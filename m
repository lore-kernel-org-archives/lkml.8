Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223B4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA05206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C0uhEvrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgGGKRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbgGGKRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:17:24 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09821C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:17:24 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q15so42683871wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mkgQ5GKpYIPow7Og+7iz9PKlHm4fJKjWVXLF1XFMGh8=;
        b=C0uhEvrw6Cb6IHyeUQxsYIXDlt3MpDWf+csmiOXGn8Tz+dxr65xSfiRAXDv0HcY7VA
         NvpMy1QsPzCkYFLQA/o8gvCmNN5LUa6IzlRX+YurOnzL/MvvpNS1KRUxqYpOgpLfdjE1
         S2OtbToPGQBg8bUH8J1mfVOMyo4577J/aIDCuTAdvoPMQOHr7bqo4ZA6P7mvSbmnTivp
         QG0NtI5BiM4i5cVDFeBAKf5Ou9B19WCz8jkZYmqAkbgdhl5KYNI6mtDzea4vd0V4DJLI
         uLs+F14Mfcp16TcdvjfEn3NvNcwnkFxvfenN1oYO0taaEW1PJM+hY9kvVQ5vBZcyvZ0W
         JOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mkgQ5GKpYIPow7Og+7iz9PKlHm4fJKjWVXLF1XFMGh8=;
        b=Bli2lRXcWjVeuxI6IIr6V+5yXOR7hFKe/AC6+rInjcIVqOlivgiFouQSS9zNypFNwA
         BXaqvTYENdw1/ANebq2EKKSPhPWUa533UGXSYxfezTZBxJ8CqnNqolnZjdTuLCG/ZDP4
         eL1j1Nml841yPeAcR6zXU+l7xgn+5QzJx7sFxbNlB098IyEDVf9PF0urhNbLGE2MV44g
         GNSBYdH5GqRLNHaZi4P/hkpDyxfIzHFWbydToX2UzL76rjeh/mdDF1gZZXWU24EbaBl+
         5mjhzKx4rbW/Z//K0JqNLPcNhajqzv2qzStUIwUIhgcMy2AO187Uei72+r81QN3Noyu4
         yrqg==
X-Gm-Message-State: AOAM531bTdXH+FD1OrRDCbJKQFqpOvDyfcp5IltrRFCMdaDuy5yWo5rI
        JwV2n0ubkGyRyVmeKpayxuHnXw==
X-Google-Smtp-Source: ABdhPJyfry+2eTSCxNFY+4n4PKf/X6rv1JuST/nCviW5AF3KdytzTgNqbLpj9UGcP7OiMG0Dy8C7Tg==
X-Received: by 2002:a7b:cc08:: with SMTP id f8mr3624996wmh.106.1594117042719;
        Tue, 07 Jul 2020 03:17:22 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:17:22 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        patches@opensource.cirrus.com
Subject: [PATCH 28/28] ASoC: codecs: wm8400: Remove a bunch of unused variables
Date:   Tue,  7 Jul 2020 11:16:42 +0100
Message-Id: <20200707101642.1747944-29-lee.jones@linaro.org>
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

