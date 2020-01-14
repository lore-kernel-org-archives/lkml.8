Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83775C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1BB2468B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996436;
	bh=+gYPelXvqrrju/nEGUV6QFgs/hZenqpPWhlUyiFzqwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kq8WnbVHScRnto2BRpn76wqdvurkoiHFmP40FjAPsu9iE1LofBp+75QqULd6MeBzm
	 0eLxCCoo5xej8BJNK9eVUAHbyQ++5LT4W1u1kiY7fYnpOwI1L/rQHMq0sC+G74zX+j
	 hA8iVDuqh2awXSHmhC8X97vbXSzew5hJOHQf7q6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbgANKHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:07:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:36840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729745AbgANKHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:07:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 259F624681;
        Tue, 14 Jan 2020 10:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996425;
        bh=+gYPelXvqrrju/nEGUV6QFgs/hZenqpPWhlUyiFzqwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TSXNR6WIpbog3P5TGPPW1+ctoYfKl+cCOnXN8DnTEJh4vthItFPpCw2wUFHi5YfpB
         7OyRHpqqimFUnb2ZDmPCs96Crlbt3D2GBFOUplZ+CM39NZBREtYXVUe7+pZh1ONlpq
         Q71oDC84SvBCBCvD+SIPw3Pcx9Kq4D4P9uDqsgJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 05/46] ALSA: hda/realtek - Add new codec supported for ALCS1200A
Date:   Tue, 14 Jan 2020 11:01:22 +0100
Message-Id: <20200114094341.488946953@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094339.608068818@linuxfoundation.org>
References: <20200114094339.608068818@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

commit 6d9ffcff646bbd0ede6c2a59f4cd28414ecec6e0 upstream.

Add ALCS1200A supported.
It was similar as ALC900.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/a9bd3cdaa02d4fa197623448d5c51e50@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -442,6 +442,7 @@ static void alc_fill_eapd_coef(struct hd
 		break;
 	case 0x10ec0899:
 	case 0x10ec0900:
+	case 0x10ec0b00:
 	case 0x10ec1168:
 	case 0x10ec1220:
 		alc_update_coef_idx(codec, 0x7, 1<<1, 0);
@@ -2521,6 +2522,7 @@ static int patch_alc882(struct hda_codec
 	case 0x10ec0882:
 	case 0x10ec0885:
 	case 0x10ec0900:
+	case 0x10ec0b00:
 	case 0x10ec1220:
 		break;
 	default:
@@ -8989,6 +8991,7 @@ static const struct hda_device_id snd_hd
 	HDA_CODEC_ENTRY(0x10ec0892, "ALC892", patch_alc662),
 	HDA_CODEC_ENTRY(0x10ec0899, "ALC898", patch_alc882),
 	HDA_CODEC_ENTRY(0x10ec0900, "ALC1150", patch_alc882),
+	HDA_CODEC_ENTRY(0x10ec0b00, "ALCS1200A", patch_alc882),
 	HDA_CODEC_ENTRY(0x10ec1168, "ALC1220", patch_alc882),
 	HDA_CODEC_ENTRY(0x10ec1220, "ALC1220", patch_alc882),
 	{} /* terminator */


