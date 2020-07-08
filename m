Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED6AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96BA520739
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXXNW2Hw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgGHHrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgGHHrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:47:15 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE73C08C5DC;
        Wed,  8 Jul 2020 00:47:15 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b25so49419564ljp.6;
        Wed, 08 Jul 2020 00:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mxS+F39BoFx3/+K2xuOp4+K9JxcDhgJQv7Yws3W7LL4=;
        b=iXXNW2HwCxD3aES0pvd67VRcY29JZnbbf9Q2xCdrxjaHkYaCwp3XRVhVSnUbIU77Eg
         sWDPWWaJWXpsxF4QTmM03uMXOi2cGWIB8UQKML7Tg9HiKwfNIHaXPTFYN/FrWVNXIg+m
         Eph2eS5eGhM+65vGH8bW7R6RqrBj/y+EjuAQOrlIMRe27J+H+vh5d3zteAGYXsFPXIei
         lzgbtx0yRBjGKk3UV9CxGyHQks+QQeW69UQwev0f9UiQWs7ru7hHatnSBiSQkiz1wcHI
         Zbex3y0RGb9DTsdt1h+jWIvVtJihxU3utSqLrEkW2H6DXOPYgFofUEsMTzNQHqP9HYBn
         J+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mxS+F39BoFx3/+K2xuOp4+K9JxcDhgJQv7Yws3W7LL4=;
        b=ViCGL+CseEqbQU64xFlvEH6Ly/kCSkVboMyuhC1JHKxh0/QO9jUQVUJ0a5kYG6wtMn
         TZUgy8O4O59egsChQITqjL6iRi11DDzzP3O0DYEP1cjMGaDT0MqGgVmxPZZHTvbvx4WC
         Wf7e1E3jsGAQf4It9Xfn476Gm6hgxhm6YL65TZiOwMKAvO6Ue0qsRYYLJ3gf07rhgpvy
         lKbnw1ft4YPxMipmkzPBY2ECP2eGBYIlJWcUodTVSaSyEDcR1c8uNXjRPOQTbXAQ04Hs
         +hGKMTXuAiCzOo3PYFvixhv71+OyOiRShtQz7EJ2a+JONH5/3+pPbYt4lKZLVI0npxrH
         8PGQ==
X-Gm-Message-State: AOAM532XLqg/wP/YUxWvvlSrjsT0SU7s1y5rILJ0qxzkswSnvOmLcWxz
        GOgVjtPSQyeGej7owC477WE=
X-Google-Smtp-Source: ABdhPJw1BOO1Ub9pCHAAIIWaqq9Y+Jk3ciQ9Z5kFnro7GyrHUg+wvMPvJ67mQmD4lu1s6M7VlCIytQ==
X-Received: by 2002:a2e:8047:: with SMTP id p7mr34213212ljg.414.1594194433815;
        Wed, 08 Jul 2020 00:47:13 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-105.pppoe.mtu-net.ru. [91.79.162.105])
        by smtp.gmail.com with ESMTPSA id f24sm808339ljc.99.2020.07.08.00.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 00:47:13 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: tegra: pll: Improve PLLM enable-state detection
Date:   Wed,  8 Jul 2020 10:46:28 +0300
Message-Id: <20200708074628.18173-1-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Power Management Controller (PMC) can override the PLLM clock settings,
including the enable-state. Although PMC could only act as a second level
gate, meaning that PLLM needs to be enabled by the Clock and Reset
Controller (CaR) anyways if we want it to be enabled. Hence, when PLLM is
overridden by PMC, it needs to be enabled by CaR and ungated by PMC in
order to be functional. Please note that this patch doesn't fix any known
problem, and thus, it's merely a minor improvement.

Link: https://lore.kernel.org/linux-arm-kernel/20191210120909.GA2703785@ulmo/T/
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2: - Added clarifying comment to the code.

    - Prettified the code.

 drivers/clk/tegra/clk-pll.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index b2d39a66f0fa..f700356efe3e 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -327,20 +327,30 @@ int tegra_pll_wait_for_lock(struct tegra_clk_pll *pll)
 	return clk_pll_wait_for_lock(pll);
 }
 
+static bool pllm_pmc_clk_enabled(struct tegra_clk_pll *pll)
+{
+	u32 val = readl_relaxed(pll->pmc + PMC_PLLP_WB0_OVERRIDE);
+
+	return !(val & PMC_PLLP_WB0_OVERRIDE_PLLM_OVERRIDE) ||
+		(val & PMC_PLLP_WB0_OVERRIDE_PLLM_ENABLE);
+}
+
 static int clk_pll_is_enabled(struct clk_hw *hw)
 {
 	struct tegra_clk_pll *pll = to_clk_pll(hw);
 	u32 val;
 
-	if (pll->params->flags & TEGRA_PLLM) {
-		val = readl_relaxed(pll->pmc + PMC_PLLP_WB0_OVERRIDE);
-		if (val & PMC_PLLP_WB0_OVERRIDE_PLLM_OVERRIDE)
-			return val & PMC_PLLP_WB0_OVERRIDE_PLLM_ENABLE ? 1 : 0;
-	}
+	/*
+	 * Power Management Controller (PMC) can override the PLLM clock
+	 * settings, including the enable-state. The PLLM is enabled when
+	 * PLLM's CaR state is ON and when PLLM isn't disabled by PMC.
+	 */
+	if ((pll->params->flags & TEGRA_PLLM) && !pllm_pmc_clk_enabled(pll))
+		return 0;
 
 	val = pll_readl_base(pll);
 
-	return val & PLL_BASE_ENABLE ? 1 : 0;
+	return val & PLL_BASE_ENABLE;
 }
 
 static void _clk_pll_enable(struct clk_hw *hw)
-- 
2.26.0

