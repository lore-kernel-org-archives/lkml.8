Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D066CC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5857208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340008;
	bh=TpS93HXzeugPFDQSTYDNxPAiVVoolk1rUfEuk9z1Bbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hRZ39J+1hF3ZxwiIutHkXFmgdXG680H62gVPNFgU9YWi3ObTNx+nr0np6Cs8sCUWS
	 HJE22iWPm9miNfBPZnq803n83AiPF/nyjMK95zsVm3y+i6AKirZsM/Hy6WfZtV8Iq5
	 +lwi+oOix0b+iJ26LDdoYMvZ+jF5RBrJDthP+3Ks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbgEANd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:33:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730407AbgEANdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:33:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35C68208C3;
        Fri,  1 May 2020 13:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340001;
        bh=TpS93HXzeugPFDQSTYDNxPAiVVoolk1rUfEuk9z1Bbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PhAoYztVH85fjlnRZAfFVZ5GkaoDUfhBy94jfDeHI2YLJKsdk3sfaVOzPWbNGgDUV
         vA7MHFFceeYCXgovtyxf+JmLorYYkgGhuV5eVI67Zf4KyBpDzBsOC4H1OttuuPRf7V
         Dy6+I3yutW/lrPNNasf1NvVK/IIxTEWBdx05k/PE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 054/117] ALSA: hda/realtek - Add new codec supported for ALC245
Date:   Fri,  1 May 2020 15:21:30 +0200
Message-Id: <20200501131551.740025374@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131544.291247695@linuxfoundation.org>
References: <20200501131544.291247695@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

commit 7fbdcd8301a84c09cebfa64f1317a6dafeec9188 upstream.

Enable new codec supported for ALC245.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/8c0804738b2c42439f59c39c8437817f@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -334,6 +334,7 @@ static void alc_fill_eapd_coef(struct hd
 	case 0x10ec0233:
 	case 0x10ec0235:
 	case 0x10ec0236:
+	case 0x10ec0245:
 	case 0x10ec0255:
 	case 0x10ec0256:
 	case 0x10ec0257:
@@ -7264,6 +7265,7 @@ static int patch_alc269(struct hda_codec
 		spec->gen.mixer_nid = 0;
 		break;
 	case 0x10ec0215:
+	case 0x10ec0245:
 	case 0x10ec0285:
 	case 0x10ec0289:
 		spec->codec_variant = ALC269_TYPE_ALC215;
@@ -8344,6 +8346,7 @@ static const struct hda_device_id snd_hd
 	HDA_CODEC_ENTRY(0x10ec0234, "ALC234", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0235, "ALC233", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0236, "ALC236", patch_alc269),
+	HDA_CODEC_ENTRY(0x10ec0245, "ALC245", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0255, "ALC255", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0256, "ALC256", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0257, "ALC257", patch_alc269),


