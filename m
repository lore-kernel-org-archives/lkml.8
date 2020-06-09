Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2040C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB3C2078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbgFIOS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:18:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42004 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726967AbgFIOS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:18:57 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E58AA6A53D90B98A796E;
        Tue,  9 Jun 2020 22:18:51 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 9 Jun 2020
 22:18:44 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <gerrit@erg.abdn.ac.uk>,
        <posk@google.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dccp@vger.kernel.org>, <wanghai38@huawei.com>
Subject: [PATCH] dccp: Fix possible memleak in dccp_init and dccp_fini
Date:   Tue, 9 Jun 2020 22:18:16 +0800
Message-ID: <20200609141816.33467-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some memory leaks in dccp_init() and dccp_fini().

In dccp_fini() and the error handling path in dccp_init(), free lhash2
is missing. Add inet_hashinfo2_free_mod() to do it.

If inet_hashinfo2_init_mod() failed in dccp_init(),
percpu_counter_destroy() should be called to destroy dccp_orphan_count.
It need to goto out_free_percpu when inet_hashinfo2_init_mod() failed.

Fixes: c92c81df93df ("net: dccp: fix kernel crash on module load")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 include/net/inet_hashtables.h | 6 ++++++
 net/dccp/proto.c              | 7 +++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index ad64ba6..9256097 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -185,6 +185,12 @@ static inline spinlock_t *inet_ehash_lockp(
 
 int inet_ehash_locks_alloc(struct inet_hashinfo *hashinfo);
 
+static inline void inet_hashinfo2_free_mod(struct inet_hashinfo *h)
+{
+	kfree(h->lhash2);
+	h->lhash2 = NULL;
+}
+
 static inline void inet_ehash_locks_free(struct inet_hashinfo *hashinfo)
 {
 	kvfree(hashinfo->ehash_locks);
diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index 4af8a98..c13b660 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -1139,14 +1139,14 @@ static int __init dccp_init(void)
 	inet_hashinfo_init(&dccp_hashinfo);
 	rc = inet_hashinfo2_init_mod(&dccp_hashinfo);
 	if (rc)
-		goto out_fail;
+		goto out_free_percpu;
 	rc = -ENOBUFS;
 	dccp_hashinfo.bind_bucket_cachep =
 		kmem_cache_create("dccp_bind_bucket",
 				  sizeof(struct inet_bind_bucket), 0,
 				  SLAB_HWCACHE_ALIGN, NULL);
 	if (!dccp_hashinfo.bind_bucket_cachep)
-		goto out_free_percpu;
+		goto out_free_hashinfo2;
 
 	/*
 	 * Size and allocate the main established and bind bucket
@@ -1242,6 +1242,8 @@ static int __init dccp_init(void)
 	free_pages((unsigned long)dccp_hashinfo.ehash, ehash_order);
 out_free_bind_bucket_cachep:
 	kmem_cache_destroy(dccp_hashinfo.bind_bucket_cachep);
+out_free_hashinfo2:
+	inet_hashinfo2_free_mod(&dccp_hashinfo);
 out_free_percpu:
 	percpu_counter_destroy(&dccp_orphan_count);
 out_fail:
@@ -1265,6 +1267,7 @@ static void __exit dccp_fini(void)
 	kmem_cache_destroy(dccp_hashinfo.bind_bucket_cachep);
 	dccp_ackvec_exit();
 	dccp_sysctl_exit();
+	inet_hashinfo2_free_mod(&dccp_hashinfo);
 	percpu_counter_destroy(&dccp_orphan_count);
 }
 
-- 
1.8.3.1

