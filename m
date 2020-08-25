Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892A6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53EF32075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Vj9FVogw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgHYPKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgHYPKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:10:47 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08915C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 08:10:46 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id u3so11190906qkd.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BNq5Zlk150pviE6ZXbLRBh3YPk82JI5ia7l5y8IDiZE=;
        b=Vj9FVogwqT9DCuNcJkRAg+vBqhPWaJhuBSHeqkrDVuKbd8bVb4EJH0XtPU2YJRB3s4
         i9/X7Hyc+uAj86JCaTP5DulwGeqIU5Y/feIA5Fn6gIg/WDTR+YNPoyBcVRA3vEMgfXGT
         bIuNxAUDiNLJgRoK9lAHfFvr3GMlF8+f0bOjYGjoeSnCTf0PaZjmYQ9pYlq9ygipWI8Y
         BRdT2QTnXAWBCGHGJtzVKfhlAG+KIeCRvY0IlnhBz8Go44EfsON6pQs3jq2VaneYC8Yd
         dCF5vnVByfyCnOdAGar2+8Hh2yqIez4KmNx7+y7jIzRKVe+X+oAc5nflzk89ntDBseJd
         hWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BNq5Zlk150pviE6ZXbLRBh3YPk82JI5ia7l5y8IDiZE=;
        b=RP/JOlQLCtZUSZTcuspwwcYfYkEr3xxVyR7y88NmqVD9thQY4+FpQRdLnUiUq9SV04
         G8pQC89zho9Ifd2yYEwLJt49+kuXQWOnrlGCIHfFqphCAheoPdVqj4u5Gg+l8f/aH/VL
         qjmqj7O2Lj6GjwR4PQUKGpCkvXSpOzzU/8SzlPO8kdVZI0igmvd524wej5P1Bo6QyIm5
         7DAbRhKNAl/7i/+gnEU2eT95UG0nWsBe9IObJSiWk27ufB2pYaMfx2sZIcqv5mjeTa0b
         G0B0hAE/u8N3xDubxdKO0KIyfWd0/dMGSA3K+8r34UqBKMKhV4Cut9g5YNRpEmFZZia6
         8gHw==
X-Gm-Message-State: AOAM531iBRSrJmKGwlKPCQXbLtC+4i8moEazAHyaGiQBmJ9Y3RBLPtEu
        DOCuYArMtmJIbLcqpC0JKBc/bg==
X-Google-Smtp-Source: ABdhPJyf8MToRVRD6h//jMS5uIn/DL3VouNopKLGVdpk1lvDF1GD863oMnjBrUpM1NkUMRazxcBGBA==
X-Received: by 2002:a37:8047:: with SMTP id b68mr9104318qkd.299.1598368246055;
        Tue, 25 Aug 2020 08:10:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:bdd3])
        by smtp.gmail.com with ESMTPSA id f14sm11854778qkl.52.2020.08.25.08.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 08:10:45 -0700 (PDT)
Date:   Tue, 25 Aug 2020 11:09:33 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+b305848212deec86eabe@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Roman Gushchin <guro@fb.com>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: KASAN: use-after-free Write in page_counter_uncharge
Message-ID: <20200825150933.GB932571@cmpxchg.org>
References: <00000000000014822b05ad2802a7@google.com>
 <20200818161856.d18df24b5d10fc727ead846f@linux-foundation.org>
 <20200819063421.GA5422@dhcp22.suse.cz>
 <20200820090341.GC5033@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820090341.GC5033@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 11:03:41AM +0200, Michal Hocko wrote:
> From 73a40589cab12122170fb9f90222982e81d41423 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Thu, 20 Aug 2020 10:44:58 +0200
> Subject: [PATCH] memcg: fix use-after-free in uncharge_batch
> 
> syzbot has reported an use-after-free in the uncharge_batch path
> BUG: KASAN: use-after-free in instrument_atomic_write include/linux/instrumented.h:71 [inline]
> BUG: KASAN: use-after-free in atomic64_sub_return include/asm-generic/atomic-instrumented.h:970 [inline]
> BUG: KASAN: use-after-free in atomic_long_sub_return include/asm-generic/atomic-long.h:113 [inline]
> BUG: KASAN: use-after-free in page_counter_cancel mm/page_counter.c:54 [inline]
> BUG: KASAN: use-after-free in page_counter_uncharge+0x3d/0xc0 mm/page_counter.c:155
> Write of size 8 at addr ffff8880371c0148 by task syz-executor.0/9304
> 
> CPU: 0 PID: 9304 Comm: syz-executor.0 Not tainted 5.8.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1f0/0x31e lib/dump_stack.c:118
>  print_address_description+0x66/0x620 mm/kasan/report.c:383
>  __kasan_report mm/kasan/report.c:513 [inline]
>  kasan_report+0x132/0x1d0 mm/kasan/report.c:530
>  check_memory_region_inline mm/kasan/generic.c:183 [inline]
>  check_memory_region+0x2b5/0x2f0 mm/kasan/generic.c:192
>  instrument_atomic_write include/linux/instrumented.h:71 [inline]
>  atomic64_sub_return include/asm-generic/atomic-instrumented.h:970 [inline]
>  atomic_long_sub_return include/asm-generic/atomic-long.h:113 [inline]
>  page_counter_cancel mm/page_counter.c:54 [inline]
>  page_counter_uncharge+0x3d/0xc0 mm/page_counter.c:155
>  uncharge_batch+0x6c/0x350 mm/memcontrol.c:6764
>  uncharge_page+0x115/0x430 mm/memcontrol.c:6796
>  uncharge_list mm/memcontrol.c:6835 [inline]
>  mem_cgroup_uncharge_list+0x70/0xe0 mm/memcontrol.c:6877
>  release_pages+0x13a2/0x1550 mm/swap.c:911
>  tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
>  tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
>  tlb_flush_mmu+0x780/0x910 mm/mmu_gather.c:249
>  tlb_finish_mmu+0xcb/0x200 mm/mmu_gather.c:328
>  exit_mmap+0x296/0x550 mm/mmap.c:3185
>  __mmput+0x113/0x370 kernel/fork.c:1076
>  exit_mm+0x4cd/0x550 kernel/exit.c:483
>  do_exit+0x576/0x1f20 kernel/exit.c:793
>  do_group_exit+0x161/0x2d0 kernel/exit.c:903
>  get_signal+0x139b/0x1d30 kernel/signal.c:2743
>  arch_do_signal+0x33/0x610 arch/x86/kernel/signal.c:811
>  exit_to_user_mode_loop kernel/entry/common.c:135 [inline]
>  exit_to_user_mode_prepare+0x8d/0x1b0 kernel/entry/common.c:166
>  syscall_exit_to_user_mode+0x5e/0x1a0 kernel/entry/common.c:241
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> 1a3e1f40962c ("mm: memcontrol: decouple reference counting from page
> accounting") has reworked the memcg lifetime to be bound the the struct
> page rather than charges. It has also removed the css_put_many from
> uncharge_batch and that is causing the above splat. uncharge_batch is
> supposed to uncharge accumulated charges for all pages freed from the
> same memcg. The queuing is done by uncharge_page which however drops the
> memcg reference after it adds charges to the batch. If the current page
> happens to be the last one holding the reference for its memcg then the
> memcg is OK to go and the next page to be freed will trigger batched
> uncharge which needs to access the memcg which is gone already.
> 
> Fix the issue by taking a reference for the memcg in the current batch.
> 
> Fixes: 1a3e1f40962c ("mm: memcontrol: decouple reference counting from page accounting")
> Reported-by: syzbot+b305848212deec86eabe@syzkaller.appspotmail.com
> Reported-by: syzbot+b5ea6fb6f139c8b9482b@syzkaller.appspotmail.com
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Nice catch! The fix looks correct - ug now holds a reference count for
its ug->memcg pointer.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
