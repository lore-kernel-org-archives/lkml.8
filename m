Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A75C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01419207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624448;
	bh=1N3415oeDWlqK8Aql3s8A4K4Il5a0l+sZLnrxoZ2+qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fi9oD62KwPy+OrKHS7v/cA6FIG5qNPFDl6Kbkqc+RVKxxxhMAEpWyusr3UIehQOP+
	 YA1V+mgc1+g0gNb3izBQOd2zuv4hDpgkxUUh8WelqjpJ4t9qyWtv7/op/zGPSzcQKe
	 QsXB58Q94GlmeEZ2kF9Tj+BB2rLj6kmIU9sbKKqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbgCSN10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:27:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730886AbgCSN1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:27:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E3FD207FC;
        Thu, 19 Mar 2020 13:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584624443;
        bh=1N3415oeDWlqK8Aql3s8A4K4Il5a0l+sZLnrxoZ2+qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HHYwLJDX1LVErj3hEpvs3TbkRc8ihWzHqSp/N649v4og0BWhz6FXj39r59H1ReHHH
         PwoFu1SDTGGRkeUvBVRP4rl0xIQUXwCBEd2igUbGXaoLHjwgpbmIL57p9WbCoAHD/b
         y307uoByRJxelgdn9Hxq3tTxwiLZzU0HwRzHlAWA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Tsung Hsieh <chentsung@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 5.5 62/65] HID: google: add moonball USB id
Date:   Thu, 19 Mar 2020 14:04:44 +0100
Message-Id: <20200319123945.815722870@linuxfoundation.org>
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

From: Chen-Tsung Hsieh <chentsung@chromium.org>

commit 58322a1590fc189a8e1e349d309637d4a4942840 upstream.

Add 1 additional hammer-like device.

Signed-off-by: Chen-Tsung Hsieh <chentsung@chromium.org>
Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-google-hammer.c |    2 ++
 drivers/hid/hid-ids.h           |    1 +
 2 files changed, 3 insertions(+)

--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -533,6 +533,8 @@ static const struct hid_device_id hammer
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_MASTERBALL) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_MOONBALL) },
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STAFF) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_WAND) },
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -478,6 +478,7 @@
 #define USB_DEVICE_ID_GOOGLE_WHISKERS	0x5030
 #define USB_DEVICE_ID_GOOGLE_MASTERBALL	0x503c
 #define USB_DEVICE_ID_GOOGLE_MAGNEMITE	0x503d
+#define USB_DEVICE_ID_GOOGLE_MOONBALL	0x5044
 
 #define USB_VENDOR_ID_GOTOP		0x08f2
 #define USB_DEVICE_ID_SUPER_Q2		0x007f


