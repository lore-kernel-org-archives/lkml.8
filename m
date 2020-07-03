Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E9AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E10CA206DD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="WK9lutSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgGCHF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCHFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:05:55 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A65C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 00:05:55 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z3so4326042pfn.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 00:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1tVzWaBcXcAIcSS8sXY9snxZzqYH+2Rl4YL7e8hJOjM=;
        b=WK9lutSV8aohCLhH2O7vvNVP18AgWz88xGPef6Tk1YAI+DQ2HqXCXRy4bqeyBAiReO
         S9SBfaT+E/rsH5+uawtdGO+5wNZwnR8NHv5wpZ+Sz61fmvOGelKdc+SnGEXTn5ZOFskc
         5ynnceAafFB6tto143ZnsyfGU550y+q8VzxbYpMifE2ptXE5b0H0McCc66XbJ4cfFIQc
         U3Xf0MM8mBczuJwupscYlUSaBf5RI3Lv6VgpslVT7Yw635ZTijRx8rAFsEqUeQk1sZbd
         WkKCHGpiyLofO3iBBtn5liXFUyqT6ZAD7ZxIlfDqNYxUJkoJcayn6mrfix/UH4wzfqjz
         7Zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1tVzWaBcXcAIcSS8sXY9snxZzqYH+2Rl4YL7e8hJOjM=;
        b=QS88o1tEdnOuEo/MHy/swdk1SvUTavTItiSg1JyebFAuR+uuaMT81RsxniHjYa/Dur
         oOonYMnvLmWG0vVQSmFxkALfuBFP9An84Pz+/f9358hNaj/r5rUPqmIMqrObvVgsR4kQ
         cX0EBfTJqWivlhfL3EAoeEh39F6DEffy+C8z+fcMYxcspLkyLwRMrrQuhvw8RenGG0Kd
         cEVo+qyb1PndB99X8duCDuitB8W9JM70w/OdRinlGuugrVAm4Q2MOtQUHFjOTdbZXAtU
         2v0X8KVazg4f83GE93Y8yBC6DzSkuJBqAYppfuIErS7qjRdxfYUA3tWi3oPv1MZRfxgZ
         A8vA==
X-Gm-Message-State: AOAM533aVy5KWYI/z9xJwpgdzjvUXfpLBB0AV7tWytTANQXAgljGOoRR
        uZJGe/uRraD+MhHlqnUhzbctjg==
X-Google-Smtp-Source: ABdhPJxGi/BdYlejGmgrE/rcM8LCpXTxUzO9vwzvnCwG+dyaUMn01oiAAfHbABHUSHjkCn8XHOLXjw==
X-Received: by 2002:a05:6a00:4f:: with SMTP id i15mr638018pfk.93.1593759955267;
        Fri, 03 Jul 2020 00:05:55 -0700 (PDT)
Received: from starnight.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id p1sm3529764pja.2.2020.07.03.00.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 00:05:54 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>
Subject: [PATCH 1/3] ALSA: hda/realtek - Enable audio jacks of Acer vCopperbox with ALC269VC
Date:   Fri,  3 Jul 2020 15:05:11 +0800
Message-Id: <20200703070512.174394-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Acer desktop vCopperbox with ALC269VC cannot detect the MIC of
headset, the line out and internal speaker until
ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS quirk applied.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 737ef82a75fd..dfb4bca07d3f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6149,6 +6149,7 @@ enum {
 	ALC236_FIXUP_HP_MUTE_LED,
 	ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET,
 	ALC295_FIXUP_ASUS_MIC_NO_PRESENCE,
+	ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -7327,6 +7328,17 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MODE
 	},
+	[ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x14, 0x90100120 }, /* use as internal speaker */
+			{ 0x18, 0x02a111f0 }, /* use as headset mic, without its own jack detect */
+			{ 0x1a, 0x01011020 }, /* use as line out */
+			{ },
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MODE
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7346,6 +7358,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x1099, "Acer Aspire E5-523G", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x110e, "Acer Aspire ES1-432", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1246, "Acer Predator Helios 500", ALC299_FIXUP_PREDATOR_SPK),
+	SND_PCI_QUIRK(0x1025, 0x1247, "Acer vCopperbox", ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS),
 	SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
-- 
2.27.0

