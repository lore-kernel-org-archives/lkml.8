Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78995C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D3AB23117
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073901;
	bh=5j1N6fY856atSdd1yo4YTw/tK7vOcoJ8AervVVeA2Bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TJ0dAJuLAozCxHCm+1BrRpPXDiz6ad1c20Qaz6qlESeSuLQF11mhanUW6Doz6isXZ
	 zcuZyp1mwTCwmOh4Q6k6WD8cHxyTuSq0tRPoCLSYCa4SpOcVwW7M7QMq4Gm7bKkjea
	 SAVGV+MvkS9m0X4ga6oU7xXXOcYrwAjS7ycfAqaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgHJPiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:38:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728617AbgHJP0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:26:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA29220772;
        Mon, 10 Aug 2020 15:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073163;
        bh=5j1N6fY856atSdd1yo4YTw/tK7vOcoJ8AervVVeA2Bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=07modz3Ig5gYPc0yZkpZ6HUVf1R4qPGNdxT9x4eIypTA/r78mRxDnKQ2cH2QtAz90
         Kpxcf7x1oZH4rfNbx6VVUcwZAtu8SmYkg33pix4sIGa9EeHPsS1S3h75/WXom7VJfH
         9vS8/0fvpbAqGwihQyEOhgFDImm7s32nyh1DJLKs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erik Ekman <erik@kryo.se>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.4 01/67] USB: serial: qcserial: add EM7305 QDL product ID
Date:   Mon, 10 Aug 2020 17:20:48 +0200
Message-Id: <20200810151809.514561300@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151809.438685785@linuxfoundation.org>
References: <20200810151809.438685785@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erik Ekman <erik@kryo.se>

commit d2a4309c1ab6df424b2239fe2920d6f26f808d17 upstream.

When running qmi-firmware-update on the Sierra Wireless EM7305 in a Toshiba
laptop, it changed product ID to 0x9062 when entering QDL mode:

usb 2-4: new high-speed USB device number 78 using xhci_hcd
usb 2-4: New USB device found, idVendor=1199, idProduct=9062, bcdDevice= 0.00
usb 2-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-4: Product: EM7305
usb 2-4: Manufacturer: Sierra Wireless, Incorporated

The upgrade could complete after running
 # echo 1199 9062 > /sys/bus/usb-serial/drivers/qcserial/new_id

qcserial 2-4:1.0: Qualcomm USB modem converter detected
usb 2-4: Qualcomm USB modem converter now attached to ttyUSB0

Signed-off-by: Erik Ekman <erik@kryo.se>
Link: https://lore.kernel.org/r/20200717185118.3640219-1-erik@kryo.se
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/qcserial.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -155,6 +155,7 @@ static const struct usb_device_id id_tab
 	{DEVICE_SWI(0x1199, 0x9056)},	/* Sierra Wireless Modem */
 	{DEVICE_SWI(0x1199, 0x9060)},	/* Sierra Wireless Modem */
 	{DEVICE_SWI(0x1199, 0x9061)},	/* Sierra Wireless Modem */
+	{DEVICE_SWI(0x1199, 0x9062)},	/* Sierra Wireless EM7305 QDL */
 	{DEVICE_SWI(0x1199, 0x9063)},	/* Sierra Wireless EM7305 */
 	{DEVICE_SWI(0x1199, 0x9070)},	/* Sierra Wireless MC74xx */
 	{DEVICE_SWI(0x1199, 0x9071)},	/* Sierra Wireless MC74xx */


