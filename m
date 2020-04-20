Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A021C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65DB820782
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3EwKK9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgDTUU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgDTUU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:20:26 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D78C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:20:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k11so13833392wrp.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WaNkYITjpr2SJjowiiyR8sRi3eo+gyei8bJaiA5cLw0=;
        b=Y3EwKK9Y5HCD6i0fmisN2pj7R3M+p4Ukl2HwAWgKkuyHdWJOKD3hAvOAs3MFDiaOmX
         SPpTk7WcQJIAQhUyNqkiLDyC88nU1aCgLqZke94+xejuqmQmQMYxmpdaYYWK24xtbfVH
         CMRWCyZ0/qhfHG6rQRRlj/JIrhY1I3JbsM3Js69YIS5plZecPEqRq1j2c559p2BIJNWg
         o7z+8IfmeUV7Z+MvizXjkbo5F8AU/5Oir5+W66XBFQEZdNxIuSw1vMCqd1UGd+MVTvsC
         p1w+LTV8fsKfE5joQamgpZdFJ+S8jCHXzFRolk+p83sJRHPf2THpkwlAme7aYtn8UBAw
         9tOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WaNkYITjpr2SJjowiiyR8sRi3eo+gyei8bJaiA5cLw0=;
        b=gSanplsXgSpusfBSEKf6LZbxofJiVHKfm7SYQFQL6+cLzACHTGLHw0+o94oQ8Jgp1u
         osSYmbWqyjGnieGvSXIfrohBiFKVkLnXqq7qXc6u5v/lGjhM6GF2z6puufJxQeDmW649
         c4eRRLoucl15KvN3ZKqhP7VnfzBE1uQY2IgKtAQR8j+aJvUDofxoeBBsomS6PTGxKce/
         RZH2S6+Q/05C7Sq6GB0L+ZG+RKMdd4u9RtOtPEccRq5OMwtDi/3Ja4eYBQ4FLBaHN1u7
         +S/sVrwUyVM1Aar0QDwLdfbHkVCxFoKDErepLR6ZrqmSt45Hk7OkAvqXldGHc7Mf5d/I
         x7zA==
X-Gm-Message-State: AGi0PuYky9iRH2xHV4yjHpoxWxCNEJrODVnsABpIQxXmCaHyHyQOqWOo
        aF+yn5SHYtnC6yw3TjzYdlo=
X-Google-Smtp-Source: APiQypKOFZ/OsoFUO7Ip+UczM4P7hW+gEVwybr4+Ux4Vbi2V+C8fm37/5IMLcEVQXuL+BuKVbSWCFw==
X-Received: by 2002:a5d:4b49:: with SMTP id w9mr20692680wrs.359.1587414023070;
        Mon, 20 Apr 2020 13:20:23 -0700 (PDT)
Received: from localhost.localdomain ([91.221.170.230])
        by smtp.googlemail.com with ESMTPSA id o18sm773682wrp.23.2020.04.20.13.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:20:22 -0700 (PDT)
From:   Gregor Pintar <grpintar@gmail.com>
To:     tiwai@suse.com, perex@perex.cz
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        grpintar@gmail.com
Subject: [PATCH] ALSA: usb-audio: Add quirk for Focusrite Scarlett 2i2
Date:   Mon, 20 Apr 2020 22:19:37 +0200
Message-Id: <20200420201937.12634-1-grpintar@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Force it to use asynchronous playback.

Same quirk has already been added for Focusrite Scarlett Solo (2nd gen)
with a commit 46f5710f0b88 ("ALSA: usb-audio: Add quirk for Focusrite
Scarlett Solo").

This also seems to prevent regular clicks when playing at 44100Hz
on Scarlett 2i2 (2nd gen). I did not notice any side effects.

Signed-off-by: Gregor Pintar <grpintar@gmail.com>
---
 sound/usb/quirks-table.h | 84 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index e009d584e..bc936bf79 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2840,6 +2840,90 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
+{
+	/*
+	 * Focusrite Scarlett 2i2 2nd generation
+	 * Reports that playback should use Synch: Synchronous
+	 * while still providing a feedback endpoint. Synchronous causes
+	 * snapping on some sample rates.
+	 * Force it to use Synch: Asynchronous.
+	 */
+	USB_DEVICE(0x1235, 0x8202),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 2,
+					.iface = 1,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = 0,
+					.endpoint = 0x01,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_ASYNC,
+					.protocol = UAC_VERSION_2,
+					.rates = SNDRV_PCM_RATE_44100 |
+						SNDRV_PCM_RATE_48000 |
+						SNDRV_PCM_RATE_88200 |
+						SNDRV_PCM_RATE_96000 |
+						SNDRV_PCM_RATE_176400 |
+						SNDRV_PCM_RATE_192000,
+					.rate_min = 44100,
+					.rate_max = 192000,
+					.nr_rates = 6,
+					.rate_table = (unsigned int[]) {
+						44100, 48000, 88200,
+						96000, 176400, 192000
+					},
+					.clock = 41
+				}
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 2,
+					.iface = 2,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = 0,
+					.endpoint = 0x82,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_ASYNC |
+						USB_ENDPOINT_USAGE_IMPLICIT_FB,
+					.protocol = UAC_VERSION_2,
+					.rates = SNDRV_PCM_RATE_44100 |
+						SNDRV_PCM_RATE_48000 |
+						SNDRV_PCM_RATE_88200 |
+						SNDRV_PCM_RATE_96000 |
+						SNDRV_PCM_RATE_176400 |
+						SNDRV_PCM_RATE_192000,
+					.rate_min = 44100,
+					.rate_max = 192000,
+					.nr_rates = 6,
+					.rate_table = (unsigned int[]) {
+						44100, 48000, 88200,
+						96000, 176400, 192000
+					},
+					.clock = 41
+				}
+			},
+			{
+				.ifnum = 3,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
 
 /* Access Music devices */
 {
-- 
2.20.1

