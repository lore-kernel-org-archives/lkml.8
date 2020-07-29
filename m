Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE65C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 307942083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Eo+0w9c4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgG2PoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbgG2PoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:44:09 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF01C0619D4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:44:09 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a14so22119503wra.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CQIn+VEpnEWmSg9hS5AE3VgFC5CX71fT+x9MqwA/nSI=;
        b=Eo+0w9c4wPP7x+MiwaxTzJX484Ai6UmktMd8hl2Q5Eu7JdW4RcKGROLAIeJ5MoIQV7
         SZcw9L4eFS3ufCY7FdWL6qdbbUhqqMv6kq8e+lMtk0B8HsVV1NzGj9IQHgXOVNmfbF0M
         OUJ/zIkQq+hDQd4iUqTxiwsL5SAiAApARsYsD74qqaC4Y+obzj0AoV4o1diNM3v7SLv4
         BVSrUDX06j9FXxvYq2WM+PBBHSvDwOYZZcNy67cs4+O7DWffIQ0YR4FXK/eGvUPdkjEu
         PtXZLqU9kaZ+ojo7qYMIcESGpKDoKrMkwi3d7AcS3h+7Fho57bOiamNQkQVRChsYf6p5
         JI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CQIn+VEpnEWmSg9hS5AE3VgFC5CX71fT+x9MqwA/nSI=;
        b=j0X/yj4ddeB25OwgMgc7dEuG9zTUhlHUq6wurNyWBMraZPV0xHZUxAFqz677tKO9ml
         Epj4lm7hKLbEviqG9HE70UbSOf9gbEclyVQdhlc7Hx8Td29dDlyDnzRPNtyGuKBJjvW2
         nufE7KpevXYLY7Md4JrPknyEuU4ffS9h8K/yaKdax6PQ22afYOor5uQcqFqe33lsHPg2
         0Lhxbsz3scynt+Gdor2hD/T2vTtpcrD3cG4Mn4XEJ7E/+x3vWVgBHDdSDeGtFiLdfoI2
         EPxN/xe2+VobbpjTagD9tXEM9H42cLFNeR/F6pAJdOk06t+lzhHiprgu3Hnq6kqLbapo
         C1Zg==
X-Gm-Message-State: AOAM531qcRLjeQXj6IOsRL8L7PTbEvNvXeJe5tmsktUZZA3Oyd1oEIRM
        uIhJVDOn+UMOeNXFLBRGh1BxLg==
X-Google-Smtp-Source: ABdhPJyA5nUpAfKxBwT5CUr30zbViSnYuF9A6uKhawAchbArA6W9CY8esvozk1vQl5v9DuoiBTeTiA==
X-Received: by 2002:adf:de8d:: with SMTP id w13mr29665660wrl.129.1596037447519;
        Wed, 29 Jul 2020 08:44:07 -0700 (PDT)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a134sm6526030wmd.17.2020.07.29.08.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 08:44:06 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, linux-clk@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] clk: meson: add sclk-ws driver
Date:   Wed, 29 Jul 2020 17:43:57 +0200
Message-Id: <20200729154359.1983085-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200729154359.1983085-1-jbrunet@baylibre.com>
References: <20200729154359.1983085-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is yet another simple but odd driver for the audio block of the g12a
and sm1 SoC families.

For TDMOUT's sclk to be properly inverted, bit 29 of
AUDIO_CLK_TDMOUT_x_CTRL should be the inverse of bit 28.
IOW bit28 == !bit29 at all times

This setting is automatically applied on axg and the manual setting was
added on g12a.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/clk-phase.c | 56 +++++++++++++++++++++++++++++++++++
 drivers/clk/meson/clk-phase.h |  6 ++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/clk/meson/clk-phase.c b/drivers/clk/meson/clk-phase.c
index fe22e171121a..a6763439f7d2 100644
--- a/drivers/clk/meson/clk-phase.c
+++ b/drivers/clk/meson/clk-phase.c
@@ -125,6 +125,62 @@ const struct clk_ops meson_clk_triphase_ops = {
 };
 EXPORT_SYMBOL_GPL(meson_clk_triphase_ops);
 
+/*
+ * This is a special clock for the audio controller.
+ * This drive a bit clock inverter for which the
+ * opposite value of the inverter bit needs to be manually
+ * set into another bit
+ */
+static inline struct meson_sclk_ws_inv_data *
+meson_sclk_ws_inv_data(struct clk_regmap *clk)
+{
+	return (struct meson_sclk_ws_inv_data *)clk->data;
+}
+
+static int meson_sclk_ws_inv_sync(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_sclk_ws_inv_data *tph = meson_sclk_ws_inv_data(clk);
+	unsigned int val;
+
+	/* Get phase and sync the inverted value to ws */
+	val = meson_parm_read(clk->map, &tph->ph);
+	meson_parm_write(clk->map, &tph->ws, val ? 0 : 1);
+
+	return 0;
+}
+
+static int meson_sclk_ws_inv_get_phase(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_sclk_ws_inv_data *tph = meson_sclk_ws_inv_data(clk);
+	unsigned int val;
+
+	val = meson_parm_read(clk->map, &tph->ph);
+
+	return meson_clk_degrees_from_val(val, tph->ph.width);
+}
+
+static int meson_sclk_ws_inv_set_phase(struct clk_hw *hw, int degrees)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_sclk_ws_inv_data *tph = meson_sclk_ws_inv_data(clk);
+	unsigned int val;
+
+	val = meson_clk_degrees_to_val(degrees, tph->ph.width);
+	meson_parm_write(clk->map, &tph->ph, val);
+	meson_parm_write(clk->map, &tph->ws, val ? 0 : 1);
+	return 0;
+}
+
+const struct clk_ops meson_sclk_ws_inv_ops = {
+	.init		= meson_sclk_ws_inv_sync,
+	.get_phase	= meson_sclk_ws_inv_get_phase,
+	.set_phase	= meson_sclk_ws_inv_set_phase,
+};
+EXPORT_SYMBOL_GPL(meson_sclk_ws_inv_ops);
+
+
 MODULE_DESCRIPTION("Amlogic phase driver");
 MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/clk-phase.h b/drivers/clk/meson/clk-phase.h
index 5579f9ced142..b637b9b227bc 100644
--- a/drivers/clk/meson/clk-phase.h
+++ b/drivers/clk/meson/clk-phase.h
@@ -20,7 +20,13 @@ struct meson_clk_triphase_data {
 	struct parm ph2;
 };
 
+struct meson_sclk_ws_inv_data {
+	struct parm ph;
+	struct parm ws;
+};
+
 extern const struct clk_ops meson_clk_phase_ops;
 extern const struct clk_ops meson_clk_triphase_ops;
+extern const struct clk_ops meson_sclk_ws_inv_ops;
 
 #endif /* __MESON_CLK_PHASE_H */
-- 
2.25.4

