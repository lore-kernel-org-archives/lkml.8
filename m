Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712E4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC4E2076C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591664960;
	bh=rza3GijJEHiYQS6naUd/LTVSyFhudYeYmLttrcZ8jOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CY+ZOB2QUoyjyfa7tLCvY7AyECcN0zSUIATBh8vg1lqNm//GuHgeAEcDkVFrec1lc
	 2Trg865C/6eTTfWK2dZ/catxacQ5gIixpe7RgsuOzsW6sDF8w4ybrMi0Xg9cRv1yMh
	 s/JfQUNoom691LyL42fDY16LT+epFRB5maFgNHcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbgFIBJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 21:09:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgFHXGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:06:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 822692078C;
        Mon,  8 Jun 2020 23:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657594;
        bh=rza3GijJEHiYQS6naUd/LTVSyFhudYeYmLttrcZ8jOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O5eG3ktZYMifgzMt7m0OJalm0RkBxpin3ruCipnjkVYysg0fCbvAi2VkClacudXeL
         dQBuC5nVZPrtyTWSZu66XrHe6ElomP9UtCc3h7qwheqiU/cLXWuLfLN93hVyGDhQnS
         wxi7uXBGm9H7trsXE7Jupq0EEZSyUXlpHR2IdxnA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 021/274] net: ethernet: ti: fix return value check in k3_cppi_desc_pool_create_name()
Date:   Mon,  8 Jun 2020 19:01:54 -0400
Message-Id: <20200608230607.3361041-21-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

