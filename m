Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A29BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B942072E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646063;
	bh=WrLmrYraf+mK7cIgFLavPmqL/IOaaNICmzVAiwoZoPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0cLB4X3BNVUYDZCOJcwBlnneFaSNKPDt7348b44XV4ulB1SyRZlBdFRb45jBifHp1
	 XZ7zRmptbHqIjErxntiTukaSAqlslIJGlZk9a+5wx/w5v1a9m16uKtWJeFWXXGXG7E
	 Unwcn6I4XrIZz8DcNOuzUqJc4LITebVjDN/My/kE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731835AbgCaJOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:14:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730628AbgCaJOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:14:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21E6320675;
        Tue, 31 Mar 2020 09:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585646060;
        bh=WrLmrYraf+mK7cIgFLavPmqL/IOaaNICmzVAiwoZoPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mXXB5TfCuX5Uq6emregBJGYWDx7UfF7Kpubmqsn6Glmc6T90OMeTENLwcLiI9iCGM
         24nyROIq5WT6lBZonVG0eANTIQQVILdXZnAJJaxPB7KOLwuwurJflxGvOjm8i+f38A
         psagjN8Oq6s/2e/sfNLeoAWsoKmRoltUEoNjkXAY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonglong Liu <liuyonglong@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 072/155] net: hns3: fix "tc qdisc del" failed issue
Date:   Tue, 31 Mar 2020 10:58:32 +0200
Message-Id: <20200331085426.476301033@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

[ Upstream commit 5eb01ddfcfb25e6ebc404a41deae946bde776731 ]

The HNS3 driver supports to configure TC numbers and TC to priority
map via "tc" tool. But when delete the rule, will fail, because
the HNS3 driver needs at least one TC, but the "tc" tool sets TC
number to zero when delete.

This patch makes sure that the TC number is at least one.

Fixes: 30d240dfa2e8 ("net: hns3: Add mqprio hardware offload support in hns3 driver")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 0c8d2269bc46e..403e0f089f2af 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1596,7 +1596,7 @@ static int hns3_setup_tc(struct net_device *netdev, void *type_data)
 	netif_dbg(h, drv, netdev, "setup tc: num_tc=%u\n", tc);
 
 	return (kinfo->dcb_ops && kinfo->dcb_ops->setup_tc) ?
-		kinfo->dcb_ops->setup_tc(h, tc, prio_tc) : -EOPNOTSUPP;
+		kinfo->dcb_ops->setup_tc(h, tc ? tc : 1, prio_tc) : -EOPNOTSUPP;
 }
 
 static int hns3_nic_setup_tc(struct net_device *dev, enum tc_setup_type type,
-- 
2.20.1



