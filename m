Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8A1C34051
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D1724654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="OvI3GdWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgBSO2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:28:53 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38531 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgBSO2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:28:52 -0500
Received: by mail-qt1-f193.google.com with SMTP id i23so305403qtr.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 06:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=M/WOQ4dpD5ui5gn3HK5r3YR0sSK5JjTGZgiU8nuYjiY=;
        b=OvI3GdWaULkHM6L7NQNGiL1tt+87WC0aV1sO7nxEF6vXn1H1/McHlo6NEux0NpiDAE
         eXuxxl8CwvjBJoNkxUgLeXRQ4aM8Oohu6ZPrDF3WYVmrlm/ogr5eim0ZUrec2+Q3qq/A
         0szU0cwq2GMLj1y3zeR4BqAxDsbGXtzzp20Uc8506FOtPqSaBESxQc41R7gvT6ME+Yhh
         SPMHj4NjfddXYPjXpKc+9s39XhceWqbDYjFYErdd3LRFzIkYWqvfrokwF4C0kgYTXAjm
         4tGwt6qg4BPCS9o+GOkTe8X1NPkW6IX5oZ6miDSXl4NnrrBCciCnMCUEwoTTj2T1nlR1
         VrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M/WOQ4dpD5ui5gn3HK5r3YR0sSK5JjTGZgiU8nuYjiY=;
        b=Mtjqp0ZMXoCujedD9jUUo7TOAN+rD1imSLMBp7+1LHTsQWSpG/ZFBih30ZTUUvmDs4
         slKSpAzPsqWK80Q35v5wCJTUIPDjo9abjSxW1vG6c92MOb/mbsYeTzfxU4KgEeY8Cbzk
         NtNQNudFGGp/EJSC7yciC5w3VpA6cHnxEHbhgvMYD7P4DWobojfVKcwhrnZAlPKnjpnu
         4JDQ6hT9bGBZpGsO6jjx1hGqqYKhCajY0LYrcMIkyZ3nSf9/xgc4v7JhYS71Dejjf5dV
         a07lifHl7UOcD55nH45TN2hBSIzi2tEoMRUgNGWXszKSa7vzBFDNQi7mOzRNYYiEOvoH
         tgdQ==
X-Gm-Message-State: APjAAAVfUEDaZeFLMGx+LgMFWKq0oBqK8piNRoGdEL7I0syilHyy3V5l
        zVRN457TJnzxom60kGQwxKQAyg==
X-Google-Smtp-Source: APXvYqxF8mlRubt5qpCY+pnwXt0503TztKUdTJaSgYBmvl0/fQkuGgmQdfDCtpU4CZp7L7c9IZpvfg==
X-Received: by 2002:ac8:7765:: with SMTP id h5mr22389403qtu.223.1582122530154;
        Wed, 19 Feb 2020 06:28:50 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c26sm57012qtn.19.2020.02.19.06.28.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2020 06:28:49 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     paulmck@kernel.org
Cc:     akpm@linux-foundation.org, kirill@shutemov.name, elver@google.com,
        peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next v2] fork: annotate a data race in vm_area_dup()
Date:   Wed, 19 Feb 2020 09:28:15 -0500
Message-Id: <1582122495-12885-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

v2: Insert a few assertions thanks to Marco.
    Update the commit log thanks to Kirill.

 kernel/fork.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index cb2ae49e497e..67a5d691ffa8 100644
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
1.8.3.1

