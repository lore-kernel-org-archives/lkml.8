Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97657C47258
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F1812073E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615349;
	bh=xAhcyASkKJoXAxQ5uQWDxeqCnS2LV7E91ZihB8sCoOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z7f8hTjs+IZA9xMXSzLF5tsLybd0p8vqMJH8vFkig6LfoJECab5br9RYZdbUJXpot
	 6PO1uddstr7R2417NJ0E+YAtFu6gH4OyNneBcXw82Hxr5yxfRVa4+FZEU+D6nThbQK
	 Hd1u0qFxFLsZtB73qrnOJLvTCjE5Es/t8P3HwMhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbgEDSC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730810AbgEDSC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:02:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DD0E206B8;
        Mon,  4 May 2020 18:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615345;
        bh=xAhcyASkKJoXAxQ5uQWDxeqCnS2LV7E91ZihB8sCoOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2t5EOsUoQXkN80OahgNInVeynBW360JpZlEcwonXwFy6o0sPjz6yBgCSodtIX7Kgr
         Tn6qZfeP3E76jeFu6d7uKUzMT7tseSs0erKWCBMroT5RZBf8+3WmwgkPYAjLh9mQz/
         SDOvYRW4nBfKOQvWi4MUju7MdCKOJvWSN9l9I+Fk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alaa Hleihel <alaa@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.19 18/37] RDMA/mlx4: Initialize ib_spec on the stack
Date:   Mon,  4 May 2020 19:57:31 +0200
Message-Id: <20200504165450.276430232@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165448.264746645@linuxfoundation.org>
References: <20200504165448.264746645@linuxfoundation.org>
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
@@ -1606,8 +1606,9 @@ static int __mlx4_ib_create_default_rule
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(pdefault_rules->rules_create_list); i++) {
+		union ib_flow_spec ib_spec = {};
 		int ret;
-		union ib_flow_spec ib_spec;
+
 		switch (pdefault_rules->rules_create_list[i]) {
 		case 0:
 			/* no rule */


