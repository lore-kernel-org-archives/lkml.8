Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4270C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E508D2076E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LPyRsBf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgHDAFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgHDAFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:05:34 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC74DC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 17:05:34 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d188so13157776pfd.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 17:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l3OiBOjafm3plPEFte4M6SO56RI7TS2vgkQEyD6y8A0=;
        b=LPyRsBf8uatoR8gWHlPsC/BOs6J+g3iymamTa9IWYe2OXk+e9O1U+kElZtxQYeyY/C
         Eyb660XqBkPshzkYARXpu1veuTlEWBLctTGaZ2TX8ZFi03Mq+fDjaLt9pW05nKWefJuq
         XvNZhcNKkmbYBMGzbXq3C4j6YB6NKPoCc5c7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l3OiBOjafm3plPEFte4M6SO56RI7TS2vgkQEyD6y8A0=;
        b=aO9Vuvi6Hv8TWZ7R9ZIanHLiMHTUB3eJr1E5xnYwjsH6cHKWydTVYrLm+x8zW9uTog
         RexUQmrSVclxd52hjuSelNCgcDX74qwa6Qo3gqyBktT4T2jcFYk03gDMPnXQY9Nbm6jU
         5ZdWjLeGz/p0lVch30YhAGU3we5GdeyqHtEfpdMGgSJrlS6Bp0hHJVGfGtm7yOGm9DDr
         dV9w+cJ2WZmiUrGbpF5CYMu22unSDEMly5YbKuykKd6RMsfWlwcSbBGF5VrCtjj+LL8L
         /BarIGlZ8czkdsGSkfSCz3DjGzMmGnE4qFZL52qH6nVKKaO4I0/1/dzlcMM1NwJL7+Ks
         0HgA==
X-Gm-Message-State: AOAM531hDI4rOng4QriRF2cOmvzZGhpe49J8a3T0P9bXneJJDmWdZoCU
        djZ1TyQIHVUXkf3VrZx5qrXxkPsIYkM=
X-Google-Smtp-Source: ABdhPJyFldD5Jk+BXD0T+4t0RZBnjvyZfqehuzQXAggkI49L/50t4c4PrODhjN5fDmoDfwya8bFnWA==
X-Received: by 2002:a63:8ec8:: with SMTP id k191mr17016302pge.154.1596499534145;
        Mon, 03 Aug 2020 17:05:34 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id e28sm12332756pfl.124.2020.08.03.17.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 17:05:33 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Shuming Fan <shumingf@realtek.com>
Subject: [PATCH 2/3] ASoC: rt5682: Drop usage of __clk_get_name()
Date:   Mon,  3 Aug 2020 17:05:30 -0700
Message-Id: <20200804000531.920688-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200804000531.920688-1-swboyd@chromium.org>
References: <20200804000531.920688-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __clk_get_name() API is deprecated. Use clk_hw_get_name() or
proper registration techniques to avoid it.

Cc: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 sound/soc/codecs/rt5682.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index ed9475f24aec..d8a1973a4624 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2548,7 +2548,7 @@ static unsigned long rt5682_wclk_recalc_rate(struct clk_hw *hw,
 		container_of(hw, struct rt5682_priv,
 			     dai_clks_hw[RT5682_DAI_WCLK_IDX]);
 	struct snd_soc_component *component = rt5682->component;
-	const char * const clk_name = __clk_get_name(hw->clk);
+	const char * const clk_name = clk_hw_get_name(hw);
 
 	if (!rt5682_clk_check(rt5682))
 		return 0;
@@ -2572,7 +2572,7 @@ static long rt5682_wclk_round_rate(struct clk_hw *hw, unsigned long rate,
 		container_of(hw, struct rt5682_priv,
 			     dai_clks_hw[RT5682_DAI_WCLK_IDX]);
 	struct snd_soc_component *component = rt5682->component;
-	const char * const clk_name = __clk_get_name(hw->clk);
+	const char * const clk_name = clk_hw_get_name(hw);
 
 	if (!rt5682_clk_check(rt5682))
 		return -EINVAL;
@@ -2597,7 +2597,7 @@ static int rt5682_wclk_set_rate(struct clk_hw *hw, unsigned long rate,
 			     dai_clks_hw[RT5682_DAI_WCLK_IDX]);
 	struct snd_soc_component *component = rt5682->component;
 	struct clk *parent_clk;
-	const char * const clk_name = __clk_get_name(hw->clk);
+	const char * const clk_name = clk_hw_get_name(hw);
 	int pre_div;
 	unsigned int clk_pll2_out;
 
@@ -2755,33 +2755,31 @@ static int rt5682_register_dai_clks(struct snd_soc_component *component)
 	struct device *dev = component->dev;
 	struct rt5682_priv *rt5682 = snd_soc_component_get_drvdata(component);
 	struct rt5682_platform_data *pdata = &rt5682->pdata;
-	struct clk_init_data init;
 	struct clk *dai_clk;
 	struct clk_lookup *dai_clk_lookup;
 	struct clk_hw *dai_clk_hw;
-	const char *parent_name;
 	int i, ret;
 
 	for (i = 0; i < RT5682_DAI_NUM_CLKS; ++i) {
+		struct clk_init_data init = { };
+
 		dai_clk_hw = &rt5682->dai_clks_hw[i];
 
 		switch (i) {
 		case RT5682_DAI_WCLK_IDX:
 			/* Make MCLK the parent of WCLK */
 			if (rt5682->mclk) {
-				parent_name = __clk_get_name(rt5682->mclk);
-				init.parent_names = &parent_name;
+				init.parent_data = &(struct clk_parent_data){
+					.fw_name = "mclk",
+				};
 				init.num_parents = 1;
-			} else {
-				init.parent_names = NULL;
-				init.num_parents = 0;
 			}
 			break;
 		case RT5682_DAI_BCLK_IDX:
 			/* Make WCLK the parent of BCLK */
-			parent_name = __clk_get_name(
-				rt5682->dai_clks[RT5682_DAI_WCLK_IDX]);
-			init.parent_names = &parent_name;
+			init.parent_hws = &(const struct clk_hw *){
+				&rt5682->dai_clks_hw[RT5682_DAI_WCLK_IDX]
+			};
 			init.num_parents = 1;
 			break;
 		default:
-- 
Sent by a computer, using git, on the internet

