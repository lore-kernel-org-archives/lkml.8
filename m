Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDF8C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ABAE2173E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595892327;
	bh=e45O64EGQzQMOrrWcSMj0I5jzsqG5i/oLqrPSK2fkXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X39PmYHS515rVdOimuZ54AxTEiKwm/mRpgrXKGrv6wwLaBj9lec0G7tgvdiEwr1Gp
	 qA5VybgKYCcmuNhATSxTYaDZ1WLAfgj6ZgamvtXQ7MtFOR2EBQQVwrY3cOh1TkqP6m
	 98SG53DdY22i+vXD60rWmSfBRE6fSeM+r3ardtCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgG0XZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgG0XZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:25:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F80220A8B;
        Mon, 27 Jul 2020 23:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595892323;
        bh=e45O64EGQzQMOrrWcSMj0I5jzsqG5i/oLqrPSK2fkXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IxrandHv3ItSHIrlu3DhNgHOMDNueK4c8HSja/OCVR0F9vS6AI9zE80DnNAdt0fUj
         5QMZoO74O73jSONirkYmC5stzdMQJh3JCyw9nobyo2MQqc2y7G/Fs9h3HshkWQCgoG
         n1a5KGaY9AALL9P189Zop9lPFx7R+UkF8SXJBjW0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Raviteja Narayanam <raviteja.narayanam@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 6/7] Revert "i2c: cadence: Fix the hold bit setting"
Date:   Mon, 27 Jul 2020 19:25:13 -0400
Message-Id: <20200727232514.718265-6-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727232514.718265-1-sashal@kernel.org>
References: <20200727232514.718265-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raviteja Narayanam <raviteja.narayanam@xilinx.com>

[ Upstream commit 0db9254d6b896b587759e2c844c277fb1a6da5b9 ]

This reverts commit d358def706880defa4c9e87381c5bf086a97d5f9.

There are two issues with "i2c: cadence: Fix the hold bit setting" commit.

1. In case of combined message request from user space, when the HOLD
bit is cleared in cdns_i2c_mrecv function, a STOP condition is sent
on the bus even before the last message is started. This is because when
the HOLD bit is cleared, the FIFOS are empty and there is no pending
transfer. The STOP condition should occur only after the last message
is completed.

2. The code added by the commit is redundant. Driver is handling the
setting/clearing of HOLD bit in right way before the commit.

The setting of HOLD bit based on 'bus_hold_flag' is taken care in
cdns_i2c_master_xfer function even before cdns_i2c_msend/cdns_i2c_recv
functions.

The clearing of HOLD bit is taken care at the end of cdns_i2c_msend and
cdns_i2c_recv functions based on bus_hold_flag and byte count.
Since clearing of HOLD bit is done after the slave address is written to
the register (writing to address register triggers the message transfer),
it is ensured that STOP condition occurs at the right time after
completion of the pending transfer (last message).

Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-cadence.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 59c08d5b75d6a..45d6771fac8ce 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -382,10 +382,8 @@ static void cdns_i2c_mrecv(struct cdns_i2c *id)
 	 * Check for the message size against FIFO depth and set the
 	 * 'hold bus' bit if it is greater than FIFO depth.
 	 */
-	if ((id->recv_count > CDNS_I2C_FIFO_DEPTH)  || id->bus_hold_flag)
+	if (id->recv_count > CDNS_I2C_FIFO_DEPTH)
 		ctrl_reg |= CDNS_I2C_CR_HOLD;
-	else
-		ctrl_reg = ctrl_reg & ~CDNS_I2C_CR_HOLD;
 
 	cdns_i2c_writereg(ctrl_reg, CDNS_I2C_CR_OFFSET);
 
@@ -442,11 +440,8 @@ static void cdns_i2c_msend(struct cdns_i2c *id)
 	 * Check for the message size against FIFO depth and set the
 	 * 'hold bus' bit if it is greater than FIFO depth.
 	 */
-	if ((id->send_count > CDNS_I2C_FIFO_DEPTH) || id->bus_hold_flag)
+	if (id->send_count > CDNS_I2C_FIFO_DEPTH)
 		ctrl_reg |= CDNS_I2C_CR_HOLD;
-	else
-		ctrl_reg = ctrl_reg & ~CDNS_I2C_CR_HOLD;
-
 	cdns_i2c_writereg(ctrl_reg, CDNS_I2C_CR_OFFSET);
 
 	/* Clear the interrupts in interrupt status register. */
-- 
2.25.1

