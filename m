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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2113BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1E0C20748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gg5bZtNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgHUSyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgHUSy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:54:26 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7880BC061798
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:54:19 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id p4so2281760qkf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+7lmgRcS/6fJp6h5ROUarTA7VyvP90YaETxkd0V3RrY=;
        b=Gg5bZtNErShDFFliPCKHJSHXYpOYbTHAPgKnjGKH7Zh5psQoONprAgu2PZDZAHs7jO
         GGt/Mr1vvLjFMeBFzVhkXEH0tZvddFX0ptPH15Ttcrp3AvKnaWJEe2AXKdP2MUmAJMAN
         91lef8AX6/3GKeLUVM6JFYvYxYsGa+swb+POOiMfJBFAnKQjipsB0HVljr6SNOXhZ4wi
         knhvroQk4W0HEHPtjLHSTgbRA8iO6kuyQB6iblPHdxIdiayMDfEv1CLOricB7Fp8awb0
         AwllXhunB8EOrsiyovQb3UicmRbyugu8gAkyEcMrLpyDYVmCk40V1+ved5X9E7SVl3N5
         SSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+7lmgRcS/6fJp6h5ROUarTA7VyvP90YaETxkd0V3RrY=;
        b=cdLLdbff+1qk4L3wk2xvEEYJ3jJqDza0IBYRB21GUDaQNfE65mp6kIoj/wSqiR+iUA
         zhUs4lKUEE0ot+eO6kMaTZFmvk54tPWf7linZiixkNIgxal02oCzOr7J0B544mcn9s16
         3mcvD5WVXewswv6HBrNfpc0BucJy/dHlmSU9+N0zbJbt8SanSZmxKfcSQAWaURon4drI
         nr2IsdiXZKLbZ+1TD6a2G2fFCWoFi+uImhUyqQIG0Vu+Jy1QPqk+D7GY3v6Tjhq4YkOb
         A00GFlRXsPxd0bRVEqvzjBWCCa6NXjW1jo1fgNho1557+OlWEv1+0rXMF05Y5XBrpJJ7
         f+eg==
X-Gm-Message-State: AOAM531p4wugpeg46WNxZzN6yXUBFEw4W6ebjdxUnARhQnZ14/JMHJ1r
        lBvrHrVuLFEZdqzvKHHlkLU=
X-Google-Smtp-Source: ABdhPJzLNHO6gRBGrFLUhGPu/Ih6ZLGxsDG8HffwpSpchiVDouTbRlCpvrfSdr0/MuufzA2SGnC+6w==
X-Received: by 2002:a05:620a:1523:: with SMTP id n3mr3892360qkk.245.1598036058814;
        Fri, 21 Aug 2020 11:54:18 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id o72sm2468426qka.113.2020.08.21.11.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:54:18 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/20] ALSA: hda/ca0132 - Add AE-7 exit commands.
Date:   Fri, 21 Aug 2020 14:52:37 -0400
Message-Id: <20200821185239.26133-21-conmanx360@gmail.com>
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

Add exit commands for the AE-7.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 9c70d85b21e0..4d26440eceb0 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -8838,6 +8838,32 @@ static void ae5_exit_chip(struct hda_codec *codec)
 	snd_hda_codec_write(codec, 0x01, 0, 0x724, 0x83);
 }
 
+static void ae7_exit_chip(struct hda_codec *codec)
+{
+	chipio_set_stream_control(codec, 0x18, 0);
+	chipio_set_stream_source_dest(codec, 0x21, 0xc8, 0xc8);
+	chipio_set_stream_channels(codec, 0x21, 0);
+	chipio_set_control_param(codec, CONTROL_PARAM_NODE_ID, 0x09);
+	chipio_set_control_param(codec, 0x20, 0x01);
+
+	chipio_set_control_param(codec, CONTROL_PARAM_ASI, 0);
+
+	chipio_set_stream_control(codec, 0x18, 0);
+	chipio_set_stream_control(codec, 0x0c, 0);
+
+	ca0113_mmio_command_set(codec, 0x30, 0x2b, 0x00);
+	snd_hda_codec_write(codec, 0x15, 0, 0x724, 0x83);
+	ca0113_mmio_command_set_type2(codec, 0x48, 0x07, 0x83);
+	ca0113_mmio_command_set(codec, 0x30, 0x30, 0x00);
+	ca0113_mmio_command_set(codec, 0x30, 0x2e, 0x00);
+	ca0113_mmio_gpio_set(codec, 0, false);
+	ca0113_mmio_gpio_set(codec, 1, false);
+	ca0113_mmio_command_set(codec, 0x30, 0x32, 0x3f);
+
+	snd_hda_codec_write(codec, 0x01, 0, 0x793, 0x00);
+	snd_hda_codec_write(codec, 0x01, 0, 0x794, 0x53);
+}
+
 static void zxr_exit_chip(struct hda_codec *codec)
 {
 	chipio_set_stream_control(codec, 0x03, 0);
@@ -9457,6 +9483,9 @@ static void ca0132_free(struct hda_codec *codec)
 	case QUIRK_AE5:
 		ae5_exit_chip(codec);
 		break;
+	case QUIRK_AE7:
+		ae7_exit_chip(codec);
+		break;
 	case QUIRK_R3DI:
 		r3di_gpio_shutdown(codec);
 		break;
-- 
2.20.1

