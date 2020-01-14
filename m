Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9D6C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A7C24685
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996461;
	bh=2m06gkz84QLde4drCqbnIjIW6b8Xjt+SP/Y7t00iEcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OWNo+2kitr0g9nagd/kjP2Y21pnKPwiOrPKl5tMfFHJVYGPw3u7Ui6rq1iAoiBT0l
	 hZOZ3s0eRBPEIuMhz06ZthhMFrc7mWYYlw96FIscEjMjV8UBU+xb9aAe9ERYyDvkBY
	 3xG4qJhXy1H6joJ/nUI0J10y567m5i4MHffOqWfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbgANKHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:07:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729431AbgANKHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:07:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C86724679;
        Tue, 14 Jan 2020 10:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996443;
        bh=2m06gkz84QLde4drCqbnIjIW6b8Xjt+SP/Y7t00iEcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NlsUGcifsQ1gu9Fv3T+VELcbB//ZWnIX+1zodjMrL3iNWqPbV3PgEA9b7aY9EEQ1E
         uw8GognstJY66McirMB0PKdvhQ+UEzcV0xDsfQfCplMXZkrsNd2/phMwmKXx5HIdqQ
         ywmmegWY0WHXULlt+NdkLS5YshxIlWaUWOwDH14k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jimmy Assarsson <extja@kvaser.com>,
        Christer Beskow <chbe@kvaser.com>,
        Nicklas Johansson <extnj@kvaser.com>,
        Martin Henriksson <mh@kvaser.com>,
        Johan Hovold <johan@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.19 19/46] can: kvaser_usb: fix interface sanity check
Date:   Tue, 14 Jan 2020 11:01:36 +0100
Message-Id: <20200114094344.407711257@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094339.608068818@linuxfoundation.org>
References: <20200114094339.608068818@linuxfoundation.org>
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


