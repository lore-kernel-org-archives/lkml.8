Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9F3C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C10E24677
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582056038;
	bh=iaLubHGPgPk7jIXL2erHvzW0+SkVMmcTvq40jqMmVM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o650aTqt+zNrSsgjYwzertdvNdfPH0ZkfgxUEcZ6DzBWiOiS6nXzSe8+c88yUhv9H
	 wLRiNEgKN8haoRB9vI8Dj0bjk1ZVR3hrJ9vrZxPyAVUpFL+8fJDC/l/TpqNVEz7qhA
	 fNB+EVzBjjF17pYL7ZG5bbSzIX9gz0+KUQDCe6X8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgBRUAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:00:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:39876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbgBRUAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:00:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AC392464E;
        Tue, 18 Feb 2020 20:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582056034;
        bh=iaLubHGPgPk7jIXL2erHvzW0+SkVMmcTvq40jqMmVM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pZ8MvAqDIasbfFv8dVLAcTBtgnWBTjJeqqkjHxvdwpygtbHzG01bMRsCLPJIaKpGY
         tSCOFouYgG89JrFX04XZIhgGhLxHUV4LfLTvtobYD73SPYzOT61vshPhbxdTb3Vvoc
         BHmBQAw/k0GTG5boDW60I/thTMsDSzBlCcd0IViE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.5 10/80] ALSA: hda/realtek - Fix silent output on MSI-GL73
Date:   Tue, 18 Feb 2020 20:54:31 +0100
Message-Id: <20200218190433.075335833@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190432.043414522@linuxfoundation.org>
References: <20200218190432.043414522@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 7dafba3762d6c0083ded00a48f8c1a158bc86717 upstream.

MSI-GL73 laptop with ALC1220 codec requires a similar workaround for
Clevo laptops to enforce the DAC/mixer connection path.  Set up a
quirk entry for that.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204159
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200212081047.27727-1-tiwai@suse.de
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
+	SND_PCI_QUIRK(0x1462, 0x1276, "MSI-GL73", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x7350, "MSI-7350", ALC889_FIXUP_CD),
 	SND_PCI_QUIRK(0x1462, 0xda57, "MSI Z270-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
 	SND_PCI_QUIRK_VENDOR(0x1462, "MSI", ALC882_FIXUP_GPIO3),


