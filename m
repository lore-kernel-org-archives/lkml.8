Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAFEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7CD520679
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037495;
	bh=BIjX25o2Nl0UvKQ3OSYhwQrEQgiMKAAjhR6p4MIRU/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D0VgnCzSCzbBPD9tepw5axgO7/Lxk1p5+8BpDHsg9HKxwo0W54lQL7ozHCFiYtnsh
	 uqH3SJGqI2zgk4ZenJd4kgE3D5dJYcAjPe27RElHlQShgzrWxgvKBKxsX54UvyxLBC
	 yFVxQeg5jx3oQUBSNEj4lwaJppHVLgqHdQR1zIx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgFASEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730224AbgFASEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:04:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4AE72077D;
        Mon,  1 Jun 2020 18:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034678;
        bh=BIjX25o2Nl0UvKQ3OSYhwQrEQgiMKAAjhR6p4MIRU/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=awun5tBQffU4Jvt+H4CzBsbzUcY7PYD5FT0gzlacn5Pr0NnxD7PV3Lmvw+T+p+0ow
         2F61fO4QPvg62M6RqYHUHNGhyciNUFdWC1OBCKknTqmRFUdeYqfcVFStBVzj50T7pj
         AYGKtNbNB5Uzm79iWEgPYDYRlMmazeFuKhUuQQeU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Chiu <chiu@endlessm.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 59/95] ALSA: usb-audio: mixer: volume quirk for ESS Technology Asus USB DAC
Date:   Mon,  1 Jun 2020 19:53:59 +0200
Message-Id: <20200601174030.474392946@linuxfoundation.org>
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

From: Chris Chiu <chiu@endlessm.com>

[ Upstream commit 4020d1ccbe55bdf67b31d718d2400506eaf4b43f ]

The Asus USB DAC is a USB type-C audio dongle for connecting to
the headset and headphone. The volume minimum value -23040 which
is 0xa600 in hexadecimal with the resolution value 1 indicates
this should be endianness issue caused by the firmware bug. Add
a volume quirk to fix the volume control problem.

Also fixes this warning:
  Warning! Unlikely big volume range (=23040), cval->res is probably wrong.
  [5] FU [Headset Capture Volume] ch = 1, val = -23040/0/1
  Warning! Unlikely big volume range (=23040), cval->res is probably wrong.
  [7] FU [Headset Playback Volume] ch = 1, val = -23040/0/1

Signed-off-by: Chris Chiu <chiu@endlessm.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200526062613.55401-1-chiu@endlessm.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 7a5c665cf4e4..8a0211131fc6 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1186,6 +1186,14 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 			cval->res = 384;
 		}
 		break;
+	case USB_ID(0x0495, 0x3042): /* ESS Technology Asus USB DAC */
+		if ((strstr(kctl->id.name, "Playback Volume") != NULL) ||
+			strstr(kctl->id.name, "Capture Volume") != NULL) {
+			cval->min >>= 8;
+			cval->max = 0;
+			cval->res = 1;
+		}
+		break;
 	}
 }
 
-- 
2.25.1



