Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B58C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFAD720738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RJJDMHb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgGGKRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgGGKRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:17:21 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6C4C08C5DF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:17:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f139so45916904wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uo5lua4EqbM6dOWxZ2PX5/59WiGZNeMIYC5zygYLP+w=;
        b=RJJDMHb5PseEHV13fK3dntfY0SifRUv3KOer7kIUTRvgXuZ4xlS45hcCxG5BKlewVC
         3hP+gmb2xP8RQZ4rXrBu7OAMcj1IjYnk/Hq8f5w+JQIvyEKO1gCKJqlBEWxmNCyou+gh
         RVSC+T3bqxktFOZj/7Cj+oOt0FWUcOpX2WZL3ggGMoRNb3BBwPGNOjBsphEau4CyJlWx
         HRhZzBsx+Zeb3zzu6VHY6FFwmBLm0Xf3cA5G6VqXRm+bw6pVJKQSqdh+a+CDvFyxFPZm
         tt7mqjlndBOcwoFBaY1YXUAZ/dYDPaXolLxY/JRUFFiXiX+li4ymLYlyNAFDfkDvl0fJ
         28eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uo5lua4EqbM6dOWxZ2PX5/59WiGZNeMIYC5zygYLP+w=;
        b=g8t6tFVLP/y3IHtv4b2YN8tCZAhiPMAQhiqwzEYYhjdtZ4bHTmvT7bc1gZ1T1SsDDJ
         ShP3kkGg1EKD9tXSmKGjZoIVw5USDMfS/MMmpO70PpY5g7obvqPvJANQPBuqzuXN41kO
         HILACiKkuT96ncLv/dvuxszar4PtnOji2akLu+scjVQYuUhIXJF4ydCEVrXV7NzJzybJ
         bF/899OUvdwneYapsApXZt3f5d3i1mQTRc3IwuuXdV1UEH09JG8jNOEfDuImjWBzmDMe
         Pzu2FIrARzvpYZih2vN59RXZSGXqyIc+uZP6+rWhvC1M+fHdAb9trwJtkgJUhiXOdDcv
         sUlw==
X-Gm-Message-State: AOAM53006oOvcwfI6bzWISQidRI+6WHngB2ZHDRfx1w0SHwU5CoblqVJ
        XmZGojjJDQLftANKeCjMFFtp0A==
X-Google-Smtp-Source: ABdhPJwBZScVrLRaoB2qbt1B7gPdAiGWJE3GpDYVPkVBQkQeuhCY3G1NK1G3mX96r9YIsd6G8GLX1g==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr3392098wmj.136.1594117039808;
        Tue, 07 Jul 2020 03:17:19 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:17:19 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Bard Liao <bardliao@realtek.com>
Subject: [PATCH 26/28] ASoC: codecs: rt5659: Remove many unused const variables
Date:   Tue,  7 Jul 2020 11:16:40 +0100
Message-Id: <20200707101642.1747944-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks as though they've never been used.

Fixes the following W=1 kernel build warning(s):

 In file included from  sound/soc/codecs/rt5659.c:25:
 In file included from sound/soc/codecs/rt5659.c:25:
 sound/soc/codecs/rt5659.c:1232:2: warning: ‘rt5659_ad_monor_asrc_enum’ defined but not used [-Wunused-const-variable=]
 1232 | rt5659_ad_monor_asrc_enum, RT5659_ASRC_3, RT5659_AD_MONO_R_T_SFT, 0x7,
 | ^~~~~~~~~~~~~~~~~~~~~~~~~
 include/sound/soc.h:359:24: note: in definition of macro ‘SOC_VALUE_ENUM_DOUBLE_DECL’
 359 | const struct soc_enum name = SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, | ^~~~
 sound/soc/codecs/rt5659.c:1231:8: note: in expansion of macro ‘SOC_VALUE_ENUM_SINGLE_DECL’
 1231 | static SOC_VALUE_ENUM_SINGLE_DECL(
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~
 sound/soc/codecs/rt5659.c:1228:2: warning: ‘rt5659_ad_monol_asrc_enum’ defined but not used [-Wunused-const-variable=]
 1228 | rt5659_ad_monol_asrc_enum, RT5659_ASRC_3, RT5659_AD_MONO_L_T_SFT, 0x7,
 | ^~~~~~~~~~~~~~~~~~~~~~~~~
 include/sound/soc.h:359:24: note: in definition of macro ‘SOC_VALUE_ENUM_DOUBLE_DECL’
 359 | const struct soc_enum name = SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, | ^~~~
 sound/soc/codecs/rt5659.c:1227:8: note: in expansion of macro ‘SOC_VALUE_ENUM_SINGLE_DECL’
 1227 | static SOC_VALUE_ENUM_SINGLE_DECL(
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~
 sound/soc/codecs/rt5659.c:1224:2: warning: ‘rt5659_ad_sto2_asrc_enum’ defined but not used [-Wunused-const-variable=]
 1224 | rt5659_ad_sto2_asrc_enum, RT5659_ASRC_3, RT5659_AD_STO2_T_SFT, 0x7,
 | ^~~~~~~~~~~~~~~~~~~~~~~~
 include/sound/soc.h:359:24: note: in definition of macro ‘SOC_VALUE_ENUM_DOUBLE_DECL’
 359 | const struct soc_enum name = SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, | ^~~~
 sound/soc/codecs/rt5659.c:1223:8: note: in expansion of macro ‘SOC_VALUE_ENUM_SINGLE_DECL’
 1223 | static SOC_VALUE_ENUM_SINGLE_DECL(
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~
 sound/soc/codecs/rt5659.c:1220:2: warning: ‘rt5659_ad_sto1_asrc_enum’ defined but not used [-Wunused-const-variable=]
 1220 | rt5659_ad_sto1_asrc_enum, RT5659_ASRC_2, RT5659_AD_STO1_T_SFT, 0x7,
 | ^~~~~~~~~~~~~~~~~~~~~~~~
 include/sound/soc.h:359:24: note: in definition of macro ‘SOC_VALUE_ENUM_DOUBLE_DECL’
 359 | const struct soc_enum name = SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, | ^~~~
 sound/soc/codecs/rt5659.c:1219:8: note: in expansion of macro ‘SOC_VALUE_ENUM_SINGLE_DECL’
 1219 | static SOC_VALUE_ENUM_SINGLE_DECL(
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~
 sound/soc/codecs/rt5659.c:1216:2: warning: ‘rt5659_da_monor_asrc_enum’ defined but not used [-Wunused-const-variable=]
 1216 | rt5659_da_monor_asrc_enum, RT5659_ASRC_2, RT5659_DA_MONO_R_T_SFT, 0x7,
 | ^~~~~~~~~~~~~~~~~~~~~~~~~
 include/sound/soc.h:359:24: note: in definition of macro ‘SOC_VALUE_ENUM_DOUBLE_DECL’
 359 | const struct soc_enum name = SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, | ^~~~
 sound/soc/codecs/rt5659.c:1215:8: note: in expansion of macro ‘SOC_VALUE_ENUM_SINGLE_DECL’
 1215 | static SOC_VALUE_ENUM_SINGLE_DECL(
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~
 sound/soc/codecs/rt5659.c:1212:2: warning: ‘rt5659_da_monol_asrc_enum’ defined but not used [-Wunused-const-variable=]
 1212 | rt5659_da_monol_asrc_enum, RT5659_ASRC_2, RT5659_DA_MONO_L_T_SFT, 0x7,
 | ^~~~~~~~~~~~~~~~~~~~~~~~~
 include/sound/soc.h:359:24: note: in definition of macro ‘SOC_VALUE_ENUM_DOUBLE_DECL’
 359 | const struct soc_enum name = SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, | ^~~~
 sound/soc/codecs/rt5659.c:1211:8: note: in expansion of macro ‘SOC_VALUE_ENUM_SINGLE_DECL’
 1211 | static SOC_VALUE_ENUM_SINGLE_DECL(
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~
 sound/soc/codecs/rt5659.c:1208:2: warning: ‘rt5659_da_sto_asrc_enum’ defined but not used [-Wunused-const-variable=]
 1208 | rt5659_da_sto_asrc_enum, RT5659_ASRC_2, RT5659_DA_STO_T_SFT, 0x7,
 | ^~~~~~~~~~~~~~~~~~~~~~~
 include/sound/soc.h:359:24: note: in definition of macro ‘SOC_VALUE_ENUM_DOUBLE_DECL’
 359 | const struct soc_enum name = SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, | ^~~~
 sound/soc/codecs/rt5659.c:1207:8: note: in expansion of macro ‘SOC_VALUE_ENUM_SINGLE_DECL’
 1207 | static SOC_VALUE_ENUM_SINGLE_DECL(
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Oder Chiou <oder_chiou@realtek.com>
Cc: Bard Liao <bardliao@realtek.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/codecs/rt5659.c | 37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 541fc6f1089bb..41e5917b16a5e 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -1195,43 +1195,6 @@ static const struct snd_kcontrol_new rt5659_if3_dac_swap_mux =
 static const struct snd_kcontrol_new rt5659_if3_adc_swap_mux =
 	SOC_DAPM_ENUM("IF3 ADC Swap Source", rt5659_if3_adc_enum);
 
-static const char * const rt5659_asrc_clk_src[] = {
-	"clk_sysy_div_out", "clk_i2s1_track", "clk_i2s2_track",
-	"clk_i2s3_track", "clk_sys2", "clk_sys3"
-};
-
-static unsigned int rt5659_asrc_clk_map_values[] = {
-	0, 1, 2, 3, 5, 6,
-};
-
-static SOC_VALUE_ENUM_SINGLE_DECL(
-	rt5659_da_sto_asrc_enum, RT5659_ASRC_2, RT5659_DA_STO_T_SFT, 0x7,
-	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
-
-static SOC_VALUE_ENUM_SINGLE_DECL(
-	rt5659_da_monol_asrc_enum, RT5659_ASRC_2, RT5659_DA_MONO_L_T_SFT, 0x7,
-	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
-
-static SOC_VALUE_ENUM_SINGLE_DECL(
-	rt5659_da_monor_asrc_enum, RT5659_ASRC_2, RT5659_DA_MONO_R_T_SFT, 0x7,
-	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
-
-static SOC_VALUE_ENUM_SINGLE_DECL(
-	rt5659_ad_sto1_asrc_enum, RT5659_ASRC_2, RT5659_AD_STO1_T_SFT, 0x7,
-	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
-
-static SOC_VALUE_ENUM_SINGLE_DECL(
-	rt5659_ad_sto2_asrc_enum, RT5659_ASRC_3, RT5659_AD_STO2_T_SFT, 0x7,
-	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
-
-static SOC_VALUE_ENUM_SINGLE_DECL(
-	rt5659_ad_monol_asrc_enum, RT5659_ASRC_3, RT5659_AD_MONO_L_T_SFT, 0x7,
-	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
-
-static SOC_VALUE_ENUM_SINGLE_DECL(
-	rt5659_ad_monor_asrc_enum, RT5659_ASRC_3, RT5659_AD_MONO_R_T_SFT, 0x7,
-	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
-
 static int rt5659_hp_vol_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-- 
2.25.1

