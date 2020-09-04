Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8B5C2BB84
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 261DA2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="siFPR6aR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgIDQFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgIDQFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:05:06 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D23C061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 09:05:06 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u18so6537228wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 09:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yTXlpKamjwyTHjWdGVSl8o9My/8vSac7U2q74lShFws=;
        b=siFPR6aRivTG4UwTsmGL9oE+KFJlvZ6Ik0/YOfh1DsNSaTy+zYFSKZozg7FXg45SEu
         ro8fVmQTuJKWq/NvSL1cPI5dD/hi4XV3dQqDk7dw98BIV74+GxybrY/GvsE3FMLRQfvW
         b3XW7lxpFHBVqjOgF6REu6V5843LXZCTeAmjcF/plXLrAqfSt5VBrhV5ln4zCUnunLla
         bO97YfeqoAbfT703K+bt/i3B5w3PZsdKVedVs5wtFT8xEoU5XSuYdE5/bq7b7cKpmfdU
         /7DB/YfJA6iERxJoaAbcgrTinl7iG3bvIat4x0BJO/lLlcB1t164vVuQoPK7ncoUNEsq
         imuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yTXlpKamjwyTHjWdGVSl8o9My/8vSac7U2q74lShFws=;
        b=CHAesj6ff7eIwPmEsmV/wmO92p1HU7hH1ujBAdg6heQu2l+CrzWDdWF+oOEHrOWOBE
         9zEiiG+73P/ez3H0tM4AxfOC+p5SGyd2QhLYBIjkW3Fd08V2e+xPGvbbWY2fd/1RM5SY
         s0qyMMMu4+z3FqtNcs0yv2b1fJWmhaTzWKYmSZurJDF1l03ys7MOfswnbOZva22VZ0sD
         nLtSX3/RhSg1bbF7cgmV8kbkdZMPIx3yMEHD3DsqxdCMS44ysnHMIZUYiYcq7PiC305B
         4H3vQlJpiHn0768Ty0TbMyp7M+P5zgilEZkQiWnOjW2iDrYgawxp//xVugmBxiP5Yh8O
         g8Eg==
X-Gm-Message-State: AOAM530a5VmkrdLtbNJ8EL+Q6U0jubRjOK0BVK14K77QVl2Ks9Fbf0ZM
        3DvCwlqyYuAkWUWLpJ4B9uB0yQ==
X-Google-Smtp-Source: ABdhPJxI3136LpiKvLQIjnG0wTFZ8dVizPe7AJBMHTf12fW/qqwn8dx3TZTFNeztkzCDV9ZSTfl78g==
X-Received: by 2002:a1c:c256:: with SMTP id s83mr8363530wmf.93.1599235504887;
        Fri, 04 Sep 2020 09:05:04 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id o9sm12038486wrw.58.2020.09.04.09.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 09:05:04 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] soc: amlogic: meson-ee-pwrc: add support for the Meson AXG SoCs
Date:   Fri,  4 Sep 2020 18:05:00 +0200
Message-Id: <20200904160500.22924-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200904160500.22924-1-narmstrong@baylibre.com>
References: <20200904160206.22570-1-narmstrong@baylibre.com>
 <20200904160500.22924-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Power Controller in the Amlogic AXG SoCs is similar to the GXL one
but with less VPU memory domains to enable and a supplementary Audio
memory power domain.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/soc/amlogic/meson-ee-pwrc.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
index 43665b77aa9e..81834eb166d0 100644
--- a/drivers/soc/amlogic/meson-ee-pwrc.c
+++ b/drivers/soc/amlogic/meson-ee-pwrc.c
@@ -15,6 +15,7 @@
 #include <linux/reset.h>
 #include <linux/clk.h>
 #include <dt-bindings/power/meson8-power.h>
+#include <dt-bindings/power/meson-axg-power.h>
 #include <dt-bindings/power/meson-g12a-power.h>
 #include <dt-bindings/power/meson-gxbb-power.h>
 #include <dt-bindings/power/meson-sm1-power.h>
@@ -141,6 +142,11 @@ static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_vpu[] = {
 	VPU_HHI_MEMPD(HHI_MEM_PD_REG0),
 };
 
+static struct meson_ee_pwrc_mem_domain axg_pwrc_mem_vpu[] = {
+	VPU_MEMPD(HHI_VPU_MEM_PD_REG0),
+	VPU_HHI_MEMPD(HHI_MEM_PD_REG0),
+};
+
 static struct meson_ee_pwrc_mem_domain gxbb_pwrc_mem_vpu[] = {
 	VPU_MEMPD(HHI_VPU_MEM_PD_REG0),
 	VPU_MEMPD(HHI_VPU_MEM_PD_REG1),
@@ -190,6 +196,10 @@ static struct meson_ee_pwrc_mem_domain sm1_pwrc_mem_ge2d[] = {
 	{ HHI_MEM_PD_REG0, GENMASK(25, 18) },
 };
 
+static struct meson_ee_pwrc_mem_domain axg_pwrc_mem_audio[] = {
+	{ HHI_MEM_PD_REG0, GENMASK(5, 4) },
+};
+
 static struct meson_ee_pwrc_mem_domain sm1_pwrc_mem_audio[] = {
 	{ HHI_MEM_PD_REG0, GENMASK(5, 4) },
 	{ HHI_AUDIO_MEM_PD_REG0, GENMASK(1, 0) },
@@ -237,6 +247,13 @@ static struct meson_ee_pwrc_domain_desc g12a_pwrc_domains[] = {
 	[PWRC_G12A_ETH_ID] = MEM_PD("ETH", meson_pwrc_mem_eth),
 };
 
+static struct meson_ee_pwrc_domain_desc axg_pwrc_domains[] = {
+	[PWRC_AXG_VPU_ID]  = VPU_PD("VPU", &gx_pwrc_vpu, axg_pwrc_mem_vpu,
+				     pwrc_ee_get_power, 5, 2),
+	[PWRC_AXG_ETHERNET_MEM_ID] = MEM_PD("ETH", meson_pwrc_mem_eth),
+	[PWRC_AXG_AUDIO_ID] = MEM_PD("AUDIO", axg_pwrc_mem_audio),
+};
+
 static struct meson_ee_pwrc_domain_desc gxbb_pwrc_domains[] = {
 	[PWRC_GXBB_VPU_ID]  = VPU_PD("VPU", &gx_pwrc_vpu, gxbb_pwrc_mem_vpu,
 				     pwrc_ee_get_power, 12, 2),
@@ -529,6 +546,11 @@ static struct meson_ee_pwrc_domain_data meson_ee_g12a_pwrc_data = {
 	.domains = g12a_pwrc_domains,
 };
 
+static struct meson_ee_pwrc_domain_data meson_ee_axg_pwrc_data = {
+	.count = ARRAY_SIZE(axg_pwrc_domains),
+	.domains = axg_pwrc_domains,
+};
+
 static struct meson_ee_pwrc_domain_data meson_ee_gxbb_pwrc_data = {
 	.count = ARRAY_SIZE(gxbb_pwrc_domains),
 	.domains = gxbb_pwrc_domains,
@@ -566,6 +588,10 @@ static const struct of_device_id meson_ee_pwrc_match_table[] = {
 		.compatible = "amlogic,meson-gxbb-pwrc",
 		.data = &meson_ee_gxbb_pwrc_data,
 	},
+	{
+		.compatible = "amlogic,meson-axg-pwrc",
+		.data = &meson_ee_axg_pwrc_data,
+	},
 	{
 		.compatible = "amlogic,meson-g12a-pwrc",
 		.data = &meson_ee_g12a_pwrc_data,
-- 
2.22.0

