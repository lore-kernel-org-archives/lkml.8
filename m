Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F3CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E37C72068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="jTrxQ6Iy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgGMGGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgGMGGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:06:05 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170C0C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:06:05 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc15so6131746pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MlERMPe6fGAvj4w5/nTL9cv57borO+mmI3Hl4AGrcc4=;
        b=jTrxQ6IyNq2Ysc69R/0IFeTQFBhkhM0+6xrEYqZyvO9DhGt1rl0E/hhiqEgkxY08Bf
         KZku6pqYZMch1MugMhTHA9MPFe6EzZgd/czxeNolMSnMBLKs7eJsFVQzl9DCXYwi0OXp
         l6Kg7F0OmcZxmWNtiVrxOues0aaX3OHFetjsgKIUZFXm/iAObzoIrJjy3k1c3/5GArWg
         aV5tX29fakQCIq3Ihc+JooBiqRGxOFximFhH6gQ7dkd97IE3jwxlp80gGioeedBEwoZB
         exXJM7MHv9a3ZTmZ1cEYsdDzUcP3Xlf/RqT0ssE0YJNnH/Yl3maoHQyuHGIuOI4CR/T7
         AgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MlERMPe6fGAvj4w5/nTL9cv57borO+mmI3Hl4AGrcc4=;
        b=OPbiSfYZKdmYJaQ4Ad0aSvmD6EnrSIFLUGhJryhenT2YSUQujayJluVFfjHPLB/8LY
         /2gSw91xWllaNNBh7ep20XjGBGtTUBvCrdI4awv2/wpL+pQ6JJnzGC5WxxwHaTFd0mLZ
         4PhGz/cV1xdqG+5DoapDiR+1I2sEARYTTmOa2NxTzucK/gs4WIjFOYFg13dIwazPr7ck
         SRHOzSR3xColqa56UAN3iDo+Yh3iJSjfYkAVQjW8BZNJ0HnKb4kPwEPmIQdffVr7Vts0
         potOcDPjs8r0gn3g5sM8fgd/dNQH5mQfvCt3UZLNubc21tWCXro5HgDU2+diH95wd4B+
         5aFA==
X-Gm-Message-State: AOAM533KAkj/Cbh6f5cIHUwxBLSopM6HE47dnG5ahCp9WwB4VNN3SDZB
        7/oQjUX/GpYZQqEFU1qAsG4VyXuypxbWHA==
X-Google-Smtp-Source: ABdhPJxx0ea7ecSDl4FCc5Y25WmO9d3urI7HLdgrZJ05S+ydYUvbkx/eCtceyh2sg1fo2wzE8XjCMA==
X-Received: by 2002:a17:902:c24a:: with SMTP id 10mr64821849plg.82.1594620364526;
        Sun, 12 Jul 2020 23:06:04 -0700 (PDT)
Received: from starnight.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id g6sm13317525pfr.129.2020.07.12.23.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 23:06:04 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] ALSA: hda/realtek: Enable headset mic of Acer TravelMate B311R-31 with ALC256
Date:   Mon, 13 Jul 2020 14:04:22 +0800
Message-Id: <20200713060421.62435-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Acer TravelMate B311R-31 laptop's audio (1025:1430) with ALC256
cannot detect the headset microphone until
ALC256_FIXUP_ACER_MIC_NO_PRESENCE quirk maps the NID 0x19 as the headset
mic pin.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
Re-send for wrong email address

 sound/pci/hda/patch_realtek.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 194ffa8c66ce..0585ac97faf4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6152,6 +6152,7 @@ enum {
 	ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS,
 	ALC269VC_FIXUP_ACER_HEADSET_MIC,
 	ALC269VC_FIXUP_ACER_MIC_NO_PRESENCE,
+	ALC256_FIXUP_ACER_MIC_NO_PRESENCE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -7359,6 +7360,15 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
+	[ALC256_FIXUP_ACER_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x02a11120 }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7387,6 +7397,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x1308, "Acer Aspire Z24-890", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x132a, "Acer TravelMate B114-21", ALC233_FIXUP_ACER_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T", ALC255_FIXUP_ACER_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1025, 0x1430, "Acer TravelMate B311R-31", ALC256_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
 	SND_PCI_QUIRK(0x1028, 0x054b, "Dell XPS one 2710", ALC275_FIXUP_DELL_XPS),
 	SND_PCI_QUIRK(0x1028, 0x05bd, "Dell Latitude E6440", ALC292_FIXUP_DELL_E7X),
-- 
2.27.0

