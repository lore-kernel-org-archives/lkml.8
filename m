Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A01C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 111DE206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592873034;
	bh=Z8+OD9VMW4gCybZppyhdhOmo/u9oJoDAvPRBgprvWcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qSit8ykXGwyfuejK7G5yC+dkcsouZ24HwWA0IlPJ8II2c91I4e5BmAXLqJS+YGBGZ
	 3BdiOOLsa9cHey/QvUt5u5x+EEsCg6pMSaLIhDs4gf7Ad9Vfb+Rk6he/ZSCZe7qbr4
	 zMXkeaEBEAMK9PpBBR7k6ts9XGEkGUfA9JR5Psho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732218AbgFWAnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:43:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731823AbgFWAnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:43:35 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 614CF20706;
        Tue, 23 Jun 2020 00:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592873015;
        bh=Z8+OD9VMW4gCybZppyhdhOmo/u9oJoDAvPRBgprvWcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r3mLacsz6toDbJfOlZYAmpiUmmeCaK414fBjFAQ1geDHQ9H0vtEnyhsv6PGLrji26
         2HhxyKkAKcJ43F8xCsRIY3+q3AullZF2ezGhaFJRjDdM1iP0UPb79P2Qb90nUcMhTT
         B9SoYrF6+Z2Yle0EbkTDMY08QbcvD3PX58wixRmQ=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/10] fork: Annotate a data race in vm_area_dup()
Date:   Mon, 22 Jun 2020 17:43:24 -0700
Message-Id: <20200623004333.27227-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>

struct vm_area_struct could be accessed concurrently as noticed by
KCSAN,

 write to 0xffff9cf8bba08ad8 of 8 bytes by task 14263 on cpu 35:
  vma_interval_tree_insert+0x101/0x150:
  rb_insert_augmented_cached at include/linux/rbtree_augmented.h:58
  (inlined by) vma_interval_tree_insert at mm/interval_tree.c:23
  __vma_link_file+0x6e/0xe0
  __vma_link_file at mm/mmap.c:629
  vma_link+0xa2/0x120
  mmap_region+0x753/0xb90
  do_mmap+0x45c/0x710
  vm_mmap_pgoff+0xc0/0x130
  ksys_mmap_pgoff+0x1d1/0x300
  __x64_sys_mmap+0x33/0x40
  do_syscall_64+0x91/0xc44
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

 read to 0xffff9cf8bba08a80 of 200 bytes by task 14262 on cpu 122:
  vm_area_dup+0x6a/0xe0
  vm_area_dup at kernel/fork.c:362
  __split_vma+0x72/0x2a0
  __split_vma at mm/mmap.c:2661
  split_vma+0x5a/0x80
  mprotect_fixup+0x368/0x3f0
  do_mprotect_pkey+0x263/0x420
  __x64_sys_mprotect+0x51/0x70
  do_syscall_64+0x91/0xc44
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

vm_area_dup() blindly copies all fields of original VMA to the new one.
This includes coping vm_area_struct::shared.rb which is normally
protected by i_mmap_lock. But this is fine because the read value will
be overwritten on the following __vma_link_file() under proper
protection. Thus, mark it as an intentional data race and insert a few
assertions for the fields that should not be modified concurrently.

Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/fork.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 142b236..bba10fb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -359,7 +359,13 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
 
 	if (new) {
-		*new = *orig;
+		ASSERT_EXCLUSIVE_WRITER(orig->vm_flags);
+		ASSERT_EXCLUSIVE_WRITER(orig->vm_file);
+		/*
+		 * orig->shared.rb may be modified concurrently, but the clone
+		 * will be reinitialized.
+		 */
+		*new = data_race(*orig);
 		INIT_LIST_HEAD(&new->anon_vma_chain);
 		new->vm_next = new->vm_prev = NULL;
 	}
-- 
2.9.5

