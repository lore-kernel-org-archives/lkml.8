Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA27C52D41
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165C024656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812196;
	bh=Bkh+we6stYqMwnk4wpfRnNp0RbbLSiBMlza0wPclcFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WUFxK1rJFu/e/DMsytLaqdf+Iwb3oA/IE/u6wUa9Q5kV8O85G4u/Tr5HYBx+t9zDd
	 0K1eV2CmbpYLOR9ENtQOdtZ9VwACuzRSBOH6qQ2VClUDvvihAgdbW9hPH6Vyh+pxnT
	 +zLEODtecd39gHexOPAospCYVSrCiG5DMmc9rlmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733303AbgB0ODO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:03:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733292AbgB0ODN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:03:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFC5B20801;
        Thu, 27 Feb 2020 14:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812193;
        bh=Bkh+we6stYqMwnk4wpfRnNp0RbbLSiBMlza0wPclcFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p/u31KyGoKDiwgc0zTcBEq5M/MAhRzI8RaIkNBs9vYmXQOAsoyGaJAhdbym1bFu+s
         jUVcZXismtma7+N3cFI7xZo8K/QheddvZ9ZwAr7XMOQFUlS5rTBYUH71D8+W7anf9i
         tlMMQ5EYlB+RAZElH7QbbgEhh0b9BItCUIkeb5oU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 04/97] ALSA: hda/realtek - Apply quirk for yet another MSI laptop
Date:   Thu, 27 Feb 2020 14:36:12 +0100
Message-Id: <20200227132215.265512747@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132214.553656188@linuxfoundation.org>
References: <20200227132214.553656188@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit cc5049ae4d457194796f854eb2e38b9727ad8c2d upstream.

MSI GP65 laptop with SSID 1462:1293 requires the same quirk as other
MSI models.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204159
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200218080915.3433-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2444,6 +2444,7 @@ static const struct snd_pci_quirk alc882
 	SND_PCI_QUIRK(0x1458, 0xa0b8, "Gigabyte AZ370-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
 	SND_PCI_QUIRK(0x1462, 0x1228, "MSI-GP63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1276, "MSI-GL73", ALC1220_FIXUP_CLEVO_P950),
+	SND_PCI_QUIRK(0x1462, 0x1293, "MSI-GP65", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x7350, "MSI-7350", ALC889_FIXUP_CD),
 	SND_PCI_QUIRK(0x1462, 0xda57, "MSI Z270-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
 	SND_PCI_QUIRK_VENDOR(0x1462, "MSI", ALC882_FIXUP_GPIO3),


