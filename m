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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7E6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBEDD2076E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvnzpEJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgHUSyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgHUSyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:54:10 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C04CC061755
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:54:10 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id p25so2286645qkp.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ySHRdkEI0EzJJJO/AyNWTBnHyWXEreYyyJNUq9kZfoI=;
        b=WvnzpEJKTyoNFkklI2snGsgG7wnjHqExJLQZdJLXjtTLqZzWaF2bP9DYyTR4V5Ah47
         4vzmMozsf38RuDW4GWrUwjlxTLpZm4/UUNfAVoSQttCYVFe1NYjCuZ9Vs+7a59IJOrWR
         O417+z5lftpavPgruh6z6JTPcLF+3WvdotmEZnzNFJz2rilEP5IkaY5Os7rBzL11FWiw
         vwxNoL4HY9lj+tKJ6+DFfAsj3Ky+mYERhLRwfTINtIB5lDu+9+xromc2arB+KpPT9IM2
         WXC/Yv1yhVpV9lm0BeBpNXvdk6w8toaRw1Xw0rEMdPdCQE5oihEwEcrW1li5S6Tg5InH
         0/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ySHRdkEI0EzJJJO/AyNWTBnHyWXEreYyyJNUq9kZfoI=;
        b=B+K3N3Ic24esSgXjy6FKNKQZgo2Co+h4la2cHQ7J1BCYX1m40ufPsfymvoajx0f7JV
         RcgB6f7/jxFrqlxAO1pKtlHG7nqEFdb8FIXIEy1452EF1NBQmiMJ9TC7GFZz87sAO4k+
         WtRzjOTCYVhro7IVy6tMDbg3if9s2oX0wImfu5AGaXFQ2pF6io8QMRd6VK59cNOB5wif
         UEB2C2BQpyhaBTMinb23zYsVQLASPkp165PGmVWFt3Qd6uWGZ+dNe1aI42ymQDQanb6g
         gDXM0eOap6064wkjzBnckaCj3nJytQeyBaOM8o5TRvIWgsy7H3mnqHrOgWg4aSneUMUs
         6pTw==
X-Gm-Message-State: AOAM5329YYlRXIO0WPzI5O9uqz9efqAP1E7QeYmmSqYOZjdpMvG2fK/I
        P7LKCJWlCXZiSNfUFS2uJ0g=
X-Google-Smtp-Source: ABdhPJy0tFKmH9MuzNd+9OhMKF+hWTMOFGz9YUA1vkqDjMV5krKUFZVy5qe+JYghg+8cHC2G6S+5yg==
X-Received: by 2002:a37:8601:: with SMTP id i1mr4143086qkd.307.1598036049415;
        Fri, 21 Aug 2020 11:54:09 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id o72sm2468426qka.113.2020.08.21.11.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:54:09 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/20] ALSA: hda/ca0132 - Add init data for SoundBlaster AE-7.
Date:   Fri, 21 Aug 2020 14:52:32 -0400
Message-Id: <20200821185239.26133-16-conmanx360@gmail.com>
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

Add initialization data for the SoundBlaster AE-7 card.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 9a1491d33819..4ec93a070d73 100644
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

