Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FBAC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8522076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587046862;
	bh=UqFZh/1eEoluZP1qvKMPPJGO87tS/2gzODxY+9ZVkYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qcUT2q6BHX9Oxb9pslA5kTMyAp0fzMI1khaXEJ2bl5/NC9c6saTQfusehRo1+TBlq
	 sAi57NWaaK8oCM9xXlFHgcXzrrLuUzxyKIDrDuKeVboQ+Q6zKOye0FpjTh1MPdMYya
	 Dl6XLtbkaS6y8pNdpXMhknOadG4X2oRW/gehI804=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390191AbgDPOVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:21:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409081AbgDPNy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:54:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82B5320732;
        Thu, 16 Apr 2020 13:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045298;
        bh=UqFZh/1eEoluZP1qvKMPPJGO87tS/2gzODxY+9ZVkYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mixw5EFX79Cit44w4n2Z1CafOBaFLV7YmSR22z8QD0pKlb8Sx1lkiGBkzo8BOUzx5
         zDRLnHMJpsLOHMPAmuYcIw12+sv/r/9Ch05vwAPflMAKmeMRYmoM8byC+iPJ7rPl40
         OiizfYUzkMSe71ZY7Xd7wlkamxRjEdr9Ra78FkTY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.6 077/254] ALSA: hda/realtek: Enable mute LED on an HP system
Date:   Thu, 16 Apr 2020 15:22:46 +0200
Message-Id: <20200416131335.532388407@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit f5a88b0accc24c4a9021247d7a3124f90aa4c586 upstream.

The system in question uses ALC285, and it uses GPIO 0x04 to control its
mute LED.

The mic mute LED can be controlled by GPIO 0x01, however the system uses
DMIC so we should use that to control mic mute LED.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200327044626.29582-1-kai.heng.feng@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4008,6 +4008,12 @@ static void alc269_fixup_hp_gpio_led(str
 	alc_fixup_hp_gpio_led(codec, action, 0x08, 0x10);
 }
 
+static void alc285_fixup_hp_gpio_led(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	alc_fixup_hp_gpio_led(codec, action, 0x04, 0x00);
+}
+
 static void alc286_fixup_hp_gpio_led(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
@@ -5923,6 +5929,7 @@ enum {
 	ALC294_FIXUP_ASUS_DUAL_SPK,
 	ALC285_FIXUP_THINKPAD_HEADSET_JACK,
 	ALC294_FIXUP_ASUS_HPE,
+	ALC285_FIXUP_HP_GPIO_LED,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -7061,6 +7068,10 @@ static const struct hda_fixup alc269_fix
 		.chained = true,
 		.chain_id = ALC294_FIXUP_ASUS_HEADSET_MIC
 	},
+	[ALC285_FIXUP_HP_GPIO_LED] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_hp_gpio_led,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7208,6 +7219,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x103c, 0x83b9, "HP Spectre x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8497, "HP Envy x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
+	SND_PCI_QUIRK(0x103c, 0x8736, "HP", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),


