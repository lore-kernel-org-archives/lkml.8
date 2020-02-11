Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51AEC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 05:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9EC20708
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 05:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvZxgNzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgBKF5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 00:57:30 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47057 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgBKF53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 00:57:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id k29so4913214pfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 21:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kjJUuCHQpi9LW6K3SCFPHipBrAr50LwcH0CdlL5eTMs=;
        b=gvZxgNzBgl0TJLLOKiE2TTF3Pqx0vKD/tvCvkLUzP6Om61XXLI7C0Qtt/rFQyK5dB7
         3081QHioDn8bO1jrkqq6QgBIAhFiA3iKHTFllBxbdjVXK9AmD6iK5/zaJwYyGerB3tsb
         i9HejBAl/Y46aLKXfQVF0q/+B9l3Emf8TkFcTwy2Y9zKgQOZAf4+bNbASentgv46zlAB
         FAXINDmBSg2RS+R4+YZrVyYvWQCSfm7hbo3nczDBuHvaBrrFfqyPpfA81uNMJ4m2cGDI
         IzoFbN+WC5Gnr22i/Zaho7uMJYu2Vu+QNZXW1s7DtpvQuoNlgUON9cKcRc9plXUCIs7d
         39mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kjJUuCHQpi9LW6K3SCFPHipBrAr50LwcH0CdlL5eTMs=;
        b=I6/K20PtG+2/okjcPQ/8vTxzyo8ky40M+8FbrLaFXkp8Fuy5Wu7EC8Sh1sNtsEBNfp
         XdCS7+BQ34HOUHtmUbEH9gOz2g0mdkdeXRuqvamSbNNcTX5l8rJQoEaIO64WngStigzG
         jdqt3kcpACpUUzdm0BLfO/+CcwluYZv8ZP4t2gnFdkVqKOu/u6YrVVf58zdecJAxbmFt
         PHAzo2dQwPt+7guOFCGWn/634nxabKqHzQXXUsaddQK2WH0lgl2wsFWRcJBilIh7Odzb
         lxTXfQdiRKvlWhNvyvBp+sgtsauO8dfDK6YV3YPPnKWBmo2xoWMSXubqB9GkpGkeoxbJ
         rLEQ==
X-Gm-Message-State: APjAAAXt9xyqIXXPpFcZ80Nub241SUydWgTsjsKsFGuT6CaL2JXFeo34
        7Sbh5jdwObS6r5EYlXq35wo=
X-Google-Smtp-Source: APXvYqzOBM4eqdyXiL3AzHLtbF778Ggsf2iOPk8M3cfPyFjBwDrfq3tLZnzRT7QmuN3of3XJvP8++Q==
X-Received: by 2002:a63:cc4c:: with SMTP id q12mr5144257pgi.443.1581400648891;
        Mon, 10 Feb 2020 21:57:28 -0800 (PST)
Received: from f3.synalogic.ca (ag119225.dynamic.ppp.asahi-net.or.jp. [157.107.119.225])
        by smtp.gmail.com with ESMTPSA id x6sm2355617pfi.83.2020.02.10.21.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 21:57:28 -0800 (PST)
From:   Benjamin Poirier <benjamin.poirier@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ALSA: hda/realtek - Fix Lenovo Thinkpad X1 Carbon 7th quirk subdevice id
Date:   Tue, 11 Feb 2020 14:56:50 +0900
Message-Id: <20200211055651.4405-1-benjamin.poirier@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixes the pci subsystem device ids for the "Thinkpad X1 Carbon 7th" and
"Thinkpad X1 Yoga 7th" quirks.

My machine reports the following:
dmidecode -t system
        Manufacturer: LENOVO
        Product Name: 20QDCTO1WW
        Version: ThinkPad X1 Carbon 7th

lspci -s 1f.3 -vnn
00:1f.3 Audio device [0403]: Intel Corporation Cannon Point-LP High Definition Audio Controller [8086:9dc8] (rev 11) (prog-if 80)
        Subsystem: Lenovo Cannon Point-LP High Definition Audio Controller [17aa:2292]

/proc/asound/card0/codec#0
	Subsystem Id: 0x17aa2293

Notice the different subsystem device ids between pci info and codec info.

commit d2cd795c4ece ("ALSA: hda - fixup for the bass speaker on Lenovo
Carbon X1 7th gen") added a quirk meant for the X1 Carbon but used device
id 0x2293. Note that this does not match the PCI SSID but it matches the
codec SSID.
commit 54a6a7dc107d ("ALSA: hda/realtek - Add quirk for the bass speaker on
Lenovo Yoga X1 7th gen") added a quirk meant for the X1 Yoga but used
subdevice id 0x2292, the PCI SSID used on the X1 Carbon.

Given that in snd_hdac_device_init() quirks are first matched by PCI SSID
and then, if there is no match, by codec SSID, the net result is that the
quirk labelled "Thinkpad X1 Yoga 7th" now gets applied on the X1 Carbon.
Example from my machine (an X1 Carbon, not Yoga):
[   15.817637] snd_hda_codec_realtek hdaudioC0D0: ALC285: picked fixup Thinkpad X1 Yoga 7th (PCI SSID)

Therefore, fix the subdevice id for the "ThinkPad X1 Carbon 7th" quirk.

Note that looking through the lspci outputs collected at
https://github.com/linuxhw/LsPCI/tree/master/Notebook/Lenovo/ThinkPad
all X1 Carbon there have an Audio device with PCI SSID 0x2292, which
matches with the output from my machine.

This leaves the question of what to do with the quirk labelled "Thinkpad X1
Yoga 7th".

From email discussions, it seems that the author of commit 54a6a7dc107d
("ALSA: hda/realtek - Add quirk for the bass speaker on Lenovo Yoga X1 7th
gen") did not have a device to test the changes. I don't have an X1 Yoga
either and I did not find a sample lspci listing for it online. Therefore,
the best course of action seems to be to remove that quirk. In the best
case, the quirk for the X1 Carbon will match the X1 Yoga (via PCI SSID or
codec SSID). In the worst case, it will not and someone who actually has
such a machine should come forth with concrete data about subsystem ids and
needed quirks.

Fixes: d2cd795c4ece ("ALSA: hda - fixup for the bass speaker on Lenovo Carbon X1 7th gen")
Fixes: 54a6a7dc107d ("ALSA: hda/realtek - Add quirk for the bass speaker on Lenovo Yoga X1 7th gen")
Link: https://lore.kernel.org/alsa-devel/20200210025249.GA2700@f3/
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Kailang Yang <kailang@realtek.com>
Signed-off-by: Benjamin Poirier <benjamin.poirier@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4770fb3f51fb..05d44df2008e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7268,8 +7268,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x224c, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x224d, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x225d, "Thinkpad T480", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-	SND_PCI_QUIRK(0x17aa, 0x2292, "Thinkpad X1 Yoga 7th", ALC285_FIXUP_SPEAKER2_TO_DAC1),
-	SND_PCI_QUIRK(0x17aa, 0x2293, "Thinkpad X1 Carbon 7th", ALC285_FIXUP_SPEAKER2_TO_DAC1),
+	SND_PCI_QUIRK(0x17aa, 0x2292, "Thinkpad X1 Carbon 7th", ALC285_FIXUP_SPEAKER2_TO_DAC1),
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x310c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
-- 
2.25.0

