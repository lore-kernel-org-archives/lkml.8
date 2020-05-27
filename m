Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0DFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D58B20888
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgE0Bqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:46:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:32574 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgE0Bqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:46:53 -0400
IronPort-SDR: O+O/uocb5Rlc+Z7RveADbT0B1clbNTQIJMwgxNV+uoJ1OkcolitvKoyHK/eI0E3sLk+KEaFrH3
 0AC98WA7+RQQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 18:46:53 -0700
IronPort-SDR: Cf62kFi7YkZ3YUAAK9mk0W0O7m3pzSKs5qklf1rikCGL2zhWHuY03kNAfbhuXRm4tSGRn9CV5y
 2/P27otfLRSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,439,1583222400"; 
   d="scan'208";a="468564332"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by fmsmga006.fm.intel.com with ESMTP; 26 May 2020 18:46:48 -0700
Date:   Wed, 27 May 2020 09:46:47 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Qian Cai <cai@lca.pw>
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
Message-ID: <20200527014647.GB93879@shbuild999.sh.intel.com>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <20200521212726.GC6367@ovpn-112-192.phx2.redhat.com>
 <20200526181459.GD991@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526181459.GD991@lca.pw>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

On Tue, May 26, 2020 at 02:14:59PM -0400, Qian Cai wrote:
> On Thu, May 21, 2020 at 05:27:26PM -0400, Qian Cai wrote:
> > On Fri, May 08, 2020 at 03:25:14PM +0800, Feng Tang wrote:
> > > When checking a performance change for will-it-scale scalability
> > > mmap test [1], we found very high lock contention for spinlock of
> > > percpu counter 'vm_committed_as':
> > > 
> > >     94.14%     0.35%  [kernel.kallsyms]         [k] _raw_spin_lock_irqsave
> > >     48.21% _raw_spin_lock_irqsave;percpu_counter_add_batch;__vm_enough_memory;mmap_region;do_mmap;
> > >     45.91% _raw_spin_lock_irqsave;percpu_counter_add_batch;__do_munmap;
> > > 
> > > Actually this heavy lock contention is not always necessary. The
> > > 'vm_committed_as' needs to be very precise when the strict
> > > OVERCOMMIT_NEVER policy is set, which requires a rather small batch
> > > number for the percpu counter.
> > > 
> > > So lift the batch number to 16X for OVERCOMMIT_ALWAYS and
> > > OVERCOMMIT_GUESS policies, and add a sysctl handler to adjust it
> > > when the policy is reconfigured.
> > > 
> > > Benchmark with the same testcase in [1] shows 53% improvement on a
> > > 8C/16T desktop, and 2097%(20X) on a 4S/72C/144T server. And no change
> > > for some platforms, due to the test mmap size of the case is bigger
> > > than the batch number computed, though the patch will help mmap/munmap
> > > generally.
> > > 
> > > [1] https://lkml.org/lkml/2020/3/5/57
> > 
> > Reverted this series fixed a warning under memory pressue.
> 
> Andrew, Stephen, can you drop this series?
> 
> > 
> > [ 3319.257898] LTP: starting oom01
> > [ 3319.284417] ------------[ cut here ]------------
> > [ 3319.284439] memory commitment underflow

Thanks for the catch!

Could you share the info about the platform, like the CPU numbers
and RAM size, and what's the mmap test size of your test program.
It would be great if you can point me the link to the test program.

Thanks,
Feng

> > [ 3319.284456] WARNING: CPU: 13 PID: 130949 at mm/util.c:835 __vm_enough_memory+0x1dc/0x1f0
> > [ 3319.284485] Modules linked in: brd ext4 crc16 mbcache jbd2 loop kvm_hv kvm ip_tables x_tables xfs sd_mod ahci libahci bnx2x libata mdio tg3 libphy firmware_class dm_mirror dm_region_hash dm_log dm_mod
> > [ 3319.284538] CPU: 13 PID: 130949 Comm: oom01 Not tainted 5.7.0-rc6-next-20200521+ #115
> > [ 3319.284551] NIP:  c00000000043027c LR: c000000000430278 CTR: c0000000007bd120
> > [ 3319.284572] REGS: c00000064a42f710 TRAP: 0700   Not tainted  (5.7.0-rc6-next-20200521+)
> > [ 3319.284602] MSR:  900000000282b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28222422  XER: 20040000
> > [ 3319.284638] CFAR: c000000000119098 IRQMASK: 0 
> >                GPR00: c000000000430278 c00000064a42f9a0 c000000001765500 000000000000001b 
> >                GPR04: c00000000179c3b0 000000000000000b 0000000066726564 c00000000429ac28 
> >                GPR08: 0000000000000001 0000000000000000 0000000000000000 c000001301facc80 
> >                GPR12: 0000000000002000 c000001fffff3d80 0000000000000000 0000000000000000 
> >                GPR16: 0000000000000000 0000000000000000 c0000014f358dd60 fffffffffff7dfff 
> >                GPR20: c0000003725a9128 c0000003725a3928 c000000b0a0c0670 c000000b0a0c0678 
> >                GPR24: c000000b0a0c0660 c00000064a42fa58 c000000b0a0c0650 c0000003725a9080 
> >                GPR28: 0000000000000001 0000000000000000 c000000001620178 0000000000000001 
> > [ 3319.284825] NIP [c00000000043027c] __vm_enough_memory+0x1dc/0x1f0
> > [ 3319.284853] LR [c000000000430278] __vm_enough_memory+0x1d8/0x1f0
> > [ 3319.284872] Call Trace:
> > [ 3319.284889] [c00000064a42f9a0] [c000000000430278] __vm_enough_memory+0x1d8/0x1f0 (unreliable)
> > [ 3319.284930] [c00000064a42fa30] [c000000000114258] dup_mm+0x2a8/0x700
> > [ 3319.284960] [c00000064a42fae0] [c000000000115c7c] copy_process+0xeac/0x1a00
> > [ 3319.284981] [c00000064a42fbf0] [c000000000116b3c] _do_fork+0xac/0xce0
> > [ 3319.285002] [c00000064a42fd00] [c000000000117928] __do_sys_clone+0x98/0xe0
> > [ 3319.285032] [c00000064a42fdc0] [c000000000039e78] system_call_exception+0x108/0x1d0
> > [ 3319.285064] [c00000064a42fe20] [c00000000000c9f0] system_call_common+0xf0/0x278
> > [ 3319.285093] Instruction dump:
> > [ 3319.285109] 60000000 73a90001 4182000c e8be0002 4bfffeb8 3c62ff51 39200001 3d42fff9 
> > [ 3319.285142] 38636690 992a6ad6 4bce8dbd 60000000 <0fe00000> e8be0002 4bfffe90 60000000 
