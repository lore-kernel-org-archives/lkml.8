Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80592C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58BDC2072F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNTtd+Gc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgFJQis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgFJQip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:38:45 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6303DC03E96B;
        Wed, 10 Jun 2020 09:38:45 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 9so3300086ljc.8;
        Wed, 10 Jun 2020 09:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4o9LdKBdQI4Xw0X6DBGZV3+M+KUXZfmXVAd7OspnHY4=;
        b=VNTtd+GcNu8jNRAUDP/kbJWJxCcWxUggQSdsrptXxSwqaRJ2vBUD7J+Wog7Rnocm3i
         xn4cAUnDo4+a4ZLYmwUmgT+Bl+nD5aTfEif/hqsbmAwepfq9RndVekxOvyq3/fMoQPo+
         hSOZcsbZxY9s3mfy5j+vorR9kwJgI9MMzbLukHo5fJjECRMjr2lik0dn/Ph1vXA+eASi
         VEerkrqRyAIYnvJ4ZWHgKhdvWh1LjH5CqqLyGUOoyoXKKjmb2WL60dBE9mfGQjshi8Z0
         Aqq+v5LhyaqHZD8sp8aL892WuLZwU8RqVJ9vCd11OD5pZ0NW5hoK84XCwZam3ti1EMdN
         gkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4o9LdKBdQI4Xw0X6DBGZV3+M+KUXZfmXVAd7OspnHY4=;
        b=sTeWHnl5xaa/0NGDDob9sRZq/hZcaO1RrTGgZhpnkT2UJLOdMS4VbEOa0KWwNLVRel
         ML8gxILtf/RoX4qXYgi9LplMReUc8YO07fymmIez8sQecTAJuvFMynJG7qrNVyuXdBt4
         jVJzqezvHeYVnKxXed3oxmiIHIN2W6S1/Ze4oTPJtpXnJWT03DoeugMZ38v6B3OoqVPX
         wSjINg2JJYg/c9z2vDsKgXbIRmEUgTMktODRiHbJK9r6enowtdFfKgLn8P5zd9KW2xA2
         w4ZcgmwHjOhSuGh7xXmvV/lYMu+J+oCMtyGLtyp06ZVrOrx50xF7r0HFj/xPYHl31fza
         c1ZQ==
X-Gm-Message-State: AOAM531qfP7kUMVHjaVF2IcYLMhnBWrwLMI47zu64i8QjvniielZMUCG
        VlOKnJwmtEVCNprVLFsV8IY=
X-Google-Smtp-Source: ABdhPJypPUuoq+xIcrWQhm7AFGbkqwnRbH7qt2lfZbzVikpJUbJ2EyXU00QIw3EMW1Lfa6ekU7/1yg==
X-Received: by 2002:a2e:94d0:: with SMTP id r16mr2079054ljh.351.1591807123820;
        Wed, 10 Jun 2020 09:38:43 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id k1sm82825lja.27.2020.06.10.09.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 09:38:43 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] clk: tegra: pll: Improve PLLM enable-state detection
Date:   Wed, 10 Jun 2020 19:37:38 +0300
Message-Id: <20200610163738.29304-1-digetx@gmail.com>
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
 drivers/clk/tegra/clk-pll.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index 0b212cf2e794..4fd1edba8caf 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -330,17 +330,18 @@ int tegra_pll_wait_for_lock(struct tegra_clk_pll *pll)
 static int clk_pll_is_enabled(struct clk_hw *hw)
 {
 	struct tegra_clk_pll *pll = to_clk_pll(hw);
+	bool pllm_enabled = true;
 	u32 val;
 
 	if (pll->params->flags & TEGRA_PLLM) {
 		val = readl_relaxed(pll->pmc + PMC_PLLP_WB0_OVERRIDE);
 		if (val & PMC_PLLP_WB0_OVERRIDE_PLLM_OVERRIDE)
-			return val & PMC_PLLP_WB0_OVERRIDE_PLLM_ENABLE ? 1 : 0;
+			pllm_enabled = !!(val & PMC_PLLP_WB0_OVERRIDE_PLLM_ENABLE);
 	}
 
 	val = pll_readl_base(pll);
 
-	return val & PLL_BASE_ENABLE ? 1 : 0;
+	return pllm_enabled && (val & PLL_BASE_ENABLE);
 }
 
 static void _clk_pll_enable(struct clk_hw *hw)
-- 
2.26.0

