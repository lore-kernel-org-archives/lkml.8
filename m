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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741ABC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 552622074A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAMO1U+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgHYUL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgHYULg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:11:36 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C18C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:35 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id w2so62133qvh.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/+cwVyjZiU4lXoMXrR09xnU2c7BRFNH9q0stX6k3GcY=;
        b=dAMO1U+RevIO7rh5rOP9d3DmIrKRIYbMXoicQvkuxYjBSssIN91V63VzUq8v+ElC+J
         kEFSsOQeSsEE+MRgem6spXGSpf39HhkO3zZiAA/aa7J/QrVI2oIXadp57dY/HnHnYnyT
         ZqY+xCLsWwOxsfZqUCllIvLNJQQsJrsgci3GJXQG9YdaOhXYdMkAEjLnOjsnPN3TwK7w
         ZX0inEKHyz3zBtgxakoa1LFcYPk46N5MM6FD0Fb9FvtzTH49mH/AazMFlPrFXPJvJ0iw
         doXU1Q5PL+18F7l+V4Dhg+dzaYTJJe96DSFC/8k9unw9ZNOms1Hh+4rxQSHrNZtWxP5d
         tSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/+cwVyjZiU4lXoMXrR09xnU2c7BRFNH9q0stX6k3GcY=;
        b=YFOyYkRtv0kB+rVsqqbRnGNQReOYGHYL8H0PNf5T1JrQq7WgIIIC+kwwNiFqDYq1Wu
         DqNBgUczWaDoZUEXrLHxAjnM+axx14esNhHREzRQkhvY5yNinyIlT5ZQCPB7b1J0oc4h
         3XGCf6lJE/fSsCMPeCHp1Efgb8bpMwM3BsmC3bsjC7BSWFixW/jJTy/OxyEmGckDmMs8
         2wofg7KZBj3lqHtriOcitfRxhs6+Adamapv6UFO+F1Usr3oLb5izgalWAzICFnWVPhqf
         CtqhJiUrS1mCyS94f+HGJJKw6K7r5JKgtsRi/tRWwaopZFxKJkUl75oRT9CGB8dUa+4m
         DIPA==
X-Gm-Message-State: AOAM533knQteJ7u32uTUCS9jJUHMEWBPp1FhUjUszmKXZo+CDoIOP7Fd
        7Q4Ej+0xisWJgHkMtQjvu+Y=
X-Google-Smtp-Source: ABdhPJxPOQcCxc3raJ9IRb9qpgoHHl7LUdH4TqQCk5D7HKxNaWnG7oex+RuA/9J9uFMXPxP7rM0+QA==
X-Received: by 2002:ad4:4482:: with SMTP id m2mr11266618qvt.102.1598386294963;
        Tue, 25 Aug 2020 13:11:34 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id n23sm12453459qkk.105.2020.08.25.13.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 13:11:34 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/20] ALSA: hda/ca0132 - Add AE-7 microphone selection commands.
Date:   Tue, 25 Aug 2020 16:10:37 -0400
Message-Id: <20200825201040.30339-19-conmanx360@gmail.com>
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

Add AE-7 quirk data for setting of microphone. The AE-7 has no front
panel connector, so only rear-mic/line-in have new commands.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index dcc8d29d934c..8c6e38734489 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4997,6 +4997,15 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 			ca0113_mmio_command_set(codec, 0x30, 0x28, 0x00);
 			tmp = FLOAT_THREE;
 			break;
+		case QUIRK_AE7:
+			ca0113_mmio_command_set(codec, 0x30, 0x28, 0x00);
+			tmp = FLOAT_THREE;
+			chipio_set_conn_rate(codec, MEM_CONNID_MICIN2,
+					SR_96_000);
+			chipio_set_conn_rate(codec, MEM_CONNID_MICOUT2,
+					SR_96_000);
+			dspio_set_uint_param(codec, 0x80, 0x01, FLOAT_ZERO);
+			break;
 		default:
 			tmp = FLOAT_ONE;
 			break;
@@ -5042,6 +5051,14 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 		case QUIRK_AE5:
 			ca0113_mmio_command_set(codec, 0x30, 0x28, 0x00);
 			break;
+		case QUIRK_AE7:
+			ca0113_mmio_command_set(codec, 0x30, 0x28, 0x3f);
+			chipio_set_conn_rate(codec, MEM_CONNID_MICIN2,
+					SR_96_000);
+			chipio_set_conn_rate(codec, MEM_CONNID_MICOUT2,
+					SR_96_000);
+			dspio_set_uint_param(codec, 0x80, 0x01, FLOAT_ZERO);
+			break;
 		default:
 			break;
 		}
@@ -5051,7 +5068,10 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 		if (ca0132_quirk(spec) == QUIRK_R3DI)
 			chipio_set_conn_rate(codec, 0x0F, SR_96_000);
 
-		tmp = FLOAT_ZERO;
+		if (ca0132_quirk(spec) == QUIRK_AE7)
+			tmp = FLOAT_THREE;
+		else
+			tmp = FLOAT_ZERO;
 		dspio_set_uint_param(codec, 0x80, 0x00, tmp);
 
 		switch (ca0132_quirk(spec)) {
-- 
2.20.1

