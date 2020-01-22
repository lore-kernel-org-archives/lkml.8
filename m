Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED95C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8142467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699435;
	bh=ZxYyBmcz/5wuirpUXUplrKtt/pbCq1dVIw7KyX/C3NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EtWwkpmZbZ/hkz5uuTxW9GFgyyw6zlY+Ekhablsg5MZfEPg25f8idDPWnCGWezoV6
	 SC8R5Y1sLQn433aCGeoyWoTTqVazmP8XHdbUPIaztTLGLzMcB4qVlSn07d/YiKL9sk
	 8Eav36u7Jo13905jVs7Zk7r8HlPp4EW93m90vIlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbgAVNXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:23:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:42294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgAVNXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:23:48 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C18F824688;
        Wed, 22 Jan 2020 13:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699427;
        bh=ZxYyBmcz/5wuirpUXUplrKtt/pbCq1dVIw7KyX/C3NU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KNvHkO5OM1c+9vpJvn6uF3c9+hSrx5e+79WIM+Arz8Shw6TrnQTWK+7243pq4muVY
         74gBaevxNqHp7Hu4fwk0JuL6mI33DU/6svDOvbCw4vyS1BbXBmqgZj/MEsYL3W1FM6
         IGSk0jirTYn157JRgzj5Pp3s36aG17WbBh4t7eZw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunsheng Lin <linyunsheng@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 140/222] net: hns3: pad the short frame before sending to the hardware
Date:   Wed, 22 Jan 2020 10:28:46 +0100
Message-Id: <20200122092843.758942348@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

[ Upstream commit 36c67349a1a1c88b9cf11d7ca7762ababdb38867 ]

The hardware can not handle short frames below or equal to 32
bytes according to the hardware user manual, and it will trigger
a RAS error when the frame's length is below 33 bytes.

This patch pads the SKB when skb->len is below 33 bytes before
sending it to hardware.

Fixes: 76ad4f0ee747 ("net: hns3: Add support of HNS3 Ethernet Driver for hip08 SoC")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -54,6 +54,8 @@ MODULE_PARM_DESC(debug, " Network interf
 #define HNS3_INNER_VLAN_TAG	1
 #define HNS3_OUTER_VLAN_TAG	2
 
+#define HNS3_MIN_TX_LEN		33U
+
 /* hns3_pci_tbl - PCI Device ID Table
  *
  * Last entry must be all 0s
@@ -1329,6 +1331,10 @@ netdev_tx_t hns3_nic_net_xmit(struct sk_
 	int ret;
 	int i;
 
+	/* Hardware can only handle short frames above 32 bytes */
+	if (skb_put_padto(skb, HNS3_MIN_TX_LEN))
+		return NETDEV_TX_OK;
+
 	/* Prefetch the data used later */
 	prefetch(skb->data);
 


