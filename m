Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F7EC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9E97208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099270;
	bh=NJbMw6Pbe7+GENnJqQLQX7O3iLztQDGPrtaFnqPW2d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i2MAmwQvWFRo5lMP46YNUsOdV6z4+8lun2XCR263FQArfqsR/1fze98dR2SglMhKs
	 i40DvecwghuMXL3n6bogSYh0x+laUym9nTeJ8fQfR+MOB/zXKWdKrnr7W3gVCpGFVp
	 S8gTVA4C/AiKHQAfm+vnOXLDQD0yc6ZSEdhM3o1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgD1SlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:41:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730834AbgD1SlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:41:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3E69208E0;
        Tue, 28 Apr 2020 18:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099266;
        bh=NJbMw6Pbe7+GENnJqQLQX7O3iLztQDGPrtaFnqPW2d4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0OM2fHpJ/T2oy37I1dpNCLsVjMYFOQ3VTB88ExSVoatIrf/W3mS94VvLvl7iMuc7I
         +1U1YsPZcTG5PtV100QZ9ZDK6ECRHqSWqN4MvuRjdI9XuvvG6UUDdEe3dbfhEBISzP
         ICB6SEWxzHGxU16QWallu18ey9RKyewvMHG3IHkU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Johnathan Smithinovic <johnathan.smithinovic@gmx.at>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 084/168] ALSA: hda: Remove ASUS ROG Zenith from the blacklist
Date:   Tue, 28 Apr 2020 20:24:18 +0200
Message-Id: <20200428182242.840957653@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit a8cf44f085ac12c0b5b8750ebb3b436c7f455419 ]

The commit 3c6fd1f07ed0 ("ALSA: hda: Add driver blacklist") added a
new blacklist for the devices that are known to have empty codecs, and
one of the entries was ASUS ROG Zenith II (PCI SSID 1043:874f).
However, it turned out that the very same PCI SSID is used for the
previous model that does have the valid HD-audio codecs and the change
broke the sound on it.

This patch reverts the corresponding entry as a temporary solution.
Although Zenith II and co will see get the empty HD-audio bus again,
it'd be merely resource wastes and won't affect the functionality,
so it's no end of the world.  We'll need to address this later,
e.g. by either switching to DMI string matching or using PCI ID &
SSID pairs.

Fixes: 3c6fd1f07ed0 ("ALSA: hda: Add driver blacklist")
Reported-by: Johnathan Smithinovic <johnathan.smithinovic@gmx.at>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200419071926.22683-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 72bbfeddea24a..dd77b9ffe5fd9 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2024,7 +2024,6 @@ static void pcm_mmap_prepare(struct snd_pcm_substream *substream,
  * should be ignored from the beginning.
  */
 static const struct snd_pci_quirk driver_blacklist[] = {
-	SND_PCI_QUIRK(0x1043, 0x874f, "ASUS ROG Zenith II / Strix", 0),
 	SND_PCI_QUIRK(0x1462, 0xcb59, "MSI TRX40 Creator", 0),
 	SND_PCI_QUIRK(0x1462, 0xcb60, "MSI TRX40", 0),
 	{}
-- 
2.20.1



