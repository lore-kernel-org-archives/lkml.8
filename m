Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8EDC433E6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C1B42070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="sgSnX4Bv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgGFHTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 03:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728832AbgGFHTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 03:19:52 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AD6C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 00:19:52 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x3so11065826pfo.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 00:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O74Nuai4i0SLX5VBGfHYZHCvuzscSOHQ2q6kAb3CK+Q=;
        b=sgSnX4BvnCsHbxM0A5WWFsmuE95MfmeQXIjkXZbR2BNWgcCW1NKpULF4OKiZwMPf2F
         SkM7pF7DPNg+vYebyjW8hcfK/wLQvoRq8NDdij03laNTuA/b0770dCQrB9Sal4EyYLgV
         YdRhA0c/egElceVCWwUTJI5re6E2kthSlvIAaEIOWCRjD5G3YPHELvH7WFlivgQbJswP
         ErLpEU4nnu0sZg68ioKM3Tf4RdO6DAaaO/ybGyTahRQZI8lmCpEZMAPlDoGRoAhNz4cU
         XxOWXJg9ydKvmgsX0zaiUnu2Rv45vfUmfHcFhxxqgAfYImQ2TqZ6sLU0FvU5ESorX9D/
         +XAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O74Nuai4i0SLX5VBGfHYZHCvuzscSOHQ2q6kAb3CK+Q=;
        b=I3jcnC3JwFw6LIxbdpfumX6dSkzC+zJSDBypp3+dvNYgjOIRWQrulxe6mh/+/uy16J
         thl/4fjjVdqLxfutF0fLQ1oxdYoOLeh7BzwxufVx+CXG7LYL9kl7lq+KqIW930HMkgC0
         ILLFVvSsYJXaLJpJFuovg0fbOxJDdrVzgdhK4PYMaTJcYC+wlN+P4SDPThf+mtTVOuGv
         /QyeXdzUaBwHVB7mbdwyRekMJriQhpyEIzpap4U8tBDy/qkLEDrDDbrdePLJI5WKUHoA
         7p/E0kI6opjQwbOywCB9wqwpSHK34Yd5NvpDNiE4eGKs90Vwvh8Ln46eX899SM7Hz1bM
         6wiw==
X-Gm-Message-State: AOAM532vPvlZz+H5HGTM9uMXlF+Ii5Afs0iKA4yhs3KKYDGKrHRz+yo8
        Ifuw6Ufzx9q0qRejKyheUogV3nC+dJxSkA==
X-Google-Smtp-Source: ABdhPJy97C5d00A/1zRlOr0gcTDJG1/xcPA2z9ugXTaAcrfTaHjW/vgXKJw1+14TyG8kSOVZet0P2Q==
X-Received: by 2002:aa7:848b:: with SMTP id u11mr28920909pfn.72.1594019991291;
        Mon, 06 Jul 2020 00:19:51 -0700 (PDT)
Received: from starnight.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id f18sm17825210pgv.84.2020.07.06.00.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 00:19:50 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>
Subject: [PATCH v3 1/3] ALSA: hda/realtek - Enable audio jacks of Acer vCopperbox with ALC269VC
Date:   Mon,  6 Jul 2020 15:18:25 +0800
Message-Id: <20200706071826.39726-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <aa62a43d4f1f458fb11794c26d373528@realtek.com>
References: <aa62a43d4f1f458fb11794c26d373528@realtek.com>
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
v3: Change the chained ID to ALC269_FIXUP_HEADSET_MIC according to
    Realtek's suggestion

 sound/pci/hda/patch_realtek.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 737ef82a75fd..13c32655df44 100644
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
+		.chain_id = ALC269_FIXUP_HEADSET_MIC
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

