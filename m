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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06570C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7A5C20738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIP3jMK1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgHYUMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgHYUL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:11:27 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDD5C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:27 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id m7so12287212qki.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NxP3rQXiCSclAsMcIFJFVBcoqDGCfKXN2d02ZJbg+bQ=;
        b=GIP3jMK1OzR7Aq43LTTYjoeRlqIaCXyJWm2lJtUo4jyZjHNrCm10gBr7AOom0R6gtV
         7NnSfLT9Jg8IWfgmdzo704nD5kIwv9hAaNlr9OUbeJJyUETugpgZ1ESlNOPeCysNdS/i
         z2SScJCAGXFsceEwsYHDcRI9FwRJlG2wK12IoMSYtVhTzn26RsprCK//EJ+e/PKZNwAD
         l62v2xn4Q25nNQ924y9ob8hlXWjZPuwByRxIpeAmIYCAYoy+TWLTYr+kr0rBCs9CKyrV
         48QntxFKjyIbR1rh6WOGLn6VXlOQ0wE5g41eajOOfmstzj98LgHO9+01DoHEJMevujUM
         hqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NxP3rQXiCSclAsMcIFJFVBcoqDGCfKXN2d02ZJbg+bQ=;
        b=Yt8Lb4m5TvV9I+oLoRES/dFtWIChqnOG9qKSVW2qlslEDKoOy/ApOXMX8eDSUyvJMZ
         BfqpQjpO2H/VpAp69rgM4xjxZtsER6VMnA1fkTfbEs2kpmScE1OMJ2pzRHQDuvvEqPV1
         pKgAph0APWFKa9Ltwa3N+YF9O3BZEKVDjuUDyDVyIfIsC8WCrGlz2BH61Y5e8Rj5G8ru
         a6ykAuOxWrJqBJ0gUfhBSlURAebH10+XGyvYSNICdFLwLINwRyM9P38Vwb19C6K5rhh4
         f4QB9XxVHBn0aGJFszBzelxBZuQfcHEqPY/ckgX8+IwWkTJg10x3QoRg5xp/q1tESIxr
         l8wQ==
X-Gm-Message-State: AOAM533yDatjy65S7zwA7SfaNguGzFOJTRQdpt7e8W1igcT/tts03bx/
        tq5x8ykeyNSq0XDKFabS6t4=
X-Google-Smtp-Source: ABdhPJwvqY/3gycbChlBkROJ6M19+JYts0F3JvZuSzYyZ0ZhrS9L+WsYU4fy9e7VNRjpYPRGIR4Mtw==
X-Received: by 2002:a05:620a:15b0:: with SMTP id f16mr10917378qkk.191.1598386286791;
        Tue, 25 Aug 2020 13:11:26 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id n23sm12453459qkk.105.2020.08.25.13.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 13:11:26 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/20] ALSA: hda/ca0132 - Add pre-init function for SoundBlaster AE-7.
Date:   Tue, 25 Aug 2020 16:10:33 -0400
Message-Id: <20200825201040.30339-15-conmanx360@gmail.com>
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

Add pre DSP initialization function for the AE-7.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 70 ++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 15 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 10aaa4806946..cd46112c827e 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -8786,6 +8786,16 @@ static void ca0132_mmio_init(struct hda_codec *codec)
 	}
 }
 
+static const unsigned int ca0132_ae5_register_set_addresses[] = {
+	0x304, 0x304, 0x304, 0x304, 0x100, 0x304, 0x100, 0x304, 0x100, 0x304,
+	0x100, 0x304, 0x86c, 0x800, 0x86c, 0x800, 0x804
+};
+
+static const unsigned char ca0132_ae5_register_set_data[] = {
+	0x0f, 0x0e, 0x1f, 0x0c, 0x3f, 0x08, 0x7f, 0x00, 0xff, 0x00, 0x6b,
+	0x01, 0x6b, 0x57
+};
+
 /*
  * This function writes to some SFR's, does some region2 writes, and then
  * eventually resets the codec with the 0x7ff verb. Not quite sure why it does
@@ -8794,6 +8804,18 @@ static void ca0132_mmio_init(struct hda_codec *codec)
 static void ae5_register_set(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
+	unsigned int count = ARRAY_SIZE(ca0132_ae5_register_set_addresses);
+	const unsigned int *addr = ca0132_ae5_register_set_addresses;
+	const unsigned char *data = ca0132_ae5_register_set_data;
+	unsigned int i, cur_addr;
+	unsigned char tmp[3];
+
+	if (ca0132_quirk(spec) == QUIRK_AE7) {
+		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+				    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x41);
+		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+				    VENDOR_CHIPIO_PLL_PMU_WRITE, 0xc8);
+	}
 
 	chipio_8051_write_direct(codec, 0x93, 0x10);
 	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
@@ -8801,25 +8823,43 @@ static void ae5_register_set(struct hda_codec *codec)
 	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
 			    VENDOR_CHIPIO_PLL_PMU_WRITE, 0xc2);
 
-	writeb(0x0f, spec->mem_base + 0x304);
-	writeb(0x0f, spec->mem_base + 0x304);
-	writeb(0x0f, spec->mem_base + 0x304);
-	writeb(0x0f, spec->mem_base + 0x304);
-	writeb(0x0e, spec->mem_base + 0x100);
-	writeb(0x1f, spec->mem_base + 0x304);
-	writeb(0x0c, spec->mem_base + 0x100);
-	writeb(0x3f, spec->mem_base + 0x304);
-	writeb(0x08, spec->mem_base + 0x100);
-	writeb(0x7f, spec->mem_base + 0x304);
-	writeb(0x00, spec->mem_base + 0x100);
-	writeb(0xff, spec->mem_base + 0x304);
+	if (ca0132_quirk(spec) == QUIRK_AE7) {
+		tmp[0] = 0x03;
+		tmp[1] = 0x03;
+		tmp[2] = 0x07;
+	} else {
+		tmp[0] = 0x0f;
+		tmp[1] = 0x0f;
+		tmp[2] = 0x0f;
+	}
 
-	ca0113_mmio_command_set(codec, 0x30, 0x2d, 0x3f);
+	for (i = cur_addr = 0; i < 3; i++, cur_addr++)
+		writeb(tmp[i], spec->mem_base + addr[cur_addr]);
+
+	/*
+	 * First writes are in single bytes, final are in 4 bytes. So, we use
+	 * writeb, then writel.
+	 */
+	for (i = 0; cur_addr < 12; i++, cur_addr++)
+		writeb(data[i], spec->mem_base + addr[cur_addr]);
+
+	for (; cur_addr < count; i++, cur_addr++)
+		writel(data[i], spec->mem_base + addr[cur_addr]);
+
+	writel(0x00800001, spec->mem_base + 0x20c);
+
+	if (ca0132_quirk(spec) == QUIRK_AE7) {
+		ca0113_mmio_command_set_type2(codec, 0x48, 0x07, 0x83);
+		ca0113_mmio_command_set(codec, 0x30, 0x2e, 0x3f);
+	} else {
+		ca0113_mmio_command_set(codec, 0x30, 0x2d, 0x3f);
+	}
 
 	chipio_8051_write_direct(codec, 0x90, 0x00);
 	chipio_8051_write_direct(codec, 0x90, 0x10);
 
-	ca0113_mmio_command_set(codec, 0x48, 0x07, 0x83);
+	if (ca0132_quirk(spec) == QUIRK_AE5)
+		ca0113_mmio_command_set(codec, 0x48, 0x07, 0x83);
 
 	chipio_write(codec, 0x18b0a4, 0x000000c2);
 
@@ -8918,7 +8958,7 @@ static int ca0132_init(struct hda_codec *codec)
 
 	snd_hda_power_up_pm(codec);
 
-	if (ca0132_quirk(spec) == QUIRK_AE5)
+	if (ca0132_quirk(spec) == QUIRK_AE5 || ca0132_quirk(spec) == QUIRK_AE7)
 		ae5_register_set(codec);
 
 	ca0132_init_unsol(codec);
-- 
2.20.1

