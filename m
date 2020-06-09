Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925F0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A6E2067B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591727091;
	bh=mvN444EYeBC8fFHTPY2yR4t38No63yDfTSFm+X7LJlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nh7ZDMJIAWqQUW6nZqy12UlmIlrCIq1suv87dEMnPswPnHYSLyxZ4jiAYb6eAc3Ux
	 YQnK5h84y/WqLlFTK9YzKU8Ep/Sa2qRk2V3mPcVZqMQN6r3ECBSnnDKwTw1HdY0Nr0
	 O4m1TBjoZ6THwrR7NOnTP2XaZt3zy4YvGEBYA+7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389001AbgFISYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:24:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732018AbgFIRqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:46:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44F4F20801;
        Tue,  9 Jun 2020 17:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724809;
        bh=mvN444EYeBC8fFHTPY2yR4t38No63yDfTSFm+X7LJlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dI3XWeqAQumcRqidexR9BFpGHseIgF93b1fSKXhRNBL08c23EimXMUBoczacf6N7y
         OTufZU3/1S94XGz858/mxhQdDbL01rMWn64RJ9p4dLaJhZWnhCRaNPsFGUcfK4NjA/
         rKm/dkTmNCu6jQr1D4pSxT3ojEWlB+WrWVLOd/mk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 26/36] USB: serial: option: add Telit LE910C1-EUX compositions
Date:   Tue,  9 Jun 2020 19:44:26 +0200
Message-Id: <20200609173934.951285925@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609173933.288044334@linuxfoundation.org>
References: <20200609173933.288044334@linuxfoundation.org>
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
@@ -1146,6 +1146,10 @@ static const struct usb_device_id option
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


