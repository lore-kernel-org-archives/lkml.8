Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096B0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0FDC206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="eBxrUA/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405834AbgE1Sae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 14:30:34 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:39577 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405803AbgE1Sab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 14:30:31 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49Xx8N2wkvz63;
        Thu, 28 May 2020 20:30:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1590690629; bh=wyk1Xu6FHxs00Uj8yLfVamGMvT7czOOsTndQSx9fs8A=;
        h=Date:From:Subject:To:Cc:From;
        b=eBxrUA/+NVA3frxBWe/uNipfhphrdxrnbO+QVsyc2NKfb4EGBpJcs2UohSLpDFIhr
         d7Z8q4sg6xd5TxvxBazcy9UgEJYV8WRwcWauVfYz15zNWiIP0Y9TC50CFl9dMCpigz
         GJUcK4BIDQDLmvVwBNuEK+cScQZdRAwfd9tGuK+bRQj/DW2YQskjqt8zyjucNN8oYB
         GPz248JYO9lF02C+Khq/FeigGaLORj4W0jHzUOMKM11nZsZrzImKM9B4eEAh2vH3r1
         +FUHviTw1zhlKhtytHgcwKSwDdM+w9TF/sE2xz9uMVLbDVHbNd67kHRq8Ke/VON9HF
         J5vBtQAHmYQYA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 28 May 2020 20:30:28 +0200
Message-Id: <237e4bc8c63680f9ce0388d35b4c34a856ed8595.1590690518.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] usb: gadget: f_acm: don't disable disabled EP
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Baldyga <r.baldyga@samsung.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make debugging real problems easier by not trying to disable an EP that
was not yet enabled.

Fixes: 4aab757ca44a ("usb: gadget: f_acm: eliminate abuse of ep->driver data")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/usb/gadget/function/f_acm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_acm.c b/drivers/usb/gadget/function/f_acm.c
index 200596ea9557..46647bfac2ef 100644
--- a/drivers/usb/gadget/function/f_acm.c
+++ b/drivers/usb/gadget/function/f_acm.c
@@ -425,9 +425,11 @@ static int acm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 	/* we know alt == 0, so this is an activation or a reset */
 
 	if (intf == acm->ctrl_id) {
-		dev_vdbg(&cdev->gadget->dev,
-				"reset acm control interface %d\n", intf);
-		usb_ep_disable(acm->notify);
+		if (acm->notify->enabled) {
+			dev_vdbg(&cdev->gadget->dev,
+					"reset acm control interface %d\n", intf);
+			usb_ep_disable(acm->notify);
+		}
 
 		if (!acm->notify->desc)
 			if (config_ep_by_speed(cdev->gadget, f, acm->notify))
-- 
2.20.1

