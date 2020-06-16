Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B8FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 01:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9772206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 01:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="eHORBFoY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgFPBNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 21:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgFPBNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 21:13:44 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAB5C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 18:13:43 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w3so17727794qkb.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 18:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=024dD2jIH4hLayUKB47VJpIZ1P0Ce1ME3zobZlALpg0=;
        b=eHORBFoYoNU83sNEYcY+XUxSiwKnmb5b/fsiilJ6BebrlKJIbyx3WJTQpoiU39ZIQ3
         GVnvonReFLnCnRrDryi5seZIOgvzg4a5Vyq0RbxcR7b1hAsUOHlJAoHPR3tqKT2b58lR
         7Od2r+/KogPl0UumuCYgrylkZ0FvZwE5UDgQ9cWAokzixkdOuVkqaJs0HxsO8reecqnZ
         jxlhtMDmcZpYKH8NBsk5Q16LWig5MGwPjIT6ZKfWnYt9dGzPYYAE2Ih8pCg81TRBq+80
         aLpEupJZm0v3mAEowfmCsxwvLAkPTlvvhiP1pusx3eiEDDWh0/3nn3oSytViLKL6MENf
         fWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=024dD2jIH4hLayUKB47VJpIZ1P0Ce1ME3zobZlALpg0=;
        b=ihz9IL35FXZUsqizWU+ZVPYEAySVPtA+5NsukHUwWNEf6lnMofA7s1fanpG7P2nmYV
         DvbuPCKeTsnhc/nFLfVX2NnjYPNwIy49YYwPUNCB70tQd6C5fp0Njceb1IZ0FWwOq7q0
         pq6yHQgl/PQY0Cl0WBiEqLxtPztZLhEfLEkle/BiWvodKSlHae+34Ulf19NOM7CD9u0g
         SIVTs3CoiMua9yHq1zz51/2FuCnBPzjOpabABjXo74y/772vm6cC7nxCKFfGKMiXMysH
         SUPIGoxbpxzLXvG0UwUhBkIcdj3GgGkTwd9Q9dLEVR2mCjlLMIbcJfZBdPui4VxjX0bu
         S9kw==
X-Gm-Message-State: AOAM533RNMCip/MP1y3QNCuldPhRRtVhIMwh0Ij1GmmAyzlWkIhCjrer
        OKwt2neyiN7/Vp5TNesg3j0+/Q==
X-Google-Smtp-Source: ABdhPJx8ravJnneVtPFjNhElXFNwpErAR7OClp8m2nqdpnFKDs4ETjFXELCr+HAhH5xXxM+yUOudbA==
X-Received: by 2002:a37:aac4:: with SMTP id t187mr16433579qke.263.1592270022142;
        Mon, 15 Jun 2020 18:13:42 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v14sm14355907qtj.31.2020.06.15.18.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 18:13:41 -0700 (PDT)
Date:   Mon, 15 Jun 2020 21:13:34 -0400
From:   Qian Cai <cai@lca.pw>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: not-present page at swap_vma_readahead()
Message-ID: <20200616011334.GA815@lca.pw>
References: <62A0ACFC-E023-4269-8121-F96B879A8C51@lca.pw>
 <81F06AA9-F25B-4342-9CF7-2763AC394A18@lca.pw>
 <874ktl1p7y.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874ktl1p7y.fsf@yhuang-dev.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 10:01:53AM +0800, Huang, Ying wrote:
> Qian Cai <cai@lca.pw> writes:
> 
> >> On Apr 14, 2020, at 10:32 AM, Qian Cai <cai@lca.pw> wrote:
> >> 
> >> Fuzzers are unhappy. Thoughts?
> >
> > This is rather to reproduce. All the traces so far are from copy_from_user() to trigger a page fault,
> > and then it dereferences a bad pte in swap_vma_readahead(),
> >
> > 	for (i = 0, pte = ra_info.ptes; i < ra_info.nr_pte;
> > 	     i++, pte++) {
> > 		pentry = *pte;   <— crashed here.
> > 		if (pte_none(pentry))
> 
> Is it possible to bisect this?
> 
> Because the crash point is identified, it may be helpful to collect and
> analyze the status of the faulting page table and readahead ptes.  But I
> am not familiar with the ARM64 architecture.  So I cannot help much
> here.

Ying, looks like the bug is still there today which manifests itself
into a different form. Looking at the logs, I believe it was involved
with swapoff(). Any other thought? I still have not found time to bisect
this yet.

[  785.477183][ T8727] BUG: KASAN: slab-out-of-bounds in swapin_readahead+0x7b8/0xbc0
swap_vma_readahead at mm/swap_state.c:759
(inlined by) swapin_readahead at mm/swap_state.c:803
[  785.484752][ T8727] Read of size 8 at addr ffff00886ecaffe8 by task trinity-c35/8727
[  785.492488][ T8727] 
[  785.494675][ T8727] CPU: 35 PID: 8727 Comm: trinity-c35 Not tainted 5.7.0-next-20200610 #3
[  785.502942][ T8727] Hardware name: HPE Apollo 70             /C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
[  785.513387][ T8727] Call trace:
[  785.516538][ T8727]  dump_backtrace+0x0/0x398
[  785.520891][ T8727]  show_stack+0x14/0x20
[  785.524900][ T8727]  dump_stack+0x140/0x1b8
[  785.529087][ T8727]  print_address_description.isra.12+0x54/0x4a8
[  785.535185][ T8727]  kasan_report+0x134/0x1b8
[  785.539545][ T8727]  __asan_report_load8_noabort+0x2c/0x50
[  785.545036][ T8727]  swapin_readahead+0x7b8/0xbc0
[  785.549745][ T8727]  do_swap_page+0xb1c/0x19a0
[  785.554195][ T8727]  handle_mm_fault+0xf10/0x2b30
[  785.558905][ T8727]  do_page_fault+0x230/0x908
[  785.563354][ T8727]  do_translation_fault+0xe0/0x108
[  785.568323][ T8727]  do_mem_abort+0x64/0x180
[  785.572597][ T8727]  el1_sync_handler+0x188/0x1b8
[  785.577305][ T8727]  el1_sync+0x7c/0x100
[  785.581232][ T8727]  __arch_copy_to_user+0xc4/0x158
[  785.586115][ T8727]  __arm64_sys_sysinfo+0x2c/0xd0
[  785.590912][ T8727]  do_el0_svc+0x124/0x220
[  785.595100][ T8727]  el0_sync_handler+0x260/0x408
[  785.599807][ T8727]  el0_sync+0x140/0x180
[  785.603818][ T8727] 
[  785.606007][ T8727] Allocated by task 8673:
[  785.610193][ T8727]  save_stack+0x24/0x50
[  785.614208][ T8727]  __kasan_kmalloc.isra.13+0xc4/0xe0
[  785.619350][ T8727]  kasan_slab_alloc+0x14/0x20
[  785.623885][ T8727]  slab_post_alloc_hook+0x50/0xa8
[  785.628769][ T8727]  kmem_cache_alloc+0x18c/0x438
[  785.633479][ T8727]  create_object+0x58/0x960
[  785.637844][ T8727]  kmemleak_alloc+0x2c/0x38
[  785.642205][ T8727]  slab_post_alloc_hook+0x70/0xa8
[  785.647089][ T8727]  kmem_cache_alloc_trace+0x178/0x308
[  785.652322][ T8727]  refill_pi_state_cache.part.10+0x3c/0x1a8
[  785.658073][ T8727]  futex_lock_pi+0x404/0x5e0
[  785.662519][ T8727]  do_futex+0x790/0x1448
[  785.666618][ T8727]  __arm64_sys_futex+0x204/0x588
[  785.671411][ T8727]  do_el0_svc+0x124/0x220
[  785.675603][ T8727]  el0_sync_handler+0x260/0x408
[  785.680312][ T8727]  el0_sync+0x140/0x180
[  785.684322][ T8727] 
[  785.686510][ T8727] Freed by task 0:
[  785.690088][ T8727]  save_stack+0x24/0x50
[  785.694104][ T8727]  __kasan_slab_free+0x124/0x198
[  785.698899][ T8727]  kasan_slab_free+0x10/0x18
[  785.703340][ T8727]  slab_free_freelist_hook+0x110/0x298
[  785.708648][ T8727]  kmem_cache_free+0xc8/0x3e0
[  785.713175][ T8727]  free_object_rcu+0x1e0/0x3b8
[  785.717796][ T8727]  rcu_core+0x8bc/0xf40
[  785.721810][ T8727]  rcu_core_si+0xc/0x18
[  785.725825][ T8727]  efi_header_end+0x2d8/0x1204
[  785.730442][ T8727] 
[  785.732625][ T8727] The buggy address belongs to the object at ffff00886ecafd28
[  785.732625][ T8727]  which belongs to the cache kmemleak_object of size 368
[  785.746875][ T8727] The buggy address is located 336 bytes to the right of
[  785.746875][ T8727]  368-byte region [ffff00886ecafd28, ffff00886ecafe98)
[  785.760519][ T8727] The buggy address belongs to the page:
[  785.766009][ T8727] page:ffffffe021fbb280 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff00886ecaa8c8
[  785.776268][ T8727] flags: 0x7ffff800000200(slab)
[  785.780971][ T8727] raw: 007ffff800000200 ffffffe0222c12c8 ffffffe0223a1488 ffff000000323080
[  785.789410][ T8727] raw: ffff00886ecaa8c8 00000000005b001d 00000001ffffffff 0000000000000000
[  785.797849][ T8727] page dumped because: kasan: bad access85.811794][ T87270886ecaff00: fc  fc fc fc fc fc     ^
[  785.842727]  ffff00886ecb0080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  785.858703][ T8727] ==================================================================
[  785.866621][ T8727] Disabling lock debugging due to kernel taint
[  785.872714][ T8727] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  785.879523][ T8727] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
[  785.886322][ T8727] get_swap_device: Bad swap file entry 58025a5a5a5a5a5a
