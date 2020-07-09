Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE797C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9343320708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="Bm+cJZcw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgGINyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgGINye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:54:34 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E5CC08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 06:54:34 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id z63so1801919qkb.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 06:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=acMY/PDEeXIX2iUBf49C2Sg8svQXM/66G883KF7yr14=;
        b=Bm+cJZcw8lBOA1VWMFEuZRinjCzdRz4WsrMdSj8RPciFM2TAVO10U5xCHYrdWCqXe4
         z4Zz9Hna7qm1epZ0bjKszQeIhAXoTUUPBoA6L1yYnz+I4eXH1tIc7eJxioJ6+22L6MQW
         kRFs0D3Q1G+podAogNq+sk0z3uI35NbsRxJ3zSeD2tN9d44Gr6eFOZ7psSJHCS6acAKy
         Nrzn1M7uopQkkSUGgG9F8IadyeYlzmpfsKR4BxplGOwHftKbhr68TpXPtoLQPmPxdqxP
         CdhOKRGuya9Qk7pP0IH5PfqP6hmairkT2LSL87vW032Lc1wkA3UfPaw3w3hDKQ9NyOgj
         buzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=acMY/PDEeXIX2iUBf49C2Sg8svQXM/66G883KF7yr14=;
        b=L2kk451srcy+pvEXRGG7l89HgQe+6hdLdy6LouZGynJwlnOPk3YHOzaX7dz5hF7X2T
         P4eAm7Lw77iEforwd6joDCyyRTOfUYqJxCEbZL14U2RsqyZhbjiHkH9aUbhllm8/kS2B
         mcyHC0s/F2+c1Hv3QFHst9wtEKRj1Ht8qOOLg1Exh7ekhBqbT5r/mKIRP4T2F/WIPN37
         UEb/NHIdtPvHTq47SkFFu2fquIxTdhyb/p0Z38yiPmaH0XTbgxZQXS/UdQ04cQpEitJb
         nbnykmOdj+1KWmkyAJwH5AEfNNN1b1uJkzJXtK3Kxkmxa48A+rBF6yCUK0jsELBmwM+q
         KQXA==
X-Gm-Message-State: AOAM532rEA7Utsa0yonxPx6Yw2TvdDge5P6daNq+t3Ss9dbxkwAbBGc4
        8p/P0kow6O72BdQkFwI8awkpiA==
X-Google-Smtp-Source: ABdhPJw37kH3im5smTGeBCDUSp/SURXzq5WwBzBJ0ebLhKt5prhiL4Fb2+HJM8hrRJso76++VGBqaQ==
X-Received: by 2002:a37:93c1:: with SMTP id v184mr50690654qkd.480.1594302873710;
        Thu, 09 Jul 2020 06:54:33 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id 130sm3632735qkn.82.2020.07.09.06.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 06:54:33 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 05/14] clk: qcom: gcc: remove unnecessary vco_table from SM8150
Date:   Thu,  9 Jul 2020 09:52:36 -0400
Message-Id: <20200709135251.643-6-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200709135251.643-1-jonathan@marek.ca>
References: <20200709135251.643-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fixed alpha pll ops only use it for clamping in round_rate, which is
unnecessary. This is consistent with SM8250 GCC not using vco_table.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/clk/qcom/gcc-sm8150.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
index d7778def37da..8e9b5b3cceaf 100644
--- a/drivers/clk/qcom/gcc-sm8150.c
+++ b/drivers/clk/qcom/gcc-sm8150.c
@@ -34,14 +34,8 @@ enum {
 	P_SLEEP_CLK,
 };
 
-static const struct pll_vco trion_vco[] = {
-	{ 249600000, 2000000000, 0 },
-};
-
 static struct clk_alpha_pll gpll0 = {
 	.offset = 0x0,
-	.vco_table = trion_vco,
-	.num_vco = ARRAY_SIZE(trion_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_TRION],
 	.clkr = {
 		.enable_reg = 0x52000,
@@ -85,8 +79,6 @@ static struct clk_alpha_pll_postdiv gpll0_out_even = {
 
 static struct clk_alpha_pll gpll7 = {
 	.offset = 0x1a000,
-	.vco_table = trion_vco,
-	.num_vco = ARRAY_SIZE(trion_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_TRION],
 	.clkr = {
 		.enable_reg = 0x52000,
@@ -105,8 +97,6 @@ static struct clk_alpha_pll gpll7 = {
 
 static struct clk_alpha_pll gpll9 = {
 	.offset = 0x1c000,
-	.vco_table = trion_vco,
-	.num_vco = ARRAY_SIZE(trion_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_TRION],
 	.clkr = {
 		.enable_reg = 0x52000,
-- 
2.26.1

