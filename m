Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9DAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BCA421548
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592582036;
	bh=GyawCehqGpm2VcAuaYavesS82XTSN3Zi4tiNLnMQVpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=we9d3LuJvB40y8abIGYEmRAlY7tXfk2WpRYVKi/B08qtnuIiiBoyylwdukvMavdmF
	 m+YnL+9/CIa4YVH9L1LsiLdH/OpAMWUE5yPrTXb1JuVKPqkJj2BMFPmW9i0m7Dsq/Y
	 VlO9jdFMxPt6PRyQTjoWMjmnMP3O26IX7r/4Qh+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405423AbgFSPxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:53:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392963AbgFSPWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:22:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76D922158C;
        Fri, 19 Jun 2020 15:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580133;
        bh=GyawCehqGpm2VcAuaYavesS82XTSN3Zi4tiNLnMQVpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LcsjT9JZO6TEvOZLEMxnQLBJF/aA+8F+OzPmVdo4QN3cfxt7bEEiYq/eqsITjg/xb
         0ESB8dnlcSRU2lobcxPoBk5YwCrO0S10A1JQL8yWNw+5qEq8kgyO9nSBgOrV4a4KHz
         oYPWYaWdpBshJIuiC7drFzxsA6buBbjI1+bACxzs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roi Dayan <roid@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 134/376] net/mlx5e: CT: Avoid false warning about rule may be used uninitialized
Date:   Fri, 19 Jun 2020 16:30:52 +0200
Message-Id: <20200619141716.679086744@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roi Dayan <roid@mellanox.com>

[ Upstream commit 70a5698a5683cd504b03c6030ee622b1bec3f702 ]

Avoid gcc warning by preset rule to invalid ptr.

Fixes: 4c3844d9e97e ("net/mlx5e: CT: Introduce connection tracking")
Signed-off-by: Roi Dayan <roid@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index 153d6eb19d3c..470282daed19 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -1132,7 +1132,7 @@ mlx5_tc_ct_flow_offload(struct mlx5e_priv *priv,
 {
 	bool clear_action = attr->ct_attr.ct_action & TCA_CT_ACT_CLEAR;
 	struct mlx5_tc_ct_priv *ct_priv = mlx5_tc_ct_get_ct_priv(priv);
-	struct mlx5_flow_handle *rule;
+	struct mlx5_flow_handle *rule = ERR_PTR(-EINVAL);
 	int err;
 
 	if (!ct_priv)
-- 
2.25.1



