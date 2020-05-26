Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA72C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B6020B80
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520378;
	bh=jfyz9oqs6eHVNMoOj+ndiLbYCz73HTyt7i3ncvxZRBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rVYA2hCDPsBlAp7X424zoKSKCuUokJUIL5CbAMIIcCBFlrnxqCm598s3VM8boOP9L
	 tSQIOXAOT0rVQ9qgE53dFYHZ91szEUoL1vz/uO2Q5OWHfwQjxxhaRm39zk1/0gxNWS
	 QQ0zqPerEtO8VBXwgaDnOX8C4tS9DxV8LvEUGryI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404171AbgEZTM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:12:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392133AbgEZTMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:12:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3B62208A7;
        Tue, 26 May 2020 19:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520372;
        bh=jfyz9oqs6eHVNMoOj+ndiLbYCz73HTyt7i3ncvxZRBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K8knQnHPPlx91aTgGBYuTouyZFgMwA44QQTBMceAWCeVA9CJEBgWtNrPHvWp5f1h3
         rAM/qa8SZ7RtZhTrzY31kK6i3JtMpDSYXcZoq8RqKd9N47EDSuSQKDWi9qci6u/qhs
         sZJyTAM3Q32L14/mps3M5DqURDEWDO+cWgUhR7hw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Fabian Schindlatz <fabian.schindlatz@fau.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 026/126] HID: logitech: Add support for Logitech G11 extra keys
Date:   Tue, 26 May 2020 20:52:43 +0200
Message-Id: <20200526183939.926776792@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabian Schindlatz <fabian.schindlatz@fau.de>

[ Upstream commit b1bd0f75288f60e8d142a1b3e979ed0192c04931 ]

The Logitech G11 keyboard is a cheap variant of the G15 without the LCD
screen. It uses the same layout for its extra and macro keys (G1 - G18,
M1-M3, MR) and - from the input subsystem's perspective - behaves just
like the G15, so we can treat it as such.

Tested it with my own keyboard.

Signed-off-by: Fabian Schindlatz <fabian.schindlatz@fau.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-lg-g15.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 309510a72c5e..40697af0ca35 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -756,6 +756,7 @@
 #define USB_DEVICE_ID_LOGITECH_RUMBLEPAD2	0xc218
 #define USB_DEVICE_ID_LOGITECH_RUMBLEPAD2_2	0xc219
 #define USB_DEVICE_ID_LOGITECH_G15_LCD		0xc222
+#define USB_DEVICE_ID_LOGITECH_G11		0xc225
 #define USB_DEVICE_ID_LOGITECH_G15_V2_LCD	0xc227
 #define USB_DEVICE_ID_LOGITECH_G510		0xc22d
 #define USB_DEVICE_ID_LOGITECH_G510_USB_AUDIO	0xc22e
diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
index ad4b5412a9f4..ef0cbcd7540d 100644
--- a/drivers/hid/hid-lg-g15.c
+++ b/drivers/hid/hid-lg-g15.c
@@ -872,6 +872,10 @@ error_hw_stop:
 }
 
 static const struct hid_device_id lg_g15_devices[] = {
+	/* The G11 is a G15 without the LCD, treat it as a G15 */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
+		USB_DEVICE_ID_LOGITECH_G11),
+		.driver_data = LG_G15 },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
 			 USB_DEVICE_ID_LOGITECH_G15_LCD),
 		.driver_data = LG_G15 },
-- 
2.25.1



