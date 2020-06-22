Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B3EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43851206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgFVKyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 06:54:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6382 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727024AbgFVKyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 06:54:12 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DD2B3CE1167AFCF01F41;
        Mon, 22 Jun 2020 18:54:09 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.232) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 22 Jun 2020 18:54:01 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Seth Jennings <sjenning@redhat.com>,
        "Dan Streetman" <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Subject: [PATCH] mm/zswap: careful error path implementation in comp_prepare
Date:   Mon, 22 Jun 2020 22:52:28 +1200
Message-ID: <20200622105228.17720-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.232]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free the allocated memory and resource while an error occurs.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller" <davem@davemloft.net>
Cc: Seth Jennings <sjenning@redhat.com>
Cc: Dan Streetman <ddstreet@ieee.org>
Cc: Vitaly Wool <vitaly.wool@konsulko.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v1: an incremental patch againest linux-next to fix the issue pointed
      out by Vitaly

 mm/zswap.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 0d914ba6b4a0..c0a85ef46610 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -428,28 +428,31 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 	struct crypto_acomp *acomp;
 	struct acomp_req *req;
 	struct crypto_acomp_ctx *acomp_ctx;
+	int ret;
 
 	if (WARN_ON(*per_cpu_ptr(pool->acomp_ctx, cpu)))
 		return 0;
 
 	acomp_ctx = kzalloc(sizeof(*acomp_ctx), GFP_KERNEL);
-	if (IS_ERR_OR_NULL(acomp_ctx)) {
-		pr_err("Could not initialize acomp_ctx\n");
+	if (!acomp_ctx) {
+		pr_err("Could not allocate acomp_ctx\n");
 		return -ENOMEM;
 	}
 	acomp = crypto_alloc_acomp(pool->tfm_name, 0, 0);
-	if (IS_ERR_OR_NULL(acomp)) {
+	if (IS_ERR(acomp)) {
 		pr_err("could not alloc crypto acomp %s : %ld\n",
 				pool->tfm_name, PTR_ERR(acomp));
-		return -ENOMEM;
+		ret = PTR_ERR(acomp);
+		goto free_ctx;
 	}
 	acomp_ctx->acomp = acomp;
 
 	req = acomp_request_alloc(acomp_ctx->acomp);
-	if (IS_ERR_OR_NULL(req)) {
-		pr_err("could not alloc crypto acomp %s : %ld\n",
-		       pool->tfm_name, PTR_ERR(acomp));
-		return -ENOMEM;
+	if (!req) {
+		pr_err("could not alloc crypto acomp_request %s\n",
+		       pool->tfm_name);
+		ret = -ENOMEM;
+		goto free_acomp;
 	}
 	acomp_ctx->req = req;
 
@@ -462,6 +465,12 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 	*per_cpu_ptr(pool->acomp_ctx, cpu) = acomp_ctx;
 
 	return 0;
+
+free_acomp:
+	crypto_free_acomp(acomp_ctx->acomp);
+free_ctx:
+	kfree(acomp_ctx);
+	return ret;
 }
 
 static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
-- 
2.27.0


