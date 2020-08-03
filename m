Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA88C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F56207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457618;
	bh=5z5Q8QBzafP67PGyOz2etWaMlFZANqgyI5uCWFQH8cU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xv+LIs5OOw5GzTWG+GbeSgSqyAH3POHsnjx02wx4tcFuAnJhf4l1MT4FVfiZWMzqQ
	 tidvXL/le/syhb7+jG/bvlNvRGzaFToiM67aZcjxbFJs9bo5JlefiRC3gNMLMC1qUe
	 dOHebsjBThVsNhrgPBimkqBlotR07Kn6OL0y/iho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgHCM06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbgHCM0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:26:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BEA7207FC;
        Mon,  3 Aug 2020 12:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457611;
        bh=5z5Q8QBzafP67PGyOz2etWaMlFZANqgyI5uCWFQH8cU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lazsnnais7CFN0W+0q6oHRTUnTKq6o/4tDxrdjiJ142O9jVGjhk2HbHvOjHBDzsnN
         FXURMQueUDRwy3jC2s2IdtgIDMz01BXUf5i8HDiLThzvMvSbnDeNbw9p82SOvHogih
         k/I0YFrnYXIhk93hXx43lTjtUXYHUVYNin/GZW8U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, PeiSen Hou <pshou@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 10/90] ALSA: hda/realtek: Fix add a "ultra_low_power" function for intel reference board (alc256)
Date:   Mon,  3 Aug 2020 14:18:32 +0200
Message-Id: <20200803121858.042920784@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121857.546052424@linuxfoundation.org>
References: <20200803121857.546052424@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: PeiSen Hou <pshou@realtek.com>

commit 6fa38ef1534e7e9320aa15e329eb1404ab2f70ac upstream.

Intel requires to enable power saving mode for intel reference board (alc256)

Signed-off-by: PeiSen Hou <pshou@realtek.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200727115647.10967-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7555,7 +7555,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x10cf, 0x1629, "Lifebook U7x7", ALC255_FIXUP_LIFEBOOK_U7x7_HEADSET_MIC),
 	SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", ALC269_FIXUP_LIFEBOOK_EXTMIC),
 	SND_PCI_QUIRK(0x10ec, 0x10f2, "Intel Reference board", ALC700_FIXUP_INTEL_REFERENCE),
-	SND_PCI_QUIRK(0x10ec, 0x1230, "Intel Reference board", ALC225_FIXUP_HEADSET_JACK),
+	SND_PCI_QUIRK(0x10ec, 0x1230, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10f7, 0x8338, "Panasonic CF-SZ6", ALC269_FIXUP_HEADSET_MODE),
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),


