Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985B9C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 15:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58E822087C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 15:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbgIJPxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 11:53:45 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731313AbgIJPxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:53:11 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 29705937C3914FA5C913;
        Thu, 10 Sep 2020 23:07:16 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 23:07:11 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <jeffrey.t.kirsher@intel.com>, <davem@davemloft.net>,
        <kuba@kernel.org>
CC:     <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 2/3] e1000e: Fix some kernel-doc warnings in netdev.c
Date:   Thu, 10 Sep 2020 23:04:28 +0800
Message-ID: <20200910150429.31912-3-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910150429.31912-1-wanghai38@huawei.com>
References: <20200910150429.31912-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

drivers/net/ethernet/intel/e1000e/netdev.c:2525: warning: Excess function parameter 'adapter' description in 'e1000_update_itr'
drivers/net/ethernet/intel/e1000e/netdev.c:609: warning: Excess function parameter 'csum' description in 'e1000_rx_checksum'
drivers/net/ethernet/intel/e1000e/netdev.c:609: warning: Excess function parameter 'sk_buff' description in 'e1000_rx_checksum'
drivers/net/ethernet/intel/e1000e/netdev.c:6191: warning: Excess function parameter 'ifreq' description in 'e1000e_hwtstamp_set'

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 664e8ccc88d2..4c5c4e8a14ba 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -601,8 +601,7 @@ static void e1000_receive_skb(struct e1000_adapter *adapter,
  * e1000_rx_checksum - Receive Checksum Offload
  * @adapter: board private structure
  * @status_err: receive descriptor status and error fields
- * @csum: receive descriptor csum field
- * @sk_buff: socket buffer with received data
+ * @skb: socket buffer with received data
  **/
 static void e1000_rx_checksum(struct e1000_adapter *adapter, u32 status_err,
 			      struct sk_buff *skb)
@@ -2507,7 +2506,6 @@ void e1000e_free_rx_resources(struct e1000_ring *rx_ring)
 
 /**
  * e1000_update_itr - update the dynamic ITR value based on statistics
- * @adapter: pointer to adapter
  * @itr_setting: current adapter->itr
  * @packets: the number of packets during this measurement interval
  * @bytes: the number of bytes during this measurement interval
@@ -6174,7 +6172,7 @@ static int e1000_mii_ioctl(struct net_device *netdev, struct ifreq *ifr,
 /**
  * e1000e_hwtstamp_ioctl - control hardware time stamping
  * @netdev: network interface device structure
- * @ifreq: interface request
+ * @ifr: interface request
  *
  * Outgoing time stamping can be enabled and disabled. Play nice and
  * disable it when requested, although it shouldn't cause any overhead
-- 
2.17.1

