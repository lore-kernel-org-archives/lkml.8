Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB466C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B18362074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="rCQmxswG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632914AbgDNUPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2632880AbgDNUPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:15:33 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19D6C061A10;
        Tue, 14 Apr 2020 13:15:31 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a201so15425535wme.1;
        Tue, 14 Apr 2020 13:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p4l4dlajAQ5hYjHdHbwaVhCtPIXq0hp8eJOoIEyPOB8=;
        b=rCQmxswG1BGOEARKUCexdg+aGeADAIKgZIwZjwJkLZrGhmCovgrO+m71XsKtHMwhcW
         jGTKcfBk9GxSTf79LGD7XxCdD5zurhHtPqMMh/UsTeeVYX6rQhPqDtQUYsOTVD//mTkX
         lGIShvLgthU6cz53Kri6oAh8W9SlVpcgLklPEsH3AYFn/Btx+9dTE15PxwlrvewOrz+q
         loCkkfriYZGolidfxl9eeapc2PeCYoH+abWdGDRnOEp2GCeRGV4yn2hMs9HIto0rdEs+
         4sQZCjCtWNIzeW9R1/A/yFXsIUCfw1kLW9k1S2ibSQfEj1ClNMg8q4Tkf78ePOEmiMzu
         ZGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p4l4dlajAQ5hYjHdHbwaVhCtPIXq0hp8eJOoIEyPOB8=;
        b=P7yQtF6SFQnaHI7afJPMVXGjRG6gmYvbG2lbzwsusbjXkJHU+p6J+/sNdjwX0P8auN
         G0KkCMMdGmuvnu+cx+l3nuoFT/qviHH+gW4PELQno9Dz8xBwQbbRxiURI45+I6hqxv05
         uLQNUWz6/ncmVeBGp292J+AXGsdYeUcmMZLbc20Jzn3e9wnmaYPgpMu9Rag21F2jTD2z
         gGYtUzsHblVOUNJaBkdt9c5uw08ma7JMqfroH1BiSclV/ISf1O2wK+p0M5LgeUnkA6q2
         6gbUlaI+9KJCgBS3fVGlZscQtE4S3Ggb0y4vSEkMZpbTjfkmOxN02+Ty5rkelfkCW2lY
         HuAg==
X-Gm-Message-State: AGi0PuY6CSHddpFjdZLSgks1fF6d+znqM83rhfAGKjSI+ffOz+UZOc/C
        0mKtArZ6pfvXeHxHm4wKgeI=
X-Google-Smtp-Source: APiQypJn7651jK1wPIoK97bfaAlMxVEJAxTqdFKuTBux1LLYd0Wh6Oa1R9Ue81ARL/IBgupmXdzqDQ==
X-Received: by 2002:a1c:4b15:: with SMTP id y21mr1531218wma.150.1586895330456;
        Tue, 14 Apr 2020 13:15:30 -0700 (PDT)
Received: from localhost.localdomain (p200300F13717DF00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3717:df00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id u17sm22537467wra.63.2020.04.14.13.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:15:30 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     robh+dt@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 3/4] soc: amlogic: meson-ee-pwrc: add support for Meson8/Meson8b/Meson8m2
Date:   Tue, 14 Apr 2020 22:14:56 +0200
Message-Id: <20200414201457.229131-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414201457.229131-1-martin.blumenstingl@googlemail.com>
References: <20200414201457.229131-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the power domains on Meson8/Meson8b/Meson8m2.
Meson8 doesn't use any reset lines while Meson8b and Meson8m2 use the
same set of reset lines (which is different from the newer SoCs).
Add dedicated compatible strings for Meson8, Meson8b and Meson8m2 to
support these differences.

Notable differences between Meson8 and G12A are:
- there is no HHI_VPU_MEM_PD_REG2 on the 32-bit SoCs
- the Meson8b datasheet describes an "audio DSP memory" power domain
  which is used for the hardware audio decoder
- the "amlogic,ao-sysctrl" only includes the power management related
  registers on the 32-bit SoCs, meaning the for example the
  AO_RTI_GEN_PWR_SLEEP0 register is at offset (0x2 << 2) rather than
  (0x3a << 2). As result of this (0x38 << 2) is subtracted from the
  register offsets, which is the start of the power management related
  registers.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/soc/amlogic/meson-ee-pwrc.c | 72 +++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
index 3f0261d53ad9..b30868da456a 100644
--- a/drivers/soc/amlogic/meson-ee-pwrc.c
+++ b/drivers/soc/amlogic/meson-ee-pwrc.c
@@ -14,6 +14,7 @@
 #include <linux/reset-controller.h>
 #include <linux/reset.h>
 #include <linux/clk.h>
+#include <dt-bindings/power/meson8-power.h>
 #include <dt-bindings/power/meson-g12a-power.h>
 #include <dt-bindings/power/meson-sm1-power.h>
 
@@ -22,6 +23,12 @@
 #define AO_RTI_GEN_PWR_SLEEP0		(0x3a << 2)
 #define AO_RTI_GEN_PWR_ISO0		(0x3b << 2)
 
+/*
+ * Meson8/Meson8b/Meson8m2 only expose the power management registers of
+ * the AO-bus as syscon. Above register offsets need to subtract this offset.
+ */
+#define AO_RTI_GEN_MESON8_PMU_OFFSET	(0x38 << 2)
+
 /* HHI Offsets */
 
 #define HHI_MEM_PD_REG0			(0x40 << 2)
@@ -73,6 +80,13 @@ static struct meson_ee_pwrc_top_domain g12a_pwrc_vpu = {
 	.iso_mask = BIT(9),
 };
 
+static struct meson_ee_pwrc_top_domain meson8_pwrc_vpu = {
+	.sleep_reg = AO_RTI_GEN_PWR_SLEEP0 - AO_RTI_GEN_MESON8_PMU_OFFSET,
+	.sleep_mask = BIT(8),
+	.iso_reg = AO_RTI_GEN_PWR_SLEEP0 - AO_RTI_GEN_MESON8_PMU_OFFSET,
+	.iso_mask = BIT(9),
+};
+
 #define SM1_EE_PD(__bit)					\
 	{							\
 		.sleep_reg = AO_RTI_GEN_PWR_SLEEP0, 		\
@@ -124,10 +138,20 @@ static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_vpu[] = {
 	VPU_HHI_MEMPD(HHI_MEM_PD_REG0),
 };
 
-static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_eth[] = {
+static struct meson_ee_pwrc_mem_domain meson8_pwrc_mem_eth[] = {
 	{ HHI_MEM_PD_REG0, GENMASK(3, 2) },
 };
 
+static struct meson_ee_pwrc_mem_domain meson8_pwrc_audio_dsp_mem[] = {
+	{ HHI_MEM_PD_REG0, GENMASK(1, 0) },
+};
+
+static struct meson_ee_pwrc_mem_domain meson8_pwrc_mem_vpu[] = {
+	VPU_MEMPD(HHI_VPU_MEM_PD_REG0),
+	VPU_MEMPD(HHI_VPU_MEM_PD_REG1),
+	VPU_HHI_MEMPD(HHI_MEM_PD_REG0),
+};
+
 static struct meson_ee_pwrc_mem_domain sm1_pwrc_mem_vpu[] = {
 	VPU_MEMPD(HHI_VPU_MEM_PD_REG0),
 	VPU_MEMPD(HHI_VPU_MEM_PD_REG1),
@@ -201,7 +225,27 @@ static bool pwrc_ee_get_power(struct meson_ee_pwrc_domain *pwrc_domain);
 static struct meson_ee_pwrc_domain_desc g12a_pwrc_domains[] = {
 	[PWRC_G12A_VPU_ID]  = VPU_PD("VPU", &g12a_pwrc_vpu, g12a_pwrc_mem_vpu,
 				     pwrc_ee_get_power, 11, 2),
-	[PWRC_G12A_ETH_ID] = MEM_PD("ETH", g12a_pwrc_mem_eth),
+	[PWRC_G12A_ETH_ID] = MEM_PD("ETH", meson8_pwrc_mem_eth),
+};
+
+static struct meson_ee_pwrc_domain_desc meson8_pwrc_domains[] = {
+	[PWRC_MESON8_VPU_ID]  = VPU_PD("VPU", &meson8_pwrc_vpu,
+				       meson8_pwrc_mem_vpu, pwrc_ee_get_power,
+				       0, 1),
+	[PWRC_MESON8_ETHERNET_MEM_ID] = MEM_PD("ETHERNET_MEM",
+						  meson8_pwrc_mem_eth),
+	[PWRC_MESON8_AUDIO_DSP_MEM_ID] = MEM_PD("AUDIO_DSP_MEM",
+						meson8_pwrc_audio_dsp_mem),
+};
+
+static struct meson_ee_pwrc_domain_desc meson8b_pwrc_domains[] = {
+	[PWRC_MESON8_VPU_ID]  = VPU_PD("VPU", &meson8_pwrc_vpu,
+				       meson8_pwrc_mem_vpu, pwrc_ee_get_power,
+				       11, 1),
+	[PWRC_MESON8_ETHERNET_MEM_ID] = MEM_PD("ETHERNET_MEM",
+						  meson8_pwrc_mem_eth),
+	[PWRC_MESON8_AUDIO_DSP_MEM_ID] = MEM_PD("AUDIO_DSP_MEM",
+						meson8_pwrc_audio_dsp_mem),
 };
 
 static struct meson_ee_pwrc_domain_desc sm1_pwrc_domains[] = {
@@ -216,7 +260,7 @@ static struct meson_ee_pwrc_domain_desc sm1_pwrc_domains[] = {
 	[PWRC_SM1_GE2D_ID] = TOP_PD("GE2D", &sm1_pwrc_ge2d, sm1_pwrc_mem_ge2d,
 				    pwrc_ee_get_power),
 	[PWRC_SM1_AUDIO_ID] = MEM_PD("AUDIO", sm1_pwrc_mem_audio),
-	[PWRC_SM1_ETH_ID] = MEM_PD("ETH", g12a_pwrc_mem_eth),
+	[PWRC_SM1_ETH_ID] = MEM_PD("ETH", meson8_pwrc_mem_eth),
 };
 
 struct meson_ee_pwrc_domain {
@@ -470,12 +514,34 @@ static struct meson_ee_pwrc_domain_data meson_ee_g12a_pwrc_data = {
 	.domains = g12a_pwrc_domains,
 };
 
+static struct meson_ee_pwrc_domain_data meson_ee_m8_pwrc_data = {
+	.count = ARRAY_SIZE(meson8_pwrc_domains),
+	.domains = meson8_pwrc_domains,
+};
+
+static struct meson_ee_pwrc_domain_data meson_ee_m8b_pwrc_data = {
+	.count = ARRAY_SIZE(meson8b_pwrc_domains),
+	.domains = meson8b_pwrc_domains,
+};
+
 static struct meson_ee_pwrc_domain_data meson_ee_sm1_pwrc_data = {
 	.count = ARRAY_SIZE(sm1_pwrc_domains),
 	.domains = sm1_pwrc_domains,
 };
 
 static const struct of_device_id meson_ee_pwrc_match_table[] = {
+	{
+		.compatible = "amlogic,meson8-pwrc",
+		.data = &meson_ee_m8_pwrc_data,
+	},
+	{
+		.compatible = "amlogic,meson8b-pwrc",
+		.data = &meson_ee_m8b_pwrc_data,
+	},
+	{
+		.compatible = "amlogic,meson8m2-pwrc",
+		.data = &meson_ee_m8b_pwrc_data,
+	},
 	{
 		.compatible = "amlogic,meson-g12a-pwrc",
 		.data = &meson_ee_g12a_pwrc_data,
-- 
2.26.0

