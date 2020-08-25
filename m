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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79430C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ADAA20738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsC5rdn+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgHYULy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbgHYULk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:11:40 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B36C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:39 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id y11so91370qvl.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u/YG2y7YYQKcyizD32v+alkIg1GqrI1eey3uzGqUNIM=;
        b=LsC5rdn+JKeGTf0RY5xS6/YJy14TwVDXsYPwLnT70X+6Ql3ErrgsjybUvYsjd4CZSb
         2XCZLBy9whZP7kJ3DhpkEn4Pqg7dV+p/06m1nOn6gFaai7pONHDukOrZ1BW6yT7sgGQM
         E2MXZQMClifMICbIm8xsLsDJnAtVIQ6Z9AKup2xLGlxrLGE1Ty7JmqbHp5GY1iV3/kDW
         hd0VW9t5eKFcKJbzuqYZCXLfU1lES6dAP171rg4VjXaYCd3n+Ka+qTwKWlULrc2QaVWm
         QCqcGUcsKvlB0juz41pmJzSrk1tJeBW6k4+joY3hM9GOg2z7qj2wrBlN+Ai9ww+rhA4U
         c38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u/YG2y7YYQKcyizD32v+alkIg1GqrI1eey3uzGqUNIM=;
        b=JVctJdl4cUxoDkMe5MFaNFhFV0PKSW5T8ETUmn8zOFt7GQSCHLfMmN+dsgdhXiOvH8
         vl5VToH69lPdTyQ2sNQM21DmDgNGmDMFOHnMRaQWA27ZLI6SUhvFCklEztk/HdBRhxGM
         Zd5+stwuH/AcPRr+Ywjd04c7UDYJU73E8mYH4CzpVASIlpz2xQaPIuD1sW4tE5rcMD5x
         VbesaV9uNp57kzmMMxrXCO/5dGgPdm1IISUHOxe7gANqvpwAVZmGaccfFjbAlfxKIp/d
         njTjk1acAs5AXLUEsZs6SGtQZLFObS344BUHKxtUoiSlbZEWN1hEoX/E+5ezGuFG5+6B
         SC6A==
X-Gm-Message-State: AOAM533f/43Mo61a++uMVk75Tn/wbv6xQGIzpOhO/4rnvXLv1qiSJsyj
        Dvu/eEEcpL9ITcrFvYggMtc=
X-Google-Smtp-Source: ABdhPJyIaDklSy5krYwDL1p2YCpM3OTQpYvynxWvLZOffa9sOD4vm46sbJdLPf4Hu90lF0UvHeJ/lw==
X-Received: by 2002:a0c:f505:: with SMTP id j5mr11017299qvm.166.1598386298988;
        Tue, 25 Aug 2020 13:11:38 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id n23sm12453459qkk.105.2020.08.25.13.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 13:11:38 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/20] ALSA: hda/ca0132 - Add AE-7 exit commands.
Date:   Tue, 25 Aug 2020 16:10:39 -0400
Message-Id: <20200825201040.30339-21-conmanx360@gmail.com>
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

Add exit commands for the AE-7.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 52f6d3740e0a..9779978e4bc7 100644
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

