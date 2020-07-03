Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4248EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1190821548
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="CVuXoOBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgGCHGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCHGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:06:55 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4ADC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 00:06:55 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f3so14700697pgr.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 00:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qZjFkIVJTz9thTx+GrzMJX0wDRAys5DOTPVI0ovJ+iM=;
        b=CVuXoOBOVKnzWQ1+4EX86/AeV4yV7/24FrDAkOtOKsSTcP0e7nrxWMsW1cJBLHTzYo
         rvsZzOPMI26z2LP9nY6Zc/yPLYWQfU+0ad7x1RIpMJFnb1qU+wVhkVjGevC3VXaNNG5l
         qeGf8+s4geDIaq2rt0pV8OShhDUD3XXJb+3abQAwXTox4ZVpdBVYnpvBXupyz5KT1D8W
         zSzBDD7ifHAaf1Fv2IenQn/AWWai64JG3swoTUSJvJumxHb9AIHTLJUI3QQ72wCqpaHq
         Lsi2m6PP4hFocDXVx+6UYgB+yXRFOJus2vBlbySvd0rEw+SHLnT11yGzbSt6kde+kmFc
         DUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qZjFkIVJTz9thTx+GrzMJX0wDRAys5DOTPVI0ovJ+iM=;
        b=BoDQVGYkmj2rYfoG4ZOKuxBxk4R7HWl0pX3HJ1qAi0OBd9xqvacv0vl+9uMc4Mu2lY
         kI3lPbVVLfq+3qfAeIAFTzw+L1ZQI08qvHFPH9vFERszHpZkIwuS4g4Cjzybcz60bp+I
         VG9Sg2v9Iab+8khmnYTM5qSQF+v2oJc6vv4F/FpjA542wy/9Ly4AX2wz7cYYgwjXMb0U
         1lsev+L1X7p6VbAcVly6fLxXmhk2Vw27NFITAd3leuUM9kzZGf2Jh/0LfkbxjxV0s9gQ
         w6fWkln5hM4LsK0HP/70/i1QyjB/grh7S4wxR2r2I1/97y1eT8U+ao2XVK5X0c6WK8TC
         B2uQ==
X-Gm-Message-State: AOAM531IiTy2fHfeg3N/PNdQBvXar0bT4HkQJqpZMlfFzYSFh7VqVkAp
        kPltiL4RpJH6XZTJ3/Pl3MeiVYt5W0zDPwCU
X-Google-Smtp-Source: ABdhPJyy3l4qFH7FwIRz0AG+TcbmJt6Z71Eiyguflbvc+p56xo8H509bviHjQYsZvaxm9C/QxUEdBA==
X-Received: by 2002:a63:135b:: with SMTP id 27mr19533356pgt.37.1593760014502;
        Fri, 03 Jul 2020 00:06:54 -0700 (PDT)
Received: from starnight.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id p1sm3529764pja.2.2020.07.03.00.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 00:06:54 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH 3/3] ALSA: hda/realtek: Enable headset mic of Acer Veriton N4660G with ALC269VC
Date:   Fri,  3 Jul 2020 15:05:16 +0800
Message-Id: <20200703070512.174394-3-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200703070512.174394-1-jian-hong@endlessm.com>
References: <20200703070512.174394-1-jian-hong@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Acer Veriton N4660G desktop's audio (1025:1248) with ALC269VC cannot
detect the headset microphone until ALC269VC_FIXUP_ACER_MIC_NO_PRESENCE
quirk maps the NID 0x18 as the headset mic pin.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3255da8b3849..02054a2a742f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6151,6 +6151,7 @@ enum {
 	ALC295_FIXUP_ASUS_MIC_NO_PRESENCE,
 	ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS,
 	ALC269VC_FIXUP_ACER_HEADSET_MIC,
+	ALC269VC_FIXUP_ACER_MIC_NO_PRESENCE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -7349,6 +7350,15 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
 	},
+	[ALC269VC_FIXUP_ACER_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x18, 0x01a11130 }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MODE
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7370,6 +7380,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x110e, "Acer Aspire ES1-432", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1246, "Acer Predator Helios 500", ALC299_FIXUP_PREDATOR_SPK),
 	SND_PCI_QUIRK(0x1025, 0x1247, "Acer vCopperbox", ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS),
+	SND_PCI_QUIRK(0x1025, 0x1248, "Acer Veriton N4660G", ALC269VC_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
-- 
2.27.0

