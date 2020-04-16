Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E507C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20E6D214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587051910;
	bh=B3agja7d5i9EgfKrTUOIU7rPulPCYb51rpGZv+pp3Sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vN2Qe5AAujvYAFS0AMQ2PjTgSAfEwVkxb/av2AhhZZYD35gR7Cnv0hWlg+hpTg4V7
	 0rJO6F1Jcn+L3bCT+b8lvaR16O4HQu4NvUDd7nT4TI/1O0GEXpwj6MTRk1EHbWqvAV
	 sf0CoyakKcXxFEr4bt/hfw+D0e7/pDjFM9TlnKEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407943AbgDPPpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897101AbgDPNfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:35:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBBB5208E4;
        Thu, 16 Apr 2020 13:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044116;
        bh=B3agja7d5i9EgfKrTUOIU7rPulPCYb51rpGZv+pp3Sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QtQP1h5b0rDbdNUOGHqvxbzyyzoa1koXehrek12VLBtZFAb143X6BMn6RWnOZ1nvW
         AQOmx+Epk7/2pz3PBPKOuVa/l6d3XSr4+qqgV9+4Gr9LMMD58WhtY+uExOOBjduFoB
         0GNBPynGPF2xprbCrCIbTIQFTwv7o2/19YR4u+Nk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.5 088/257] ALSA: hda: Add driver blacklist
Date:   Thu, 16 Apr 2020 15:22:19 +0200
Message-Id: <20200416131336.983738605@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 3c6fd1f07ed03a04debbb9a9d782205f1ef5e2ab upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_intel.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2074,6 +2074,17 @@ static void pcm_mmap_prepare(struct snd_
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
@@ -2090,6 +2101,11 @@ static int azx_probe(struct pci_dev *pci
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


