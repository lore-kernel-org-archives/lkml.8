Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E26C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D41A8206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpJmF9im"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgFBFVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 01:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgFBFVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:21:47 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D63C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 22:21:47 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n2so857949pld.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 22:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HrE8jPu+eUk0rWTp09/AJ6eqmFiFFAxiAwX4LTYEZSI=;
        b=gpJmF9imy7EwPbtaigUBNEagjOGDTHD7fGkw4xKgjzwdrEDC95Xhb57T5uX5Cv2MYb
         EsIlOcMB0m4Sl/Y/j17qCRyftShvGybRddCKlD2EKGmKcig/PPIjsUbJBBHmfOgb/y14
         aLp8xW4F4acHz4tcakZ98Jo6bh1vl22/wf0uBDJuL+3cSJfwezXm8oDsD3PeVIMhYn/U
         FJ6yTQJaB5SVCNWXe2aJQ8peooqMUZTIqZlOyv/c1j/lxVpFseme/3udPj/dwPKEDXPf
         QqsX8S8kYLK9v1SQXu8zvztocBOWKIPVDLksgkkUCYlcANLGjmGplT/D5QRxqgY2TXVY
         PUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HrE8jPu+eUk0rWTp09/AJ6eqmFiFFAxiAwX4LTYEZSI=;
        b=NXjoLhK6d1KGLHNFANe4QU/UrUF9TYr/dw41AVHwh7FqD0PvLGNiBA7h+00AAkppY7
         tDu1fGNBltpxXcaY5AEWCLyz/3UvTSggRRFXiGoWGC86bYdutJ2/FuriGX2ujYtmEXA2
         ZuNXe6ay9lHek45A4Udd01ZV7xFs6wO+zuqqzsMa4nBuYfiD+eeSDt5vF+hZ4PLvZgEi
         e/EAEexGwhXTETGnuZzOgSHIaidq+1dDvRpI4hHgXEuiVbS3nSwwTujFRjTO+wej8KVL
         zX2QBVYIUGi07Mc2J/TOYBjLs0AADpM6IdAGL2Pc5I6Z7AJIHwuVYCseNK6oYEbcbCBP
         Z6/Q==
X-Gm-Message-State: AOAM5323WoZaJuw4RGRzyddkJcS7czzuglGeTvNbo+3Q2gCPC66DnzvW
        bG+HnMkBsluBm3vf2wbhhMY=
X-Google-Smtp-Source: ABdhPJwliQkS5O5QAObRlb1MPyWfpR5B70bSXSCGtCR9PUV8lwzDthFzWXZlc9YWILqypdxgX7VFnQ==
X-Received: by 2002:a17:90a:20a2:: with SMTP id f31mr318401pjg.34.1591075306770;
        Mon, 01 Jun 2020 22:21:46 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com ([192.55.55.41])
        by smtp.googlemail.com with ESMTPSA id f18sm1004764pga.75.2020.06.01.22.21.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2020 22:21:46 -0700 (PDT)
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
Subject: [RESEND PATCH v1 1/6] staging: greybus: audio: Update snd_jack FW usage as per new APIs
Date:   Tue,  2 Jun 2020 10:51:10 +0530
Message-Id: <1ee2783b64c68e49880f88457655648ac45bbcb8.1591040859.git.vaibhav.sr@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591040859.git.vaibhav.sr@gmail.com>
References: <cover.1591040859.git.vaibhav.sr@gmail.com>
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
---
 drivers/staging/greybus/audio_codec.c | 59 +++++++++++++++++++++------
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
2.26.2

