Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8714EC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BB1C20674
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593460326;
	bh=PTXgBodTo5cXRnYlvSzqSd9BTMIrdK30OzvUyOONAiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qeWCOsMlq5YLz9PbBEd3t4/y8pPBAq+AkzbM1ukqplZA92BedxTBCzY0jmp55/q+6
	 b6AMjBFaLPYBw/mn68jHyEm2TjZ0hAkaFcmjzEnT99J4YooD4VekxVRssWF/kncdeV
	 Czp87t9y41Ab5r9FiBokuTQKJXtJ8mUiZGS7W7ZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388286AbgF2TwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:52:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387715AbgF2Tkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0FBF24908;
        Mon, 29 Jun 2020 15:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444460;
        bh=PTXgBodTo5cXRnYlvSzqSd9BTMIrdK30OzvUyOONAiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EAuteJD3+cSUQwPBwpP1afnq07N9AhF3wwG71KV7QEcnxSR/bqnqfUNUBD9C7rzfg
         yNhHoM4xzIAckMKuXM85kiGKUOaJ3qtmCWZVPwEbn9zP7MP1QhVDMay/ACEgfSye9u
         HY9hlcZIUlxDCoCS0NiigsT0k0LHVoFJFbtXNE5I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.4 140/178] ALSA: hda/realtek - Add quirk for MSI GE63 laptop
Date:   Mon, 29 Jun 2020 11:24:45 -0400
Message-Id: <20200629152523.2494198-141-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629152523.2494198-1-sashal@kernel.org>
References: <20200629152523.2494198-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.50-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.50-rc1
X-KernelTest-Deadline: 2020-07-01T15:25+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit a0b03952a797591d4b6d6fa7b9b7872e27783729 upstream.

MSI GE63 laptop with ALC1220 codec requires the very same quirk
(ALC1220_FIXUP_CLEVO_P950) as other MSI devices for the proper sound
output.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=208057
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200616132150.8778-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 459a7d61326ec..45315b14abe63 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2460,6 +2460,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1458, 0xa0b8, "Gigabyte AZ370-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
 	SND_PCI_QUIRK(0x1458, 0xa0cd, "Gigabyte X570 Aorus Master", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1458, 0xa0ce, "Gigabyte X570 Aorus Xtreme", ALC1220_FIXUP_CLEVO_P950),
+	SND_PCI_QUIRK(0x1462, 0x11f7, "MSI-GE63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1228, "MSI-GP63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1275, "MSI-GL63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1276, "MSI-GL73", ALC1220_FIXUP_CLEVO_P950),
-- 
2.25.1

