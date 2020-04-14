Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E03C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FE8D206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586879913;
	bh=G6+vfMZ2pNDwT8SirtAs1S39KUkflhMBZFg2z9xV554=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=SCWY5KDOQlKpi9XMsd+uVQiHNPS1OAPmWf8vCnKnNX1lKh1DwT/FG3mekD26s6QqV
	 MBjdkWRFhBAw6oiX3X61l+GI6qz0dumOoB78yUKfQjZI3KDxZOEqWRKPWOCTez3wDJ
	 rXdH16VFKGQCVREjAc2eYknVImk0Ienx5tDmHIgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391191AbgDNP6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:58:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391161AbgDNP6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:58:04 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70237206D5;
        Tue, 14 Apr 2020 15:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586879884;
        bh=G6+vfMZ2pNDwT8SirtAs1S39KUkflhMBZFg2z9xV554=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=wuyTE/t9Y2YelbZszgUj2827prl4MB8WgvnX0fA8PFgwJ8cOakeRaXyTw3Qibde00
         QodsD14rA5vp459G/4mkLIL9W8Va9zSde/PKYuDgl8JivQtQZPysppzT4/G7to4W31
         UHj2uD/rpKVBL2MXfKIHbp7+n0HC3SEe/eLd4rFg=
Date:   Tue, 14 Apr 2020 16:58:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     broonie@kernel.org, Hulk Robot <hulkci@huawei.com>,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: ab8500: remove some defined but not used variables" to the regulator tree
In-Reply-To:  <20200410073343.39031-1-yanaijie@huawei.com>
Message-Id:  <applied-20200410073343.39031-1-yanaijie@huawei.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: ab8500: remove some defined but not used variables

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

From 29ebe87cdd57accdbe94e44a01685cb3227ad223 Mon Sep 17 00:00:00 2001
From: Jason Yan <yanaijie@huawei.com>
Date: Fri, 10 Apr 2020 15:33:43 +0800
Subject: [PATCH] regulator: ab8500: remove some defined but not used variables
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix the following gcc warning:

drivers/regulator/ab8500.c:195:27: warning: ‘ldo_vdmic_voltages’ defined
but not used [-Wunused-const-variable=]
 static const unsigned int ldo_vdmic_voltages[] = {
                           ^~~~~~~~~~~~~~~~~~
drivers/regulator/ab8500.c:169:27: warning: ‘fixed_3300000_voltage’
defined but not used [-Wunused-const-variable=]
 static const unsigned int fixed_3300000_voltage[] = {
                           ^~~~~~~~~~~~~~~~~~~~~
drivers/regulator/ab8500.c:142:27: warning: ‘ldo_sdio_voltages’ defined
but not used [-Wunused-const-variable=]
 static const unsigned int ldo_sdio_voltages[] = {
                           ^~~~~~~~~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
Link: https://lore.kernel.org/r/20200410073343.39031-1-yanaijie@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/ab8500.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index f60e1b26c2d2..716ca5bb178e 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -139,17 +139,6 @@ static const unsigned int ldo_vintcore_voltages[] = {
 	1350000,
 };
 
-static const unsigned int ldo_sdio_voltages[] = {
-	1160000,
-	1050000,
-	1100000,
-	1500000,
-	1800000,
-	2200000,
-	2910000,
-	3050000,
-};
-
 static const unsigned int fixed_1200000_voltage[] = {
 	1200000,
 };
@@ -166,10 +155,6 @@ static const unsigned int fixed_2050000_voltage[] = {
 	2050000,
 };
 
-static const unsigned int fixed_3300000_voltage[] = {
-	3300000,
-};
-
 static const unsigned int ldo_vana_voltages[] = {
 	1050000,
 	1075000,
@@ -192,13 +177,6 @@ static const unsigned int ldo_vaudio_voltages[] = {
 	2600000,	/* Duplicated in Vaudio and IsoUicc Control register. */
 };
 
-static const unsigned int ldo_vdmic_voltages[] = {
-	1800000,
-	1900000,
-	2000000,
-	2850000,
-};
-
 static DEFINE_MUTEX(shared_mode_mutex);
 static struct ab8500_shared_mode ldo_anamic1_shared;
 static struct ab8500_shared_mode ldo_anamic2_shared;
-- 
2.20.1

