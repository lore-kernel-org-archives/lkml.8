Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B8BC433F7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 261C6207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860117;
	bh=2IakSLwb7F0uY7SEyp6CN2yis8j5UQFk0MW6DKvYm9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UVHhoK7RSJlIQtZI89+ObGbU71dHr7iZstv4zgFD7CRou2mZHRT+34bfL82N11h2H
	 sv6+ipRsVtUFtejYc4jtxmDM9nVW4l+/Mu04Bnfy8TuV/oP6sLxgiLE40hqee8z5Tu
	 EnxbRATq8wPqlDoS2VgMl/1on/dcBmUkdaZVlp18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbgG0OYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:24:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732195AbgG0OYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:24:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39CEA2177B;
        Mon, 27 Jul 2020 14:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859852;
        bh=2IakSLwb7F0uY7SEyp6CN2yis8j5UQFk0MW6DKvYm9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hpJdZvUl0FE5hTFOIzZu39hwirZRBIaYeeblhT7U7p8LfkSM8ZilGk/v6ow6rWUoJ
         240voXGQZw4N6kzSggkwgvdz1mB9q1Q72GtHr73vvIpKSsXDLDlvWMn06LiTZz9lW2
         DVmtaNz9ZBpjIdLxodcCzc4i6b6sMUv/6+Y+x64s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, PeiSen Hou <pshou@realtek.com.tw>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 131/179] ALSA: hda/realtek - fixup for yet another Intel reference board
Date:   Mon, 27 Jul 2020 16:05:06 +0200
Message-Id: <20200727134939.027740419@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: PeiSen Hou <pshou@realtek.com.tw>

[ Upstream commit 5734e509d5d515c187f642937ef2de1e58d7715d ]

Add headset_jack for the intel reference board support with
10ec:1230.

Signed-off-by: PeiSen Hou <pshou@realtek.com.tw>
Link: https://lore.kernel.org/r/20200716090134.9811-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 65a8ffef2aff4..27dd8945d6e6d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7546,6 +7546,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x10cf, 0x1629, "Lifebook U7x7", ALC255_FIXUP_LIFEBOOK_U7x7_HEADSET_MIC),
 	SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", ALC269_FIXUP_LIFEBOOK_EXTMIC),
 	SND_PCI_QUIRK(0x10ec, 0x10f2, "Intel Reference board", ALC700_FIXUP_INTEL_REFERENCE),
+	SND_PCI_QUIRK(0x10ec, 0x1230, "Intel Reference board", ALC225_FIXUP_HEADSET_JACK),
 	SND_PCI_QUIRK(0x10f7, 0x8338, "Panasonic CF-SZ6", ALC269_FIXUP_HEADSET_MODE),
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
-- 
2.25.1



