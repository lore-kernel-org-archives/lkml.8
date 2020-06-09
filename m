Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1070EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D082520774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591725335;
	bh=Faj6ySPN4NhaH1lHmRfYbHVD4GDrDtfBMnqzZGepr5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=krkNeACzaGhn1VGQa2i4SkPsr7WWwCbC1wVNLdPmhcMvaFJ2pg5mmpQXGS4rkYyjf
	 Badf7I9u/XbqsU6OyJQJSEfysar6uHcNJZ58Y4kF8CcVrUuVu0sAtlAl+ApqYB+vDj
	 aDzhQFRiwy/GiIQ0Rm4VQQ9wx62z5cxkBI5iHzDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733262AbgFIRze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731587AbgFIRxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:53:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7437D20734;
        Tue,  9 Jun 2020 17:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591725225;
        bh=Faj6ySPN4NhaH1lHmRfYbHVD4GDrDtfBMnqzZGepr5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EUKg0+dsEOotLyvBZ9nr+9B51XXOIkqklQqKWUGdO75TR2nCuMctRKkJqyyMAGhZB
         Q2j5PAUmob5ApTrOA0a9mPqJqt+0sUqUE2hkpQ71JR+NsjsbQNDIg6uqCg4dnExVeD
         oAeDjeVa1jQBAxinRNPG8nzk8P1fuCNJKlDhHp5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.6 20/41] USB: serial: option: add Telit LE910C1-EUX compositions
Date:   Tue,  9 Jun 2020 19:45:22 +0200
Message-Id: <20200609174114.065212758@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174112.129412236@linuxfoundation.org>
References: <20200609174112.129412236@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Palmas <dnlplm@gmail.com>

commit 399ad9477c523f721f8e51d4f824bdf7267f120c upstream.

Add Telit LE910C1-EUX compositions:

	0x1031: tty, tty, tty, rmnet
	0x1033: tty, tty, tty, ecm

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Link: https://lore.kernel.org/r/20200525211106.27338-1-dnlplm@gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1157,6 +1157,10 @@ static const struct usb_device_id option
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_CC864_SINGLE) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_DE910_DUAL) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_UE910_V2) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1031, 0xff),	/* Telit LE910C1-EUX */
+	 .driver_info = NCTRL(0) | RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1033, 0xff),	/* Telit LE910C1-EUX (ECM) */
+	 .driver_info = NCTRL(0) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE922_USBCFG0),
 	  .driver_info = RSVD(0) | RSVD(1) | NCTRL(2) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE922_USBCFG1),


