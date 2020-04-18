Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3CCC38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33D6320753
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587221648;
	bh=mB2qUxOwz7H7+t2VXUIz0ESIb9S4rCzBsqKWNvGsaTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fvM8nbzCHb8Hls21fPAONLfWMge+7RnxLf4raCVreb5md43JB/5V6UhxZNmd4eRxi
	 HJ+USUMS4rjxP+NllBcJXCrBpPSZu/nRG2RZxCGF+QNvMUGz0vN5mDkQITyiniry8C
	 h1vVviAAN5Q6rEvlnu0c3VSQkRy3cebSg2y/zvFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgDROyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:54:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728094AbgDROlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:41:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27FC921D82;
        Sat, 18 Apr 2020 14:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587220908;
        bh=mB2qUxOwz7H7+t2VXUIz0ESIb9S4rCzBsqKWNvGsaTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dxib1z5CMdrdb3b5xIj6YLx4Rnmc9H6o/oLx+vzcN/3Hqxj/M5RdsGIRd+69WAiIY
         Fb2FBOUNcoO87IWToT0p99j5Z8fmBR5rIakajQ1gM9RMFhD/o2fq8UI7AOGx+1gbs1
         ribk3u8BkvdyP1u7dbWIOrsuDus0h4CsHhxHeX2o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 48/78] ALSA: hda: Add driver blacklist
Date:   Sat, 18 Apr 2020 10:40:17 -0400
Message-Id: <20200418144047.9013-48-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144047.9013-1-sashal@kernel.org>
References: <20200418144047.9013-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 3c6fd1f07ed03a04debbb9a9d782205f1ef5e2ab ]

The recent AMD platform exposes an HD-audio bus but without any actual
codecs, which is internally tied with a USB-audio device, supposedly.
It results in "no codecs" error of HD-audio bus driver, and it's
nothing but a waste of resources.

This patch introduces a static blacklist table for skipping such a
known bogus PCI SSID entry.  As of writing this patch, the known SSIDs
are:
* 1043:874f - ASUS ROG Zenith II / Strix
* 1462:cb59 - MSI TRX40 Creator
* 1462:cb60 - MSI TRX40

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206543
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200408140449.22319-2-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 85beb172d8108..1db9d0579c72a 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2024,6 +2024,17 @@ static void pcm_mmap_prepare(struct snd_pcm_substream *substream,
 #endif
 }
 
+/* Blacklist for skipping the whole probe:
+ * some HD-audio PCI entries are exposed without any codecs, and such devices
+ * should be ignored from the beginning.
+ */
+static const struct snd_pci_quirk driver_blacklist[] = {
+	SND_PCI_QUIRK(0x1043, 0x874f, "ASUS ROG Zenith II / Strix", 0),
+	SND_PCI_QUIRK(0x1462, 0xcb59, "MSI TRX40 Creator", 0),
+	SND_PCI_QUIRK(0x1462, 0xcb60, "MSI TRX40", 0),
+	{}
+};
+
 static const struct hda_controller_ops pci_hda_ops = {
 	.disable_msi_reset_irq = disable_msi_reset_irq,
 	.pcm_mmap_prepare = pcm_mmap_prepare,
@@ -2059,6 +2070,11 @@ static int azx_probe(struct pci_dev *pci,
 	bool schedule_probe;
 	int err;
 
+	if (snd_pci_quirk_lookup(pci, driver_blacklist)) {
+		dev_info(&pci->dev, "Skipping the blacklisted device\n");
+		return -ENODEV;
+	}
+
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
 	if (!enable[dev]) {
-- 
2.20.1

