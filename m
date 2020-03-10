Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F133DC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C681E20675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583847032;
	bh=oqpU7+lIdaD3CW6o9cAgOBK5CJusQU6TVMmNheEZeIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WQddjPW2NY0vstxidAPHwsUXzGx/f9kWK02BtahfFYUf+t0TOzshOqcyDezBqcxj4
	 8QG6UVr8C/egxiICW+PeK2cfVaGow/Lf/BzepaUiH7DL1HWNZTI8qYh7cbJSyJzJSX
	 jc+U+FkacfWgGn/k/kLrnS68bMS0PdhAxixXb70w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgCJNab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:30:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728628AbgCJMuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:50:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A26F2468F;
        Tue, 10 Mar 2020 12:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844631;
        bh=oqpU7+lIdaD3CW6o9cAgOBK5CJusQU6TVMmNheEZeIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i+FLIUf4wAULXQnZiuhXeHIwF8DV7kMtXgxYND9ZujTSjGXkUysCJqLb7zZswPjsr
         U13fFk6JmKW9rYL8bvoBJokMqLhDuVbLzLlrdHUVzIk/bcgh8r4WuE3ElRJNqwG6Rk
         n4H2ypMyNSBmp3ODEY6IoFCHgr+FBlZ6WsKSIeQ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 061/168] ALSA: hda/realtek - Add Headset Button supported for ThinkPad X1
Date:   Tue, 10 Mar 2020 13:38:27 +0100
Message-Id: <20200310123641.454001212@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

commit 76f7dec08fd64e9e3ad0810a1a8a60b0a846d348 upstream.

ThinkPad want to support Headset Button control.
This patch will enable it.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/7f0b7128f40f41f6b5582ff610adc33d@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5920,7 +5920,7 @@ enum {
 	ALC289_FIXUP_DUAL_SPK,
 	ALC294_FIXUP_SPK2_TO_DAC1,
 	ALC294_FIXUP_ASUS_DUAL_SPK,
-
+	ALC285_FIXUP_THINKPAD_HEADSET_JACK,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -7042,7 +7042,12 @@ static const struct hda_fixup alc269_fix
 		.chained = true,
 		.chain_id = ALC294_FIXUP_SPK2_TO_DAC1
 	},
-
+	[ALC285_FIXUP_THINKPAD_HEADSET_JACK] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_headset_jack,
+		.chained = true,
+		.chain_id = ALC285_FIXUP_SPEAKER2_TO_DAC1
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7278,8 +7283,8 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x17aa, 0x224c, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x224d, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x225d, "Thinkpad T480", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-	SND_PCI_QUIRK(0x17aa, 0x2292, "Thinkpad X1 Yoga 7th", ALC285_FIXUP_SPEAKER2_TO_DAC1),
-	SND_PCI_QUIRK(0x17aa, 0x2293, "Thinkpad X1 Carbon 7th", ALC285_FIXUP_SPEAKER2_TO_DAC1),
+	SND_PCI_QUIRK(0x17aa, 0x2292, "Thinkpad X1 Yoga 7th", ALC285_FIXUP_THINKPAD_HEADSET_JACK),
+	SND_PCI_QUIRK(0x17aa, 0x2293, "Thinkpad X1 Carbon 7th", ALC285_FIXUP_THINKPAD_HEADSET_JACK),
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x310c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),


