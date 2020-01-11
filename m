Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873C6C33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EA82077C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578736709;
	bh=yxO19RkpbpT6xRpMIbMXZhoy5cZeZcVraSfibN4vxIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OcnE19oqHAd4YRQT228BGo/UeB+AnTp3GK8KKyEbOmjWDNDBh/pwl92E1sZ7KJNFv
	 BuSSF9UV4sfgMbF9HLAZact9HEMr15cJ3n/hqbtUZoqqSb0OZSDzUhxi1twyoNk15o
	 mRq+450Gqbvs08gMp+rXXOGfJy9SszdvTN69gfjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbgAKJ62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 04:58:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:51718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729051AbgAKJ62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 04:58:28 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D29AC2077C;
        Sat, 11 Jan 2020 09:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578736707;
        bh=yxO19RkpbpT6xRpMIbMXZhoy5cZeZcVraSfibN4vxIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sg2dfAlM/ZoVcFHTHdnLUQQs7rrt354aMc1KFnAkIudVmhKSrLSnFXeT5CwPe1sF8
         qeL9Y981TkzR0iWkXL4diwRGvtknzOqhdVjUWD18kGp57OU+hOsijUlt22FyNy67S7
         15v5Y/A+hFtBwqzW48PdvRz9vxDWoYPSn3p2HQZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 59/59] USB: serial: option: add Telit ME910G1 0x110a composition
Date:   Sat, 11 Jan 2020 10:50:08 +0100
Message-Id: <20200111094854.319738883@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094835.417654274@linuxfoundation.org>
References: <20200111094835.417654274@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Palmas <dnlplm@gmail.com>

commit 0d3010fa442429f8780976758719af05592ff19f upstream.

This patch adds the following Telit ME910G1 composition:

0x110a: tty, tty, tty, rmnet

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1167,6 +1167,8 @@ static const struct usb_device_id option
 	  .driver_info = NCTRL(0) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1102, 0xff),	/* Telit ME910 (ECM) */
 	  .driver_info = NCTRL(0) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x110a, 0xff),	/* Telit ME910G1 */
+	  .driver_info = NCTRL(0) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE910),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE910_USBCFG4),


