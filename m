Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E360EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFDCD207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597924407;
	bh=mWsxCKDF2jQl76QZS+o3janKb4+GWIAq68VFC1YnKXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dlx8Ubprfh5CunsYf7aEZu9SBwa0XPR4URddfyFGc1VmtAoJqF+bIX/wejsegJwry
	 Mxpzd49chWgsAa5vXtOoU83xIpntpTPoX+teV07+Qi2rbJcG4NHsr0FgqZlsql0Vv6
	 ruJrThOS0+38M/gXhKZqLAO+pmjC5NuL+euQPTc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgHTLvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:51:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730589AbgHTKDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:03:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B70AA22BEA;
        Thu, 20 Aug 2020 10:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917783;
        bh=mWsxCKDF2jQl76QZS+o3janKb4+GWIAq68VFC1YnKXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NlVaKbLv6J79XiNf2AEaaXnYl99TTPU1cSn1VLsMSpYTPO3AOheYlwCKwE9vUdBi3
         cyWF0VVLnKucCkKq2rPpvXCojHnNWbp1NOtgtjMKprhWreSdmXF+PQkYz5+S1lrD4+
         pxPvAJ1haYi+U0uWqKD/WMCEviFDdAuWXiVO0vgM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 156/212] ALSA: usb-audio: fix overeager device match for MacroSilicon MS2109
Date:   Thu, 20 Aug 2020 11:22:09 +0200
Message-Id: <20200820091610.280373483@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
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
@@ -3335,7 +3335,13 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge
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


