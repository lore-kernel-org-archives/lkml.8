Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D892FC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 03:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97835206D5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 03:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJyZd0fH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgCGDFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 22:05:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41018 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726237AbgCGDFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 22:05:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583550339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xeTJEAKky+Ubop+H5lfdTe5iFzyTb/vlVHG5rO7Sccw=;
        b=hJyZd0fHX6z8TKLHSnsc+27awbg11Pp5zMB2RtoEe9HmmaM+iv0aScvJfx6VAaf1YoKCZT
        r/scu3AdPCq+pjPBUDV22aZBJ2H+080ah43W/Rv8WcYpTMkyfxDuNUoXyKfWnn+WaaIWjx
        OOc4TtJgzvWXbg0NDfYvj3nZd3JIArU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-m63gQAQ_NW2HiLuJSErLUQ-1; Fri, 06 Mar 2020 22:05:35 -0500
X-MC-Unique: m63gQAQ_NW2HiLuJSErLUQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33E8D8017CC;
        Sat,  7 Mar 2020 03:05:34 +0000 (UTC)
Received: from t490s (ovpn-116-48.phx2.redhat.com [10.3.116.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DCEB25D9CA;
        Sat,  7 Mar 2020 03:05:32 +0000 (UTC)
Date:   Fri, 6 Mar 2020 22:05:30 -0500
From:   Rafael Aquini <aquini@redhat.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz
Subject: Re: [PATCH] mm, numa: fix bad pmd by atomically check for
 pmd_trans_huge when marking page tables prot_numa
Message-ID: <20200307030530.GB4093@t490s>
References: <20200216191800.22423-1-aquini@redhat.com>
 <2E0766B8-DDD1-4448-8605-8535A16670FC@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E0766B8-DDD1-4448-8605-8535A16670FC@lca.pw>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 09:40:10PM -0500, Qian Cai wrote:
> 
> 
> > On Feb 16, 2020, at 2:18 PM, Rafael Aquini <aquini@redhat.com> wrote:
> > 
> > From: Mel Gorman <mgorman@techsingularity.net>
> >  A user reported a bug against a distribution kernel while running
> >  a proprietary workload described as "memory intensive that is not
> >  swapping" that is expected to apply to mainline kernels. The workload
> >  is read/write/modifying ranges of memory and checking the contents. They
> >  reported that within a few hours that a bad PMD would be reported followed
> >  by a memory corruption where expected data was all zeros.  A partial report
> >  of the bad PMD looked like
> > 
> >  [ 5195.338482] ../mm/pgtable-generic.c:33: bad pmd ffff8888157ba008(000002e0396009e2)
> >  [ 5195.341184] ------------[ cut here ]------------
> >  [ 5195.356880] kernel BUG at ../mm/pgtable-generic.c:35!
> >  ....
> >  [ 5195.410033] Call Trace:
> >  [ 5195.410471]  [<ffffffff811bc75d>] change_protection_range+0x7dd/0x930
> >  [ 5195.410716]  [<ffffffff811d4be8>] change_prot_numa+0x18/0x30
> >  [ 5195.410918]  [<ffffffff810adefe>] task_numa_work+0x1fe/0x310
> >  [ 5195.411200]  [<ffffffff81098322>] task_work_run+0x72/0x90
> >  [ 5195.411246]  [<ffffffff81077139>] exit_to_usermode_loop+0x91/0xc2
> >  [ 5195.411494]  [<ffffffff81003a51>] prepare_exit_to_usermode+0x31/0x40
> >  [ 5195.411739]  [<ffffffff815e56af>] retint_user+0x8/0x10
> > 
> >  Decoding revealed that the PMD was a valid prot_numa PMD and the bad PMD
> >  was a false detection. The bug does not trigger if automatic NUMA balancing
> >  or transparent huge pages is disabled.
> > 
> >  The bug is due a race in change_pmd_range between a pmd_trans_huge and
> >  pmd_nond_or_clear_bad check without any locks held. During the pmd_trans_huge
> >  check, a parallel protection update under lock can have cleared the PMD
> >  and filled it with a prot_numa entry between the transhuge check and the
> >  pmd_none_or_clear_bad check.
> > 
> >  While this could be fixed with heavy locking, it's only necessary to
> >  make a copy of the PMD on the stack during change_pmd_range and avoid
> >  races. A new helper is created for this as the check if quite subtle and the
> >  existing similar helpful is not suitable. This passed 154 hours of testing
> >  (usually triggers between 20 minutes and 24 hours) without detecting bad
> >  PMDs or corruption. A basic test of an autonuma-intensive workload showed
> >  no significant change in behaviour.
> > 
> > Although Mel withdrew the patch on the face of LKML comment https://lkml.org/lkml/2017/4/10/922
> > the race window aforementioned is still open, and we have reports of Linpack test reporting bad
> > residuals after the bad PMD warning is observed. In addition to that, bad rss-counter and
> > non-zero pgtables assertions are triggered on mm teardown for the task hitting the bad PMD.
> > 
> > host kernel: mm/pgtable-generic.c:40: bad pmd 00000000b3152f68(8000000d2d2008e7)
> > ....
> > host kernel: BUG: Bad rss-counter state mm:00000000b583043d idx:1 val:512
> > host kernel: BUG: non-zero pgtables_bytes on freeing mm: 4096
> > 
> > The issue is observed on a v4.18-based distribution kernel, but the race window is
> > expected to be applicable to mainline kernels, as well.
> 
> After reverted this patch, it is no longer possible to reproduce a bug under memory pressure
> with swapping on linux-next 20200306,
>

Would you mind sharing your .config ? Also it would be nice to know your
system and workload details so I can try to reproduce.

Cheers,
-- Rafael

> The trace is a bit off for some reasons, but it is basically,
> 
> kernel BUG at include/linux/page-flags.h:317!
> 
> end_swap_bio_write()
>    SetPageError(page)
>        VM_BUG_ON_PAGE(1 && PageCompound(page)) 
> 
> The page was allocated in,
> 
> do_huge_pmd_anonymous_page()
> 
> [ 9598.551238][  T794] oom_reaper: reaped process 49120 (oom02), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB 
> [ 9690.896638][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0027 address=0xffffffffffcc0000 flags=0x0010] 
> [ 9690.910129][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0027 address=0xffffffffffcc1000 flags=0x0010] 
> [ 9690.923933][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0027 address=0xffffffffffcc1900 flags=0x0010] 
> [ 9690.937669][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0027 address=0xffffffffffcc1d00 flags=0x0010] 
> [ 9690.951468][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0027 address=0xffffffffffcc2000 flags=0x0010] 
> [ 9690.964803][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0027 address=0xffffffffffcc2400 flags=0x0010] 
> [ 9690.978256][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0027 address=0xffffffffffcc2800 flags=0x0010] 
> [ 9690.991423][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0027 address=0xffffffffffcc2c00 flags=0x0010] 
> [ 9691.004294][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0027 address=0xffffffffffcc3000 flags=0x0010] 
> [ 9691.017228][  T814] smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0027 address=0xffffffffffcc3400 flags=0x0010] 
> [ 9691.029804][  T814] AMD-Vi: Event logged [IO_PAGE_FAULT device=23:00.0 domain=0x0027 address=0xffffffffffcc3800 flags=0x0010] 
> [ 9691.041623][  T814] AMD-Vi: Event logged [IO_PAGE_FAULT device=23:00.0 domain=0x0027 address=0xffffffffffcc3c00 flags=0x0010] 
> [ 9692.767064][    C8] smartpqi 0000:23:00.0: controller is offline: status code 0x14803 
> [ 9692.775562][    C8] smartpqi 0000:23:00.0: controller offline 
> [ 9692.841721][   C36] sd 0:1:0:0: [sda] tag#693 UNKNOWN(0x2003) Result: hostbyte=0x01 driverbyte=0x00 cmd_age=1s 
> [ 9692.841970][   C87] blk_update_request: I/O error, dev sda, sector 59046400 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0 
> [ 9692.842718][   C31] blk_update_request: I/O error, dev sda, sector 36509696 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0 
> [ 9692.842748][   C18] sd 0:1:0:0: [sda] tag#616 UNKNOWN(0x2003) Result: hostbyte=0x01 driverbyte=0x00 cmd_age=1s 
> [ 9692.842757][   C28] sd 0:1:0:0: [sda] tag#841 UNKNOWN(0x2003) Result: hostbyte=0x01 driverbyte=0x00 cmd_age=1s 
> [ 9692.842766][  C109] sd 0:1:0:0: [sda] tag#393 UNKNOWN(0x2003) Result: hostbyte=0x01 driverbyte=0x00 cmd_age=1s 
> [ 9692.842811][  C109] sd 0:1:0:0: [sda] tag#393 CDB: opcode=0x2a 2a 00 01 60 c8 00 00 02 00 00 
> [ 9692.842840][   C13] sd 0:1:0:0: [sda] tag#324 UNKNOWN(0x2003) Result: hostbyte=0x01 driverbyte=0x00 cmd_age=1s 
> [ 9692.842924][   C18] sd 0:1:0:0: [sda] tag#616 CDB: opcode=0x2a 2a 00 01 c7 8c 00 00 02 00 00 
> [ 9692.842932][  C109] blk_update_request: I/O error, dev sda, sector 23119872 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0 
> [ 9692.842938][   C28] sd 0:1:0:0: [sda] tag#841 CDB: opcode=0x2a 2a 00 03 2f cc 00 00 02 00 00 
> [ 9692.842984][  T213] sd 0:1:0:0: [sda] tag#47 UNKNOWN(0x2003) Result: hostbyte=0x01 driverbyte=0x00 cmd_age=1s 
> [ 9692.842995][   C28] blk_update_request: I/O error, dev sda, sector 53464064 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0 
> [ 9692.843000][   C81] sd 0:1:0:0: [sda] tag#10 UNKNOWN(0x2003) Result: hostbyte=0x01 driverbyte=0x00 cmd_age=1s 
> [ 9692.843031][   C18] blk_update_request: I/O error, dev sda, sector 29854720 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0 
> [ 9692.843056][   C13] sd 0:1:0:0: [sda] tag#324 CDB: opcode=0x2a 2a 00 03 17 66 00 00 02 00 00 
> [ 9692.843101][   C81] sd 0:1:0:0: [sda] tag#10 CDB: opcode=0x2a 2a 00 00 52 a4 00 00 02 00 00 
> [ 9692.843129][   C13] blk_update_request: I/O error, dev sda, sector 51865088 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0 
> [ 9692.843192][   C81] blk_update_request: I/O error, dev sda, sector 5415936 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0 
> [ 9692.843338][  T213] sd 0:1:0:0: [sda] tag#47 CDB: opcode=0x2a 2a 00 02 be 5a 00 00 02 00 00 
> [ 9692.843358][   C13] sd 0:1:0:0: [sda] tag#325 UNKNOWN(0x2003) Result: hostbyte=0x01 driverbyte=0x00 cmd_age=1s 
> [ 9692.843480][  T213] blk_update_request: I/O error, dev sda, sector 46029312 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0 
> [ 9692.843485][   C13] sd 0:1:0:0: [sda] tag#325 CDB: opcode=0x2a 2a 00 03 17 68 00 00 02 00 00 
> [ 9692.843510][   C13] blk_update_request: I/O error, dev sda, sector 51865600 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0 
> [ 9692.843685][  C103] blk_update_request: I/O error, dev sda, sector 34941952 op 0x1:(WRITE) flags 0x8004000 phys_seg 4 prio class 0 
> [ 9692.843725][   C96] sd 0:1:0:0: [sda] tag#877 UNKNOWN(0x2003) Result: hostbyte=0x01 driverbyte=0x00 cmd_age=1s 
> [ 9692.843744][   C92] Write-error on swap-device (254:1:39256632) 
> [ 9692.843791][  C118] sd 0:1:0:0: [sda] tag#230 UNKNOWN(0x2003) Result: hostbyte=0x01 driverbyte=0x00 cmd_age=1s 
> [ 9692.843866][   C64] Write-error on swap-device (254:1:63030016) 
> [ 9692.843891][   C96] sd 0:1:0:0: [sda] tag#877 CDB: opcode=0x2a 2a 00 03 1e 48 00 00 02 00 00 
> [ 9692.844013][  C118] sd 0:1:0:0: [sda] tag#230 CDB: opcode=0x2a 2a 00 03 c6 26 00 00 02 00 00 
> [ 9692.844615][   C92] Write-error on swap-device (254:1:39256640) 
> [ 9692.844643][   C64] Write-error on swap-device (254:1:63030024) 
> [ 9692.845109][   C61] Write-error on swap-device (254:1:17105384) 
> [ 9692.845192][   C25] page:fffff3b2ec3a8000 refcount:512 mapcount:0 mapping:000000009eb0338c index:0x7f6e58200 head:fffff3b2ec3a8000 order:9 compound_mapcount:0 compound_pincount:0 
> [ 9692.845226][   C25] anon flags: 0x45fffe0000d8454(uptodate|lru|workingset|owner_priv_1|writeback|head|reclaim|swapbacked) 
> [ 9692.845254][   C25] raw: 045fffe0000d8454 fffff3b2f9d48008 fffff3b2f3270008 ffff97c3090f8209 
> [ 9692.845283][   C25] raw: 00000007f6e58200 000000000053c800 00000200ffffffff ffff97c8d71e9000 
> [ 9692.845293][  C122] Write-error on swap-device (254:1:39080184) 
> [ 9692.845316][  T213] page:fffff3b2f77d8000 refcount:512 mapcount:0 mapping:00000000a4517f4e index:0x7f69d2200 head:fffff3b2f77d8000 order:9 compound_mapcount:0 compound_pincount:0 
> [ 9692.845330][   C25] page dumped because: VM_BUG_ON_PAGE(1 && PageCompound(page)) 
> [ 9692.845427][  T213] anon flags: 0x45fffe0000d8454(uptodate|lru|workingset|owner_priv_1|writeback|head|reclaim|swapbacked) 
> [ 9692.845433][   C25] page->mem_cgroup:ffff97c8d71e9000 
> [ 9692.845443][   C25] page_owner tracks the page as allocated 
> [ 9692.845520][  T213] raw: 045fffe0000d8454 fffff3b2f5ec2f08 fffff3b2f6b88008 ffff97c715cc0609 
> [ 9692.845535][   C25] page last allocated via order 9, migratetype Movable, gfp_mask 0x1c20ca(GFP_TRANSHUGE_LIGHT) 
> [ 9692.845606][   C25]  prep_new_page+0x1cd/0x1f0 
> [ 9692.845628][   C25]  get_page_from_freelist+0x18ac/0x24d0 
> [ 9692.845639][  T213] raw: 00000007f69d2200 00000000000bf400 00000200ffffffff ffff97c8d71e9000 
> [ 9692.845654][   C25]  __alloc_pages_nodemask+0x1b1/0x450 
> [ 9692.845733][  T213] page dumped because: VM_BUG_ON_PAGE(1 && PageCompound(page)) 
> [ 9692.845757][   C25]  alloc_pages_vma+0x8a/0x2c0 
> [ 9692.845762][  T213] page->mem_cgroup:ffff97c8d71e9000 
> [ 9692.845779][   C25]  do_huge_pmd_anonymous_page+0x1d4/0xc30 
> [ 9692.845786][  T213] page_owner tracks the page as allocated 
> [ 9692.845807][   C25]  __handle_mm_fault+0xd27/0xd50 
> [ 9692.845819][  T213] page last allocated via order 9, migratetype Movable, gfp_mask 0x1c20ca(GFP_TRANSHUGE_LIGHT) 
> [ 9692.845833][   C25]  handle_mm_fault+0xfc/0x2f0 
> [ 9692.845856][  T213]  prep_new_page+0x1cd/0x1f0 
> [ 9692.845876][   C25]  do_page_fault+0x263/0x6f9 
> [ 9692.845892][  T213]  get_page_from_free7219][   C25]  clone_endio+0xe4/0x2c0 [dm_mod] 
> [ 9692.847226][  T213] kernel BUG at include/linux/page-flags.h:317! 
> [ 9692.847234][   C64] Write-error on swap-device (254:1:63030064) 
> [ 9692.847250][   C25]  bio_endio+0x297/0x560 
> [ 9692.847255][   C61] Write-error on swap-device (254:1:17105424) 
> [ 9692.847263][   C25]  ? bio_advance+0x92/0x190 
> [ 9692.847267][  C122] Write-error on swap-device (254:1:39080224) 
> [ 9692.847276][   C25]  blk_update_request+0x201/0x920 
> [ 9692.847287][   C25]  ? ___ratelimit+0x138/0x1e0 
> [ 9692.847312][   C25]  scsi_end_request+0x6b/0x4b0 
> [ 9692.847320][   C25]  ? ___ratelimit+0x3e/0x1e0 
> [ 9692.847329][   C25]  scsi_io_completion+0x509/0x7e0 
> [ 9692.847340][   C25]  scsi_finish_command+0x1ed/0x2a0 
> [ 9692.847350][   C25]  scsi_softirq_done+0x1c9/0x1d0 
> [ 9692.847354][   C64] Write-error on swap-device (254:1:63030072) 
> [ 9692.847363][   C25]  ? blk_mq_check_inflight+0xa0/0xa0 
> [ 9692.847383][   C61] Write-error on swap-device (254:1:17105432) 
> [ 9692.847397][  C122] Write-erro692.848242][   C25] RSP: 0018:ffffb02006b68bb0 EFLAGS: 00010086 
> [ 9692.848333][  T213] Workqueue: events pqi_ctrl_offline_worker [smartpqi] 
> [ 9692.848346][   C61] Write-error on swap-device (254:1:17105528) 
> [ 9692.848351][  C122] Write-error on swap-device (254:1:39080328) 
> [ 9692.848428][   C25] RAX: 0000000000000000 RBX: ffff97c76d8d4b80 RCX: ffffffff9d51e8f0 
> [ 9692.848433][   C61] Write-error on swap-device (254:1:17105536) 
> [ 9692.848437][  C122] Write-error on swap-device (254:1:39080336) 
> [ 9692.848445][  T213] RIP: 0010:end_swap_bio_write+0x90/0x280 
> [ 9692.848450][   C25] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff97c7e539f00a 
> [ 9692.848461][  T213] Code: 80 7b 1a 00 0f 84 58 01 00 00 4c 89 e6 bf 10 00 00 00 e8 33 f8 ff ff 84 c0 74 1d 48 c7 c6 18 7e 3b 9a 4c 89 e7 e8 20 78 fa ff <0f> 0b 48 c7 c7 b0 0b 6e 9a e8 04 ee 2b 00 4d 8d 74 24 08 ba 08 00 
> [ 9692.848466][   C25] RBP: ffffb02006b68bf0 R08: 0000000000000000 R09: 000097c7e539f00a 
> [ 9692.848471][  T213] RSP: 0018:ffffb02006dd3908 EFLAGS: 00010286 
> [ 9692.848485][   C25] R10: 0000b02006b689a0 R11: 000097c7e5ax_pmem_core efivars acpi_cpufreq efivarfs ip_tables x_tables xfs sd_mod smartpqi scsi_transport_sas tg3 mlx5_core 
> [ 9692.849818][  C122] Write-error on swap-device (254:1:39080440) 
> [ 9692.849884][  T213]  libphy 
> [ 9692.849889][  C122] Write-error on swap-device (254:1:39080448) 
> [ 9692.849952][  T213]  firmware_class 
> [ 9692.849959][  C122] Write-error on swap-device (254:1:39080456) 
> [ 9692.849963][  T213]  dm_mirror dm_region_hash dm_log dm_mod 
> [ 9692.849990][  C122] Write-error on swap-device (254:1:39080464) 
> [ 9692.850069][  C122] Write-error on swap-device (254:1:39080472) 
> [ 9692.850107][  C122] Write-error on swap-device (254:1:39080480) 
> [ 9692.850156][  C122] Write-error on swap-device (254:1:39080488) 
> [ 9692.850220][  C122] Write-error on swap-device (254:1:39080496) 
> [ 9692.850264][  C122] Write-error on swap-device (254:1:39080504) 
> [ 9692.850323][  C122] Write-error on swap-device (254:1:39080512) 
> [ 9692.850361][  C122] Write-error on swap-device (254:1:39080520) 
> [ 9692.850411][  C122] Write-error on swap-device (254:1:39080528)  
> 
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Rafael Aquini <aquini@redhat.com>
> > ---
> > mm/mprotect.c | 38 ++++++++++++++++++++++++++++++++++++--
> > 1 file changed, 36 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > index 7a8e84f86831..9ea8cc0ab2fd 100644
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -161,6 +161,31 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
> > 	return pages;
> > }
> > 
> > +/*
> > + * Used when setting automatic NUMA hinting protection where it is
> > + * critical that a numa hinting PMD is not confused with a bad PMD.
> > + */
> > +static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
> > +{
> > +	pmd_t pmdval = pmd_read_atomic(pmd);
> > +
> > +	/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +	barrier();
> > +#endif
> > +
> > +	if (pmd_none(pmdval))
> > +		return 1;
> > +	if (pmd_trans_huge(pmdval))
> > +		return 0;
> > +	if (unlikely(pmd_bad(pmdval))) {
> > +		pmd_clear_bad(pmd);
> > +		return 1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
> > 		pud_t *pud, unsigned long addr, unsigned long end,
> > 		pgprot_t newprot, int dirty_accountable, int prot_numa)
> > @@ -178,8 +203,17 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
> > 		unsigned long this_pages;
> > 
> > 		next = pmd_addr_end(addr, end);
> > -		if (!is_swap_pmd(*pmd) && !pmd_trans_huge(*pmd) && !pmd_devmap(*pmd)
> > -				&& pmd_none_or_clear_bad(pmd))
> > +
> > +		/*
> > +		 * Automatic NUMA balancing walks the tables with mmap_sem
> > +		 * held for read. It's possible a parallel update to occur
> > +		 * between pmd_trans_huge() and a pmd_none_or_clear_bad()
> > +		 * check leading to a false positive and clearing.
> > +		 * Hence, it's ecessary to atomically read the PMD value
> > +		 * for all the checks.
> > +		 */
> > +		if (!is_swap_pmd(*pmd) && !pmd_devmap(*pmd) &&
> > +		     pmd_none_or_clear_bad_unless_trans_huge(pmd))
> > 			goto next;
> > 
> > 		/* invoke the mmu notifier if the pmd is populated */
> > -- 
> > 2.24.1
> > 
> > 
> 

