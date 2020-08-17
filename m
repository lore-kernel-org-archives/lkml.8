Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695A4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FDFE204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597689842;
	bh=Kp8YB+cckSSzEOMiviR23Op7YTUgP0UQ2ytfzormX48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uTCfR9njLbA3L+y7QOdTq6C72oRMwxxom/K4BF9zR1gAVepAjRuNAIWHp+utKRIgp
	 chmGu87MB1PYCtaIgwyR2yYbtV5p/3Y5fG91W7qOEVfDdEEG09UN9EujGA+7M1Jhnt
	 YFQvk0dCZ0jU71iCWpKpwpNdW/qCc8sR1NxemU/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403773AbgHQSn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:43:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388079AbgHQP4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:56:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33629206FA;
        Mon, 17 Aug 2020 15:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679791;
        bh=Kp8YB+cckSSzEOMiviR23Op7YTUgP0UQ2ytfzormX48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ANszUnQRwa0KcNyby+37RwxC5L75vJudGOxVgnSSm04Gp+TKSdE2KUVQB+ot1czxZ
         pofe+lln4OYfA6bk44PFyOtihg1MzQnIMRWWYVjNcx5MLhqAaKIOIcvlXIlAQQC48r
         2XBp59TwOXxtmbXX4JaHFxy1oeR3Un2oEq+ew3GE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.7 336/393] ALSA: usb-audio: fix overeager device match for MacroSilicon MS2109
Date:   Mon, 17 Aug 2020 17:16:26 +0200
Message-Id: <20200817143835.896367156@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hector Martin <marcan@marcan.st>

commit 14a720dc1f5332f3bdf30a23a3bc549e81be974c upstream.

Matching by device matches all interfaces, which breaks the video/HID
portions of the device depending on module load order.

Fixes: e337bf19f6af ("ALSA: usb-audio: add quirk for MacroSilicon MS2109")
Cc: stable@vger.kernel.org
Signed-off-by: Hector Martin <marcan@marcan.st>
Link: https://lore.kernel.org/r/20200810045319.128745-1-marcan@marcan.st
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/quirks-table.h |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3623,7 +3623,13 @@ ALC1220_VB_DESKTOP(0x26ce, 0x0a01), /* A
  * with.
  */
 {
-	USB_DEVICE(0x534d, 0x2109),
+	.match_flags = USB_DEVICE_ID_MATCH_DEVICE |
+		       USB_DEVICE_ID_MATCH_INT_CLASS |
+		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+	.idVendor = 0x534d,
+	.idProduct = 0x2109,
+	.bInterfaceClass = USB_CLASS_AUDIO,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL,
 	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
 		.vendor_name = "MacroSilicon",
 		.product_name = "MS2109",


