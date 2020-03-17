Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30290C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0444B205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="kqYfXL1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgCQIaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 04:30:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40494 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgCQIaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 04:30:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id t24so11314326pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 01:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gZuIwtZ+2hf7pTqEUWqw1JVhU89MyFlE8Sqn8Fq++lU=;
        b=kqYfXL1Ip04HSNa8KkPDkDcYn9wmErZYNjZYbNvEgOyOvNcKeM6PnUSsd63PcWQ4cE
         ffmMU1uEnPka286OXda1tk8F4bTmOJTGkxiSkayEbrknb1/F1jxXabXASpWuC1zXLvHk
         lUiAfATamDJucgdSejqSv2xOcEeuROXpdQBR5g2y6Sx/xsMOoWMvt7sXCWmgFI0PncXD
         T/XHlwOeZHYjHem5INobJ54nKD/SllrBAwAJGQTzEqz7z7SG61QQA0Yd7Mux51uw5lGO
         6YS4qXeFVzCFAxBO89ViyIi9uXKzUbXAf3YBI4lnzPkA/2TzGG0H9IUq6Zt1Xr6XyoIB
         TdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gZuIwtZ+2hf7pTqEUWqw1JVhU89MyFlE8Sqn8Fq++lU=;
        b=JQgKOJbnLj/K68EJi7ACHCbf0DiDaROT9QujE+1QbVmYPTp9zPabhoCpNTs93lZREu
         sQGEBgrAZAPLZWnCs7//AMZ9WULn5jwwVjK8kZtz8kTCrQklS0iYbtnge4bgP5EnBAdV
         9bNE6UmmJ4ngDqlWedP7EXbsfGpOPQbvfrtNq2AFFjmDv28HnXzLJYhqWcSwZnihsYM/
         FCRePnkV161L55UbluVV5HWEU/7Z36ZMSVzQJHi643I2oPUuXeZ3uwz++lOqxafzu2Cm
         4jn8bDwGZTCqUcyt/JRA/xZdi78L8aivV7gf88rgFwHHRbvrrokOZZ8MTczxRcqfbyal
         S3fg==
X-Gm-Message-State: ANhLgQ39DJPGErvIolVj175o9oEj7kKZCjZjXGDGtOaYJHQ/2kiX0Lli
        zP9haBG5jwTa2lx4DBOSkkOyzQ==
X-Google-Smtp-Source: ADFU+vuuKNJsNdUjh+PEtFFc4KNbme2kHZkfB9E0YtDtV8C5w+Ed+TLaDuX5RWPZPS0rV5JHuMXVIg==
X-Received: by 2002:a63:e053:: with SMTP id n19mr4100628pgj.64.1584433799881;
        Tue, 17 Mar 2020 01:29:59 -0700 (PDT)
Received: from starnight.local ([150.116.255.181])
        by smtp.googlemail.com with ESMTPSA id m68sm21095679pjb.0.2020.03.17.01.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 01:29:59 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH 1/2] ALSA: hda/realtek - Enable headset mic of Acer X2660G with ALC662
Date:   Tue, 17 Mar 2020 16:28:07 +0800
Message-Id: <20200317082806.73194-2-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317082806.73194-1-jian-hong@endlessm.com>
References: <20200317082806.73194-1-jian-hong@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Acer desktop X2660G with ALC662 can't detect the headset microphone
until ALC662_FIXUP_ACER_X2660G_HEADSET_MODE quirk applied.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0ac06ff1a17c..bb29c25f4567 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8610,6 +8610,7 @@ enum {
 	ALC669_FIXUP_ACER_ASPIRE_ETHOS,
 	ALC669_FIXUP_ACER_ASPIRE_ETHOS_HEADSET,
 	ALC671_FIXUP_HP_HEADSET_MIC2,
+	ALC662_FIXUP_ACER_X2660G_HEADSET_MODE,
 };
 
 static const struct hda_fixup alc662_fixups[] = {
@@ -8955,6 +8956,15 @@ static const struct hda_fixup alc662_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc671_fixup_hp_headset_mic2,
 	},
+	[ALC662_FIXUP_ACER_X2660G_HEADSET_MODE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1a, 0x02a1113c }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC662_FIXUP_USI_FUNC
+	},
 };
 
 static const struct snd_pci_quirk alc662_fixup_tbl[] = {
@@ -8966,6 +8976,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x0349, "eMachines eM250", ALC662_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x034a, "Gateway LT27", ALC662_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x038b, "Acer Aspire 8943G", ALC662_FIXUP_ASPIRE),
+	SND_PCI_QUIRK(0x1025, 0x124e, "Acer 2660G", ALC662_FIXUP_ACER_X2660G_HEADSET_MODE),
 	SND_PCI_QUIRK(0x1028, 0x05d8, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05db, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05fe, "Dell XPS 15", ALC668_FIXUP_DELL_XPS13),
-- 
2.25.1

