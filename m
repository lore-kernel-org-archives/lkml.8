Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DF5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD2A20756
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="IOkE7RUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbgEUV1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 17:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgEUV1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 17:27:31 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2BFC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 14:27:30 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id a23so6778897qto.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 14:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8TeGwC7k1LgLk5B1QkYpSTBORNJEePl7PM+/aQJi3DI=;
        b=IOkE7RUdGKph3Gln/GphgLfe9Fxo/K9yxtrMkA7cu41pEkgO/W6Ly5o+pVmfH5PHMY
         G6KMz6qGhNeEVssPcRGmGuu0P+1uCbWFfPXQpXPrvEGj+qtXavq17GJoGMrV9FoWRmDj
         WmPT7UrcIBzxc5oSZWLkt5z69GDtuTQmgx6O9Lr6cUj7T+FDxeqEbaglTNEHeHWXPfWx
         cqaTf8EtgCYws1UguMmhy3c9YK12TGsNQAdqU32C5LjIDbH7YcFp7x6QEhwuDCi6Vwy+
         1R38xXj+ZRiakZSMu9H5+z0Pk0PUkAsPqaZsdmcOy3wU9cB0gCZpp8pqjA9OQeQlRGDT
         jSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8TeGwC7k1LgLk5B1QkYpSTBORNJEePl7PM+/aQJi3DI=;
        b=dcdungiUeOAcLj6bskhOSbGi/ZVAp3s7v1uvDOv9y7VxMfkqVRn0xjetfudWpGeqYd
         JnKMqPdBr0yNpkHiXvh3W8TcK8/817v9S5RaUPPiBwNhWCReqxhQB37nTqgsAqDYZSbU
         mUP0a5aKBGStWHfeH2NZ9VVfx/6AQI95PUIgXCWYJaBzlpJvaQudXiZhAuTRdNEZbd88
         V7GUx84wIBfzJBAsoUCssN1Vqvqx8Fo6cLB9Kheia9kvpkrDXIHSnAuezQeqvZKeDy/1
         OhQPH/RY9nVzPyFrnLl2pace7Rq9uChOlWru6M0a7uhWj6xfRLzMPFfo5JL4GK0YNzxm
         UBfA==
X-Gm-Message-State: AOAM531L2YJYGRl0o7B26Guv1fJOyCNEZB1MHnc08s0rTu7c1HtxzFts
        Pl8ke5j5lqZk2SnKxej0rFk9NA==
X-Google-Smtp-Source: ABdhPJxZ6QaxeCSe/h/Se1G7OtAAZB6pgQz+lvqvpOOLHqDrlRmrcdUA10Duv4iFmyhRZQUP5Guxzw==
X-Received: by 2002:ac8:105:: with SMTP id e5mr13009506qtg.15.1590096450013;
        Thu, 21 May 2020 14:27:30 -0700 (PDT)
Received: from ovpn-112-192.phx2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u16sm2290245qkm.107.2020.05.21.14.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 14:27:29 -0700 (PDT)
Date:   Thu, 21 May 2020 17:27:26 -0400
From:   Qian Cai <cai@lca.pw>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] make vm_committed_as_batch aware of vm overcommit
 policy
Message-ID: <20200521212726.GC6367@ovpn-112-192.phx2.redhat.com>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 03:25:14PM +0800, Feng Tang wrote:
> When checking a performance change for will-it-scale scalability
> mmap test [1], we found very high lock contention for spinlock of
> percpu counter 'vm_committed_as':
> 
>     94.14%     0.35%  [kernel.kallsyms]         [k] _raw_spin_lock_irqsave
>     48.21% _raw_spin_lock_irqsave;percpu_counter_add_batch;__vm_enough_memory;mmap_region;do_mmap;
>     45.91% _raw_spin_lock_irqsave;percpu_counter_add_batch;__do_munmap;
> 
> Actually this heavy lock contention is not always necessary. The
> 'vm_committed_as' needs to be very precise when the strict
> OVERCOMMIT_NEVER policy is set, which requires a rather small batch
> number for the percpu counter.
> 
> So lift the batch number to 16X for OVERCOMMIT_ALWAYS and
> OVERCOMMIT_GUESS policies, and add a sysctl handler to adjust it
> when the policy is reconfigured.
> 
> Benchmark with the same testcase in [1] shows 53% improvement on a
> 8C/16T desktop, and 2097%(20X) on a 4S/72C/144T server. And no change
> for some platforms, due to the test mmap size of the case is bigger
> than the batch number computed, though the patch will help mmap/munmap
> generally.
> 
> [1] https://lkml.org/lkml/2020/3/5/57
> 
> There are some style complain from checkpatch for patch 3, as it
> follows the similar format of sibling functions
> 
> patch1: a cleanup for /proc/meminfo
> patch2: a preparation patch which also improve the accuracy of
>         vm_memory_committed
> patch3: the main change
> 
> Please help to review, thanks!

Reverted this series fixed a warning under memory pressue.

[ 3319.257898] LTP: starting oom01
[ 3319.284417] ------------[ cut here ]------------
[ 3319.284439] memory commitment underflow
[ 3319.284456] WARNING: CPU: 13 PID: 130949 at mm/util.c:835 __vm_enough_memory+0x1dc/0x1f0
[ 3319.284485] Modules linked in: brd ext4 crc16 mbcache jbd2 loop kvm_hv kvm ip_tables x_tables xfs sd_mod ahci libahci bnx2x libata mdio tg3 libphy firmware_class dm_mirror dm_region_hash dm_log dm_mod
[ 3319.284538] CPU: 13 PID: 130949 Comm: oom01 Not tainted 5.7.0-rc6-next-20200521+ #115
[ 3319.284551] NIP:  c00000000043027c LR: c000000000430278 CTR: c0000000007bd120
[ 3319.284572] REGS: c00000064a42f710 TRAP: 0700   Not tainted  (5.7.0-rc6-next-20200521+)
[ 3319.284602] MSR:  900000000282b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28222422  XER: 20040000
[ 3319.284638] CFAR: c000000000119098 IRQMASK: 0 
               GPR00: c000000000430278 c00000064a42f9a0 c000000001765500 000000000000001b 
               GPR04: c00000000179c3b0 000000000000000b 0000000066726564 c00000000429ac28 
               GPR08: 0000000000000001 0000000000000000 0000000000000000 c000001301facc80 
               GPR12: 0000000000002000 c000001fffff3d80 0000000000000000 0000000000000000 
               GPR16: 0000000000000000 0000000000000000 c0000014f358dd60 fffffffffff7dfff 
               GPR20: c0000003725a9128 c0000003725a3928 c000000b0a0c0670 c000000b0a0c0678 
               GPR24: c000000b0a0c0660 c00000064a42fa58 c000000b0a0c0650 c0000003725a9080 
               GPR28: 0000000000000001 0000000000000000 c000000001620178 0000000000000001 
[ 3319.284825] NIP [c00000000043027c] __vm_enough_memory+0x1dc/0x1f0
[ 3319.284853] LR [c000000000430278] __vm_enough_memory+0x1d8/0x1f0
[ 3319.284872] Call Trace:
[ 3319.284889] [c00000064a42f9a0] [c000000000430278] __vm_enough_memory+0x1d8/0x1f0 (unreliable)
[ 3319.284930] [c00000064a42fa30] [c000000000114258] dup_mm+0x2a8/0x700
[ 3319.284960] [c00000064a42fae0] [c000000000115c7c] copy_process+0xeac/0x1a00
[ 3319.284981] [c00000064a42fbf0] [c000000000116b3c] _do_fork+0xac/0xce0
[ 3319.285002] [c00000064a42fd00] [c000000000117928] __do_sys_clone+0x98/0xe0
[ 3319.285032] [c00000064a42fdc0] [c000000000039e78] system_call_exception+0x108/0x1d0
[ 3319.285064] [c00000064a42fe20] [c00000000000c9f0] system_call_common+0xf0/0x278
[ 3319.285093] Instruction dump:
[ 3319.285109] 60000000 73a90001 4182000c e8be0002 4bfffeb8 3c62ff51 39200001 3d42fff9 
[ 3319.285142] 38636690 992a6ad6 4bce8dbd 60000000 <0fe00000> e8be0002 4bfffe90 60000000 
[ 3319.285166] irq event stamp: 0
[ 3319.285183] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 3319.285195] hardirqs last disabled at (0): [<c0000000001154c8>] copy_process+0x6f8/0x1a00
[ 3319.285216] softirqs last  enabled at (0): [<c0000000001154c8>] copy_process+0x6f8/0x1a00
[ 3319.285238] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 3319.285267] ---[ end trace 115e3f7fbb0653c2 ]---

> 
> - Feng
> 
> ----------------------------------------------------------------
> Changelog:
>   v2:
>      * add the sysctl handler to cover runtime overcommit policy
>        change, as suggested by Andres Morton 
>      * address the accuracy concern of vm_memory_committed()
>        from Andi Kleen 
> 
> Feng Tang (3):
>   proc/meminfo: avoid open coded reading of vm_committed_as
>   mm/util.c: make vm_memory_committed() more accurate
>   mm: adjust vm_committed_as_batch according to vm overcommit policy
> 
>  fs/proc/meminfo.c    |  2 +-
>  include/linux/mm.h   |  2 ++
>  include/linux/mman.h |  4 ++++
>  kernel/sysctl.c      |  2 +-
>  mm/mm_init.c         | 19 +++++++++++++++----
>  mm/util.c            | 15 ++++++++++++++-
>  6 files changed, 37 insertions(+), 7 deletions(-)
> 
> -- 
> 2.7.4
> 
> 
