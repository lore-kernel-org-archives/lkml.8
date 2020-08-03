Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C380C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B02C2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596458637;
	bh=CVfzO/w2z9Q/j/WHg0j161Dfhtj25Thzw+zhOAcF4bM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d5dnikG5jG52hZayV0ojN34qeMdxREovD9AHxWuJyUHNVOyi1pQrXDD+C3LVxkuR7
	 YTKyme9RxY+V2GKPVaIX0r47gEByyjJ0ZEbp8Tl02CjjaBcQ9pwZYaaM8HIhuJhmBf
	 WPrnlwKwEfBzMW9ikjVfH/CU36jSix7kbnsFWXqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgHCMn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbgHCM3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:29:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA5922083B;
        Mon,  3 Aug 2020 12:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457742;
        bh=CVfzO/w2z9Q/j/WHg0j161Dfhtj25Thzw+zhOAcF4bM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x26kRjE/H4fXIq+2twtgewuP4P1fgbQRBRSJuhpeEE5Vhtyh+M9eaKh27PyNW7JOZ
         k7l+fb4oStpMAmGv3GoxZ0s2iNlSNVFemFfHeJ+M6DhAkTC9xfyvNd+3lX1QmB3VdD
         pUjZzZp67FNehKtN5hkEYeldo49JjQXyf0H75+wA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 56/90] mlxsw: core: Increase scope of RCU read-side critical section
Date:   Mon,  3 Aug 2020 14:19:18 +0200
Message-Id: <20200803121900.336920588@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121857.546052424@linuxfoundation.org>
References: <20200803121857.546052424@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 7d8e8f3433dc8d1dc87c1aabe73a154978fb4c4d ]

The lifetime of the Rx listener item ('rxl_item') is managed using RCU,
but is dereferenced outside of RCU read-side critical section, which can
lead to a use-after-free.

Fix this by increasing the scope of the RCU read-side critical section.

Fixes: 93c1edb27f9e ("mlxsw: Introduce Mellanox switch driver core")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index 1b204ce30ee42..506bcdc32a8df 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -1802,11 +1802,13 @@ void mlxsw_core_skb_receive(struct mlxsw_core *mlxsw_core, struct sk_buff *skb,
 			break;
 		}
 	}
-	rcu_read_unlock();
-	if (!found)
+	if (!found) {
+		rcu_read_unlock();
 		goto drop;
+	}
 
 	rxl->func(skb, local_port, rxl_item->priv);
+	rcu_read_unlock();
 	return;
 
 drop:
-- 
2.25.1



