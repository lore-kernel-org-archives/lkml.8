Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEA5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D598520738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uMUpTd8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgHYUMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgHYULe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:11:34 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4216C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:33 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id d139so7257453qke.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k1da2fAV2EiQh7vVO93ek9apNvvMiSDZUgYoRcsPbOw=;
        b=uMUpTd8pIXKAsSyGriRx+OF2tXnJE4SsTtmcTL2ab7byJwIJ6/ecDegHY9Pl0hOLpC
         wzN1uqYrxzR1PRGExtXidxK5UHtORiW3sDl0hL6tP0HDeKMTN+y2A6XuTjOhY8/HWO8t
         7cQupL5K7IJJevAS5DMJn05ug6aWBhh7VGApTwWBXiTeWKqV3fk/y9RheSySmyUjZwhO
         mi3RXnhr0EF/m1Y4NcRt8S698eFyse8nFwhGxI7JA0SbRItEyafv0zVZAfuiiC4Oq/Du
         vy4Q04Kb6dkQHkdJuiPxDzmfFhYTg/UOVUJmzyc5Qs1YTFUDF6rID/qHdJobMyGgNAyr
         yl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k1da2fAV2EiQh7vVO93ek9apNvvMiSDZUgYoRcsPbOw=;
        b=UK9KorjqJ7uDoOLFYohe/lZhR+I4waBMdu5tch+P0tbkesamxzJzxgu/GnSdzqdxrG
         wUgK0nr/vj6oipFURoTP5Qm2KEFLWWtHYqwS1MCcx18y/VqCFgePedArlUBXrCAUYWn6
         BslbJmSNgqPRKImOGUVl5hlubfe6IWHg0xbMMIB0n6IA4QPm9WavZrN/gixgkEL0X2t2
         rRJIOcKRAQXo6d+hoNkY/tDuAFMhLE+rr6U1ufdyEcB3v5wnfPxyWw2HiW2gbxSqswcT
         1EHdvpX7igZTfxMzhdBToVlOMqcmLzHdh5KLXmEdueVl0PovOCpC/gSElV83h9Jyr0Bk
         xFVw==
X-Gm-Message-State: AOAM533tsUjNUlP46o1aHbFW5z9KW8wCjC5iOcCdP8d58DmxkxWtwDLb
        5TJCVkJ40nAX359Y/NGX/Y8=
X-Google-Smtp-Source: ABdhPJyKcp6cLMiFgvQ+YKy4tk4K8doRDATt69GDmP4uJ61BvaUEIrxKb+v4Ey7qixzGnWTmdsDuCA==
X-Received: by 2002:a37:4856:: with SMTP id v83mr11203807qka.213.1598386293007;
        Tue, 25 Aug 2020 13:11:33 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id n23sm12453459qkk.105.2020.08.25.13.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 13:11:32 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/20] ALSA: hda/ca0132 - Add output selection for SoundBlaster AE-7.
Date:   Tue, 25 Aug 2020 16:10:36 -0400
Message-Id: <20200825201040.30339-18-conmanx360@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200825201040.30339-1-conmanx360@gmail.com>
References: <20200825201040.30339-1-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add output selection quirk table information for SoundBlaster AE-7, and
slightly modify the AE-5's ca0113 command table to accommodate the AE-7.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 88 ++++++++++++++++++++++++++++--------
 1 file changed, 68 insertions(+), 20 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 8519119ef7a6..dcc8d29d934c 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -727,22 +727,29 @@ static const struct ct_dsp_volume_ctl ca0132_alt_vol_ctls[] = {
 };
 
 /* Values for ca0113_mmio_command_set for selecting output. */
-#define AE5_CA0113_OUT_SET_COMMANDS 6
-struct ae5_ca0113_output_set {
-	unsigned int group[AE5_CA0113_OUT_SET_COMMANDS];
-	unsigned int target[AE5_CA0113_OUT_SET_COMMANDS];
-	unsigned int vals[AE5_CA0113_OUT_SET_COMMANDS];
+#define AE_CA0113_OUT_SET_COMMANDS 6
+struct ae_ca0113_output_set {
+	unsigned int group[AE_CA0113_OUT_SET_COMMANDS];
+	unsigned int target[AE_CA0113_OUT_SET_COMMANDS];
+	unsigned int vals[NUM_OF_OUTPUTS][AE_CA0113_OUT_SET_COMMANDS];
 };
 
-static const struct ae5_ca0113_output_set ae5_ca0113_output_presets[] = {
-	{ .group =  { 0x30, 0x30, 0x48, 0x48, 0x48, 0x30 },
-	  .target = { 0x2e, 0x30, 0x0d, 0x17, 0x19, 0x32 },
-	  .vals =   { 0x00, 0x00, 0x40, 0x00, 0x00, 0x3f }
-	},
-	{ .group =  { 0x30, 0x30, 0x48, 0x48, 0x48, 0x30 },
-	  .target = { 0x2e, 0x30, 0x0d, 0x17, 0x19, 0x32 },
-	  .vals =   { 0x3f, 0x3f, 0x00, 0x00, 0x00, 0x00 }
-	}
+static const struct ae_ca0113_output_set ae5_ca0113_output_presets = {
+	.group =  { 0x30, 0x30, 0x48, 0x48, 0x48, 0x30 },
+	.target = { 0x2e, 0x30, 0x0d, 0x17, 0x19, 0x32 },
+		    /* Speakers. */
+	.vals =   { { 0x00, 0x00, 0x40, 0x00, 0x00, 0x3f },
+		    /* Headphones. */
+		    { 0x3f, 0x3f, 0x00, 0x00, 0x00, 0x00 } },
+};
+
+static const struct ae_ca0113_output_set ae7_ca0113_output_presets = {
+	.group  = { 0x30, 0x30, 0x48, 0x48, 0x48, 0x30 },
+	.target = { 0x2e, 0x30, 0x0d, 0x17, 0x19, 0x32 },
+		    /* Speakers. */
+	.vals   = { { 0x00, 0x00, 0x40, 0x00, 0x00, 0x3f },
+		    /* Headphones. */
+		    { 0x3f, 0x3f, 0x00, 0x00, 0x02, 0x00 } },
 };
 
 /* ae5 ca0113 command sequences to set headphone gain levels. */
@@ -1427,6 +1434,41 @@ static const struct ca0132_alt_out_set_quirk_data quirk_out_set_data[] = {
 		  .chipio_write_addr = 0x0018b03c,
 		  .chipio_write_data = 0x00000012
 		} },
+	},
+	{ .quirk_id = QUIRK_AE7,
+	  .has_headphone_gain = true,
+	  .is_ae_series       = true,
+	  .out_set_info = {
+		/* Speakers. */
+		{ .dac2port          = 0x58,
+		  .has_hda_gpio      = false,
+		  .mmio_gpio_count   = 1,
+		  .mmio_gpio_pin     = { 0 },
+		  .mmio_gpio_set     = { 1 },
+		  .scp_cmds_count    = 2,
+		  .scp_cmd_mid       = { 0x96, 0x96 },
+		  .scp_cmd_req       = { SPEAKER_TUNING_FRONT_LEFT_INVERT,
+					 SPEAKER_TUNING_FRONT_RIGHT_INVERT },
+		  .scp_cmd_val       = { FLOAT_ZERO, FLOAT_ZERO },
+		  .has_chipio_write  = true,
+		  .chipio_write_addr = 0x0018b03c,
+		  .chipio_write_data = 0x00000000
+		},
+		/* Headphones. */
+		{ .dac2port          = 0x58,
+		  .has_hda_gpio      = false,
+		  .mmio_gpio_count   = 1,
+		  .mmio_gpio_pin     = { 0 },
+		  .mmio_gpio_set     = { 1 },
+		  .scp_cmds_count    = 2,
+		  .scp_cmd_mid       = { 0x96, 0x96 },
+		  .scp_cmd_req       = { SPEAKER_TUNING_FRONT_LEFT_INVERT,
+					 SPEAKER_TUNING_FRONT_RIGHT_INVERT },
+		  .scp_cmd_val       = { FLOAT_ONE, FLOAT_ONE },
+		  .has_chipio_write  = true,
+		  .chipio_write_addr = 0x0018b03c,
+		  .chipio_write_data = 0x00000010
+		} },
 	}
 };
 
@@ -4383,18 +4425,24 @@ static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val);
 static void ae5_mmio_select_out(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
+	const struct ae_ca0113_output_set *out_cmds;
 	unsigned int i;
 
-	for (i = 0; i < AE5_CA0113_OUT_SET_COMMANDS; i++)
-		ca0113_mmio_command_set(codec,
-			ae5_ca0113_output_presets[spec->cur_out_type].group[i],
-			ae5_ca0113_output_presets[spec->cur_out_type].target[i],
-			ae5_ca0113_output_presets[spec->cur_out_type].vals[i]);
+	if (ca0132_quirk(spec) == QUIRK_AE5)
+		out_cmds = &ae5_ca0113_output_presets;
+	else
+		out_cmds = &ae7_ca0113_output_presets;
+
+	for (i = 0; i < AE_CA0113_OUT_SET_COMMANDS; i++)
+		ca0113_mmio_command_set(codec, out_cmds->group[i],
+				out_cmds->target[i],
+				out_cmds->vals[spec->cur_out_type][i]);
 }
 
 static int ca0132_alt_set_full_range_speaker(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
+	int quirk = ca0132_quirk(spec);
 	unsigned int tmp;
 	int err;
 
@@ -4426,7 +4474,7 @@ static int ca0132_alt_set_full_range_speaker(struct hda_codec *codec)
 	 * Only the AE series cards set this value when setting full-range,
 	 * and it's always 1.0f.
 	 */
-	if (ca0132_quirk(spec) == QUIRK_AE5) {
+	if (quirk == QUIRK_AE5 || quirk == QUIRK_AE7) {
 		err = dspio_set_uint_param(codec, 0x96,
 				SPEAKER_FULL_RANGE_SURROUND_L_R, FLOAT_ONE);
 		if (err < 0)
-- 
2.20.1

