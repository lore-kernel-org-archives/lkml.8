Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAA5C35DF8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E4E222C2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="QTiTs3ao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgBYHa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 02:30:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33492 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbgBYHaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 02:30:25 -0500
Received: by mail-pf1-f195.google.com with SMTP id n7so6726835pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 23:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E829NU76QDF3cP/NsyErXF/fNnm7bAZiWaUr7fUocZ8=;
        b=QTiTs3aoEEiRq3DT0rUxnmFQocgrrfwNw1ly2CM7jAB6Z81aRWuSBtnCqw+Tt8oY1Q
         +auweEAILHLb6ZWPUWiZErDojNz6vcZ+I5Ip45q5dna8/Of5jGzziSqbFtPZkVndOrTm
         DKOSyjrdGGIIGeT/HH4KFmvW8ZtjX1PFCzR1uRi4pdDc4XFut+Jtl8thk/LSyn6dWcVH
         yA/0wjuouCUKi33ywydJR9L3xdPEQMq+lr6ZzmW8TjrM8LJ3cR00TULafnOY27yZeXLd
         rhGArS8UOg+Shp7IcB3T8Zx1uEztrfbJxKDjAWkRJ5lFq6S0FwPQxcQURr6pF9GLAdIV
         My/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E829NU76QDF3cP/NsyErXF/fNnm7bAZiWaUr7fUocZ8=;
        b=UJLeo5kmqqUrOx3MVP3ndc0gcTbaoBcR0li3y+zhV3PuriJVcKZJlttCJ6zJX6IelT
         XLueeVbbvI09eNwfWwxwC+UqOP1fI30ygF2aeePhT6dYmDNn86vi5HclaOcW/jejz4Ey
         mKplyJpzApLhaQ4MN3iXNRCMJU86C4+7Nbg0ic1+XJ4UUDZ/LJxvk12nGrInnKHhN1oe
         GQot80YUi5YB9W88A0c3t4DcHjbKmb06EOyc2TzrCk49jYooOI0evguyx7ZYfslgvrMS
         v1zzbKJbt+5HyP3klhuA0PMe970T0uvP1FiAvYkQCi2rNJxJqdMIdnlW9BIUgxt6Gatj
         qOPg==
X-Gm-Message-State: APjAAAVflPrfxt7/09BSpP59vnKVWJqY5r2JCxl9gi1Q3fTarkLyM8uj
        q2lBHt/FPnReqBNFaAfy5kNFTg==
X-Google-Smtp-Source: APXvYqzXPXVTEmI4sSnMC//AihHYA7770hDbD0z2yO5l63QvCrokdmPOorLFdPHTa0VvcKMZjmxfeg==
X-Received: by 2002:aa7:8e88:: with SMTP id a8mr33713851pfr.254.1582615825187;
        Mon, 24 Feb 2020 23:30:25 -0800 (PST)
Received: from starnight.endlessm-sf.com (ec2-34-209-191-27.us-west-2.compute.amazonaws.com. [34.209.191.27])
        by smtp.googlemail.com with ESMTPSA id s13sm1796960pjp.1.2020.02.24.23.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 23:30:24 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] ALSA: hda/realtek - Enable the headset of ASUS B9450FA with ALC294
Date:   Tue, 25 Feb 2020 15:29:21 +0800
Message-Id: <20200225072920.109199-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A headset on the laptop like ASUS B9450FA does not work, until quirk
ALC294_FIXUP_ASUS_HPE is applied.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Singed-off-by: Kailang Yang <kailang@realtek.com>
---
 sound/pci/hda/patch_realtek.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 477589e7ec1d..a47f6404aea9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5920,7 +5920,7 @@ enum {
 	ALC289_FIXUP_DUAL_SPK,
 	ALC294_FIXUP_SPK2_TO_DAC1,
 	ALC294_FIXUP_ASUS_DUAL_SPK,
-
+	ALC294_FIXUP_ASUS_HPE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -7040,7 +7040,17 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC294_FIXUP_SPK2_TO_DAC1
 	},
-
+	[ALC294_FIXUP_ASUS_HPE] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			/* Set EAPD high */
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x0f },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x7774 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC294_FIXUP_ASUS_HEADSET_MIC
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7204,6 +7214,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_DUAL_SPK),
 	SND_PCI_QUIRK(0x1043, 0x18b1, "Asus MJ401TA", ALC256_FIXUP_ASUS_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1043, 0x19ce, "ASUS B9450FA", ALC294_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
 	SND_PCI_QUIRK(0x1043, 0x1a30, "ASUS X705UD", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1b13, "Asus U41SV", ALC269_FIXUP_INV_DMIC),
-- 
2.25.1

