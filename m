Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DD3C433FC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC8C8207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752701;
	bh=v2wN1Lorr9bWGmeULkeXI4D1aoWs1M0eeIraS7x8kDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RpeRB/U9csE04MIlGwHSdZ8Qey61biPRniQJXfWjIEw1IoZfIlDzTlwyfN5c6qeYZ
	 xW/1AgPd0V52tNyYuMSAt4pGIjSS/AgWf+oPXYPkiprg9NdvxJ5eK4yA/WRkQewDdl
	 CGWYvmxP//6SuNtqCja7D/CV1voo4i/pBTD4d1gY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgGNSvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729966AbgGNSvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:51:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E7BD207F5;
        Tue, 14 Jul 2020 18:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752696;
        bh=v2wN1Lorr9bWGmeULkeXI4D1aoWs1M0eeIraS7x8kDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lIZKJypPrUOQdIiXNSvH/rmJ9Yj27yheB9wFfRFsBj96XU8HyidXCzID76de4FP0n
         N5cXDNnzVuT+GgIaWMzEtZRqRyBtHK/0JcOTeicxXrEWJd7yX89i2CVglYIVSGnUGf
         3bfPaWlQbHUWJFW5p8IZlJg58BDaZIbZVAdDaoOI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 074/109] ALSA: usb-audio: add quirk for MacroSilicon MS2109
Date:   Tue, 14 Jul 2020 20:44:17 +0200
Message-Id: <20200714184109.091151128@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
References: <20200714184105.507384017@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hector Martin <marcan@marcan.st>

commit e337bf19f6af38d5c3fa6d06cd594e0f890ca1ac upstream.

These devices claim to be 96kHz mono, but actually are 48kHz stereo with
swapped channels and unaligned transfers.

Cc: stable@vger.kernel.org
Signed-off-by: Hector Martin <marcan@marcan.st>
Link: https://lore.kernel.org/r/20200702071433.237843-1-marcan@marcan.st
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/quirks-table.h |   52 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3695,4 +3695,56 @@ ALC1220_VB_DESKTOP(0x26ce, 0x0a01), /* A
 	}
 },
 
+/*
+ * MacroSilicon MS2109 based HDMI capture cards
+ *
+ * These claim 96kHz 1ch in the descriptors, but are actually 48kHz 2ch.
+ * They also need QUIRK_AUDIO_ALIGN_TRANSFER, which makes one wonder if
+ * they pretend to be 96kHz mono as a workaround for stereo being broken
+ * by that...
+ *
+ * They also have swapped L-R channels, but that's for userspace to deal
+ * with.
+ */
+{
+	USB_DEVICE(0x534d, 0x2109),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "MacroSilicon",
+		.product_name = "MS2109",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = &(const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_ALIGN_TRANSFER,
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_STANDARD_MIXER,
+			},
+			{
+				.ifnum = 3,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S16_LE,
+					.channels = 2,
+					.iface = 3,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = 0,
+					.endpoint = 0x82,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_ASYNC,
+					.rates = SNDRV_PCM_RATE_CONTINUOUS,
+					.rate_min = 48000,
+					.rate_max = 48000,
+				}
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
+
 #undef USB_DEVICE_VENDOR_SPEC


