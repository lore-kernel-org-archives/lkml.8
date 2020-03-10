Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F62C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32AC24694
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845117;
	bh=SvLp9QeIlteRIJuHx2peXZJf994646fGWpEk41TPcgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KMRzuWBQ4GafKK3rFTYBrQ6xU5os4Sd/LMjWUSC0Y+xR82PqeNdTC2iwPaE6UIylM
	 nvskYODlC4Ocg/cU/lm6ho0KcMBqQ5RNDXwUz3V1abuXi5eY8rmzhsVWceinw5yQrw
	 gwo90dAEHckEIghp0TyEsr9w/pBclfGNZrSq2Eyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgCJM6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:58:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729915AbgCJM63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:58:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F237120674;
        Tue, 10 Mar 2020 12:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845109;
        bh=SvLp9QeIlteRIJuHx2peXZJf994646fGWpEk41TPcgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6XIcfkAhJRyJxap/2Jzhg5gQC7V5r0zW4tFBXa9PZyIiHQr8CoKokVjQf462tiWp
         /AxX9X49iX+oy1DFagiBr/FLQpABsHYpnf3jMFGBEJHBwgWg8k4sgH/k4FK7ycbhjP
         U9GnOD65OHUTtyUoRSwsTeCBWI4ZVIDrEnmr9YPg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christian Lachner <gladiac@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.5 064/189] ALSA: hda/realtek - Fix silent output on Gigabyte X570 Aorus Master
Date:   Tue, 10 Mar 2020 13:38:21 +0100
Message-Id: <20200310123646.059714635@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Lachner <gladiac@gmail.com>

commit 0d45e86d2267d5bdf7bbb631499788da1c27ceb2 upstream.

The Gigabyte X570 Aorus Master motherboard with ALC1220 codec
requires a similar workaround for Clevo laptops to enforce the
DAC/mixer connection path. Set up a quirk entry for that.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205275
Signed-off-by: Christian Lachner <gladiac@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200223092416.15016-2-gladiac@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2447,6 +2447,7 @@ static const struct snd_pci_quirk alc882
 	SND_PCI_QUIRK(0x1071, 0x8258, "Evesham Voyaeger", ALC882_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte EP45-DS3/Z87X-UD3H", ALC889_FIXUP_FRONT_HP_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1458, 0xa0b8, "Gigabyte AZ370-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
+	SND_PCI_QUIRK(0x1458, 0xa0cd, "Gigabyte X570 Aorus Master", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1228, "MSI-GP63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1276, "MSI-GL73", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1293, "MSI-GP65", ALC1220_FIXUP_CLEVO_P950),


