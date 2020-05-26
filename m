Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8D5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDB8C20888
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590521259;
	bh=oXcHXb6dsSUvMpO8NE2tgJlKh/jHYLMsINJNQtFNX/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pBf0zKTWFVUIDbaOU3OhYO7non/FrutZsreZtkKxJx9nb4cY89eYXrB/JCou6BnQw
	 sj1mMEt9pOD5EYVdN9WnMOoQONAvaECDWDubGiTRMW6hxgoUwLGlSmcfHqotMIYCRY
	 Ua65RDNAV64j6q6prrTuXQq6CkOrAeT0tu8MMe9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392488AbgEZT1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391319AbgEZTEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:04:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C293E20849;
        Tue, 26 May 2020 19:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519850;
        bh=oXcHXb6dsSUvMpO8NE2tgJlKh/jHYLMsINJNQtFNX/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a/do5Po24igzrLrMRgzpLx4wIkC8UUC3rculzuxlYixFyMf7MNIR8wayRDx7UI92b
         3FEHk13KpA41h7GegkcsYRiv2+Y1CibmblkmOY1dduN3+BZJlO4Kp2xuBlsM6C2HRm
         bRP7pN0ilXPpdZz+mfQlvVlVg7nggJnABYHs+JxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christian Lachner <gladiac@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 40/81] ALSA: hda/realtek - Fix silent output on Gigabyte X570 Aorus Xtreme
Date:   Tue, 26 May 2020 20:53:15 +0200
Message-Id: <20200526183931.653439338@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183923.108515292@linuxfoundation.org>
References: <20200526183923.108515292@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Lachner <gladiac@gmail.com>

commit d9e8fe0cffbfdd18de96fa68ee2a8b667a0b046e upstream.

The Gigabyte X570 Aorus Xtreme motherboard with ALC1220 codec
requires a similar workaround for Clevo laptops to enforce the
DAC/mixer connection path. Set up a quirk entry for that.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205275
Signed-off-by: Christian Lachner <gladiac@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200518053844.42743-2-gladiac@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2443,6 +2443,7 @@ static const struct snd_pci_quirk alc882
 	SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte EP45-DS3/Z87X-UD3H", ALC889_FIXUP_FRONT_HP_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1458, 0xa0b8, "Gigabyte AZ370-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
 	SND_PCI_QUIRK(0x1458, 0xa0cd, "Gigabyte X570 Aorus Master", ALC1220_FIXUP_CLEVO_P950),
+	SND_PCI_QUIRK(0x1458, 0xa0ce, "Gigabyte X570 Aorus Xtreme", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1228, "MSI-GP63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1275, "MSI-GL63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1276, "MSI-GL73", ALC1220_FIXUP_CLEVO_P950),


