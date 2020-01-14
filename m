Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005E9C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBFB20678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996977;
	bh=kj5oLprT9pQG69urIPM3UZ0hDiIFQcdBiSg9DXCNPXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GkQVdRa+SE7fD7tZILuTXUApFxZqWruAPRqXtgMaPUVvFH6jRy3fbG0QTT2zgOrBO
	 2i0sJ8k/vDwdMmkc1clpBfKSFB2RAr/gJju33BzxAw6EceiBtmc0joM4BOriK20XAY
	 xvnzbeTOp3Lc3TC6+y8o044lSuLRAR/xwJE3eXU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbgANKQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:16:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730743AbgANKJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:09:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8019207FF;
        Tue, 14 Jan 2020 10:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996587;
        bh=kj5oLprT9pQG69urIPM3UZ0hDiIFQcdBiSg9DXCNPXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=swo++ogz1/UjAZGRYHcZnkvP0NRnFEnPFI4ZS+9aaHf1A3vQELto12kb3z6Zokjzz
         HcTNTNINI74623lEFYEQIJBgEiHPnJOXU2F25D9mMBp1GqwRsD9N2MDwjFjYQc7jGV
         11z6mGJHmQNZEMPrIEBvY+nZsGoZhqjz7LwNTxyI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 04/39] ALSA: hda/realtek - Add new codec supported for ALCS1200A
Date:   Tue, 14 Jan 2020 11:01:38 +0100
Message-Id: <20200114094338.882263254@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094336.210038037@linuxfoundation.org>
References: <20200114094336.210038037@linuxfoundation.org>
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
@@ -396,6 +396,7 @@ static void alc_fill_eapd_coef(struct hd
 		break;
 	case 0x10ec0899:
 	case 0x10ec0900:
+	case 0x10ec0b00:
 	case 0x10ec1168:
 	case 0x10ec1220:
 		alc_update_coef_idx(codec, 0x7, 1<<1, 0);
@@ -2389,6 +2390,7 @@ static int patch_alc882(struct hda_codec
 	case 0x10ec0882:
 	case 0x10ec0885:
 	case 0x10ec0900:
+	case 0x10ec0b00:
 	case 0x10ec1220:
 		break;
 	default:
@@ -8398,6 +8400,7 @@ static const struct hda_device_id snd_hd
 	HDA_CODEC_ENTRY(0x10ec0892, "ALC892", patch_alc662),
 	HDA_CODEC_ENTRY(0x10ec0899, "ALC898", patch_alc882),
 	HDA_CODEC_ENTRY(0x10ec0900, "ALC1150", patch_alc882),
+	HDA_CODEC_ENTRY(0x10ec0b00, "ALCS1200A", patch_alc882),
 	HDA_CODEC_ENTRY(0x10ec1168, "ALC1220", patch_alc882),
 	HDA_CODEC_ENTRY(0x10ec1220, "ALC1220", patch_alc882),
 	{} /* terminator */


