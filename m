Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02286C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6FF207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583428822;
	bh=7Xpa5Qwe0lWcRf6rqT2U+lbAJA93ioiusi3vNGr++3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B6hzSCRNbSPqd5vmtcpQNiZBsqSCXwmuBr1UmWpWWgC2x7gJAe9Pypd+lBUzU7fc3
	 FdENMDWf85Ja+ePZUd1EFEUKZyHi5CaEVSty3LojxIWVJYPZVxCohvyFKwULhYICeG
	 H0ChOgZERfvG5EX4mtmNPJdQY59CSTEqAjP7SZ4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgCERUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:20:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:41406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbgCEROz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:14:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0936021556;
        Thu,  5 Mar 2020 17:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583428494;
        bh=7Xpa5Qwe0lWcRf6rqT2U+lbAJA93ioiusi3vNGr++3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d2dH8bhCyB1k54UzNqV0SR6FTX4OveKkoH4IMfcFDjbUSy34zkagxLRUSgOQ56FDB
         4xVMszVfIM9zejilSsSPJlP0PRZrO97xNr9e5dxnLcOwxlxWKZRuXSa6V9qkOgHRSG
         jZ4p1HtM/W1sQd4RY1nXdfsiGBsOUhewNMstLgTQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniele Palmas <dnlplm@gmail.com>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 27/58] net: usb: qmi_wwan: restore mtu min/max values after raw_ip switch
Date:   Thu,  5 Mar 2020 12:13:48 -0500
Message-Id: <20200305171420.29595-27-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305171420.29595-1-sashal@kernel.org>
References: <20200305171420.29595-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Palmas <dnlplm@gmail.com>

[ Upstream commit eae7172f8141eb98e64e6e81acc9e9d5b2add127 ]

usbnet creates network interfaces with min_mtu = 0 and
max_mtu = ETH_MAX_MTU.

These values are not modified by qmi_wwan when the network interface
is created initially, allowing, for example, to set mtu greater than 1500.

When a raw_ip switch is done (raw_ip set to 'Y', then set to 'N') the mtu
values for the network interface are set through ether_setup, with
min_mtu = ETH_MIN_MTU and max_mtu = ETH_DATA_LEN, not allowing anymore to
set mtu greater than 1500 (error: mtu greater than device maximum).

The patch restores the original min/max mtu values set by usbnet after a
raw_ip switch.

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Acked-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/qmi_wwan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 9485c8d1de8a3..9dcbca1f8f9aa 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -338,6 +338,9 @@ static void qmi_wwan_netdev_setup(struct net_device *net)
 		netdev_dbg(net, "mode: raw IP\n");
 	} else if (!net->header_ops) { /* don't bother if already set */
 		ether_setup(net);
+		/* Restoring min/max mtu values set originally by usbnet */
+		net->min_mtu = 0;
+		net->max_mtu = ETH_MAX_MTU;
 		clear_bit(EVENT_NO_IP_ALIGN, &dev->flags);
 		netdev_dbg(net, "mode: Ethernet\n");
 	}
-- 
2.20.1

