Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FB1C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B532821D92
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kwb9FGhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgIJV1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731051AbgIJOKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:10:20 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C694C06179B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:57:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so6851067wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JuyBy5SQ7Lbzjz7YW70om8n+KmTvxYMUk+MZk/dzwhw=;
        b=Kwb9FGhK/VZxBJyw32CBJXlBvPh8JJqrejHsDQcx6O9DfDnqGscFNi1vOWFEv/JDvO
         5bAKHrqOopKBjW9KfqBdjL9jpxEYypeGrNbite8YEhbzS/6fWZq+rBh370l7/6vWc4nP
         JhO6l8tEbyb7nY7fvmUNAT6zOQMAkr82dtEs5HJE/YrOioqhkQX13VW8nVVKJpErzG9m
         vx8UVTFUrPweHMq/vdGw2RHq0tMqqxSftmckFvCmoC56PCOcuRm0akrg9j2j0ehiyO8e
         LGul4m6xMpzIJP0fKoPklKZxvdcdHpBkAtmOFjk9galeiYUzhBn3cIdn5ooBwljP+BNw
         0Bqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JuyBy5SQ7Lbzjz7YW70om8n+KmTvxYMUk+MZk/dzwhw=;
        b=e0MBJWF+n7UlDM4YUO0/So5+oRGR357CuWltV0oLLCdur9aYq+MCs5xjM2ZzdMrYew
         MUVXgN4wRqxBhoODYqlQ06Jv2POwXtoeOVsrQJxvVr1RdA/2/mdOuNt/t29wDwvekZ+B
         OoSIJdxc3VG+W0tm61HAFVIAsE5lbLuST9TBNodGU7NAww79gwHRR3joZIUIvY241JVr
         3eeIXZa/UcQ2JFMLbW/Z7dwAdrnNVTieWqjGlp32+vKuPaAyf6b/P8hn/QlvJYoT3nbi
         SdYc0dFXwOuvMJVBFZCFC3HOWGKqSs92I8yKnKyO1Nv5fV4X6S1v7gHvl5vdz17StH5I
         NxAg==
X-Gm-Message-State: AOAM533qvhsrRmp/nAGl8r1r7WtQnB8od7xi0PTnf78T+YPQDbYKKvSj
        NIxzS1LpInbWDqmemHCsYnZUSg==
X-Google-Smtp-Source: ABdhPJxoAB4SgLJt/G+GmfOLrydKZkE5iN65qR8j3d4TGTuQTXLIW7vY72H0j/6CKQVH6sTxQnkeWw==
X-Received: by 2002:adf:e4c9:: with SMTP id v9mr8851548wrm.375.1599746252966;
        Thu, 10 Sep 2020 06:57:32 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id b2sm3786154wmh.47.2020.09.10.06.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:57:32 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] ASoC: q6afe-clocks: add q6afe clock controller
Date:   Thu, 10 Sep 2020 14:57:08 +0100
Message-Id: <20200910135708.14842-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200910135708.14842-1-srinivas.kandagatla@linaro.org>
References: <20200910135708.14842-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

q6afe already exposes lpass clocks, however this was not presented
as proper clock controller driver. This patch basically adds clock
controller support for q6afe clocks.

This is useful for other drivers like lpass digital codec or lpass
lowpower island drivers to request or vote for these clocks.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig              |   4 +
 sound/soc/qcom/qdsp6/Makefile       |   1 +
 sound/soc/qcom/qdsp6/q6afe-clocks.c | 270 ++++++++++++++++++++++++++++
 3 files changed, 275 insertions(+)
 create mode 100644 sound/soc/qcom/qdsp6/q6afe-clocks.c

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index a607ace8b089..a7ef62685b41 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -63,6 +63,9 @@ config SND_SOC_QDSP6_AFE
 config SND_SOC_QDSP6_AFE_DAI
 	tristate
 
+config SND_SOC_QDSP6_AFE_CLOCKS
+	tristate
+
 config SND_SOC_QDSP6_ADM
 	tristate
 
@@ -83,6 +86,7 @@ config SND_SOC_QDSP6
 	select SND_SOC_QDSP6_CORE
 	select SND_SOC_QDSP6_AFE
 	select SND_SOC_QDSP6_AFE_DAI
+	select SND_SOC_QDSP6_AFE_CLOCKS
 	select SND_SOC_QDSP6_ADM
 	select SND_SOC_QDSP6_ROUTING
 	select SND_SOC_QDSP6_ASM
diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
index 7e91e96f7ad5..3c1dd9f32f1d 100644
--- a/sound/soc/qcom/qdsp6/Makefile
+++ b/sound/soc/qcom/qdsp6/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_SND_SOC_QDSP6_COMMON) += q6dsp-common.o
 obj-$(CONFIG_SND_SOC_QDSP6_CORE) += q6core.o
 obj-$(CONFIG_SND_SOC_QDSP6_AFE) += q6afe.o
 obj-$(CONFIG_SND_SOC_QDSP6_AFE_DAI) += q6afe-dai.o
+obj-$(CONFIG_SND_SOC_QDSP6_AFE_CLOCKS) += q6afe-clocks.o
 obj-$(CONFIG_SND_SOC_QDSP6_ADM) += q6adm.o
 obj-$(CONFIG_SND_SOC_QDSP6_ROUTING) += q6routing.o
 obj-$(CONFIG_SND_SOC_QDSP6_ASM) += q6asm.o
diff --git a/sound/soc/qcom/qdsp6/q6afe-clocks.c b/sound/soc/qcom/qdsp6/q6afe-clocks.c
new file mode 100644
index 000000000000..2967f4546af5
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6afe-clocks.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-1.0
+// Copyright (c) 2020, Linaro Limited
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include "q6afe.h"
+
+#define Q6AFE_CLK(id) &(struct q6afe_clk) {		\
+		.clk_id	= id,				\
+		.afe_clk_id	= Q6AFE_##id,		\
+		.name = #id,				\
+		.attributes = LPASS_CLK_ATTRIBUTE_COUPLE_NO, \
+		.hw.init = &(struct clk_init_data) {	\
+			.ops = &clk_q6afe_ops,		\
+			.name = #id,			\
+		},					\
+	}
+
+#define Q6AFE_VOTE_CLK(id, blkid, n) &(struct q6afe_clk) { \
+		.clk_id	= id,				\
+		.afe_clk_id = blkid,			\
+		.name = #n,				\
+		.hw.init = &(struct clk_init_data) {	\
+			.ops = &clk_vote_q6afe_ops,	\
+			.name = #id,			\
+		},					\
+	}
+
+struct q6afe_clk {
+	struct device *dev;
+	int clk_id;
+	int afe_clk_id;
+	char *name;
+	int attributes;
+	int rate;
+	uint32_t handle;
+	struct clk_hw hw;
+};
+
+#define to_q6afe_clk(_hw) container_of(_hw, struct q6afe_clk, hw)
+
+struct q6afe_cc {
+	struct device *dev;
+	struct q6afe_clk **clks;
+	int num_clks;
+};
+
+static int clk_q6afe_prepare(struct clk_hw *hw)
+{
+	struct q6afe_clk *clk = to_q6afe_clk(hw);
+
+	return q6afe_set_lpass_clock(clk->dev, clk->afe_clk_id, clk->attributes,
+				     Q6AFE_LPASS_CLK_ROOT_DEFAULT, clk->rate);
+}
+
+static void clk_q6afe_unprepare(struct clk_hw *hw)
+{
+	struct q6afe_clk *clk = to_q6afe_clk(hw);
+
+	q6afe_set_lpass_clock(clk->dev, clk->afe_clk_id, clk->attributes,
+			      Q6AFE_LPASS_CLK_ROOT_DEFAULT, 0);
+}
+
+static int clk_q6afe_set_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long parent_rate)
+{
+	struct q6afe_clk *clk = to_q6afe_clk(hw);
+
+	clk->rate = rate;
+
+	return 0;
+}
+
+static unsigned long clk_q6afe_recalc_rate(struct clk_hw *hw,
+					   unsigned long parent_rate)
+{
+	struct q6afe_clk *clk = to_q6afe_clk(hw);
+
+	return clk->rate;
+}
+
+static long clk_q6afe_round_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long *parent_rate)
+{
+	return rate;
+}
+
+static const struct clk_ops clk_q6afe_ops = {
+	.prepare	= clk_q6afe_prepare,
+	.unprepare	= clk_q6afe_unprepare,
+	.set_rate	= clk_q6afe_set_rate,
+	.round_rate	= clk_q6afe_round_rate,
+	.recalc_rate	= clk_q6afe_recalc_rate,
+};
+
+static int clk_vote_q6afe_block(struct clk_hw *hw)
+{
+	struct q6afe_clk *clk = to_q6afe_clk(hw);
+
+	return q6afe_vote_lpass_core_hw(clk->dev, clk->afe_clk_id,
+					clk->name, &clk->handle);
+}
+
+static void clk_unvote_q6afe_block(struct clk_hw *hw)
+{
+	struct q6afe_clk *clk = to_q6afe_clk(hw);
+
+	q6afe_unvote_lpass_core_hw(clk->dev, clk->afe_clk_id, clk->handle);
+}
+
+static const struct clk_ops clk_vote_q6afe_ops = {
+	.prepare	= clk_vote_q6afe_block,
+	.unprepare	= clk_unvote_q6afe_block,
+};
+
+struct q6afe_clk *q6afe_clks[Q6AFE_MAX_CLK_ID] = {
+	[LPASS_CLK_ID_PRI_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_PRI_MI2S_IBIT),
+	[LPASS_CLK_ID_PRI_MI2S_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_PRI_MI2S_EBIT),
+	[LPASS_CLK_ID_SEC_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEC_MI2S_IBIT),
+	[LPASS_CLK_ID_SEC_MI2S_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEC_MI2S_EBIT),
+	[LPASS_CLK_ID_TER_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_TER_MI2S_IBIT),
+	[LPASS_CLK_ID_TER_MI2S_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_TER_MI2S_EBIT),
+	[LPASS_CLK_ID_QUAD_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUAD_MI2S_IBIT),
+	[LPASS_CLK_ID_QUAD_MI2S_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUAD_MI2S_EBIT),
+	[LPASS_CLK_ID_SPEAKER_I2S_IBIT] =
+				Q6AFE_CLK(LPASS_CLK_ID_SPEAKER_I2S_IBIT),
+	[LPASS_CLK_ID_SPEAKER_I2S_EBIT] =
+				Q6AFE_CLK(LPASS_CLK_ID_SPEAKER_I2S_EBIT),
+	[LPASS_CLK_ID_SPEAKER_I2S_OSR] =
+				Q6AFE_CLK(LPASS_CLK_ID_SPEAKER_I2S_OSR),
+	[LPASS_CLK_ID_QUI_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUI_MI2S_IBIT),
+	[LPASS_CLK_ID_QUI_MI2S_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUI_MI2S_EBIT),
+	[LPASS_CLK_ID_SEN_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEN_MI2S_IBIT),
+	[LPASS_CLK_ID_SEN_MI2S_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEN_MI2S_EBIT),
+	[LPASS_CLK_ID_INT0_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_INT0_MI2S_IBIT),
+	[LPASS_CLK_ID_INT1_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_INT1_MI2S_IBIT),
+	[LPASS_CLK_ID_INT2_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_INT2_MI2S_IBIT),
+	[LPASS_CLK_ID_INT3_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_INT3_MI2S_IBIT),
+	[LPASS_CLK_ID_INT4_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_INT4_MI2S_IBIT),
+	[LPASS_CLK_ID_INT5_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_INT5_MI2S_IBIT),
+	[LPASS_CLK_ID_INT6_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_INT6_MI2S_IBIT),
+	[LPASS_CLK_ID_QUI_MI2S_OSR] = Q6AFE_CLK(LPASS_CLK_ID_QUI_MI2S_OSR),
+	[LPASS_CLK_ID_PRI_PCM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_PRI_PCM_IBIT),
+	[LPASS_CLK_ID_PRI_PCM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_PRI_PCM_EBIT),
+	[LPASS_CLK_ID_SEC_PCM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEC_PCM_IBIT),
+	[LPASS_CLK_ID_SEC_PCM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEC_PCM_EBIT),
+	[LPASS_CLK_ID_TER_PCM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_TER_PCM_IBIT),
+	[LPASS_CLK_ID_TER_PCM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_TER_PCM_EBIT),
+	[LPASS_CLK_ID_QUAD_PCM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUAD_PCM_IBIT),
+	[LPASS_CLK_ID_QUAD_PCM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUAD_PCM_EBIT),
+	[LPASS_CLK_ID_QUIN_PCM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUIN_PCM_IBIT),
+	[LPASS_CLK_ID_QUIN_PCM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUIN_PCM_EBIT),
+	[LPASS_CLK_ID_QUI_PCM_OSR] = Q6AFE_CLK(LPASS_CLK_ID_QUI_PCM_OSR),
+	[LPASS_CLK_ID_PRI_TDM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_PRI_TDM_IBIT),
+	[LPASS_CLK_ID_PRI_TDM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_PRI_TDM_EBIT),
+	[LPASS_CLK_ID_SEC_TDM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEC_TDM_IBIT),
+	[LPASS_CLK_ID_SEC_TDM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEC_TDM_EBIT),
+	[LPASS_CLK_ID_TER_TDM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_TER_TDM_IBIT),
+	[LPASS_CLK_ID_TER_TDM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_TER_TDM_EBIT),
+	[LPASS_CLK_ID_QUAD_TDM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUAD_TDM_IBIT),
+	[LPASS_CLK_ID_QUAD_TDM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUAD_TDM_EBIT),
+	[LPASS_CLK_ID_QUIN_TDM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUIN_TDM_IBIT),
+	[LPASS_CLK_ID_QUIN_TDM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUIN_TDM_EBIT),
+	[LPASS_CLK_ID_QUIN_TDM_OSR] = Q6AFE_CLK(LPASS_CLK_ID_QUIN_TDM_OSR),
+	[LPASS_CLK_ID_MCLK_1] = Q6AFE_CLK(LPASS_CLK_ID_MCLK_1),
+	[LPASS_CLK_ID_MCLK_2] = Q6AFE_CLK(LPASS_CLK_ID_MCLK_2),
+	[LPASS_CLK_ID_MCLK_3] = Q6AFE_CLK(LPASS_CLK_ID_MCLK_3),
+	[LPASS_CLK_ID_MCLK_4] = Q6AFE_CLK(LPASS_CLK_ID_MCLK_4),
+	[LPASS_CLK_ID_INTERNAL_DIGITAL_CODEC_CORE] =
+		Q6AFE_CLK(LPASS_CLK_ID_INTERNAL_DIGITAL_CODEC_CORE),
+	[LPASS_CLK_ID_INT_MCLK_0] = Q6AFE_CLK(LPASS_CLK_ID_INT_MCLK_0),
+	[LPASS_CLK_ID_INT_MCLK_1] = Q6AFE_CLK(LPASS_CLK_ID_INT_MCLK_1),
+	[LPASS_CLK_ID_WSA_CORE_MCLK] = Q6AFE_CLK(LPASS_CLK_ID_WSA_CORE_MCLK),
+	[LPASS_CLK_ID_WSA_CORE_NPL_MCLK] =
+				Q6AFE_CLK(LPASS_CLK_ID_WSA_CORE_NPL_MCLK),
+	[LPASS_CLK_ID_VA_CORE_MCLK] = Q6AFE_CLK(LPASS_CLK_ID_VA_CORE_MCLK),
+	[LPASS_CLK_ID_TX_CORE_MCLK] = Q6AFE_CLK(LPASS_CLK_ID_TX_CORE_MCLK),
+	[LPASS_CLK_ID_TX_CORE_NPL_MCLK] =
+			Q6AFE_CLK(LPASS_CLK_ID_TX_CORE_NPL_MCLK),
+	[LPASS_CLK_ID_RX_CORE_MCLK] = Q6AFE_CLK(LPASS_CLK_ID_RX_CORE_MCLK),
+	[LPASS_CLK_ID_RX_CORE_NPL_MCLK] =
+				Q6AFE_CLK(LPASS_CLK_ID_RX_CORE_NPL_MCLK),
+	[LPASS_CLK_ID_VA_CORE_2X_MCLK] =
+				Q6AFE_CLK(LPASS_CLK_ID_VA_CORE_2X_MCLK),
+	[LPASS_HW_AVTIMER_VOTE] = Q6AFE_VOTE_CLK(LPASS_HW_AVTIMER_VOTE,
+						 Q6AFE_LPASS_CORE_AVTIMER_BLOCK,
+						 "LPASS_AVTIMER_MACRO"),
+	[LPASS_HW_MACRO_VOTE] = Q6AFE_VOTE_CLK(LPASS_HW_MACRO_VOTE,
+						Q6AFE_LPASS_CORE_HW_MACRO_BLOCK,
+						"LPASS_HW_MACRO"),
+	[LPASS_HW_DCODEC_VOTE] = Q6AFE_VOTE_CLK(LPASS_HW_DCODEC_VOTE,
+					Q6AFE_LPASS_CORE_HW_DCODEC_BLOCK,
+					"LPASS_HW_DCODEC"),
+};
+
+static struct clk_hw *q6afe_of_clk_hw_get(struct of_phandle_args *clkspec,
+					  void *data)
+{
+	struct q6afe_cc *cc = data;
+	unsigned int idx = clkspec->args[0];
+	unsigned int attr = clkspec->args[1];
+
+	if (idx >= cc->num_clks || attr > LPASS_CLK_ATTRIBUTE_COUPLE_DIVISOR) {
+		dev_err(cc->dev, "Invalid clk specifier (%d, %d)\n", idx, attr);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (cc->clks[idx]) {
+		cc->clks[idx]->attributes = attr;
+		return &cc->clks[idx]->hw;
+	}
+
+	return ERR_PTR(-ENOENT);
+}
+
+static int q6afe_clock_dev_probe(struct platform_device *pdev)
+{
+	struct q6afe_cc *cc;
+	struct device *dev = &pdev->dev;
+	int i, ret;
+
+	cc = devm_kzalloc(dev, sizeof(*cc), GFP_KERNEL);
+	if (!cc)
+		return -ENOMEM;
+
+	cc->clks = &q6afe_clks[0];
+	cc->num_clks = ARRAY_SIZE(q6afe_clks);
+	for (i = 0; i < ARRAY_SIZE(q6afe_clks); i++) {
+		if (!q6afe_clks[i])
+			continue;
+
+		q6afe_clks[i]->dev = dev;
+
+		ret = devm_clk_hw_register(dev, &q6afe_clks[i]->hw);
+		if (ret)
+			return ret;
+	}
+
+	ret = of_clk_add_hw_provider(dev->of_node, q6afe_of_clk_hw_get, cc);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(dev, cc);
+
+	return 0;
+}
+
+static const struct of_device_id q6afe_clock_device_id[] = {
+	{ .compatible = "qcom,q6afe-clocks" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, q6afe_clock_device_id);
+
+static struct platform_driver q6afe_clock_platform_driver = {
+	.driver = {
+		.name = "q6afe-clock",
+		.of_match_table = of_match_ptr(q6afe_clock_device_id),
+	},
+	.probe = q6afe_clock_dev_probe,
+};
+module_platform_driver(q6afe_clock_platform_driver);
+
+MODULE_DESCRIPTION("Q6 Audio Frontend clock driver");
+MODULE_LICENSE("GPL v2");
-- 
2.21.0

