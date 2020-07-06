Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1A6C433E4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F29F20715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="usBlw4O/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgGFHUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 03:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbgGFHUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 03:20:31 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E268C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 00:20:31 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ch3so1461253pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 00:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CUjOCBzJzHZGlbM/LYArmMgBHJ4SZ/ZCIHU1HiTNVeA=;
        b=usBlw4O/gmejQLVUZZlYw0kQnxq4GauNQ154hpOYplmmBgH+QjlS6wW1MCyNmQAEYc
         VgIJ87k6wMU/LRBRAiPVrG4Mq+eHOV5bpnplpssw97Ebcp8en/Vmbzk3IC+S2xaCmchd
         B4fQWSGeccoxsuff7VOEcOm12+xTR2jIVQF31iL2uzpq1Sn4eRM+aQJHRdRJubxStA2G
         oZRZv2nSflASVFIImduypO2rx/VrGLrAmRaCDI6lzcKtygmbCIf7mLkrAZqGZzeij04k
         +JcoaAS3owh3T1TlnQCny5X2RRceUQX482FBGjugBrBkGFi+6+57Fl8wq8K0XCNAAdtv
         IK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CUjOCBzJzHZGlbM/LYArmMgBHJ4SZ/ZCIHU1HiTNVeA=;
        b=fw2gA6XHZtiCyV+ci1J17NGWyQ6EQx1HBtVF9UXVjjBcxhMIwHTppgo2hbT7rmZl0J
         6SasUZnDNrxY7KeR1MHwzGQ77LeUcubd1fmFGQt4P8OjRw2rclfLL/aGoZq6xQHg5PyV
         hwPDzOYO8TldeKNYBNqHeKP7Q4YmT9CCi7uQCpjMZjQJJQdn36+BMra0q6jqyCN0amaf
         ivQGECfT02SbaxDoc4eiD75KDV15NfaYRshq2+7a8eufBNNRdfgxZub0YKbjkq5DziIY
         cG2tzJ94pkzfth+QWXMxcUvPITN2Kt/LcJMw67x4W1Spuhj5NO7BwD3jR1s9+Rg23udr
         EJlw==
X-Gm-Message-State: AOAM533ScZ0yqx0lK/b+Tm+Ihfb7a72I1ZN8IHo556I31va1USk54PuT
        LYQPF6kxYSWl3zaS8jW2Lhh7og==
X-Google-Smtp-Source: ABdhPJyGDFe4YRXz9gpczWaXXbPvo1uMz8oukjySBx3ZILFkG2vsakTo2pzJAur0RmMp3klhqK2s5A==
X-Received: by 2002:a17:902:728c:: with SMTP id d12mr40859452pll.155.1594020031088;
        Mon, 06 Jul 2020 00:20:31 -0700 (PDT)
Received: from starnight.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id f18sm17825210pgv.84.2020.07.06.00.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 00:20:30 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH v3 3/3] ALSA: hda/realtek: Enable headset mic of Acer Veriton N4660G with ALC269VC
Date:   Mon,  6 Jul 2020 15:18:29 +0800
Message-Id: <20200706071826.39726-3-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <aa62a43d4f1f458fb11794c26d373528@realtek.com>
References: <aa62a43d4f1f458fb11794c26d373528@realtek.com>
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
v3: Change the chained ID to ALC269_FIXUP_HEADSET_MIC according to
    Realtek's suggestion

 sound/pci/hda/patch_realtek.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index be18b304e731..c2e6a6b7ea5b 100644
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
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
+	[ALC269VC_FIXUP_ACER_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x18, 0x01a11130 }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MIC
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

