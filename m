Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80252C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 540ED20776
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587549685;
	bh=Gffv+ReFDRRO5s95+puu/0ZhUVTFVRoGi0XUyz/4kE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SCQRXqveMD5f9DxxxUoTALL21hnYHfrmu/X3ZrNmVTkp4wFu9lW4PKSsyR//RqK8F
	 6NqexEYm7IFbCt73fbEuZUR0yWPxV7OPhHl9WAxs/XqPBXxn0Qtj9jD0rrpH1j7MdR
	 vY3kRh475MFFYYCJFreVqdysXtnMscs20eHfMvDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgDVKBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:01:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbgDVKBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:01:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13B5C2076C;
        Wed, 22 Apr 2020 10:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549679;
        bh=Gffv+ReFDRRO5s95+puu/0ZhUVTFVRoGi0XUyz/4kE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NmLsHHIvMimPLNh+co8MV1nafhvUH0ku2oQUtpMctYCZR/eIVciIeT0869qAnvdZq
         hSWk11xQ8ZNePAcRHR59Nkh6o3aTnfzbJecRZd8qn66lWy7jXrcUAo+KTENkC3suKE
         76+B6g3T7E59QNKeRFcZWNrmLjKF67I03V1Ie39A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 021/100] ALSA: hda: Add driver blacklist
Date:   Wed, 22 Apr 2020 11:55:51 +0200
Message-Id: <20200422095026.684017108@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095022.476101261@linuxfoundation.org>
References: <20200422095022.476101261@linuxfoundation.org>
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
@@ -1982,6 +1982,17 @@ static const struct hdac_io_ops pci_hda_
 	.dma_free_pages = dma_free_pages,
 };
 
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
 	.substream_alloc_pages = substream_alloc_pages,
@@ -2001,6 +2012,11 @@ static int azx_probe(struct pci_dev *pci
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


