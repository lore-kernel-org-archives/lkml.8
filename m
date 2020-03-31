Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAF3C2D0F3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E4320658
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646365;
	bh=eaZtXvrvNclIweD2DXp8T7YbxLOfq85xDuyOa6hnfmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F9XpL/XTDGQLQfwSuyNpCj6ruGDPtuYbTE/Zx1zE7hzkC0RtRaTWLHe7wey0MCKZh
	 oRoy/YjB2sNsPGgyk92oBOnJBcv8QTcBFnZQ0+GMC7supzyply58hHH6Uo3NrPtKbO
	 jZvXCKqVIIzeyWK4QCk0Gwa0E1deT9NxETIB03/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbgCaJTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:19:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732223AbgCaJTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:19:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7D2220675;
        Tue, 31 Mar 2020 09:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585646360;
        bh=eaZtXvrvNclIweD2DXp8T7YbxLOfq85xDuyOa6hnfmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=twSrNhmBsKJnbHKSid9i5/GSuVTKfVVS6RvGx27eg0nFZ3eq5Fk4EWF12iMU1w6rW
         L5Bm/i6hVNUaXv/4anBBEy8vhAg05Gox9nbgPdhV4a17opJ/abdMpF6ljZmfNhNkHU
         bzBLIsKJORxJjZLvvd+VN2Ir0f9o8nac3EEn2bc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mans Rullgard <mans@mansr.com>,
        Bin Liu <b-liu@ti.com>
Subject: [PATCH 5.4 142/155] usb: musb: fix crash with highmen PIO and usbmon
Date:   Tue, 31 Mar 2020 10:59:42 +0200
Message-Id: <20200331085434.085600075@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mans Rullgard <mans@mansr.com>

commit 52974d94a206ce428d9d9b6eaa208238024be82a upstream.

When handling a PIO bulk transfer with highmem buffer, a temporary
mapping is assigned to urb->transfer_buffer.  After the transfer is
complete, an invalid address is left behind in this pointer.  This is
not ordinarily a problem since nothing touches that buffer before the
urb is released.  However, when usbmon is active, usbmon_urb_complete()
calls (indirectly) mon_bin_get_data() which does access the transfer
buffer if it is set.  To prevent an invalid memory access here, reset
urb->transfer_buffer to NULL when finished (musb_host_rx()), or do not
set it at all (musb_host_tx()).

Fixes: 8e8a55165469 ("usb: musb: host: Handle highmem in PIO mode")
Signed-off-by: Mans Rullgard <mans@mansr.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bin Liu <b-liu@ti.com>
Link: https://lore.kernel.org/r/20200316211136.2274-8-b-liu@ti.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/musb_host.c |   17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1462,10 +1462,7 @@ done:
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
@@ -1473,9 +1470,8 @@ done:
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
@@ -1484,11 +1480,6 @@ done:
 
 	qh->segsize = length;
 
-	if (qh->use_sg) {
-		if (offset + length >= urb->transfer_buffer_length)
-			qh->use_sg = false;
-	}
-
 	musb_ep_select(mbase, epnum);
 	musb_writew(epio, MUSB_TXCSR,
 			MUSB_TXCSR_H_WZC_BITS | MUSB_TXCSR_TXPKTRDY);
@@ -2003,8 +1994,10 @@ finish:
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


