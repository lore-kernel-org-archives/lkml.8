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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A1BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 068B92074A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qx8DnmHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgHYULK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgHYULB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:11:01 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32052C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:01 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id j10so57298qvo.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lo2pPs5Z3dtcsHghWeXAbSPyEkVTw+1ChIKWljdMLdA=;
        b=Qx8DnmHQIT8sjgDjmiFkvWoisyKLc+4CQbQgLPwhauZg6+nzdBzfk+o46pWa8kHSXk
         XVaSp0fwlJcUHB/PQLI1PzhEy3YKZ4f59WmSKXACgWthAsM/m2B/Ertzlzj+BjXjrh9i
         SnrOcdzC04LZ9UhiiG5veShc0FhCvuuCwTwD9kHxoz/lYTZ/wVbwsgUZAygIVwrzzZZr
         YVfgdfl98UkGYGBttCV20yFfO00SgaGa9JwPj3fQqm4utteYs2qKi1ZetdeshczeJCGd
         qurLX1mRvolvJ7+dH4b/K3cH67O7U/xcVCtAYR8zBLEZQjESFBci+STlJvxw8LS0cppE
         d9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lo2pPs5Z3dtcsHghWeXAbSPyEkVTw+1ChIKWljdMLdA=;
        b=UR3UFBt5fVdcWOoyl3Euaoenk1ClmRcRljX4piExC0swu0S2JW9jzVfEj+2259VbQq
         1lHKsGrGl5/2780H2mmsvhzklBB4ZFx2e1yTYhHexZdEuANib8u+AsfwxrDO0kJ3mxwi
         sHKbw8R1YYCwHREeB1wkOMa0d+Sh4HvfvqjFg92jTZmxtWhAwcQ8UMpECKFVzUsSwgDr
         ZkiDtOuvgZ38BcLU/cMGlLbDhYni/eIYlU9SEGihvZPM4DBKqRLgMQbXulR4Pvdg1wW/
         iXsSvSLw/adXFNklvhYkVwgzi6mqYHz0WcUKLCS6E7/7qKWelrqb9gwiJcR3531skpZL
         x0Iw==
X-Gm-Message-State: AOAM532VREc36GCbmQZGX/xLkyMvXgoG/Ci1hsHPNfXiKJ/5yJV94UzJ
        PC9IWH+rlpQ4DHrRpxaJZSM=
X-Google-Smtp-Source: ABdhPJzTkVy28b/qFDiVm80to8A8hRW3Gn+p7w7LTsOS4XysKirqXaShwjqE3WTnatRb2usNQRZ7VA==
X-Received: by 2002:a05:6214:612:: with SMTP id z18mr11318242qvw.25.1598386260361;
        Tue, 25 Aug 2020 13:11:00 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id n23sm12453459qkk.105.2020.08.25.13.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 13:10:59 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/20] ALSA: hda/ca0132 - Cleanup ca0132_mmio_init function.
Date:   Tue, 25 Aug 2020 16:10:20 -0400
Message-Id: <20200825201040.30339-2-conmanx360@gmail.com>
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

Cleanup the ca0132_mmio_init function, separating into two separate
functions, one for Sound Blaster Z/ZxR/Recon3D, and another for the
AE-5.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 158 ++++++++++++++++++++++-------------
 1 file changed, 99 insertions(+), 59 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index b7dbf2e7f77a..7491e2044638 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -8108,78 +8108,118 @@ static void r3di_pre_dsp_setup(struct hda_codec *codec)
  * what they do, or if they're necessary. Could possibly
  * be removed. Figure they're better to leave in.
  */
-static void ca0132_mmio_init(struct hda_codec *codec)
+static const unsigned int ca0113_mmio_init_address_sbz[] = {
+	0x400, 0x408, 0x40c, 0x01c, 0xc0c, 0xc00, 0xc04, 0xc0c, 0xc0c, 0xc0c,
+	0xc0c, 0xc08, 0xc08, 0xc08, 0xc08, 0xc08, 0xc04
+};
+
+static const unsigned int ca0113_mmio_init_data_sbz[] = {
+	0x00000030, 0x00000000, 0x00000003, 0x00000003, 0x00000003,
+	0x00000003, 0x000000c1, 0x000000f1, 0x00000001, 0x000000c7,
+	0x000000c1, 0x00000080
+};
+
+static const unsigned int ca0113_mmio_init_data_zxr[] = {
+	0x00000030, 0x00000000, 0x00000000, 0x00000003, 0x00000003,
+	0x00000003, 0x00000001, 0x000000f1, 0x00000001, 0x000000c7,
+	0x000000c1, 0x00000080
+};
+
+static const unsigned int ca0113_mmio_init_address_ae5[] = {
+	0x400, 0x42c, 0x46c, 0x4ac, 0x4ec, 0x43c, 0x47c, 0x4bc, 0x4fc, 0x408,
+	0x100, 0x410, 0x40c, 0x100, 0x100, 0x830, 0x86c, 0x800, 0x86c, 0x800,
+	0x804, 0x20c, 0x01c, 0xc0c, 0xc00, 0xc04, 0xc0c, 0xc0c, 0xc0c, 0xc0c,
+	0xc08, 0xc08, 0xc08, 0xc08, 0xc08, 0xc04, 0x01c
+};
+
+static const unsigned int ca0113_mmio_init_data_ae5[] = {
+	0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000001,
+	0x00000600, 0x00000014, 0x00000001, 0x0000060f, 0x0000070f,
+	0x00000aff, 0x00000000, 0x0000006b, 0x00000001, 0x0000006b,
+	0x00000057, 0x00800000, 0x00880680, 0x00000080, 0x00000030,
+	0x00000000, 0x00000000, 0x00000003, 0x00000003, 0x00000003,
+	0x00000001, 0x000000f1, 0x00000001, 0x000000c7, 0x000000c1,
+	0x00000080, 0x00880680
+};
+
+static void ca0132_mmio_init_sbz(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
+	unsigned int tmp[2], i, count, cur_addr;
+	const unsigned int *addr, *data;
 
-	if (ca0132_quirk(spec) == QUIRK_AE5)
-		writel(0x00000001, spec->mem_base + 0x400);
-	else
-		writel(0x00000000, spec->mem_base + 0x400);
+	addr = ca0113_mmio_init_address_sbz;
+	for (i = 0; i < 3; i++)
+		writel(0x00000000, spec->mem_base + addr[i]);
 
-	if (ca0132_quirk(spec) == QUIRK_AE5)
-		writel(0x00000001, spec->mem_base + 0x408);
-	else
-		writel(0x00000000, spec->mem_base + 0x408);
+	cur_addr = i;
+	switch (ca0132_quirk(spec)) {
+	case QUIRK_ZXR:
+		tmp[0] = 0x00880480;
+		tmp[1] = 0x00000080;
+		break;
+	case QUIRK_SBZ:
+		tmp[0] = 0x00820680;
+		tmp[1] = 0x00000083;
+		break;
+	case QUIRK_R3D:
+		tmp[0] = 0x00880680;
+		tmp[1] = 0x00000083;
+		break;
+	default:
+		tmp[0] = 0x00000000;
+		tmp[1] = 0x00000000;
+		break;
+	}
 
-	if (ca0132_quirk(spec) == QUIRK_AE5)
-		writel(0x00000001, spec->mem_base + 0x40c);
-	else
-		writel(0x00000000, spec->mem_base + 0x40C);
+	for (i = 0; i < 2; i++)
+		writel(tmp[i], spec->mem_base + addr[cur_addr + i]);
 
-	if (ca0132_quirk(spec) == QUIRK_ZXR)
-		writel(0x00880640, spec->mem_base + 0x01C);
-	else
-		writel(0x00880680, spec->mem_base + 0x01C);
+	cur_addr += i;
 
-	if (ca0132_quirk(spec) == QUIRK_AE5)
-		writel(0x00000080, spec->mem_base + 0xC0C);
-	else
-		writel(0x00000083, spec->mem_base + 0xC0C);
+	switch (ca0132_quirk(spec)) {
+	case QUIRK_ZXR:
+		count = ARRAY_SIZE(ca0113_mmio_init_data_zxr);
+		data = ca0113_mmio_init_data_zxr;
+		break;
+	default:
+		count = ARRAY_SIZE(ca0113_mmio_init_data_sbz);
+		data = ca0113_mmio_init_data_sbz;
+		break;
+	}
 
-	writel(0x00000030, spec->mem_base + 0xC00);
-	writel(0x00000000, spec->mem_base + 0xC04);
+	for (i = 0; i < count; i++)
+		writel(data[i], spec->mem_base + addr[cur_addr + i]);
+}
 
-	if (ca0132_quirk(spec) == QUIRK_AE5)
-		writel(0x00000000, spec->mem_base + 0xC0C);
-	else
-		writel(0x00000003, spec->mem_base + 0xC0C);
+static void ca0132_mmio_init_ae5(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	const unsigned int *addr, *data;
+	unsigned int i, count;
 
-	writel(0x00000003, spec->mem_base + 0xC0C);
-	writel(0x00000003, spec->mem_base + 0xC0C);
-	writel(0x00000003, spec->mem_base + 0xC0C);
+	addr = ca0113_mmio_init_address_ae5;
+	data = ca0113_mmio_init_data_ae5;
+	count = ARRAY_SIZE(ca0113_mmio_init_data_ae5);
 
-	if (ca0132_quirk(spec) == QUIRK_AE5)
-		writel(0x00000001, spec->mem_base + 0xC08);
-	else
-		writel(0x000000C1, spec->mem_base + 0xC08);
+	for (i = 0; i < count; i++)
+		writel(data[i], spec->mem_base + addr[i]);
+}
 
-	writel(0x000000F1, spec->mem_base + 0xC08);
-	writel(0x00000001, spec->mem_base + 0xC08);
-	writel(0x000000C7, spec->mem_base + 0xC08);
-	writel(0x000000C1, spec->mem_base + 0xC08);
-	writel(0x00000080, spec->mem_base + 0xC04);
+static void ca0132_mmio_init(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
 
-	if (ca0132_quirk(spec) == QUIRK_AE5) {
-		writel(0x00000000, spec->mem_base + 0x42c);
-		writel(0x00000000, spec->mem_base + 0x46c);
-		writel(0x00000000, spec->mem_base + 0x4ac);
-		writel(0x00000000, spec->mem_base + 0x4ec);
-		writel(0x00000000, spec->mem_base + 0x43c);
-		writel(0x00000000, spec->mem_base + 0x47c);
-		writel(0x00000000, spec->mem_base + 0x4bc);
-		writel(0x00000000, spec->mem_base + 0x4fc);
-		writel(0x00000600, spec->mem_base + 0x100);
-		writel(0x00000014, spec->mem_base + 0x410);
-		writel(0x0000060f, spec->mem_base + 0x100);
-		writel(0x0000070f, spec->mem_base + 0x100);
-		writel(0x00000aff, spec->mem_base + 0x830);
-		writel(0x00000000, spec->mem_base + 0x86c);
-		writel(0x0000006b, spec->mem_base + 0x800);
-		writel(0x00000001, spec->mem_base + 0x86c);
-		writel(0x0000006b, spec->mem_base + 0x800);
-		writel(0x00000057, spec->mem_base + 0x804);
-		writel(0x00800000, spec->mem_base + 0x20c);
+	switch (ca0132_quirk(spec)) {
+	case QUIRK_R3D:
+	case QUIRK_SBZ:
+	case QUIRK_ZXR:
+		ca0132_mmio_init_sbz(codec);
+		break;
+	case QUIRK_AE5:
+		ca0132_mmio_init_ae5(codec);
+		break;
 	}
 }
 
-- 
2.20.1

