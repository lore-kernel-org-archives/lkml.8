Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDD6C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A7B620780
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgDWXKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:10:55 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50296 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728594AbgDWXGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:06:52 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1jRkve-0004m9-2I; Fri, 24 Apr 2020 00:06:46 +0100
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1jRkvW-00E6wb-IO; Fri, 24 Apr 2020 00:06:38 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Johan Hovold" <johan@kernel.org>,
        "hayeswang" <hayeswang@realtek.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Fri, 24 Apr 2020 00:06:51 +0100
Message-ID: <lsq.1587683028.209573827@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 184/245] r8152: add missing endpoint sanity check
In-Reply-To: <lsq.1587683027.831233700@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.83-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 86f3f4cd53707ceeec079b83205c8d3c756eca93 upstream.

Add missing endpoint sanity check to probe in order to prevent a
NULL-pointer dereference (or slab out-of-bounds access) when retrieving
the interrupt-endpoint bInterval on ndo_open() in case a device lacks
the expected endpoints.

Fixes: 40a82917b1d3 ("net/usb/r8152: enable interrupt transfer")
Cc: hayeswang <hayeswang@realtek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/usb/r8152.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -3425,6 +3425,9 @@ static int rtl8152_probe(struct usb_inte
 		return -ENODEV;
 	}
 
+	if (intf->cur_altsetting->desc.bNumEndpoints < 3)
+		return -ENODEV;
+
 	usb_reset_device(udev);
 	netdev = alloc_etherdev(sizeof(struct r8152));
 	if (!netdev) {

