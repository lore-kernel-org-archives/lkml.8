Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0D9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 02:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32F63208B6
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 02:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="AoCpWGsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgE0CZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 22:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgE0CZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 22:25:44 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A02C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 19:25:43 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s1so22976212qkf.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 19:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=100qRK0v59tkRA6luhba8f77DGLb1v0NKntxYlUPLeo=;
        b=AoCpWGsLhocOaQvRCd4/NnrsZIyyWCF3KprBbpRTvsWyqFaItLOfrq5NXGleiLn6+K
         MMGUV11C88H8suRaz0C+94n4tLS3QPeLX90VRzwMy70dKK72LL32v4+jUd+WcaKHKWBP
         CFnZUfX4mPMZGh+NpwuSyEYOP0AG+aHfUeg86wJgj+HBK0PUQCj5rJpozi/fFSrcJ41F
         Gu2okmDr5GZK6WjWrYTKutO+Ljd5yOp077bjslvKm0r6Yha72At7KCzcgHmm/QbQBJCV
         kDdvF3mBvA7TWF+XvGJ00vH7i4vPYY4pXr1s/O6uCtiwcTw025O0AovtAA1/GMTC2jqe
         s7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=100qRK0v59tkRA6luhba8f77DGLb1v0NKntxYlUPLeo=;
        b=Aqw/5WNk2EvbDvOZQyldSJ26tbMW8jXvE1cE2LbVA/5i4/nbTfuednzHf4WRv2gd3w
         9nO61dBjo5CYR1fZsfQDuv9ZLExTUuKaZaKTCCF9dH8K7Djxglib2yGI1V4icouXyiWd
         778tuZpI8q9cm0zOh8SLYo9poqmaj2GrNjFpYm+U6VJabHrvl7VnHGEUTp+MT3V6Fhnz
         b5Y/wODdQrccOyX8vP8WSKDclk7Vm6pUjMaEXGlMXrnH/aDa189NSzD+C0wksuB2CVNH
         QoOIrQGCT2vRGBYVO6G7dDbKcS0cglFaotNvnF8kAiuVfzdgZ8p9HcLek/TqQh9KrxBB
         zGQw==
X-Gm-Message-State: AOAM532od6xyGppxdwm9ImxfX6pEqbYvqjHaIxxvZS/XCFwVtLeevwsx
        zl5iBhPbuQgCqByWn9B/2zmosQ==
X-Google-Smtp-Source: ABdhPJw/Gi2P4B7fenwuZ/2u8oZ6G6IWk7IlG4FwftoxLVY8mAe2gn4E+ldOmPrLIpg6Wdw2nds3rA==
X-Received: by 2002:a37:9b81:: with SMTP id d123mr1717681qke.324.1590546342258;
        Tue, 26 May 2020 19:25:42 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l22sm1190010qki.45.2020.05.26.19.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 19:25:41 -0700 (PDT)
Date:   Tue, 26 May 2020 22:25:39 -0400
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
Message-ID: <20200527022539.GK991@lca.pw>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <20200521212726.GC6367@ovpn-112-192.phx2.redhat.com>
 <20200526181459.GD991@lca.pw>
 <20200527014647.GB93879@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527014647.GB93879@shbuild999.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 09:46:47AM +0800, Feng Tang wrote:
> Hi Qian,
> 
> On Tue, May 26, 2020 at 02:14:59PM -0400, Qian Cai wrote:
> > On Thu, May 21, 2020 at 05:27:26PM -0400, Qian Cai wrote:
> > > On Fri, May 08, 2020 at 03:25:14PM +0800, Feng Tang wrote:
> > > > When checking a performance change for will-it-scale scalability
> > > > mmap test [1], we found very high lock contention for spinlock of
> > > > percpu counter 'vm_committed_as':
> > > > 
> > > >     94.14%     0.35%  [kernel.kallsyms]         [k] _raw_spin_lock_irqsave
> > > >     48.21% _raw_spin_lock_irqsave;percpu_counter_add_batch;__vm_enough_memory;mmap_region;do_mmap;
> > > >     45.91% _raw_spin_lock_irqsave;percpu_counter_add_batch;__do_munmap;
> > > > 
> > > > Actually this heavy lock contention is not always necessary. The
> > > > 'vm_committed_as' needs to be very precise when the strict
> > > > OVERCOMMIT_NEVER policy is set, which requires a rather small batch
> > > > number for the percpu counter.
> > > > 
> > > > So lift the batch number to 16X for OVERCOMMIT_ALWAYS and
> > > > OVERCOMMIT_GUESS policies, and add a sysctl handler to adjust it
> > > > when the policy is reconfigured.
> > > > 
> > > > Benchmark with the same testcase in [1] shows 53% improvement on a
> > > > 8C/16T desktop, and 2097%(20X) on a 4S/72C/144T server. And no change
> > > > for some platforms, due to the test mmap size of the case is bigger
> > > > than the batch number computed, though the patch will help mmap/munmap
> > > > generally.
> > > > 
> > > > [1] https://lkml.org/lkml/2020/3/5/57
> > > 
> > > Reverted this series fixed a warning under memory pressue.
> > 
> > Andrew, Stephen, can you drop this series?
> > 
> > > 
> > > [ 3319.257898] LTP: starting oom01
> > > [ 3319.284417] ------------[ cut here ]------------
> > > [ 3319.284439] memory commitment underflow
> 
> Thanks for the catch!
> 
> Could you share the info about the platform, like the CPU numbers
> and RAM size, and what's the mmap test size of your test program.
> It would be great if you can point me the link to the test program.

I have been reproduced this on both AMD and Intel. The test just
allocating memory and swapping.

https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/oom/oom01.c
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/tunable/overcommit_memory.c

It might be better to run the whole LTP mm tests if none of the above
triggers it for you which has quite a few memory pressurers.

/opt/ltp/runltp -f mm

# lscpu
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              48
On-line CPU(s) list: 0-47
Thread(s) per core:  1
Core(s) per socket:  12
Socket(s):           4
NUMA node(s):        4
Vendor ID:           GenuineIntel
CPU family:          6
Model:               63
Model name:          Intel(R) Xeon(R) CPU E5-4650 v3 @ 2.10GHz
Stepping:            2
CPU MHz:             1198.498
BogoMIPS:            4195.14
Virtualization:      VT-x
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            30720K
NUMA node0 CPU(s):   0-5,24-29
NUMA node1 CPU(s):   6-11,30-35
NUMA node2 CPU(s):   12-17,36-41
NUMA node3 CPU(s):   18-23,42-47

# numactl -H
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 24 25 26 27 28 29
node 0 size: 27768 MB
node 0 free: 27539 MB
node 1 cpus: 6 7 8 9 10 11 30 31 32 33 34 35
node 1 size: 32225 MB
node 1 free: 32009 MB
node 2 cpus: 12 13 14 15 16 17 36 37 38 39 40 41
node 2 size: 32253 MB
node 2 free: 32174 MB
node 3 cpus: 18 19 20 21 22 23 42 43 44 45 46 47
node 3 size: 32252 MB
node 3 free: 31330 MB
node distances:
node   0   1   2   3
  0:  10  21  21  21
  1:  21  10  21  21
  2:  21  21  10  21
  3:  21  21  21  10

> 
> Thanks,
> Feng
> 
> > > [ 3319.284456] WARNING: CPU: 13 PID: 130949 at mm/util.c:835 __vm_enough_memory+0x1dc/0x1f0
> > > [ 3319.284485] Modules linked in: brd ext4 crc16 mbcache jbd2 loop kvm_hv kvm ip_tables x_tables xfs sd_mod ahci libahci bnx2x libata mdio tg3 libphy firmware_class dm_mirror dm_region_hash dm_log dm_mod
> > > [ 3319.284538] CPU: 13 PID: 130949 Comm: oom01 Not tainted 5.7.0-rc6-next-20200521+ #115
> > > [ 3319.284551] NIP:  c00000000043027c LR: c000000000430278 CTR: c0000000007bd120
> > > [ 3319.284572] REGS: c00000064a42f710 TRAP: 0700   Not tainted  (5.7.0-rc6-next-20200521+)
> > > [ 3319.284602] MSR:  900000000282b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28222422  XER: 20040000
> > > [ 3319.284638] CFAR: c000000000119098 IRQMASK: 0 
> > >                GPR00: c000000000430278 c00000064a42f9a0 c000000001765500 000000000000001b 
> > >                GPR04: c00000000179c3b0 000000000000000b 0000000066726564 c00000000429ac28 
> > >                GPR08: 0000000000000001 0000000000000000 0000000000000000 c000001301facc80 
> > >                GPR12: 0000000000002000 c000001fffff3d80 0000000000000000 0000000000000000 
> > >                GPR16: 0000000000000000 0000000000000000 c0000014f358dd60 fffffffffff7dfff 
> > >                GPR20: c0000003725a9128 c0000003725a3928 c000000b0a0c0670 c000000b0a0c0678 
> > >                GPR24: c000000b0a0c0660 c00000064a42fa58 c000000b0a0c0650 c0000003725a9080 
> > >                GPR28: 0000000000000001 0000000000000000 c000000001620178 0000000000000001 
> > > [ 3319.284825] NIP [c00000000043027c] __vm_enough_memory+0x1dc/0x1f0
> > > [ 3319.284853] LR [c000000000430278] __vm_enough_memory+0x1d8/0x1f0
> > > [ 3319.284872] Call Trace:
> > > [ 3319.284889] [c00000064a42f9a0] [c000000000430278] __vm_enough_memory+0x1d8/0x1f0 (unreliable)
> > > [ 3319.284930] [c00000064a42fa30] [c000000000114258] dup_mm+0x2a8/0x700
> > > [ 3319.284960] [c00000064a42fae0] [c000000000115c7c] copy_process+0xeac/0x1a00
> > > [ 3319.284981] [c00000064a42fbf0] [c000000000116b3c] _do_fork+0xac/0xce0
> > > [ 3319.285002] [c00000064a42fd00] [c000000000117928] __do_sys_clone+0x98/0xe0
> > > [ 3319.285032] [c00000064a42fdc0] [c000000000039e78] system_call_exception+0x108/0x1d0
> > > [ 3319.285064] [c00000064a42fe20] [c00000000000c9f0] system_call_common+0xf0/0x278
> > > [ 3319.285093] Instruction dump:
> > > [ 3319.285109] 60000000 73a90001 4182000c e8be0002 4bfffeb8 3c62ff51 39200001 3d42fff9 
> > > [ 3319.285142] 38636690 992a6ad6 4bce8dbd 60000000 <0fe00000> e8be0002 4bfffe90 60000000 
