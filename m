Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D779AC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 17:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E99207D4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 17:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwS1ofl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgEQRRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 13:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgEQRRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 13:17:45 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2FBC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 10:17:45 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 23so3719612pfy.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 10:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=45o3etKlnOcpUx67t30P22I6OR7Qi1F0VuTYiBHo1QI=;
        b=BwS1ofl7efwZ1PkLEOB4tLZoLqSu1aYUAyW+9Qtpl5OzgwyssSnZf+rJtJjbLsWkGL
         JkxgnV2IN2vrjRLBJYqSJ6kjAN61vc+YhiP0nomwlbUIMIekDAQGsdOsbrrBv+wCf8wR
         PerUJgoS+3oNQjg1nhEYoOH6Q8gfKLgw2SpK3xnrFFjrhFmSpjh/DI3I4T3tAHcPNULo
         EacZpB8J2lpKPLvfU9l7dtOpBoNh6c3h4oZLBBjkpdIsnEOCBbxviHTkZaHpSIrjXAJk
         mh5qY7/mNnAGBjaUKQMEnqVPs+2p5U9tJbeGslv/eHA5xXG3G4QzsssFhSMdgwz55ObG
         98NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=45o3etKlnOcpUx67t30P22I6OR7Qi1F0VuTYiBHo1QI=;
        b=ibq2v8L59gXugWWZ37Q46ajrRbky7fh/CCxkc2rjVXWsd2LXHOfe1yDfNroHfXzfnj
         Ryjv+H0XN5TjjYV8OPTGFjS7RmmlHpIbs1v/8ham8t3kz+JuNmQH4NK6EsbZXWFAiJqz
         T9s0MHZg36d9ONDCQeIHjRrSzPSoOm8Jh2ATYicXpNbDrP9cdv4RnylLYkym7PM1oIjX
         xh3YF3dwU9uY+ThL/XgzgFgVB8lPtv7vHIpF3NXuhOh9KtHqQl2PQbv0IXFG38wxMEmr
         xPljkiywzy0nAW/qibrSTj15026m3sb/D/VewnYtIskPzUAG92FGyk/dT15e18I3A5Dg
         OF8w==
X-Gm-Message-State: AOAM5320X5Ae/2blU0K1rtFMrVpYla/ZVyQ7Rujr2vy+Q5y22t54CfGb
        iM13+plDEWW/gKlTQxeCxD4=
X-Google-Smtp-Source: ABdhPJx4jxMWB6aC6gn5aoUUf8bTpzTRpSK2/fGf5wFDXHYvHHcFDkeR8KPmOn3vNwC0WSVyW9X+mA==
X-Received: by 2002:aa7:9297:: with SMTP id j23mr13001422pfa.15.1589735864535;
        Sun, 17 May 2020 10:17:44 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.googlemail.com with ESMTPSA id n69sm6513900pjc.8.2020.05.17.10.17.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 May 2020 10:17:44 -0700 (PDT)
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>
Subject: [PATCH V1 1/6] staging: greybus: audio: Update snd_jack FW usage as per new APIs
Date:   Sun, 17 May 2020 22:47:16 +0530
Message-Id: <1ee2783b64c68e49880f88457655648ac45bbcb8.1589734179.git.vaibhav.sr@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1589734179.git.vaibhav.sr@gmail.com>
References: <cover.1589734179.git.vaibhav.sr@gmail.com>
In-Reply-To: <cover.1589734179.git.vaibhav.sr@gmail.com>
References: <cover.1589734179.git.vaibhav.sr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_soc_jack APIs are modified in recent kernel versions. This patch
updates the codec driver to resolve the compilation errors related to
jack framework.

Signed-off-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>
---
 drivers/staging/greybus/audio_codec.c | 59 ++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
index 08746c85dea6..ebf8484f0ae7 100644
--- a/drivers/staging/greybus/audio_codec.c
+++ b/drivers/staging/greybus/audio_codec.c
@@ -709,17 +709,29 @@ static struct snd_soc_dai_driver gbaudio_dai[] = {
 };
 
 static int gbaudio_init_jack(struct gbaudio_module_info *module,
-			     struct snd_soc_codec *codec)
+			     struct snd_soc_card *card)
 {
 	int ret;
 
+	struct snd_soc_jack *jack;
+	struct snd_soc_jack_pin *headset, *button;
+
 	if (!module->jack_mask)
 		return 0;
 
 	snprintf(module->jack_name, NAME_SIZE, "GB %d Headset Jack",
 		 module->dev_id);
-	ret = snd_soc_jack_new(codec, module->jack_name, module->jack_mask,
-			       &module->headset_jack);
+
+	headset = devm_kzalloc(module->dev, sizeof(*headset), GFP_KERNEL);
+	if (!headset)
+		return -ENOMEM;
+
+	headset->pin = module->jack_name;
+	headset->mask = module->jack_mask;
+	jack = &module->headset_jack;
+
+	ret = snd_soc_card_jack_new(card, module->jack_name, module->jack_mask,
+				    jack, headset, 1);
 	if (ret) {
 		dev_err(module->dev, "Failed to create new jack\n");
 		return ret;
@@ -730,11 +742,21 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
 
 	snprintf(module->button_name, NAME_SIZE, "GB %d Button Jack",
 		 module->dev_id);
-	ret = snd_soc_jack_new(codec, module->button_name, module->button_mask,
-			       &module->button_jack);
+	button = devm_kzalloc(module->dev, sizeof(*headset), GFP_KERNEL);
+	if (!button) {
+		ret = -ENOMEM;
+		goto free_headset;
+	}
+
+	button->pin = module->button_name;
+	button->mask = module->button_mask;
+	jack = &module->button_jack;
+
+	ret = snd_soc_card_jack_new(card, module->button_name,
+				    module->button_mask, jack, button, 1);
 	if (ret) {
 		dev_err(module->dev, "Failed to create button jack\n");
-		return ret;
+		goto free_headset;
 	}
 
 	/*
@@ -750,7 +772,7 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
 				       KEY_MEDIA);
 		if (ret) {
 			dev_err(module->dev, "Failed to set BTN_0\n");
-			return ret;
+			goto free_button;
 		}
 	}
 
@@ -759,7 +781,7 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
 				       KEY_VOICECOMMAND);
 		if (ret) {
 			dev_err(module->dev, "Failed to set BTN_1\n");
-			return ret;
+			goto free_button;
 		}
 	}
 
@@ -768,7 +790,7 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
 				       KEY_VOLUMEUP);
 		if (ret) {
 			dev_err(module->dev, "Failed to set BTN_2\n");
-			return ret;
+			goto free_button;
 		}
 	}
 
@@ -777,7 +799,7 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
 				       KEY_VOLUMEDOWN);
 		if (ret) {
 			dev_err(module->dev, "Failed to set BTN_0\n");
-			return ret;
+			goto free_button;
 		}
 	}
 
@@ -788,6 +810,18 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
 	*/
 
 	return 0;
+
+free_button:
+	jack = &module->button_jack;
+	snd_device_free(card->snd_card, jack->jack);
+	list_del(&jack->list);
+
+free_headset:
+	jack = &module->headset_jack;
+	snd_device_free(card->snd_card, jack->jack);
+	list_del(&jack->list);
+
+	return ret;
 }
 
 int gbaudio_register_module(struct gbaudio_module_info *module)
@@ -815,7 +849,7 @@ int gbaudio_register_module(struct gbaudio_module_info *module)
 		return -EINVAL;
 	}
 
-	ret = gbaudio_init_jack(module, codec);
+	ret = gbaudio_init_jack(module, component->card);
 	if (ret) {
 		up_write(&card->controls_rwsem);
 		return ret;
@@ -942,7 +976,8 @@ void gbaudio_unregister_module(struct gbaudio_module_info *module)
 
 #ifdef CONFIG_SND_JACK
 	/* free jack devices for this module from codec->jack_list */
-	list_for_each_entry_safe(jack, next_j, &codec->jack_list, list) {
+	list_for_each_entry_safe(jack, next_j, &component->card->jack_list,
+				 list) {
 		if (jack == &module->headset_jack)
 			mask = GBCODEC_JACK_MASK;
 		else if (jack == &module->button_jack)
-- 
2.7.4

