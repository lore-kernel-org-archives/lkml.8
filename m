Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5F5C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32CB21927
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbgCISUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:20:02 -0400
Received: from foss.arm.com ([217.140.110.172]:55768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbgCISTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:19:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50F6C11FB;
        Mon,  9 Mar 2020 11:19:18 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02E5B3F67D;
        Mon,  9 Mar 2020 11:19:16 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Robert Hancock <hancock@sedsystems.ca>, netdev@vger.kernel.org,
        rmk+kernel@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 10/14] net: axienet: Add mii-tool support
Date:   Mon,  9 Mar 2020 18:18:47 +0000
Message-Id: <20200309181851.190164-11-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309181851.190164-1-andre.przywara@arm.com>
References: <20200309181851.190164-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mii-tool is useful for debugging, and all it requires to work is to wire
up the ioctl ops function pointer.
Add this to the axienet driver to enable mii-tool.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index a926dd4f5a18..74cd11d65cd8 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1168,6 +1168,16 @@ static void axienet_poll_controller(struct net_device *ndev)
 }
 #endif
 
+static int axienet_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+{
+	struct axienet_local *lp = netdev_priv(dev);
+
+	if (!netif_running(dev))
+		return -EINVAL;
+
+	return phylink_mii_ioctl(lp->phylink, rq, cmd);
+}
+
 static const struct net_device_ops axienet_netdev_ops = {
 	.ndo_open = axienet_open,
 	.ndo_stop = axienet_stop,
@@ -1175,6 +1185,7 @@ static const struct net_device_ops axienet_netdev_ops = {
 	.ndo_change_mtu	= axienet_change_mtu,
 	.ndo_set_mac_address = netdev_set_mac_address,
 	.ndo_validate_addr = eth_validate_addr,
+	.ndo_do_ioctl = axienet_ioctl,
 	.ndo_set_rx_mode = axienet_set_multicast_list,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller = axienet_poll_controller,
-- 
2.17.1

