Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61BDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98B3F206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C84F2y6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgGIK1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgGIK1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:27:47 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E517C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 03:27:47 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b9so664832plx.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 03:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wBejO/xUkPwib/mX/QjZ9UHJhcJDeDuqfeRfkDWcj9A=;
        b=C84F2y6aZ73GJL4Y+dCP1R7Oc6ylztwGdgkvTbOd6N9+3Y9QgqjFCyCOHeCjzs1Zn2
         KAkDTc/HLhV50E6jhXUY/uXSyX/e65dJCTpJRq7cl9pkB9uuZJfObS+uMmZPBI5wKG6m
         th2LzwU7sQ1tEhuVex6Va5+GLfq8tcB/nD+SH13k9aVv2HnwjKQQ98xdlFk6SkxGM0bL
         kxe3boF6kT6yJBViDsZ+VDUOWnnsQ27CtWp3HwHtqqXPhNW8GoUL8HKgo3rXvxaC7QDd
         Y5YvQYzF5RE1T1uKi3Y2XPx7kh1gnYMxzVl94Dl9pYxBiZUyooEKa9H/4v7mtAm2S72M
         iTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wBejO/xUkPwib/mX/QjZ9UHJhcJDeDuqfeRfkDWcj9A=;
        b=qclpcuGz4G8WV6nm44qNlThfHvKxc6eV75GVvEzRPC2b8kjinVwRutcyfIbuXmxIum
         +q5bhzqPLz0MbUKtVjO1ePa2kLzv2SN6tTSdEtgC/cQY9CzAbwZuAHVvr7Agl71Pljqw
         gKSQrd5OUCubvaDsJBoJcdCMBVFRfDPTwcy8ZLy4SvIp5DE0Mp80ihIo84QTfgqREs3E
         3c0wcsjwhCpIAnqz7S8fE+j/jFFR5yZddkeTh3Urbcnp2fjgQlcaiedIPz/7lNnnt05I
         yYabpYOlmV8Uo8Vxt6eNfblxDNBHbSK9IH9Bt+BGh4RO8sLy0WUfg4bnao7p++soDfGW
         v/UA==
X-Gm-Message-State: AOAM530D/Z5NaAwXzpE+yRRR6IfuNeLW0zjCV6eWlD+u5EPV6cqi2w2F
        7MY4SIngfdtq7W5WxuR4cYcemMKaws02qw==
X-Google-Smtp-Source: ABdhPJzEtnudH7Gx8NjM2nvVJu6j5ftK6ejMImPlH6JK55XG/h96iXA7yHY5Tft2c1qqEJD2PG5Wpg==
X-Received: by 2002:a17:90b:3755:: with SMTP id ne21mr14001714pjb.218.1594290466969;
        Thu, 09 Jul 2020 03:27:46 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com ([192.55.54.40])
        by smtp.googlemail.com with ESMTPSA id y8sm2125163pju.49.2020.07.09.03.27.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 03:27:46 -0700 (PDT)
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v4 1/7] staging: greybus: audio: Update snd_jack FW usage as per new APIs
Date:   Thu,  9 Jul 2020 15:57:17 +0530
Message-Id: <896b8e24d990f2bca5aafaebd26e37095042951e.1594290158.git.vaibhav.sr@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1594290158.git.vaibhav.sr@gmail.com>
References: <cover.1594290158.git.vaibhav.sr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_soc_jack APIs are modified in recent kernel versions. This patch
updates the codec driver to resolve the compilation errors related to
jack framework.

Signed-off-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/staging/greybus/audio_codec.c | 54 +++++++++++++++++++++------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
index 08746c85dea6..5d3a5e6a8fe6 100644
--- a/drivers/staging/greybus/audio_codec.c
+++ b/drivers/staging/greybus/audio_codec.c
@@ -709,17 +709,26 @@ static struct snd_soc_dai_driver gbaudio_dai[] = {
 };
 
 static int gbaudio_init_jack(struct gbaudio_module_info *module,
-			     struct snd_soc_codec *codec)
+			     struct snd_soc_card *card)
 {
 	int ret;
+	struct snd_soc_jack_pin *headset, *button;
 
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
+
+	ret = snd_soc_card_jack_new(card, module->jack_name, module->jack_mask,
+				    &module->headset_jack, headset, 1);
 	if (ret) {
 		dev_err(module->dev, "Failed to create new jack\n");
 		return ret;
@@ -730,11 +739,21 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
 
 	snprintf(module->button_name, NAME_SIZE, "GB %d Button Jack",
 		 module->dev_id);
-	ret = snd_soc_jack_new(codec, module->button_name, module->button_mask,
-			       &module->button_jack);
+	button = devm_kzalloc(module->dev, sizeof(*button), GFP_KERNEL);
+	if (!button) {
+		ret = -ENOMEM;
+		goto free_headset;
+	}
+
+	button->pin = module->button_name;
+	button->mask = module->button_mask;
+
+	ret = snd_soc_card_jack_new(card, module->button_name,
+				    module->button_mask, &module->button_jack,
+				    button, 1);
 	if (ret) {
 		dev_err(module->dev, "Failed to create button jack\n");
-		return ret;
+		goto free_headset;
 	}
 
 	/*
@@ -750,7 +769,7 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
 				       KEY_MEDIA);
 		if (ret) {
 			dev_err(module->dev, "Failed to set BTN_0\n");
-			return ret;
+			goto free_button;
 		}
 	}
 
@@ -759,7 +778,7 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
 				       KEY_VOICECOMMAND);
 		if (ret) {
 			dev_err(module->dev, "Failed to set BTN_1\n");
-			return ret;
+			goto free_button;
 		}
 	}
 
@@ -768,7 +787,7 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
 				       KEY_VOLUMEUP);
 		if (ret) {
 			dev_err(module->dev, "Failed to set BTN_2\n");
-			return ret;
+			goto free_button;
 		}
 	}
 
@@ -777,7 +796,7 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
 				       KEY_VOLUMEDOWN);
 		if (ret) {
 			dev_err(module->dev, "Failed to set BTN_0\n");
-			return ret;
+			goto free_button;
 		}
 	}
 
@@ -788,6 +807,16 @@ static int gbaudio_init_jack(struct gbaudio_module_info *module,
 	*/
 
 	return 0;
+
+free_button:
+	snd_device_free(card->snd_card, module->button_jack.jack);
+	list_del(&module->button_jack.list);
+
+free_headset:
+	snd_device_free(card->snd_card, module->headset_jack.jack);
+	list_del(&module->headset_jack.list);
+
+	return ret;
 }
 
 int gbaudio_register_module(struct gbaudio_module_info *module)
@@ -815,7 +844,7 @@ int gbaudio_register_module(struct gbaudio_module_info *module)
 		return -EINVAL;
 	}
 
-	ret = gbaudio_init_jack(module, codec);
+	ret = gbaudio_init_jack(module, component->card);
 	if (ret) {
 		up_write(&card->controls_rwsem);
 		return ret;
@@ -942,7 +971,8 @@ void gbaudio_unregister_module(struct gbaudio_module_info *module)
 
 #ifdef CONFIG_SND_JACK
 	/* free jack devices for this module from codec->jack_list */
-	list_for_each_entry_safe(jack, next_j, &codec->jack_list, list) {
+	list_for_each_entry_safe(jack, next_j, &component->card->jack_list,
+				 list) {
 		if (jack == &module->headset_jack)
 			mask = GBCODEC_JACK_MASK;
 		else if (jack == &module->button_jack)
-- 
2.27.0

