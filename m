Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8868C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E9820730
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQB1quuu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgDII6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 04:58:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45066 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgDII6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 04:58:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id w11so516306pga.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 01:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=oU1SD0/H2uFcMVlkfJZK0TPjnOK4yvBSFYiaVddiQBs=;
        b=eQB1quuuNCnbuszNLZq5C4v9ObB3vpVxfyBN7YbqpY/tdFfJM0ZH+Z6kGaCU1KyCwA
         oQL5ILPSOB8OLPRrcnzMepJq//HqoJj0BsKCZNoBphaIxrjWrjZOemIRzQs4AR8B8Y4n
         xCTC0+VRhGafFP47eDaza5ZdZMKRU1A6pPswGprcH+9CjE94KA41CNnnDkx5/cYTaPBO
         1s/ddv70jXS7M4oOKJ7sI+NEUhr7dP+aDrwaHip7Wcv1V0+aLuT5wUiRNOIJpSr5QeIJ
         HRf6OdsuFaaycPp+oFN5iIE7SdShy4iyS5/y8vHsRnpa22DXMA/IC16N0/4kboa+x5dV
         icMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=oU1SD0/H2uFcMVlkfJZK0TPjnOK4yvBSFYiaVddiQBs=;
        b=Iq0bVSYHPYub1zmpNWGA+VLC+lg78gIY1JjdPf1STpy4OlEFsLxk2GeRMYQinr1d3w
         2zHqBcsCbQueOJXS//AdcHfsEi0h6muvgMLsdL74fjcTJVUSdIZkxzaHgW9qFJjd2hYC
         2np353P7nlw9hh/l5JfukZtDRDIbOYJbxdkbyQU/8n5j/9bZ7zys21TvG0LkXyseKySe
         WDhxB6Z7uEuKyjYNqod/r4KATOzZZkxtuesFoELyWuvuJMImqPkBkA9WhIHjmCzoDKG/
         KQJYt+aS/nRcLLVyoRy4n8nXxBcsDb9QLnCIiHCb0DwN8THu2LLvUEuaDv4Pk14K8eaB
         0yEQ==
X-Gm-Message-State: AGi0Pub9+n8BMxyoFiZy6kGsVAjmEKw/KhUhvMtyqOxHX30s35TV9L9m
        WmCburoPy2V+VQ5Fz8wCDywOIGqv
X-Google-Smtp-Source: APiQypKLXbbNZP+LHdpL9FcYf++f9Mwp/jtMmbPtysRBYBA9SyTTilnrtKkSV1z/UavNWQP1Jif/Zw==
X-Received: by 2002:a63:e708:: with SMTP id b8mr2703800pgi.128.1586422700609;
        Thu, 09 Apr 2020 01:58:20 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id s9sm1561712pjr.5.2020.04.09.01.58.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2020 01:58:20 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     lee.jones@linaro.org, arnd@arndb.de, broonie@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] regmap: Add reg_update_bits() support
Date:   Thu,  9 Apr 2020 16:57:58 +0800
Message-Id: <f48d3b98debe5b2c1cc9a384874d6032b051a4c5.1586422035.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1586422035.git.baolin.wang7@gmail.com>
References: <cover.1586422035.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1586422035.git.baolin.wang7@gmail.com>
References: <cover.1586422035.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reg_update_bits() support in case some platforms use a special method
to update bits of registers.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/base/regmap/regmap-mmio.c | 29 ++++++++++++++++++++++++++++-
 drivers/base/regmap/regmap.c      |  1 +
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index af967d8..dae0d28 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -24,6 +24,8 @@ struct regmap_mmio_context {
 			  unsigned int reg, unsigned int val);
 	unsigned int (*reg_read)(struct regmap_mmio_context *ctx,
 			         unsigned int reg);
+	int (*reg_update_bits)(void *ctx, unsigned int reg,
+			       unsigned int mask, unsigned int val);
 };
 
 static int regmap_mmio_regbits_check(size_t reg_bits)
@@ -188,6 +190,26 @@ static int regmap_mmio_read(void *context, unsigned int reg, unsigned int *val)
 	return 0;
 }
 
+static int regmap_mmio_update_bits(void *context, unsigned int reg,
+				   unsigned int mask, unsigned int val)
+{
+	struct regmap_mmio_context *ctx = context;
+	int ret;
+
+	if (!IS_ERR(ctx->clk)) {
+		ret = clk_enable(ctx->clk);
+		if (ret < 0)
+			return ret;
+	}
+
+	ctx->reg_update_bits(ctx->regs, reg, mask, val);
+
+	if (!IS_ERR(ctx->clk))
+		clk_disable(ctx->clk);
+
+	return 0;
+}
+
 static void regmap_mmio_free_context(void *context)
 {
 	struct regmap_mmio_context *ctx = context;
@@ -200,7 +222,7 @@ static void regmap_mmio_free_context(void *context)
 	kfree(context);
 }
 
-static const struct regmap_bus regmap_mmio = {
+static struct regmap_bus regmap_mmio = {
 	.fast_io = true,
 	.reg_write = regmap_mmio_write,
 	.reg_read = regmap_mmio_read,
@@ -239,6 +261,11 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
 	ctx->val_bytes = config->val_bits / 8;
 	ctx->clk = ERR_PTR(-ENODEV);
 
+	if (config->reg_update_bits) {
+		ctx->reg_update_bits = config->reg_update_bits;
+		regmap_mmio.reg_update_bits = regmap_mmio_update_bits;
+	}
+
 	switch (regmap_get_val_endian(dev, &regmap_mmio, config)) {
 	case REGMAP_ENDIAN_DEFAULT:
 	case REGMAP_ENDIAN_LITTLE:
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 59f911e..553d92a 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -827,6 +827,7 @@ struct regmap *__regmap_init(struct device *dev,
 	} else if (!bus->read || !bus->write) {
 		map->reg_read = _regmap_bus_reg_read;
 		map->reg_write = _regmap_bus_reg_write;
+		map->reg_update_bits = bus->reg_update_bits;
 
 		map->defer_caching = false;
 		goto skip_format_initialization;
-- 
1.9.1

