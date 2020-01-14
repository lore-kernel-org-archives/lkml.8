Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9B6C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF842467C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996254;
	bh=2m06gkz84QLde4drCqbnIjIW6b8Xjt+SP/Y7t00iEcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PDAJdqy4y9rwgQs2dP2GK76R1JHOlopIzLy6+4pc681Zdr5ucAc6XKgDjNnMfpv6F
	 Ji44ZuL7GutmqmdgGQcVxPxUcJ0VBGgvm1kHDcKXPHA6N2IBCwAid4Y0ezbXyj+2JX
	 xH6kE2hnLJQcYl1hgOvZ0M/lzoINKeKN21WbSgdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgANKEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:04:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:59566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728944AbgANKEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:04:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB0FF2465B;
        Tue, 14 Jan 2020 10:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996251;
        bh=2m06gkz84QLde4drCqbnIjIW6b8Xjt+SP/Y7t00iEcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dlSlFQyZwDiu1w42JfEGHm+ShtqLmBJrr/F6PVqTI/OF4pE6vUExO4r0tP4XaJMza
         w4YJsKPNBy+MRWEFr/E6DzYUBxaketufu15o997rx1MDkHRkQ6KgBgL1MP4ZeUhj5+
         20Vt4E0K8tSWAiIYsKfpxnUY9+qptqiaRqDaooI4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jimmy Assarsson <extja@kvaser.com>,
        Christer Beskow <chbe@kvaser.com>,
        Nicklas Johansson <extnj@kvaser.com>,
        Martin Henriksson <mh@kvaser.com>,
        Johan Hovold <johan@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.4 32/78] can: kvaser_usb: fix interface sanity check
Date:   Tue, 14 Jan 2020 11:01:06 +0100
Message-Id: <20200114094357.974017346@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094352.428808181@linuxfoundation.org>
References: <20200114094352.428808181@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 5660493c637c9d83786f1c9297f403eae44177b6 upstream.

Make sure to use the current alternate setting when verifying the
interface descriptors to avoid binding to an invalid interface.

Failing to do so could cause the driver to misbehave or trigger a WARN()
in usb_submit_urb() that kernels with panic_on_warn set would choke on.

Fixes: aec5fb2268b7 ("can: kvaser_usb: Add support for Kvaser USB hydra family")
Cc: stable <stable@vger.kernel.org>     # 4.19
Cc: Jimmy Assarsson <extja@kvaser.com>
Cc: Christer Beskow <chbe@kvaser.com>
Cc: Nicklas Johansson <extnj@kvaser.com>
Cc: Martin Henriksson <mh@kvaser.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c |    2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -1590,7 +1590,7 @@ static int kvaser_usb_hydra_setup_endpoi
 	struct usb_endpoint_descriptor *ep;
 	int i;
 
-	iface_desc = &dev->intf->altsetting[0];
+	iface_desc = dev->intf->cur_altsetting;
 
 	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
 		ep = &iface_desc->endpoint[i].desc;
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -1310,7 +1310,7 @@ static int kvaser_usb_leaf_setup_endpoin
 	struct usb_endpoint_descriptor *endpoint;
 	int i;
 
-	iface_desc = &dev->intf->altsetting[0];
+	iface_desc = dev->intf->cur_altsetting;
 
 	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
 		endpoint = &iface_desc->endpoint[i].desc;


