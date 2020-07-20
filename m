Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19F4C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C90B22D01
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259974;
	bh=ko0uM49NweAZFWVgp1NkQ10g5w/KsTKdbttdn0rNZKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0w67sHSbLxPki7WH1IcCiEEOAoLwEkS2jbZtObIYoXzb5Dmv4+yz6/Fg5OELqEdHj
	 rfp+WfSOkmF4ewbvskE42yQzOM5UafzstIB+zDilbwSdxabTvKcAXlcPfBzZv8k77c
	 PzTB5r/UFKN+1ApYttwOygPrryYxLFfCV1Ismc3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbgGTPqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:46:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730631AbgGTPqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:46:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F125722CB3;
        Mon, 20 Jul 2020 15:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259969;
        bh=ko0uM49NweAZFWVgp1NkQ10g5w/KsTKdbttdn0rNZKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u/jt2koloWUOkcgakjwhG+haa+42SYiO1EO/7z/s5bmlhmiR1bIGUITFe2BcQRC9V
         ujYicSA4MPD+nfsY4l2X1GMKV1TdI002+nweVC6nIfEBNskRgmUshHJ9OTpqkMJs4x
         4nKSAgBorJJGYaxE0TqyoezKamAgmpTveI4qJEIw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 028/125] ALSA: usb-audio: add quirk for MacroSilicon MS2109
Date:   Mon, 20 Jul 2020 17:36:07 +0200
Message-Id: <20200720152804.344970506@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152802.929969555@linuxfoundation.org>
References: <20200720152802.929969555@linuxfoundation.org>
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
@@ -3323,4 +3323,56 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge
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


