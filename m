Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B805C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529C720775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgCXKcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:32:16 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:52655 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbgCXKcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:32:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0TtVTLwS_1585045921;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0TtVTLwS_1585045921)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Mar 2020 18:32:06 +0800
From:   Hui Zhu <teawater@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, hughd@google.com,
        yang.shi@linux.alibaba.com, kirill@shutemov.name,
        dan.j.williams@intel.com, aneesh.kumar@linux.ibm.com,
        sean.j.christopherson@intel.com, thellstrom@vmware.com,
        guro@fb.com, shakeelb@google.com, chris@chrisdown.name,
        tj@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Hui Zhu <teawater@gmail.com>, Hui Zhu <teawaterz@linux.alibaba.com>
Subject: [PATCH] mm, memcg: Add memory.transparent_hugepage_disabled
Date:   Tue, 24 Mar 2020 18:31:56 +0800
Message-Id: <1585045916-27339-1-git-send-email-teawater@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/sys/kernel/mm/transparent_hugepage/enabled is the only interface to
control if the application can use THP in system level.
Sometime, we would not want an application use THP even if
transparent_hugepage/enabled is set to "always" or "madvise" because
thp may need more cpu and memory resources in some cases.

This commit add a new interface memory.transparent_hugepage_disabled
in memcg.
When it set to 1, the application inside the cgroup cannot use THP
except dax.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 include/linux/huge_mm.h    | 18 ++++++++++++++++--
 include/linux/memcontrol.h |  2 ++
 mm/memcontrol.c            | 42 ++++++++++++++++++++++++++++++++++++++++++
 mm/shmem.c                 |  4 ++++
 4 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 5aca3d1..fd81479 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -91,6 +91,16 @@ extern bool is_vma_temporary_stack(struct vm_area_struct *vma);
 
 extern unsigned long transparent_hugepage_flags;
 
+#ifdef CONFIG_MEMCG
+extern bool memcg_transparent_hugepage_disabled(struct vm_area_struct *vma);
+#else
+static inline bool
+memcg_transparent_hugepage_disabled(struct vm_area_struct *vma)
+{
+	return false;
+}
+#endif
+
 /*
  * to be used on vmas which are known to support THP.
  * Use transparent_hugepage_enabled otherwise
@@ -106,8 +116,6 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 	if (test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
 		return false;
 
-	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
-		return true;
 	/*
 	 * For dax vmas, try to always use hugepage mappings. If the kernel does
 	 * not support hugepages, fsdax mappings will fallback to PAGE_SIZE
@@ -117,6 +125,12 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 	if (vma_is_dax(vma))
 		return true;
 
+	if (memcg_transparent_hugepage_disabled(vma))
+		return false;
+
+	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
+		return true;
+
 	if (transparent_hugepage_flags &
 				(1 << TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG))
 		return !!(vma->vm_flags & VM_HUGEPAGE);
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a7a0a1a5..abc3142 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -320,6 +320,8 @@ struct mem_cgroup {
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	struct deferred_split deferred_split_queue;
+
+	bool transparent_hugepage_disabled;
 #endif
 
 	struct mem_cgroup_per_node *nodeinfo[0];
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7a4bd8b..b6d91b6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5011,6 +5011,14 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	if (parent) {
 		memcg->swappiness = mem_cgroup_swappiness(parent);
 		memcg->oom_kill_disable = parent->oom_kill_disable;
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+		memcg->transparent_hugepage_disabled
+			= parent->transparent_hugepage_disabled;
+#endif
+	} else {
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+		memcg->transparent_hugepage_disabled = false;
+#endif
 	}
 	if (parent && parent->use_hierarchy) {
 		memcg->use_hierarchy = true;
@@ -6126,6 +6134,24 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+static u64 transparent_hugepage_disabled_read(struct cgroup_subsys_state *css,
+					      struct cftype *cft)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+
+	return memcg->transparent_hugepage_disabled;
+}
+
+static int transparent_hugepage_disabled_write(struct cgroup_subsys_state *css,
+					       struct cftype *cft, u64 val)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+
+	memcg->transparent_hugepage_disabled = !!val;
+
+	return 0;
+}
+
 static struct cftype memory_files[] = {
 	{
 		.name = "current",
@@ -6179,6 +6205,12 @@ static struct cftype memory_files[] = {
 		.seq_show = memory_oom_group_show,
 		.write = memory_oom_group_write,
 	},
+	{
+		.name = "transparent_hugepage_disabled",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = transparent_hugepage_disabled_read,
+		.write_u64 = transparent_hugepage_disabled_write,
+	},
 	{ }	/* terminate */
 };
 
@@ -6787,6 +6819,16 @@ void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
 	refill_stock(memcg, nr_pages);
 }
 
+bool memcg_transparent_hugepage_disabled(struct vm_area_struct *vma)
+{
+	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(vma->vm_mm);
+
+	if (memcg && memcg->transparent_hugepage_disabled)
+		return true;
+
+	return false;
+}
+
 static int __init cgroup_memory(char *s)
 {
 	char *token;
diff --git a/mm/shmem.c b/mm/shmem.c
index aad3ba7..253b63b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1810,6 +1810,10 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 		goto alloc_nohuge;
 	if (shmem_huge == SHMEM_HUGE_DENY || sgp_huge == SGP_NOHUGE)
 		goto alloc_nohuge;
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (memcg_transparent_hugepage_disabled(vma))
+		goto alloc_nohuge;
+#endif
 	if (shmem_huge == SHMEM_HUGE_FORCE)
 		goto alloc_huge;
 	switch (sbinfo->huge) {
-- 
2.7.4

