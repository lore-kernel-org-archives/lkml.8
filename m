Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534D4C3F34E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FEA24656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813905;
	bh=QisveVIqzmKwUGoJ8Sy17j3fPQyxBUWHRj/ky++yg78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Iqp5hDEKIeH3sXUdYE2VjH3HbpkHMloMZmnZkC/iTIsZBEsuvmykRvE8yYCF4xLnk
	 bdsSOiYl6nnkS0+alkazKexBxlH6asC5MaZNW7QkY4rZt3Uv9McnwrVUmOZXI3BaIt
	 ahuWetVE1LWZ3sTaDby5GCYdRNS86tSMVzLtVUpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733294AbgB0ODN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:03:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733268AbgB0ODL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:03:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF32420801;
        Thu, 27 Feb 2020 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812190;
        bh=QisveVIqzmKwUGoJ8Sy17j3fPQyxBUWHRj/ky++yg78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FQArhGeW8SSHKgj+iHzoC71+PLcq1tpgPrHO7HG3dOLZitNcp0Ot2aa6syJDOwsRu
         xdqAIpM7kWxDrAC0ngoDtcDWnKZIvx4z7S6F5k7TU1sj/Vfhsn7Dcy2L2BSviQLCT/
         9jNnZHZ5NkRM0J1Hq0xnxVy82y6T++0ZG/oppcTg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 03/97] ALSA: hda/realtek - Apply quirk for MSI GP63, too
Date:   Thu, 27 Feb 2020 14:36:11 +0100
Message-Id: <20200227132215.101907309@linuxfoundation.org>
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

commit a655e2b107d463ce2745188ce050d07daed09a71 upstream.

The same quirk that was applied to MSI GL73 is needed for MSI GP63,
too.  Adding the entry with the SSID 1462:1228.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206503
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200217151947.17528-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2442,6 +2442,7 @@ static const struct snd_pci_quirk alc882
 	SND_PCI_QUIRK(0x1071, 0x8258, "Evesham Voyaeger", ALC882_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte EP45-DS3/Z87X-UD3H", ALC889_FIXUP_FRONT_HP_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1458, 0xa0b8, "Gigabyte AZ370-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
+	SND_PCI_QUIRK(0x1462, 0x1228, "MSI-GP63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1276, "MSI-GL73", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x7350, "MSI-7350", ALC889_FIXUP_CD),
 	SND_PCI_QUIRK(0x1462, 0xda57, "MSI Z270-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),


