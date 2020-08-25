Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD13C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A269520738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1quhfa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgHYULa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgHYULP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:11:15 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60CDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:15 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id m7so12286468qki.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PyW2J2UOhlxaTC3XuwkPuw7lgwu3wVys0aDNpB+jS1E=;
        b=D1quhfa+3/XarwBootUNPPs3xIMwKxE+clw9r8WMdAtyLagB5rc2wey/aIFgiFf3UW
         KZZBbSB6u8gV38ZO+oDHYxxg3MxyeGZdAk9pNmRtIiUZ1st37ZeKAKSWOJndc3ZqOToH
         p4T+Ua44QzfsXotS3MKKga8LCf8zJPvO9sXeKOc+BIWi/xh3dIWjSFyXbfhjulRTOYbW
         yp/wSLFA3+/rIIWnbPzkC2e47CfF1WSPQagC7KnNGPyfzcxRli35IIjkLKu77nDmItQ+
         jSPn/JZ49yI3XsphNAnZyOL93WDVDub3AnlhvYf7EVCqNSNrJUzclcjGSanXVqUtIJTY
         H72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PyW2J2UOhlxaTC3XuwkPuw7lgwu3wVys0aDNpB+jS1E=;
        b=dDKgZEMHBShyRaP6TEEccYVTk93Q+EUO0BEUZnKZBFdr5elh0NmxTlHgI/UAJEe6y6
         5/gj3KNTJYzr2o8dMwnxlUsX1tzWHP4LL8dmVCCXDStyMqeBoRKAVuireXHXNG9rwP1p
         ZMnmhSnehhtlTgRqM+SoDlafMuCvNVmStgjWqamgBrQY6ThBxQEYezfIjNUuRXV00rdC
         myY2dG9ueei0nlQFAW6o7coNpbrSNKE4r3QwrA1W6Aepx5s2gvOaoWAIG/SBT3+EVcth
         0v2SOLN7MVKWujLxmB3hIFjz72H1/phXjQtHlzZfvvo6kJUnThIJQhTxVTTe9Oq1IxGa
         JQZw==
X-Gm-Message-State: AOAM531HlBb/OTARESDOgSvGQPVMycUfp0caN3JAicqKhEuu8mrAOHMp
        dH8QYy04QXZBggn5TrRH7oA=
X-Google-Smtp-Source: ABdhPJyIai6YUySonnwyqrcNXkTmlHnuSwrtBl+qQUd1H9q4nHBR7c/mnHZTN84Exf1Y4wVuJ7ocgA==
X-Received: by 2002:a05:620a:48:: with SMTP id t8mr11120533qkt.474.1598386274815;
        Tue, 25 Aug 2020 13:11:14 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id n23sm12453459qkk.105.2020.08.25.13.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 13:11:14 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/20] ALSA: hda/ca0132 - Add quirk output selection structures.
Date:   Tue, 25 Aug 2020 16:10:27 -0400
Message-Id: <20200825201040.30339-9-conmanx360@gmail.com>
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

Add structures containing the changes that need to happen on output
selection for each quirk. This should streamline the addition of new
quirks.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 336 +++++++++++++++++++++++++----------
 1 file changed, 241 insertions(+), 95 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 39e333866be3..ab84ea397552 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1256,6 +1256,164 @@ static const struct snd_pci_quirk ca0132_quirks[] = {
 	{}
 };
 
+/* Output selection quirk info structures. */
+#define MAX_QUIRK_MMIO_GPIO_SET_VALS 3
+#define MAX_QUIRK_SCP_SET_VALS 2
+struct ca0132_alt_out_set_info {
+	unsigned int dac2port; /* ParamID 0x0d value. */
+
+	bool has_hda_gpio;
+	char hda_gpio_pin;
+	char hda_gpio_set;
+
+	unsigned int mmio_gpio_count;
+	char mmio_gpio_pin[MAX_QUIRK_MMIO_GPIO_SET_VALS];
+	char mmio_gpio_set[MAX_QUIRK_MMIO_GPIO_SET_VALS];
+
+	unsigned int scp_cmds_count;
+	unsigned int scp_cmd_mid[MAX_QUIRK_SCP_SET_VALS];
+	unsigned int scp_cmd_req[MAX_QUIRK_SCP_SET_VALS];
+	unsigned int scp_cmd_val[MAX_QUIRK_SCP_SET_VALS];
+
+	bool has_chipio_write;
+	unsigned int chipio_write_addr;
+	unsigned int chipio_write_data;
+};
+
+struct ca0132_alt_out_set_quirk_data {
+	int quirk_id;
+
+	bool has_headphone_gain;
+	bool is_ae_series;
+
+	struct ca0132_alt_out_set_info out_set_info[NUM_OF_OUTPUTS];
+};
+
+static const struct ca0132_alt_out_set_quirk_data quirk_out_set_data[] = {
+	{ .quirk_id = QUIRK_R3DI,
+	  .has_headphone_gain = false,
+	  .is_ae_series       = false,
+	  .out_set_info = {
+		/* Speakers. */
+		{ .dac2port         = 0x24,
+		  .has_hda_gpio     = true,
+		  .hda_gpio_pin     = 2,
+		  .hda_gpio_set     = 1,
+		  .mmio_gpio_count  = 0,
+		  .scp_cmds_count   = 0,
+		  .has_chipio_write = false,
+		},
+		/* Headphones. */
+		{ .dac2port         = 0x21,
+		  .has_hda_gpio     = true,
+		  .hda_gpio_pin     = 2,
+		  .hda_gpio_set     = 0,
+		  .mmio_gpio_count  = 0,
+		  .scp_cmds_count   = 0,
+		  .has_chipio_write = false,
+		} },
+	},
+	{ .quirk_id = QUIRK_R3D,
+	  .has_headphone_gain = false,
+	  .is_ae_series       = false,
+	  .out_set_info = {
+		/* Speakers. */
+		{ .dac2port         = 0x24,
+		  .has_hda_gpio     = false,
+		  .mmio_gpio_count  = 1,
+		  .mmio_gpio_pin    = { 1 },
+		  .mmio_gpio_set    = { 1 },
+		  .scp_cmds_count   = 0,
+		  .has_chipio_write = false,
+		},
+		/* Headphones. */
+		{ .dac2port         = 0x21,
+		  .has_hda_gpio     = false,
+		  .mmio_gpio_count  = 1,
+		  .mmio_gpio_pin    = { 1 },
+		  .mmio_gpio_set    = { 0 },
+		  .scp_cmds_count   = 0,
+		  .has_chipio_write = false,
+		} },
+	},
+	{ .quirk_id = QUIRK_SBZ,
+	  .has_headphone_gain = false,
+	  .is_ae_series       = false,
+	  .out_set_info = {
+		/* Speakers. */
+		{ .dac2port         = 0x18,
+		  .has_hda_gpio     = false,
+		  .mmio_gpio_count  = 3,
+		  .mmio_gpio_pin    = { 7, 4, 1 },
+		  .mmio_gpio_set    = { 0, 1, 1 },
+		  .scp_cmds_count   = 0,
+		  .has_chipio_write = false, },
+		/* Headphones. */
+		{ .dac2port         = 0x12,
+		  .has_hda_gpio     = false,
+		  .mmio_gpio_count  = 3,
+		  .mmio_gpio_pin    = { 7, 4, 1 },
+		  .mmio_gpio_set    = { 1, 1, 0 },
+		  .scp_cmds_count   = 0,
+		  .has_chipio_write = false,
+		} },
+	},
+	{ .quirk_id = QUIRK_ZXR,
+	  .has_headphone_gain = true,
+	  .is_ae_series       = false,
+	  .out_set_info = {
+		/* Speakers. */
+		{ .dac2port         = 0x24,
+		  .has_hda_gpio     = false,
+		  .mmio_gpio_count  = 3,
+		  .mmio_gpio_pin    = { 2, 3, 5 },
+		  .mmio_gpio_set    = { 1, 1, 0 },
+		  .scp_cmds_count   = 0,
+		  .has_chipio_write = false,
+		},
+		/* Headphones. */
+		{ .dac2port         = 0x21,
+		  .has_hda_gpio     = false,
+		  .mmio_gpio_count  = 3,
+		  .mmio_gpio_pin    = { 2, 3, 5 },
+		  .mmio_gpio_set    = { 0, 1, 1 },
+		  .scp_cmds_count   = 0,
+		  .has_chipio_write = false,
+		} },
+	},
+	{ .quirk_id = QUIRK_AE5,
+	  .has_headphone_gain = true,
+	  .is_ae_series       = true,
+	  .out_set_info = {
+		/* Speakers. */
+		{ .dac2port          = 0xa4,
+		  .has_hda_gpio      = false,
+		  .mmio_gpio_count   = 0,
+		  .scp_cmds_count    = 2,
+		  .scp_cmd_mid       = { 0x96, 0x96 },
+		  .scp_cmd_req       = { SPEAKER_TUNING_FRONT_LEFT_INVERT,
+					 SPEAKER_TUNING_FRONT_RIGHT_INVERT },
+		  .scp_cmd_val       = { FLOAT_ZERO, FLOAT_ZERO },
+		  .has_chipio_write  = true,
+		  .chipio_write_addr = 0x0018b03c,
+		  .chipio_write_data = 0x00000012
+		},
+		/* Headphones. */
+		{ .dac2port          = 0xa1,
+		  .has_hda_gpio      = false,
+		  .mmio_gpio_count   = 0,
+		  .scp_cmds_count    = 2,
+		  .scp_cmd_mid       = { 0x96, 0x96 },
+		  .scp_cmd_req       = { SPEAKER_TUNING_FRONT_LEFT_INVERT,
+					 SPEAKER_TUNING_FRONT_RIGHT_INVERT },
+		  .scp_cmd_val       = { FLOAT_ONE, FLOAT_ONE },
+		  .has_chipio_write  = true,
+		  .chipio_write_addr = 0x0018b03c,
+		  .chipio_write_data = 0x00000012
+		} },
+	}
+};
+
 /*
  * CA0132 codec access
  */
@@ -3513,26 +3671,6 @@ static void r3di_gpio_mic_set(struct hda_codec *codec,
 			    AC_VERB_SET_GPIO_DATA, cur_gpio);
 }
 
-static void r3di_gpio_out_set(struct hda_codec *codec,
-		enum r3di_out_select cur_out)
-{
-	unsigned int cur_gpio;
-
-	/* Get the current GPIO Data setup */
-	cur_gpio = snd_hda_codec_read(codec, 0x01, 0, AC_VERB_GET_GPIO_DATA, 0);
-
-	switch (cur_out) {
-	case R3DI_HEADPHONE_OUT:
-		cur_gpio &= ~(1 << R3DI_OUT_SELECT_BIT);
-		break;
-	case R3DI_LINE_OUT:
-		cur_gpio |= (1 << R3DI_OUT_SELECT_BIT);
-		break;
-	}
-	snd_hda_codec_write(codec, codec->core.afg, 0,
-			    AC_VERB_SET_GPIO_DATA, cur_gpio);
-}
-
 static void r3di_gpio_dsp_status_set(struct hda_codec *codec,
 		enum r3di_dsp_status dsp_status)
 {
@@ -4314,86 +4452,93 @@ static int ca0132_alt_surround_set_bass_redirection(struct hda_codec *codec,
  * These are the commands needed to setup output on each of the different card
  * types.
  */
-static void ca0132_alt_select_out_quirk_handler(struct hda_codec *codec)
+static void ca0132_alt_select_out_get_quirk_data(struct hda_codec *codec,
+		const struct ca0132_alt_out_set_quirk_data **quirk_data)
 {
 	struct ca0132_spec *spec = codec->spec;
-	unsigned int tmp;
+	int quirk = ca0132_quirk(spec);
+	unsigned int i;
 
-	switch (spec->cur_out_type) {
-	case SPEAKER_OUT:
-		switch (ca0132_quirk(spec)) {
-		case QUIRK_SBZ:
-			ca0113_mmio_gpio_set(codec, 7, false);
-			ca0113_mmio_gpio_set(codec, 4, true);
-			ca0113_mmio_gpio_set(codec, 1, true);
-			chipio_set_control_param(codec, 0x0d, 0x18);
-			break;
-		case QUIRK_ZXR:
-			ca0113_mmio_gpio_set(codec, 2, true);
-			ca0113_mmio_gpio_set(codec, 3, true);
-			ca0113_mmio_gpio_set(codec, 5, false);
-			zxr_headphone_gain_set(codec, 0);
-			chipio_set_control_param(codec, 0x0d, 0x24);
-			break;
-		case QUIRK_R3DI:
-			chipio_set_control_param(codec, 0x0d, 0x24);
-			r3di_gpio_out_set(codec, R3DI_LINE_OUT);
-			break;
-		case QUIRK_R3D:
-			chipio_set_control_param(codec, 0x0d, 0x24);
-			ca0113_mmio_gpio_set(codec, 1, true);
-			break;
-		case QUIRK_AE5:
-			ae5_mmio_select_out(codec);
-			ae5_headphone_gain_set(codec, 2);
-			tmp = FLOAT_ZERO;
-			dspio_set_uint_param(codec, 0x96, 0x29, tmp);
-			dspio_set_uint_param(codec, 0x96, 0x2a, tmp);
-			chipio_set_control_param(codec, 0x0d, 0xa4);
-			chipio_write(codec, 0x18b03c, 0x00000012);
-			break;
-		default:
-			break;
+	*quirk_data = NULL;
+	for (i = 0; i < ARRAY_SIZE(quirk_out_set_data); i++) {
+		if (quirk_out_set_data[i].quirk_id == quirk) {
+			*quirk_data = &quirk_out_set_data[i];
+			return;
 		}
-		break;
-	case HEADPHONE_OUT:
-		switch (ca0132_quirk(spec)) {
-		case QUIRK_SBZ:
-			ca0113_mmio_gpio_set(codec, 7, true);
-			ca0113_mmio_gpio_set(codec, 4, true);
-			ca0113_mmio_gpio_set(codec, 1, false);
-			chipio_set_control_param(codec, 0x0d, 0x12);
-			break;
-		case QUIRK_ZXR:
-			ca0113_mmio_gpio_set(codec, 2, false);
-			ca0113_mmio_gpio_set(codec, 3, false);
-			ca0113_mmio_gpio_set(codec, 5, true);
-			zxr_headphone_gain_set(codec, spec->zxr_gain_set);
-			chipio_set_control_param(codec, 0x0d, 0x21);
-			break;
-		case QUIRK_R3DI:
-			chipio_set_control_param(codec, 0x0d, 0x21);
-			r3di_gpio_out_set(codec, R3DI_HEADPHONE_OUT);
-			break;
-		case QUIRK_R3D:
-			chipio_set_control_param(codec, 0x0d, 0x21);
-			ca0113_mmio_gpio_set(codec, 0x1, false);
-			break;
-		case QUIRK_AE5:
-			ae5_mmio_select_out(codec);
-			ae5_headphone_gain_set(codec,
-					spec->ae5_headphone_gain_val);
-			tmp = FLOAT_ONE;
-			dspio_set_uint_param(codec, 0x96, 0x29, tmp);
-			dspio_set_uint_param(codec, 0x96, 0x2a, tmp);
-			chipio_set_control_param(codec, 0x0d, 0xa1);
-			chipio_write(codec, 0x18b03c, 0x00000012);
-			break;
-		default:
-			break;
+	}
+}
+
+static int ca0132_alt_select_out_quirk_set(struct hda_codec *codec)
+{
+	const struct ca0132_alt_out_set_quirk_data *quirk_data;
+	const struct ca0132_alt_out_set_info *out_info;
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int i, gpio_data;
+	int err;
+
+	ca0132_alt_select_out_get_quirk_data(codec, &quirk_data);
+	if (!quirk_data)
+		return 0;
+
+	out_info = &quirk_data->out_set_info[spec->cur_out_type];
+	if (quirk_data->is_ae_series)
+		ae5_mmio_select_out(codec);
+
+	if (out_info->has_hda_gpio) {
+		gpio_data = snd_hda_codec_read(codec, codec->core.afg, 0,
+				AC_VERB_GET_GPIO_DATA, 0);
+
+		if (out_info->hda_gpio_set)
+			gpio_data |= (1 << out_info->hda_gpio_pin);
+		else
+			gpio_data &= ~(1 << out_info->hda_gpio_pin);
+
+		snd_hda_codec_write(codec, codec->core.afg, 0,
+				    AC_VERB_SET_GPIO_DATA, gpio_data);
+	}
+
+	if (out_info->mmio_gpio_count) {
+		for (i = 0; i < out_info->mmio_gpio_count; i++) {
+			ca0113_mmio_gpio_set(codec, out_info->mmio_gpio_pin[i],
+					out_info->mmio_gpio_set[i]);
 		}
-		break;
 	}
+
+	if (out_info->scp_cmds_count) {
+		for (i = 0; i < out_info->scp_cmds_count; i++) {
+			err = dspio_set_uint_param(codec,
+					out_info->scp_cmd_mid[i],
+					out_info->scp_cmd_req[i],
+					out_info->scp_cmd_val[i]);
+			if (err < 0)
+				return err;
+		}
+	}
+
+	chipio_set_control_param(codec, 0x0d, out_info->dac2port);
+
+	if (out_info->has_chipio_write) {
+		chipio_write(codec, out_info->chipio_write_addr,
+				out_info->chipio_write_data);
+	}
+
+	if (quirk_data->has_headphone_gain) {
+		if (spec->cur_out_type != HEADPHONE_OUT) {
+			if (quirk_data->is_ae_series)
+				ae5_headphone_gain_set(codec, 2);
+			else
+				zxr_headphone_gain_set(codec, 0);
+		} else {
+			if (quirk_data->is_ae_series)
+				ae5_headphone_gain_set(codec,
+						spec->ae5_headphone_gain_val);
+			else
+				zxr_headphone_gain_set(codec,
+						spec->zxr_gain_set);
+		}
+	}
+
+	return 0;
 }
 
 static void ca0132_set_out_node_pincfg(struct hda_codec *codec, hda_nid_t nid,
@@ -4456,7 +4601,8 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 	if (err < 0)
 		goto exit;
 
-	ca0132_alt_select_out_quirk_handler(codec);
+	if (ca0132_alt_select_out_quirk_set(codec) < 0)
+		goto exit;
 
 	switch (spec->cur_out_type) {
 	case SPEAKER_OUT:
-- 
2.20.1

