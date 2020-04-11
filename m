Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2509CC2BBFD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF4B20708
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586646688;
	bh=DhzcEptChd0fwK1XPOxrmKjNSnVlPf5I4TA6HXVaIOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VXFTj+UHZXmdI4g90R6stwrJuHzwdQI1H4TRFuD6KHzqu0SetzjnYowBAOKFBIPMJ
	 KFP2U1RXvxHViWmBJaIcH/UaugQcIQoqWSXjounS/hMdbw8nU/ZqubGe06eCDj2ljX
	 C5eVy0RhloDuw/LOF6TIgmuGXtOtQ4V3TBj02a20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbgDKXL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728318AbgDKXLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:11:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4834821D7E;
        Sat, 11 Apr 2020 23:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646679;
        bh=DhzcEptChd0fwK1XPOxrmKjNSnVlPf5I4TA6HXVaIOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BZojzTM8Hz3gUVt7Hy3A4az7eYiRrGzOBVJqZeqRTRtKhpbXMIJnfpWc4Tg2PLTn0
         0mzeaWwAjeNQp4FFinHft9QSRir2+XG71z5OquL1mWOY6RSqYGhe/WDcqybQSHi71U
         QpxUxMA/deXYLt+Tokms1Ok6P1y7jXF/xgxPep6g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 076/108] net: axienet: Propagate failure of DMA descriptor setup
Date:   Sat, 11 Apr 2020 19:09:11 -0400
Message-Id: <20200411230943.24951-76-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230943.24951-1-sashal@kernel.org>
References: <20200411230943.24951-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Przywara <andre.przywara@arm.com>

[ Upstream commit ee44d0b78839b21591501424fd3cb3648cc803b5 ]

When we fail allocating the DMA buffers in axienet_dma_bd_init(), we
report this error, but carry on with initialisation nevertheless.

This leads to a kernel panic when the driver later wants to send a
packet, as it uses uninitialised data structures.

Make the axienet_device_reset() routine return an error value, as it
contains the DMA buffer initialisation. Make sure we propagate the error
up the chain and eventually fail the driver initialisation, to avoid
relying on non-initialised buffers.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 26 ++++++++++++++-----
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 345a795666e92..bb6e52f3bdf9b 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -437,9 +437,10 @@ static void axienet_setoptions(struct net_device *ndev, u32 options)
 	lp->options |= options;
 }
 
-static void __axienet_device_reset(struct axienet_local *lp)
+static int __axienet_device_reset(struct axienet_local *lp)
 {
 	u32 timeout;
+
 	/* Reset Axi DMA. This would reset Axi Ethernet core as well. The reset
 	 * process of Axi DMA takes a while to complete as all pending
 	 * commands/transfers will be flushed or completed during this
@@ -455,9 +456,11 @@ static void __axienet_device_reset(struct axienet_local *lp)
 		if (--timeout == 0) {
 			netdev_err(lp->ndev, "%s: DMA reset timeout!\n",
 				   __func__);
-			break;
+			return -ETIMEDOUT;
 		}
 	}
+
+	return 0;
 }
 
 /**
@@ -470,13 +473,17 @@ static void __axienet_device_reset(struct axienet_local *lp)
  * areconnected to Axi Ethernet reset lines, this in turn resets the Axi
  * Ethernet core. No separate hardware reset is done for the Axi Ethernet
  * core.
+ * Returns 0 on success or a negative error number otherwise.
  */
-static void axienet_device_reset(struct net_device *ndev)
+static int axienet_device_reset(struct net_device *ndev)
 {
 	u32 axienet_status;
 	struct axienet_local *lp = netdev_priv(ndev);
+	int ret;
 
-	__axienet_device_reset(lp);
+	ret = __axienet_device_reset(lp);
+	if (ret)
+		return ret;
 
 	lp->max_frm_size = XAE_MAX_VLAN_FRAME_SIZE;
 	lp->options |= XAE_OPTION_VLAN;
@@ -491,9 +498,11 @@ static void axienet_device_reset(struct net_device *ndev)
 			lp->options |= XAE_OPTION_JUMBO;
 	}
 
-	if (axienet_dma_bd_init(ndev)) {
+	ret = axienet_dma_bd_init(ndev);
+	if (ret) {
 		netdev_err(ndev, "%s: descriptor allocation failed\n",
 			   __func__);
+		return ret;
 	}
 
 	axienet_status = axienet_ior(lp, XAE_RCW1_OFFSET);
@@ -518,6 +527,8 @@ static void axienet_device_reset(struct net_device *ndev)
 	axienet_setoptions(ndev, lp->options);
 
 	netif_trans_update(ndev);
+
+	return 0;
 }
 
 /**
@@ -921,8 +932,9 @@ static int axienet_open(struct net_device *ndev)
 	 */
 	mutex_lock(&lp->mii_bus->mdio_lock);
 	axienet_mdio_disable(lp);
-	axienet_device_reset(ndev);
-	ret = axienet_mdio_enable(lp);
+	ret = axienet_device_reset(ndev);
+	if (ret == 0)
+		ret = axienet_mdio_enable(lp);
 	mutex_unlock(&lp->mii_bus->mdio_lock);
 	if (ret < 0)
 		return ret;
-- 
2.20.1

