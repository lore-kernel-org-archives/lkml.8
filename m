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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8675AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63EF42076E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJyCxedG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgHUSzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgHUSyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:54:25 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CCEC061795
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:54:15 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id j10so1069826qvo.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8oxfznRuxrb0aNVbLz/oSH4iUfl8mxNBqknvHByn30A=;
        b=qJyCxedGgqPbgUhudbJC1fhdciQkZwbrZWG5L05yORpgM78RVuYXTyFmiK+yWF5VPJ
         mbEkCIwEB0CK/ZWwM7xc34vPZWDwNjrYMDxhSbMpxJRXBqxwrUZwZ5vsTSMhkMY98wvn
         BTncLGrnBIVnJ4iANimGVmRtuqEjhk92FVoCy1eMH4DvD5jIn5I2lvy3sb4qkIgIYXsx
         yAIYkhl/vtz48AmPKLKcT5DWEVZ+9W2XBjep9G/aCvBAhzsdiz9zh/Mex3m2QnFLAXSS
         cZT2Ktm06xLrzlH4EZHUCK3Wot1VSUaXcSypblwmYmMW5DRjCglVhQTl0+GIrp58GK1S
         ysgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8oxfznRuxrb0aNVbLz/oSH4iUfl8mxNBqknvHByn30A=;
        b=cTjylkhegramnI2RimqrDvbJglKsp90pQQCFKQmNFIp97djsQ8BYYuLCC9GHtesuWw
         +BGCijdiiALIcJWdh2FwsAEKXKgwVCqBKKcEehMpGHMTi5LwEhT8DnUgHSH4MuUALMvJ
         ysoVyfclHO3W+kkYB/Q9nGM4imoJ8ZAvPh+TegeKUtZTyUntaTaR4rU0A2KHcTpV1ol9
         k5dx3HSysfk/YAjRfXL+Qpg0R/qzvLGH7O0rXRKlJB4xQ88hUsDPzzrnvvkUWtoHwhbz
         9IsxRu4vU6ZyS8JUwaOevbmHssuFoYAWGybK77C/DZR1aq4Tme4Vwc/j9Ti9+ZGgcmDZ
         Z4og==
X-Gm-Message-State: AOAM530yulA95pkmnpKVfN4pdOO4Kc32nMk9jA4mg/ggGG5MBzEoUbi5
        GozBI1h6sI0vc0DsfKhtma8=
X-Google-Smtp-Source: ABdhPJwyIoGjnn/b6livni1+fFSQ4C7Ne/IqJ8Hey2qSQ/j1ruP1iGJohD1MnFyfdtopPjKPY6SMgw==
X-Received: by 2002:ad4:51c8:: with SMTP id p8mr3614397qvq.31.1598036053138;
        Fri, 21 Aug 2020 11:54:13 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id o72sm2468426qka.113.2020.08.21.11.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:54:12 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/20] ALSA: hda/ca0132 - Add output selection for SoundBlaster AE-7.
Date:   Fri, 21 Aug 2020 14:52:34 -0400
Message-Id: <20200821185239.26133-18-conmanx360@gmail.com>
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

Add output selection quirk table information for SoundBlaster AE-7, and
slightly modify the AE-5's ca0113 command table to accommodate the AE-7.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 88 ++++++++++++++++++++++++++++--------
 1 file changed, 68 insertions(+), 20 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 040233b33074..ad594c2d47ec 100644
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

