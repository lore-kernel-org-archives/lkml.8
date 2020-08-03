Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55591C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 339E0206D4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596458841;
	bh=wU/TN71rTvgaJrmEbzOri9vKXRrQfz4CqDUk8J6+y90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bQYsBDQoahBk4kTIcsn3pnL18AbneUHcTpPXNWa8A1r+1+BcrZ9EOjrldPvR0PSfS
	 JWv7HpxEdFeIUeT6Qpq7sLKI2ZNxvxcMSXX+us29gQhDUBlHDdeb+RolQ9mhiYCx/c
	 vnmH1oNe3zy1zd+v0x8jIRiDZVhOWXxDNAMfHjBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgHCMZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:25:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728276AbgHCMZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:25:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A01E7204EC;
        Mon,  3 Aug 2020 12:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457550;
        bh=wU/TN71rTvgaJrmEbzOri9vKXRrQfz4CqDUk8J6+y90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aBsrzByo0AXKIMk2QMyUiSWERyJu/OYEHN7UvfQMWMKlr05g+nKJIGKdGGbMGfIhq
         XNaWj2lvaZpmtj7OpUfYKuYHwqw0p5rJ4+zCHDijeSHd1eTI6Z3NDTtyIzIe1oHBRd
         3jk2bHdD4yPH9HEA3l9r9o2l4BfNwcbFzwZP79ro=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Raviteja Narayanam <raviteja.narayanam@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 109/120] i2c: cadence: Clear HOLD bit at correct time in Rx path
Date:   Mon,  3 Aug 2020 14:19:27 +0200
Message-Id: <20200803121908.204499811@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121902.860751811@linuxfoundation.org>
References: <20200803121902.860751811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raviteja Narayanam <raviteja.narayanam@xilinx.com>

[ Upstream commit 12d4d9ec5eeecd712c73772e422b6d082e66b046 ]

There are few issues on Zynq SOC observed in the stress tests causing
timeout errors. Even though all the data is received, timeout error
is thrown. This is due to an IP bug in which the COMP bit in ISR is
not set at end of transfer and completion interrupt is not generated.

This bug is seen on Zynq platforms when the following condition occurs:
Master read & HOLD bit set & Transfer size register reaches '0'.

One workaround is to clear the HOLD bit before the transfer size
register reaches '0'. The current implementation checks for this at
the start of the loop and also only for less than FIFO DEPTH case
(ignoring the equal to case).

So clear the HOLD bit when the data yet to receive is less than or
equal to the FIFO DEPTH. This avoids the IP bug condition.

Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-cadence.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 97a0bd6ea31f1..1efdabb5adca0 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -230,20 +230,21 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 		/* Read data if receive data valid is set */
 		while (cdns_i2c_readreg(CDNS_I2C_SR_OFFSET) &
 		       CDNS_I2C_SR_RXDV) {
-			/*
-			 * Clear hold bit that was set for FIFO control if
-			 * RX data left is less than FIFO depth, unless
-			 * repeated start is selected.
-			 */
-			if ((id->recv_count < CDNS_I2C_FIFO_DEPTH) &&
-			    !id->bus_hold_flag)
-				cdns_i2c_clear_bus_hold(id);
-
 			if (id->recv_count > 0) {
 				*(id->p_recv_buf)++ =
 					cdns_i2c_readreg(CDNS_I2C_DATA_OFFSET);
 				id->recv_count--;
 				id->curr_recv_count--;
+
+				/*
+				 * Clear hold bit that was set for FIFO control
+				 * if RX data left is less than or equal to
+				 * FIFO DEPTH unless repeated start is selected
+				 */
+				if (id->recv_count <= CDNS_I2C_FIFO_DEPTH &&
+				    !id->bus_hold_flag)
+					cdns_i2c_clear_bus_hold(id);
+
 			} else {
 				dev_err(id->adap.dev.parent,
 					"xfer_size reg rollover. xfer aborted!\n");
-- 
2.25.1



