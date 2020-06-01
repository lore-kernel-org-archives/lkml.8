Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7BDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D65A420679
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037740;
	bh=FGwaNQkUdKW88U1CxOdinfFuRPVjkVQm1MT3k60Cho0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rVnYnwyKpc9lWiE3tZxzYBNmJmH1Bc9MwWWchxB+yShUvfoYk8d9oKyS3BSq4RcqE
	 VdO+fM8IrZ3U0Pb5JuYrx6u1cmNW0u0AjlA+rowB7TvHleiaVWDmfgQwBfk+dLrbFk
	 zXm4dMUI9lM4/Hf6fWr+rOucuDZRHNuZqpVDvPr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbgFASzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:55:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729749AbgFASBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:01:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDAB92065C;
        Mon,  1 Jun 2020 18:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034472;
        bh=FGwaNQkUdKW88U1CxOdinfFuRPVjkVQm1MT3k60Cho0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QRcrieOEaAuDteAAKlBEksJlzxDO9g36q+TcU/kWtHr4vqp9ubDc3FwzkUIYbF+lr
         4IU3G1NhlZq/gKX8CFivR1R6IrzNPJaa17T95D8Pz4RtW2DIWq3X4FzETOOAsC0AeB
         YGn960kxvrDj0IBOB9iJ3izDw62ozP6QOLK3Go0U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 46/77] ALSA: hda/realtek - Add new codec supported for ALC287
Date:   Mon,  1 Jun 2020 19:53:51 +0200
Message-Id: <20200601174024.598792261@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174016.396817032@linuxfoundation.org>
References: <20200601174016.396817032@linuxfoundation.org>
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
index c4e97b3ba1dd..5be3c926364e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -341,6 +341,7 @@ static void alc_fill_eapd_coef(struct hda_codec *codec)
 	case 0x10ec0282:
 	case 0x10ec0283:
 	case 0x10ec0286:
+	case 0x10ec0287:
 	case 0x10ec0288:
 	case 0x10ec0285:
 	case 0x10ec0298:
@@ -7290,6 +7291,7 @@ static int patch_alc269(struct hda_codec *codec)
 	case 0x10ec0215:
 	case 0x10ec0245:
 	case 0x10ec0285:
+	case 0x10ec0287:
 	case 0x10ec0289:
 		spec->codec_variant = ALC269_TYPE_ALC215;
 		spec->gen.mixer_nid = 0;
@@ -8389,6 +8391,7 @@ static const struct hda_device_id snd_hda_id_realtek[] = {
 	HDA_CODEC_ENTRY(0x10ec0284, "ALC284", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0285, "ALC285", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0286, "ALC286", patch_alc269),
+	HDA_CODEC_ENTRY(0x10ec0287, "ALC287", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0288, "ALC288", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0289, "ALC289", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0290, "ALC290", patch_alc269),
-- 
2.25.1



