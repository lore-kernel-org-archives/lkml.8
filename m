Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828DEC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 13:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56ABC21739
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 13:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583330263;
	bh=TElYCsPC/KjwS0PoNhsiB2JHg6pH7mVlsUEWPAPpKe0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=V19l2Yx4nNPKxqW+oMt5gtHIROsadJdRcd2vuPn9XsocMBQQq5wryRwWTKPQOlqFY
	 GB8xiEzcmNnS0fRJ07/oSjVbXeo81fYOuaQB9d2TnLpqZzpViacR2kuVktGrpGu6po
	 SSSsdo6PC7g8LWyQ0Au+DtqrEWw1cB++TePHCl2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387938AbgCDN5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 08:57:42 -0500
Received: from foss.arm.com ([217.140.110.172]:34506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728432AbgCDN5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 08:57:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FFEA31B;
        Wed,  4 Mar 2020 05:57:41 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B61B03F6CF;
        Wed,  4 Mar 2020 05:57:40 -0800 (PST)
Date:   Wed, 04 Mar 2020 13:57:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     alexandre.torgue@st.com, broonie@kernel.org,
        fabrice.gasnier@st.com, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, mcoquelin.stm32@gmail.com
Subject: Applied "regulator: stm32-vrefbuf: fix a possible overshoot when re-enabling" to the regulator tree
In-Reply-To:  <1583312132-20932-1-git-send-email-fabrice.gasnier@st.com>
Message-Id:  <applied-1583312132-20932-1-git-send-email-fabrice.gasnier@st.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: stm32-vrefbuf: fix a possible overshoot when re-enabling

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 02fbabd5f4ed182d2c616e49309f5a3efd9ec671 Mon Sep 17 00:00:00 2001
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Date: Wed, 4 Mar 2020 09:55:32 +0100
Subject: [PATCH] regulator: stm32-vrefbuf: fix a possible overshoot when
 re-enabling

There maybe an overshoot, when disabling, then re-enabling vrefbuf
too quickly. VREFBUF is used by ADC/DAC on some boards. When re-enabling
too quickly, an overshoot on the reference voltage make the conversions
inaccurate for a short period of time.
- Don't put the VREFBUF in HiZ when disabling, to force an active
discharge.
- Enforce a 1ms OFF/ON delay

Fixes: 0cdbf481e927 ("regulator: Add support for stm32-vrefbuf")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-Id: <1583312132-20932-1-git-send-email-fabrice.gasnier@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/stm32-vrefbuf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/stm32-vrefbuf.c b/drivers/regulator/stm32-vrefbuf.c
index bdfaf7edb75a..992bc18101ef 100644
--- a/drivers/regulator/stm32-vrefbuf.c
+++ b/drivers/regulator/stm32-vrefbuf.c
@@ -88,7 +88,7 @@ static int stm32_vrefbuf_disable(struct regulator_dev *rdev)
 	}
 
 	val = readl_relaxed(priv->base + STM32_VREFBUF_CSR);
-	val = (val & ~STM32_ENVR) | STM32_HIZ;
+	val &= ~STM32_ENVR;
 	writel_relaxed(val, priv->base + STM32_VREFBUF_CSR);
 
 	pm_runtime_mark_last_busy(priv->dev);
@@ -175,6 +175,7 @@ static const struct regulator_desc stm32_vrefbuf_regu = {
 	.volt_table = stm32_vrefbuf_voltages,
 	.n_voltages = ARRAY_SIZE(stm32_vrefbuf_voltages),
 	.ops = &stm32_vrefbuf_volt_ops,
+	.off_on_delay = 1000,
 	.type = REGULATOR_VOLTAGE,
 	.owner = THIS_MODULE,
 };
-- 
2.20.1

