Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F653C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 11:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 412C2207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 11:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFodsMXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732678AbgFSLVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 07:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730962AbgFSLVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 07:21:00 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49351C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 04:21:00 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d8so3805909plo.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 04:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4+zEUtuyQ6hqqALnGkDhXNleDNcn5cF9BtJWeUpqVO8=;
        b=hFodsMXtiPZPtBAufX9DyF6NpkvKPuJrOJRvDePsYjS1eXvUBxFQc1FTIlCEfTl0ys
         +ro6z9fujQmNs7ezzT4bKhGWGIYWGxyVXl0hDsojQgMasZ5R3iLhPqJ1vJEnP7rvSz6P
         UqlZO+hzNsm2OB7YciR9tmna4vksGD0RFrSs7J44fkMTdufLO3VQzvOzguuuOH6C34VZ
         vw9bB7fl08qmS7X3Ug3f27OvMyE0UMFlnu1b4Dw/qXQH59bGFriTnsmEoPCRlmgk/Hq6
         WPywB8tMXrk8xNbKmaq87/jBLsqFCzsKvHSJhty50EROV2V2NEnJm3dOHoDEeIJ0bY4P
         FaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4+zEUtuyQ6hqqALnGkDhXNleDNcn5cF9BtJWeUpqVO8=;
        b=TE5WWVW7rfvfMM/UvO8YtmaGyDLGa1O3eAprfV8fKEpvwJUDgpmvMMhXJGamn90bQ9
         HJLjF8FNNhxLAKN/ApiMSchRJH6ak5XXTgwL/apOYbiy81rg2ldul+BPJua26jcJBqmy
         3o20HQ8L2ijakMpiu7OJZcP/4E9KB52E8bum8Ix96yJBrjyrm57oRLU8unmBBwuHge7a
         JQxVztlycW6Ga8ycyjlpZ1kcOLcWPySuvQEZ9t0DvqezOeD+BibHXYZ14qHQhyEVsp5o
         BrEgkJHYz68D56Vdvsr45QICzbskb4F2FNglvHGPxWciFnekuPWqCCsW5xYIL9F5H42j
         gymA==
X-Gm-Message-State: AOAM533F2LcknwudHkJVZ9QyI0223QzRXMARsMBUyA1kJXjZ+Fium4+s
        zP/owXI+E5/y0anRTc9K+NU=
X-Google-Smtp-Source: ABdhPJyzMTyQ+hSUjn3mrajvpT7mxESxVd7RGiO7HlQ/yZkBAmMzmGRrZQYPwTMI1xwso49p/jzGVA==
X-Received: by 2002:a17:90a:1aaa:: with SMTP id p39mr3152582pjp.127.1592565659694;
        Fri, 19 Jun 2020 04:20:59 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com ([192.55.55.41])
        by smtp.googlemail.com with ESMTPSA id d9sm4974293pgg.74.2020.06.19.04.20.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 04:20:59 -0700 (PDT)
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v3 1/6] staging: greybus: audio: Update snd_jack FW usage as per new APIs
Date:   Fri, 19 Jun 2020 16:50:21 +0530
Message-Id: <3eb377f467ef07e3da1367a02b7b7cf70380a53f.1592537217.git.vaibhav.sr@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592537217.git.vaibhav.sr@gmail.com>
References: <cover.1592537217.git.vaibhav.sr@gmail.com>
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
2.26.2

