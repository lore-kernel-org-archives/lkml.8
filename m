Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CA2C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 04:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB3220739
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 04:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387803AbgCLEXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 00:23:47 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63262 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387756AbgCLEXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 00:23:46 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02C4NMh7078162;
        Thu, 12 Mar 2020 13:23:22 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp);
 Thu, 12 Mar 2020 13:23:22 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02C4NMsG078157;
        Thu, 12 Mar 2020 13:23:22 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id 02C4NMgH078156;
        Thu, 12 Mar 2020 13:23:22 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <202003120423.02C4NMgH078156@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP systems
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
MIME-Version: 1.0
Date:   Thu, 12 Mar 2020 13:23:22 +0900
References: <alpine.DEB.2.21.2003111513180.195367@chino.kir.corp.google.com> 
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > We used to have a schedule_timeout_killable(1) to address exactly that 
> > scenario but it was removed in 4.19:
> > 
> > commit 9bfe5ded054b8e28a94c78580f233d6879a00146
> > Author: Michal Hocko <mhocko@suse.com>
> > Date:   Fri Aug 17 15:49:04 2018 -0700
> > 
> >     mm, oom: remove sleep from under oom_lock
> 

For the record: If I revert that commit, I can observe that
current thread sleeps for more than one minute with oom_lock held.
That is, I don't want to revert that commit.

[ 1629.930998][T14021] idle-priority invoked oom-killer: gfp_mask=0x100dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO), order=0, oom_score_adj=0
[ 1629.934944][T14021] CPU: 0 PID: 14021 Comm: idle-priority Kdump: loaded Not tainted 5.6.0-rc5+ #968
[ 1629.938352][T14021] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 07/29/2019
[ 1629.942211][T14021] Call Trace:
[ 1629.943956][T14021]  dump_stack+0x71/0xa5
[ 1629.946041][T14021]  dump_header+0x4d/0x3e0
[ 1629.948097][T14021]  oom_kill_process+0x179/0x210
[ 1629.950191][T14021]  out_of_memory+0x109/0x3d0
[ 1629.952154][T14021]  ? out_of_memory+0x1ea/0x3d0
[ 1629.954349][T14021]  __alloc_pages_slowpath+0x934/0xb89
[ 1629.956959][T14021]  __alloc_pages_nodemask+0x333/0x370
[ 1629.959121][T14021]  handle_pte_fault+0x4ce/0xb40
[ 1629.961274][T14021]  __handle_mm_fault+0x2b2/0x5e0
[ 1629.963363][T14021]  handle_mm_fault+0x177/0x360
[ 1629.965404][T14021]  ? handle_mm_fault+0x46/0x360
[ 1629.967451][T14021]  do_page_fault+0x2d5/0x680
[ 1629.969351][T14021]  page_fault+0x34/0x40
[ 1629.971290][T14021] RIP: 0010:__clear_user+0x36/0x70
[ 1629.973621][T14021] Code: 0c a7 e2 95 53 48 89 f3 be 14 00 00 00 e8 82 87 b4 ff 0f 01 cb 48 89 d8 48 c1 eb 03 4c 89 e7 83 e0 07 48 89 d9 48 85 c9 74 0f <48> c7 07 00 00 00 00 48 83 c7 08 ff c9 75 f1 48 89 c1 85 c9 74 0a
[ 1629.980104][T14021] RSP: 0000:ffffa06e0742bd40 EFLAGS: 00050202
[ 1629.982543][T14021] RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000002
[ 1629.985322][T14021] RDX: 0000000000000000 RSI: 00000000a8057a95 RDI: 00007f0ca8605000
[ 1629.999883][T14021] RBP: ffffa06e0742bd50 R08: 0000000000000001 R09: 0000000000000000
[ 1630.018164][T14021] R10: 0000000000000000 R11: ffff953843a80978 R12: 00007f0ca8604010
[ 1630.021491][T14021] R13: 000000000c988000 R14: ffffa06e0742be08 R15: 0000000000001000
[ 1630.024881][T14021]  clear_user+0x47/0x60
[ 1630.026651][T14021]  iov_iter_zero+0x95/0x3d0
[ 1630.028455][T14021]  read_iter_zero+0x38/0xb0
[ 1630.030234][T14021]  new_sync_read+0x112/0x1b0
[ 1630.032025][T14021]  __vfs_read+0x27/0x40
[ 1630.033639][T14021]  vfs_read+0xaf/0x160
[ 1630.035243][T14021]  ksys_read+0x62/0xe0
[ 1630.036869][T14021]  __x64_sys_read+0x15/0x20
[ 1630.038827][T14021]  do_syscall_64+0x4a/0x1e0
[ 1630.040515][T14021]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1630.042598][T14021] RIP: 0033:0x7f109bb78950
[ 1630.044208][T14021] Code: Bad RIP value.
[ 1630.045798][T14021] RSP: 002b:00007fff499db458 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[ 1630.048558][T14021] RAX: ffffffffffffffda RBX: 0000000200000000 RCX: 00007f109bb78950
[ 1630.051117][T14021] RDX: 0000000200000000 RSI: 00007f0c9bc7c010 RDI: 0000000000000003
[ 1630.053715][T14021] RBP: 00007f0c9bc7c010 R08: 0000000000000000 R09: 0000000000021000
[ 1630.056488][T14021] R10: 00007fff499daea0 R11: 0000000000000246 R12: 00007f0c9bc7c010
[ 1630.059124][T14021] R13: 0000000000000005 R14: 0000000000000003 R15: 0000000000000000
[ 1630.061935][T14021] Mem-Info:
[ 1630.063226][T14021] active_anon:1314192 inactive_anon:5198 isolated_anon:0
[ 1630.063226][T14021]  active_file:9 inactive_file:0 isolated_file:0
[ 1630.063226][T14021]  unevictable:0 dirty:0 writeback:0 unstable:0
[ 1630.063226][T14021]  slab_reclaimable:6649 slab_unreclaimable:268898
[ 1630.063226][T14021]  mapped:1094 shmem:10475 pagetables:127946 bounce:0
[ 1630.063226][T14021]  free:25585 free_pcp:62 free_cma:0
[ 1630.075882][T14021] Node 0 active_anon:5256768kB inactive_anon:20792kB active_file:36kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:4376kB dirty:0kB writeback:0kB shmem:41900kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 3158016kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
[ 1630.084961][T14021] DMA free:15360kB min:132kB low:164kB high:196kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15960kB managed:15360kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[ 1630.094169][T14021] lowmem_reserve[]: 0 2717 7644 7644
[ 1630.096174][T14021] DMA32 free:43680kB min:23972kB low:29964kB high:35956kB reserved_highatomic:0KB active_anon:2733524kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129152kB managed:2782468kB mlocked:0kB kernel_stack:0kB pagetables:4764kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[ 1630.106132][T14021] lowmem_reserve[]: 0 0 4927 4927
[ 1630.108104][T14021] Normal free:43300kB min:43476kB low:54344kB high:65212kB reserved_highatomic:4096KB active_anon:2523244kB inactive_anon:20792kB active_file:36kB inactive_file:0kB unevictable:0kB writepending:0kB present:5242880kB managed:5045744kB mlocked:0kB kernel_stack:313872kB pagetables:507020kB bounce:0kB free_pcp:248kB local_pcp:248kB free_cma:0kB
[ 1630.118473][T14021] lowmem_reserve[]: 0 0 0 0
[ 1630.120348][T14021] DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
[ 1630.124316][T14021] DMA32: 0*4kB 0*8kB 2*16kB (UM) 2*32kB (UM) 1*64kB (U) 0*128kB 2*256kB (UM) 2*512kB (UM) 1*1024kB (M) 2*2048kB (UM) 9*4096kB (M) = 43680kB
[ 1630.128773][T14021] Normal: 1231*4kB (UE) 991*8kB (UE) 343*16kB (UME) 230*32kB (UE) 117*64kB (UME) 65*128kB (UME) 7*256kB (UM) 0*512kB 0*1024kB 0*2048kB 0*4096kB = 43300kB
[ 1630.134207][T14021] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[ 1630.137435][T14021] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[ 1630.140770][T14021] 10478 total pagecache pages
[ 1630.142789][T14021] 0 pages in swap cache
[ 1630.144572][T14021] Swap cache stats: add 0, delete 0, find 0/0
[ 1630.146921][T14021] Free swap  = 0kB
[ 1630.148627][T14021] Total swap = 0kB
[ 1630.150298][T14021] 2096998 pages RAM
[ 1630.152078][T14021] 0 pages HighMem/MovableOnly
[ 1630.154073][T14021] 136105 pages reserved
[ 1630.156165][T14021] 0 pages cma reserved
[ 1630.158028][T14021] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),global_oom,task_memcg=/,task=normal-priority,pid=23173,uid=0
[ 1630.161867][T14021] Out of memory: Killed process 23173 (normal-priority) total-vm:4228kB, anon-rss:88kB, file-rss:0kB, shmem-rss:0kB, UID:0 pgtables:52kB oom_score_adj:1000
[ 1630.171681][   T18] oom_reaper: reaped process 23173 (normal-priority), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
(...snipped...)
[ 1800.548694][    C0] idle-priority   R  running task    12416 14021   1183 0x80004080
[ 1800.550942][    C0] Call Trace:
[ 1800.552116][    C0]  __schedule+0x28c/0x860
[ 1800.553531][    C0]  ? _raw_spin_unlock_irqrestore+0x2c/0x50
[ 1800.555293][    C0]  schedule+0x5f/0xd0
[ 1800.556618][    C0]  schedule_timeout+0x1ab/0x340
[ 1800.558151][    C0]  ? __next_timer_interrupt+0xd0/0xd0
[ 1800.560069][    C0]  schedule_timeout_killable+0x25/0x30
[ 1800.561836][    C0]  out_of_memory+0x113/0x3d0
[ 1800.563519][    C0]  ? out_of_memory+0x1ea/0x3d0
[ 1800.565040][    C0]  __alloc_pages_slowpath+0x934/0xb89
[ 1800.566727][    C0]  __alloc_pages_nodemask+0x333/0x370
[ 1800.568397][    C0]  handle_pte_fault+0x4ce/0xb40
[ 1800.569944][    C0]  __handle_mm_fault+0x2b2/0x5e0
[ 1800.571527][    C0]  handle_mm_fault+0x177/0x360
[ 1800.573046][    C0]  ? handle_mm_fault+0x46/0x360
[ 1800.574592][    C0]  do_page_fault+0x2d5/0x680
[ 1800.576306][    C0]  page_fault+0x34/0x40
[ 1800.578413][    C0] RIP: 0010:__clear_user+0x36/0x70
