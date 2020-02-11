Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140A6C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 05:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28BC20708
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 05:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uGIPMgze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgBKF5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 00:57:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45159 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgBKF5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 00:57:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so4913436pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 21:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RtcACHY1GteKSUYIoiEzAwSY/JFxUKopsQ/nQ/UelxI=;
        b=uGIPMgze54HdLetRttejcgVMdUMlVlZkhEspiWqqqdkOH3lzSVGcJCK3qlMJp4oEoO
         +AQibt5qwbOn4CDt02cT4IXmHlE5WOz2XRHjXT/EyeOcfZuPiPlvmR+lw6FixpphVsmq
         yuXuVtzmNrDo8qXM/xuVARxvnjcJcQNYS77qsMazdQG3e10aiXkJ6ZHgKyxQbTVrRb0n
         ZDzXRMxWhE+WmLA2DjSVqB2DVkkOCzX2frTVlAHsYRVY3rKNCJTU9cMpOfuyW/4EnD9V
         OKpguDR32powtQmqXuS6zW4EEfT1FRxc14JeR3LcCkLZKu3AsSWGUrKOBxmHOwi38KcJ
         zm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RtcACHY1GteKSUYIoiEzAwSY/JFxUKopsQ/nQ/UelxI=;
        b=NsxOpSlGAPsOnVdmN8PrWNUVPrV6X56R7v26ktvMqOyoUZKACBETfhjyCiqOVO12JQ
         QqwzLbXKtamS11pT6rWgAyaQKV4Hk1znbwAY/tZu8HP25bypevUoTZBIXzwNoV7yqeNh
         Nm5GZzSiqqjhANB7tXM0m1SOcXbz2GqLv+2Upvk3QoEDQpo8LbbsYEWdXS8jbykBS6NB
         HkjEt+YBhqdCqYyTbl6TciTpoK/XLG9ZHKdSbdPvVLe5O8RnsYE0HHxx3aAcagh+8g6y
         qq63WdrP/eEPn+hYK6++vawIDyeW8SCeXhx1xJ5Yor+H+ANGdRrhUqsQmmtn0F879YTY
         nLgg==
X-Gm-Message-State: APjAAAXA6p7p1huILnS5fkaRer7adltCrQI8yWWGbaaYB/YZtkiB5nwP
        DrDI+VM98KqAVzBKnGd7bJw=
X-Google-Smtp-Source: APXvYqy7gDZtDUPcbSurzNtWPfxbcVBQ4CDX+IzdlO8ruSHzRLLXhc2oxOV/u5IcG5LFaVannNLK7A==
X-Received: by 2002:a63:6607:: with SMTP id a7mr5450503pgc.310.1581400669771;
        Mon, 10 Feb 2020 21:57:49 -0800 (PST)
Received: from f3.synalogic.ca (ag119225.dynamic.ppp.asahi-net.or.jp. [157.107.119.225])
        by smtp.gmail.com with ESMTPSA id x6sm2355617pfi.83.2020.02.10.21.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 21:57:49 -0800 (PST)
From:   Benjamin Poirier <benjamin.poirier@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ALSA: hda/realtek - Fix Lenovo Thinkpad X1 Carbon 7th quirk value
Date:   Tue, 11 Feb 2020 14:56:51 +0900
Message-Id: <20200211055651.4405-2-benjamin.poirier@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211055651.4405-1-benjamin.poirier@gmail.com>
References: <20200211055651.4405-1-benjamin.poirier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a result of commit d2cd795c4ece ("ALSA: hda - fixup for the bass speaker
on Lenovo Carbon X1 7th gen"), the maximum sound output level on my
machine, an X1 Carbon, was reduced to ~60% of its previous level.

This laptop model has two sets of stereo speakers: Front and Bass (aka Rear
in some contexts).
Before commit d2cd795c4ece, volume control was commonly ineffective (using
the Master slider in alsa or pulseaudio apparently had little effect or
alternated between mute or max with nothing in between - more details
below)
commit d2cd795c4ece added quirk ALC285_FIXUP_SPEAKER2_TO_DAC1 which
resulted in assigning both sets of speakers to the same DAC, bringing
the two sets of speakers under one effective volume control but also
lowering the max output volume noticeably.

Fix this by changing the quirk so that each set of speakers can be
controlled individually and the max output volume is restored to what it
was before commit d2cd795c4ece.

Since there is no documentation about the audio codec, here is some
detailed information about the result of applying different quirks.
DAC connection (which is what's affected by the quirk) is reported as found
in /proc/asound/card0/codec#0, Node 0x17.
pavucontrol controls are reported with the device configured with the
"Analog Surround 4.0 Output" profile.

no quirk
	Loud max output volume
	DAC connection
	  Connection: 3
	     0x02 0x03 0x06*
	Controls in alsamixer
		Master controls front speakers only.
		Speaker controls front speakers only.
		Bass Speaker is a toggle that mutes everything.
		PCM controls all speakers.
		There is no "Front" mixer.
	Controls in pavucontrol
		"Front Left"/"Front Right" sliders work as expected.
		"Rear Left"/"Rear Right" sliders seem to operate in a
		non-linear fashion such that most values above 0% result in
		max volume output.
		-> Because the bass speakers (Rear) are more powerful, the
		net effect is that when the channels are linked into a
		single slider, it seems like it has just two modes: mute or
		max.
ALC285_FIXUP_SPEAKER2_TO_DAC1
	Weak (~60%) max output volume
	DAC connection
	  Connection: 3
	     0x02* 0x03 0x06
	  In-driver Connection: 1
	     0x02
	Controls in alsamixer
		Master controls all four speakers.
		Speaker controls all four speakers.
		Bass Speaker is a toggle that mutes everything.
		PCM controls all four speakers.
		There is no "Front" mixer.
	Controls in pavucontrol
		"Front Left"/"Front Right" sliders have no effect.
		"Rear Left"/"Rear Right" sliders control both front and
		bass speakers.
		-> Volume control is effective but it's not possible to
		control front and bass speakers individually.
ALC295_FIXUP_DISABLE_DAC3
	Loud max output volume
	DAC connection
	  Connection: 3
	     0x02 0x03* 0x06
	  In-driver Connection: 2
	     0x02 0x03
	Controls in alsamixer
		Master controls all speakers.
		Speaker is a toggle that mutes everything.
		Bass Speaker controls bass speakers only.
		PCM controls all speakers.
		Front controls front speakers only.
	Controls in pavucontrol
		"Front Left"/"Front Right" sliders control front speakers
		only.
		"Rear Left"/"Rear Right" sliders control bass speakers
		only.
		-> Volume control is effective and it's possible to control
		each of the four speakers individually.

In summary, Node 0x17 DAC connection 0x3 offers the loudest max volume and
the most detailed mixer controls. That connection is obtained with quirk
ALC295_FIXUP_DISABLE_DAC3. Therefore, change the ThinkPad X1 Carbon 7th to
use ALC295_FIXUP_DISABLE_DAC3.

Fixes: d2cd795c4ece ("ALSA: hda - fixup for the bass speaker on Lenovo Carbon X1 7th gen")
Link: https://lore.kernel.org/alsa-devel/20200210025249.GA2700@f3/
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Kailang Yang <kailang@realtek.com>
Signed-off-by: Benjamin Poirier <benjamin.poirier@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 05d44df2008e..3171da10123e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7268,7 +7268,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x224c, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x224d, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x225d, "Thinkpad T480", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-	SND_PCI_QUIRK(0x17aa, 0x2292, "Thinkpad X1 Carbon 7th", ALC285_FIXUP_SPEAKER2_TO_DAC1),
+	SND_PCI_QUIRK(0x17aa, 0x2292, "Thinkpad X1 Carbon 7th", ALC295_FIXUP_DISABLE_DAC3),
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x310c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
-- 
2.25.0

