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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D26C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E644F20748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZySkau+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgHUSyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgHUSxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:53:51 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD8AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:53:50 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id v22so1933894qtq.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GP5vIYZDE5wLQloDqHwwOOSc6E8YyrpTpCW1tgf7iiM=;
        b=BZySkau+Lmb4Mn7kwLID8XWciUtg9EQYdPQ41jEmFjltAl0Mpxpqey0ii9hlyV+tqf
         T48NHqDEs1yxgc3qkGmJCTTz5E+o6opRPKR4937Wi732O5CldMKxnUiSayTjExLnCOvU
         I1HvFg0g91vM50EgrZ8vYtpf5ep/MiF7RpJ+gmcuiNZfwq0mZcPiRXyDR9pCEWf5q1NZ
         3FvwJLgzYjwx9YNgT3rkno1CQBgUgc5WIIR3PfkBguXnAvBGrTAaHbz9JyHbZLdM9Qg5
         lyat9CdodV9zduPNynOuYUPjDftdNyfyw0fPcjPIlTNhfOFAcHGycDqfD4ICa3LQ5CsU
         ATng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GP5vIYZDE5wLQloDqHwwOOSc6E8YyrpTpCW1tgf7iiM=;
        b=JPtgBHI+hASMB1MLMmkrFq3KJMXQ1dmQoVHjgc+p1+DliGVSOc6Rv3On0t1S/yMEFS
         BD4QQ5zerxudh5lDqyqU2na9kNfdXlxCinD+HLrY01Z8PJUxTQXGNSNjDFbV1j/Ow1Dc
         NxKlXjYMGd3f/3J0+kecs/OwDaWanUmplj08km2JNvtWL2O+vC9c0/6OqHMJpacWMNPA
         2zTZOea+/yM+ugv9cuuQIXEjrwZLtjHKlFmR7ecWdLts+ik1Ckx71K9GHAeUf7kxeAkB
         fuK0rH/1A3g48lPVamsPtEWlf+pjV3gxVhTXv/JndHfcxrjKYc9VMIMVolawJ2bom7ie
         PEfA==
X-Gm-Message-State: AOAM533CfGrtGtnuDGwqYY8zBOksMyBWVfVIHh4WPazMZgn5kOcXDVlY
        Ugm6HdBY94UVLfcifEyUENI=
X-Google-Smtp-Source: ABdhPJwq9xnhoPY81WJaYWLW9xZcomJNImjoRqEUOGfPKHuinRvHVD/BHOR0sivtN3KZ2o3MtyMELg==
X-Received: by 2002:ac8:431a:: with SMTP id z26mr4015779qtm.298.1598036030149;
        Fri, 21 Aug 2020 11:53:50 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id o72sm2468426qka.113.2020.08.21.11.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:53:49 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/20] ALSA: hda/ca0132 - Add bass redirection controls.
Date:   Fri, 21 Aug 2020 14:52:22 -0400
Message-Id: <20200821185239.26133-6-conmanx360@gmail.com>
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

Add bass redirection controls for surround outputs. This uses the DSP to
redirect audio below the bass redirection crossover frequency to the LFE
channel from the front/rear L/R speakers. This only goes into effect if
the speakers aren't set as full range, and only if the surround
configuration has an LFE channel.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 130 +++++++++++++++++++++++++++++++++--
 1 file changed, 126 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index c9cd4fc218fe..d97358406401 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -149,6 +149,8 @@ enum {
 	SPEAKER_CHANNEL_CFG_ENUM,
 	SPEAKER_FULL_RANGE_FRONT,
 	SPEAKER_FULL_RANGE_REAR,
+	BASS_REDIRECTION,
+	BASS_REDIRECTION_XOVER,
 #define EFFECTS_COUNT  (EFFECT_END_NID - EFFECT_START_NID)
 };
 
@@ -1123,6 +1125,8 @@ struct ca0132_spec {
 	unsigned char speaker_range_val[2];
 	unsigned char mic_boost_enum_val;
 	unsigned char smart_volume_setting;
+	unsigned char bass_redirection_val;
+	long bass_redirect_xover_freq;
 	long fx_ctl_val[EFFECT_LEVEL_SLIDERS];
 	long xbass_xover_freq;
 	long eq_preset_val;
@@ -4324,6 +4328,35 @@ static int ca0132_alt_set_full_range_speaker(struct hda_codec *codec)
 	return 0;
 }
 
+static int ca0132_alt_surround_set_bass_redirection(struct hda_codec *codec,
+		bool val)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int tmp;
+	int err;
+
+	if (val && spec->channel_cfg_val != SPEAKER_CHANNELS_4_0 &&
+			spec->channel_cfg_val != SPEAKER_CHANNELS_2_0)
+		tmp = FLOAT_ONE;
+	else
+		tmp = FLOAT_ZERO;
+
+	err = dspio_set_uint_param(codec, 0x96, SPEAKER_BASS_REDIRECT, tmp);
+	if (err < 0)
+		return err;
+
+	/* If it is enabled, make sure to set the crossover frequency. */
+	if (tmp) {
+		tmp = float_xbass_xover_lookup[spec->xbass_xover_freq];
+		err = dspio_set_uint_param(codec, 0x96,
+				SPEAKER_BASS_REDIRECT_XOVER_FREQ, tmp);
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
@@ -4593,6 +4626,15 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 		ca0132_effects_set(codec, X_BASS,
 			spec->effects_switch[X_BASS - EFFECT_START_NID]);
 
+	if (spec->cur_out_type == SURROUND_OUT)
+		err = ca0132_alt_surround_set_bass_redirection(codec,
+				spec->bass_redirection_val);
+	else
+		err = ca0132_alt_surround_set_bass_redirection(codec, 0);
+
+	if (err < 0)
+		goto exit;
+
 	/* run through the output dsp commands for the selected output. */
 	for (i = 0; i < alt_out_presets[spec->cur_out_type].commands; i++) {
 		err = dspio_set_uint_param(codec,
@@ -5282,6 +5324,18 @@ static int ca0132_vnode_switch_set(struct snd_kcontrol *kcontrol,
 	return ret;
 }
 /* End of control change helpers. */
+
+static void ca0132_alt_bass_redirection_xover_set(struct hda_codec *codec,
+		long idx)
+{
+	snd_hda_power_up(codec);
+
+	dspio_set_param(codec, 0x96, 0x20, SPEAKER_BASS_REDIRECT_XOVER_FREQ,
+			&(float_xbass_xover_lookup[idx]), sizeof(unsigned int));
+
+	snd_hda_power_down(codec);
+}
+
 /*
  * Below I've added controls to mess with the effect levels, I've only enabled
  * them on the Sound Blaster Z, but they would probably also work on the
@@ -5290,6 +5344,7 @@ static int ca0132_vnode_switch_set(struct snd_kcontrol *kcontrol,
  */
 
 /* Sets DSP effect level from the sliders above the controls */
+
 static int ca0132_alt_slider_ctl_set(struct hda_codec *codec, hda_nid_t nid,
 			  const unsigned int *lookup, int idx)
 {
@@ -5335,8 +5390,12 @@ static int ca0132_alt_xbass_xover_slider_ctl_get(struct snd_kcontrol *kcontrol,
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct ca0132_spec *spec = codec->spec;
 	long *valp = ucontrol->value.integer.value;
+	hda_nid_t nid = get_amp_nid(kcontrol);
 
-	*valp = spec->xbass_xover_freq;
+	if (nid == BASS_REDIRECTION_XOVER)
+		*valp = spec->bass_redirect_xover_freq;
+	else
+		*valp = spec->xbass_xover_freq;
 
 	return 0;
 }
@@ -5391,16 +5450,25 @@ static int ca0132_alt_xbass_xover_slider_put(struct snd_kcontrol *kcontrol,
 	struct ca0132_spec *spec = codec->spec;
 	hda_nid_t nid = get_amp_nid(kcontrol);
 	long *valp = ucontrol->value.integer.value;
+	long *cur_val;
 	int idx;
 
+	if (nid == BASS_REDIRECTION_XOVER)
+		cur_val = &spec->bass_redirect_xover_freq;
+	else
+		cur_val = &spec->xbass_xover_freq;
+
 	/* any change? */
-	if (spec->xbass_xover_freq == *valp)
+	if (*cur_val == *valp)
 		return 0;
 
-	spec->xbass_xover_freq = *valp;
+	*cur_val = *valp;
 
 	idx = *valp;
-	ca0132_alt_slider_ctl_set(codec, nid, float_xbass_xover_lookup, idx);
+	if (nid == BASS_REDIRECTION_XOVER)
+		ca0132_alt_bass_redirection_xover_set(codec, *cur_val);
+	else
+		ca0132_alt_slider_ctl_set(codec, nid, float_xbass_xover_lookup, idx);
 
 	return 0;
 }
@@ -5968,6 +6036,11 @@ static int ca0132_switch_get(struct snd_kcontrol *kcontrol,
 		return 0;
 	}
 
+	if (nid == BASS_REDIRECTION) {
+		*valp = spec->bass_redirection_val;
+		return 0;
+	}
+
 	return 0;
 }
 
@@ -6054,6 +6127,14 @@ static int ca0132_switch_put(struct snd_kcontrol *kcontrol,
 		changed = 0;
 	}
 
+	if (nid == BASS_REDIRECTION) {
+		spec->bass_redirection_val = *valp;
+		if (spec->cur_out_type == SURROUND_OUT)
+			ca0132_alt_surround_set_bass_redirection(codec, *valp);
+
+		changed = 0;
+	}
+
 exit:
 	snd_hda_power_down(codec);
 	return changed;
@@ -6436,6 +6517,39 @@ static int ca0132_alt_add_rear_full_range_switch(struct hda_codec *codec)
 				snd_ctl_new1(&knew, codec));
 }
 
+/*
+ * Bass redirection redirects audio below the crossover frequency to the LFE
+ * channel on speakers that are set as not being full-range. On configurations
+ * without an LFE channel, it does nothing. Bass redirection seems to be the
+ * replacement for X-Bass on configurations with an LFE channel.
+ */
+static int ca0132_alt_add_bass_redirection_crossover(struct hda_codec *codec)
+{
+	const char *namestr = "Output: Bass Redirection Playback Volume";
+	struct snd_kcontrol_new knew =
+		HDA_CODEC_VOLUME_MONO(namestr, BASS_REDIRECTION_XOVER, 1, 0,
+				HDA_OUTPUT);
+
+	knew.tlv.c = NULL;
+	knew.info = ca0132_alt_xbass_xover_slider_info;
+	knew.get = ca0132_alt_xbass_xover_slider_ctl_get;
+	knew.put = ca0132_alt_xbass_xover_slider_put;
+
+	return snd_hda_ctl_add(codec, BASS_REDIRECTION_XOVER,
+			snd_ctl_new1(&knew, codec));
+}
+
+static int ca0132_alt_add_bass_redirection_switch(struct hda_codec *codec)
+{
+	const char *namestr = "Output: Bass Redirection Playback Switch";
+	struct snd_kcontrol_new knew =
+		CA0132_CODEC_MUTE_MONO(namestr, BASS_REDIRECTION, 1,
+				HDA_OUTPUT);
+
+	return snd_hda_ctl_add(codec, BASS_REDIRECTION,
+			snd_ctl_new1(&knew, codec));
+}
+
 /*
  * Create an Input Source enumerated control for the alternate ca0132 codecs
  * because the front microphone has no auto-detect, and Line-in has to be set
@@ -6749,6 +6863,12 @@ static int ca0132_build_controls(struct hda_codec *codec)
 		if (err < 0)
 			return err;
 		err = ca0132_alt_add_rear_full_range_switch(codec);
+		if (err < 0)
+			return err;
+		err = ca0132_alt_add_bass_redirection_crossover(codec);
+		if (err < 0)
+			return err;
+		err = ca0132_alt_add_bass_redirection_switch(codec);
 		if (err < 0)
 			return err;
 		err = ca0132_alt_add_mic_boost_enum(codec);
@@ -8102,6 +8222,8 @@ static void ca0132_init_chip(struct hda_codec *codec)
 		spec->xbass_xover_freq = 8;
 		for (i = 0; i < EFFECT_LEVEL_SLIDERS; i++)
 			spec->fx_ctl_val[i] = effect_slider_defaults[i];
+
+		spec->bass_redirect_xover_freq = 8;
 	}
 
 	spec->voicefx_val = 0;
-- 
2.20.1

