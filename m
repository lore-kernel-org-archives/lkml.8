Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1D2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 831EC207D0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOBwKdid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgGIRVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgGIRVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:21:06 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F80C08C5CE;
        Thu,  9 Jul 2020 10:21:06 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id t9so1612084lfl.5;
        Thu, 09 Jul 2020 10:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/iVQVSgsf58pbHgZKUWZQ1AACh3hg+wIWQ4vsAiPv2k=;
        b=oOBwKdidM5tOiSehmim9SjQopmOeNjzRFo/AScTTmCPR+ESbuGzW2Wv1AG226D2g2W
         +dkDbX7lH32PveACfmvrQDWGCt5DANUif6qhL6i5GEVzez0fNE6yjOtYD3LLklFZFuOQ
         uf7CiXzUPy4dNScNtqV8i99R2j4UKxdyPuwqBdGJDlcvwdsCVIEV5iP4E+QO/d4vFCgp
         Q4z20O2gbbqo9Kce4VgbAaroHIDKLHkzFZ0OFjkgJjw0/kPSs3tKuEgDjlEbj8ybP3JO
         ODD4oP0pdDmtfb7b7G+7zR7j01SNyUyOr3bkDaYZEIbCI5pwZXstLqS/Ii1MuWte7+S9
         +DOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/iVQVSgsf58pbHgZKUWZQ1AACh3hg+wIWQ4vsAiPv2k=;
        b=SK3d5d5Xkd+Zjq+OUrOGmynr9kPC46kgG0h8nuKrR4gRQldGnVo6PuYOfXcc6ZcC2g
         vSGTEncAfktdHOZFIlc0TAzf4XwI6Adiv7jEJoWkBMCyNVELGU9jIoD2EsH7cLoIaera
         4Itw+sIDApVpa3tuu25zZ73fHbMa7KDR74lWu2OEIXrFTrOsyGeoE+FJ+UOXFCu4I6Dh
         lqBo8AVde2yadEi3sKETYU9koB/Btlh4sXdwbxKID3StW0yPieVzsLDGtqbrOk2+nYMu
         KhRx1K+AeCAvfYJpMm6dhVu/tJ/ADoqh/vSuZE4h6hfiJ1x8BUHomE8c6X9fpBG4+vyg
         pUDA==
X-Gm-Message-State: AOAM532fJhqCf/zkOmbwRRlfywbSHW6Df9Q/Ye5VlZu3XExRsAUcb6Bc
        hzaFtTOMavwEaH+J3HymKlA=
X-Google-Smtp-Source: ABdhPJzcW59Uzj03ql5tpBAj4o8yToe+DepfciZrigCYQ8TxvGtZRFEjAI607q25HTh6r+/NGs6zOA==
X-Received: by 2002:ac2:5090:: with SMTP id f16mr41751560lfm.86.1594315264523;
        Thu, 09 Jul 2020 10:21:04 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-105.pppoe.mtu-net.ru. [91.79.162.105])
        by smtp.gmail.com with ESMTPSA id o21sm1148921lfo.2.2020.07.09.10.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 10:21:03 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] clk: tegra: pll: Improve PLLM enable-state detection
Date:   Thu,  9 Jul 2020 20:20:57 +0300
Message-Id: <20200709172057.13951-1-digetx@gmail.com>
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

v4: - Renamed pllm_pmc_clk_enabled() to pllm_clk_is_gated_by_pmc() as
      it was suggested by Jon Hunter in the review comment to v3.

v3: - Dropped unintended code change that was accidentally added to v2.

v2: - Added clarifying comment to the code.

    - Prettified the code.

 drivers/clk/tegra/clk-pll.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index b2d39a66f0fa..ff13b371e176 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -327,16 +327,26 @@ int tegra_pll_wait_for_lock(struct tegra_clk_pll *pll)
 	return clk_pll_wait_for_lock(pll);
 }
 
+static bool pllm_clk_is_gated_by_pmc(struct tegra_clk_pll *pll)
+{
+	u32 val = readl_relaxed(pll->pmc + PMC_PLLP_WB0_OVERRIDE);
+
+	return (val & PMC_PLLP_WB0_OVERRIDE_PLLM_OVERRIDE) &&
+	      !(val & PMC_PLLP_WB0_OVERRIDE_PLLM_ENABLE);
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
+	 * PLLM's CaR state is ON and when PLLM isn't gated by PMC.
+	 */
+	if ((pll->params->flags & TEGRA_PLLM) && pllm_clk_is_gated_by_pmc(pll))
+		return 0;
 
 	val = pll_readl_base(pll);
 
-- 
2.26.0

