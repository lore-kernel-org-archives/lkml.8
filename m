Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E00BC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA6652078C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588616066;
	bh=k62scmE/GZiKnp3l2l7zkJn0NgOpPJlV7ZzvKqtdrZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pwut/++U0tbQx7tSyBWc/PeLBjfGWxG6ORrQt8x89IumLJmv0b4a9gBT7Kv9EA6g/
	 1vRKKuaHWhW7pDppLhdx0K8Be6zPYqKhxeWV4am5Md+AVtoMliFpNivcKY8fD5fQH9
	 cTOsgmgXF8EDMVz0+HnQSN15HxNEWq9PID0beyjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbgEDSAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:00:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730994AbgEDSA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:00:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09B21206B8;
        Mon,  4 May 2020 18:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615226;
        bh=k62scmE/GZiKnp3l2l7zkJn0NgOpPJlV7ZzvKqtdrZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ArYokJSnEAO/l9xmqSkTUcPAp6tiaYDDmjqCNlfT+dzyCmPNYV8s3z+9g0VyXPkfm
         9UVqv1iAXnn2iawZdCbakBnl3mP8CN2EH05UrTD7Xfo9L+VVL/SCSTNSc7RcyBZgxt
         pgRZSZHJSEcJ5ObXhkNQ2ny0RzR7dDEULus/+I2U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alaa Hleihel <alaa@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.14 17/26] RDMA/mlx4: Initialize ib_spec on the stack
Date:   Mon,  4 May 2020 19:57:31 +0200
Message-Id: <20200504165446.326630840@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165442.494398840@linuxfoundation.org>
References: <20200504165442.494398840@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alaa Hleihel <alaa@mellanox.com>

commit c08cfb2d8d78bfe81b37cc6ba84f0875bddd0d5c upstream.

Initialize ib_spec on the stack before using it, otherwise we will have
garbage values that will break creating default rules with invalid parsing
error.

Fixes: a37a1a428431 ("IB/mlx4: Add mechanism to support flow steering over IB links")
Link: https://lore.kernel.org/r/20200413132235.930642-1-leon@kernel.org
Signed-off-by: Alaa Hleihel <alaa@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx4/main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1614,8 +1614,9 @@ static int __mlx4_ib_create_default_rule
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(pdefault_rules->rules_create_list); i++) {
+		union ib_flow_spec ib_spec = {};
 		int ret;
-		union ib_flow_spec ib_spec;
+
 		switch (pdefault_rules->rules_create_list[i]) {
 		case 0:
 			/* no rule */


