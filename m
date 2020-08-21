Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D884CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF67A20714
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtcR+PR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgHUSzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbgHUSxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:53:55 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9DCC061755
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:53:54 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 2so2258907qkf.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+fpJmzjQ6yOdK1U34PvE0n10FIQEsQXTA6sxXU+2uuA=;
        b=PtcR+PR6yoXB9yF0RTUjhLLqKrM+PtEvP7kr8PZkI7AZ2wc5xSzUKpgMtfRhS1BNPk
         anBiPVU+p+AksWlo31HPkFkwlN2wj6hNxQcqVg6Keyiej8jR+nT2lScNHcV6EeWlAI0j
         /KquUpE7ziaDYEgJnp2/gTvdA/WWWhO6VolgfKjyHP9WAYBO/MVw6o2vrTZPLAwBzW3J
         anyK1chhyp2jitSMRSo8oa0wf8uTZImN1w9NObazUHLCdMfUomiKEVdJNW4N4SfJcPs5
         a0ZrJlJEjJLmUd7IB/CFbwQ5emgP+NIABT/KiFTtmgXlAznQi+uGPP/lMWgGcG0wzPcV
         4gmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+fpJmzjQ6yOdK1U34PvE0n10FIQEsQXTA6sxXU+2uuA=;
        b=Mj9cx8kOFMsn0wpt7pWcHLeRkUkQroQBBAkp9dROV6CzrIfr9fKwYavsG7xZyjYZeR
         7tvM6yPUYjYkI6dLgBfTL4Lr2bvigsCDlfobyhqw9ZGsSawPJIZAuIdNqg4FffTcLFmp
         Yt0tJqG49rQjuuUFcU2BEPoXzMWz1yrUwLhpDqO0k2BBjm86te68YyK4GRyzVK80Dk6X
         WcKuEVkeRlhoEd3DPdyP4Li1a2lIAfG1tCn3RdRvl/vnXG5NopSlHJY8u6meKLGCwEhv
         whdYFbeyuHM4gUGVCtZhvr44MxIdGZmSV7KrLS934tKHyNJE+wh9IbL4rPyj32RtAAz4
         DDDQ==
X-Gm-Message-State: AOAM5323BupFQXzOCiWLORvRwZVzxK7ZO0LF3Acvtl5xvNsRr/5kXfJ0
        8Ov+v8Jxwz1e+ROb4yKWYvI=
X-Google-Smtp-Source: ABdhPJwVRDMdrHMcYK2bjCibu2wJPEKwhDlVxZZFBvfSPTJizNC167ezHaefNmqRF9YvfV5ymNpDvg==
X-Received: by 2002:a37:5dc6:: with SMTP id r189mr3968942qkb.364.1598036034011;
        Fri, 21 Aug 2020 11:53:54 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id o72sm2468426qka.113.2020.08.21.11.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:53:53 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/20] ALSA: hda/ca0132 - Clean up ca0132_alt_out_select.
Date:   Fri, 21 Aug 2020 14:52:24 -0400
Message-Id: <20200821185239.26133-8-conmanx360@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200821185239.26133-1-conmanx360@gmail.com>
References: <20200821185239.26133-1-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the output structures that were in use before and instead set the
DSP commands line by line. Now that the commands use is known, it makes
the functionality more clear this way.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 142 ++++++++++++++---------------------
 1 file changed, 57 insertions(+), 85 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index f0fa1e8f41da..ee25265ab600 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -83,6 +83,7 @@ MODULE_FIRMWARE(R3DI_EFX_FILE);
 static const char *const dirstr[2] = { "Playback", "Capture" };
 
 #define NUM_OF_OUTPUTS 2
+static const char *const out_type_str[2] = { "Speakers", "Headphone" };
 enum {
 	SPEAKER_OUT,
 	HEADPHONE_OUT,
@@ -667,39 +668,6 @@ enum speaker_tuning_reqs {
 	SPEAKER_TUNING_MUTE                     = 0x3a,
 };
 
-/* DSP command sequences for ca0132_alt_select_out */
-#define ALT_OUT_SET_MAX_COMMANDS 9 /* Max number of commands in sequence */
-struct ca0132_alt_out_set {
-	char *name; /*preset name*/
-	unsigned char commands;
-	unsigned int mids[ALT_OUT_SET_MAX_COMMANDS];
-	unsigned int reqs[ALT_OUT_SET_MAX_COMMANDS];
-	unsigned int vals[ALT_OUT_SET_MAX_COMMANDS];
-};
-
-static const struct ca0132_alt_out_set alt_out_presets[] = {
-	{ .name = "Line Out",
-	  .commands = 7,
-	  .mids = { 0x96, 0x96, 0x96, 0x8F,
-		    0x96, 0x96, 0x96 },
-	  .reqs = { 0x19, 0x17, 0x18, 0x01,
-		    0x1F, 0x15, 0x3A },
-	  .vals = { 0x3F000000, 0x42A00000, 0x00000000,
-		    0x00000000, 0x00000000, 0x00000000,
-		    0x00000000 }
-	},
-	{ .name = "Headphone",
-	  .commands = 7,
-	  .mids = { 0x96, 0x96, 0x96, 0x8F,
-		    0x96, 0x96, 0x96 },
-	  .reqs = { 0x19, 0x17, 0x18, 0x01,
-		    0x1F, 0x15, 0x3A },
-	  .vals = { 0x3F000000, 0x42A00000, 0x00000000,
-		    0x00000000, 0x00000000, 0x00000000,
-		    0x00000000 }
-	},
-};
-
 /* Surround output channel count configuration structures. */
 #define SPEAKER_CHANNEL_CFG_COUNT 5
 enum {
@@ -4428,21 +4396,31 @@ static void ca0132_alt_select_out_quirk_handler(struct hda_codec *codec)
 	}
 }
 
+static void ca0132_set_out_node_pincfg(struct hda_codec *codec, hda_nid_t nid,
+		bool out_enable, bool hp_enable)
+{
+	unsigned int pin_ctl;
+
+	pin_ctl = snd_hda_codec_read(codec, nid, 0,
+			AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+
+	pin_ctl = hp_enable ? pin_ctl | PIN_HP_AMP : pin_ctl & ~PIN_HP_AMP;
+	pin_ctl = out_enable ? pin_ctl | PIN_OUT : pin_ctl & ~PIN_OUT;
+	snd_hda_set_pin_ctl(codec, nid, pin_ctl);
+}
+
 /*
  * This function behaves similarly to the ca0132_select_out funciton above,
  * except with a few differences. It adds the ability to select the current
  * output with an enumerated control "output source" if the auto detect
  * mute switch is set to off. If the auto detect mute switch is enabled, it
  * will detect either headphone or lineout(SPEAKER_OUT) from jack detection.
- * It also adds the ability to auto-detect the front headphone port. The only
- * way to select surround is to disable auto detect, and set Surround with the
- * enumerated control.
+ * It also adds the ability to auto-detect the front headphone port.
  */
 static int ca0132_alt_select_out(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
-	unsigned int tmp, outfx_set, i;
-	unsigned int pin_ctl;
+	unsigned int tmp, outfx_set;
 	int jack_present;
 	int auto_jack;
 	int err;
@@ -4473,9 +4451,8 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 
 	outfx_set = spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID];
 
-	/* Begin DSP output switch */
-	tmp = FLOAT_ONE;
-	err = dspio_set_uint_param(codec, 0x96, 0x3A, tmp);
+	/* Begin DSP output switch, mute DSP volume. */
+	err = dspio_set_uint_param(codec, 0x96, SPEAKER_TUNING_MUTE, FLOAT_ONE);
 	if (err < 0)
 		goto exit;
 
@@ -4485,31 +4462,18 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 	case SPEAKER_OUT:
 		codec_dbg(codec, "%s speaker\n", __func__);
 
-		/* disable headphone node */
-
-		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[1], 0,
-					AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
-		snd_hda_set_pin_ctl(codec, spec->out_pins[1],
-				    pin_ctl & ~PIN_HP);
-		/* enable line-out node */
-		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[0], 0,
-				AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
-		snd_hda_set_pin_ctl(codec, spec->out_pins[0],
-				    pin_ctl | PIN_OUT);
 		/* Enable EAPD */
 		snd_hda_codec_write(codec, spec->out_pins[0], 0,
 			AC_VERB_SET_EAPD_BTLENABLE, 0x01);
 
-		/* enable center/lfe out node */
-		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[2], 0,
-				AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
-		snd_hda_set_pin_ctl(codec, spec->out_pins[2],
-				pin_ctl | PIN_OUT);
-		/* Now set rear surround node as out. */
-		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[3], 0,
-				AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
-		snd_hda_set_pin_ctl(codec, spec->out_pins[3],
-				pin_ctl | PIN_OUT);
+		/* Disable headphone node. */
+		ca0132_set_out_node_pincfg(codec, spec->out_pins[1], 0, 0);
+		/* Set front L-R to output. */
+		ca0132_set_out_node_pincfg(codec, spec->out_pins[0], 1, 0);
+		/* Set Center/LFE to output. */
+		ca0132_set_out_node_pincfg(codec, spec->out_pins[2], 1, 0);
+		/* Set rear surround to output. */
+		ca0132_set_out_node_pincfg(codec, spec->out_pins[3], 1, 0);
 
 		/*
 		 * Without PlayEnhancement being enabled, if we've got a 2.0
@@ -4531,11 +4495,10 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 		snd_hda_codec_write(codec, spec->out_pins[0], 0,
 			AC_VERB_SET_EAPD_BTLENABLE, 0x00);
 
-		/* disable speaker*/
-		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[0], 0,
-					AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
-		snd_hda_set_pin_ctl(codec, spec->out_pins[0],
-				pin_ctl & ~PIN_HP);
+		/* Disable all speaker nodes. */
+		ca0132_set_out_node_pincfg(codec, spec->out_pins[0], 0, 0);
+		ca0132_set_out_node_pincfg(codec, spec->out_pins[2], 0, 0);
+		ca0132_set_out_node_pincfg(codec, spec->out_pins[3], 0, 0);
 
 		/* enable headphone, either front or rear */
 		if (snd_hda_jack_detect(codec, spec->unsol_tag_front_hp))
@@ -4543,15 +4506,15 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 		else if (snd_hda_jack_detect(codec, spec->unsol_tag_hp))
 			headphone_nid = spec->out_pins[1];
 
-		pin_ctl = snd_hda_codec_read(codec, headphone_nid, 0,
-					AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
-		snd_hda_set_pin_ctl(codec, headphone_nid,
-				    pin_ctl | PIN_HP);
+		ca0132_set_out_node_pincfg(codec, headphone_nid, 1, 1);
 
 		if (outfx_set)
-			dspio_set_uint_param(codec, 0x80, 0x04, FLOAT_ONE);
+			err = dspio_set_uint_param(codec, 0x80, 0x04, FLOAT_ONE);
 		else
-			dspio_set_uint_param(codec, 0x80, 0x04, FLOAT_ZERO);
+			err = dspio_set_uint_param(codec, 0x80, 0x04, FLOAT_ZERO);
+
+		if (err < 0)
+			goto exit;
 		break;
 	}
 	/*
@@ -4563,29 +4526,38 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 		ca0132_effects_set(codec, X_BASS,
 			spec->effects_switch[X_BASS - EFFECT_START_NID]);
 
+	/* Set speaker EQ bypass attenuation to 0. */
+	err = dspio_set_uint_param(codec, 0x8f, 0x01, FLOAT_ZERO);
+	if (err < 0)
+		goto exit;
+
+	/*
+	 * Although unused on all cards but the AE series, this is always set
+	 * to zero when setting the output.
+	 */
+	err = dspio_set_uint_param(codec, 0x96,
+			SPEAKER_TUNING_USE_SPEAKER_EQ, FLOAT_ZERO);
+	if (err < 0)
+		goto exit;
+
 	if (spec->cur_out_type == SPEAKER_OUT)
 		err = ca0132_alt_surround_set_bass_redirection(codec,
 				spec->bass_redirection_val);
 	else
 		err = ca0132_alt_surround_set_bass_redirection(codec, 0);
 
+	/* Unmute DSP now that we're done with output selection. */
+	err = dspio_set_uint_param(codec, 0x96,
+			SPEAKER_TUNING_MUTE, FLOAT_ZERO);
 	if (err < 0)
 		goto exit;
 
-	/* run through the output dsp commands for the selected output. */
-	for (i = 0; i < alt_out_presets[spec->cur_out_type].commands; i++) {
-		err = dspio_set_uint_param(codec,
-		alt_out_presets[spec->cur_out_type].mids[i],
-		alt_out_presets[spec->cur_out_type].reqs[i],
-		alt_out_presets[spec->cur_out_type].vals[i]);
-
+	if (spec->cur_out_type == SPEAKER_OUT) {
+		err = ca0132_alt_set_full_range_speaker(codec);
 		if (err < 0)
 			goto exit;
 	}
 
-	if (spec->cur_out_type == SPEAKER_OUT)
-		err = ca0132_alt_set_full_range_speaker(codec);
-
 exit:
 	snd_hda_power_down_pm(codec);
 
@@ -5659,7 +5631,7 @@ static int ca0132_alt_output_select_get_info(struct snd_kcontrol *kcontrol,
 	if (uinfo->value.enumerated.item >= NUM_OF_OUTPUTS)
 		uinfo->value.enumerated.item = NUM_OF_OUTPUTS - 1;
 	strcpy(uinfo->value.enumerated.name,
-			alt_out_presets[uinfo->value.enumerated.item].name);
+			out_type_str[uinfo->value.enumerated.item]);
 	return 0;
 }
 
@@ -5686,7 +5658,7 @@ static int ca0132_alt_output_select_put(struct snd_kcontrol *kcontrol,
 		return 0;
 
 	codec_dbg(codec, "ca0132_alt_output_select: sel=%d, preset=%s\n",
-		    sel, alt_out_presets[sel].name);
+		    sel, out_type_str[sel]);
 
 	spec->out_enum_val = sel;
 
-- 
2.20.1

