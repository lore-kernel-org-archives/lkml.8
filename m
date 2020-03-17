Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15808C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44D320714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b="GPs62GCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgCQQOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:14:55 -0400
Received: from mail-ed1-f99.google.com ([209.85.208.99]:35825 "EHLO
        mail-ed1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgCQQOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:14:55 -0400
Received: by mail-ed1-f99.google.com with SMTP id a20so27312159edj.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 09:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bqq7Nz7Ul6ndWRSNt3PwuRDa2qbb2WebPjjAC6A6KEw=;
        b=GPs62GCUqmQCXDCD+io6u6XlYmbRK0nBOX9okJjHVeICHfyoP5cXLKyo4VNnxQEEn9
         MzblMRmXqDdMR0/89UtcRLfuHhDgvwB0/GfUJShfTG4f/0XijWFHrzQhIJBvjsXuym2a
         PKQ2vRb0x2hYGO9fc6ohPeHmk1878ZOoS1EvfEQWgj+EcDy8jyELvF6pv3DojUJdrybb
         qUvUxCbF499ro6c3fYm/kOQnFdAWNM3fRLK65ELNPVU4wm0Dh/XeaMpghdWdsW/A/Uf/
         PsnIUerlzmy1FpWcQXovTzhFyePxmvF4LWBPt9vS88tLnPrF+P55AwhhsXqJqr+Yzl0e
         lSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bqq7Nz7Ul6ndWRSNt3PwuRDa2qbb2WebPjjAC6A6KEw=;
        b=iKai2lNWq0EsQDp4Q2ON8fXdoQew3+p3UU+kCBx2vdKtSGB1gCsi9TJfOsq1z4Hxmf
         TZAyzafYDbCq9BWggXiaUi11LjdC0DhStPPP6Sbbi1WCEGCgSf8/KZpehKm7kXWtfTnN
         WCTtxu4h3Adb+6Xb7D9+fNlLvW2pDiyBszdvKZHA5JaS0iH2FiXeDPNXiuM5j6CADK0A
         LGJIxYp8uppKRm9VniaRa2WCGcRBPGshI46h1hBr/UOy3uoxRQt2e0IhzDPECIxIgO/Q
         9Tm2PwKy0IR/9JtTnZnnwjHhw4AMIE8VsgvaKMVEDBK4gY6PRb+1aBENxT0C0Cj98ffi
         cFBw==
X-Gm-Message-State: ANhLgQ2Dxjc57StHfqKZNsy3nN1peEh28A+PY9BznuS6cW/LOJkPSUd1
        NhqIBEuzsm+yU+CPc47wKseXRvL6ZSVeJhFlyi/D2M9BgkEe
X-Google-Smtp-Source: ADFU+vsehk2QAhVNpztC5cXNTT8VOLRVBq16IM24S+KvgZQkVDNq1IMHsrh/kX/ixd6T5feHNqyXCt955YON
X-Received: by 2002:a17:906:689:: with SMTP id u9mr4970947ejb.78.1584461692696;
        Tue, 17 Mar 2020 09:14:52 -0700 (PDT)
Received: from mail.besancon.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id u11sm26469edq.19.2020.03.17.09.14.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 17 Mar 2020 09:14:52 -0700 (PDT)
X-Relaying-Domain: flowbird.group
Received: from [172.16.13.134] (port=56720 helo=PC12445-BES.dynamic.besancon.parkeon.com)
        by mail.besancon.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1jEErk-0008GF-3s; Tue, 17 Mar 2020 17:14:52 +0100
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
To:     support.opensource@diasemi.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: da9063: fix suspend
Date:   Tue, 17 Mar 2020 17:14:26 +0100
Message-Id: <1584461691-14344-1-git-send-email-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

From 5.1.5 System Enable:

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
---
 drivers/regulator/da9063-regulator.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 2aceb3b..46b7301 100644
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
@@ -465,42 +467,36 @@ static int da9063_ldo_set_suspend_mode(struct regulator_dev *rdev, unsigned mode
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
@@ -508,7 +504,6 @@ static int da9063_ldo_set_suspend_mode(struct regulator_dev *rdev, unsigned mode
 			    DA9063_REG_BUCK_ILIM_C, DA9063_BCORE1_ILIM_MASK),
 		/* BCORES_MERGED uses the same register fields as BCORE1 */
 		DA9063_BUCK_COMMON_FIELDS(BCORE1),
-		.suspend = BFIELD(DA9063_REG_DVC_1, DA9063_VBCORE1_SEL),
 	},
 	{
 		DA9063_BUCK(DA9063, BMEM_BIO_MERGED, 800, 20, 3340,
@@ -516,21 +511,17 @@ static int da9063_ldo_set_suspend_mode(struct regulator_dev *rdev, unsigned mode
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
@@ -539,36 +530,29 @@ static int da9063_ldo_set_suspend_mode(struct regulator_dev *rdev, unsigned mode
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
1.9.1

