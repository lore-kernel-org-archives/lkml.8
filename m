Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A95C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D91221655
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598976797;
	bh=lPpN0ofvKrWwRILlZ6nzMtWdbUvEs5PBobyPX0wZu6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=foSVraWgsuQXXp92zplD8Hq1dBNs9StmVNhorZJVKduyqZqB7Y5ptEWfFFT+sNq+o
	 1Q5U05P35x77jGJa93XUnTqvbvJoqBYstJ99xw7+eTBXxW87Lrak3V+np6Ah1ZvIFz
	 Ps0Gr97HD8OvVckQD2itm6p2C/GapXOIF0uhnnxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgIAQNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731274AbgIAPg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:36:27 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B935E21534;
        Tue,  1 Sep 2020 15:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974587;
        bh=lPpN0ofvKrWwRILlZ6nzMtWdbUvEs5PBobyPX0wZu6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eej71XX1CDNh4TgR6i0x2Wnqv0JIhcJxJUFTjeiAYgNaxFv9rYhxItOJYIxTRtipK
         rDqT2mTkFUwwq9cgXpJZumIW+T8u9FLD4O1Mqozo/PeXEc7ENV/RDNN/3h8mNKMpLk
         6rgM1aygGfX8Ss++QdMFdyZ29AEL0WR7VmjmHUzs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 005/255] ALSA: hda/realtek: Fix pin default on Intel NUC 8 Rugged
Date:   Tue,  1 Sep 2020 17:07:41 +0200
Message-Id: <20200901151001.063285033@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit e2d2fded6bdf3f7bb40718a208140dba8b4ec574 ]

The jack on Intel NUC 8 Rugged rear panel doesn't work.

The spec [1] states that the jack supports both headphone and
microphone, so override a Pin Complex which has both Amp-In and Amp-Out
to make the jack work.

Node 0x1b fits the requirement, and user confirmed the jack now works
with new pin config.

[1] https://www.intel.com/content/dam/support/us/en/documents/mini-pcs/NUC8CCH_TechProdSpec.pdf
BugLink: https://bugs.launchpad.net/bugs/1875199

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Link: https://lore.kernel.org/r/20200807080514.15293-1-kai.heng.feng@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b10d005786d07..b767d8fce828e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6167,6 +6167,7 @@ enum {
 	ALC269_FIXUP_CZC_L101,
 	ALC269_FIXUP_LEMOTE_A1802,
 	ALC269_FIXUP_LEMOTE_A190X,
+	ALC256_FIXUP_INTEL_NUC8_RUGGED,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -7488,6 +7489,15 @@ static const struct hda_fixup alc269_fixups[] = {
 		},
 		.chain_id = ALC269_FIXUP_DMIC,
 	},
+	[ALC256_FIXUP_INTEL_NUC8_RUGGED] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1b, 0x01a1913c }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MODE
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7787,6 +7797,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x10ec, 0x118c, "Medion EE4254 MD62100", ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1c06, 0x2013, "Lemote A1802", ALC269_FIXUP_LEMOTE_A1802),
 	SND_PCI_QUIRK(0x1c06, 0x2015, "Lemote A190X", ALC269_FIXUP_LEMOTE_A190X),
+	SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),
 
 #if 0
 	/* Below is a quirk table taken from the old code.
-- 
2.25.1



