Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E0FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDC424687
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221853;
	bh=sY7XWHTJaL6C2cC0Ct4juQRGtasPLxjNLYSOZPeOZ2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eU/kP6s3VwKbhG8Ji6wBcpwezimqNLz2mQbS4Be+cAUdsniBROvu9e3Lb1cn+CHIj
	 8FHqqijo4kAjy7Reyrb0eU6OXYpKt8cgvkky+QT6KNzk7ZI8OjLFCrLVxqgX3GQzUU
	 pE0YVxV2Eh+ke9tZ1adpCkXP/cl2OAC3IViXejNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387729AbgA1Oaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:30:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387539AbgA1O2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:28:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13A312468A;
        Tue, 28 Jan 2020 14:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221720;
        bh=sY7XWHTJaL6C2cC0Ct4juQRGtasPLxjNLYSOZPeOZ2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2a933cKZ7lhix7dYKQnZ22Uzz+QMqUnyvjnfBNV7Zu2DX2RkgsKME+pE1RD7cxI3L
         oJZLmeInBw8F7cVl50TR283WbAnY0QbMcxnzhLskkcZgv7ADigs1vj7/6qdOgCUif6
         dYcSpObZyHwlljQ5X2ONPCOM2KpNc4awsGKGhRxY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stan Johnson <userm57@yahoo.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 55/92] net/sonic: Prevent tx watchdog timeout
Date:   Tue, 28 Jan 2020 15:08:23 +0100
Message-Id: <20200128135816.271158392@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135809.344954797@linuxfoundation.org>
References: <20200128135809.344954797@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>

commit 686f85d71d095f1d26b807e23b0f0bfd22042c45 upstream.

Section 5.5.3.2 of the datasheet says,

    If FIFO Underrun, Byte Count Mismatch, Excessive Collision, or
    Excessive Deferral (if enabled) errors occur, transmission ceases.

In this situation, the chip asserts a TXER interrupt rather than TXDN.
But the handler for the TXDN is the only way that the transmit queue
gets restarted. Hence, an aborted transmission can result in a watchdog
timeout.

This problem can be reproduced on congested link, as that can result in
excessive transmitter collisions. Another way to reproduce this is with
a FIFO Underrun, which may be caused by DMA latency.

In event of a TXER interrupt, prevent a watchdog timeout by restarting
transmission.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/natsemi/sonic.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/natsemi/sonic.c
+++ b/drivers/net/ethernet/natsemi/sonic.c
@@ -414,10 +414,19 @@ static irqreturn_t sonic_interrupt(int i
 			lp->stats.rx_missed_errors += 65536;
 
 		/* transmit error */
-		if (status & SONIC_INT_TXER)
-			if (SONIC_READ(SONIC_TCR) & SONIC_TCR_FU)
-				netif_dbg(lp, tx_err, dev, "%s: tx fifo underrun\n",
-					  __func__);
+		if (status & SONIC_INT_TXER) {
+			u16 tcr = SONIC_READ(SONIC_TCR);
+
+			netif_dbg(lp, tx_err, dev, "%s: TXER intr, TCR %04x\n",
+				  __func__, tcr);
+
+			if (tcr & (SONIC_TCR_EXD | SONIC_TCR_EXC |
+				   SONIC_TCR_FU | SONIC_TCR_BCM)) {
+				/* Aborted transmission. Try again. */
+				netif_stop_queue(dev);
+				SONIC_WRITE(SONIC_CMD, SONIC_CR_TXP);
+			}
+		}
 
 		/* bus retry */
 		if (status & SONIC_INT_BR) {


