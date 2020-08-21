Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F006C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF5E2076E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="raP3mKr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgHUSyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgHUSxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:53:47 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A53FC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:53:47 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b14so2275795qkn.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uImsmBH23sPzP3vG0wZJKpZ9lS3yeqtfWSNpQPrME7M=;
        b=raP3mKr4A7lnhwddtOU+KsHFwBsUfU4DmOvFodZ+ZhAMifIa7LyDs/w3RVN7QwyTKz
         xHqYwgLYcZVk92DNa3a4MJWTDZjVpQcElsZqXw8d3o8F4wA1YAI2J7+BXS5jFkkHK5Z2
         WQHrbEYeVjcIcs6fKCHPUMoNguLMKvJ7grffrCMjN7BZlz0CKauNeSdortWL0+CpCTSQ
         DA6g4QFA4fYt2Cn8yTOIrakh9wFardQT5YqDuThT4O958X+TwTt/Tg1Smf/5SJtcWfoA
         e8Z4TpIGnGUu3GgsRpHaAVoE0wSjzIqucJ7oq8yWRrFW7UbfRQprt21A1G3vn4cO+fHR
         /nIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uImsmBH23sPzP3vG0wZJKpZ9lS3yeqtfWSNpQPrME7M=;
        b=b6QiKsruXUs0usincbL5zet79kI/m76Wn+G0xQkMT1DUA1b8TBKiTt/3R2Y5S9JI+N
         OmO3XVBrTehk0pK+AxnSXiL7c/3WE6YtyprFa6JDZi5TNhgZM4se70mY7iZqgthM5WMF
         DkO9Q7mhS+xIOUaJm8cKyPzOqAIf7xI8JTfj0kInyIn0MCE25UCGyiTGPiRMHwOUzpdb
         /LZyZ98xIr1TvL1J4jSpuKnjAN+B8EeP2CSn2TyEmfR6HsHHRbnmPS8Q94HENI1uvdqa
         NV9vBpjprIhAOTSEpPIz3keTWJMEtwKozvgUDTzos/J/pW4plRAoPLY6YiiZEzrQ6Fu5
         ljLQ==
X-Gm-Message-State: AOAM533ldRYzkNh678HAzxwF6TvGIxOCGRC7pLsqAeAZgYYb6Q5htHoL
        l3XrN45XSH3PyR89NZQz6t8=
X-Google-Smtp-Source: ABdhPJyr5jyoZ/GtZeTtX0UPtZQ/tbTvKysNEHQZjPE6u8dqrcTpgGdOzLcDqfn4X6wl7Z9eCKaAdg==
X-Received: by 2002:ae9:e30f:: with SMTP id v15mr4132536qkf.331.1598036026204;
        Fri, 21 Aug 2020 11:53:46 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id o72sm2468426qka.113.2020.08.21.11.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:53:45 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/20] ALSA: hda/ca0132 - Add surround channel config control.
Date:   Fri, 21 Aug 2020 14:52:20 -0400
Message-Id: <20200821185239.26133-4-conmanx360@gmail.com>
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

Add a surround channel configuration enumeration control. Setting up
different channel configurations allows the DSP to upmix stereo audio
into multi-channel audio, and allows for redirection of bass to a
subwoofer.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 110 ++++++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 2e664aeee1c4..dd580f4b741d 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -38,6 +38,8 @@
 #define FLOAT_ONE	0x3f800000
 #define FLOAT_TWO	0x40000000
 #define FLOAT_THREE     0x40400000
+#define FLOAT_FIVE	0x40a00000
+#define FLOAT_SIX       0x40c00000
 #define FLOAT_EIGHT     0x41000000
 #define FLOAT_MINUS_5	0xc0a00000
 
@@ -143,7 +145,8 @@ enum {
 	MIC_BOOST_ENUM,
 	AE5_HEADPHONE_GAIN_ENUM,
 	AE5_SOUND_FILTER_ENUM,
-	ZXR_HEADPHONE_GAIN
+	ZXR_HEADPHONE_GAIN,
+	SPEAKER_CHANNEL_CFG_ENUM,
 #define EFFECTS_COUNT  (EFFECT_END_NID - EFFECT_START_NID)
 };
 
@@ -686,6 +689,39 @@ static const struct ca0132_alt_out_set alt_out_presets[] = {
 	}
 };
 
+/* Surround output channel count configuration structures. */
+#define SPEAKER_CHANNEL_CFG_COUNT 5
+enum {
+	SPEAKER_CHANNELS_2_0,
+	SPEAKER_CHANNELS_2_1,
+	SPEAKER_CHANNELS_4_0,
+	SPEAKER_CHANNELS_4_1,
+	SPEAKER_CHANNELS_5_1,
+};
+
+struct ca0132_alt_speaker_channel_cfg {
+	char *name;
+	unsigned int val;
+};
+
+static const struct ca0132_alt_speaker_channel_cfg speaker_channel_cfgs[] = {
+	{ .name = "2.0",
+	  .val = FLOAT_ONE
+	},
+	{ .name = "2.1",
+	  .val = FLOAT_TWO
+	},
+	{ .name = "4.0",
+	  .val = FLOAT_FIVE
+	},
+	{ .name = "4.1",
+	  .val = FLOAT_SIX
+	},
+	{ .name = "5.1",
+	  .val = FLOAT_EIGHT
+	}
+};
+
 /*
  * DSP volume setting structs. Req 1 is left volume, req 2 is right volume,
  * and I don't know what the third req is, but it's always zero. I assume it's
@@ -1063,6 +1099,7 @@ struct ca0132_spec {
 	/* ca0132_alt control related values */
 	unsigned char in_enum_val;
 	unsigned char out_enum_val;
+	unsigned char channel_cfg_val;
 	unsigned char mic_boost_enum_val;
 	unsigned char smart_volume_setting;
 	long fx_ctl_val[EFFECT_LEVEL_SLIDERS];
@@ -4476,7 +4513,8 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 		snd_hda_set_pin_ctl(codec, spec->out_pins[3],
 				    pin_ctl | PIN_OUT);
 
-		dspio_set_uint_param(codec, 0x80, 0x04, FLOAT_EIGHT);
+		tmp = speaker_channel_cfgs[spec->channel_cfg_val].val;
+		dspio_set_uint_param(codec, 0x80, 0x04, tmp);
 		break;
 	}
 	/*
@@ -5582,6 +5620,54 @@ static int ca0132_alt_output_select_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
+/* Select surround output type: 2.1, 4.0, 4.1, or 5.1. */
+static int ca0132_alt_speaker_channel_cfg_get_info(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_info *uinfo)
+{
+	unsigned int items = SPEAKER_CHANNEL_CFG_COUNT;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = items;
+	if (uinfo->value.enumerated.item >= items)
+		uinfo->value.enumerated.item = items - 1;
+	strcpy(uinfo->value.enumerated.name,
+			speaker_channel_cfgs[uinfo->value.enumerated.item].name);
+	return 0;
+}
+
+static int ca0132_alt_speaker_channel_cfg_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+
+	ucontrol->value.enumerated.item[0] = spec->channel_cfg_val;
+	return 0;
+}
+
+static int ca0132_alt_speaker_channel_cfg_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct ca0132_spec *spec = codec->spec;
+	int sel = ucontrol->value.enumerated.item[0];
+	unsigned int items = SPEAKER_CHANNEL_CFG_COUNT;
+
+	if (sel >= items)
+		return 0;
+
+	codec_dbg(codec, "ca0132_alt_speaker_channels: sel=%d, channels=%s\n",
+		    sel, speaker_channel_cfgs[sel].name);
+
+	spec->channel_cfg_val = sel;
+
+	if (spec->out_enum_val == SURROUND_OUT)
+		ca0132_alt_select_out(codec);
+
+	return 1;
+}
+
 /*
  * Smart Volume output setting control. Three different settings, Normal,
  * which takes the value from the smart volume slider. The two others, loud
@@ -6226,6 +6312,23 @@ static int ca0132_alt_add_output_enum(struct hda_codec *codec)
 				snd_ctl_new1(&knew, codec));
 }
 
+/*
+ * Add a control for selecting channel count on speaker output. Setting this
+ * allows the DSP to do bass redirection and channel upmixing on surround
+ * configurations.
+ */
+static int ca0132_alt_add_speaker_channel_cfg_enum(struct hda_codec *codec)
+{
+	struct snd_kcontrol_new knew =
+		HDA_CODEC_MUTE_MONO("Output: Channels",
+				    SPEAKER_CHANNEL_CFG_ENUM, 1, 0, HDA_OUTPUT);
+	knew.info = ca0132_alt_speaker_channel_cfg_get_info;
+	knew.get = ca0132_alt_speaker_channel_cfg_get;
+	knew.put = ca0132_alt_speaker_channel_cfg_put;
+	return snd_hda_ctl_add(codec, SPEAKER_CHANNEL_CFG_ENUM,
+				snd_ctl_new1(&knew, codec));
+}
+
 /*
  * Create an Input Source enumerated control for the alternate ca0132 codecs
  * because the front microphone has no auto-detect, and Line-in has to be set
@@ -6530,6 +6633,9 @@ static int ca0132_build_controls(struct hda_codec *codec)
 	 */
 	if (ca0132_use_alt_functions(spec)) {
 		err = ca0132_alt_add_output_enum(codec);
+		if (err < 0)
+			return err;
+		err = ca0132_alt_add_speaker_channel_cfg_enum(codec);
 		if (err < 0)
 			return err;
 		err = ca0132_alt_add_mic_boost_enum(codec);
-- 
2.20.1

