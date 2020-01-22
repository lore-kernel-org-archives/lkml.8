Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88392C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5678924673
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685566;
	bh=KihyWKk3SIkPemrHd6GuzvjWjwEY7Z9Koyl5Lj7HXM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wut3NVoTM9qKkbL5p1eKc1fn38asejBUJamL34MCGDWWtj9XVr1y0VL+wkbwkqdGk
	 50ttyvLQV9J4K//Oy55UdNdx6Drl+brLZ+POlphos+EOKQCreEFDELrU/gXHh2Iohh
	 D5TQtzzR8/cXhYaoG9zqG/7JhrPEAOBRSwRQYxII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbgAVJcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:32:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:45880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbgAVJcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:32:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 403E72071E;
        Wed, 22 Jan 2020 09:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685564;
        bh=KihyWKk3SIkPemrHd6GuzvjWjwEY7Z9Koyl5Lj7HXM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cc7l4/tS8NDWpwil9zi7Qy4CSIIQZbWXu7Sjr3wZeDHHEUeYWPRqklYzxQAgO6Tdo
         xcf5kEethMWwFWlGG2zBRYcHpx//n+g9z7Z1qfMhHPrh5ydkI7+dUlwIMVnwtxOlkG
         3thbvpU8F3z3i46fSL96Gk6vlMs4tGsIZVms8mNg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, hayeswang <hayeswang@realtek.com>,
        Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 64/76] r8152: add missing endpoint sanity check
Date:   Wed, 22 Jan 2020 10:29:20 +0100
Message-Id: <20200122092801.020020736@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092751.587775548@linuxfoundation.org>
References: <20200122092751.587775548@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 86f3f4cd53707ceeec079b83205c8d3c756eca93 ]

Add missing endpoint sanity check to probe in order to prevent a
NULL-pointer dereference (or slab out-of-bounds access) when retrieving
the interrupt-endpoint bInterval on ndo_open() in case a device lacks
the expected endpoints.

Fixes: 40a82917b1d3 ("net/usb/r8152: enable interrupt transfer")
Cc: hayeswang <hayeswang@realtek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/r8152.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -4243,6 +4243,9 @@ static int rtl8152_probe(struct usb_inte
 		return -ENODEV;
 	}
 
+	if (intf->cur_altsetting->desc.bNumEndpoints < 3)
+		return -ENODEV;
+
 	usb_reset_device(udev);
 	netdev = alloc_etherdev(sizeof(struct r8152));
 	if (!netdev) {


