Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C28C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78B13214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587049188;
	bh=RlPp1iaNAIZtXV/7DCpgYxXxtz24O5yn7VLRupqjAtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KNxM3DrNjF//1Wz+VKr9G9CcLOn7oUaVyp4H9Y1RfXbjdhbmb42EFqxRePv4CopHt
	 FnB1qjoSR4a4xztV86FllalBPxB3LZevePb+Rip6MlE5nfUfnEBvnNlVqSf9SBqWcB
	 /rMdq7C6gfePU2niEJ2FGbkQPdMZMMTo6RlgHi8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438799AbgDPO7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:59:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898866AbgDPNyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:54:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A8F120732;
        Thu, 16 Apr 2020 13:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045280;
        bh=RlPp1iaNAIZtXV/7DCpgYxXxtz24O5yn7VLRupqjAtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JKCQjvfk1GQRueUJiR/LvcbgYidSenVFPHxqOE24zBkt2laJlQxfdeG4Rf71MzUO6
         tvJxnijcdcVi8KYI7XNrRzmKFDrHLYkRXfJGeBVdgCe6lZnwXT8bEAVp9CU7f9FgGg
         qcV4xxR4NGRvig5tuUpGvgHIo6jfLh1LzIbA2xbI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thinh Nguyen <thinhn@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 5.6 071/254] usb: gadget: composite: Inform controller driver of self-powered
Date:   Thu, 16 Apr 2020 15:22:40 +0200
Message-Id: <20200416131334.752534395@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit 5e5caf4fa8d3039140b4548b6ab23dd17fce9b2c upstream.

Different configuration/condition may draw different power. Inform the
controller driver of the change so it can respond properly (e.g.
GET_STATUS request). This fixes an issue with setting MaxPower from
configfs. The composite driver doesn't check this value when setting
self-powered.

Cc: stable@vger.kernel.org
Fixes: 88af8bbe4ef7 ("usb: gadget: the start of the configfs interface")
Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/composite.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -861,6 +861,11 @@ static int set_config(struct usb_composi
 	else
 		power = min(power, 900U);
 done:
+	if (power <= USB_SELF_POWER_VBUS_MAX_DRAW)
+		usb_gadget_set_selfpowered(gadget);
+	else
+		usb_gadget_clear_selfpowered(gadget);
+
 	usb_gadget_vbus_draw(gadget, power);
 	if (result >= 0 && cdev->delayed_status)
 		result = USB_GADGET_DELAYED_STATUS;
@@ -2279,6 +2284,7 @@ void composite_suspend(struct usb_gadget
 
 	cdev->suspended = 1;
 
+	usb_gadget_set_selfpowered(gadget);
 	usb_gadget_vbus_draw(gadget, 2);
 }
 
@@ -2307,6 +2313,9 @@ void composite_resume(struct usb_gadget
 		else
 			maxpower = min(maxpower, 900U);
 
+		if (maxpower > USB_SELF_POWER_VBUS_MAX_DRAW)
+			usb_gadget_clear_selfpowered(gadget);
+
 		usb_gadget_vbus_draw(gadget, maxpower);
 	}
 


