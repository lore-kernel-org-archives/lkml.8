Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22293C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1BF205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699117;
	bh=uG2XbXMoGZzx8H4q1N55KBac6z4u0PS3eMFKnphQBH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LG9aG3nku0UMb54MNxVRilqJBebJsQ3WZeU4YL+sbxZOWc0AYdzoc4Odib6N5Af3G
	 8PDFw+Q3bDpjSh+Vku+gS/MQ6KIrwBLa/2m6MubFuWESlpR8vkxr1wMThker/Ikf2O
	 RiTzOQh5miTWfNmP2LHAx2Wnx9QqhBbWT5fg4kBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgAVNSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:18:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:34256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729340AbgAVNSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:18:34 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 151A5205F4;
        Wed, 22 Jan 2020 13:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699113;
        bh=uG2XbXMoGZzx8H4q1N55KBac6z4u0PS3eMFKnphQBH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rOc30CbTjq/kwum91gK/wFli1yzyBWNKTLomQnfEpmypLrCCwx8lPMC4TDhnkK6j/
         pLNMhZ/YcoEjahGXBOpWw8ToTbXSzigcq7hVqb2E79OpP719c59TB04CQBx6Dy/cmX
         fGEvN2DOhSVaZkgadikU0jSyIGe0RIttU76Ja4QI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Jansen <martin.jansen@opticon.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.4 045/222] USB: serial: opticon: fix control-message timeouts
Date:   Wed, 22 Jan 2020 10:27:11 +0100
Message-Id: <20200122092836.784725349@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 5e28055f340275a8616eee88ef19186631b4d136 upstream.

The driver was issuing synchronous uninterruptible control requests
without using a timeout. This could lead to the driver hanging
on open() or tiocmset() due to a malfunctioning (or malicious) device
until the device is physically disconnected.

The USB upper limit of five seconds per request should be more than
enough.

Fixes: 309a057932ab ("USB: opticon: add rts and cts support")
Cc: stable <stable@vger.kernel.org>     # 2.6.39
Cc: Martin Jansen <martin.jansen@opticon.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/opticon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/serial/opticon.c
+++ b/drivers/usb/serial/opticon.c
@@ -113,7 +113,7 @@ static int send_control_msg(struct usb_s
 	retval = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
 				requesttype,
 				USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
-				0, 0, buffer, 1, 0);
+				0, 0, buffer, 1, USB_CTRL_SET_TIMEOUT);
 	kfree(buffer);
 
 	if (retval < 0)


