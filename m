Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E3AC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88A520716
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222960;
	bh=l+s3jAlkmBILkB9oTKFVMq390ksNdWRrM2SzmM0zX1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xgbF6CvGuIpq2coHfpJZGIwnNmNhDl8a3yz+RRWsXtc/mGfJLFCdbCjtIu0E9Vbgs
	 J2T9B8JqUS2M0KOfVxsJTPCJYSXjGutBUOzfRCQ8wGvXe8yxk3wLbk6TX0jTGigMqM
	 xNu9Y0IRUJHoFzJldpE/67V4N2jHq5cC/tsZfS9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgA1OBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:01:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:47622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727468AbgA1OBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:01:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78BF6205F4;
        Tue, 28 Jan 2020 14:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220091;
        bh=l+s3jAlkmBILkB9oTKFVMq390ksNdWRrM2SzmM0zX1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pJjbLEC3JxWZsQ4lVyo0DBNUbNukFlw0ae2LBMXX5Vs4ULYxlt/Usk6RqmWyUOQLU
         SA+bJm3Zd76K8iox/MdN6aXLPyMieoZsQTUi5Q+veUWzfdkOOBzJVSJ0swwJ/PaHwC
         OnA9B3I6+cY8alGwVU/UBGoh7ss8jrPmZI9fhK64=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        James Hughes <james.hughes@raspberrypi.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 014/104] net: usb: lan78xx: Add .ndo_features_check
Date:   Tue, 28 Jan 2020 14:59:35 +0100
Message-Id: <20200128135819.209454935@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135817.238524998@linuxfoundation.org>
References: <20200128135817.238524998@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Hughes <james.hughes@raspberrypi.org>

[ Upstream commit ce896476c65d72b4b99fa09c2f33436b4198f034 ]

As reported by Eric Dumazet, there are still some outstanding
cases where the driver does not handle TSO correctly when skb's
are over a certain size. Most cases have been fixed, this patch
should ensure that forwarded SKB's that are greater than
MAX_SINGLE_PACKET_SIZE - TX_OVERHEAD are software segmented
and handled correctly.

Signed-off-by: James Hughes <james.hughes@raspberrypi.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/lan78xx.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -20,6 +20,7 @@
 #include <linux/mdio.h>
 #include <linux/phy.h>
 #include <net/ip6_checksum.h>
+#include <net/vxlan.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/irq.h>
@@ -3668,6 +3669,19 @@ static void lan78xx_tx_timeout(struct ne
 	tasklet_schedule(&dev->bh);
 }
 
+static netdev_features_t lan78xx_features_check(struct sk_buff *skb,
+						struct net_device *netdev,
+						netdev_features_t features)
+{
+	if (skb->len + TX_OVERHEAD > MAX_SINGLE_PACKET_SIZE)
+		features &= ~NETIF_F_GSO_MASK;
+
+	features = vlan_features_check(skb, features);
+	features = vxlan_features_check(skb, features);
+
+	return features;
+}
+
 static const struct net_device_ops lan78xx_netdev_ops = {
 	.ndo_open		= lan78xx_open,
 	.ndo_stop		= lan78xx_stop,
@@ -3681,6 +3695,7 @@ static const struct net_device_ops lan78
 	.ndo_set_features	= lan78xx_set_features,
 	.ndo_vlan_rx_add_vid	= lan78xx_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= lan78xx_vlan_rx_kill_vid,
+	.ndo_features_check	= lan78xx_features_check,
 };
 
 static void lan78xx_stat_monitor(struct timer_list *t)


