Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9866C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD1BA20771
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHMItv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:49:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9278 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726081AbgHMItv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:49:51 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2A4F769E3430D62507E1;
        Thu, 13 Aug 2020 16:49:47 +0800 (CST)
Received: from DESKTOP-A9S207P.china.huawei.com (10.174.179.61) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 13 Aug 2020 16:49:40 +0800
From:   <wuyun.wu@huawei.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
CC:     <hewenliang4@huawei.com>, <hushiyuan@huawei.com>,
        Abel Wu <wuyun.wu@huawei.com>,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/slub: sysfs cleanup on cpu partial when !SLUB_CPU_PARTIAL
Date:   Thu, 13 Aug 2020 16:48:54 +0800
Message-ID: <20200813084858.1494-1-wuyun.wu@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Wu <wuyun.wu@huawei.com>

Hide cpu partial related sysfs entries when !CONFIG_SLUB_CPU_PARTIAL to
avoid confusion.

Signed-off-by: Abel Wu <wuyun.wu@huawei.com>
---
 mm/slub.c | 56 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 5d89e4064f83..4f496ae5a820 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5071,29 +5071,6 @@ static ssize_t min_partial_store(struct kmem_cache *s, const char *buf,
 }
 SLAB_ATTR(min_partial);
 
-static ssize_t cpu_partial_show(struct kmem_cache *s, char *buf)
-{
-	return sprintf(buf, "%u\n", slub_cpu_partial(s));
-}
-
-static ssize_t cpu_partial_store(struct kmem_cache *s, const char *buf,
-				 size_t length)
-{
-	unsigned int objects;
-	int err;
-
-	err = kstrtouint(buf, 10, &objects);
-	if (err)
-		return err;
-	if (objects && !kmem_cache_has_cpu_partial(s))
-		return -EINVAL;
-
-	slub_set_cpu_partial(s, objects);
-	flush_all(s);
-	return length;
-}
-SLAB_ATTR(cpu_partial);
-
 static ssize_t ctor_show(struct kmem_cache *s, char *buf)
 {
 	if (!s->ctor)
@@ -5132,6 +5109,30 @@ static ssize_t objects_partial_show(struct kmem_cache *s, char *buf)
 }
 SLAB_ATTR_RO(objects_partial);
 
+#ifdef CONFIG_SLUB_CPU_PARTIAL
+static ssize_t cpu_partial_show(struct kmem_cache *s, char *buf)
+{
+	return sprintf(buf, "%u\n", slub_cpu_partial(s));
+}
+
+static ssize_t cpu_partial_store(struct kmem_cache *s, const char *buf,
+				 size_t length)
+{
+	unsigned int objects;
+	int err;
+
+	err = kstrtouint(buf, 10, &objects);
+	if (err)
+		return err;
+	if (objects && !kmem_cache_has_cpu_partial(s))
+		return -EINVAL;
+
+	slub_set_cpu_partial(s, objects);
+	flush_all(s);
+	return length;
+}
+SLAB_ATTR(cpu_partial);
+
 static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
 {
 	int objects = 0;
@@ -5166,6 +5167,7 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
 	return len + sprintf(buf + len, "\n");
 }
 SLAB_ATTR_RO(slabs_cpu_partial);
+#endif
 
 static ssize_t reclaim_account_show(struct kmem_cache *s, char *buf)
 {
@@ -5496,10 +5498,12 @@ STAT_ATTR(DEACTIVATE_BYPASS, deactivate_bypass);
 STAT_ATTR(ORDER_FALLBACK, order_fallback);
 STAT_ATTR(CMPXCHG_DOUBLE_CPU_FAIL, cmpxchg_double_cpu_fail);
 STAT_ATTR(CMPXCHG_DOUBLE_FAIL, cmpxchg_double_fail);
+#ifdef CONFIG_SLUB_CPU_PARTIAL
 STAT_ATTR(CPU_PARTIAL_ALLOC, cpu_partial_alloc);
 STAT_ATTR(CPU_PARTIAL_FREE, cpu_partial_free);
 STAT_ATTR(CPU_PARTIAL_NODE, cpu_partial_node);
 STAT_ATTR(CPU_PARTIAL_DRAIN, cpu_partial_drain);
+#endif
 #endif	/* CONFIG_SLUB_STATS */
 
 static struct attribute *slab_attrs[] = {
@@ -5508,7 +5512,6 @@ static struct attribute *slab_attrs[] = {
 	&objs_per_slab_attr.attr,
 	&order_attr.attr,
 	&min_partial_attr.attr,
-	&cpu_partial_attr.attr,
 	&objects_attr.attr,
 	&objects_partial_attr.attr,
 	&partial_attr.attr,
@@ -5520,7 +5523,10 @@ static struct attribute *slab_attrs[] = {
 	&reclaim_account_attr.attr,
 	&destroy_by_rcu_attr.attr,
 	&shrink_attr.attr,
+#ifdef CONFIG_SLUB_CPU_PARTIAL
+	&cpu_partial_attr.attr,
 	&slabs_cpu_partial_attr.attr,
+#endif
 #ifdef CONFIG_SLUB_DEBUG
 	&total_objects_attr.attr,
 	&slabs_attr.attr,
@@ -5562,11 +5568,13 @@ static struct attribute *slab_attrs[] = {
 	&order_fallback_attr.attr,
 	&cmpxchg_double_fail_attr.attr,
 	&cmpxchg_double_cpu_fail_attr.attr,
+#ifdef CONFIG_SLUB_CPU_PARTIAL
 	&cpu_partial_alloc_attr.attr,
 	&cpu_partial_free_attr.attr,
 	&cpu_partial_node_attr.attr,
 	&cpu_partial_drain_attr.attr,
 #endif
+#endif
 #ifdef CONFIG_FAILSLAB
 	&failslab_attr.attr,
 #endif
-- 
2.28.0.windows.1

