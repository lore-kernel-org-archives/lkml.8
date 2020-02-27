Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D8AC52D5A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D61D2469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812454;
	bh=CbyDrFMn32uvZfgP3IBgZLYcyX5tbyJPqq33qrjGK+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LnqWk+scnfoE4lSm8I368Yco8627v2XaVaWx2TTPihRoSdazJ1HaqvPLJWnt/szxW
	 hiiAuobFj9bCDUH7dEWLcEq3KGfaW0FE29VQdFDk9MIt9SPtzYPqII/CdbZJtNfsn5
	 Hd0bKH61E5vx1OWGRfVzEuZ4XYh1EQxw/pZ5h5vg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388100AbgB0OHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:07:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388087AbgB0OH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:07:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC32821D7E;
        Thu, 27 Feb 2020 14:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812448;
        bh=CbyDrFMn32uvZfgP3IBgZLYcyX5tbyJPqq33qrjGK+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z/MD/BEyMuM4GXDuniS1z1GYWeS/ausW9gknX0avhGeVD762C+/uQrF4csDmLGKVT
         /R1n0J/x2rCL32ddX/jt7Fe3LnqOkwv0UwXVQsVpDWjN+OpSDGhCIf+4Nbd3uyLa6k
         bARE5xNumQz025cA9UukDDe1hu953pBYmWDwpiQI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 004/135] ALSA: hda/realtek - Apply quirk for yet another MSI laptop
Date:   Thu, 27 Feb 2020 14:35:44 +0100
Message-Id: <20200227132229.525589619@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132228.710492098@linuxfoundation.org>
References: <20200227132228.710492098@linuxfoundation.org>
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
@@ -2449,6 +2449,7 @@ static const struct snd_pci_quirk alc882
 	SND_PCI_QUIRK(0x1458, 0xa0b8, "Gigabyte AZ370-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
 	SND_PCI_QUIRK(0x1462, 0x1228, "MSI-GP63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1276, "MSI-GL73", ALC1220_FIXUP_CLEVO_P950),
+	SND_PCI_QUIRK(0x1462, 0x1293, "MSI-GP65", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x7350, "MSI-7350", ALC889_FIXUP_CD),
 	SND_PCI_QUIRK(0x1462, 0xda57, "MSI Z270-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
 	SND_PCI_QUIRK_VENDOR(0x1462, "MSI", ALC882_FIXUP_GPIO3),


