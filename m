Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D52C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818F320754
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584558483;
	bh=u3Lc3dK+QtaBraoybTjK1mK8Hw1Y+E5UyK1sj4aPNyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=X0pizY7ZP5pDmw7z0Ihd+mgPX2a5jr6Mei4bh55Pkmhjhv2VUuwmC6cJDOpqQC8eZ
	 6uPemLDJ5GTNDjXc+bD/mxynYQcPFijoatBrbM+5t6RUxIswoRYVBhKKwwTriOnUGU
	 HelyTV3XpqGcQtLjqekQay1BWPj1DOrygK8z5LPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgCRTIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:08:02 -0400
Received: from foss.arm.com ([217.140.110.172]:53574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgCRTIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:08:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62B021FB;
        Wed, 18 Mar 2020 12:08:01 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D94A83F67D;
        Wed, 18 Mar 2020 12:08:00 -0700 (PDT)
Date:   Wed, 18 Mar 2020 19:07:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Martin Fuzzey <martin.fuzzey@flowbird.group>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, support.opensource@diasemi.com
Subject: Applied "regulator: da9063: fix suspend" to the regulator tree
In-Reply-To:  <1584461691-14344-1-git-send-email-martin.fuzzey@flowbird.group>
Message-Id:  <applied-1584461691-14344-1-git-send-email-martin.fuzzey@flowbird.group>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9063: fix suspend

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

From 99f75ce6661993b8ba7ae0c94e95cb25454fdf1e Mon Sep 17 00:00:00 2001
From: Martin Fuzzey <martin.fuzzey@flowbird.group>
Date: Tue, 17 Mar 2020 17:14:26 +0100
Subject: [PATCH] regulator: da9063: fix suspend

The .set_suspend_enable() and .set_suspend_disable() methods are not
supposed to immediately change the regulator state but just indicated
if the regulator should be enabled or disabled when standby mode is
entered (by a hardware signal).

However currently they set control the SEL bits in the DVC registers,
which causes the voltage to change to immediately between the "A"
(normal) and "B" (standby) values as programmed and does nothing for
the enable state...

This means that "regulator-on-in-suspend" does not work (the regulator
is switched off when the PMIC enters standby mode on the hardware
signal) and, potentially, depending on the A and B voltage
configurations the voltage could be incorrectly changed *before*
actually entering suspend.

The right bit to use for the functionality is the "CONF" bit in the
"CONT" register.
The detailed register description says "Sequencer target state"
for this bit which is not very clear but the functional description
is clearer.

>From 5.1.5 System Enable:

	De-asserting SYS_EN (changing from active to passive state)
	clears control SYSTEM_EN  which triggers a power down sequence
	into hibernate/standby mode
	...
	With the exception of supplies that have the xxxx_CONF control
	bit asserted, all regulators in power domains POWER1, POWER, and
	SYSTEM are sequentially disabled in reverse order.
	Regulators with the <x>_CONF bit set remain on but change the
	active voltage controlregisters from V<x>_A to V<x>_B
	(if V<x>_B is notalready selected).

Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
Link: https://lore.kernel.org/r/1584461691-14344-1-git-send-email-martin.fuzzey@flowbird.group
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9063-regulator.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 2aceb3b7afc2..46b7301efcd6 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -100,6 +100,7 @@ struct da9063_regulator_info {
 	.desc.vsel_mask = DA9063_V##regl_name##_MASK, \
 	.desc.linear_min_sel = DA9063_V##regl_name##_BIAS, \
 	.sleep = BFIELD(DA9063_REG_V##regl_name##_A, DA9063_LDO_SL), \
+	.suspend = BFIELD(DA9063_REG_##regl_name##_CONT, DA9063_LDO_CONF), \
 	.suspend_sleep = BFIELD(DA9063_REG_V##regl_name##_B, DA9063_LDO_SL), \
 	.suspend_vsel_reg = DA9063_REG_V##regl_name##_B
 
@@ -124,6 +125,7 @@ struct da9063_regulator_info {
 	.desc.vsel_mask = DA9063_VBUCK_MASK, \
 	.desc.linear_min_sel = DA9063_VBUCK_BIAS, \
 	.sleep = BFIELD(DA9063_REG_V##regl_name##_A, DA9063_BUCK_SL), \
+	.suspend = BFIELD(DA9063_REG_##regl_name##_CONT, DA9063_BUCK_CONF), \
 	.suspend_sleep = BFIELD(DA9063_REG_V##regl_name##_B, DA9063_BUCK_SL), \
 	.suspend_vsel_reg = DA9063_REG_V##regl_name##_B, \
 	.mode = BFIELD(DA9063_REG_##regl_name##_CFG, DA9063_BUCK_MODE_MASK)
@@ -465,42 +467,36 @@ static const struct da9063_regulator_info da9063_regulator_info[] = {
 			    da9063_buck_a_limits,
 			    DA9063_REG_BUCK_ILIM_C, DA9063_BCORE1_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BCORE1),
-		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VBCORE1_SEL),
 	},
 	{
 		DA9063_BUCK(DA9063, BCORE2, 300, 10, 1570,
 			    da9063_buck_a_limits,
 			    DA9063_REG_BUCK_ILIM_C, DA9063_BCORE2_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BCORE2),
-		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VBCORE2_SEL),
 	},
 	{
 		DA9063_BUCK(DA9063, BPRO, 530, 10, 1800,
 			    da9063_buck_a_limits,
 			    DA9063_REG_BUCK_ILIM_B, DA9063_BPRO_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BPRO),
-		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VBPRO_SEL),
 	},
 	{
 		DA9063_BUCK(DA9063, BMEM, 800, 20, 3340,
 			    da9063_buck_b_limits,
 			    DA9063_REG_BUCK_ILIM_A, DA9063_BMEM_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BMEM),
-		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VBMEM_SEL),
 	},
 	{
 		DA9063_BUCK(DA9063, BIO, 800, 20, 3340,
 			    da9063_buck_b_limits,
 			    DA9063_REG_BUCK_ILIM_A, DA9063_BIO_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BIO),
-		.suspend = BFIELD(DA9063_REG_DVC_2, DA9063_VBIO_SEL),
 	},
 	{
 		DA9063_BUCK(DA9063, BPERI, 800, 20, 3340,
 			    da9063_buck_b_limits,
 			    DA9063_REG_BUCK_ILIM_B, DA9063_BPERI_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BPERI),
-		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VBPERI_SEL),
 	},
 	{
 		DA9063_BUCK(DA9063, BCORES_MERGED, 300, 10, 1570,
@@ -508,7 +504,6 @@ static const struct da9063_regulator_info da9063_regulator_info[] = {
 			    DA9063_REG_BUCK_ILIM_C, DA9063_BCORE1_ILIM_MASK),
 		/* BCORES_MERGED uses the same register fields as BCORE1 */
 		DA9063_BUCK_COMMON_FIELDS(BCORE1),
-		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VBCORE1_SEL),
 	},
 	{
 		DA9063_BUCK(DA9063, BMEM_BIO_MERGED, 800, 20, 3340,
@@ -516,21 +511,17 @@ static const struct da9063_regulator_info da9063_regulator_info[] = {
 			    DA9063_REG_BUCK_ILIM_A, DA9063_BMEM_ILIM_MASK),
 		/* BMEM_BIO_MERGED uses the same register fields as BMEM */
 		DA9063_BUCK_COMMON_FIELDS(BMEM),
-		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VBMEM_SEL),
 	},
 	{
 		DA9063_LDO(DA9063, LDO3, 900, 20, 3440),
-		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VLDO3_SEL),
 		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO3_LIM),
 	},
 	{
 		DA9063_LDO(DA9063, LDO7, 900, 50, 3600),
-		.suspend = BFIELD(DA9063_REG_LDO7_CONT, DA9063_VLDO7_SEL),
 		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO7_LIM),
 	},
 	{
 		DA9063_LDO(DA9063, LDO8, 900, 50, 3600),
-		.suspend = BFIELD(DA9063_REG_LDO8_CONT, DA9063_VLDO8_SEL),
 		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO8_LIM),
 	},
 	{
@@ -539,36 +530,29 @@ static const struct da9063_regulator_info da9063_regulator_info[] = {
 	},
 	{
 		DA9063_LDO(DA9063, LDO11, 900, 50, 3600),
-		.suspend = BFIELD(DA9063_REG_LDO11_CONT, DA9063_VLDO11_SEL),
 		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO11_LIM),
 	},
 
 	/* The following LDOs are present only on DA9063, not on DA9063L */
 	{
 		DA9063_LDO(DA9063, LDO1, 600, 20, 1860),
-		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VLDO1_SEL),
 	},
 	{
 		DA9063_LDO(DA9063, LDO2, 600, 20, 1860),
-		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VLDO2_SEL),
 	},
 	{
 		DA9063_LDO(DA9063, LDO4, 900, 20, 3440),
-		.suspend = BFIELD(DA9063_REG_DVC_2, DA9063_VLDO4_SEL),
 		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO4_LIM),
 	},
 	{
 		DA9063_LDO(DA9063, LDO5, 900, 50, 3600),
-		.suspend = BFIELD(DA9063_REG_LDO5_CONT, DA9063_VLDO5_SEL),
 	},
 	{
 		DA9063_LDO(DA9063, LDO6, 900, 50, 3600),
-		.suspend = BFIELD(DA9063_REG_LDO6_CONT, DA9063_VLDO6_SEL),
 	},
 
 	{
 		DA9063_LDO(DA9063, LDO10, 900, 50, 3600),
-		.suspend = BFIELD(DA9063_REG_LDO10_CONT, DA9063_VLDO10_SEL),
 	},
 };
 
-- 
2.20.1

