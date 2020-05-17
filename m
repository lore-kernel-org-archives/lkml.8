Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18525C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 17:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF737207D4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 17:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vezhd0GL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgEQRSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 13:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgEQRSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 13:18:00 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682FFC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 10:18:00 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q9so3686822pjm.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=l2W2xS62GYdegwds1m8qkgAq7FLG1DLl28++ecGwz+4=;
        b=vezhd0GLlaAwinptWs2OarhAwiUJQcNzkUeqxIghvK0x3hNrhhIrst5FadAD21jfr8
         K95NaUUYJ8XtzBxddOxES325UoF138c2flAC2VCuwoV2vKuM0nYpPTfTuJ3ENAEgV9af
         +mtIUcwFlRlJSPC0ACqypUPFweylZDnSN/7ayu/cx4OJX9JEYRTFuk8c7TVjvRtmDIGb
         t8eYxgnoI3kKjfl1Uqy6xvNlo4dMonF51jbDIXtFo3z3vIGQT77hASnfc6JkmyUPFS+u
         JKXEW8F1H0UuM+mgETtazquYTVpV/iv5KaAMS2jUCDFKYGh82cus1YQZRNBxm7qXvcXx
         8v3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=l2W2xS62GYdegwds1m8qkgAq7FLG1DLl28++ecGwz+4=;
        b=tkknCm87nzbhbrPEXIRKgsmAj7YOxbM++TqlEYA+VU20ziu0efdG6pwdWcA16WMeIu
         6Q5RP93W8QVKJh46WDaSUeS9tXVypB06P+UdZtzgpXxnQ8OX9FHm0GqaZaUKoALuRwYD
         Jy2/e1kq7DlJ6Cp74bV1UIPq8KN9qho3nhZph/1Y+ARXWMiisZkzI+/xREGhZ3J5mc7e
         W1eHg7e6lRMWEBcN577OwynA68G09/D2rybrzlg6HP007VZVzIvo/zZ9hup59zPnf1CW
         nzlOZWyMDhQrP8KXkP7iWkx3mmvWYMbZw1L0rG3eQMKybN9z2yRdUgKbyEJpHZbc7PcV
         ybFw==
X-Gm-Message-State: AOAM5337Ovjc5kQgKaJYAH/LBjuG/Z55to4ZJslIa5LwDMI/7MDsFePp
        2CWS8chP9WLObDcFGpORoe4=
X-Google-Smtp-Source: ABdhPJweAkJ6REvlPMDyLxDikSBWr+WBXMPDY2/thLzHgYUtwCrlh7EBtZWoi6Xz4AHtgYTsTmY8zg==
X-Received: by 2002:a17:90a:cc6:: with SMTP id 6mr14863282pjt.17.1589735879910;
        Sun, 17 May 2020 10:17:59 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.googlemail.com with ESMTPSA id n69sm6513900pjc.8.2020.05.17.10.17.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 May 2020 10:17:59 -0700 (PDT)
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>
Subject: [PATCH V1 3/6] staging: greybus: audio: Resolve compilation errors for GB codec module
Date:   Sun, 17 May 2020 22:47:18 +0530
Message-Id: <cce5aa43533d872d84be1abc514074a7705f9a54.1589734179.git.vaibhav.sr@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1589734179.git.vaibhav.sr@gmail.com>
References: <cover.1589734179.git.vaibhav.sr@gmail.com>
In-Reply-To: <cover.1589734179.git.vaibhav.sr@gmail.com>
References: <cover.1589734179.git.vaibhav.sr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to dependencies on ASoC framework changes, GB dummy codec module
compilation is currently disabled. This patch updates codec driver as
per the latest ASoC APIs.

Signed-off-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>
---
 drivers/staging/greybus/audio_codec.c | 87 +++++++++++++++++------------------
 drivers/staging/greybus/audio_codec.h |  2 +-
 2 files changed, 44 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
index a2ee587e5a79..bbd072acda5c 100644
--- a/drivers/staging/greybus/audio_codec.c
+++ b/drivers/staging/greybus/audio_codec.c
@@ -832,7 +832,7 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
 int gbaudio_register_module(struct gbaudio_module_info *module)
 {
 	int ret;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	struct snd_card *card;
 	struct gbaudio_jack *gba_jack = NULL;
 	struct snd_soc_jack *jack = NULL;
@@ -842,8 +842,8 @@ int gbaudio_register_module(struct gbaudio_module_info *module)
 		return -EAGAIN;
 	}
 
-	codec = gbcodec->codec;
-	card = codec->card->snd_card;
+	component = gbcodec->component;
+	card = component->card->snd_card;
 
 	down_write(&card->controls_rwsem);
 
@@ -862,19 +862,20 @@ int gbaudio_register_module(struct gbaudio_module_info *module)
 	}
 
 	if (module->dapm_widgets)
-		snd_soc_dapm_new_controls(&codec->dapm, module->dapm_widgets,
+		snd_soc_dapm_new_controls(&component->dapm,
+					  module->dapm_widgets,
 					  module->num_dapm_widgets);
 	if (module->controls)
-		snd_soc_add_codec_controls(codec, module->controls,
-					   module->num_controls);
+		snd_soc_add_component_controls(component, module->controls,
+					       module->num_controls);
 	if (module->dapm_routes)
-		snd_soc_dapm_add_routes(&codec->dapm, module->dapm_routes,
+		snd_soc_dapm_add_routes(&component->dapm, module->dapm_routes,
 					module->num_dapm_routes);
 
 	/* card already instantiated, create widgets here only */
-	if (codec->card->instantiated) {
-		snd_soc_dapm_link_component_dai_widgets(codec->card,
-							&codec->dapm);
+	if (component->card->instantiated) {
+		snd_soc_dapm_link_component_dai_widgets(component->card,
+							&component->dapm);
 #ifdef CONFIG_SND_JACK
 		/*
 		 * register jack devices for this module
@@ -882,7 +883,7 @@ int gbaudio_register_module(struct gbaudio_module_info *module)
 		 */
 		list_for_each_entry(gba_jack, &module->jack_list, list) {
 			jack = &gba_jack->jack;
-			snd_device_register(codec->card->snd_card,
+			snd_device_register(component->card->snd_card,
 					    jack->jack);
 		}
 #endif
@@ -892,9 +893,9 @@ int gbaudio_register_module(struct gbaudio_module_info *module)
 	list_add(&module->list, &gbcodec->module_list);
 	mutex_unlock(&gbcodec->lock);
 
-	if (codec->card->instantiated)
-		ret = snd_soc_dapm_new_widgets(&codec->dapm);
-	dev_dbg(codec->dev, "Registered %s module\n", module->name);
+	if (component->card->instantiated)
+		ret = snd_soc_dapm_new_widgets(component->card);
+	dev_dbg(component->dev, "Registered %s module\n", module->name);
 
 	up_write(&card->controls_rwsem);
 	return ret;
@@ -965,19 +966,19 @@ static void gbaudio_codec_cleanup(struct gbaudio_module_info *module)
 
 void gbaudio_unregister_module(struct gbaudio_module_info *module)
 {
-	struct snd_soc_codec *codec = gbcodec->codec;
-	struct snd_card *card = codec->card->snd_card;
+	struct snd_soc_component *component = gbcodec->component;
+	struct snd_card *card = component->card->snd_card;
 	struct gbaudio_jack *gba_jack, *n;
 	struct snd_soc_jack *jack;
 	int mask;
 
-	dev_dbg(codec->dev, "Unregister %s module\n", module->name);
+	dev_dbg(component->dev, "Unregister %s module\n", module->name);
 
 	down_write(&card->controls_rwsem);
 	mutex_lock(&gbcodec->lock);
 	gbaudio_codec_cleanup(module);
 	list_del(&module->list);
-	dev_dbg(codec->dev, "Process Unregister %s module\n", module->name);
+	dev_dbg(component->dev, "Process Unregister %s module\n", module->name);
 	mutex_unlock(&gbcodec->lock);
 
 #ifdef CONFIG_SND_JACK
@@ -994,99 +995,97 @@ void gbaudio_unregister_module(struct gbaudio_module_info *module)
 			dev_dbg(module->dev, "Report %s removal\n",
 				jack->jack->id);
 			snd_soc_jack_report(jack, 0, mask);
-			snd_device_free(codec->card->snd_card, jack->jack);
+			snd_device_free(component->card->snd_card, jack->jack);
 			list_del(&gba_jack->list);
 		}
 	}
 #endif
 
 	if (module->dapm_routes) {
-		dev_dbg(codec->dev, "Removing %d routes\n",
+		dev_dbg(component->dev, "Removing %d routes\n",
 			module->num_dapm_routes);
-		snd_soc_dapm_del_routes(&codec->dapm, module->dapm_routes,
+		snd_soc_dapm_del_routes(&component->dapm, module->dapm_routes,
 					module->num_dapm_routes);
 	}
 	if (module->controls) {
-		dev_dbg(codec->dev, "Removing %d controls\n",
+		dev_dbg(component->dev, "Removing %d controls\n",
 			module->num_controls);
-		snd_soc_remove_codec_controls(codec, module->controls,
+		snd_soc_remove_codec_controls(component, module->controls,
 					      module->num_controls);
 	}
 	if (module->dapm_widgets) {
-		dev_dbg(codec->dev, "Removing %d widgets\n",
+		dev_dbg(component->dev, "Removing %d widgets\n",
 			module->num_dapm_widgets);
-		snd_soc_dapm_free_controls(&codec->dapm, module->dapm_widgets,
+		snd_soc_dapm_free_controls(&component->dapm,
+					   module->dapm_widgets,
 					   module->num_dapm_widgets);
 	}
 
-	dev_dbg(codec->dev, "Unregistered %s module\n", module->name);
+	dev_dbg(component->dev, "Unregistered %s module\n", module->name);
 
 	up_write(&card->controls_rwsem);
 }
 EXPORT_SYMBOL(gbaudio_unregister_module);
 
 /*
- * codec driver ops
+ * component driver ops
  */
-static int gbcodec_probe(struct snd_soc_codec *codec)
+static int gbcodec_probe(struct snd_soc_component *component)
 {
 	int i;
 	struct gbaudio_codec_info *info;
 	struct gbaudio_codec_dai *dai;
 
-	info = devm_kzalloc(codec->dev, sizeof(*info), GFP_KERNEL);
+	info = devm_kzalloc(component->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
-	info->dev = codec->dev;
+	info->dev = component->dev;
 	INIT_LIST_HEAD(&info->module_list);
 	mutex_init(&info->lock);
 	INIT_LIST_HEAD(&info->dai_list);
 
 	/* init dai_list used to maintain runtime stream info */
 	for (i = 0; i < ARRAY_SIZE(gbaudio_dai); i++) {
-		dai = devm_kzalloc(codec->dev, sizeof(*dai), GFP_KERNEL);
+		dai = devm_kzalloc(component->dev, sizeof(*dai), GFP_KERNEL);
 		if (!dai)
 			return -ENOMEM;
 		dai->id = gbaudio_dai[i].id;
 		list_add(&dai->list, &info->dai_list);
 	}
 
-	info->codec = codec;
-	snd_soc_codec_set_drvdata(codec, info);
+	info->component = component;
+	snd_soc_component_set_drvdata(component, info);
 	gbcodec = info;
 
-	device_init_wakeup(codec->dev, 1);
+	device_init_wakeup(component->dev, 1);
 	return 0;
 }
 
-static int gbcodec_remove(struct snd_soc_codec *codec)
+static void gbcodec_remove(struct snd_soc_component *component)
 {
 	/* Empty function for now */
-	return 0;
+	return;
 }
 
-static int gbcodec_write(struct snd_soc_codec *codec, unsigned int reg,
+static int gbcodec_write(struct snd_soc_component *component, unsigned int reg,
 			 unsigned int value)
 {
 	return 0;
 }
 
-static unsigned int gbcodec_read(struct snd_soc_codec *codec,
+static unsigned int gbcodec_read(struct snd_soc_component *component,
 				 unsigned int reg)
 {
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_gbaudio = {
+static const struct snd_soc_component_driver soc_codec_dev_gbaudio = {
 	.probe	= gbcodec_probe,
 	.remove	= gbcodec_remove,
 
 	.read = gbcodec_read,
 	.write = gbcodec_write,
-
-	.idle_bias_off = true,
-	.ignore_pmdown_time = 1,
 };
 
 #ifdef CONFIG_PM
@@ -1110,13 +1109,13 @@ static const struct dev_pm_ops gbaudio_codec_pm_ops = {
 
 static int gbaudio_codec_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_gbaudio,
+	return devm_snd_soc_register_component(&pdev->dev,
+			&soc_codec_dev_gbaudio,
 			gbaudio_dai, ARRAY_SIZE(gbaudio_dai));
 }
 
 static int gbaudio_codec_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
 }
 
diff --git a/drivers/staging/greybus/audio_codec.h b/drivers/staging/greybus/audio_codec.h
index af9195eceb3a..ce15e800e607 100644
--- a/drivers/staging/greybus/audio_codec.h
+++ b/drivers/staging/greybus/audio_codec.h
@@ -66,7 +66,7 @@ struct gbaudio_codec_dai {
 
 struct gbaudio_codec_info {
 	struct device *dev;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	struct list_head module_list;
 	/* to maintain runtime stream params for each DAI */
 	struct list_head dai_list;
-- 
2.7.4

