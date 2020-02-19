Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07230C169F9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABD024672
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582139066;
	bh=mezGysAMCe50aogHaA5sl++kWa73c/LuEVAzNwLfPVQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=l+d4AfaadcEWZNsNF7FKFVRGg8YxRZuBSfOQ3DPEfZUrbo0Xy+G35CRTFVFnUxVvZ
	 yZSoYefm2+LfH+mASLyad6BYLm2L0Wd0QdS5VMss2yIIIKIPUYAr7lXxsVtPwJuxXs
	 CpCefdYz5GQIwdM3XTa8W8HZHH4PKaJPoC2e8o4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgBSTEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:04:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:41478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgBSTEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:04:25 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B85A7206DB;
        Wed, 19 Feb 2020 19:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582139063;
        bh=mezGysAMCe50aogHaA5sl++kWa73c/LuEVAzNwLfPVQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PFi6l+Ns2YnYnF3DJ3EE/KGh6WUog0ugjnK0XQt/MjpfflUUNyfO8/AK8xKptXr1o
         mvEKmKSzQyOIUIbSvexr/dZVL6VRcSRXXmywgferlUkefCORd5jCByI560cUCmBlWI
         kYgvy2kBxq7GYvSyeV7e4YWYswiCNRtrcxAonH6Q=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8FB263520BB6; Wed, 19 Feb 2020 11:04:23 -0800 (PST)
Date:   Wed, 19 Feb 2020 11:04:23 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, kirill@shutemov.name, elver@google.com,
        peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] fork: annotate a data race in vm_area_dup()
Message-ID: <20200219190423.GN2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1582122495-12885-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582122495-12885-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 09:28:15AM -0500, Qian Cai wrote:
> struct vm_area_struct could be accessed concurrently as noticed by
> KCSAN,
> 
>  write to 0xffff9cf8bba08ad8 of 8 bytes by task 14263 on cpu 35:
>   vma_interval_tree_insert+0x101/0x150:
>   rb_insert_augmented_cached at include/linux/rbtree_augmented.h:58
>   (inlined by) vma_interval_tree_insert at mm/interval_tree.c:23
>   __vma_link_file+0x6e/0xe0
>   __vma_link_file at mm/mmap.c:629
>   vma_link+0xa2/0x120
>   mmap_region+0x753/0xb90
>   do_mmap+0x45c/0x710
>   vm_mmap_pgoff+0xc0/0x130
>   ksys_mmap_pgoff+0x1d1/0x300
>   __x64_sys_mmap+0x33/0x40
>   do_syscall_64+0x91/0xc44
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>  read to 0xffff9cf8bba08a80 of 200 bytes by task 14262 on cpu 122:
>   vm_area_dup+0x6a/0xe0
>   vm_area_dup at kernel/fork.c:362
>   __split_vma+0x72/0x2a0
>   __split_vma at mm/mmap.c:2661
>   split_vma+0x5a/0x80
>   mprotect_fixup+0x368/0x3f0
>   do_mprotect_pkey+0x263/0x420
>   __x64_sys_mprotect+0x51/0x70
>   do_syscall_64+0x91/0xc44
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> vm_area_dup() blindly copies all fields of original VMA to the new one.
> This includes coping vm_area_struct::shared.rb which is normally
> protected by i_mmap_lock. But this is fine because the read value will
> be overwritten on the following __vma_link_file() under proper
> protection. Thus, mark it as an intentional data race and insert a few
> assertions for the fields that should not be modified concurrently.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Queued for safekeeping on -rcu.  I had to adjust a bit to get it to
apply on -rcu, please see below.  In my experience, git should have
no trouble figuring it out.  ;-)

							Thanx, Paul

------------------------------------------------------------------------

commit 1228aca56f2a25b67876d8a819437b620a6e1cee
Author: Qian Cai <cai@lca.pw>
Date:   Wed Feb 19 11:00:54 2020 -0800

    fork: Annotate a data race in vm_area_dup()
    
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

diff --git a/kernel/fork.c b/kernel/fork.c
index 60a1295..e592e6f 100644
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
 	}
 	return new;
