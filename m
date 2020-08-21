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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A24AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 605FF20791
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gby67M+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgHUSy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgHUSxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:53:49 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED039C061575
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:53:48 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g26so2285033qka.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bv67ihDVTEDQj09PWsYiVKFEHQCcpRPrT/l21XbwLYo=;
        b=Gby67M+0otxTnK9cq9ag3I0A3lveDhPh6Ol2xqEFqNtiuxMZ27nOmuaxgfG1VPrDN1
         vwmQSv7qLGy7PBP/IUhBDmsI02bLEaj8y6TGcVG5MvHKbO7cTR2Ln9o9ctvsMeYjbdq3
         PUovRGMngHx2Ho3qa75Z7jetgTk3YWNmvQQALJ29POJgeeR18h6igCFZTfuKw1GebZtV
         rHTECVa05MByAhBtbRcyh/d+YkGiBtYcWFtLAqPvHxGtdAVwS3nTq5PDIlX3lfMhCLLo
         rMluF/s6KlEfiHUpPo7v6Jp4gCFdXaBgELcjuZKe6WLARDH8QbzmNyp8o2BSlqh0NQ2a
         G2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bv67ihDVTEDQj09PWsYiVKFEHQCcpRPrT/l21XbwLYo=;
        b=DgL9SKLPyDdMr9MKy6B1X58RFCZPJX8bn9w9bkY756srG+FfTJYSgU8hHcrcLwt9yt
         DWB03aWvRQYsNLWLGQbNJnIEhZdbfFUj1j70Czn87w8BOc+bNhwP8O1vJbgCQEt8Qc11
         lTp95tlPnh21bthFs7/5S0cLJ9kjABPxJkN6P1pGP7PW1tCmVhXV7XjXLo51aXsjqWQM
         7h2OVTouA2OevsQSd0SmbBnzxwQg8/xJF29Zi/gSz8G1lphebKaVkPXk0oolKkxh2ZwX
         U0S2kPTlTuDqKflbfujzdtS4YnErX/WKVT00Ip5WJrequs1ME5+lGoq1y7hw1ceak1qt
         3ZBw==
X-Gm-Message-State: AOAM532p5poKFHZW1iCF1e8+lUFJzjl0f977NsYgDTfgQW4Et0s7yJ2/
        cAmeIrXeZzLIpSHwq/9DAo0=
X-Google-Smtp-Source: ABdhPJw/Yb8quq3VibPNAzooWmG1jHpZroVZFnhNcooHuK/G7ca0kRmI/5tn0erShK29pdVTDnvgng==
X-Received: by 2002:ae9:e505:: with SMTP id w5mr3970052qkf.282.1598036028162;
        Fri, 21 Aug 2020 11:53:48 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id o72sm2468426qka.113.2020.08.21.11.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:53:47 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/20] ALSA: hda/ca0132 - Add full-range speaker selection controls.
Date:   Fri, 21 Aug 2020 14:52:21 -0400
Message-Id: <20200821185239.26133-5-conmanx360@gmail.com>
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

Add functions for setting full-range speakers and controls to
enable/disable the setting. Setting a speaker to full-range means that
the channels won't have their bass redirected to the LFE channel.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 117 +++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index dd580f4b741d..c9cd4fc218fe 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -147,6 +147,8 @@ enum {
 	AE5_SOUND_FILTER_ENUM,
 	ZXR_HEADPHONE_GAIN,
 	SPEAKER_CHANNEL_CFG_ENUM,
+	SPEAKER_FULL_RANGE_FRONT,
+	SPEAKER_FULL_RANGE_REAR,
 #define EFFECTS_COUNT  (EFFECT_END_NID - EFFECT_START_NID)
 };
 
@@ -592,6 +594,24 @@ static const struct ct_eq_preset ca0132_alt_eq_presets[] = {
 	}
 };
 
+/*
+ * DSP reqs for handling full-range speakers/bass redirection. If a speaker is
+ * set as not being full range, and bass redirection is enabled, all
+ * frequencies below the crossover frequency are redirected to the LFE
+ * channel. If the surround configuration has no LFE channel, this can't be
+ * enabled. X-Bass must be disabled when using these.
+ */
+enum speaker_range_reqs {
+	SPEAKER_BASS_REDIRECT            = 0x15,
+	SPEAKER_BASS_REDIRECT_XOVER_FREQ = 0x16,
+	/* Between 0x16-0x1a are the X-Bass reqs. */
+	SPEAKER_FULL_RANGE_FRONT_L_R     = 0x1a,
+	SPEAKER_FULL_RANGE_CENTER_LFE    = 0x1b,
+	SPEAKER_FULL_RANGE_REAR_L_R      = 0x1c,
+	SPEAKER_FULL_RANGE_SURROUND_L_R  = 0x1d,
+	SPEAKER_BASS_REDIRECT_SUB_GAIN   = 0x1e,
+};
+
 /*
  * Definitions for the DSP req's to handle speaker tuning. These all belong to
  * module ID 0x96, the output effects module.
@@ -1100,6 +1120,7 @@ struct ca0132_spec {
 	unsigned char in_enum_val;
 	unsigned char out_enum_val;
 	unsigned char channel_cfg_val;
+	unsigned char speaker_range_val[2];
 	unsigned char mic_boost_enum_val;
 	unsigned char smart_volume_setting;
 	long fx_ctl_val[EFFECT_LEVEL_SLIDERS];
@@ -4259,6 +4280,50 @@ static void ae5_mmio_select_out(struct hda_codec *codec)
 			ae5_ca0113_output_presets[spec->cur_out_type].vals[i]);
 }
 
+static int ca0132_alt_set_full_range_speaker(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int tmp;
+	int err;
+
+	/* 2.0/4.0 setup has no LFE channel, so setting full-range does nothing. */
+	if (spec->channel_cfg_val == SPEAKER_CHANNELS_4_0
+			|| spec->channel_cfg_val == SPEAKER_CHANNELS_2_0)
+		return 0;
+
+	/* Set front L/R full range. Zero for full-range, one for redirection. */
+	tmp = spec->speaker_range_val[0] ? FLOAT_ZERO : FLOAT_ONE;
+	err = dspio_set_uint_param(codec, 0x96,
+			SPEAKER_FULL_RANGE_FRONT_L_R, tmp);
+	if (err < 0)
+		return err;
+
+	/* When setting full-range rear, both rear and center/lfe are set. */
+	tmp = spec->speaker_range_val[1] ? FLOAT_ZERO : FLOAT_ONE;
+	err = dspio_set_uint_param(codec, 0x96,
+			SPEAKER_FULL_RANGE_CENTER_LFE, tmp);
+	if (err < 0)
+		return err;
+
+	err = dspio_set_uint_param(codec, 0x96,
+			SPEAKER_FULL_RANGE_REAR_L_R, tmp);
+	if (err < 0)
+		return err;
+
+	/*
+	 * Only the AE series cards set this value when setting full-range,
+	 * and it's always 1.0f.
+	 */
+	if (ca0132_quirk(spec) == QUIRK_AE5) {
+		err = dspio_set_uint_param(codec, 0x96,
+				SPEAKER_FULL_RANGE_SURROUND_L_R, FLOAT_ONE);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 /*
  * These are the commands needed to setup output on each of the different card
  * types.
@@ -4539,6 +4604,9 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 			goto exit;
 	}
 
+	if (spec->cur_out_type == SURROUND_OUT)
+		err = ca0132_alt_set_full_range_speaker(codec);
+
 exit:
 	snd_hda_power_down_pm(codec);
 
@@ -5269,6 +5337,7 @@ static int ca0132_alt_xbass_xover_slider_ctl_get(struct snd_kcontrol *kcontrol,
 	long *valp = ucontrol->value.integer.value;
 
 	*valp = spec->xbass_xover_freq;
+
 	return 0;
 }
 
@@ -5894,6 +5963,11 @@ static int ca0132_switch_get(struct snd_kcontrol *kcontrol,
 		return 0;
 	}
 
+	if (nid == SPEAKER_FULL_RANGE_FRONT || nid == SPEAKER_FULL_RANGE_REAR) {
+		*valp = spec->speaker_range_val[nid - SPEAKER_FULL_RANGE_FRONT];
+		return 0;
+	}
+
 	return 0;
 }
 
@@ -5972,6 +6046,14 @@ static int ca0132_switch_put(struct snd_kcontrol *kcontrol,
 		goto exit;
 	}
 
+	if (nid == SPEAKER_FULL_RANGE_FRONT || nid == SPEAKER_FULL_RANGE_REAR) {
+		spec->speaker_range_val[nid - SPEAKER_FULL_RANGE_FRONT] = *valp;
+		if (spec->cur_out_type == SURROUND_OUT)
+			ca0132_alt_set_full_range_speaker(codec);
+
+		changed = 0;
+	}
+
 exit:
 	snd_hda_power_down(codec);
 	return changed;
@@ -6329,6 +6411,31 @@ static int ca0132_alt_add_speaker_channel_cfg_enum(struct hda_codec *codec)
 				snd_ctl_new1(&knew, codec));
 }
 
+/*
+ * Full range front stereo and rear surround switches. When these are set to
+ * full range, the lower frequencies from these channels are no longer
+ * redirected to the LFE channel.
+ */
+static int ca0132_alt_add_front_full_range_switch(struct hda_codec *codec)
+{
+	struct snd_kcontrol_new knew =
+		CA0132_CODEC_MUTE_MONO("Output: Full-Range Front Playback Switch",
+				    SPEAKER_FULL_RANGE_FRONT, 1, HDA_OUTPUT);
+
+	return snd_hda_ctl_add(codec, SPEAKER_FULL_RANGE_FRONT,
+				snd_ctl_new1(&knew, codec));
+}
+
+static int ca0132_alt_add_rear_full_range_switch(struct hda_codec *codec)
+{
+	struct snd_kcontrol_new knew =
+		CA0132_CODEC_MUTE_MONO("Output: Full-Range Rear Playback Switch",
+				    SPEAKER_FULL_RANGE_REAR, 1, HDA_OUTPUT);
+
+	return snd_hda_ctl_add(codec, SPEAKER_FULL_RANGE_REAR,
+				snd_ctl_new1(&knew, codec));
+}
+
 /*
  * Create an Input Source enumerated control for the alternate ca0132 codecs
  * because the front microphone has no auto-detect, and Line-in has to be set
@@ -6636,6 +6743,12 @@ static int ca0132_build_controls(struct hda_codec *codec)
 		if (err < 0)
 			return err;
 		err = ca0132_alt_add_speaker_channel_cfg_enum(codec);
+		if (err < 0)
+			return err;
+		err = ca0132_alt_add_front_full_range_switch(codec);
+		if (err < 0)
+			return err;
+		err = ca0132_alt_add_rear_full_range_switch(codec);
 		if (err < 0)
 			return err;
 		err = ca0132_alt_add_mic_boost_enum(codec);
@@ -7982,6 +8095,10 @@ static void ca0132_init_chip(struct hda_codec *codec)
 	 * ca0132 codecs. Also sets x-bass crossover frequency to 80hz.
 	 */
 	if (ca0132_use_alt_controls(spec)) {
+		/* Set speakers to default to full range. */
+		spec->speaker_range_val[0] = 1;
+		spec->speaker_range_val[1] = 1;
+
 		spec->xbass_xover_freq = 8;
 		for (i = 0; i < EFFECT_LEVEL_SLIDERS; i++)
 			spec->fx_ctl_val[i] = effect_slider_defaults[i];
-- 
2.20.1

