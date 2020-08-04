Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A501EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B37482076E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kSXUbVgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgHDAFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgHDAFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:05:36 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FB4C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 17:05:36 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u10so12383964plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 17:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XYxlPxktLYpTU+ajRvocUmvWDtHWUPhy8uwzwzVSk3I=;
        b=kSXUbVgMYfHIPmXvbDKDf53m5ed9n1Gm6wnE6Vy5a4s1jaI4+9yrAkwN4xh9jxDUCj
         WQlzPLz+ANy+WsdXd6S24HWI0jcEtM+EQeiagJNqQZZIftIkdToSDqBWVkXMifVxXbvd
         gxYItY//3bUQS8cwCayYMupFA/eJoX86S2fbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XYxlPxktLYpTU+ajRvocUmvWDtHWUPhy8uwzwzVSk3I=;
        b=gtyCF3S058PkVxPUo/tpLgJiBtISuBcXCW8/cxq/7jmpieiANBDEqCvcbKN7z7ha+E
         ToNKP1RihDG1vj1UD1j74qh3vG2sYSgLKnX333E8XIvJvCVCQ12g+dRuEUP6vjoJ3pWk
         2xGamYg+n78hhRXIAJJb6+Q1wjyOC+Lg2GID3FFmhol7oK51PORibDANPApe8k629pu1
         RjHzDtWcu+51ynFBIuJ4KxpUpNqqcbMknEjT2WDKGF/UX5MHRrgrCSmR8aqXn/ZwykTG
         eiUiTXtot30LFwgP+6226TKUvXr+sCaa/bhNEXkpVPa7qvAKv1rISse59Zmj5N4LBfhC
         je9g==
X-Gm-Message-State: AOAM533ELrLSFeJ5ITWQdUaSbLmavFD3FTyf0MQgUDItJ5GE891XoKGm
        +yx9M9Hbsxqcq9P/xGnNU6ZZzg==
X-Google-Smtp-Source: ABdhPJy0Kl39KCvp6CQkcZipctw4cxaao9j76i19pk33xNx5VtGJDatjpizlaD3AgEZ9rDJKr/SibQ==
X-Received: by 2002:a17:90a:33e8:: with SMTP id n95mr1683693pjb.183.1596499535212;
        Mon, 03 Aug 2020 17:05:35 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id e28sm12332756pfl.124.2020.08.03.17.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 17:05:34 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Shuming Fan <shumingf@realtek.com>
Subject: [PATCH 3/3] ASoC: rt5682: Use clk_hw based APIs for registration
Date:   Mon,  3 Aug 2020 17:05:31 -0700
Message-Id: <20200804000531.920688-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200804000531.920688-1-swboyd@chromium.org>
References: <20200804000531.920688-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The (new?) style of clk registration uses clk_hw based APIs so that we
can more easily see the difference between clk providers and clk
consumers. Use the clk_hw based APIs to do this and migrate to devm for
the clkdev creation so that we can reduce the amount of code.

Cc: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 sound/soc/codecs/rt5682.c | 47 +++++++++------------------------------
 sound/soc/codecs/rt5682.h |  2 --
 2 files changed, 11 insertions(+), 38 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index d8a1973a4624..bfb26fec7137 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2755,8 +2755,6 @@ static int rt5682_register_dai_clks(struct snd_soc_component *component)
 	struct device *dev = component->dev;
 	struct rt5682_priv *rt5682 = snd_soc_component_get_drvdata(component);
 	struct rt5682_platform_data *pdata = &rt5682->pdata;
-	struct clk *dai_clk;
-	struct clk_lookup *dai_clk_lookup;
 	struct clk_hw *dai_clk_hw;
 	int i, ret;
 
@@ -2784,8 +2782,7 @@ static int rt5682_register_dai_clks(struct snd_soc_component *component)
 			break;
 		default:
 			dev_err(dev, "Invalid clock index\n");
-			ret = -EINVAL;
-			goto err;
+			return -EINVAL;
 		}
 
 		init.name = pdata->dai_clk_names[i];
@@ -2793,39 +2790,26 @@ static int rt5682_register_dai_clks(struct snd_soc_component *component)
 		init.flags = CLK_GET_RATE_NOCACHE | CLK_SET_RATE_GATE;
 		dai_clk_hw->init = &init;
 
-		dai_clk = devm_clk_register(dev, dai_clk_hw);
-		if (IS_ERR(dai_clk)) {
-			dev_warn(dev, "Failed to register %s: %ld\n",
-				 init.name, PTR_ERR(dai_clk));
-			ret = PTR_ERR(dai_clk);
-			goto err;
+		ret = devm_clk_hw_register(dev, dai_clk_hw);
+		if (ret) {
+			dev_warn(dev, "Failed to register %s: %d\n",
+				 init.name, ret);
+			return ret;
 		}
-		rt5682->dai_clks[i] = dai_clk;
 
 		if (dev->of_node) {
 			devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
 						    dai_clk_hw);
 		} else {
-			dai_clk_lookup = clkdev_create(dai_clk, init.name,
-						       "%s", dev_name(dev));
-			if (!dai_clk_lookup) {
-				ret = -ENOMEM;
-				goto err;
-			} else {
-				rt5682->dai_clks_lookup[i] = dai_clk_lookup;
-			}
+			ret = devm_clk_hw_register_clkdev(dev, dai_clk_hw,
+							  init.name,
+							  dev_name(dev));
+			if (ret)
+				return ret;
 		}
 	}
 
 	return 0;
-
-err:
-	do {
-		if (rt5682->dai_clks_lookup[i])
-			clkdev_drop(rt5682->dai_clks_lookup[i]);
-	} while (i-- > 0);
-
-	return ret;
 }
 #endif /* CONFIG_COMMON_CLK */
 
@@ -2882,15 +2866,6 @@ static void rt5682_remove(struct snd_soc_component *component)
 {
 	struct rt5682_priv *rt5682 = snd_soc_component_get_drvdata(component);
 
-#ifdef CONFIG_COMMON_CLK
-	int i;
-
-	for (i = RT5682_DAI_NUM_CLKS - 1; i >= 0; --i) {
-		if (rt5682->dai_clks_lookup[i])
-			clkdev_drop(rt5682->dai_clks_lookup[i]);
-	}
-#endif
-
 	rt5682_reset(rt5682);
 }
 
diff --git a/sound/soc/codecs/rt5682.h b/sound/soc/codecs/rt5682.h
index 6d94327beae5..354acd735ef4 100644
--- a/sound/soc/codecs/rt5682.h
+++ b/sound/soc/codecs/rt5682.h
@@ -1411,8 +1411,6 @@ struct rt5682_priv {
 
 #ifdef CONFIG_COMMON_CLK
 	struct clk_hw dai_clks_hw[RT5682_DAI_NUM_CLKS];
-	struct clk_lookup *dai_clks_lookup[RT5682_DAI_NUM_CLKS];
-	struct clk *dai_clks[RT5682_DAI_NUM_CLKS];
 	struct clk *mclk;
 #endif
 
-- 
Sent by a computer, using git, on the internet

