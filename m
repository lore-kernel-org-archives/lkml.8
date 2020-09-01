Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D806C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B238206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598976039;
	bh=S5C81WiV8OV3qp8z5Nyo7c98chNJsKCzHkYy4/d8fE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yr18mWJHqqKUjyGJQ6WNyObdbBT9rfBwG3QPEx13B6vnQbY058G7FuYRb8BuvKfWT
	 MgkaPLpytQPiObqkj+spDZdRbuSDFm9ih3JwYZr0Ezmi12SqMGM2vKOggohhKXdsJy
	 fQsVf/76TsLiJSck66KOGqYtUIY8KVLmxPDzmHLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbgIAQAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:00:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbgIAQAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:00:24 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E02DB20767;
        Tue,  1 Sep 2020 16:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598976024;
        bh=S5C81WiV8OV3qp8z5Nyo7c98chNJsKCzHkYy4/d8fE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iIO1d154iBheuw72X/qgqIIzQCLQXiDNGyTh+lJua4nPajl5pajIgWlQ1iiGSoVn5
         7CXob2nqCWa22OLSyX8pTp1LHKLk5TIwmsxQwcCnoVecvV2yEjQn3Ii/7kezbv5Iwg
         nJ8TsQrnicZSARYnotXex8JC3HFpfs4nenBRjPCw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Tsoy <alexander@tsoy.me>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 084/255] ALSA: usb-audio: Add capture support for Saffire 6 (USB 1.1)
Date:   Tue,  1 Sep 2020 17:09:00 +0200
Message-Id: <20200901151004.760924921@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Tsoy <alexander@tsoy.me>

[ Upstream commit 470757f5b3a46bd85741bb0d8c1fd3f21048a2af ]

Capture and playback endpoints on Saffire 6 (USB 1.1) resides on the same
interface. This was not supported by the composite quirk back in the day
when initial support for this device was added, thus only playback was
enabled until now.

Fixes: 11e424e88bd4 ("ALSA: usb-audio: Add support for Focusrite Saffire 6 USB")
Signed-off-by: Alexander Tsoy <alexander@tsoy.me>
Cc: <stable.vger.kernel.org>
Link: https://lore.kernel.org/r/20200815002103.29247-1-alexander@tsoy.me
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/quirks-table.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index a53eb67ad4bd8..946e7804942c7 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2678,6 +2678,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_COMPOSITE,
 		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_STANDARD_MIXER,
+			},
 			{
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
@@ -2690,6 +2694,32 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
 					.endpoint = 0x01,
 					.ep_attr = USB_ENDPOINT_XFER_ISOC,
+					.datainterval = 1,
+					.maxpacksize = 0x024c,
+					.rates = SNDRV_PCM_RATE_44100 |
+						 SNDRV_PCM_RATE_48000,
+					.rate_min = 44100,
+					.rate_max = 48000,
+					.nr_rates = 2,
+					.rate_table = (unsigned int[]) {
+						44100, 48000
+					}
+				}
+			},
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 2,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = 0,
+					.endpoint = 0x82,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC,
+					.datainterval = 1,
+					.maxpacksize = 0x0126,
 					.rates = SNDRV_PCM_RATE_44100 |
 						 SNDRV_PCM_RATE_48000,
 					.rate_min = 44100,
-- 
2.25.1



