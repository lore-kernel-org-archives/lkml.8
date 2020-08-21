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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AECC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D2C12076E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnKLCKzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgHUSyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgHUSxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:53:45 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14AFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:53:44 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id u3so2259978qkd.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=81C/lA6HY2KxQVDEZQTDvj+0VcawE4mM9Jq8wz/uYUA=;
        b=NnKLCKzEJ3zwmiT37Y5mS4iv3LlWs1mTA41hrC63wKqeWwUGwQ4nr6kNqxefEGcfyW
         oiz8o+vvud516bvDli4cACNy0Iiuywb0l4slFkiIeN+/mA2mXHaJTQzY0Tm0JjyCZ5W5
         KP2/hCSuu4V3qBxwm9242yKP07LAumnRy7bLMFZRpguEisqnztmmziTv+LO2zsDvT3+k
         XG3+mSBN17RW1c92WQDbiBcHygs4ZNmckPkzlngmmyPRpJPCqh24axcI3YRJocpso51G
         gPHqe6DzZhTh/ik2LKaBnYXnd+wjwO+t6JltRxFxwX6YUY7JRkvr2WgfYkgCn1dttehU
         457Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=81C/lA6HY2KxQVDEZQTDvj+0VcawE4mM9Jq8wz/uYUA=;
        b=H2JAxdqdOnH29C7tLY2JiZKOyAE7Ikfi8VYD0FHF2loosDq99iFOXBzhuvnltLpAoS
         dF0YoUP2GqAV2aNcmZHCvZzYr+W92HUyIq1cUeN1+UqFbYoRyq3w9yLsF4gxh11ofTvh
         xuTWpATz365y1gusdGspUb/RAKGEC6e2NELOdgaTzKGc7FNbff2Z8kGSDwfmgoDhl619
         zN/TL5tSfQ3VqfV078yJmzHD9maXqyXU0KpZ0psxYDVTKrc8LaQEIU/6Sj3bC0f0dphG
         iIdtzjnDsHMWFNCCsXuWS/Xfg3uTzokTh1fJ2o5YBlMZzTSN5AIUvOYCfIeL+alxUG5w
         SF3w==
X-Gm-Message-State: AOAM5307bPOgnW/M4mI/MkrTEJshosgf0D/2ZEhJRnUCKM6Z+aehGmfg
        q+GFkOamYMDD4rfYbhICdr2W6y5OmpY=
X-Google-Smtp-Source: ABdhPJzb3j9QpbKeWpAL0wKAbMHNJ2M8X+QORSRyjC+q+J6cZmR3z8ZnCfaGmbgtVfdjUTiUnoxmJw==
X-Received: by 2002:a05:620a:1188:: with SMTP id b8mr4142269qkk.440.1598036024163;
        Fri, 21 Aug 2020 11:53:44 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id o72sm2468426qka.113.2020.08.21.11.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:53:43 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/20] ALSA: hda/ca0132 - Add speaker tuning initialization commands.
Date:   Fri, 21 Aug 2020 14:52:19 -0400
Message-Id: <20200821185239.26133-3-conmanx360@gmail.com>
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

Add speaker tuning initialization DSP commands, and also define
previously unknown DSP command values.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 119 +++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 7491e2044638..2e664aeee1c4 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -589,6 +589,60 @@ static const struct ct_eq_preset ca0132_alt_eq_presets[] = {
 	}
 };
 
+/*
+ * Definitions for the DSP req's to handle speaker tuning. These all belong to
+ * module ID 0x96, the output effects module.
+ */
+enum speaker_tuning_reqs {
+	/*
+	 * Currently, this value is always set to 0.0f. However, on Windows,
+	 * when selecting certain headphone profiles on the new Sound Blaster
+	 * connect software, the QUERY_SPEAKER_EQ_ADDRESS req on mid 0x80 is
+	 * sent. This gets the speaker EQ address area, which is then used to
+	 * send over (presumably) an equalizer profile for the specific
+	 * headphone setup. It is sent using the same method the DSP
+	 * firmware is uploaded with, which I believe is why the 'ctspeq.bin'
+	 * file exists in linux firmware tree but goes unused. It would also
+	 * explain why the QUERY_SPEAKER_EQ_ADDRESS req is defined but unused.
+	 * Once this profile is sent over, SPEAKER_TUNING_USE_SPEAKER_EQ is
+	 * set to 1.0f.
+	 */
+	SPEAKER_TUNING_USE_SPEAKER_EQ           = 0x1f,
+	SPEAKER_TUNING_ENABLE_CENTER_EQ         = 0x20,
+	SPEAKER_TUNING_FRONT_LEFT_VOL_LEVEL     = 0x21,
+	SPEAKER_TUNING_FRONT_RIGHT_VOL_LEVEL    = 0x22,
+	SPEAKER_TUNING_CENTER_VOL_LEVEL         = 0x23,
+	SPEAKER_TUNING_LFE_VOL_LEVEL            = 0x24,
+	SPEAKER_TUNING_REAR_LEFT_VOL_LEVEL      = 0x25,
+	SPEAKER_TUNING_REAR_RIGHT_VOL_LEVEL     = 0x26,
+	SPEAKER_TUNING_SURROUND_LEFT_VOL_LEVEL  = 0x27,
+	SPEAKER_TUNING_SURROUND_RIGHT_VOL_LEVEL = 0x28,
+	/*
+	 * Inversion is used when setting headphone virtualization to line
+	 * out. Not sure why this is, but it's the only place it's ever used.
+	 */
+	SPEAKER_TUNING_FRONT_LEFT_INVERT        = 0x29,
+	SPEAKER_TUNING_FRONT_RIGHT_INVERT       = 0x2a,
+	SPEAKER_TUNING_CENTER_INVERT            = 0x2b,
+	SPEAKER_TUNING_LFE_INVERT               = 0x2c,
+	SPEAKER_TUNING_REAR_LEFT_INVERT         = 0x2d,
+	SPEAKER_TUNING_REAR_RIGHT_INVERT        = 0x2e,
+	SPEAKER_TUNING_SURROUND_LEFT_INVERT     = 0x2f,
+	SPEAKER_TUNING_SURROUND_RIGHT_INVERT    = 0x30,
+	/* Delay is used when setting surround speaker distance in Windows. */
+	SPEAKER_TUNING_FRONT_LEFT_DELAY         = 0x31,
+	SPEAKER_TUNING_FRONT_RIGHT_DELAY        = 0x32,
+	SPEAKER_TUNING_CENTER_DELAY             = 0x33,
+	SPEAKER_TUNING_LFE_DELAY                = 0x34,
+	SPEAKER_TUNING_REAR_LEFT_DELAY          = 0x35,
+	SPEAKER_TUNING_REAR_RIGHT_DELAY         = 0x36,
+	SPEAKER_TUNING_SURROUND_LEFT_DELAY      = 0x37,
+	SPEAKER_TUNING_SURROUND_RIGHT_DELAY     = 0x38,
+	/* Of these two, only mute seems to ever be used. */
+	SPEAKER_TUNING_MAIN_VOLUME              = 0x39,
+	SPEAKER_TUNING_MUTE                     = 0x3a,
+};
+
 /* DSP command sequences for ca0132_alt_select_out */
 #define ALT_OUT_SET_MAX_COMMANDS 9 /* Max number of commands in sequence */
 struct ca0132_alt_out_set {
@@ -6874,6 +6928,67 @@ static void ca0132_refresh_widget_caps(struct hda_codec *codec)
 	}
 }
 
+/*
+ * Default speaker tuning values setup for alternative codecs.
+ */
+static const unsigned int sbz_default_delay_values[] = {
+	/* Non-zero values are floating point 0.000198. */
+	0x394f9e38, 0x394f9e38, 0x00000000, 0x00000000, 0x00000000, 0x00000000
+};
+
+static const unsigned int zxr_default_delay_values[] = {
+	/* Non-zero values are floating point 0.000220. */
+	0x00000000, 0x00000000, 0x3966afcd, 0x3966afcd, 0x3966afcd, 0x3966afcd
+};
+
+static const unsigned int ae5_default_delay_values[] = {
+	/* Non-zero values are floating point 0.000100. */
+	0x00000000, 0x00000000, 0x38d1b717, 0x38d1b717, 0x38d1b717, 0x38d1b717
+};
+
+/*
+ * If we never change these, probably only need them on initialization.
+ */
+static void ca0132_alt_init_speaker_tuning(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int i, tmp, start_req, end_req;
+	const unsigned int *values;
+
+	switch (ca0132_quirk(spec)) {
+	case QUIRK_SBZ:
+		values = sbz_default_delay_values;
+		break;
+	case QUIRK_ZXR:
+		values = zxr_default_delay_values;
+		break;
+	case QUIRK_AE5:
+		values = ae5_default_delay_values;
+		break;
+	default:
+		values = sbz_default_delay_values;
+		break;
+	}
+
+	tmp = FLOAT_ZERO;
+	dspio_set_uint_param(codec, 0x96, SPEAKER_TUNING_ENABLE_CENTER_EQ, tmp);
+
+	start_req = SPEAKER_TUNING_FRONT_LEFT_VOL_LEVEL;
+	end_req = SPEAKER_TUNING_REAR_RIGHT_VOL_LEVEL;
+	for (i = start_req; i < end_req + 1; i++)
+		dspio_set_uint_param(codec, 0x96, i, tmp);
+
+	start_req = SPEAKER_TUNING_FRONT_LEFT_INVERT;
+	end_req = SPEAKER_TUNING_REAR_RIGHT_INVERT;
+	for (i = start_req; i < end_req + 1; i++)
+		dspio_set_uint_param(codec, 0x96, i, tmp);
+
+
+	for (i = 0; i < 6; i++)
+		dspio_set_uint_param(codec, 0x96,
+				SPEAKER_TUNING_FRONT_LEFT_DELAY + i, values[i]);
+}
+
 /*
  * Creates a dummy stream to bind the output to. This seems to have to be done
  * after changing the main outputs source and destination streams.
@@ -7373,6 +7488,8 @@ static void sbz_setup_defaults(struct hda_codec *codec)
 		}
 	}
 
+	ca0132_alt_init_speaker_tuning(codec);
+
 	ca0132_alt_create_dummy_stream(codec);
 }
 
@@ -7440,6 +7557,8 @@ static void ae5_setup_defaults(struct hda_codec *codec)
 		}
 	}
 
+	ca0132_alt_init_speaker_tuning(codec);
+
 	ca0132_alt_create_dummy_stream(codec);
 }
 
-- 
2.20.1

