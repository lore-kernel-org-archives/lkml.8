Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F29C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181E220842
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738885;
	bh=2ANPraND6LtqpzGN5B9VgWNulfpGmjENQvaFPvVenlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UU2FcKR7usjyPWsnH3Vxe1ySQcX3CXnGLzBM9SXDLLhPwB4TLq5F7tzUnrJmMMlYv
	 VwfxTNlpbWobQt8c1cSaScaKV45OQsTG32qVay6JhQWc2GeWvPuKMGVf7dLpHeO1Mm
	 KizfjgswASCVuugvpsERSQrNhHQ6BJE9h4rZ5GxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbgAKKeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:34:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:51204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728911AbgAKKem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:34:42 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 920A420880;
        Sat, 11 Jan 2020 10:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738881;
        bh=2ANPraND6LtqpzGN5B9VgWNulfpGmjENQvaFPvVenlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dn71KTncmnFEi1mf5Yq7dsUEhSl5+GVJUgZMHm0BHzho3csPLDY4aeslxqZecrRLK
         V28OG2NwjIYBbJQFaIu0/TeqXcIOJX02BZrdx84SCjfyECI5v5ukNjt9zx+ypuaynv
         qcPwoUFqwpKVa+UcyNR0Y7JkSmw2PXTfWf6P07dg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.4 164/165] USB: serial: option: add Telit ME910G1 0x110a composition
Date:   Sat, 11 Jan 2020 10:51:23 +0100
Message-Id: <20200111094943.763188870@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
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
@@ -1172,6 +1172,8 @@ static const struct usb_device_id option
 	  .driver_info = NCTRL(0) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1102, 0xff),	/* Telit ME910 (ECM) */
 	  .driver_info = NCTRL(0) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x110a, 0xff),	/* Telit ME910G1 */
+	  .driver_info = NCTRL(0) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE910),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE910_USBCFG4),


