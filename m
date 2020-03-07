Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E56FC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 13:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59EB7206D5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 13:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgCGNIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 08:08:18 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:59430 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgCGNIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 08:08:17 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 165E615F0E; Sat,  7 Mar 2020 13:08:16 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     Bin Liu <b-liu@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: musb: fix crash with highmen PIO and usbmon
Date:   Sat,  7 Mar 2020 13:07:20 +0000
Message-Id: <20200307130720.16652-1-mans@mansr.com>
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
urb->tranfer_buffer to NULL when finished.

Fixes: 8e8a55165469 ("usb: musb: host: Handle highmem in PIO mode")
Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/usb/musb/musb_host.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 1c813c37462a..b67b40de1947 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1459,8 +1459,10 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 	qh->segsize = length;
 
 	if (qh->use_sg) {
-		if (offset + length >= urb->transfer_buffer_length)
+		if (offset + length >= urb->transfer_buffer_length) {
 			qh->use_sg = false;
+			urb->transfer_buffer = NULL;
+		}
 	}
 
 	musb_ep_select(mbase, epnum);
@@ -1977,8 +1979,10 @@ void musb_host_rx(struct musb *musb, u8 epnum)
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

