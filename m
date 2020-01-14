Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506F6C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19659207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578997230;
	bh=SJvBSaoMS0e5WzxqzcuBHsGDMilqyBHp4GnjjU/Gexs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hfuC1SZRdoWqH8MmY+vrtpCu5xeJYZaVnyaRgcTRaEVa7QV8k98/XG09Pt1Xh2eMJ
	 hnSB20i/V2dpU/0MftyA1MLPBS0xjtuQYa6mTlwKufxGWurIi8ZaiEtkoh15HaN4I0
	 exIoJqQfXjr7MUFXWEcu1BiZzDheXeRLVSafaKQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgANKDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:03:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:58306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729537AbgANKD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:03:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B35124672;
        Tue, 14 Jan 2020 10:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996206;
        bh=SJvBSaoMS0e5WzxqzcuBHsGDMilqyBHp4GnjjU/Gexs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J+6PH9lfGOzRQUfNwyEPRpPqfOROjWwwzee5ZOIm5GFgR+O2HEmuv2Hclj9jSmeRy
         elF5UB2ZNn+1nHroB0dsMUw4EcGdytYvw1RDmW37mgJryWDivAD7pRQYiuRs94TVaE
         tYpNjvMS+YW394ygLOvI/GyFPMPFi2g7LYlnyoJ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 05/78] ALSA: usb-audio: Apply the sample rate quirk for Bose Companion 5
Date:   Tue, 14 Jan 2020 11:00:39 +0100
Message-Id: <20200114094353.250893006@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094352.428808181@linuxfoundation.org>
References: <20200114094352.428808181@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 51d4efab7865e6ea6a4ebcd25b3f03c019515c4c upstream.

Bose Companion 5 (with USB ID 05a7:1020) doesn't seem supporting
reading back the sample rate, so the existing quirk is needed.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206063
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200104110936.14288-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/quirks.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1397,6 +1397,7 @@ bool snd_usb_get_sample_rate_quirk(struc
 	case USB_ID(0x04D8, 0xFEEA): /* Benchmark DAC1 Pre */
 	case USB_ID(0x0556, 0x0014): /* Phoenix Audio TMX320VC */
 	case USB_ID(0x05A3, 0x9420): /* ELP HD USB Camera */
+	case USB_ID(0x05a7, 0x1020): /* Bose Companion 5 */
 	case USB_ID(0x074D, 0x3553): /* Outlaw RR2150 (Micronas UAC3553B) */
 	case USB_ID(0x1395, 0x740a): /* Sennheiser DECT */
 	case USB_ID(0x1901, 0x0191): /* GE B850V3 CP2114 audio interface */


