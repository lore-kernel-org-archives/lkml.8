Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB0BC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D1420724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624075;
	bh=o2dlzfEgwrTd0nF1WPJZlJJFh/rR8ulQ9jeTQ2xr5Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EuftO9tnItqVxRRaEGcGpwEd139qq5RblsMNrOZIuBqCTScL12Ocf3hylhyZ0Na8c
	 dgRycV1BC0pXVwz/ne3zw5VgyV7AI6TmHK8deeGo150iIWGqSpVDfCDqvSJ5zYRGXh
	 t6C9npPuTvLX0JT+Psr1KVA0qEde3HjOPF6Gyroo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgCSNVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729303AbgCSNVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:21:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81664206D7;
        Thu, 19 Mar 2020 13:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584624070;
        bh=o2dlzfEgwrTd0nF1WPJZlJJFh/rR8ulQ9jeTQ2xr5Js=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1fUrbmggRV0pq3SN132SlC9eMaSGGA4XmAghkFTANcnK6jdug1SK+yZd/XSE2/doe
         0HMOXdrsF3LIIJpMcckA/WGfYxIexR8UKWXk4QoTTXPPkXN7E+lGNNsg7SEb4YEdQo
         5VQh2c4yoD2OSnkYy/Q41XxLTrXJYMOB5tW0EKAU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 29/48] net: rmnet: fix packet forwarding in rmnet bridge mode
Date:   Thu, 19 Mar 2020 14:04:11 +0100
Message-Id: <20200319123912.152840364@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123902.941451241@linuxfoundation.org>
References: <20200319123902.941451241@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit ad3cc31b599ea80f06b29ebdc18b3a39878a48d6 ]

Packet forwarding is not working in rmnet bridge mode.
Because when a packet is forwarded, skb_push() for an ethernet header
is needed. But it doesn't call skb_push().
So, the ethernet header will be lost.

Test commands:
    modprobe rmnet
    ip netns add nst
    ip netns add nst2
    ip link add veth0 type veth peer name veth1
    ip link add veth2 type veth peer name veth3
    ip link set veth1 netns nst
    ip link set veth3 netns nst2

    ip link add rmnet0 link veth0 type rmnet mux_id 1
    ip link set veth2 master rmnet0
    ip link set veth0 up
    ip link set veth2 up
    ip link set rmnet0 up
    ip a a 192.168.100.1/24 dev rmnet0

    ip netns exec nst ip link set veth1 up
    ip netns exec nst ip a a 192.168.100.2/24 dev veth1
    ip netns exec nst2 ip link set veth3 up
    ip netns exec nst2 ip a a 192.168.100.3/24 dev veth3
    ip netns exec nst2 ping 192.168.100.2

Fixes: 60d58f971c10 ("net: qualcomm: rmnet: Implement bridge mode")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
index 5177d0f24947f..c9d43bad1e2fc 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
@@ -168,6 +168,9 @@ static int rmnet_map_egress_handler(struct sk_buff *skb,
 static void
 rmnet_bridge_handler(struct sk_buff *skb, struct net_device *bridge_dev)
 {
+	if (skb_mac_header_was_set(skb))
+		skb_push(skb, skb->mac_len);
+
 	if (bridge_dev) {
 		skb->dev = bridge_dev;
 		dev_queue_xmit(skb);
-- 
2.20.1



