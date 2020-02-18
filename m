Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35281C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0434E21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 08:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="l6+37eJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgBRI1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 03:27:09 -0500
Received: from first.geanix.com ([116.203.34.67]:59606 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgBRI1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 03:27:09 -0500
Received: from localhost (unknown [193.163.1.7])
        by first.geanix.com (Postfix) with ESMTPSA id 919F3C0036;
        Tue, 18 Feb 2020 08:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1582014378; bh=HXbPSN1aokLgN/o7DVaUkYTISITHBVBZLKWriZmqQTI=;
        h=From:To:Cc:Subject:Date;
        b=l6+37eJul82C0JKH/GoZU6xqGEE8ZxvXS+hXWp3Ua30HtTpv7p2+dSwQ+rMWLKwaZ
         eHijheFGy20oIEAgBY99LSb2UqKGqh/jtO6fTqTfuT6BZ+l2cHbo1IpIyjhggUx6i8
         Eu/1+DFLaXbYpJx70mplhWMaBIKFT8Mu3UrIqyYUoJvsiMmnNssVjhfl+7WjTh/aui
         Z5a/SjnKhGRpcHlxoM0GdxQI40P06M17g3q6GLP5N2hPVumOUjmIXxGncJKMWjzFS5
         YyddRvPi/Gqcfn8LvAhsbtnxp0NFs/coOqkI4xI7FIkIeCvEVK4FSMAotWb13TT1Xe
         301AtVOhnkAag==
From:   Esben Haabendal <esben@geanix.com>
To:     netdev@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
Subject: [PATCH 5/8] net: ll_temac: Remove unused tx_bd_next struct field
Date:   Tue, 18 Feb 2020 09:27:06 +0100
Message-Id: <20200218082706.7458-1-esben@geanix.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tx_bd_next field was included in the initial commit,
commit 92744989533c ("net: add Xilinx ll_temac device driver"),
but has never had any real use.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/net/ethernet/xilinx/ll_temac.h      | 1 -
 drivers/net/ethernet/xilinx/ll_temac_main.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac.h b/drivers/net/ethernet/xilinx/ll_temac.h
index 53fb8141f1a6..463ef9eaf42d 100644
--- a/drivers/net/ethernet/xilinx/ll_temac.h
+++ b/drivers/net/ethernet/xilinx/ll_temac.h
@@ -372,7 +372,6 @@ struct temac_local {
 	struct cdmac_bd *rx_bd_v;
 	dma_addr_t rx_bd_p;
 	int tx_bd_ci;
-	int tx_bd_next;
 	int tx_bd_tail;
 	int rx_bd_ci;
 	int rx_bd_tail;
diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 90b486becb5b..7623d09fbd0a 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -387,7 +387,6 @@ static int temac_dma_bd_init(struct net_device *ndev)
 
 	/* Init descriptor indexes */
 	lp->tx_bd_ci = 0;
-	lp->tx_bd_next = 0;
 	lp->tx_bd_tail = 0;
 	lp->rx_bd_ci = 0;
 	lp->rx_bd_tail = RX_BD_NUM - 1;
-- 
2.25.0

