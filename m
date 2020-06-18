Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B27FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ACEE22206
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445192;
	bh=KKm3hGt7yskpwSdh59W0SWjnZ+/KPXUQvAQqdtmF8lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RdiVo4fgeVbLFDcZVP7YVIteDYqC0thgdfKaE/zU749D6VgcErO0ttm7JgKLddpkc
	 r6/zxB6OZKdMGVItdSHBEliUTs7496JUEctg0Rfk/IbO8CNqn0uObtu//vJLEvlG0i
	 Y/sYlUrgb9nVKofaRv7fDfNb77cCmfWAq3jHKpP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732871AbgFRBxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731653AbgFRB0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:26:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65DE2221EE;
        Thu, 18 Jun 2020 01:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443582;
        bh=KKm3hGt7yskpwSdh59W0SWjnZ+/KPXUQvAQqdtmF8lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y/BCPZk/evngm6y7ryPxg/tNGqIJTX0WQWVZkE4nJCTlPuneM2Xw6PsvfgX9a12Yi
         T1mEqx0hF3f5cdtdhVRkLJulloW8xp+sG5vSRRcsbS/CVwFKKOAqQy2Wx7WGCodNvI
         bw36w6j1mt9UxAM7lTclSW1BcKMu9+HNW6Gf5FNc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 017/108] i2c: pxa: clear all master action bits in i2c_pxa_stop_message()
Date:   Wed, 17 Jun 2020 21:24:29 -0400
Message-Id: <20200618012600.608744-17-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012600.608744-1-sashal@kernel.org>
References: <20200618012600.608744-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit e81c979f4e071d516aa27cf5a0c3939da00dc1ca ]

If we timeout during a message transfer, the control register may
contain bits that cause an action to be set. Read-modify-writing the
register leaving these bits set may trigger the hardware to attempt
one of these actions unintentionally.

Always clear these bits when cleaning up after a message or after
a timeout.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-pxa.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 600d264e080c..ecc84aea5131 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -709,11 +709,9 @@ static inline void i2c_pxa_stop_message(struct pxa_i2c *i2c)
 {
 	u32 icr;
 
-	/*
-	 * Clear the STOP and ACK flags
-	 */
+	/* Clear the START, STOP, ACK, TB and MA flags */
 	icr = readl(_ICR(i2c));
-	icr &= ~(ICR_STOP | ICR_ACKNAK);
+	icr &= ~(ICR_START | ICR_STOP | ICR_ACKNAK | ICR_TB | ICR_MA);
 	writel(icr, _ICR(i2c));
 }
 
-- 
2.25.1

