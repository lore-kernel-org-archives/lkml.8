Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9E1C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFB7208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055558;
	bh=GWy6tmGEEcVt6nH/teAPu97o9qVvgBZbqgNUofs01Tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eJifsX46VkEJdu5KTgYnn1Uwm0Zbno4+P6MD4CC/uiawlhM0TbvikE58+njOyWg8Z
	 eviVzvvwBSnGlqtCVLgz7URq1gAZaJ/UbOyzFIU2k2Xh0J2xH2IgjnmsYhvOpLPcWZ
	 LcBcX2GRvjJ1LQVxD4C8LWxgU0eRhpaUKgCwL0a8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgCXNMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:12:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbgCXNMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:12:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E694720775;
        Tue, 24 Mar 2020 13:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055554;
        bh=GWy6tmGEEcVt6nH/teAPu97o9qVvgBZbqgNUofs01Tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GNpNRK+K6LhMLRtYegW3sFgamdSzrUoKlZMsJ+ZQ1797/UNo6OaW3k5ybALbsB+AG
         LGhNaLD+2Hd24XcxMXT/OGzvF4RPTQ3wz1QRe23zCnyPuk/ICbAHt89CILvT3ILgDy
         4n3XkGEq+uz/d8f7PC3BFs7l593bP8Q4AyJaMkrk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 22/65] USB: serial: option: add ME910G1 ECM composition 0x110b
Date:   Tue, 24 Mar 2020 14:10:43 +0100
Message-Id: <20200324130759.850045670@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130756.679112147@linuxfoundation.org>
References: <20200324130756.679112147@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Palmas <dnlplm@gmail.com>

commit 8e852a7953be2a6ee371449f7257fe15ace6a1fc upstream.

Add ME910G1 ECM composition 0x110b: tty, tty, tty, ecm

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Link: https://lore.kernel.org/r/20200304104310.2938-1-dnlplm@gmail.com
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1183,6 +1183,8 @@ static const struct usb_device_id option
 	  .driver_info = NCTRL(0) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x110a, 0xff),	/* Telit ME910G1 */
 	  .driver_info = NCTRL(0) | RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x110b, 0xff),	/* Telit ME910G1 (ECM) */
+	  .driver_info = NCTRL(0) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE910),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE910_USBCFG4),


