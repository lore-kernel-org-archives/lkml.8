Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F3BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC19220809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592582165;
	bh=rza3GijJEHiYQS6naUd/LTVSyFhudYeYmLttrcZ8jOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kDjMIuV4ekWKLAmjS/5ILyolKBDznQbYjgoiZ3TZFwfpRKApy9Je3H45K9U6K3NZK
	 GVhEU1HgmvUIobHDHQxMZ0jKx4PEC/NLvyg7bStJ+3oh92OBUi1r9qiggWhGLK5fqA
	 WABAKyIt6aw+3iDOaufpDsf6c7iZvp7RPUzHIRDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392799AbgFSPVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:21:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392588AbgFSPS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:18:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1E3021582;
        Fri, 19 Jun 2020 15:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579908;
        bh=rza3GijJEHiYQS6naUd/LTVSyFhudYeYmLttrcZ8jOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vdYpkWoGPX7sm30PUGvdIgiZhMSrdD6WXofyy/BcEUnJqP9KS8V/JnOXp62IBkUrk
         D6NzUFH8kCKweP0v/N2fG94wAUpN6yrh2j+D1LQ0QqMh5DDGQtNsQWa8/wZnPFuV6t
         e/9oTWvc3jbsWiFs2dL05eTWZDgNVhkfi1OKMF1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 019/376] net: ethernet: ti: fix return value check in k3_cppi_desc_pool_create_name()
Date:   Fri, 19 Jun 2020 16:28:57 +0200
Message-Id: <20200619141711.271206582@linuxfoundation.org>
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

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 2ac757e4152e3322a04a6dfb3d1fa010d3521abf ]

In case of error, the function gen_pool_create() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/k3-cppi-desc-pool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
index ad7cfc1316ce..38cc12f9f133 100644
--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
@@ -64,8 +64,8 @@ k3_cppi_desc_pool_create_name(struct device *dev, size_t size,
 		return ERR_PTR(-ENOMEM);
 
 	pool->gen_pool = gen_pool_create(ilog2(pool->desc_size), -1);
-	if (IS_ERR(pool->gen_pool)) {
-		ret = PTR_ERR(pool->gen_pool);
+	if (!pool->gen_pool) {
+		ret = -ENOMEM;
 		dev_err(pool->dev, "pool create failed %d\n", ret);
 		kfree_const(pool_name);
 		goto gen_pool_create_fail;
-- 
2.25.1



