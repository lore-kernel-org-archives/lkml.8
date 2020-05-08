Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC82C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C65EA2054F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942426;
	bh=AcdBHF1lQqiPltsSywu3bPWQZYgMsimmEDEYiFo43n8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F1OEZUTFuVBvOZM5/0vO33NcyuktgAVU8Lk3OU8bvFFKKpbW75VcY029RLFBauubx
	 Jr/5Mgx1AQayenlYAK8R142aomjpv23XDaPYSLfqi0+Lm/lO9U++GzJcr6VQ6POVYJ
	 53aDruSIlWkwD1jjJjfZl2cVogAyzbIyp5Yu+rog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbgEHMxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:53:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730087AbgEHMxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:53:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8205D2054F;
        Fri,  8 May 2020 12:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942419;
        bh=AcdBHF1lQqiPltsSywu3bPWQZYgMsimmEDEYiFo43n8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=znOSmRaQrz274MbYFsbnPMuTi1nG2nsMuxrieorgkMKMUBPGnkvqUC2fXpKBR6YWP
         /kZuhNYYYU6sM8EX+PJXaX32jgyFlRmlrp/IOXjqVUHx9EXnR/q/sBi/O8zxKuWPID
         MoSnNaudjGK0S9a10J8vKx2h/foCAYzu2fk1uXOU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 38/50] ALSA: hda: Match both PCI ID and SSID for driver blacklist
Date:   Fri,  8 May 2020 14:35:44 +0200
Message-Id: <20200508123048.527795103@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123043.085296641@linuxfoundation.org>
References: <20200508123043.085296641@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 977dfef40c8996b69afe23a9094d184049efb7bb upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_intel.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2023,9 +2023,10 @@ static void pcm_mmap_prepare(struct snd_
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
 
@@ -2064,7 +2065,7 @@ static int azx_probe(struct pci_dev *pci
 	bool schedule_probe;
 	int err;
 
-	if (snd_pci_quirk_lookup(pci, driver_blacklist)) {
+	if (pci_match_id(driver_blacklist, pci)) {
 		dev_info(&pci->dev, "Skipping the blacklisted device\n");
 		return -ENODEV;
 	}


