Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860A3C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B8624696
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583847018;
	bh=SvLp9QeIlteRIJuHx2peXZJf994646fGWpEk41TPcgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kdIq61yYTjmn4iGfRhuaZrkbwYakh6oNPNhR4Ob8NIVeQ5zn+tkhE7+Ia6yD1hLWq
	 mi4jQ/vsGDeuXBxWaNOs29tjQdERH/mmvYGdCBr3ktTxWHc0XiwzHuNQ+So2nw6jTC
	 8b0xeM+HnZVEB5hyD1rzppnRct44L3RxeOLZbBe4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgCJMul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728640AbgCJMuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:50:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F23162468E;
        Tue, 10 Mar 2020 12:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844634;
        bh=SvLp9QeIlteRIJuHx2peXZJf994646fGWpEk41TPcgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZS5ZVbe1NXbWtwr2oSNAfdcWORvrzWTrBs/MDoGKPUeTvRZGMyrBnoqaF3eaWFzmh
         LpWQsBYXQrgHeVzxOs1eJXQ6Dk0PTewWARRXLP3ImTCaZa6fQQYRC/n7g483NwzatW
         6TVe0XgwdniDQHrrJogu5SHZ+gRTMi1Y+2irknt4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christian Lachner <gladiac@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 062/168] ALSA: hda/realtek - Fix silent output on Gigabyte X570 Aorus Master
Date:   Tue, 10 Mar 2020 13:38:28 +0100
Message-Id: <20200310123641.556080956@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
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


