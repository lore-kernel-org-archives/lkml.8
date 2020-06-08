Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC1BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC3B2083B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591660540;
	bh=sKZcWyp++va0RYlP8fE5B/2tUxL5JWyf+WqesDEiMhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=arybXIJIzVuLaej/L1ZUuNgpj2cB0uUTqeLvGpG0Zc7JZZ6VFJ3T1nSIu6r4XG3vA
	 8jk0qBj+kDuwCTOdpbnlt1DUCMGYR9shPz/NxE45zRRDRfFvAx30wppAT9DAZxNK2u
	 v/AI2EDZOvuA3LCSMA4AqdDX3U6JnDE+PLmY2jAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387470AbgFHXX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:23:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729566AbgFHXSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:18:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DD2420814;
        Mon,  8 Jun 2020 23:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658320;
        bh=sKZcWyp++va0RYlP8fE5B/2tUxL5JWyf+WqesDEiMhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uCYi31k4uBbxOVf+hC3aDZFjMjUcFn31D5K2np5nYvolR+V+IEEyxFLFBj+WiO43D
         FGXHFNdQqO8gdazk3eyER8PZJ5y9J0tVPC9KwyHwAlTZr3UpyZTydbDSqiHM3q9pMb
         Wy8jkAPL+YezWk09vmM1+IGC59Hihq6HLPzPjtHg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chris Chiu <chiu@endlessm.com>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.6 320/606] ALSA: usb-audio: mixer: volume quirk for ESS Technology Asus USB DAC
Date:   Mon,  8 Jun 2020 19:07:25 -0400
Message-Id: <20200608231211.3363633-320-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 7a2961ad60de..68fefe55e5c0 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1171,6 +1171,14 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
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

