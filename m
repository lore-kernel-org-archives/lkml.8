Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A101AC433EC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BEBC20675
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="NvMGc8wK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgGFHUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 03:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbgGFHUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 03:20:12 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D62C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 00:20:12 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x9so1324969plr.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 00:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZMrBCO2HX9SmHfGaTdHWGGANRpDUMASbUUrpS3Y30hY=;
        b=NvMGc8wKt9H4eVx9J5luQg51fZ8GewllQNYQDmxsgeH32r/45gfk7BhVwBserNn0LX
         ooMJLGG6IHCNW9ocWirNTotEpAHRGxAI72whR2vr+UqsyzG5yJYvWbLoJ3naFLb6LEtq
         DIzu8zmkyDBcD2q2OAJAwapFsFIcDt+xBEV48pT0T5JMaKn3iHpFKH2iwTaBbiFOp8Bs
         kikGGcnMNMKnNNyWtcXiciCRUv1C+AS1CMA4aTAQnyNxFfzNBqHEN9IBtu7ymXAF+xiE
         UbM1Je/GkYAtqVF1cfbDRAxUMj7gKFcuY+eSDTT4anJIJ6yrj38b/HZnt1Xhv40PBwWb
         B9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZMrBCO2HX9SmHfGaTdHWGGANRpDUMASbUUrpS3Y30hY=;
        b=tv0qAvE9kXy/qb63QbElNHxn1o7vq4NecS88usjd0NrjimzGulR85OYbHFZ6UVog2M
         JqpYA+p6NC5FcRxdx7w9I5OtfoVpy6zhNvBHnRMqKIvIPqtC5Bd65KOQ0WtS/nnIWhAD
         yu1axAVFsJtaSiVYlnYVbCvyq0Dh02lSp9WSMINZfhX4pYiVGPOq11/8xxO0BDD0Zio5
         JFsIiDkyKt2ZjRKK57mj+8Hf9AbuO2v7Y8OQVTswo5ie+2bOeGfuwC0EK2Y4yUvHghjZ
         D4x26EYN/V7xzQbPInyj22B6I1dVVv4R+j+xEwgQioe+Bsah2IbKMxJlavrPXZJA/RYY
         Octg==
X-Gm-Message-State: AOAM533Qjhyjye69zq+IEur8SRMBTXtEzePxPrW+xc9ErP7Z2fqCBBBA
        38cC42VLdYa5ggQtP2q2IFp0dQ==
X-Google-Smtp-Source: ABdhPJw+/4Nv1TzCrD3P91WHTQvkYg0j+ZGrFxxPtwmEmoIKGoIdqkWElWszB0kHPXghpPovSLs7eg==
X-Received: by 2002:a17:902:c142:: with SMTP id 2mr41559017plj.222.1594020011818;
        Mon, 06 Jul 2020 00:20:11 -0700 (PDT)
Received: from starnight.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id f18sm17825210pgv.84.2020.07.06.00.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 00:20:11 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH v3 2/3] ALSA: hda/realtek: Enable headset mic of Acer C20-820 with ALC269VC
Date:   Mon,  6 Jul 2020 15:18:27 +0800
Message-Id: <20200706071826.39726-2-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <aa62a43d4f1f458fb11794c26d373528@realtek.com>
References: <aa62a43d4f1f458fb11794c26d373528@realtek.com>
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
v3: Change the chained ID to ALC269_FIXUP_HEADSET_MIC according to
    Realtek's suggestion

v2: Change the chained ID to ALC269_FIXUP_HEADSET_MODE according to
    Realtek's suggestion

 sound/pci/hda/patch_realtek.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 13c32655df44..be18b304e731 100644
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
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
+	[ALC269VC_FIXUP_ACER_HEADSET_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x18, 0x02a11030 }, /* use as headset mic */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MIC
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

