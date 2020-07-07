Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0249FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE5D220738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UD8JHih7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgGGOii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbgGGOi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:38:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68004C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:38:26 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 17so46727538wmo.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mkgQ5GKpYIPow7Og+7iz9PKlHm4fJKjWVXLF1XFMGh8=;
        b=UD8JHih7QFQAexNXEPUo9QYy4IoMnlLOWLAdsLS0W1nfVGjTq8naimB7im8Phva+RS
         gUUau5HQAMqWLa8YccTr+ow/31k7oHbGvHF5Q/eORpoCsfrYCZ7lOaJ8RzJefh4U3D2D
         PO7tDIF64lZSWfAZsj1I5JyRtDE5LfWqPZltzGBMm7PINEPCfa+tUMwFURt40Ii8wuxn
         /s14XFW1u1fIPanTA+lvRHot2g3gCpv8+2e+01HJOSRiv6j3ooFzsqzsJk27PvXe7IEb
         Q/gPy1PztvuOr6cQqdKmVXjnN+TKN+N08yu2Wwy3fShpP+7bPvUTHqH0a9BB0enQJW0I
         8KYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mkgQ5GKpYIPow7Og+7iz9PKlHm4fJKjWVXLF1XFMGh8=;
        b=OMw21vUxbkEZvosNwCXS2t+IK1VX8DQfrFbNri6sABdM+hIHQfY0S/fMwBb7XCEUH6
         Ba21icG8obtq35UJ9rROrVTK2D/qUspfpEnaxM/NRmy7toVNbeydpOBiQ3dcrPval895
         AXMk5N5FQ6BQZ78nVo3oExZURuDP0b+PgEAG8W+Yew78Q29+bMK8Y8YuZXYzwCueNghb
         lJgg6ZUGg15ZpMHE1qWFoI4GDYqXghGWuiLu7NnvB/RVau0i+pKYh7/ruLtgoTY3EQEG
         As+L9gpnbXMliPiK7JUP+JxjwnT1drTvs43fRE2AptL+RgvgTasCHAggx3HXaZhnYVat
         5Iog==
X-Gm-Message-State: AOAM531iF8oX8gH9sJpi9TNoygKrv2pkGqAuyMlkS8hKt9VBQ7myaE/B
        mF8rLnGP+7x8U2e8BesuwWdvhg==
X-Google-Smtp-Source: ABdhPJyaIhhN2E+kYZJHBX3tAa5DHpsKH/SpQGqIHITspt1DcfTehPuTLvLmz0TYDCWQ5N+3uaJdww==
X-Received: by 2002:a05:600c:2187:: with SMTP id e7mr4500355wme.171.1594132705122;
        Tue, 07 Jul 2020 07:38:25 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:38:24 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        patches@opensource.cirrus.com
Subject: [PATCH v2 28/28] ASoC: codecs: wm8400: Remove a bunch of unused variables
Date:   Tue,  7 Jul 2020 15:37:42 +0100
Message-Id: <20200707143742.2959960-29-lee.jones@linaro.org>
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

Fixes the following W=1 kernel build warning(s):

 sound/soc/codecs/wm8400.c:443:38: warning: ‘wm8400_dapm_rxvoice_controls’ defined but not used [-Wunused-const-variable=]
 443 | static const struct snd_kcontrol_new wm8400_dapm_rxvoice_controls[] = {
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
 In file included from include/sound/tlv.h:10,
 from sound/soc/codecs/wm8400.c:26:
 sound/soc/codecs/wm8400.c:78:35: warning: ‘out_omix_tlv’ defined but not used [-Wunused-const-variable=]
 78 | static const DECLARE_TLV_DB_SCALE(out_omix_tlv, -600, 0, 0);
 | ^~~~~~~~~~~~
 include/uapi/sound/tlv.h:64:15: note: in definition of macro ‘SNDRV_CTL_TLVD_DECLARE_DB_SCALE’
 64 | unsigned int name[] = { | ^~~~
 sound/soc/codecs/wm8400.c:78:14: note: in expansion of macro ‘DECLARE_TLV_DB_SCALE’
 78 | static const DECLARE_TLV_DB_SCALE(out_omix_tlv, -600, 0, 0);
 | ^~~~~~~~~~~~~~~~~~~~
 sound/soc/codecs/wm8400.c:70:35: warning: ‘rec_mix_tlv’ defined but not used [-Wunused-const-variable=]
 70 | static const DECLARE_TLV_DB_SCALE(rec_mix_tlv, -1500, 600, 0);
 | ^~~~~~~~~~~
 include/uapi/sound/tlv.h:64:15: note: in definition of macro ‘SNDRV_CTL_TLVD_DECLARE_DB_SCALE’
 64 | unsigned int name[] = { | ^~~~
 sound/soc/codecs/wm8400.c:70:14: note: in expansion of macro ‘DECLARE_TLV_DB_SCALE’
 70 | static const DECLARE_TLV_DB_SCALE(rec_mix_tlv, -1500, 600, 0);
 | ^~~~~~~~~~~~~~~~~~~~

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: patches@opensource.cirrus.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/codecs/wm8400.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index 2551eb0f1868c..35ffa7765c85c 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -67,16 +67,12 @@ static void wm8400_component_reset(struct snd_soc_component *component)
 	wm8400_reset_codec_reg_cache(wm8400->wm8400);
 }
 
-static const DECLARE_TLV_DB_SCALE(rec_mix_tlv, -1500, 600, 0);
-
 static const DECLARE_TLV_DB_SCALE(in_pga_tlv, -1650, 3000, 0);
 
 static const DECLARE_TLV_DB_SCALE(out_mix_tlv, -2100, 0, 0);
 
 static const DECLARE_TLV_DB_SCALE(out_pga_tlv, -7300, 600, 0);
 
-static const DECLARE_TLV_DB_SCALE(out_omix_tlv, -600, 0, 0);
-
 static const DECLARE_TLV_DB_SCALE(out_dac_tlv, -7163, 0, 0);
 
 static const DECLARE_TLV_DB_SCALE(in_adc_tlv, -7163, 1763, 0);
@@ -439,14 +435,6 @@ static SOC_ENUM_SINGLE_DECL(wm8400_ainrmux_enum,
 static const struct snd_kcontrol_new wm8400_dapm_ainrmux_controls =
 SOC_DAPM_ENUM("Route", wm8400_ainrmux_enum);
 
-/* RXVOICE */
-static const struct snd_kcontrol_new wm8400_dapm_rxvoice_controls[] = {
-SOC_DAPM_SINGLE_TLV("LIN4/RXN", WM8400_INPUT_MIXER5, WM8400_LR4BVOL_SHIFT,
-			WM8400_LR4BVOL_MASK, 0, in_mix_tlv),
-SOC_DAPM_SINGLE_TLV("RIN4/RXP", WM8400_INPUT_MIXER6, WM8400_RL4BVOL_SHIFT,
-			WM8400_RL4BVOL_MASK, 0, in_mix_tlv),
-};
-
 /* LOMIX */
 static const struct snd_kcontrol_new wm8400_dapm_lomix_controls[] = {
 SOC_DAPM_SINGLE("LOMIX Right ADC Bypass Switch", WM8400_OUTPUT_MIXER1,
-- 
2.25.1

