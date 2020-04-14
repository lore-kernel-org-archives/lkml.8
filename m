Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4142AC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 145802076B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586879893;
	bh=Dmt9XIqHXIwK7FCqnKWFuDVuSaHFjjNXu0NxDDDyjl4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=lZV6t2H0c5Ooeq8A6rlIehjW/7SsBq/Wth4gpdJNtdUXeIU1rrADY+uVi0d4LFx9z
	 6F3RDgsaUwHEEOQ/FtYDjPDkHo193VmYl34RySjlICCPGYhJaYRUCI5czW3auijexa
	 IpY9Apgifsln/5NvNGAuyjAv8ANZPSwDlREmcHSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391169AbgDNP6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:58:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391153AbgDNP57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:57:59 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBDE220732;
        Tue, 14 Apr 2020 15:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586879878;
        bh=Dmt9XIqHXIwK7FCqnKWFuDVuSaHFjjNXu0NxDDDyjl4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vap1OGZI5eeW4rnAhQtfXX5BGbgz10G+Q8vt91Sk7QgEY0j9I8RK5CKR+yqJG08WD
         Dr5AOVEMNRFJj/HP55Gg4ngvKJR/eAh0pQ4TI6bioLYcl0ZIN8ojP6F7Gs21nvb7yK
         ECV3+6ht6qAfDnalMgELy7Ivp8Iy0zmHh3KyPgH0=
Date:   Tue, 14 Apr 2020 16:57:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: tps80031: remove redundant assignment to variables ret and val" to the regulator tree
In-Reply-To:  <20200410133406.24458-1-colin.king@canonical.com>
Message-Id:  <applied-20200410133406.24458-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: tps80031: remove redundant assignment to variables ret and val

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

From 2ea8db7200d40f89ebfb97fc512ced5f792e0e1c Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 10 Apr 2020 14:34:06 +0100
Subject: [PATCH] regulator: tps80031: remove redundant assignment to variables
 ret and val

The variables ret and val are being initialized with values that are
never read and are being updated later with a new value.  The
initializations are redundant and can be removed.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Addresses-Coverity: ("Unused value")
Link: https://lore.kernel.org/r/20200410133406.24458-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps80031-regulator.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/tps80031-regulator.c b/drivers/regulator/tps80031-regulator.c
index 85a6a8ca8c1b..a29e65230132 100644
--- a/drivers/regulator/tps80031-regulator.c
+++ b/drivers/regulator/tps80031-regulator.c
@@ -271,7 +271,7 @@ static int tps80031_vbus_is_enabled(struct regulator_dev *rdev)
 {
 	struct tps80031_regulator *ri = rdev_get_drvdata(rdev);
 	struct device *parent = to_tps80031_dev(rdev);
-	int ret = -EIO;
+	int ret;
 	uint8_t ctrl1 = 0;
 	uint8_t ctrl3 = 0;
 
@@ -322,7 +322,7 @@ static int tps80031_vbus_disable(struct regulator_dev *rdev)
 {
 	struct tps80031_regulator *ri = rdev_get_drvdata(rdev);
 	struct device *parent = to_tps80031_dev(rdev);
-	int ret = 0;
+	int ret;
 
 	if (ri->config_flags & TPS80031_VBUS_DISCHRG_EN_PDN) {
 		ret = tps80031_write(parent, TPS80031_SLAVE_ID2,
@@ -530,7 +530,8 @@ static int tps80031_regulator_config(struct device *parent,
 	case TPS80031_REGULATOR_LDOUSB:
 		if (ri->config_flags & (TPS80031_USBLDO_INPUT_VSYS |
 			TPS80031_USBLDO_INPUT_PMID)) {
-			unsigned val = 0;
+			unsigned val;
+
 			if (ri->config_flags & TPS80031_USBLDO_INPUT_VSYS)
 				val = MISC2_LDOUSB_IN_VSYS;
 			else
-- 
2.20.1

