Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FA7C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F1D2067C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgCIP1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:27:01 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:54684 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgCIP1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:27:01 -0400
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 0741B15F11; Mon,  9 Mar 2020 15:26:59 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     Bin Liu <b-liu@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: musb: fix crash with highmen PIO and usbmon
Date:   Mon,  9 Mar 2020 15:26:53 +0000
Message-Id: <20200309152653.29161-1-mans@mansr.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When handling a PIO bulk transfer with highmem buffer, a temporary
mapping is assigned to urb->transfer_buffer.  After the transfer is
complete, an invalid address is left behind in this pointer.  This is
not ordinarily a problem since nothing touches that buffer before the
urb is released.  However, when usbmon is active, usbmon_urb_complete()
calls (indirectly) mon_bin_get_data() which does access the transfer
buffer if it is set.  To prevent an invalid memory access here, reset
urb->tranfer_buffer to NULL when finished (musb_host_rx()), or do not
set it at all (musb_host_tx()).

Fixes: 8e8a55165469 ("usb: musb: host: Handle highmem in PIO mode")
Signed-off-by: Mans Rullgard <mans@mansr.com>
---
Changed in v2:
- Do not set urb->transfer_buffer in musb_host_tx()
---
 drivers/usb/musb/musb_host.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 1c813c37462a..8736f4251a22 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1436,10 +1436,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 	 * We need to map sg if the transfer_buffer is
 	 * NULL.
 	 */
-	if (!urb->transfer_buffer)
-		qh->use_sg = true;
-
-	if (qh->use_sg) {
+	if (!urb->transfer_buffer) {
 		/* sg_miter_start is already done in musb_ep_program */
 		if (!sg_miter_next(&qh->sg_miter)) {
 			dev_err(musb->controller, "error: sg list empty\n");
@@ -1447,9 +1444,8 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 			status = -EINVAL;
 			goto done;
 		}
-		urb->transfer_buffer = qh->sg_miter.addr;
 		length = min_t(u32, length, qh->sg_miter.length);
-		musb_write_fifo(hw_ep, length, urb->transfer_buffer);
+		musb_write_fifo(hw_ep, length, qh->sg_miter.addr);
 		qh->sg_miter.consumed = length;
 		sg_miter_stop(&qh->sg_miter);
 	} else {
@@ -1458,11 +1454,6 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 
 	qh->segsize = length;
 
-	if (qh->use_sg) {
-		if (offset + length >= urb->transfer_buffer_length)
-			qh->use_sg = false;
-	}
-
 	musb_ep_select(mbase, epnum);
 	musb_writew(epio, MUSB_TXCSR,
 			MUSB_TXCSR_H_WZC_BITS | MUSB_TXCSR_TXPKTRDY);
@@ -1977,8 +1968,10 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 	urb->actual_length += xfer_len;
 	qh->offset += xfer_len;
 	if (done) {
-		if (qh->use_sg)
+		if (qh->use_sg) {
 			qh->use_sg = false;
+			urb->transfer_buffer = NULL;
+		}
 
 		if (urb->status == -EINPROGRESS)
 			urb->status = status;
-- 
2.25.1

