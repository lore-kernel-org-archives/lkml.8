Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9009C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2EBC20658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597919188;
	bh=pn9CX2fSQaNdNVwtjc2KnFu4I6vNhAUujQBd4xjXgpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s0plg101MeeN34D2xHYIXZKnItvz1bMhZ8GPlBvYCoEer6NfuzNR0DJxNNwnoLYBJ
	 V/MXLGBohUmCT0SL7KgvBIPNvVv+aSE/N7MNd8wWjTsl8pPszRsnA8fNnSCKvBUYQD
	 DDgk5FTJaD2QcTvMGVQg6EoQQTAHk5hmK40JrriQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731762AbgHTK01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:26:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730480AbgHTKW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:22:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C3402078D;
        Thu, 20 Aug 2020 10:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918978;
        bh=pn9CX2fSQaNdNVwtjc2KnFu4I6vNhAUujQBd4xjXgpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Im7IIe53HcFOOxrdc+/NC00/49wnYpkEOM1m82RYd4J5Xqqp+jpp5SOczF6ZAf+Fn
         yQb5BYrAYwpXQcS/7i6FKLCubP7DEnPkjzlOTAwlOsdDSjpcZVUxxnaEhT6OjIJKQo
         trQFasrccVGV2T2N2lrB1Rz+ypRXqVn3qze7UX88=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 109/149] ALSA: usb-audio: add quirk for Pioneer DDJ-RB
Date:   Thu, 20 Aug 2020 11:23:06 +0200
Message-Id: <20200820092130.981920190@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hector Martin <marcan@marcan.st>

commit 6e8596172ee1cd46ec0bfd5adcf4ff86371478b6 upstream.

This is just another Pioneer device with fixed endpoints. Input is dummy
but used as feedback (it always returns silence).

Cc: stable@vger.kernel.org
Signed-off-by: Hector Martin <marcan@marcan.st>
Link: https://lore.kernel.org/r/20200810082502.225979-1-marcan@marcan.st
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/quirks-table.h |   56 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3380,5 +3380,61 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge
 		}
 	}
 },
+{
+	/*
+	 * PIONEER DJ DDJ-RB
+	 * PCM is 4 channels out, 2 dummy channels in @ 44.1 fixed
+	 * The feedback for the output is the dummy input.
+	 */
+	USB_DEVICE_VENDOR_SPEC(0x2b73, 0x000e),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 4,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x01,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC|
+						   USB_ENDPOINT_SYNC_ASYNC,
+					.rates = SNDRV_PCM_RATE_44100,
+					.rate_min = 44100,
+					.rate_max = 44100,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) { 44100 }
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
+					.endpoint = 0x82,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC|
+						 USB_ENDPOINT_SYNC_ASYNC|
+						 USB_ENDPOINT_USAGE_IMPLICIT_FB,
+					.rates = SNDRV_PCM_RATE_44100,
+					.rate_min = 44100,
+					.rate_max = 44100,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) { 44100 }
+				}
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
 
 #undef USB_DEVICE_VENDOR_SPEC


