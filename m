Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1418BC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D709B208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624450;
	bh=fZ4m9eC8ZORxTJx+xJn9/9GooWKhh4XXJWDTYVajMAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GNyam00nmNoTtlVLuXF2rp58BZuCdsyE6bs4QubwoRj1zYreeiRNRquM2HObqNg+f
	 K0OLWh8D0xzge67Ec56rwvQONLXaOict/GMwZcM5VJSjV7KgDBJTeZweMoiPM9vPLI
	 5b44j8rWKWe5xKlaXOrtrdZylVSRAjYQVlUaBgh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbgCSN13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:27:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730892AbgCSN10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:27:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B450A208D6;
        Thu, 19 Mar 2020 13:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584624446;
        bh=fZ4m9eC8ZORxTJx+xJn9/9GooWKhh4XXJWDTYVajMAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LjvRK857leEWOy/FLDvVayfLLGiNSmhr9A6AT+Ve6HDiejfYZxTeZ2RvpNJl8SVlY
         ATj7AUbSw+JtsjlfNa8scZdZ+K0SjQ4Fi3AQvXogCLEVWzJ1qSMxBSp8W4fORMquHU
         Kp3tBSCcb65wXMjWiHTusUeWjutXHzFFjj2T9EAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Fischetti <tony.fischetti@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 5.5 63/65] HID: add ALWAYS_POLL quirk to lenovo pixart mouse
Date:   Thu, 19 Mar 2020 14:04:45 +0100
Message-Id: <20200319123946.139157815@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123926.466988514@linuxfoundation.org>
References: <20200319123926.466988514@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Fischetti <tony.fischetti@gmail.com>

commit 819d578d51d0ce73f06e35d69395ef55cd683a74 upstream.

A lenovo pixart mouse (17ef:608d) is afflicted common the the malfunction
where it disconnects and reconnects every minute--each time incrementing
the device number. This patch adds the device id of the device and
specifies that it needs the HID_QUIRK_ALWAYS_POLL quirk in order to
work properly.

Signed-off-by: Tony Fischetti <tony.fischetti@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-ids.h    |    1 +
 drivers/hid/hid-quirks.c |    1 +
 2 files changed, 2 insertions(+)

--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -727,6 +727,7 @@
 #define USB_DEVICE_ID_LENOVO_X1_COVER	0x6085
 #define USB_DEVICE_ID_LENOVO_X1_TAB	0x60a3
 #define USB_DEVICE_ID_LENOVO_X1_TAB3	0x60b5
+#define USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_608D	0x608d
 
 #define USB_VENDOR_ID_LG		0x1fd2
 #define USB_DEVICE_ID_LG_MULTITOUCH	0x0064
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -103,6 +103,7 @@ static const struct hid_device_id hid_qu
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_PENSKETCH_M912), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M406XE), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE_ID2), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_608D), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_C007), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_C077), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_KEYBOARD_G710_PLUS), HID_QUIRK_NOGET },


