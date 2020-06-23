Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD7DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28D8F21531
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944758;
	bh=DrZu0NMmSZMIz0xH6G9+APbQxnDbr+G3aSdiLuebcDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N+Hx+DbI/T7b0kxUBS2uTQ7MvCSq9rYfnUGi9L4bzrmN4S7lxyQhVgdW3fhvRKQ8H
	 h9N4aBx+cArS89hm5GlzOYKF2SuB5O3bxwuoXy2E2hgYqyNa1werytHvCVzsaOjDXl
	 rWUlCfe3xY+SbAP+b1Cz+XtZdpGNeIf1Qyn7h1dA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392035AbgFWUjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:39:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392021AbgFWUjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:39:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C7A221531;
        Tue, 23 Jun 2020 20:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944750;
        bh=DrZu0NMmSZMIz0xH6G9+APbQxnDbr+G3aSdiLuebcDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BI6sI5BAbHyBFm8mQgkgsTaROoP36XosPZSzSCAJZihkos2qMNnSR4VTE+BQzDS0k
         cV0H/g8GkuVWm1qzWyElTCHCJdAR6xNwdOPbSsvrmS4Z7fFj+tOPm1llmnEYZYPTUr
         1lbn3x4YitZwER/K8wdSJ6P/zr7PwzqB4ISLwPmk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Potnuri Bharat Teja <bharat@chelsio.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 111/206] RDMA/iw_cxgb4: cleanup device debugfs entries on ULD remove
Date:   Tue, 23 Jun 2020 21:57:19 +0200
Message-Id: <20200623195322.404205831@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Potnuri Bharat Teja <bharat@chelsio.com>

[ Upstream commit 49ea0c036ede81f126f1a9389d377999fdf5c5a1 ]

Remove device specific debugfs entries immediately if LLD detaches a
particular ULD device in case of fatal PCI errors.

Link: https://lore.kernel.org/r/20200524190814.17599-1-bharat@chelsio.com
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/cxgb4/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/cxgb4/device.c
index c13c0ba30f63e..af974a2570862 100644
--- a/drivers/infiniband/hw/cxgb4/device.c
+++ b/drivers/infiniband/hw/cxgb4/device.c
@@ -945,6 +945,7 @@ void c4iw_dealloc(struct uld_ctx *ctx)
 static void c4iw_remove(struct uld_ctx *ctx)
 {
 	pr_debug("c4iw_dev %p\n", ctx->dev);
+	debugfs_remove_recursive(ctx->dev->debugfs_root);
 	c4iw_unregister_device(ctx->dev);
 	c4iw_dealloc(ctx);
 }
-- 
2.25.1



