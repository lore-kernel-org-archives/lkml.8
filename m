Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C0EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6E2620674
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="dGi1E52W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgEZSPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgEZSPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:15:04 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268D9C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:15:04 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e16so11046809qtg.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hvg/4Lmk/DoexJaZeVc9ePFzdQGpYxIOgFTwnk3pNjk=;
        b=dGi1E52WBsBz5vc9DUdVvtsR3VF6F2lArQswgvcXVnaaRuA1iLRl0Tl/g4U0PuDCHU
         YXZps3PxMmRyv8nJpVYbV67LEep25zd1vNbqsvbOK7Ulziegoo3Tm/9dQT+HFLf/6kK9
         sVhFJhvEJxUGzfMfKf6B5Ium0d5VNDU+SGFbFCisith8k9tTgsdq55stJSt+9BgIHRcy
         TStA2JuNIQY16eqx/PSxaARe16I3LBIZ9n0StxqLIG2wjfmVcHx9azLHH+Vdw/0Lrs/b
         CzpwDHMC5C858e2/OqGVhuaePYvbvqT1HN59CQi0N+7BUwhx/Qm55KB5ULTBE0Cqlb+l
         AiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hvg/4Lmk/DoexJaZeVc9ePFzdQGpYxIOgFTwnk3pNjk=;
        b=UVnpgQ/2Gwf7mVGUJWn5W3EdRW5RuCaK0mIRKF2WIus3SGpTtPkxefnVhO7kn0q/ar
         zkQIjQMcyEY1a2CMA5Zje+fy5X06JxWnyb6uJgteNjfzRc+501rCbf15u+oxSp8GAVzY
         1Hq5PyHGeTn/4WT5uqjoFSZVGjXrlH+xrix2m+FYwyasoXfTmMutcsBRoB9YvWICwhC0
         W0GuQT8AjNKL3Ujjvx3iGPrB876i1KoXN60yzanTjZVnKtGppakkBsY3KCvLVAjoJK82
         bwJtm7Wln3578Ylxj1Q7dpld8L1bdCarM7GSOtYJOJjhKnc43BUI1iGUEkdFK1VeSyDC
         +vNQ==
X-Gm-Message-State: AOAM531TPcAbwMHHm4mhfwaKYVxcDuqkH1sDyTeKDEsO5Ol8LnRDGBV7
        x1d+5Xvqxtn5wbLDLMa/UOv4Sg==
X-Google-Smtp-Source: ABdhPJykJfYyZvdQlC9orgNZw9asAk3eWEWbwrO86iTYyXp85X1EPM7N5LU8PkqV7WDIQCWLIB1wgw==
X-Received: by 2002:ac8:4a0c:: with SMTP id x12mr89509qtq.202.1590516903126;
        Tue, 26 May 2020 11:15:03 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b74sm327032qkc.17.2020.05.26.11.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 11:15:02 -0700 (PDT)
Date:   Tue, 26 May 2020 14:14:59 -0400
From:   Qian Cai <cai@lca.pw>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] make vm_committed_as_batch aware of vm overcommit
 policy
Message-ID: <20200526181459.GD991@lca.pw>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <20200521212726.GC6367@ovpn-112-192.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521212726.GC6367@ovpn-112-192.phx2.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 05:27:26PM -0400, Qian Cai wrote:
> On Fri, May 08, 2020 at 03:25:14PM +0800, Feng Tang wrote:
> > When checking a performance change for will-it-scale scalability
> > mmap test [1], we found very high lock contention for spinlock of
> > percpu counter 'vm_committed_as':
> > 
> >     94.14%     0.35%  [kernel.kallsyms]         [k] _raw_spin_lock_irqsave
> >     48.21% _raw_spin_lock_irqsave;percpu_counter_add_batch;__vm_enough_memory;mmap_region;do_mmap;
> >     45.91% _raw_spin_lock_irqsave;percpu_counter_add_batch;__do_munmap;
> > 
> > Actually this heavy lock contention is not always necessary. The
> > 'vm_committed_as' needs to be very precise when the strict
> > OVERCOMMIT_NEVER policy is set, which requires a rather small batch
> > number for the percpu counter.
> > 
> > So lift the batch number to 16X for OVERCOMMIT_ALWAYS and
> > OVERCOMMIT_GUESS policies, and add a sysctl handler to adjust it
> > when the policy is reconfigured.
> > 
> > Benchmark with the same testcase in [1] shows 53% improvement on a
> > 8C/16T desktop, and 2097%(20X) on a 4S/72C/144T server. And no change
> > for some platforms, due to the test mmap size of the case is bigger
> > than the batch number computed, though the patch will help mmap/munmap
> > generally.
> > 
> > [1] https://lkml.org/lkml/2020/3/5/57
> > 
> > There are some style complain from checkpatch for patch 3, as it
> > follows the similar format of sibling functions
> > 
> > patch1: a cleanup for /proc/meminfo
> > patch2: a preparation patch which also improve the accuracy of
> >         vm_memory_committed
> > patch3: the main change
> > 
> > Please help to review, thanks!
> 
> Reverted this series fixed a warning under memory pressue.

Andrew, Stephen, can you drop this series?

> 
> [ 3319.257898] LTP: starting oom01
> [ 3319.284417] ------------[ cut here ]------------
> [ 3319.284439] memory commitment underflow
> [ 3319.284456] WARNING: CPU: 13 PID: 130949 at mm/util.c:835 __vm_enough_memory+0x1dc/0x1f0
> [ 3319.284485] Modules linked in: brd ext4 crc16 mbcache jbd2 loop kvm_hv kvm ip_tables x_tables xfs sd_mod ahci libahci bnx2x libata mdio tg3 libphy firmware_class dm_mirror dm_region_hash dm_log dm_mod
> [ 3319.284538] CPU: 13 PID: 130949 Comm: oom01 Not tainted 5.7.0-rc6-next-20200521+ #115
> [ 3319.284551] NIP:  c00000000043027c LR: c000000000430278 CTR: c0000000007bd120
> [ 3319.284572] REGS: c00000064a42f710 TRAP: 0700   Not tainted  (5.7.0-rc6-next-20200521+)
> [ 3319.284602] MSR:  900000000282b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28222422  XER: 20040000
> [ 3319.284638] CFAR: c000000000119098 IRQMASK: 0 
>                GPR00: c000000000430278 c00000064a42f9a0 c000000001765500 000000000000001b 
>                GPR04: c00000000179c3b0 000000000000000b 0000000066726564 c00000000429ac28 
>                GPR08: 0000000000000001 0000000000000000 0000000000000000 c000001301facc80 
>                GPR12: 0000000000002000 c000001fffff3d80 0000000000000000 0000000000000000 
>                GPR16: 0000000000000000 0000000000000000 c0000014f358dd60 fffffffffff7dfff 
>                GPR20: c0000003725a9128 c0000003725a3928 c000000b0a0c0670 c000000b0a0c0678 
>                GPR24: c000000b0a0c0660 c00000064a42fa58 c000000b0a0c0650 c0000003725a9080 
>                GPR28: 0000000000000001 0000000000000000 c000000001620178 0000000000000001 
> [ 3319.284825] NIP [c00000000043027c] __vm_enough_memory+0x1dc/0x1f0
> [ 3319.284853] LR [c000000000430278] __vm_enough_memory+0x1d8/0x1f0
> [ 3319.284872] Call Trace:
> [ 3319.284889] [c00000064a42f9a0] [c000000000430278] __vm_enough_memory+0x1d8/0x1f0 (unreliable)
> [ 3319.284930] [c00000064a42fa30] [c000000000114258] dup_mm+0x2a8/0x700
> [ 3319.284960] [c00000064a42fae0] [c000000000115c7c] copy_process+0xeac/0x1a00
> [ 3319.284981] [c00000064a42fbf0] [c000000000116b3c] _do_fork+0xac/0xce0
> [ 3319.285002] [c00000064a42fd00] [c000000000117928] __do_sys_clone+0x98/0xe0
> [ 3319.285032] [c00000064a42fdc0] [c000000000039e78] system_call_exception+0x108/0x1d0
> [ 3319.285064] [c00000064a42fe20] [c00000000000c9f0] system_call_common+0xf0/0x278
> [ 3319.285093] Instruction dump:
> [ 3319.285109] 60000000 73a90001 4182000c e8be0002 4bfffeb8 3c62ff51 39200001 3d42fff9 
> [ 3319.285142] 38636690 992a6ad6 4bce8dbd 60000000 <0fe00000> e8be0002 4bfffe90 60000000 
> [ 3319.285166] irq event stamp: 0
> [ 3319.285183] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [ 3319.285195] hardirqs last disabled at (0): [<c0000000001154c8>] copy_process+0x6f8/0x1a00
> [ 3319.285216] softirqs last  enabled at (0): [<c0000000001154c8>] copy_process+0x6f8/0x1a00
> [ 3319.285238] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [ 3319.285267] ---[ end trace 115e3f7fbb0653c2 ]---
> 
> > 
> > - Feng
> > 
> > ----------------------------------------------------------------
> > Changelog:
> >   v2:
> >      * add the sysctl handler to cover runtime overcommit policy
> >        change, as suggested by Andres Morton 
> >      * address the accuracy concern of vm_memory_committed()
> >        from Andi Kleen 
> > 
> > Feng Tang (3):
> >   proc/meminfo: avoid open coded reading of vm_committed_as
> >   mm/util.c: make vm_memory_committed() more accurate
> >   mm: adjust vm_committed_as_batch according to vm overcommit policy
> > 
> >  fs/proc/meminfo.c    |  2 +-
> >  include/linux/mm.h   |  2 ++
> >  include/linux/mman.h |  4 ++++
> >  kernel/sysctl.c      |  2 +-
> >  mm/mm_init.c         | 19 +++++++++++++++----
> >  mm/util.c            | 15 ++++++++++++++-
> >  6 files changed, 37 insertions(+), 7 deletions(-)
> > 
> > -- 
> > 2.7.4
> > 
> > 
