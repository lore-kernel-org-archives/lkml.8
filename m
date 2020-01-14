Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5041AC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBEE20678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996964;
	bh=uUrA3Z+l+qzdLYCP9M082e6po9DoD8BgNE22uN5SkBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yDqoHkZgYqOwrcKXO6TNxPreZ+k11oIMotVytgAtYD2gr29GcLoCEpl7t0axIq9hd
	 neC2h/RlqRT7CpQW+Hyh5Uw05nbisyo5rnJwzuTK/xU+LN1HqV1ZS6UBtb/A9YDCDI
	 Q+b1It5lp9s2KRYeAbyAFWADaqN76SNdhcaky9SQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbgANKQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:16:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:43746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729122AbgANKKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:10:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34E9B24679;
        Tue, 14 Jan 2020 10:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996609;
        bh=uUrA3Z+l+qzdLYCP9M082e6po9DoD8BgNE22uN5SkBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SdyI6k/Khevxwprx1O3ayr1It7NU4cqKpDZdmB69JDwYdrS/oT7bHJbZg8X07Dbo0
         8qqCH5Wgn5XNKIISZTYpyphn7KB+YwqYnHPBshwjM3wNN4IgrMMhQbWVuPwQbfMncx
         KTC6NaWvh8J+cL8xML6HAqYT0tRl1T4ihxzFBx+I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.14 10/39] can: gs_usb: gs_usb_probe(): use descriptors of current altsetting
Date:   Tue, 14 Jan 2020 11:01:44 +0100
Message-Id: <20200114094341.436889131@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094336.210038037@linuxfoundation.org>
References: <20200114094336.210038037@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 2f361cd9474ab2c4ab9ac8db20faf81e66c6279b upstream.

Make sure to always use the descriptors of the current alternate setting
to avoid future issues when accessing fields that may differ between
settings.

Signed-off-by: Johan Hovold <johan@kernel.org>
Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/usb/gs_usb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -926,7 +926,7 @@ static int gs_usb_probe(struct usb_inter
 			     GS_USB_BREQ_HOST_FORMAT,
 			     USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
 			     1,
-			     intf->altsetting[0].desc.bInterfaceNumber,
+			     intf->cur_altsetting->desc.bInterfaceNumber,
 			     hconf,
 			     sizeof(*hconf),
 			     1000);
@@ -949,7 +949,7 @@ static int gs_usb_probe(struct usb_inter
 			     GS_USB_BREQ_DEVICE_CONFIG,
 			     USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
 			     1,
-			     intf->altsetting[0].desc.bInterfaceNumber,
+			     intf->cur_altsetting->desc.bInterfaceNumber,
 			     dconf,
 			     sizeof(*dconf),
 			     1000);


