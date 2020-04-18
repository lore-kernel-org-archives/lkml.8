Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52DDC3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A589B21D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587221439;
	bh=JUaulxSquTbxuDaE3Xl3iEeHyI/GelL7SV6i8zDb0OM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AjW0liR6azf8d2NLuyfhDOx7IuPLgH0Xay8wAdEMw+8Qjz1Z3SyX8SstVx65sYyC8
	 vZtJM6iN/c2za05j1AbEPXLtjoxC66cwTvccENJ0ZQZfp8S7AG0gbpM06pi3VecqVv
	 AIhgBNCwkTUHEvjig97o1Wpplq7yzY6NEPWDYJHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgDROui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728504AbgDROnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:43:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA7CC22265;
        Sat, 18 Apr 2020 14:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587220986;
        bh=JUaulxSquTbxuDaE3Xl3iEeHyI/GelL7SV6i8zDb0OM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DVPMgXQpSOND9aK5v9oNt3AaygE+yveCvkXt5xGkZpXYlgV9qXQm4TMVF/Uz5bbcs
         spPTQdM5Sqvshd1FCDzLQmYzia7yxaixBiDAGpt+w+ngSSuaxAvjb941mpE6UJ4SsJ
         VAfHp/iahPXFMD+XeKjWUzpJbUjym3VeX+aSc9tg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 30/47] ALSA: hda/realtek - Add quirk for MSI GL63
Date:   Sat, 18 Apr 2020 10:42:10 -0400
Message-Id: <20200418144227.9802-30-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144227.9802-1-sashal@kernel.org>
References: <20200418144227.9802-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 1d3aa4a5516d2e4933fe3cca11d3349ef63bc547 ]

MSI GL63 laptop requires the similar quirk like other MSI models,
ALC1220_FIXUP_CLEVO_P950.  The board BIOS doesn't provide a PCI SSID
for the device, hence we need to take the codec SSID (1462:1275)
instead.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207157
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200408135645.21896-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 23aab2fdac468..72d3b74a42cbb 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2444,6 +2444,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1458, 0xa0b8, "Gigabyte AZ370-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
 	SND_PCI_QUIRK(0x1458, 0xa0cd, "Gigabyte X570 Aorus Master", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1228, "MSI-GP63", ALC1220_FIXUP_CLEVO_P950),
+	SND_PCI_QUIRK(0x1462, 0x1275, "MSI-GL63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1276, "MSI-GL73", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1293, "MSI-GP65", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x7350, "MSI-7350", ALC889_FIXUP_CD),
-- 
2.20.1

