Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BC5C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3FCC2223D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587050366;
	bh=P0Kbr+jaiAUTu7vRnV1VEh+m2Ui/C/b38dc6jJjmH4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cXaAX6bMX2vd1z7883hTYnXCg172o3Rb5GVuWnQR0Fg8+eY+zqy/Ce9l4kcxfGQhO
	 2ocC/OZ/nBamWXCeHBJrGFtxmt93Ik5vJ/UYQpWRCxnVqkEcHTaIysscjvz+LDZHQx
	 kl2X7r9pxB33sMZUWzoxIRq2iP6fZurhL/qMXlbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504554AbgDPPTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:19:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898723AbgDPNrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:47:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D8C8208E4;
        Thu, 16 Apr 2020 13:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044874;
        bh=P0Kbr+jaiAUTu7vRnV1VEh+m2Ui/C/b38dc6jJjmH4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U7K1vAMwvVl5gKWujdNMQVk+9koJk8biI1iuVWHQ0VkQFMZ2FzNnfcTzT+gSOwfvd
         /7w8C0Sq44xO/kp2dBYyCoXOkIk2dp/sdmezNYATlgn65W568DGFRsrZIMzh4wKAg+
         63mwySlgdEJpY3D2lN64GwVFnWtctcWZNFw3t4Vk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 086/232] ALSA: hda/realtek - Add quirk for MSI GL63
Date:   Thu, 16 Apr 2020 15:23:00 +0200
Message-Id: <20200416131325.778286538@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 1d3aa4a5516d2e4933fe3cca11d3349ef63bc547 upstream.

MSI GL63 laptop requires the similar quirk like other MSI models,
ALC1220_FIXUP_CLEVO_P950.  The board BIOS doesn't provide a PCI SSID
for the device, hence we need to take the codec SSID (1462:1275)
instead.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207157
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200408135645.21896-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2447,6 +2447,7 @@ static const struct snd_pci_quirk alc882
 	SND_PCI_QUIRK(0x1458, 0xa0b8, "Gigabyte AZ370-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
 	SND_PCI_QUIRK(0x1458, 0xa0cd, "Gigabyte X570 Aorus Master", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1228, "MSI-GP63", ALC1220_FIXUP_CLEVO_P950),
+	SND_PCI_QUIRK(0x1462, 0x1275, "MSI-GL63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1276, "MSI-GL73", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1293, "MSI-GP65", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x7350, "MSI-7350", ALC889_FIXUP_CD),


