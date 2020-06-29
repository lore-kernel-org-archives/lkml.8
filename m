Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A145C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE1E6206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593467244;
	bh=8JzVfCFcoz6nS6EBFimls7GqLgC990AM2OQCsZ0RXPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wz5Lp0TzFCmn+6Qm10KTZUzJV+LpwkUNaypK5amGUT23YNo0PztVcDLSuEYcvJrn8
	 94JNNi9FQ5tRNpE+q9MNkIXlBvtnSv9bTT7yP6LMBvURLjmiXq22ko5sQb+iKKsZJQ
	 0K/vWvYk2OHWWaKh4sUqzazTmKpKNaN7Im71PnuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgF2VrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:47:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgF2Sfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CF8A24790;
        Mon, 29 Jun 2020 15:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444099;
        bh=8JzVfCFcoz6nS6EBFimls7GqLgC990AM2OQCsZ0RXPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vrA58Ou1gZ6xVbnmh7qyKVGplf8OW7Y6X7Q2YE+IJwRMVmwWV+dJ033t1eT4Rmsfd
         5ewDNqH6ZZ5L6DJi2h220d24/mcjwf86tH7P8/UJ2Oe6W1f288Oix8PsHzKavCTca9
         JXpWBhqPUfUq44kDbO5C5IUUGX9nRYjZtSm7Z+LI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.7 210/265] ALSA: hda/realtek - Add quirk for MSI GE63 laptop
Date:   Mon, 29 Jun 2020 11:17:23 -0400
Message-Id: <20200629151818.2493727-211-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
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
index e057ecb5a9045..f58102925c705 100644
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

