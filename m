Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BF2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE6F2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404089AbgE1PK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:10:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:63214 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403881AbgE1PK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:10:27 -0400
IronPort-SDR: 2TH7a5u2BRoX74ADg8cRZsvv3jsYKudXILstXDFY85rg3l0Z36QcU4gf2dAX+PJMgaNbx6eUt1
 OcFmC6mHNr5Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 08:10:25 -0700
IronPort-SDR: He64HCINUW6aF8vbO7RLYbNE+qWrJn3zIBuDWLAaV4366eXoNR06rBrqejx90NlEGsfgsnaLnL
 MGnnF7FMPDQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="414628933"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga004.jf.intel.com with ESMTP; 28 May 2020 08:10:21 -0700
Date:   Thu, 28 May 2020 23:10:20 +0800
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
Message-ID: <20200528151020.GF93879@shbuild999.sh.intel.com>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <20200521212726.GC6367@ovpn-112-192.phx2.redhat.com>
 <20200526181459.GD991@lca.pw>
 <20200527014647.GB93879@shbuild999.sh.intel.com>
 <20200527022539.GK991@lca.pw>
 <20200527104606.GE93879@shbuild999.sh.intel.com>
 <20200528141802.GB1810@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528141802.GB1810@lca.pw>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 10:18:02AM -0400, Qian Cai wrote:
> > > I have been reproduced this on both AMD and Intel. The test just
> > > allocating memory and swapping.
> > > 
> > > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/oom/oom01.c
> > > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/tunable/overcommit_memory.c
> > > 
> > > It might be better to run the whole LTP mm tests if none of the above
> > > triggers it for you which has quite a few memory pressurers.
> > > 
> > > /opt/ltp/runltp -f mm
> > 
> > Thanks for sharing. I tried to reproduce this on 2 server plaforms,
> > but can't reproduce it, and they are still under testing.
> > 
> > Meanwhile, could you help to try the below patch, which is based on
> > Andi's suggestion and have some debug info. The warning is a little
> > strange, as the condition is
> > 
> > 	(percpu_counter_read(&vm_committed_as) <
> >                        -(s64)vm_committed_as_batch * num_online_cpus())
> > 
> > while for your platform (48 CPU + 128 GB RAM), the
> > '-(s64)vm_committed_as_batch * num_online_cpus()'
> > is a s64 value: '-32G', which makes the condition hard to be true,
> > and when it is,  it could be triggered by some magic for s32/s64
> > operations around the percpu-counter. 
> 
> The patch below does not fix anything.

Thanks for the info.

> 
> [ 3160.275230][ T7955] LTP: starting oom01
> [ 3160.306977][T106365] KK as:-59683  as_sum:6896 

This does show that percpu_counter_read() is not accurate
comparing to percpu_counter_sum(). And if we use 
percpu_counter_sum() then the warning won't happen, as
6896 >> -32768

> check:-32768 batch:256

-32768 means the RAM of the test platform  is either 512M
or 32GB (more likely) depending on overcommit policy, and
it has 128 CPUs. 

So my guess of the root cause is the overcommit policy is
changing while doing the memory stress test, so the
vm_commited_as.count could have bigger deviation when the
overcommit policy is !OVERCOMMIT_NEVER, and when the policy
is changed to OVERCOMMIT_NEVER, the check value is hugely
reduced, which trigger the warning.

If it's true, then there could be 2 solutions, one is to
skip the WARN_ONCE as it has no practical value, as the real
check is the following code, the other is to rectify the
percpu counter when the policy is changing to OVERCOMMIT_NEVER. 

Thanks,
Feng

> [ 3160.307161][T106365] ------------[ cut here ]------------
> [ 3160.307184][T106365] memory commitment underflow
> [ 3160.307216][T106365] WARNING: CPU: 103 PID: 106365 at mm/util.c:858 __vm_enough_memory+0x204/0x250
> [ 3160.307275][T106365] Modules linked in: brd ext4 crc16 mbcache jbd2 loop kvm_hv kvm ip_tables x_tables xfs sd_mod bnx2x ahci libahci mdio tg3 libata libphy firmware_class dm_mirror dm_region_hash dm_log dm_mod
> [ 3160.307341][T106365] CPU: 103 PID: 106365 Comm: oom01 Not tainted 5.7.0-rc7-next-20200528+ #3
> [ 3160.307368][T106365] NIP:  c0000000003ee654 LR: c0000000003ee650 CTR: c000000000745b40
> [ 3160.307382][T106365] REGS: c0002017f940f730 TRAP: 0700   Not tainted  (5.7.0-rc7-next-20200528+)
> [ 3160.307409][T106365] MSR:  900000000282b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28222482  XER: 00000000
> [ 3160.307442][T106365] CFAR: c00000000010e428 IRQMASK: 0
> [ 3160.307442][T106365] GPR00: c0000000003ee650 c0002017f940f9c0 c00000000130a300 000000000000001b
> [ 3160.307442][T106365] GPR04: c0000000017b8d68 0000000000000006 0000000078154885 ffffffff6ca32090
> [ 3160.307442][T106365] GPR08: 0000201cc61a0000 0000000000000000 0000000000000000 0000000000000003
> [ 3160.307442][T106365] GPR12: 0000000000002000 c000201fff675100 0000000000000000 0000000000000000
> [ 3160.307442][T106365] GPR16: 0000000000000000 0000000000000000 c000200350fe3b60 fffffffffff7dfff
> [ 3160.307442][T106365] GPR20: c000201a36824928 c000201a3682c128 c000200ee33ad3a0 c000200ee33ad3a8
> [ 3160.307442][T106365] GPR24: c000200ee33ad390 ffffffffffff16dd 0000000000000000 0000000000000001
> [ 3160.307442][T106365] GPR28: c000201a36824880 0000000000000001 c000000003fa2a80 c0000000011fb0a8
> [ 3160.307723][T106365] NIP [c0000000003ee654] __vm_enough_memory+0x204/0x250
> [ 3160.307759][T106365] LR [c0000000003ee650] __vm_enough_memory+0x200/0x250
> [ 3160.308310][T106365] ---[ end trace e2152aa44c190593 ]---
> [ 3160.308478][T106365] KK as:-59683  as_sum:6897  check:-32768 batch:256
> [ 3160.308614][T106365] KK as:-59683  as_sum:6898  check:-32768 batch:256
> [ 3160.308714][T106365] KK as:-59683  as_sum:6901  check:-32768 batch:256
> [ 3160.308806][T106365] KK as:-59683  as_sum:6902  check:-32768 batch:256
> [ 3160.308900][T106365] KK as:-59683  as_sum:6903  check:-32768 batch:256
> [ 3160.308979][T106365] KK as:-59683  as_sum:6904  check:-32768 batch:256
> [ 3160.309064][T106365] KK as:-59683  as_sum:6905  check:-32768 batch:256
> [ 3160.309160][T106365] KK as:-59683  as_sum:6906  check:-32768 batch:256
> [ 3160.309275][T106365] KK as:-59683  as_sum:6907  check:-32768 batch:256
> [ 3160.309356][T106365] KK as:-59683  as_sum:6908  check:-32768 batch:256
> [ 3160.309437][T106365] KK as:-59683  as_sum:6909  check:-32768 batch:256
> [ 3160.310939][T106366] KK as:-59683  as_sum:6912  check:-32768 batch:256
> [ 3160.311134][T106366] KK as:-59270  as_sum:7040  check:-32768 batch:256
> [ 3160.311240][T106367] KK as:-59270  as_sum:7168  check:-32768 batch:256
> 
