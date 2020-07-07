Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AA6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A6FC20738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdVvmbc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgGGOim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbgGGOiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:38:23 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024B4C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:38:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w3so34318978wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ud7YS/nxWFCEKdfNWplmyakfpWkMMmFHvetIuQwMK9A=;
        b=hdVvmbc6H8PwBoroBapEBPzE9/EFUUU817fbd+RBL7zPFgItN7L4xyOaxhlf1na/8c
         LMBNV+oT5rzwx30qpZ+wDWOjMIjUSaVmx+EmRVFKOvVd7i2lCUFSTzZLyUs73kJUsbwM
         wu6fVue7GztMQ8WruqtI15zrgwytI+/ajgHgzLBEL5m8yLLLpgE8Zq+Qhnm15pWdIyuQ
         oo/DdwXXxK+QqZ0yKA8UD17YV7EHxNTnjWdN17INYOMbbJClegREeHXngIqUB2WpLPeU
         zS8/+WxQ0fm6MiMeJEsqhHGXgy5Bbh4EBspUF3t6Nw035JLN08dX71/lvitC55km0PgS
         rmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ud7YS/nxWFCEKdfNWplmyakfpWkMMmFHvetIuQwMK9A=;
        b=qSUHn/cz6x6zcSabqaJEBaX/rwO0THGCZ+rpOaDdPQBj04i6avXzuWvAbq9xdtZQrd
         7da3xMaqsN/cCztzXfeNGjnVaZENX2p86U/iVauEZLJt2wuxWPZYW0elDTSAR7riSgip
         1fXui+eSEsnEaP+OpW5hbLEaml8mbEbLcTBdoPVga8HbHE3JLuF9aHTEaW15UX6FEor7
         0oocSR0CeBAXEKp7rE89G1k3XioVktofyZaGxdWfvK9iwdzvWNeUwDOVnWRZMVQybhBB
         ZMBOPV5QzgBiRWiFjLy9/Liad5ElyXcCS2hfJW/lGNpS8N7/9F9OueHpZ2+/yMIp/OMc
         0fyQ==
X-Gm-Message-State: AOAM530X9UmWPRJAHUmsBuiYE4scyRFPb63UN5Kj0ExMPG8CGMwZI8J7
        YSd8dt3VPop0nyitFzzKvv6ykw==
X-Google-Smtp-Source: ABdhPJyIynXVm4wMkx4aYF2hvbtr7ah/gc4UneovvHYT7P6LTuGCXP0MOFSEAqHEfIgZ7mJ6vCRLzQ==
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr4748090wmj.112.1594132701677;
        Tue, 07 Jul 2020 07:38:21 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:38:21 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Oder Chiou <oder_chiou@realtek.com>, flove <flove@realtek.com>
Subject: [PATCH v2 25/28] ASoC: codecs: rt5631: Demote misuse of kerneldoc to standard comment blocks
Date:   Tue,  7 Jul 2020 15:37:39 +0100
Message-Id: <20200707143742.2959960-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Little or no attempt has been made to document any of the demoted functions here.

Fixes the following W=1 kernel build warning(s):

 sound/soc/codecs/rt5631.c:72: warning: Function parameter or member 'component' not described in 'rt5631_write_index'
 sound/soc/codecs/rt5631.c:72: warning: Function parameter or member 'reg' not described in 'rt5631_write_index'
 sound/soc/codecs/rt5631.c:72: warning: Function parameter or member 'value' not described in 'rt5631_write_index'
 sound/soc/codecs/rt5631.c:82: warning: Function parameter or member 'component' not described in 'rt5631_read_index'
 sound/soc/codecs/rt5631.c:82: warning: Function parameter or member 'reg' not described in 'rt5631_read_index'
 sound/soc/codecs/rt5631.c:367: warning: Function parameter or member 'component' not described in 'onebit_depop_power_stage'
 sound/soc/codecs/rt5631.c:405: warning: Function parameter or member 'component' not described in 'onebit_depop_mute_stage'
 sound/soc/codecs/rt5631.c:443: warning: Function parameter or member 'component' not described in 'depop_seq_power_stage'
 sound/soc/codecs/rt5631.c:515: warning: Function parameter or member 'component' not described in 'depop_seq_mute_stage'

Cc: Oder Chiou <oder_chiou@realtek.com>
Cc: flove <flove@realtek.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/codecs/rt5631.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index b5184f0e10e34..f1ace236c401e 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -64,7 +64,7 @@ static const struct reg_default rt5631_reg[] = {
 	{ RT5631_PSEUDO_SPATL_CTRL, 0x0553 },
 };
 
-/**
+/*
  * rt5631_write_index - write index register of 2nd layer
  */
 static void rt5631_write_index(struct snd_soc_component *component,
@@ -74,7 +74,7 @@ static void rt5631_write_index(struct snd_soc_component *component,
 	snd_soc_component_write(component, RT5631_INDEX_DATA, value);
 }
 
-/**
+/*
  * rt5631_read_index - read index register of 2nd layer
  */
 static unsigned int rt5631_read_index(struct snd_soc_component *component,
@@ -357,7 +357,7 @@ static int check_adcr_select(struct snd_soc_dapm_widget *source,
 	return !(reg & RT5631_M_MIC2_TO_RECMIXER_R);
 }
 
-/**
+/*
  * onebit_depop_power_stage - auto depop in power stage.
  * @enable: power on/off
  *
@@ -395,7 +395,7 @@ static void onebit_depop_power_stage(struct snd_soc_component *component, int en
 	snd_soc_component_write(component, RT5631_INT_ST_IRQ_CTRL_2, hp_zc);
 }
 
-/**
+/*
  * onebit_depop_mute_stage - auto depop in mute stage.
  * @enable: mute/unmute
  *
@@ -433,7 +433,7 @@ static void onebit_depop_mute_stage(struct snd_soc_component *component, int ena
 	snd_soc_component_write(component, RT5631_INT_ST_IRQ_CTRL_2, hp_zc);
 }
 
-/**
+/*
  * onebit_depop_power_stage - step by step depop sequence in power stage.
  * @enable: power on/off
  *
@@ -505,7 +505,7 @@ static void depop_seq_power_stage(struct snd_soc_component *component, int enabl
 	snd_soc_component_write(component, RT5631_INT_ST_IRQ_CTRL_2, hp_zc);
 }
 
-/**
+/*
  * depop_seq_mute_stage - step by step depop sequence in mute stage.
  * @enable: mute/unmute
  *
-- 
2.25.1

