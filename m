Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F46C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3DB520715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824631;
	bh=xtTsyYfsgItSKEaBHLrJ0+2xE14hvp9SsYBsLBVY7Ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kUwuZhKhCfXjHs9VeOJ1ZsqAyghmWRGCBS6RJa4QwT7XRwwIbUSMes4J7+WnIxLz/
	 QXAiZWaYatlI+Nl9JXUEr0QzMWs0Auxg6lV8Rk3OCwvcC4FwcNToOJXqWoqdCFems+
	 A9/bIEX1RjWk3l2DyV6TcL1uJMjBGcRuN/5IwaD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbgERR5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:57:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731735AbgERR5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:57:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94E3920715;
        Mon, 18 May 2020 17:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824625;
        bh=xtTsyYfsgItSKEaBHLrJ0+2xE14hvp9SsYBsLBVY7Ds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MLp94sijjGfTfaMx189pJyK/wNlA0DQdKFt3lYd21y6emPMY4N5RIUoAzwkn5CBjr
         4/gBa+cKTbXRtnb64++zc/BCV183S7/oeVkOYcZjbGue7BF+lngp2cVR2KY6ydELhn
         GpCpYRY8dTrwFa3soNqyA8nm9MjRJ3rEMnWzT28U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 087/147] RDMA/core: Fix double put of resource
Date:   Mon, 18 May 2020 19:36:50 +0200
Message-Id: <20200518173524.410646270@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173513.009514388@linuxfoundation.org>
References: <20200518173513.009514388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 50bbe3d34fea74b7c0fabe553c40c2f4a48bb9c3 ]

Do not decrease the reference count of resource tracker object twice in
the error flow of res_get_common_doit.

Fixes: c5dfe0ea6ffa ("RDMA/nldev: Add resource tracker doit callback")
Link: https://lore.kernel.org/r/20200507062942.98305-1-leon@kernel.org
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/nldev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index ef4b0c7061e4c..244ebf285fc3f 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1248,10 +1248,10 @@ static int res_get_common_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	has_cap_net_admin = netlink_capable(skb, CAP_NET_ADMIN);
 	ret = fe->fill_res_func(msg, has_cap_net_admin, res, port);
-	rdma_restrack_put(res);
 	if (ret)
 		goto err_free;
 
+	rdma_restrack_put(res);
 	nlmsg_end(msg, nlh);
 	ib_device_put(device);
 	return rdma_nl_unicast(sock_net(skb->sk), msg, NETLINK_CB(skb).portid);
-- 
2.20.1



