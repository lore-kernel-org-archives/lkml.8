Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6315C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4EB6206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037480;
	bh=x0hlXFmg6Wp3yDXIZw18ArQWevAcBwdk6vX7FKgCuko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BtD4U9LTdPIy2Ehwe7LU/7YPhXSRvXt9os50q5JcsBQbZ/k8LsFM92g2LVnZyXW58
	 05wyvLn1MSMl2aoriy6RefKzZJgfgFMh+M41EIqimfGyI9Ue5Deobv479B4cQPUjP/
	 NhvbVBNfTQ5aRY1B/VUjoEH3xr02paaWIBBY7u7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgFASFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729100AbgFASEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:04:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92ED520872;
        Mon,  1 Jun 2020 18:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034685;
        bh=x0hlXFmg6Wp3yDXIZw18ArQWevAcBwdk6vX7FKgCuko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=beWN3r5DZuKvyR7PcOb/K6b0hvNmTtiiaJmuImKw1/HibSV3cicQZEJPaUE9NFyBn
         PxCOie9vmXX5Br2+Ciepca85JpH5SofWw3wT4/amRNhJ7i/sexBYgoLrmQ7fIqQbU/
         vnxnsS883VajlA4gSqxyqd6XMcQjPHlv+Bx486HM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 62/95] ALSA: hda/realtek - Add new codec supported for ALC287
Date:   Mon,  1 Jun 2020 19:54:02 +0200
Message-Id: <20200601174030.894866009@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174020.759151073@linuxfoundation.org>
References: <20200601174020.759151073@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

[ Upstream commit 630e36126e420e1756378b3427b42711ce0b9ddd ]

Enable new codec supported for ALC287.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/dcf5ce5507104d0589a917cbb71dc3c6@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 34cda0accbd8..b06f7d52faad 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -387,6 +387,7 @@ static void alc_fill_eapd_coef(struct hda_codec *codec)
 	case 0x10ec0282:
 	case 0x10ec0283:
 	case 0x10ec0286:
+	case 0x10ec0287:
 	case 0x10ec0288:
 	case 0x10ec0285:
 	case 0x10ec0298:
@@ -7840,6 +7841,7 @@ static int patch_alc269(struct hda_codec *codec)
 	case 0x10ec0215:
 	case 0x10ec0245:
 	case 0x10ec0285:
+	case 0x10ec0287:
 	case 0x10ec0289:
 		spec->codec_variant = ALC269_TYPE_ALC215;
 		spec->shutup = alc225_shutup;
@@ -8978,6 +8980,7 @@ static const struct hda_device_id snd_hda_id_realtek[] = {
 	HDA_CODEC_ENTRY(0x10ec0284, "ALC284", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0285, "ALC285", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0286, "ALC286", patch_alc269),
+	HDA_CODEC_ENTRY(0x10ec0287, "ALC287", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0288, "ALC288", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0289, "ALC289", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0290, "ALC290", patch_alc269),
-- 
2.25.1



