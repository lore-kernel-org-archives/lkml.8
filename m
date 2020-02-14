Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022BDC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20F8247C9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697554;
	bh=1iM4YE0k6wVlE4KaGD8aHEfcNJFfXxlyVDWaVfEOIqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nDmOvvtz1sfUnyH3Wozc22LeaytNyAjyP6GWIE6YqqijeXAV6m6fqgf26DZrJtiMf
	 b8ssbmeXhcL1k+VnKtpaPwKvUe/dnkyhwnTh8qoAlMfy9jKOX0afEskghJ0uNzQJYZ
	 QX/Wh46AP3C6vjMgDhUB3j3SxRcTA+d1cOHceocA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406246AbgBNQZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:25:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405288AbgBNQXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:23:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DFA324773;
        Fri, 14 Feb 2020 16:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697424;
        bh=1iM4YE0k6wVlE4KaGD8aHEfcNJFfXxlyVDWaVfEOIqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=boffenqQlBeUsNM/30/oAy5Aq9G9ZX1SbLSgja65McthHsvQxz7vljH5A+Qk+Nh3k
         Ji3Gdpp6crBPSGLkWn3I8e7ddgtRnHnUwZ2CmaQQyA49CdTPiGQs/6oLYqSA03Rg8x
         TgRzi5YvlR80zti38g+nHAykD3sBI2Ew0/5arous=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Peter=20Gro=C3=9Fe?= <pegro@friiks.de>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.9 113/141] ALSA: hda - Add docking station support for Lenovo Thinkpad T420s
Date:   Fri, 14 Feb 2020 11:20:53 -0500
Message-Id: <20200214162122.19794-113-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162122.19794-1-sashal@kernel.org>
References: <20200214162122.19794-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Große <pegro@friiks.de>

[ Upstream commit ef7d84caa5928b40b1c93a26dbe5a3f12737c6ab ]

Lenovo Thinkpad T420s uses the same codec as T420, so apply the
same quirk to enable audio output on a docking station.

Signed-off-by: Peter Große <pegro@friiks.de>
Link: https://lore.kernel.org/r/20200122180106.9351-1-pegro@friiks.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_conexant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 8557b94e462cb..1e99500dbb6c8 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -853,6 +853,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x17aa, 0x215f, "Lenovo T510", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x21ce, "Lenovo T420", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x21cf, "Lenovo T520", CXT_PINCFG_LENOVO_TP410),
+	SND_PCI_QUIRK(0x17aa, 0x21d2, "Lenovo T420s", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x21da, "Lenovo X220", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x21db, "Lenovo X220-tablet", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo IdeaPad Z560", CXT_FIXUP_MUTE_LED_EAPD),
-- 
2.20.1

