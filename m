Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93702C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D172070B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tC4zy1ln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgFJR3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbgFJR31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:29:27 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA45C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 10:29:27 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y18so1213987plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 10:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NtbNmsonDMoekdi5axaMguk/gVcbR6PjQHj/vYuOxjU=;
        b=tC4zy1lnWK7eL+yQAvAi8uzjPY313RVnma1F67Rr5dZZR0Flk38BbMaKlhAt2wngT8
         h85Koqo6nB4VpOw8yRSFAUAtbBr+k1I1n3piokoO9ObXro6u291mBgEpfFgwGG0GSCMu
         uFt/+wLW0RrDUr3pB8yU46UZtzZPO8LyoQU1xbHyReXFF0K+wqdQIOlYBPDLwZtkl2f2
         Z9gK/aIL7tEnO3Xc8m46xz2OHUr+09PjMSHvx8TRcdw+fUsUS8j2RXtU8Qc1g594H2b4
         rc+CmEQuO2zQvBNY0lCNu6N0P9OatrKvEw9914Atmh9Zn+zuimbcJ6FI6nD43Y3EGZvg
         gtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NtbNmsonDMoekdi5axaMguk/gVcbR6PjQHj/vYuOxjU=;
        b=gxopb6tw73kXHaTIjWfhoHZhl+EKzLZNXwYjgNueCyqGH8CdOsp/oCpjSAI7lv/Frw
         YFeJgGhX3CByjgoCUziw1UikwmJAZO91fpsPKUAEeLIoxabnIjOkDQjZN+y7IQY8ZKuB
         56KnwWmqDTqXpDhu6fBWgFCH6MWeoKQyvdTOkV2latax0ZUle8XdeLOym2zcNtAZupS7
         D7boVfuwVGECtTdfVeXYqWfbHcVr5skr+3R2PJBId2vSMY/DX/rTeS/pAZ2zZeXYrsIG
         AzTx6nS/3SBFGTjU65e43G1pGsGG9P9jli5GZVgoHfN1JtCoMo4sElXG/cCPs8alQgkX
         uQhg==
X-Gm-Message-State: AOAM533ecXXVACtT8De0KKAmBwiINr7jh26gz9rxryCwO2TRqDQomEUr
        wQADXlonoI9vWRyfwmb0pUw=
X-Google-Smtp-Source: ABdhPJwkzJ7/R5LBy0d9NtZ4D2amddsknI0JxJCpfrvGpTDPcyZcSxuoBTOwnuz8K6+OT5WdH0OVhQ==
X-Received: by 2002:a17:90a:7bc3:: with SMTP id d3mr3943890pjl.98.1591810166766;
        Wed, 10 Jun 2020 10:29:26 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com ([192.55.54.40])
        by smtp.googlemail.com with ESMTPSA id l83sm490470pfd.150.2020.06.10.10.29.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2020 10:29:25 -0700 (PDT)
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>
Subject: [PATCH v2 2/6] staging: greybus: audio: Maintain jack list within GB Audio module
Date:   Wed, 10 Jun 2020 22:58:26 +0530
Message-Id: <af932176026ef8f7940cb35f515c9e1b7e5dc69f.1591802243.git.vaibhav.sr@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591802243.git.vaibhav.sr@gmail.com>
References: <cover.1591802243.git.vaibhav.sr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/staging/greybus/audio_codec.c  | 74 +++++++++++++-------------
 drivers/staging/greybus/audio_codec.h  | 10 +++-
 drivers/staging/greybus/audio_module.c | 15 +++---
 3 files changed, 53 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
index 5d3a5e6a8fe6..6dc4ee2bfb37 100644
--- a/drivers/staging/greybus/audio_codec.c
+++ b/drivers/staging/greybus/audio_codec.c
@@ -712,6 +712,7 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
 			     struct snd_soc_card *card)
 {
 	int ret;
+	struct gbaudio_jack *jack, *n;
 	struct snd_soc_jack_pin *headset, *button;
 
 	if (!module->jack_mask)
@@ -726,14 +727,16 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
 
 	headset->pin = module->jack_name;
 	headset->mask = module->jack_mask;
-
 	ret = snd_soc_card_jack_new(card, module->jack_name, module->jack_mask,
-				    &module->headset_jack, headset, 1);
+				    &module->headset.jack, headset, 1);
 	if (ret) {
 		dev_err(module->dev, "Failed to create new jack\n");
 		return ret;
 	}
 
+	/* Add to module's jack list */
+	list_add(&module->headset.list, &module->jack_list);
+
 	if (!module->button_mask)
 		return 0;
 
@@ -742,20 +745,22 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
 	button = devm_kzalloc(module->dev, sizeof(*button), GFP_KERNEL);
 	if (!button) {
 		ret = -ENOMEM;
-		goto free_headset;
+		goto free_jacks;
 	}
 
 	button->pin = module->button_name;
 	button->mask = module->button_mask;
-
 	ret = snd_soc_card_jack_new(card, module->button_name,
-				    module->button_mask, &module->button_jack,
+				    module->button_mask, &module->button.jack,
 				    button, 1);
 	if (ret) {
 		dev_err(module->dev, "Failed to create button jack\n");
-		goto free_headset;
+		goto free_jacks;
 	}
 
+	/* Add to module's jack list */
+	list_add(&module->button.list, &module->jack_list);
+
 	/*
 	 * Currently, max 4 buttons are supported with following key mapping
 	 * BTN_0 = KEY_MEDIA
@@ -765,56 +770,54 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
 	 */
 
 	if (module->button_mask & SND_JACK_BTN_0) {
-		ret = snd_jack_set_key(module->button_jack.jack, SND_JACK_BTN_0,
+		ret = snd_jack_set_key(module->button.jack.jack, SND_JACK_BTN_0,
 				       KEY_MEDIA);
 		if (ret) {
 			dev_err(module->dev, "Failed to set BTN_0\n");
-			goto free_button;
+			goto free_jacks;
 		}
 	}
 
 	if (module->button_mask & SND_JACK_BTN_1) {
-		ret = snd_jack_set_key(module->button_jack.jack, SND_JACK_BTN_1,
+		ret = snd_jack_set_key(module->button.jack.jack, SND_JACK_BTN_1,
 				       KEY_VOICECOMMAND);
 		if (ret) {
 			dev_err(module->dev, "Failed to set BTN_1\n");
-			goto free_button;
+			goto free_jacks;
 		}
 	}
 
 	if (module->button_mask & SND_JACK_BTN_2) {
-		ret = snd_jack_set_key(module->button_jack.jack, SND_JACK_BTN_2,
+		ret = snd_jack_set_key(module->button.jack.jack, SND_JACK_BTN_2,
 				       KEY_VOLUMEUP);
 		if (ret) {
 			dev_err(module->dev, "Failed to set BTN_2\n");
-			goto free_button;
+			goto free_jacks;
 		}
 	}
 
 	if (module->button_mask & SND_JACK_BTN_3) {
-		ret = snd_jack_set_key(module->button_jack.jack, SND_JACK_BTN_3,
+		ret = snd_jack_set_key(module->button.jack.jack, SND_JACK_BTN_3,
 				       KEY_VOLUMEDOWN);
 		if (ret) {
 			dev_err(module->dev, "Failed to set BTN_0\n");
-			goto free_button;
+			goto free_jacks;
 		}
 	}
 
 	/* FIXME
 	 * verify if this is really required
 	set_bit(INPUT_PROP_NO_DUMMY_RELEASE,
-		module->button_jack.jack->input_dev->propbit);
+		module->button.jack.jack->input_dev->propbit);
 	*/
 
 	return 0;
 
-free_button:
-	snd_device_free(card->snd_card, module->button_jack.jack);
-	list_del(&module->button_jack.list);
-
-free_headset:
-	snd_device_free(card->snd_card, module->headset_jack.jack);
-	list_del(&module->headset_jack.list);
+free_jacks:
+	list_for_each_entry_safe(jack, n, &module->jack_list, list) {
+		snd_device_free(card->snd_card, jack->jack.jack);
+		list_del(&jack->list);
+	}
 
 	return ret;
 }
@@ -824,7 +827,7 @@ int gbaudio_register_module(struct gbaudio_module_info *module)
 	int ret;
 	struct snd_soc_codec *codec;
 	struct snd_card *card;
-	struct snd_soc_jack *jack = NULL;
+	struct gbaudio_jack *jack = NULL;
 
 	if (!gbcodec) {
 		dev_err(module->dev, "GB Codec not yet probed\n");
@@ -869,11 +872,9 @@ int gbaudio_register_module(struct gbaudio_module_info *module)
 		 * register jack devices for this module
 		 * from codec->jack_list
 		 */
-		list_for_each_entry(jack, &codec->jack_list, list) {
-			if ((jack == &module->headset_jack) ||
-			    (jack == &module->button_jack))
-				snd_device_register(codec->card->snd_card,
-						    jack->jack);
+		list_for_each_entry(jack, &module->jack_list, list) {
+			snd_device_register(codec->card->snd_card,
+					    jack->jack.jack);
 		}
 #endif
 	}
@@ -957,7 +958,7 @@ void gbaudio_unregister_module(struct gbaudio_module_info *module)
 {
 	struct snd_soc_codec *codec = gbcodec->codec;
 	struct snd_card *card = codec->card->snd_card;
-	struct snd_soc_jack *jack, *next_j;
+	struct gbaudio_jack *jack, *n;
 	int mask;
 
 	dev_dbg(codec->dev, "Unregister %s module\n", module->name);
@@ -970,20 +971,19 @@ void gbaudio_unregister_module(struct gbaudio_module_info *module)
 	mutex_unlock(&gbcodec->lock);
 
 #ifdef CONFIG_SND_JACK
-	/* free jack devices for this module from codec->jack_list */
-	list_for_each_entry_safe(jack, next_j, &component->card->jack_list,
-				 list) {
-		if (jack == &module->headset_jack)
+	/* free jack devices for this module jack_list */
+	list_for_each_entry_safe(jack, n, &module->jack_list, list) {
+		if (jack == &module->headset)
 			mask = GBCODEC_JACK_MASK;
-		else if (jack == &module->button_jack)
+		else if (jack == &module->button)
 			mask = GBCODEC_JACK_BUTTON_MASK;
 		else
 			mask = 0;
 		if (mask) {
 			dev_dbg(module->dev, "Report %s removal\n",
-				jack->jack->id);
-			snd_soc_jack_report(jack, 0, mask);
-			snd_device_free(codec->card->snd_card, jack->jack);
+				jack->jack.jack->id);
+			snd_soc_jack_report(&jack->jack, 0, mask);
+			snd_device_free(codec->card->snd_card, jack->jack.jack);
 			list_del(&jack->list);
 		}
 	}
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
index 300a2b4f3fc7..16f60256adb2 100644
--- a/drivers/staging/greybus/audio_module.c
+++ b/drivers/staging/greybus/audio_module.c
@@ -21,8 +21,8 @@ static int gbaudio_request_jack(struct gbaudio_module_info *module,
 				struct gb_audio_jack_event_request *req)
 {
 	int report;
-	struct snd_jack *jack = module->headset_jack.jack;
-	struct snd_jack *btn_jack = module->button_jack.jack;
+	struct snd_jack *jack = module->headset.jack.jack;
+	struct snd_jack *btn_jack = module->button.jack.jack;
 
 	if (!jack) {
 		dev_err_ratelimited(module->dev,
@@ -38,11 +38,11 @@ static int gbaudio_request_jack(struct gbaudio_module_info *module,
 	if (req->event == GB_AUDIO_JACK_EVENT_REMOVAL) {
 		module->jack_type = 0;
 		if (btn_jack && module->button_status) {
-			snd_soc_jack_report(&module->button_jack, 0,
+			snd_soc_jack_report(&module->button.jack, 0,
 					    module->button_mask);
 			module->button_status = 0;
 		}
-		snd_soc_jack_report(&module->headset_jack, 0,
+		snd_soc_jack_report(&module->headset.jack, 0,
 				    module->jack_mask);
 		return 0;
 	}
@@ -61,7 +61,7 @@ static int gbaudio_request_jack(struct gbaudio_module_info *module,
 				     module->jack_type, report);
 
 	module->jack_type = report;
-	snd_soc_jack_report(&module->headset_jack, report, module->jack_mask);
+	snd_soc_jack_report(&module->headset.jack, report, module->jack_mask);
 
 	return 0;
 }
@@ -70,7 +70,7 @@ static int gbaudio_request_button(struct gbaudio_module_info *module,
 				  struct gb_audio_button_event_request *req)
 {
 	int soc_button_id, report;
-	struct snd_jack *btn_jack = module->button_jack.jack;
+	struct snd_jack *btn_jack = module->button.jack.jack;
 
 	if (!btn_jack) {
 		dev_err_ratelimited(module->dev,
@@ -124,7 +124,7 @@ static int gbaudio_request_button(struct gbaudio_module_info *module,
 
 	module->button_status = report;
 
-	snd_soc_jack_report(&module->button_jack, report, module->button_mask);
+	snd_soc_jack_report(&module->button.jack, report, module->button_mask);
 
 	return 0;
 }
@@ -258,6 +258,7 @@ static int gb_audio_probe(struct gb_bundle *bundle,
 	INIT_LIST_HEAD(&gbmodule->widget_list);
 	INIT_LIST_HEAD(&gbmodule->ctl_list);
 	INIT_LIST_HEAD(&gbmodule->widget_ctl_list);
+	INIT_LIST_HEAD(&gbmodule->jack_list);
 	gbmodule->dev = dev;
 	snprintf(gbmodule->name, NAME_SIZE, "%s.%s", dev->driver->name,
 		 dev_name(dev));
-- 
2.26.2

