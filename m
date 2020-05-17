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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF10C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 17:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D22207D4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 17:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bD/NSK0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgEQRRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 13:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgEQRRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 13:17:53 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33DBC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 10:17:52 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ci23so331252pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 10:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Rh+BtxpQgxuee3rHBHuMexjfAjQ4Uh29XKClnpfBg5A=;
        b=bD/NSK0sAfBXgHRucTyt9haM+exLcZ4N/G+HwgwWeNKbZ0r0grV+AvXUlvJSlDQnaN
         RVyynblxnoPxd5YY+Ly6/cCrrzNBZLRZZzxadZWHxrHgAkrFPBbKUWdBmEOAj2ewSPDz
         2uGbh74coXUCQKUxxg/rZCEcTFM/HbaG01P/rGtFvHf394evLmDz4J/aGiWTGBl8v8mx
         nWxRFqVQQMMNyYjaafJWehOQCapVReeYA45yq/2OEezd8IbbpVPgKsWjJlSFq6PNXV8l
         wm4MRC3eb1s/T4P2B+2ppS9GUS93FOJl2/WICaqImhGYzCT/cBTi3IZpzdcW1tr/J+Wx
         SVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Rh+BtxpQgxuee3rHBHuMexjfAjQ4Uh29XKClnpfBg5A=;
        b=YaL7EEijqOrek0BjObuU6kAGR5/cHXqR+DD59OZzHY+NoDjPQdLN4k9LwsVszxLtTP
         cZirYYEOjyqT/RITu0tZP2+xLA1SbxA621uBJGBpw1ewb9gwVKpcfG65IkxyDSyCjkrB
         h1ATr0oZfJNw71sPl1Bv//FC96Vjw2QITN3YARfl8V/lCiCl9KYFCL0uno+hSU4YaHWx
         M2yrguixvzEdlGaT1BTRbkn1PY2r/BfDEzzragPEInjSzOJG/cGRl5LV3WILX4a2Cugi
         GJxtYqFEQ8ES8jhqikmDS188+LrdQNd52Y/VR4ZPQSYeLFFJkXK9q1sy9Xc/g+jpohQa
         uiEg==
X-Gm-Message-State: AOAM530BA5bIM75/10NlGqXoQpGvYqH0mXiHm9YkciI6/n//VUmKnRDQ
        cuYk3av7WNSAg35xPDm//9nwZ7TT9rrHBQ==
X-Google-Smtp-Source: ABdhPJzjGDxKUZqiujPm5KZrdCVkSsEQAEsODGwIB75Z5IIyqPQQgr3qAFN1Tx8U2TOuO6aMbMsl5g==
X-Received: by 2002:a17:90a:20cf:: with SMTP id f73mr15190170pjg.86.1589735872335;
        Sun, 17 May 2020 10:17:52 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.googlemail.com with ESMTPSA id n69sm6513900pjc.8.2020.05.17.10.17.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 May 2020 10:17:51 -0700 (PDT)
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>
Subject: [PATCH V1 2/6] staging: greybus: audio: Maintain jack list within GB Audio module
Date:   Sun, 17 May 2020 22:47:17 +0530
Message-Id: <ccb39352a30ab39df1534efafc9415aa89b156fa.1589734179.git.vaibhav.sr@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1589734179.git.vaibhav.sr@gmail.com>
References: <cover.1589734179.git.vaibhav.sr@gmail.com>
In-Reply-To: <cover.1589734179.git.vaibhav.sr@gmail.com>
References: <cover.1589734179.git.vaibhav.sr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the current implementation for GB codec driver, a jack list is
maintained for each module. And it expects the list to be populated by
the snd_soc_jack structure which would require modifications in
mainstream code.

However, this is not a necessary requirement and the list can be easily
maintained within gbaudio_module_info as well. This patch provides the
relevant changes for the same.

Signed-off-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>
---
 drivers/staging/greybus/audio_codec.c  | 76 ++++++++++++++++++----------------
 drivers/staging/greybus/audio_codec.h  | 10 ++++-
 drivers/staging/greybus/audio_module.c | 20 +++++----
 3 files changed, 60 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
index ebf8484f0ae7..a2ee587e5a79 100644
--- a/drivers/staging/greybus/audio_codec.c
+++ b/drivers/staging/greybus/audio_codec.c
@@ -712,7 +712,7 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
 			     struct snd_soc_card *card)
 {
 	int ret;
-
+	struct gbaudio_jack *gba_jack, *n;
 	struct snd_soc_jack *jack;
 	struct snd_soc_jack_pin *headset, *button;
 
@@ -728,7 +728,8 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
 
 	headset->pin = module->jack_name;
 	headset->mask = module->jack_mask;
-	jack = &module->headset_jack;
+	gba_jack = &module->headset;
+	jack = &gba_jack->jack;
 
 	ret = snd_soc_card_jack_new(card, module->jack_name, module->jack_mask,
 				    jack, headset, 1);
@@ -737,6 +738,9 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
 		return ret;
 	}
 
+	/* Add to module's jack list */
+	list_add(&gba_jack->list, &module->jack_list);
+
 	if (!module->button_mask)
 		return 0;
 
@@ -745,20 +749,24 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
 	button = devm_kzalloc(module->dev, sizeof(*headset), GFP_KERNEL);
 	if (!button) {
 		ret = -ENOMEM;
-		goto free_headset;
+		goto free_jack;
 	}
 
 	button->pin = module->button_name;
 	button->mask = module->button_mask;
-	jack = &module->button_jack;
+	gba_jack = &module->button;
+	jack = &gba_jack->jack;
 
 	ret = snd_soc_card_jack_new(card, module->button_name,
 				    module->button_mask, jack, button, 1);
 	if (ret) {
 		dev_err(module->dev, "Failed to create button jack\n");
-		goto free_headset;
+		goto free_jack;
 	}
 
+	/* Add to module's jack list */
+	list_add(&gba_jack->list, &module->jack_list);
+
 	/*
 	 * Currently, max 4 buttons are supported with following key mapping
 	 * BTN_0 = KEY_MEDIA
@@ -768,58 +776,55 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
 	 */
 
 	if (module->button_mask & SND_JACK_BTN_0) {
-		ret = snd_jack_set_key(module->button_jack.jack, SND_JACK_BTN_0,
+		ret = snd_jack_set_key(jack->jack, SND_JACK_BTN_0,
 				       KEY_MEDIA);
 		if (ret) {
 			dev_err(module->dev, "Failed to set BTN_0\n");
-			goto free_button;
+			goto free_jack;
 		}
 	}
 
 	if (module->button_mask & SND_JACK_BTN_1) {
-		ret = snd_jack_set_key(module->button_jack.jack, SND_JACK_BTN_1,
+		ret = snd_jack_set_key(jack->jack, SND_JACK_BTN_1,
 				       KEY_VOICECOMMAND);
 		if (ret) {
 			dev_err(module->dev, "Failed to set BTN_1\n");
-			goto free_button;
+			goto free_jack;
 		}
 	}
 
 	if (module->button_mask & SND_JACK_BTN_2) {
-		ret = snd_jack_set_key(module->button_jack.jack, SND_JACK_BTN_2,
+		ret = snd_jack_set_key(jack->jack, SND_JACK_BTN_2,
 				       KEY_VOLUMEUP);
 		if (ret) {
 			dev_err(module->dev, "Failed to set BTN_2\n");
-			goto free_button;
+			goto free_jack;
 		}
 	}
 
 	if (module->button_mask & SND_JACK_BTN_3) {
-		ret = snd_jack_set_key(module->button_jack.jack, SND_JACK_BTN_3,
+		ret = snd_jack_set_key(jack->jack, SND_JACK_BTN_3,
 				       KEY_VOLUMEDOWN);
 		if (ret) {
 			dev_err(module->dev, "Failed to set BTN_0\n");
-			goto free_button;
+			goto free_jack;
 		}
 	}
 
 	/* FIXME
 	 * verify if this is really required
 	set_bit(INPUT_PROP_NO_DUMMY_RELEASE,
-		module->button_jack.jack->input_dev->propbit);
+		module->button->jack->jack->input_dev->propbit);
 	*/
 
 	return 0;
 
-free_button:
-	jack = &module->button_jack;
-	snd_device_free(card->snd_card, jack->jack);
-	list_del(&jack->list);
-
-free_headset:
-	jack = &module->headset_jack;
-	snd_device_free(card->snd_card, jack->jack);
-	list_del(&jack->list);
+free_jack:
+	list_for_each_entry_safe(gba_jack, n, &module->jack_list, list) {
+		jack = &gba_jack->jack;
+		snd_device_free(card->snd_card, jack->jack);
+		list_del(&gba_jack->list);
+	}
 
 	return ret;
 }
@@ -829,6 +834,7 @@ int gbaudio_register_module(struct gbaudio_module_info *module)
 	int ret;
 	struct snd_soc_codec *codec;
 	struct snd_card *card;
+	struct gbaudio_jack *gba_jack = NULL;
 	struct snd_soc_jack *jack = NULL;
 
 	if (!gbcodec) {
@@ -874,11 +880,10 @@ int gbaudio_register_module(struct gbaudio_module_info *module)
 		 * register jack devices for this module
 		 * from codec->jack_list
 		 */
-		list_for_each_entry(jack, &codec->jack_list, list) {
-			if ((jack == &module->headset_jack) ||
-			    (jack == &module->button_jack))
-				snd_device_register(codec->card->snd_card,
-						    jack->jack);
+		list_for_each_entry(gba_jack, &module->jack_list, list) {
+			jack = &gba_jack->jack;
+			snd_device_register(codec->card->snd_card,
+					    jack->jack);
 		}
 #endif
 	}
@@ -962,7 +967,8 @@ void gbaudio_unregister_module(struct gbaudio_module_info *module)
 {
 	struct snd_soc_codec *codec = gbcodec->codec;
 	struct snd_card *card = codec->card->snd_card;
-	struct snd_soc_jack *jack, *next_j;
+	struct gbaudio_jack *gba_jack, *n;
+	struct snd_soc_jack *jack;
 	int mask;
 
 	dev_dbg(codec->dev, "Unregister %s module\n", module->name);
@@ -975,21 +981,21 @@ void gbaudio_unregister_module(struct gbaudio_module_info *module)
 	mutex_unlock(&gbcodec->lock);
 
 #ifdef CONFIG_SND_JACK
-	/* free jack devices for this module from codec->jack_list */
-	list_for_each_entry_safe(jack, next_j, &component->card->jack_list,
-				 list) {
-		if (jack == &module->headset_jack)
+	/* free jack devices for this module jack_list */
+	list_for_each_entry_safe(gba_jack, n, &module->jack_list, list) {
+		if (gba_jack == &module->headset)
 			mask = GBCODEC_JACK_MASK;
-		else if (jack == &module->button_jack)
+		else if (gba_jack == &module->button)
 			mask = GBCODEC_JACK_BUTTON_MASK;
 		else
 			mask = 0;
 		if (mask) {
+			jack = &gba_jack->jack;
 			dev_dbg(module->dev, "Report %s removal\n",
 				jack->jack->id);
 			snd_soc_jack_report(jack, 0, mask);
 			snd_device_free(codec->card->snd_card, jack->jack);
-			list_del(&jack->list);
+			list_del(&gba_jack->list);
 		}
 	}
 #endif
diff --git a/drivers/staging/greybus/audio_codec.h b/drivers/staging/greybus/audio_codec.h
index cb5d271da1a5..af9195eceb3a 100644
--- a/drivers/staging/greybus/audio_codec.h
+++ b/drivers/staging/greybus/audio_codec.h
@@ -106,6 +106,11 @@ enum gbaudio_module_state {
 	GBAUDIO_MODULE_ON,
 };
 
+struct gbaudio_jack {
+	struct snd_soc_jack jack;
+	struct list_head list;
+};
+
 struct gbaudio_module_info {
 	/* module info */
 	struct device *dev;
@@ -130,8 +135,8 @@ struct gbaudio_module_info {
 	int jack_mask;
 	int button_mask;
 	int button_status;
-	struct snd_soc_jack headset_jack;
-	struct snd_soc_jack button_jack;
+	struct gbaudio_jack headset;
+	struct gbaudio_jack button;
 
 	/* connection info */
 	struct gb_connection *mgmt_connection;
@@ -155,6 +160,7 @@ struct gbaudio_module_info {
 	struct list_head widget_list;
 	struct list_head ctl_list;
 	struct list_head widget_ctl_list;
+	struct list_head jack_list;
 
 	struct gb_audio_topology *topology;
 };
diff --git a/drivers/staging/greybus/audio_module.c b/drivers/staging/greybus/audio_module.c
index 300a2b4f3fc7..cdd4b6be5e9c 100644
--- a/drivers/staging/greybus/audio_module.c
+++ b/drivers/staging/greybus/audio_module.c
@@ -21,8 +21,10 @@ static int gbaudio_request_jack(struct gbaudio_module_info *module,
 				struct gb_audio_jack_event_request *req)
 {
 	int report;
-	struct snd_jack *jack = module->headset_jack.jack;
-	struct snd_jack *btn_jack = module->button_jack.jack;
+	struct snd_soc_jack *hs = &module->headset.jack;
+	struct snd_soc_jack *btn = &module->button.jack;
+	struct snd_jack *jack = hs->jack;
+	struct snd_jack *btn_jack = btn->jack;
 
 	if (!jack) {
 		dev_err_ratelimited(module->dev,
@@ -38,12 +40,10 @@ static int gbaudio_request_jack(struct gbaudio_module_info *module,
 	if (req->event == GB_AUDIO_JACK_EVENT_REMOVAL) {
 		module->jack_type = 0;
 		if (btn_jack && module->button_status) {
-			snd_soc_jack_report(&module->button_jack, 0,
-					    module->button_mask);
+			snd_soc_jack_report(btn, 0, module->button_mask);
 			module->button_status = 0;
 		}
-		snd_soc_jack_report(&module->headset_jack, 0,
-				    module->jack_mask);
+		snd_soc_jack_report(hs, 0, module->jack_mask);
 		return 0;
 	}
 
@@ -61,7 +61,7 @@ static int gbaudio_request_jack(struct gbaudio_module_info *module,
 				     module->jack_type, report);
 
 	module->jack_type = report;
-	snd_soc_jack_report(&module->headset_jack, report, module->jack_mask);
+	snd_soc_jack_report(hs, report, module->jack_mask);
 
 	return 0;
 }
@@ -70,7 +70,8 @@ static int gbaudio_request_button(struct gbaudio_module_info *module,
 				  struct gb_audio_button_event_request *req)
 {
 	int soc_button_id, report;
-	struct snd_jack *btn_jack = module->button_jack.jack;
+	struct snd_soc_jack *btn = &module->button.jack;
+	struct snd_jack *btn_jack = btn->jack;
 
 	if (!btn_jack) {
 		dev_err_ratelimited(module->dev,
@@ -124,7 +125,7 @@ static int gbaudio_request_button(struct gbaudio_module_info *module,
 
 	module->button_status = report;
 
-	snd_soc_jack_report(&module->button_jack, report, module->button_mask);
+	snd_soc_jack_report(btn, report, module->button_mask);
 
 	return 0;
 }
@@ -258,6 +259,7 @@ static int gb_audio_probe(struct gb_bundle *bundle,
 	INIT_LIST_HEAD(&gbmodule->widget_list);
 	INIT_LIST_HEAD(&gbmodule->ctl_list);
 	INIT_LIST_HEAD(&gbmodule->widget_ctl_list);
+	INIT_LIST_HEAD(&gbmodule->jack_list);
 	gbmodule->dev = dev;
 	snprintf(gbmodule->name, NAME_SIZE, "%s.%s", dev->driver->name,
 		 dev_name(dev));
-- 
2.7.4

