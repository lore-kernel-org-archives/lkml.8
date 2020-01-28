Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75284C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4985C2468D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580219972;
	bh=OV6hMQvSRH9LaYqFuXBly3SfS6lgnnLWXOxFkJq2GQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oykPgUOsPzcO1GVTQP4cyUeqhG6J+eCiiN9HessMmjA5+iJfBWmIWshvhD2xWagWL
	 yGTIxgoxIx2mD0SkzB7DJ+tmXfQSCYoQIdtHrqDKPg9kERkiaXnhDeNUoLDm8g/qE3
	 O4/DMFtR4gaOLDYB9U1UYfNqvjUPLOeG1M/6Nm50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgA1N7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:59:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbgA1N7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 08:59:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8345B2173E;
        Tue, 28 Jan 2020 13:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580219963;
        bh=OV6hMQvSRH9LaYqFuXBly3SfS6lgnnLWXOxFkJq2GQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CO2t9h3NTKmkOhBTDCipPh3+RXX7xWNPdJWDRgdX0mymwlRiDUNqWLMzuZewKiVZv
         hARR9fJv1hmNJlt1Fw8j5KJnYzoVR9+biO7lv3hDa0imLbJuo4uz/pdr3ZJ4gH4cSR
         brhLGh1a59INLOsQN5/vBapkLdlGR6gA9D2xVE+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        James Hughes <james.hughes@raspberrypi.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 14/46] net: usb: lan78xx: Add .ndo_features_check
Date:   Tue, 28 Jan 2020 14:57:48 +0100
Message-Id: <20200128135751.863035919@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135749.822297911@linuxfoundation.org>
References: <20200128135749.822297911@linuxfoundation.org>
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
@@ -31,6 +31,7 @@
 #include <linux/mdio.h>
 #include <linux/phy.h>
 #include <net/ip6_checksum.h>
+#include <net/vxlan.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/irq.h>
@@ -3525,6 +3526,19 @@ static void lan78xx_tx_timeout(struct ne
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
@@ -3538,6 +3552,7 @@ static const struct net_device_ops lan78
 	.ndo_set_features	= lan78xx_set_features,
 	.ndo_vlan_rx_add_vid	= lan78xx_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= lan78xx_vlan_rx_kill_vid,
+	.ndo_features_check	= lan78xx_features_check,
 };
 
 static void lan78xx_stat_monitor(unsigned long param)


