Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15EFC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C77B205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="uOPgc3UD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgCQIag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 04:30:36 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35189 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgCQIag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 04:30:36 -0400
Received: by mail-pj1-f68.google.com with SMTP id mq3so10182443pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 01:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vWKGYsWLR1STHAG1GKHscN8Y99AToSvTAe2k4bSTdaM=;
        b=uOPgc3UDOEq50RlmiXosUbNRevpArFt4gocrkZOsZbw1F9SqgsoQWExkZ1v3bEvtnD
         lz7cHVpyyV9a7y6BJJ4oY4tIyPVdIlmUmHUAIjf+grInerwi7M9EEyx1y/0ZcJS5OO6L
         GNdnR+PHcvO+0wU7vEpiWrIGFxKF+wQl7H2V289TxRv1dtL1esuiEf7dEVtoeHr61HwJ
         YQrJvMYIMgM/89801c8Tk3HuW6JZv5t7nQVtPwIpQej3NlwBbh0P5tY6/JGZhtIRqKdW
         ixUez/uUt8rVrFxnnz95bOjIJ7cMsYQNwA8nvsY9wh/dA9TP65rcHCEXaJbJUhL3d7Sv
         9EZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vWKGYsWLR1STHAG1GKHscN8Y99AToSvTAe2k4bSTdaM=;
        b=QsRoRIhsQGEz9bidPhOfXTGiZePd4UnQ4KVWl9+0j87QTx+t8nD4+8jRzV1siep6uU
         hleqto9NfUJ0NYZVw3/P8d705oFL8dt9ZGbTsmyCMmuOdkfnzDFFuGLgnVrwhPaEsgaw
         2iB/UIPfXRT/pd8yBXslmxHMh2RvduU5NDQnj6K+73r5Vx4Dzt8atx0GstlGE0/qNf13
         MUQdoeCEmBZiFErchzj/cCvuYczBlFIgzHjW6XWrOhwnLtKaLEPZ6l3IUkfrnJ1Z50CA
         ijn0WGilnWdkblKt+AZdCLI/Sz4bvB0akeaPy735kVS6Fg0mAZiRCMux/r0eX6Ewdt6m
         vWTQ==
X-Gm-Message-State: ANhLgQ2Y3d8OudfQ5Uie02LCW6jPHA3X4gZdYMVdsu3vf8J+WENYXb3/
        ZhiAhURBZJrIKc34Rm8PocukTg==
X-Google-Smtp-Source: ADFU+vsFCy4Hl8cA7bTKABqclIVa6ikykCl2RTiTBe19VlK4hbeZjmH/loNpce/kyvIRBQObMNokgQ==
X-Received: by 2002:a17:90a:d997:: with SMTP id d23mr3896918pjv.187.1584433834564;
        Tue, 17 Mar 2020 01:30:34 -0700 (PDT)
Received: from starnight.local ([150.116.255.181])
        by smtp.googlemail.com with ESMTPSA id m68sm21095679pjb.0.2020.03.17.01.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 01:30:34 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH 2/2] ALSA: hda/realtek - Enable the headset of Acer N50-600 with ALC662
Date:   Tue, 17 Mar 2020 16:28:09 +0800
Message-Id: <20200317082806.73194-3-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317082806.73194-1-jian-hong@endlessm.com>
References: <20200317082806.73194-1-jian-hong@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A headset on the desktop like Acer N50-600 does not work, until quirk
ALC662_FIXUP_ACER_NITRO_HEADSET_MODE is applied.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index bb29c25f4567..0fa79eaa0b0b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8611,6 +8611,7 @@ enum {
 	ALC669_FIXUP_ACER_ASPIRE_ETHOS_HEADSET,
 	ALC671_FIXUP_HP_HEADSET_MIC2,
 	ALC662_FIXUP_ACER_X2660G_HEADSET_MODE,
+	ALC662_FIXUP_ACER_NITRO_HEADSET_MODE,
 };
 
 static const struct hda_fixup alc662_fixups[] = {
@@ -8965,6 +8966,16 @@ static const struct hda_fixup alc662_fixups[] = {
 		.chained = true,
 		.chain_id = ALC662_FIXUP_USI_FUNC
 	},
+	[ALC662_FIXUP_ACER_NITRO_HEADSET_MODE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1a, 0x01a11140 }, /* use as headset mic, without its own jack detect */
+			{ 0x1b, 0x0221144f },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC662_FIXUP_USI_FUNC
+	},
 };
 
 static const struct snd_pci_quirk alc662_fixup_tbl[] = {
@@ -8976,6 +8987,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x0349, "eMachines eM250", ALC662_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x034a, "Gateway LT27", ALC662_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x038b, "Acer Aspire 8943G", ALC662_FIXUP_ASPIRE),
+	SND_PCI_QUIRK(0x1025, 0x123c, "Acer Nitro N50-600", ALC662_FIXUP_ACER_NITRO_HEADSET_MODE),
 	SND_PCI_QUIRK(0x1025, 0x124e, "Acer 2660G", ALC662_FIXUP_ACER_X2660G_HEADSET_MODE),
 	SND_PCI_QUIRK(0x1028, 0x05d8, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05db, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
-- 
2.25.1

