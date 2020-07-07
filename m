Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3B0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1E9A20738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EkvVhQeZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgGGOie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgGGOiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:38:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4274CC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:38:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o8so43523759wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uo5lua4EqbM6dOWxZ2PX5/59WiGZNeMIYC5zygYLP+w=;
        b=EkvVhQeZcbznKFNyswSPNfIpD0zKHsz7OYbVpSmbN1UoZNh7AB//jJ1rDyTWShSr0g
         hlji9myJ68m3wT3PmKjNfBCeRJgcPprmUP3Ji6FYkBNNvv2lkgj/BtT4DXpSZIlD3vrd
         Qj11Tz1SitZoY4wY7or2PmiJjE05AQzNAxkKROt0u2VBp0Ia1fULkhdkzSixMwMwNKld
         2tCpxhtvORX31gwxMi8CQH4o0+Zh4L6npspKdvTQPeeO3sJK7zyqL7GwADWUon9cuxgW
         lReKFJtZnPkhwndK1255bnN6ss+/scJF7BBXN6bHGE69BrxkluiAz/vTHHSOE1XbFck/
         fy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uo5lua4EqbM6dOWxZ2PX5/59WiGZNeMIYC5zygYLP+w=;
        b=hr1kooReoCksJP5tUdDVRMDzxvsVgdqaCcN7+LqUxG5SR8xe7sMi2Vt8wKSf75d9rp
         qZX4HvL9Ey1H5BrDvXmPRgVmr4cuicCJe73XQpyJTNhZUtttSv/dPzCGAcVS75jwB97h
         r6CGOpNI/rWWA7mhYHPypFMZd0Iwwr5dOa/ws0YkokRTOQmBie3KkBypZXM+TeEyLUfW
         ueWnASCMnfdsVtR2tZLGu5RvxtcGDMg3lf/2iflcph54s9PWLbYuIoJFxhVNmcBfe2xW
         ZP8+DoU7T1laOuptSCoSsKzGHiLIeXhOqRT/3R9mTUrPL6EUdARbq208cBMzB5sg1DaL
         v+/Q==
X-Gm-Message-State: AOAM5320D/ReZL37kYJr9FmCG/0DvmBQYh0RmPq63o/n3jVL4JT+B85v
        Q+LNCqpGNcGmob6XFtURAAyjIJGVPIA=
X-Google-Smtp-Source: ABdhPJz7JLveveXiGAhwhWb1T2d1+Mq9KbtFkHkKS4L32J0B+qK7tacl/+WudhETU2bpnBREID1Alw==
X-Received: by 2002:a1c:5646:: with SMTP id k67mr4722964wmb.61.1594132702903;
        Tue, 07 Jul 2020 07:38:22 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:38:22 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Bard Liao <bardliao@realtek.com>
Subject: [PATCH v2 26/28] ASoC: codecs: rt5659: Remove many unused const variables
Date:   Tue,  7 Jul 2020 15:37:40 +0100
Message-Id: <20200707143742.2959960-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
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

