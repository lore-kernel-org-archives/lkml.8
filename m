Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1A8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712ED24680
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685944;
	bh=vyuc22PMlxG8UOEBZzuJH+BPgBY4Pz+AfMF/aKlx0OI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x1loTiDiJF+127s1/gYr74D8uXroWuq9NA5N9LT0XOf59cJ1QkdpIN9RHHTn9yXk6
	 5kkBMA0ATmqajyZ0gSLBV1VowvxhdDrqSt0kJDnXZhL5oC+L2ybswBuUoiRCq472vf
	 /ua4wgkGFMq8wXapFvQHgxsjOg1u0sMNeGvh7Wrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732802AbgAVJjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:39:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:56216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733129AbgAVJi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:38:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F47E2467B;
        Wed, 22 Jan 2020 09:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685938;
        bh=vyuc22PMlxG8UOEBZzuJH+BPgBY4Pz+AfMF/aKlx0OI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hFhlfSp5PYeOhxLDLVnKe7Bv8BI09TtBXhbYoAugc7zV6HZLSvxyXVzhQju0+Ausd
         YAvYJP/RbXCFtdQZ8Ihkuq6FEuTyMjvmxaiwBeWNqxWjCzjWkTh70St4iWy1K1bqGo
         DqSWHB2NUjtqCIVKgNaQlHdQNFwwZyG7IK9re3ak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonglong Liu <liuyonglong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 44/65] net: hns: fix soft lockup when there is not enough memory
Date:   Wed, 22 Jan 2020 10:29:29 +0100
Message-Id: <20200122092757.377249552@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092750.976732974@linuxfoundation.org>
References: <20200122092750.976732974@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

[ Upstream commit 49edd6a2c456150870ddcef5b7ed11b21d849e13 ]

When there is not enough memory and napi_alloc_skb() return NULL,
the HNS driver will print error message, and than try again, if
the memory is not enough for a while, huge error message and the
retry operation will cause soft lockup.

When napi_alloc_skb() return NULL because of no memory, we can
get a warn_alloc() call trace, so this patch deletes the error
message. We already use polling mode to handle irq, but the
retry operation will render the polling weight inactive, this
patch just return budget when the rx is not completed to avoid
dead loop.

Fixes: 36eedfde1a36 ("net: hns: Optimize hns_nic_common_poll for better performance")
Fixes: b5996f11ea54 ("net: add Hisilicon Network Subsystem basic ethernet support")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -669,7 +669,6 @@ static int hns_nic_poll_rx_skb(struct hn
 	skb = *out_skb = napi_alloc_skb(&ring_data->napi,
 					HNS_RX_HEAD_SIZE);
 	if (unlikely(!skb)) {
-		netdev_err(ndev, "alloc rx skb fail\n");
 		ring->stats.sw_err_cnt++;
 		return -ENOMEM;
 	}
@@ -1180,7 +1179,6 @@ static int hns_nic_common_poll(struct na
 		container_of(napi, struct hns_nic_ring_data, napi);
 	struct hnae_ring *ring = ring_data->ring;
 
-try_again:
 	clean_complete += ring_data->poll_one(
 				ring_data, budget - clean_complete,
 				ring_data->ex_process);
@@ -1190,7 +1188,7 @@ try_again:
 			napi_complete(napi);
 			ring->q->handle->dev->ops->toggle_ring_irq(ring, 0);
 		} else {
-			goto try_again;
+			return budget;
 		}
 	}
 


