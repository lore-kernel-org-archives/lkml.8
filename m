Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A44C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C2F20870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583428868;
	bh=Myet+OUMfpjkM+ThPePJlaV0an6jHRhSsTs8Gakel20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OCKB8yOdlq6xsRnCU8crCp5sbCCFCQZVB+2fnpsdXIoOzFTarDRCHMxt0r+cvMQmT
	 REL7Xk6or4v2lB99b3gbGotaxnqhJ6qlHC19wEV2xvXcP9sWDJ4IZdOOALyP0UkTwD
	 Tm7SwigavzTAEf6rHDcMuImQEQeOevyfcWZor6oU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCEROm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:14:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727689AbgCEROa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:14:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85E5E207FD;
        Thu,  5 Mar 2020 17:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583428469;
        bh=Myet+OUMfpjkM+ThPePJlaV0an6jHRhSsTs8Gakel20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l82/aUxt1PgitloEJglrW0wdFh2l5SbDSQ+oUR0UXOd/HJdDceKj0uzbV1Tm7WYoW
         7SYsUgelYgxCxx9MzaDyR1OonpWXgjyWST7RtDKsV5DYY2ez7mRkZS2j8fzn2Eo98d
         pgSj5DwNmRsDhUhzadUrH+v1B1qtCBe7FeFAqG+k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 07/58] i2c: altera: Fix potential integer overflow
Date:   Thu,  5 Mar 2020 12:13:28 -0500
Message-Id: <20200305171420.29595-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305171420.29595-1-sashal@kernel.org>
References: <20200305171420.29595-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

[ Upstream commit 54498e8070e19e74498a72c7331348143e7e1f8c ]

Factor out 100 from the equation and do 32-bit arithmetic (3 * clk_mhz / 10)
instead of 64-bit.

Notice that clk_mhz is MHz, so the multiplication will never wrap 32 bits
and there is no need for div_u64().

Addresses-Coverity: 1458369 ("Unintentional integer overflow")
Fixes: 0560ad576268 ("i2c: altera: Add Altera I2C Controller driver")
Suggested-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-altera.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-altera.c b/drivers/i2c/busses/i2c-altera.c
index 5255d3755411b..1de23b4f3809c 100644
--- a/drivers/i2c/busses/i2c-altera.c
+++ b/drivers/i2c/busses/i2c-altera.c
@@ -171,7 +171,7 @@ static void altr_i2c_init(struct altr_i2c_dev *idev)
 	/* SCL Low Time */
 	writel(t_low, idev->base + ALTR_I2C_SCL_LOW);
 	/* SDA Hold Time, 300ns */
-	writel(div_u64(300 * clk_mhz, 1000), idev->base + ALTR_I2C_SDA_HOLD);
+	writel(3 * clk_mhz / 10, idev->base + ALTR_I2C_SDA_HOLD);
 
 	/* Mask all master interrupt bits */
 	altr_i2c_int_enable(idev, ALTR_I2C_ALL_IRQ, false);
-- 
2.20.1

