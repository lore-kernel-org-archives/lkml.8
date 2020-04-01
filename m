Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C383C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C32216FD
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758552;
	bh=eaZtXvrvNclIweD2DXp8T7YbxLOfq85xDuyOa6hnfmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t13sGZu8O3tfnzkA3dFUUGHS2CJfJFJHOhb12h3NFXxy+IVC5napMs6FDq+UjuAFH
	 FWTWVY3RseTDs2HO9jcktuE0ZJ5x54YdMs2zU6eHPNJn+CTMG9W8SiAIN0A+NS8j/I
	 Tx5jq3buxn7V98fZAwmo1iwSuQogQRRWU07QpJBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387788AbgDAQ3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:29:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387558AbgDAQ3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:29:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D662420BED;
        Wed,  1 Apr 2020 16:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758543;
        bh=eaZtXvrvNclIweD2DXp8T7YbxLOfq85xDuyOa6hnfmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u44+FdVyDhebifXLuHUunUPxkLw7z+NCZXE9YX5dK5AmCsqqUBjuEI25YdOIPMENu
         ANg+/LIA/zMUhXbuNyDihPRn+76QOZjjLoNWqpYTULj/aXNQO3ayy/TJMlq53Vjlf3
         rTAAxrsoDu9+P3+CGbwONfl2FUUOXFjZ45JA5mis=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mans Rullgard <mans@mansr.com>,
        Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.19 084/116] usb: musb: fix crash with highmen PIO and usbmon
Date:   Wed,  1 Apr 2020 18:17:40 +0200
Message-Id: <20200401161553.239473470@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161542.669484650@linuxfoundation.org>
References: <20200401161542.669484650@linuxfoundation.org>
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


