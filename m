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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFFAC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1CB52074A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlTFHSnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgHYUMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgHYUL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:11:29 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F62C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:29 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n129so12306053qkd.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FQ2iJzueZoe0ah52IpIzfsDk3Bg8K/9h7stp9bUbn9I=;
        b=AlTFHSncwZtMZl291WdhniRMkiMbR6JrG2XayqyfQDHaOlR1e/+rakYAJyXuO+BBcL
         +pD29kGJQ2fQerJJVqNYFYkOEsqDgWdH1XmnhLOlCZedBQmeVDLSnw4xk5eJnMj8HN2Z
         x0aACiy7jiQB4Oz/nMBaJ+jV8bPkrQIoKkpaJhboF50MZruj3pPSbPzUMpvwy2OOIXrM
         fS7mQRfyI7zd1Il9j4SssC+J3IGWB8ip/66SLOnDCzRY9dK/AJmTL6yjbzlkNR2BlmQG
         YL8/HvCrdpdwbkGMorTWaUtJn5tOKpeXeLdOxKnkBwqhQ+cq1yZHd4pWPm8jWcM/v/x2
         MqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FQ2iJzueZoe0ah52IpIzfsDk3Bg8K/9h7stp9bUbn9I=;
        b=jOQWkS5sH/Bo/5Ihj+KFB3tu7UALCdYu2pEvN0uQBXgDpeJ7n27btK27xeuoKCLGn9
         yZhQnNMlaXSsnISTcJ4lsG53tXhj+l4YQ7CksD/did4/7cQAit0MSUXXkyLhHPWChXIf
         TQdJ4j69ibkUXIu9C2qA8BOZBUh0xIAdwyhN0q6ijPI1UU4+jvyCKts2ftM79KsVMo5z
         4bOmEew7ykgeOFQHyzNOGKAXQ57BESl3z52tDnfD5gpImaghJWmD/5UgWJrf2Enc+w79
         8ClnCL040jGZTR+GG/u1hWvXhOHXRVqPd+gUZq6ugWpINT2S3sxhHGDHRmPsW7XilojE
         4xZg==
X-Gm-Message-State: AOAM532TSXgc4gH7uec3OXGOFR51DL5O+atdUmzMa6dWFkvqNc4qWss1
        ZFgDvatHCi6tdSe/mrvvxJ7bJ1eAlx8=
X-Google-Smtp-Source: ABdhPJxeZs/aowP+CfcEdTW89mF78t2rG29SSZo/tjhUPpYuLZla84lNKPxTGjxXkam7N07uT61NAw==
X-Received: by 2002:a05:620a:22eb:: with SMTP id p11mr10751595qki.413.1598386288897;
        Tue, 25 Aug 2020 13:11:28 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id n23sm12453459qkk.105.2020.08.25.13.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 13:11:28 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/20] ALSA: hda/ca0132 - Add init data for SoundBlaster AE-7.
Date:   Tue, 25 Aug 2020 16:10:34 -0400
Message-Id: <20200825201040.30339-16-conmanx360@gmail.com>
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

Add initialization data for the SoundBlaster AE-7 card.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index cd46112c827e..dc1eb9bfcc5e 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -3582,6 +3582,7 @@ static void ca0132_gpio_init(struct hda_codec *codec)
 	switch (ca0132_quirk(spec)) {
 	case QUIRK_SBZ:
 	case QUIRK_AE5:
+	case QUIRK_AE7:
 		snd_hda_codec_write(codec, 0x01, 0, 0x793, 0x00);
 		snd_hda_codec_write(codec, 0x01, 0, 0x794, 0x53);
 		snd_hda_codec_write(codec, 0x01, 0, 0x790, 0x23);
@@ -8911,6 +8912,19 @@ static void ca0132_alt_init(struct hda_codec *codec)
 		snd_hda_sequence_write(codec, spec->desktop_init_verbs);
 		ca0113_mmio_command_set(codec, 0x30, 0x32, 0x3f);
 		break;
+	case QUIRK_AE7:
+		ca0132_gpio_init(codec);
+		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+				VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x49);
+		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+				VENDOR_CHIPIO_PLL_PMU_WRITE, 0x88);
+		snd_hda_sequence_write(codec, spec->chip_init_verbs);
+		snd_hda_sequence_write(codec, spec->desktop_init_verbs);
+		chipio_write(codec, 0x18b008, 0x000000f8);
+		chipio_write(codec, 0x18b008, 0x000000f0);
+		chipio_write(codec, 0x18b030, 0x00000020);
+		ca0113_mmio_command_set(codec, 0x30, 0x32, 0x3f);
+		break;
 	case QUIRK_ZXR:
 		snd_hda_sequence_write(codec, spec->chip_init_verbs);
 		snd_hda_sequence_write(codec, spec->desktop_init_verbs);
-- 
2.20.1

