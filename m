Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3451C2BA13
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7377C20772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759242;
	bh=vd9KQm5lJKIzHUK1AZOmpGTXDgVDFpKR0xg/ZSIl5jY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lCb5tcso9+fXAQ0eD3IDRfdl0TSXfhd5F5gyY6j4omlr9bsTs4Jvdn9XpRWwIi8gB
	 LfA+P4YFsWLvN9Sx+yWFSBZjVcfzMHGwUTvZeMVvgO+bRu/uVQhdT5hERX6sv/jBpi
	 3A/g7EVuFzLAvQt9pXtAU3UUkxCZp3JOgYY3jkhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389347AbgDAQkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389331AbgDAQkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:40:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17C6120719;
        Wed,  1 Apr 2020 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759235;
        bh=vd9KQm5lJKIzHUK1AZOmpGTXDgVDFpKR0xg/ZSIl5jY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fTuYIeRidxyj+XC142pu/FSbjOROt5AkUcI0Fu+e8677sYhFQ14xcHsQnL9dD7K5f
         3OOwmKMzDk/ZjPTmgFV+QRu6tqmQ8suDAO3IT5wREP8AQkDK+35zCdXOj4Rc3AyoLd
         mkEPq6XnI0Tif1kQK8hCgV3YnMhOBezHmZ1ME9yk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 017/148] USB: serial: option: add ME910G1 ECM composition 0x110b
Date:   Wed,  1 Apr 2020 18:16:49 +0200
Message-Id: <20200401161553.986490775@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
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
@@ -1186,6 +1186,8 @@ static const struct usb_device_id option
 	  .driver_info = NCTRL(0) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x110a, 0xff),	/* Telit ME910G1 */
 	  .driver_info = NCTRL(0) | RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x110b, 0xff),	/* Telit ME910G1 (ECM) */
+	  .driver_info = NCTRL(0) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE910),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE910_USBCFG4),


