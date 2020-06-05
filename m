Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B68C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA8CE2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591360231;
	bh=YlJD6YMMhL+i0hLnJJh5R5tyM7+o3K7d6jXSpkPPa7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CLpWQJqLAlL/8JcJ66Oxh3Gor92OM3w/3chWfvZTeGFgaXiOeXL5FFbBvDUxPkiwg
	 L936cFLOv5KNInDLMo2t3E75sehiQVDCuKVz8GeOFYXuA1JeLkL4g60m1Gc7ccsNR/
	 7bwj6UF5I1/T2M0IoPEU1PDkfB+xDejfS/tTdlHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgFEMaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:30:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbgFEMZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 08:25:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFC0C206DC;
        Fri,  5 Jun 2020 12:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591359935;
        bh=YlJD6YMMhL+i0hLnJJh5R5tyM7+o3K7d6jXSpkPPa7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FrOC/K5UVGtKmdbU1t6USEevian+kaDJCceGQk5O4voOq4hcvKUzRWMXgKyS1wq3T
         iJZrKJxU7yDcn3OlDSz+Wo/ZElhowdCDJlaD1kD/Jba4KthTJwIqx20IRRB0YIRsLL
         EtcdnvowPt1liZZA57veMV6pDo1TW4YWXOoA0mqE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 14/17] net/mlx5e: replace EINVAL in mlx5e_flower_parse_meta()
Date:   Fri,  5 Jun 2020 08:25:13 -0400
Message-Id: <20200605122517.2882338-14-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605122517.2882338-1-sashal@kernel.org>
References: <20200605122517.2882338-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit a683012a8e77675a1947cc8f11f97cdc1d5bb769 ]

The drivers reports EINVAL to userspace through netlink on invalid meta
match. This is confusing since EINVAL is usually reserved for malformed
netlink messages. Replace it by more meaningful codes.

Fixes: 6d65bc64e232 ("net/mlx5e: Add mlx5e_flower_parse_meta support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 4659c205cc01..46ff83408d05 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1824,7 +1824,7 @@ static int mlx5e_flower_parse_meta(struct net_device *filter_dev,
 	flow_rule_match_meta(rule, &match);
 	if (match.mask->ingress_ifindex != 0xFFFFFFFF) {
 		NL_SET_ERR_MSG_MOD(extack, "Unsupported ingress ifindex mask");
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 
 	ingress_dev = __dev_get_by_index(dev_net(filter_dev),
@@ -1832,13 +1832,13 @@ static int mlx5e_flower_parse_meta(struct net_device *filter_dev,
 	if (!ingress_dev) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Can't find the ingress port to match on");
-		return -EINVAL;
+		return -ENOENT;
 	}
 
 	if (ingress_dev != filter_dev) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Can't match on the ingress filter port");
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
-- 
2.25.1

