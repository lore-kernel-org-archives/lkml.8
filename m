Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB973C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8956B2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645811;
	bh=DF2vG2JENOKeJQt1F4AhXFxKkI4NDkRA7YESUG6WUw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z5zc8Bl+KMGWIaPO94NR7jwNzqSPZY2wNP79tYfkGnz51nOxAhvzuE4dwAZ+ZOHXS
	 /aOxU03Gvk/4zc1QgiaNov5zN+pRzrE71zPEHB9tg806EXdPrtOflyOBN1BjgRuO/v
	 5U1xuyJ+kW3rAjq5if1nsvzsSoUCf9pyo17FLzec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbgCaJKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731174AbgCaJKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:10:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31ED42072E;
        Tue, 31 Mar 2020 09:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645806;
        bh=DF2vG2JENOKeJQt1F4AhXFxKkI4NDkRA7YESUG6WUw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Sq/CyxHs2SW9Bgl4FeNMopcj+qoR8oA1GR5fEWN3Bt7nkSNzMrjivZPWjVVu1kaY
         lVpCZ9g0mDG+TCm0RLMQ2SBWgJgOkIYterrn7gKkdT/LAl3WhEflZmYhQ5tt50stNr
         0v2OblOfskGfZQRIihvCAc4qIyeOwDOhoiW4ZRtU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        Johan Hovold <johan@kernel.org>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.5 155/170] media: flexcop-usb: fix endpoint sanity check
Date:   Tue, 31 Mar 2020 10:59:29 +0200
Message-Id: <20200331085439.486016511@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit bca243b1ce0e46be26f7c63b5591dfbb41f558e5 upstream.

commit 1b976fc6d684 ("media: b2c2-flexcop-usb: add sanity checking") added
an endpoint sanity check to address a NULL-pointer dereference on probe.
Unfortunately the check was done on the current altsetting which was later
changed.

Fix this by moving the sanity check to after the altsetting is changed.

Fixes: 1b976fc6d684 ("media: b2c2-flexcop-usb: add sanity checking")
Cc: Oliver Neukum <oneukum@suse.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/b2c2/flexcop-usb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/media/usb/b2c2/flexcop-usb.c
+++ b/drivers/media/usb/b2c2/flexcop-usb.c
@@ -511,6 +511,9 @@ static int flexcop_usb_init(struct flexc
 		return ret;
 	}
 
+	if (fc_usb->uintf->cur_altsetting->desc.bNumEndpoints < 1)
+		return -ENODEV;
+
 	switch (fc_usb->udev->speed) {
 	case USB_SPEED_LOW:
 		err("cannot handle USB speed because it is too slow.");
@@ -544,9 +547,6 @@ static int flexcop_usb_probe(struct usb_
 	struct flexcop_device *fc = NULL;
 	int ret;
 
-	if (intf->cur_altsetting->desc.bNumEndpoints < 1)
-		return -ENODEV;
-
 	if ((fc = flexcop_device_kmalloc(sizeof(struct flexcop_usb))) == NULL) {
 		err("out of memory\n");
 		return -ENOMEM;


