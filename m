Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E76C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A850520756
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CRC/P4eT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgEOUsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 16:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgEOUrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 16:47:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF5CC061A0C;
        Fri, 15 May 2020 13:47:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id v12so4942101wrp.12;
        Fri, 15 May 2020 13:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JkzlwGDcewdfreahPLwFbR/d60ApGzGnMJchWdLp2eo=;
        b=CRC/P4eT7ByBXhJaUn9O2LkUDmBU96Ojnzy5UFm1QjDzVKbhNvUy4KWCd2ard9gNia
         nSzU2EYLwfRjUMx94tc7UkXUSv91SP3wKmHBTZhs+6FZGxmNPZAd9KIRqOatvbN/NhPL
         O72jEJTUrNH1PSIDBiu27IJZn430N1E9l0kDg0fNtZBTtwiZGqfbyGZ2j/wHDfD/il3Q
         wW1qL5PsjQBPTP77tMDhJb8GCArdZFkOhuTDpXmTJMFhpnhTk0soFvS1b783IkWaOJWK
         UZplC2vkEBQsWXdL/RkWDA/UVR+5OVa9ODTmje8B6MX6OYdoH+b6RNdfobqqe/sh8+ji
         IQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JkzlwGDcewdfreahPLwFbR/d60ApGzGnMJchWdLp2eo=;
        b=uJT0WyKSseKTbw/U396BOMsAUQqLqoMeIZJGCyx2fTutw8Yv3j/eSYQ709a84CsX3C
         725R2TjAS/YMUTKYym0GV79kbJg27e8SVM0hpH1EzBPuyB23N4RTdGYdNcSpgOPu7oGD
         JE14B8w6FQLJ+iuB29MS916tCdVcib0ZqDx9u8qFjZ/+yZeDxaLDx2yTI9+jZpyFvnwF
         O7xdCngoeQ0MCru2NUkRNr5YQx32kF86tdakMQpNe/wOxFvcoFcsMlvlacgrO+p/yO5h
         jELKhoYKzorKWdTsWvXsu0zfzq4J49WZ+WRHChg5cYrvY2+c/5XYVn7E0XIWJ1TC39l0
         m9QA==
X-Gm-Message-State: AOAM5334LW4ShoGmGNO1USwEq2r1+ybbNYIGJRiU2okQeA9MV+DYHIPZ
        Dp+mqSLrm1IhyQIfV3HHFzg=
X-Google-Smtp-Source: ABdhPJwFq0+9sF2WNuYs25uj0O006ePbMMW6xV8V8awuMB2aw+rYEOc7/8XkLexD7zGDkPC5NNu29A==
X-Received: by 2002:a5d:4e81:: with SMTP id e1mr6202680wru.83.1589575666809;
        Fri, 15 May 2020 13:47:46 -0700 (PDT)
Received: from localhost.localdomain (p200300F137132E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3713:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id r11sm5296211wma.35.2020.05.15.13.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 13:47:45 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     khilman@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     robh+dt@kernel.org, narmstrong@baylibre.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v4 3/4] soc: amlogic: meson-ee-pwrc: add support for Meson8/Meson8b/Meson8m2
Date:   Fri, 15 May 2020 22:47:08 +0200
Message-Id: <20200515204709.1505498-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515204709.1505498-1-martin.blumenstingl@googlemail.com>
References: <20200515204709.1505498-1-martin.blumenstingl@googlemail.com>
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
 drivers/soc/amlogic/meson-ee-pwrc.c | 86 ++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
index 3f0261d53ad9..390eb0dd0a79 100644
--- a/drivers/soc/amlogic/meson-ee-pwrc.c
+++ b/drivers/soc/amlogic/meson-ee-pwrc.c
@@ -14,13 +14,22 @@
 #include <linux/reset-controller.h>
 #include <linux/reset.h>
 #include <linux/clk.h>
+#include <dt-bindings/power/meson8-power.h>
 #include <dt-bindings/power/meson-g12a-power.h>
 #include <dt-bindings/power/meson-sm1-power.h>
 
 /* AO Offsets */
 
-#define AO_RTI_GEN_PWR_SLEEP0		(0x3a << 2)
-#define AO_RTI_GEN_PWR_ISO0		(0x3b << 2)
+#define GX_AO_RTI_GEN_PWR_SLEEP0	(0x3a << 2)
+#define GX_AO_RTI_GEN_PWR_ISO0		(0x3b << 2)
+
+/*
+ * Meson8/Meson8b/Meson8m2 only expose the power management registers of the
+ * AO-bus as syscon. 0x3a from GX translates to 0x02, 0x3b translates to 0x03
+ * and so on.
+ */
+#define MESON8_AO_RTI_GEN_PWR_SLEEP0	(0x02 << 2)
+#define MESON8_AO_RTI_GEN_PWR_ISO0	(0x03 << 2)
 
 /* HHI Offsets */
 
@@ -67,17 +76,24 @@ struct meson_ee_pwrc_domain_data {
 /* TOP Power Domains */
 
 static struct meson_ee_pwrc_top_domain g12a_pwrc_vpu = {
-	.sleep_reg = AO_RTI_GEN_PWR_SLEEP0,
+	.sleep_reg = GX_AO_RTI_GEN_PWR_SLEEP0,
+	.sleep_mask = BIT(8),
+	.iso_reg = GX_AO_RTI_GEN_PWR_SLEEP0,
+	.iso_mask = BIT(9),
+};
+
+static struct meson_ee_pwrc_top_domain meson8_pwrc_vpu = {
+	.sleep_reg = MESON8_AO_RTI_GEN_PWR_SLEEP0,
 	.sleep_mask = BIT(8),
-	.iso_reg = AO_RTI_GEN_PWR_SLEEP0,
+	.iso_reg = MESON8_AO_RTI_GEN_PWR_SLEEP0,
 	.iso_mask = BIT(9),
 };
 
 #define SM1_EE_PD(__bit)					\
 	{							\
-		.sleep_reg = AO_RTI_GEN_PWR_SLEEP0, 		\
+		.sleep_reg = GX_AO_RTI_GEN_PWR_SLEEP0, 		\
 		.sleep_mask = BIT(__bit), 			\
-		.iso_reg = AO_RTI_GEN_PWR_ISO0, 		\
+		.iso_reg = GX_AO_RTI_GEN_PWR_ISO0, 		\
 		.iso_mask = BIT(__bit), 			\
 	}
 
@@ -124,10 +140,20 @@ static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_vpu[] = {
 	VPU_HHI_MEMPD(HHI_MEM_PD_REG0),
 };
 
-static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_eth[] = {
+static struct meson_ee_pwrc_mem_domain meson_pwrc_mem_eth[] = {
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
@@ -201,7 +227,27 @@ static bool pwrc_ee_get_power(struct meson_ee_pwrc_domain *pwrc_domain);
 static struct meson_ee_pwrc_domain_desc g12a_pwrc_domains[] = {
 	[PWRC_G12A_VPU_ID]  = VPU_PD("VPU", &g12a_pwrc_vpu, g12a_pwrc_mem_vpu,
 				     pwrc_ee_get_power, 11, 2),
-	[PWRC_G12A_ETH_ID] = MEM_PD("ETH", g12a_pwrc_mem_eth),
+	[PWRC_G12A_ETH_ID] = MEM_PD("ETH", meson_pwrc_mem_eth),
+};
+
+static struct meson_ee_pwrc_domain_desc meson8_pwrc_domains[] = {
+	[PWRC_MESON8_VPU_ID]  = VPU_PD("VPU", &meson8_pwrc_vpu,
+				       meson8_pwrc_mem_vpu, pwrc_ee_get_power,
+				       0, 1),
+	[PWRC_MESON8_ETHERNET_MEM_ID] = MEM_PD("ETHERNET_MEM",
+					       meson_pwrc_mem_eth),
+	[PWRC_MESON8_AUDIO_DSP_MEM_ID] = MEM_PD("AUDIO_DSP_MEM",
+						meson8_pwrc_audio_dsp_mem),
+};
+
+static struct meson_ee_pwrc_domain_desc meson8b_pwrc_domains[] = {
+	[PWRC_MESON8_VPU_ID]  = VPU_PD("VPU", &meson8_pwrc_vpu,
+				       meson8_pwrc_mem_vpu, pwrc_ee_get_power,
+				       11, 1),
+	[PWRC_MESON8_ETHERNET_MEM_ID] = MEM_PD("ETHERNET_MEM",
+					       meson_pwrc_mem_eth),
+	[PWRC_MESON8_AUDIO_DSP_MEM_ID] = MEM_PD("AUDIO_DSP_MEM",
+						meson8_pwrc_audio_dsp_mem),
 };
 
 static struct meson_ee_pwrc_domain_desc sm1_pwrc_domains[] = {
@@ -216,7 +262,7 @@ static struct meson_ee_pwrc_domain_desc sm1_pwrc_domains[] = {
 	[PWRC_SM1_GE2D_ID] = TOP_PD("GE2D", &sm1_pwrc_ge2d, sm1_pwrc_mem_ge2d,
 				    pwrc_ee_get_power),
 	[PWRC_SM1_AUDIO_ID] = MEM_PD("AUDIO", sm1_pwrc_mem_audio),
-	[PWRC_SM1_ETH_ID] = MEM_PD("ETH", g12a_pwrc_mem_eth),
+	[PWRC_SM1_ETH_ID] = MEM_PD("ETH", meson_pwrc_mem_eth),
 };
 
 struct meson_ee_pwrc_domain {
@@ -470,12 +516,34 @@ static struct meson_ee_pwrc_domain_data meson_ee_g12a_pwrc_data = {
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
2.26.2

