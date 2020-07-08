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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FF5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4437020672
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAMHRJDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgGHHyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgGHHyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:54:31 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9646C08C5DC;
        Wed,  8 Jul 2020 00:54:30 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id o4so26326195lfi.7;
        Wed, 08 Jul 2020 00:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/jl62OZFRaBXK2/dmdRMLJsJwf4NRpbhjRcdOXNNqbY=;
        b=lAMHRJDgum/Jh1ws2Iw+TCOnv09JCdkrPBc45igIzOU90d9aFNdqFVX9mtwGxoB6kW
         KfgmUT+o/aUy6iXqMT8wLHqT8HydyIrYzYzwNDpJB67hlbd0XAa5T+bbLoRjgM4vr5MJ
         nB1vqwSvlFozXY1KgaResRzPLDBQCPyBBGawmu8H43X/MZ/9V9BMUojVPdAmKY2IR4qH
         e9FTgxFEP2czLPYtKtYByonOFopbDyU4QCQP1JDPO4wIeU5R8RyehpZs2/g/SO9HDEtT
         OJ2lHUbVsDlgsNVFPk/lamhiO8rn8SnHB/F4k0Dpj+54SJwMoc/n1C/m72g6tITQeypN
         Jm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/jl62OZFRaBXK2/dmdRMLJsJwf4NRpbhjRcdOXNNqbY=;
        b=BNJfnlv2JnRgfuhTFRDpegTjheNqAQJynz0Le7Arw0S0OzCxvzlGaCRjkfUSCVgVV8
         rfHDNr4r3MHpm5xtNphgZeVTlkeanw+T/TnHJ5TxTXqAB2xeHHAvatGKPz6mBpNSjipg
         c4nLjAZaAyamBmcucxA+6aj5m3bAIpu8T4Gx8lp4wXaCpPyGiWewZ4nVF5R9TSMPNHm6
         x9TxZUwM6kIYMkz7ZdtLLwwYSXuqPSI8hfbT45ZL7Xrd1JvgjgZAidkQXkhqhefTmGZB
         RRijLJODrr6KiZeMuAGWbePhwRWFZV+5HhF4XgkgjXwBphNS4vbtI4Wv+sE0hmVXvQfc
         2DjQ==
X-Gm-Message-State: AOAM532faIymdjdi5u+jPW0NarW7fAPkLcRHe4fIT3ZS2t5GFIk0Et6R
        Rh71ChpgpD99cIJ9LP4yvqg=
X-Google-Smtp-Source: ABdhPJzB3H8obzShnXD7Tkeqax0A0F17bqkMRwCpDKHUYza87vEYIw86K349BqyG8/M2K90wWnTsEg==
X-Received: by 2002:a05:6512:303:: with SMTP id t3mr35282302lfp.159.1594194869447;
        Wed, 08 Jul 2020 00:54:29 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-105.pppoe.mtu-net.ru. [91.79.162.105])
        by smtp.gmail.com with ESMTPSA id j4sm10175604lfb.94.2020.07.08.00.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 00:54:28 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] clk: tegra: pll: Improve PLLM enable-state detection
Date:   Wed,  8 Jul 2020 10:54:18 +0300
Message-Id: <20200708075418.25295-1-digetx@gmail.com>
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

v3: - Dropped unintended code change that was accidentally added to v2.

v2: - Added clarifying comment to the code.

    - Prettified the code.

 drivers/clk/tegra/clk-pll.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index b2d39a66f0fa..37cfcd6836c9 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -327,16 +327,26 @@ int tegra_pll_wait_for_lock(struct tegra_clk_pll *pll)
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
 
-- 
2.26.0

