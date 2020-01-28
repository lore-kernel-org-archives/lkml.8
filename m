Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F08C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D3224691
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221898;
	bh=C80hO95fUlhePgToChD8CSc4I8Aj6cloQwLGUMaNs+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qDnvGxCCEBnTnC50uaXHZxeziMVkFbBU2Pb+yJB5pUNZLHkTv/FqrL7ZtB8NGObcT
	 m8B59OG8ElDNSzvs677Wc8BawlsjvXpdoh96vsvB2oru5k8EfVEjLsKobRdertFLkj
	 90cVG3bId9ltIjTCWYYaQ4JEVDRLY2dcIONp2t14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733194AbgA1O1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:27:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:55290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbgA1O1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:27:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9991721739;
        Tue, 28 Jan 2020 14:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221650;
        bh=C80hO95fUlhePgToChD8CSc4I8Aj6cloQwLGUMaNs+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rRppznM6IfOaTizomRUIj1hBnBqkJHjnO0ZPppUxDbUAHE83Du4FiXm71TRBSvlMX
         78Psahx9AUFGQpoMJRfrlWWlwBZh8XyDuLSeCq7sgj4EC0zVDwVnYfw+24P0nqh3zA
         8WNS0saTrf3pOI1MbxlxOD9hJcxiiRQhcQbNrSfg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Vladis Dronov <vdronov@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 35/92] Input: gtco - fix endpoint sanity check
Date:   Tue, 28 Jan 2020 15:08:03 +0100
Message-Id: <20200128135813.593172472@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135809.344954797@linuxfoundation.org>
References: <20200128135809.344954797@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit a8eeb74df5a6bdb214b2b581b14782c5f5a0cf83 upstream.

The driver was checking the number of endpoints of the first alternate
setting instead of the current one, something which could lead to the
driver binding to an invalid interface.

This in turn could cause the driver to misbehave or trigger a WARN() in
usb_submit_urb() that kernels with panic_on_warn set would choke on.

Fixes: 162f98dea487 ("Input: gtco - fix crash on detecting device without endpoints")
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Vladis Dronov <vdronov@redhat.com>
Link: https://lore.kernel.org/r/20191210113737.4016-5-johan@kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/tablet/gtco.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- a/drivers/input/tablet/gtco.c
+++ b/drivers/input/tablet/gtco.c
@@ -875,18 +875,14 @@ static int gtco_probe(struct usb_interfa
 	}
 
 	/* Sanity check that a device has an endpoint */
-	if (usbinterface->altsetting[0].desc.bNumEndpoints < 1) {
+	if (usbinterface->cur_altsetting->desc.bNumEndpoints < 1) {
 		dev_err(&usbinterface->dev,
 			"Invalid number of endpoints\n");
 		error = -EINVAL;
 		goto err_free_urb;
 	}
 
-	/*
-	 * The endpoint is always altsetting 0, we know this since we know
-	 * this device only has one interrupt endpoint
-	 */
-	endpoint = &usbinterface->altsetting[0].endpoint[0].desc;
+	endpoint = &usbinterface->cur_altsetting->endpoint[0].desc;
 
 	/* Some debug */
 	dev_dbg(&usbinterface->dev, "gtco # interfaces: %d\n", usbinterface->num_altsetting);
@@ -973,7 +969,7 @@ static int gtco_probe(struct usb_interfa
 	input_dev->dev.parent = &usbinterface->dev;
 
 	/* Setup the URB, it will be posted later on open of input device */
-	endpoint = &usbinterface->altsetting[0].endpoint[0].desc;
+	endpoint = &usbinterface->cur_altsetting->endpoint[0].desc;
 
 	usb_fill_int_urb(gtco->urbinfo,
 			 udev,


