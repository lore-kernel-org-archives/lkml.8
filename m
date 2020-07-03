Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1011C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD9D1218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="ozgXHUcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgGCHGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCHGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:06:37 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37E8C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 00:06:37 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id p1so3039587pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 00:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bDYPa69LmDFvO+Xx7QJScqxnVDczXS9vz2dN5XkQbOo=;
        b=ozgXHUcVDIllwsoVOCKyOzFhQmAoGtBeS7xRsINeTILHLSCMAJRkJ1Els+cxXSztnt
         5F1xa1XAEYqYPvjFs3nTDNtanerAMu+YdgLLJZdhmh3gjNBdzutgYABmdAZHlJx1UqCQ
         3DDaIyW86f7LQkbChMriANqcer9oWb4I8BSfisxcdlAomR6IfoQ2OM/F1R1pDZ3RVVgB
         b4F7Lm7nFhwceAVhzSkS5v1KhtXfgmwVHLM+3t3pgx7pOGwfqGcHD6bsck4YsAB6dmMu
         jb8SiOve0laFHMCP+nYidOHbj5bNrLi6KtjsXLf1SaQNhSTitdy8CC6HeDkzA4R/Mvfq
         rM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bDYPa69LmDFvO+Xx7QJScqxnVDczXS9vz2dN5XkQbOo=;
        b=CZ0VSRd35DvJlIQnLeEL7m+3RVcoGNdbFCyCylGrlR2GBSXn/4XJ5JNh+l3l12X6HP
         lKkZtcb6oe10qSw/F4U+aLa2wOoOTLWsa1FHUD+ss4hrHMNBHjSD5Lkwl4oBgcIg2WYh
         Eu8FdmSnOajCdsIuheeDZpelb1wppm25J9x9eCyr8dwqbQQnn0e6n2o/CS4STOlxK+wD
         IUWjPO/3noZI2GeVKo8+A5ZTqGTC8jYZcMBfOpTd7cR7GW7FwqkMpbxi1Zf1Ku++O1YV
         39bBgvpkApOnliPJW9AjDi/Lz3SZ2o1FOaprg9XolrHH9VbttcBSXY5OkdxP1qr8BANd
         CHiQ==
X-Gm-Message-State: AOAM530Tm0CBhqpHrjzicyTN71IKAelPGEuCt/m2n8w567sYQorGFDzj
        LSUC7r+YsJHx4ED5wRAL9cuQ5g==
X-Google-Smtp-Source: ABdhPJx4PsoUIB7GYssnL1xk6WAhTBYOnCuss0AkP3hpv9zos6Fft/tE+LbljWFRS1+vvFazagSO9w==
X-Received: by 2002:a17:90b:30d0:: with SMTP id hi16mr38329964pjb.65.1593759997356;
        Fri, 03 Jul 2020 00:06:37 -0700 (PDT)
Received: from starnight.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id p1sm3529764pja.2.2020.07.03.00.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 00:06:36 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH 2/3] ALSA: hda/realtek: Enable headset mic of Acer C20-820 with ALC269VC
Date:   Fri,  3 Jul 2020 15:05:14 +0800
Message-Id: <20200703070512.174394-2-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200703070512.174394-1-jian-hong@endlessm.com>
References: <20200703070512.174394-1-jian-hong@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Acer Aspire C20-820 AIO's audio (1025:1065) with ALC269VC can't
detect the headset microphone until ALC269VC_FIXUP_ACER_HEADSET_MIC
quirk maps the NID 0x18 as the headset mic pin.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index dfb4bca07d3f..3255da8b3849 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6150,6 +6150,7 @@ enum {
 	ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET,
 	ALC295_FIXUP_ASUS_MIC_NO_PRESENCE,
 	ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS,
+	ALC269VC_FIXUP_ACER_HEADSET_MIC,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -7339,6 +7340,15 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MODE
 	},
+	[ALC269VC_FIXUP_ACER_HEADSET_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x18, 0x02a11030 }, /* use as headset mic */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7354,6 +7364,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x0775, "Acer Aspire E1-572", ALC271_FIXUP_HP_GATE_MIC_JACK_E1_572),
 	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP_ASPIRE_V5_PINS),
 	SND_PCI_QUIRK(0x1025, 0x102b, "Acer Aspire C24-860", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1025, 0x1065, "Acer Aspire C20-820", ALC269VC_FIXUP_ACER_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x106d, "Acer Cloudbook 14", ALC283_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x1025, 0x1099, "Acer Aspire E5-523G", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x110e, "Acer Aspire ES1-432", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
-- 
2.27.0

