Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4268BC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1010220656
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581610054;
	bh=rUcEVU3gBhjHwiVrzHGmMtspZDVT+yVIgYlJpo9qhi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=laNCattlx+Vz8aeWf+YuaEEXKXjB0bPucE/47G/L+y8vIP7Hg7pGGiWn1eOA5g0Ez
	 sPrkrcXX92iX7Sxo0eh24jWIYVWXboX5yF/+ZnzjOTw+OwTIgjO3AhYF5WeoszKnch
	 WTw65B0b5r3Do/mxf0dCqipX9HoAZfsF1PIEqrKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbgBMQHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:07:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbgBMPXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:23:21 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9839A246C0;
        Thu, 13 Feb 2020 15:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607400;
        bh=rUcEVU3gBhjHwiVrzHGmMtspZDVT+yVIgYlJpo9qhi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DjWUBDFJuXz77d7shfDt4/agI2E4GGI38anVM1Uc8tyht6Su/lgkXmKcM85DhSc6T
         SQ/XeW/WHqPpaQ/A6FQs0VRSpAQY5WdTs+2SB9PvgPyoY0hUGNt0SbEzKJrhZef4LE
         TqbnvV0D6BVK0aVjaNmIsNoKaVmmak3ghC4CcExA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        Lee Jones <lee.jones@linaro.org>,
        syzbot+48a2851be24583b864dc@syzkaller.appspotmail.com
Subject: [PATCH 4.9 016/116] mfd: dln2: More sanity checking for endpoints
Date:   Thu, 13 Feb 2020 07:19:20 -0800
Message-Id: <20200213151849.286887601@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151842.259660170@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit 2b8bd606b1e60ca28c765f69c1eedd7d2a2e9dca upstream.

It is not enough to check for the number of endpoints.
The types must also be correct.

Reported-and-tested-by: syzbot+48a2851be24583b864dc@syzkaller.appspotmail.com
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mfd/dln2.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -729,6 +729,8 @@ static int dln2_probe(struct usb_interfa
 		      const struct usb_device_id *usb_id)
 {
 	struct usb_host_interface *hostif = interface->cur_altsetting;
+	struct usb_endpoint_descriptor *epin;
+	struct usb_endpoint_descriptor *epout;
 	struct device *dev = &interface->dev;
 	struct dln2_dev *dln2;
 	int ret;
@@ -738,12 +740,19 @@ static int dln2_probe(struct usb_interfa
 	    hostif->desc.bNumEndpoints < 2)
 		return -ENODEV;
 
+	epin = &hostif->endpoint[0].desc;
+	epout = &hostif->endpoint[1].desc;
+	if (!usb_endpoint_is_bulk_out(epout))
+		return -ENODEV;
+	if (!usb_endpoint_is_bulk_in(epin))
+		return -ENODEV;
+
 	dln2 = kzalloc(sizeof(*dln2), GFP_KERNEL);
 	if (!dln2)
 		return -ENOMEM;
 
-	dln2->ep_out = hostif->endpoint[0].desc.bEndpointAddress;
-	dln2->ep_in = hostif->endpoint[1].desc.bEndpointAddress;
+	dln2->ep_out = epout->bEndpointAddress;
+	dln2->ep_in = epin->bEndpointAddress;
 	dln2->usb_dev = usb_get_dev(interface_to_usbdev(interface));
 	dln2->interface = interface;
 	usb_set_intfdata(interface, dln2);


