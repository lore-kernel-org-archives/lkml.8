Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D41FC3B1BF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166C624649
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="sjIUvkrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbgBNUdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:33:41 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43562 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730005AbgBNUdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:33:41 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so7853520qtj.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=utuuKup5LPG796OspCxT2KOedNLQisnMmifEVidt+tA=;
        b=sjIUvkrE9OQgMUIDitVEp37YqU2yJhK8JAzMi9of98q4BS8b5IUla33MvC49S7FPQn
         eMu+4QizwQK4DKvwM2ByOMRATGQv9tjlG4ChxzZdwKKqQ9KTiQDfgm92d9q3zNyKPZ/K
         O/FAde970kkXvyahHPJMZKw5aKBX9YwQSulTCD6kL7zwk+YULf+VbhYpFtlz4J7rNRWY
         pGu8Mh5fxhdJSaSA78adT8bLU2DOnpVoVTW+IRmT53h/elKdizX7INy4xdv69FE38EK0
         Wv4U8hhh31hiswvLH5EMHRjWaThyar9rTZ2zmea4QYNP1TLnqivImZnS+Ph105rqXY/b
         vpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=utuuKup5LPG796OspCxT2KOedNLQisnMmifEVidt+tA=;
        b=nDAl1G1xRlXePqW++7TpqzQe2mlBX/NvlycvayO0YXn+S+DqQwnf9gtOsbKpM92BMu
         9Kl/jOqqztAq2JR9N575ACbAnDL1IdTxM+j3Am+U0zH0OZG87cmzkbReE6G0wYwQmoUq
         vf7sOGkx5p4fPwFXuOrhNjuoADf4r0HfsQTVmWMzs02H24YYqpNBSQhUCaKLsDARkJiG
         fLo/uBahcZstBU3Q8i//hq2virV81eHcGLmSWeaScJMCrRVsD2UBHLKgqEf3NNOpT/kk
         +8SZ8mkaquqCfaqAmFuBgLK9lpjUEKe9IpL0vGoh356Ze5Ld7NHCCipMU7/HICYpFiWp
         syKQ==
X-Gm-Message-State: APjAAAWW1wZSuJ12tjVQlc7faD67tH/SYQHWUB2XwpKuQiE+L5bdBITk
        gXO75fIXaxSn4vqj9wq/5EWC8w==
X-Google-Smtp-Source: APXvYqzp0yEutPBy8OYKLKKPHZiW/W3QbOXwwJbuUuTg+0yaqq+Km4hVxuoJ2ybYHCYhE2i+2V0wQQ==
X-Received: by 2002:ac8:7392:: with SMTP id t18mr3874950qtp.332.1581712418467;
        Fri, 14 Feb 2020 12:33:38 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l184sm3926233qkc.107.2020.02.14.12.33.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 12:33:37 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     elver@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] fork: annotate a data race in vm_area_dup()
Date:   Fri, 14 Feb 2020 15:33:23 -0500
Message-Id: <1581712403-27243-1-git-send-email-cai@lca.pw>
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

The write is holding mmap_sem while changing vm_area_struct.shared.rb.
Even though the read is lockless while making a copy, the clone will
have its own shared.rb reinitialized. Thus, mark it as an intentional
data race using the data_race() macro.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/fork.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 41f784b6203a..81bdc6e8a6cf 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -359,7 +359,11 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
 
 	if (new) {
-		*new = *orig;
+		/*
+		 * @orig may be modified concurrently, but the clone will be
+		 * reinitialized.
+		 */
+		*new = data_race(*orig);
 		INIT_LIST_HEAD(&new->anon_vma_chain);
 	}
 	return new;
-- 
1.8.3.1

