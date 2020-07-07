Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609FCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A58F206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SJcEfdTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgGGKR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgGGKRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:17:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BA3C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:17:19 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a6so44560017wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ud7YS/nxWFCEKdfNWplmyakfpWkMMmFHvetIuQwMK9A=;
        b=SJcEfdTtluJRJ9drVxAEM084sLA2jjg2omREK8yyLHD5QF4fquunCIC3osGjdY+i8M
         BrPPOXhxhQSpxRhiU4+fbkmi+4dMKtSbB8gYesK+Z9X3T1NqQeLhdRgH2vWDU1cvpE+R
         PYS0ZwS8h1ihPLT3G3c16hhCJ1KBoJG1ZbsPwrXQ1QNq/BicFRrDnZJzAccXitAGMYne
         lPh0gdOFjd2w94WzTScj+7JLsDxkoGXcOyAshHQgtAv+5pB6mE+oZp6R+1uD5ZsUTis8
         eWLozHqgIHEAodALeznoyshSfIRd8qod9GXI8pQkFLJVOp8LwD5JpC5Mc4zMr2ad2Dzl
         HLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ud7YS/nxWFCEKdfNWplmyakfpWkMMmFHvetIuQwMK9A=;
        b=QeGNfjgNhkSZjloUvttHcErq5bWYwJFNkS+EObE38+tqusp1sbM3yQOQmKnxwz5mJV
         flwD4w/xi3PzJmWUUO+fAIGv/P3E0QCvEXRHUenqV6Wj8Yhh+odYD3nVYUUZ9InUfTW1
         9eZjNwFXCTOdi7a+GrfCOaAZOUZkCMWQNMCmjJIbHq5+Hl/eB+v7qTUtUzlzhXoUtnsk
         wBb6BCdyxNGvHKw0uPy0AEaTggNg/EYHsSDGqzaKNrAjT5FQtzdcwvLdNiP6hkH0uAVU
         CFQgtKJjkCu6Ma2+Ga+WS8xTJaH9Hlmhc8a2d0xNpKVya3SJ0864zIxGYzeGi1BlhAXJ
         4qIA==
X-Gm-Message-State: AOAM530rbPc61MhfESdsdArQqExGhn+bc9uTH4w8uJ5PT5nWaxNwNG8f
        W78q3lF5I7SIgbP5dwWXBj6TQg==
X-Google-Smtp-Source: ABdhPJzRh/ancHeMqyP+Io8AG6Q6pzx7xBhbdTVJ+PS2MJdQ9kFHphykVYJVX0M5fqWOZIm7rVI35g==
X-Received: by 2002:adf:f711:: with SMTP id r17mr54294795wrp.409.1594117038542;
        Tue, 07 Jul 2020 03:17:18 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:17:17 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Oder Chiou <oder_chiou@realtek.com>, flove <flove@realtek.com>
Subject: [PATCH 25/28] ASoC: codecs: rt5631: Demote misuse of kerneldoc to standard comment blocks
Date:   Tue,  7 Jul 2020 11:16:39 +0100
Message-Id: <20200707101642.1747944-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
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

