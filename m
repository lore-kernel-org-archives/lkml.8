Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BDCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AB3520675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593461423;
	bh=agRQypckGCYSkFlC3kExSSvrt4mjZ/93NTQyMsU16ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IEZqK65Mqeld9fAdEARLoovqEcSPaxfaPl4R42kCgGzSSaTlbv7bCqUImSbd7r+CM
	 9iio/gzVoXmigg8jhSoZ/gYQR6aHNn2yOx1b49X/nBGmC7ok8AOM0JX0TfMvpYNLLI
	 Ge/YURKG8BXAoy3yg3DZtDjX35G37RZeSA5JxECI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgF2UKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:10:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732914AbgF2TaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CEBE2522A;
        Mon, 29 Jun 2020 15:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444945;
        bh=agRQypckGCYSkFlC3kExSSvrt4mjZ/93NTQyMsU16ws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P9CV97CnbZNLAO08S20hD1eTh1lxkz5NV0HGPGF8iJMLgM0w7T6twM7sYioLrfu5c
         6/WGRDz+5eTkaMuxwqbt7JClzSU7ItLnx26iMvcvdDi70yiVA6VabiKs0+ZdAOGIra
         kkkvYffvuup8ck5NqBQDR1TPXReiHsxtqCitOzt8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Tomasz=20Meresi=C5=84ski?= <tomasz@meresinski.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.19 043/131] usb: add USB_QUIRK_DELAY_INIT for Logitech C922
Date:   Mon, 29 Jun 2020 11:33:34 -0400
Message-Id: <20200629153502.2494656-44-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629153502.2494656-1-sashal@kernel.org>
References: <20200629153502.2494656-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.131-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.131-rc1
X-KernelTest-Deadline: 2020-07-01T15:34+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Meresiński <tomasz@meresinski.eu>

commit 5d8021923e8a8cc37a421a64e27c7221f0fee33c upstream.

The Logitech C922, just like other Logitech webcams,
needs the USB_QUIRK_DELAY_INIT or it will randomly
not respond after device connection

Signed-off-by: Tomasz Meresiński <tomasz@meresinski.eu>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200603203347.7792-1-tomasz@meresinski.eu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/quirks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 3e8efe759c3e6..e0b77674869ce 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -218,11 +218,12 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* Logitech HD Webcam C270 */
 	{ USB_DEVICE(0x046d, 0x0825), .driver_info = USB_QUIRK_RESET_RESUME },
 
-	/* Logitech HD Pro Webcams C920, C920-C, C925e and C930e */
+	/* Logitech HD Pro Webcams C920, C920-C, C922, C925e and C930e */
 	{ USB_DEVICE(0x046d, 0x082d), .driver_info = USB_QUIRK_DELAY_INIT },
 	{ USB_DEVICE(0x046d, 0x0841), .driver_info = USB_QUIRK_DELAY_INIT },
 	{ USB_DEVICE(0x046d, 0x0843), .driver_info = USB_QUIRK_DELAY_INIT },
 	{ USB_DEVICE(0x046d, 0x085b), .driver_info = USB_QUIRK_DELAY_INIT },
+	{ USB_DEVICE(0x046d, 0x085c), .driver_info = USB_QUIRK_DELAY_INIT },
 
 	/* Logitech ConferenceCam CC3000e */
 	{ USB_DEVICE(0x046d, 0x0847), .driver_info = USB_QUIRK_DELAY_INIT },
-- 
2.25.1

