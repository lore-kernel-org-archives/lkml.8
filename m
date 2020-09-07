Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5647AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AAB62080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHU9kBGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbgIGQcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbgIGOWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:22:03 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DB8C061795
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 07:21:36 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n25so5417295ljj.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 07:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BIw9xe+LuyILTEIl1MT4esh/VJREnfS5b/q2dSYvFyA=;
        b=AHU9kBGOz4UTopqSe0MoQzCNlxZF7psWWAbHDXLOqCekd+0vrlXJWTFAR3eJRnCKjc
         DEpeXR3Tw4PUFDSW1bSyYarpC8r5wm04hB+h9Y6MAtBfpS9WMb/unud/Q2fXISJH7uah
         DxL5ploKwR/eXWmMhNwsIpGLJONxjmHRx8FFw2CJUpxskchjmxIyHx3n4ITbR8KbVBIb
         S9H9TAofn2zjchG2Z4jNv0SuILRT6aGkvx72Xh/KFLL4sHxd0h9S8l3swqFfsFMl8kJD
         iUUa2LOjlB1bx+dTEK6CdV5j7T740ZS8NESxiPOEdyoiKTyA3SSvqhtKGksyqtANk3DX
         JkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BIw9xe+LuyILTEIl1MT4esh/VJREnfS5b/q2dSYvFyA=;
        b=K5B+ZtgUAHSbiPH9g0905ziEpjTk1tHzpmJY5li/DuniOj0io4fhJ1UefdwwuWXZhj
         MG3+5BbYgAlmd4di24RMCJz2jdPDyu8BjNv6YE7O+o5o+OTXfi24WgQg6kqtX/PeGAGj
         kct2bCAdH5EA1OAV0HhviBGSQEEklZHjwdcNNDR2pxcjW3GwURQKwI/Ibf6AWPxtfcu9
         Ea54Y80fWspQGfch+vfnpbMoTHJhBVH+fD8RvkATEFqgZO1vvgXdzsI65tXJ9yBRSVbW
         PJMDJxvVwdsoMtpxgbweLgLEErDgLsjGy4WiFDc5r7VqvlZWKFcDFqMbdhGOvhj7K1+w
         mQ/Q==
X-Gm-Message-State: AOAM5330Bl5fpUQjcg/cWrwIiHAxKVAdWKUr1Yf1GAJeWgqvOwgy0feS
        yvx05+IjjgPr/bhFJKwBPMI=
X-Google-Smtp-Source: ABdhPJy3Wss14CvPUjoxWXYr/WXTEfQSvOceB8jCEW7maApDcqK1QyxKr8rf74TjirfT8B+jZOYr9w==
X-Received: by 2002:a2e:b704:: with SMTP id j4mr7549682ljo.329.1599488494730;
        Mon, 07 Sep 2020 07:21:34 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id 25sm7242182ljn.120.2020.09.07.07.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 07:21:34 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 7 Sep 2020 16:21:31 +0200
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        linux-mm.kvack.org@wittgenstein, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, mingo@kernel.org, peterz@infradead.org,
        ebiederm@xmission.com, esyr@redhat.com, tglx@linutronix.de,
        christian@kellner.me, areber@redhat.com, shakeelb@google.com,
        cyphar@cyphar.com, psodagud@codeaurora.org, pratikp@codeaurora.org
Subject: Re: [RFC PATCH] fork: Free per-cpu cached vmalloc'ed thread stacks
 with
Message-ID: <20200907142131.GA16844@pc636>
References: <010101745b9b7825-f4d1db4b-83fb-450e-9391-82aad77a1bd6-000000@us-west-2.amazonses.com>
 <20200907084538.qz5g4mikznwxr67g@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907084538.qz5g4mikznwxr67g@wittgenstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 10:45:38AM +0200, Christian Brauner wrote:
> On Sat, Sep 05, 2020 at 12:12:29AM +0000, Isaac J. Manjarres wrote:
> > The per-cpu cached vmalloc'ed stacks are currently freed in the
> > CPU hotplug teardown path by the free_vm_stack_cache() callback,
> > which invokes vfree(), which may result in purging the list of
> > lazily freed vmap areas.
> > 
> > Purging all of the lazily freed vmap areas can take a long time
> > when the list of vmap areas is large. This is problematic, as
> > free_vm_stack_cache() is invoked prior to the offline CPU's timers
> > being migrated. This is not desirable as it can lead to timer
> > migration delays in the CPU hotplug teardown path, and timer callbacks
> > will be invoked long after the timer has expired.
> > 
> > For example, on a system that has only one online CPU (CPU 1) that is
> > running a heavy workload, and another CPU that is being offlined,
> > the online CPU will invoke free_vm_stack_cache() to free the cached
> > vmalloc'ed stacks for the CPU being offlined. When there are 2702
> > vmap areas that total to 13498 pages, free_vm_stack_cache() takes
> > over 2 seconds to execute:
> > 
> > [001]   399.335808: cpuhp_enter: cpu: 0005 target:   0 step:  67 (free_vm_stack_cache)
> > 
> > /* The first vmap area to be freed */
> > [001]   399.337157: __purge_vmap_area_lazy: [0:2702] 0xffffffc033da8000 - 0xffffffc033dad000 (5 : 13498)
> > 
> > /* After two seconds */
> > [001]   401.528010: __purge_vmap_area_lazy: [1563:2702] 0xffffffc02fe10000 - 0xffffffc02fe15000 (5 : 5765)
> > 
> > Instead of freeing the per-cpu cached vmalloc'ed stacks synchronously
> > with respect to the CPU hotplug teardown state machine, free them
> > asynchronously to help move along the CPU hotplug teardown state machine
> > quickly.
> > 
> > Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> > ---
> 
> This needs reviews and acks from the good folks over at mm/.
> 
> >  kernel/fork.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 4d32190..68346a0 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -202,7 +202,7 @@ static int free_vm_stack_cache(unsigned int cpu)
> >  		if (!vm_stack)
> >  			continue;
> >  
> > -		vfree(vm_stack->addr);
> > +		vfree_atomic(vm_stack->addr);
> >  		cached_vm_stacks[i] = NULL;
> >  	}
> >  
Could you please also test below patch?

<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index be4724b916b3..cef7a9768f01 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -419,6 +419,10 @@ static LLIST_HEAD(vmap_purge_list);
 static struct rb_root vmap_area_root = RB_ROOT;
 static bool vmap_initialized __read_mostly;

+static struct rb_root purge_vmap_area_root = RB_ROOT;
+static LIST_HEAD(purge_vmap_area_list);
+static DEFINE_SPINLOCK(purge_vmap_area_lock);
+
 /*
  * This kmem_cache is used for vmap_area objects. Instead of
  * allocating from slab we reuse an object from this cache to
@@ -743,7 +747,8 @@ insert_vmap_area_augment(struct vmap_area *va,
  */
 static __always_inline struct vmap_area *
 merge_or_add_vmap_area(struct vmap_area *va,
-       struct rb_root *root, struct list_head *head)
+       struct rb_root *root, struct list_head *head,
+       bool update)
 {
        struct vmap_area *sibling;
        struct list_head *next;
@@ -825,7 +830,9 @@ merge_or_add_vmap_area(struct vmap_area *va,
        /*
         * Last step is to check and update the tree.
         */
-       augment_tree_propagate_from(va);
+       if (update)
+               augment_tree_propagate_from(va);
+
        return va;
 }

@@ -1140,7 +1147,7 @@ static void free_vmap_area(struct vmap_area *va)
         * Insert/Merge it back to the free tree/list.
         */
        spin_lock(&free_vmap_area_lock);
-       merge_or_add_vmap_area(va, &free_vmap_area_root, &free_vmap_area_list);
+       merge_or_add_vmap_area(va, &free_vmap_area_root, &free_vmap_area_list, true);
        spin_unlock(&free_vmap_area_lock);
 }
 
@@ -1328,32 +1335,33 @@ void set_iounmap_nonlazy(void)
 static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 {
        unsigned long resched_threshold;
-       struct llist_node *valist;
-       struct vmap_area *va;
-       struct vmap_area *n_va;
+       struct list_head local_pure_list;
+       struct vmap_area *va, *n_va;
 
        lockdep_assert_held(&vmap_purge_lock);
 
-       valist = llist_del_all(&vmap_purge_list);
-       if (unlikely(valist == NULL))
+       spin_lock(&purge_vmap_area_lock);
+       purge_vmap_area_root = RB_ROOT;
+       list_replace_init(&purge_vmap_area_list, &local_pure_list);
+       spin_unlock(&purge_vmap_area_lock);
+
+       if (unlikely(list_empty(&local_pure_list)))
                return false;

-       /*
-        * TODO: to calculate a flush range without looping.
-        * The list can be up to lazy_max_pages() elements.
-        */
-       llist_for_each_entry(va, valist, purge_list) {
-               if (va->va_start < start)
-                       start = va->va_start;
-               if (va->va_end > end)
-                       end = va->va_end;
-       }
+
+       start = min(start,
+                       list_first_entry(&local_pure_list,
+                               struct vmap_area, list)->va_start);
+
+       end = max(end,
+                       list_last_entry(&local_pure_list,
+                               struct vmap_area, list)->va_end);
 
        flush_tlb_kernel_range(start, end);
        resched_threshold = lazy_max_pages() << 1;
 
        spin_lock(&free_vmap_area_lock);
-       llist_for_each_entry_safe(va, n_va, valist, purge_list) {
+       list_for_each_entry_safe(va, n_va, &local_pure_list, list) {
                unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
                unsigned long orig_start = va->va_start;
                unsigned long orig_end = va->va_end;
@@ -1364,7 +1372,7 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
                 * anything.
                 */
                va = merge_or_add_vmap_area(va, &free_vmap_area_root,
-                                           &free_vmap_area_list);
+                               &free_vmap_area_list, true);
 
                if (!va)
                        continue;
@@ -1421,9 +1429,19 @@ static void free_vmap_area_noflush(struct vmap_area *va)
        nr_lazy = atomic_long_add_return((va->va_end - va->va_start) >>
                                PAGE_SHIFT, &vmap_lazy_nr);
 
-       /* After this point, we may free va at any time */
-       llist_add(&va->purge_list, &vmap_purge_list);
+       /*
+        * But this time the node has been removed from the busy
+        * data structures therefore, merge or place it to the purge
+        * tree/list.
+        */
+       spin_lock(&purge_vmap_area_lock);
+       merge_or_add_vmap_area(va,
+               &purge_vmap_area_root, &purge_vmap_area_list, false);
+       spin_unlock(&purge_vmap_area_lock);
 
+       /*
+        * After this point, we may free va at any time.
+        */
        if (unlikely(nr_lazy > lazy_max_pages()))
                try_purge_vmap_area_lazy();
 }
@@ -3352,7 +3370,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
                orig_start = vas[area]->va_start;
                orig_end = vas[area]->va_end;
                va = merge_or_add_vmap_area(vas[area], &free_vmap_area_root,
-                                           &free_vmap_area_list);
+                               &free_vmap_area_list, true);
                if (va)
                        kasan_release_vmalloc(orig_start, orig_end,
                                va->va_start, va->va_end);
@@ -3402,7 +3420,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
                orig_start = vas[area]->va_start;
                orig_end = vas[area]->va_end;
                va = merge_or_add_vmap_area(vas[area], &free_vmap_area_root,
-                                           &free_vmap_area_list);
+                               &free_vmap_area_list, true);
                if (va)
                        kasan_release_vmalloc(orig_start, orig_end,
                                va->va_start, va->va_end);
<snip>

Thank you!

--
Vlad Rezki
