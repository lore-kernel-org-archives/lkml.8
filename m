Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3902DC54E4A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A21F20857
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588861676;
	bh=jbQDkrhi+Hu1rfCVyIs1uuWtB/cadv2biPUK+kuj+hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=De7KnGO4dkfMWcCGTdGAH6H7N5anJXemvQPVQkCE/mcUgObHLf4Nz1JOxoAb/SI6b
	 WbpOr7dcR6Uvhk9IY9aa/g7Yt9fA1CmoYWCfLXfkYQT355LqV3Q38ycvRpLBIBSrys
	 jmFGVh3530n10qiErX0MYKliMXr7GKoeecQyfa5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgEGO1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbgEGO1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:27:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8C8020857;
        Thu,  7 May 2020 14:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588861671;
        bh=jbQDkrhi+Hu1rfCVyIs1uuWtB/cadv2biPUK+kuj+hk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ZDx7c2DHOhHYVJZeGz+Vwkr9p9hlhaxg+Tep8iU/wCG/WyAGu9aSZ0ZfwCT6UK0T
         xYWaeOT/M+1ZMAJ6oL3WZ3O/0xniqTLdE7i3cC/XFLzhZpOYg6qswa0A2Iq8ykGkzy
         9MzHDc5mTXkZgxG30zLg/nh5yhqkKa0fPs5Sb3TI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.6 20/50] ALSA: hda: Match both PCI ID and SSID for driver blacklist
Date:   Thu,  7 May 2020 10:26:56 -0400
Message-Id: <20200507142726.25751-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507142726.25751-1-sashal@kernel.org>
References: <20200507142726.25751-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 977dfef40c8996b69afe23a9094d184049efb7bb ]

The commit 3c6fd1f07ed0 ("ALSA: hda: Add driver blacklist") added a
new blacklist for the devices that are known to have empty codecs, and
one of the entries was ASUS ROG Zenith II (PCI SSID 1043:874f).
However, it turned out that the very same PCI SSID is used for the
previous model that does have the valid HD-audio codecs and the change
broke the sound on it.

Since the empty codec problem appear on the certain AMD platform (PCI
ID 1022:1487), this patch changes the blacklist matching to both PCI
ID and SSID using pci_match_id().  Also, the entry that was removed by
the previous fix for ASUS ROG Zenigh II is re-added.

Link: https://lore.kernel.org/r/20200424061222.19792-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 59b60b1f26f80..8b015b27e9c73 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2075,9 +2075,10 @@ static void pcm_mmap_prepare(struct snd_pcm_substream *substream,
  * some HD-audio PCI entries are exposed without any codecs, and such devices
  * should be ignored from the beginning.
  */
-static const struct snd_pci_quirk driver_blacklist[] = {
-	SND_PCI_QUIRK(0x1462, 0xcb59, "MSI TRX40 Creator", 0),
-	SND_PCI_QUIRK(0x1462, 0xcb60, "MSI TRX40", 0),
+static const struct pci_device_id driver_blacklist[] = {
+	{ PCI_DEVICE_SUB(0x1022, 0x1487, 0x1043, 0x874f) }, /* ASUS ROG Zenith II / Strix */
+	{ PCI_DEVICE_SUB(0x1022, 0x1487, 0x1462, 0xcb59) }, /* MSI TRX40 Creator */
+	{ PCI_DEVICE_SUB(0x1022, 0x1487, 0x1462, 0xcb60) }, /* MSI TRX40 */
 	{}
 };
 
@@ -2097,7 +2098,7 @@ static int azx_probe(struct pci_dev *pci,
 	bool schedule_probe;
 	int err;
 
-	if (snd_pci_quirk_lookup(pci, driver_blacklist)) {
+	if (pci_match_id(driver_blacklist, pci)) {
 		dev_info(&pci->dev, "Skipping the blacklisted device\n");
 		return -ENODEV;
 	}
-- 
2.20.1

