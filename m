Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878D5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5795520814
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qX9AHGB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391080AbgE1OSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390924AbgE1OSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:18:10 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBA0C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:18:09 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c185so3187259qke.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y5cAlc+GwqlL3NDyt1pFU5Mosv+3peT1VgMRY4AVw18=;
        b=qX9AHGB0DO6q85oBiUGr4WVuKmP/j0f7QpUIHjndrPLaIactzh8xw22BwRNKdJYRPA
         z3zC9ovYx2Ok2GAQgAziR8g3lL3JJL6uyoKsgTUkkruIzUxReacOAnMZ9bI9xK8shXES
         THUkzHr/dIzw/urBuvk1vVbF8ej5EGHdWNazXKhUFdh2u7HHrCaemFYi7QfLPtNiU9tq
         DkqfxxAThVxSvVnKN8ofG2ghUBdvwhcR8+PbGjx2HS8uYO2QA+6JwZ/Ex1A0EVdrZ0zV
         eYxnvjHDeIzJmTNUH5M1uCMk5f8G0M4D1Fkf03hK8erQyu755ZEymcs8zsNRzj94xBZr
         AgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y5cAlc+GwqlL3NDyt1pFU5Mosv+3peT1VgMRY4AVw18=;
        b=nVSjBJKVCWcPaLhWS2dJ9ygrp9bUR7WbJZyOTIWrM8mf8jvnoMImtHpj0fttjH40R/
         Flt/rOIbL+5xhlUlIyGOeS2/p2CRd/WO/ctMG8uVDZdrBvrr8t3J55LJ/gac4fBaM8kI
         WZoME9FUaEVWCfhcmMo5ch6GJedoeLoDX3/gVpAthYYzjbz/Mb4RP3W4m9fAB2KWc9Wg
         eTZYzTuviCrUC97lkelP07kPQaT1+DCTd65ZxaDxXOiWsJzisX2r7FCJTi6TLijsgUre
         K6v2Cj0AelRd/oBTimx65jdh0YXkMtFmsl53iiG+BGaolrz5i/VYwjKwjP5i5CmRWQFh
         z1gw==
X-Gm-Message-State: AOAM530cqSCNoExhU5jrrNQ9VGM6ocvKFMcE8S/txzHQ2n9sLQ2KA5YB
        EOARb3o3Ljfb91kC3WF4uTsFzw==
X-Google-Smtp-Source: ABdhPJy+Gxmg/ljshXzrksfPtv2b/9zN+ac8yTBc7HAhdV0bg1EoXiDcJQ6Z1bXpc5C/qFRN8cH72g==
X-Received: by 2002:a37:f50e:: with SMTP id l14mr3140395qkk.482.1590675488732;
        Thu, 28 May 2020 07:18:08 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g66sm4816908qkb.122.2020.05.28.07.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:18:07 -0700 (PDT)
Date:   Thu, 28 May 2020 10:18:02 -0400
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
Message-ID: <20200528141802.GB1810@lca.pw>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <20200521212726.GC6367@ovpn-112-192.phx2.redhat.com>
 <20200526181459.GD991@lca.pw>
 <20200527014647.GB93879@shbuild999.sh.intel.com>
 <20200527022539.GK991@lca.pw>
 <20200527104606.GE93879@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527104606.GE93879@shbuild999.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 06:46:06PM +0800, Feng Tang wrote:
> Hi Qian,
> 
> On Tue, May 26, 2020 at 10:25:39PM -0400, Qian Cai wrote:
> > > > > > [1] https://lkml.org/lkml/2020/3/5/57
> > > > > 
> > > > > Reverted this series fixed a warning under memory pressue.
> > > > 
> > > > Andrew, Stephen, can you drop this series?
> > > > 
> > > > > 
> > > > > [ 3319.257898] LTP: starting oom01
> > > > > [ 3319.284417] ------------[ cut here ]------------
> > > > > [ 3319.284439] memory commitment underflow
> > > 
> > > Thanks for the catch!
> > > 
> > > Could you share the info about the platform, like the CPU numbers
> > > and RAM size, and what's the mmap test size of your test program.
> > > It would be great if you can point me the link to the test program.
> > 
> > I have been reproduced this on both AMD and Intel. The test just
> > allocating memory and swapping.
> > 
> > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/oom/oom01.c
> > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/tunable/overcommit_memory.c
> > 
> > It might be better to run the whole LTP mm tests if none of the above
> > triggers it for you which has quite a few memory pressurers.
> > 
> > /opt/ltp/runltp -f mm
> 
> Thanks for sharing. I tried to reproduce this on 2 server plaforms,
> but can't reproduce it, and they are still under testing.
> 
> Meanwhile, could you help to try the below patch, which is based on
> Andi's suggestion and have some debug info. The warning is a little
> strange, as the condition is
> 
> 	(percpu_counter_read(&vm_committed_as) <
>                        -(s64)vm_committed_as_batch * num_online_cpus())
> 
> while for your platform (48 CPU + 128 GB RAM), the
> '-(s64)vm_committed_as_batch * num_online_cpus()'
> is a s64 value: '-32G', which makes the condition hard to be true,
> and when it is,  it could be triggered by some magic for s32/s64
> operations around the percpu-counter. 

The patch below does not fix anything.

[ 3160.275230][ T7955] LTP: starting oom01
[ 3160.306977][T106365] KK as:-59683  as_sum:6896  check:-32768 batch:256
[ 3160.307161][T106365] ------------[ cut here ]------------
[ 3160.307184][T106365] memory commitment underflow
[ 3160.307216][T106365] WARNING: CPU: 103 PID: 106365 at mm/util.c:858 __vm_enough_memory+0x204/0x250
[ 3160.307275][T106365] Modules linked in: brd ext4 crc16 mbcache jbd2 loop kvm_hv kvm ip_tables x_tables xfs sd_mod bnx2x ahci libahci mdio tg3 libata libphy firmware_class dm_mirror dm_region_hash dm_log dm_mod
[ 3160.307341][T106365] CPU: 103 PID: 106365 Comm: oom01 Not tainted 5.7.0-rc7-next-20200528+ #3
[ 3160.307368][T106365] NIP:  c0000000003ee654 LR: c0000000003ee650 CTR: c000000000745b40
[ 3160.307382][T106365] REGS: c0002017f940f730 TRAP: 0700   Not tainted  (5.7.0-rc7-next-20200528+)
[ 3160.307409][T106365] MSR:  900000000282b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28222482  XER: 00000000
[ 3160.307442][T106365] CFAR: c00000000010e428 IRQMASK: 0
[ 3160.307442][T106365] GPR00: c0000000003ee650 c0002017f940f9c0 c00000000130a300 000000000000001b
[ 3160.307442][T106365] GPR04: c0000000017b8d68 0000000000000006 0000000078154885 ffffffff6ca32090
[ 3160.307442][T106365] GPR08: 0000201cc61a0000 0000000000000000 0000000000000000 0000000000000003
[ 3160.307442][T106365] GPR12: 0000000000002000 c000201fff675100 0000000000000000 0000000000000000
[ 3160.307442][T106365] GPR16: 0000000000000000 0000000000000000 c000200350fe3b60 fffffffffff7dfff
[ 3160.307442][T106365] GPR20: c000201a36824928 c000201a3682c128 c000200ee33ad3a0 c000200ee33ad3a8
[ 3160.307442][T106365] GPR24: c000200ee33ad390 ffffffffffff16dd 0000000000000000 0000000000000001
[ 3160.307442][T106365] GPR28: c000201a36824880 0000000000000001 c000000003fa2a80 c0000000011fb0a8
[ 3160.307723][T106365] NIP [c0000000003ee654] __vm_enough_memory+0x204/0x250
[ 3160.307759][T106365] LR [c0000000003ee650] __vm_enough_memory+0x200/0x250
[ 3160.307793][T106365] Call Trace:
[ 3160.307814][T106365] [c0002017f940f9c0] [c0000000003ee650] __vm_enough_memory+0x200/0x250 (unreliable)
[ 3160.307875][T106365] [c0002017f940fa60] [c000000000109ab8] dup_mm+0x2a8/0x700
[ 3160.307901][T106365] [c0002017f940fb10] [c00000000010b3f0] copy_process+0xeb0/0x1920
[ 3160.307927][T106365] [c0002017f940fc20] [c00000000010c1cc] _do_fork+0xac/0xb20
[ 3160.307941][T106365] [c0002017f940fd00] [c00000000010cdf8] __do_sys_clone+0x98/0xe0
[ 3160.307979][T106365] [c0002017f940fdc0] [c000000000038a88] system_call_exception+0x108/0x1d0
[ 3160.308018][T106365] [c0002017f940fe20] [c00000000000c9f0] system_call_common+0xf0/0x278
[ 3160.308054][T106365] Instruction dump:
[ 3160.308076][T106365] 60000000 60000000 60000000 73490001 4082fee4 3c62ff8c 39200001 3d42fff9
[ 3160.308128][T106365] 38632788 992a6b4a 4bd1fd75 60000000 <0fe00000> 4bfffec0 7fc3f378 483218f9
[ 3160.308158][T106365] irq event stamp: 760
[ 3160.308181][T106365] hardirqs last  enabled at (759): [<c0000000001e9838>] vprintk_emit+0x118/0x430
[ 3160.308231][T106365] hardirqs last disabled at (760): [<c00000000000963c>] program_check_common_virt+0x2bc/0x310
[ 3160.308281][T106365] softirqs last  enabled at (0): [<c00000000010ac38>] copy_process+0x6f8/0x1920
[ 3160.308297][T106365] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 3160.308310][T106365] ---[ end trace e2152aa44c190593 ]---
[ 3160.308478][T106365] KK as:-59683  as_sum:6897  check:-32768 batch:256
[ 3160.308614][T106365] KK as:-59683  as_sum:6898  check:-32768 batch:256
[ 3160.308714][T106365] KK as:-59683  as_sum:6901  check:-32768 batch:256
[ 3160.308806][T106365] KK as:-59683  as_sum:6902  check:-32768 batch:256
[ 3160.308900][T106365] KK as:-59683  as_sum:6903  check:-32768 batch:256
[ 3160.308979][T106365] KK as:-59683  as_sum:6904  check:-32768 batch:256
[ 3160.309064][T106365] KK as:-59683  as_sum:6905  check:-32768 batch:256
[ 3160.309160][T106365] KK as:-59683  as_sum:6906  check:-32768 batch:256
[ 3160.309275][T106365] KK as:-59683  as_sum:6907  check:-32768 batch:256
[ 3160.309356][T106365] KK as:-59683  as_sum:6908  check:-32768 batch:256
[ 3160.309437][T106365] KK as:-59683  as_sum:6909  check:-32768 batch:256
[ 3160.310939][T106366] KK as:-59683  as_sum:6912  check:-32768 batch:256
[ 3160.311134][T106366] KK as:-59270  as_sum:7040  check:-32768 batch:256
[ 3160.311240][T106367] KK as:-59270  as_sum:7168  check:-32768 batch:256

> 
> Thanks,
> Feng
> 
> ---
>  mm/util.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 988d11e6c17c..2f3a2e0f12ae 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -797,10 +797,15 @@ EXPORT_SYMBOL_GPL(vm_memory_committed);
>  int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
>  {
>  	long allowed;
> -
> -	VM_WARN_ONCE(percpu_counter_read(&vm_committed_as) <
> +	if (percpu_counter_read(&vm_committed_as) <
> +			-(s64)vm_committed_as_batch * num_online_cpus()) {
> +		printk("as:%lld  as_sum:%lld  check:%lld batch:%d\n",
> +			percpu_counter_read(&vm_committed_as),
> +			percpu_counter_sum(&vm_committed_as),
>  			-(s64)vm_committed_as_batch * num_online_cpus(),
> -			"memory commitment underflow");
> +			vm_committed_as_batch);
> +
> +	}
>  
>  	vm_acct_memory(pages);
>  
> @@ -816,6 +821,10 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
>  		return 0;
>  	}
>  
> +	VM_WARN_ONCE(percpu_counter_read(&vm_committed_as) <
> +			-(s64)vm_committed_as_batch * num_online_cpus(),
> +			"memory commitment underflow");
> +
>  	allowed = vm_commit_limit();
>  	/*
>  	 * Reserve some for root
> -- 
> 2.14.1
> 
> > 
> > # lscpu
> > Architecture:        x86_64
> > CPU op-mode(s):      32-bit, 64-bit
> > Byte Order:          Little Endian
> > CPU(s):              48
> > On-line CPU(s) list: 0-47
> > Thread(s) per core:  1
> > Core(s) per socket:  12
> > Socket(s):           4
> > NUMA node(s):        4
> > Vendor ID:           GenuineIntel
> > CPU family:          6
> > Model:               63
> > Model name:          Intel(R) Xeon(R) CPU E5-4650 v3 @ 2.10GHz
> > Stepping:            2
> > CPU MHz:             1198.498
> > BogoMIPS:            4195.14
> > Virtualization:      VT-x
> > L1d cache:           32K
> > L1i cache:           32K
> > L2 cache:            256K
> > L3 cache:            30720K
> > NUMA node0 CPU(s):   0-5,24-29
> > NUMA node1 CPU(s):   6-11,30-35
> > NUMA node2 CPU(s):   12-17,36-41
> > NUMA node3 CPU(s):   18-23,42-47
> > 
> > # numactl -H
> > available: 4 nodes (0-3)
> > node 0 cpus: 0 1 2 3 4 5 24 25 26 27 28 29
> > node 0 size: 27768 MB
> > node 0 free: 27539 MB
> > node 1 cpus: 6 7 8 9 10 11 30 31 32 33 34 35
> > node 1 size: 32225 MB
> > node 1 free: 32009 MB
> > node 2 cpus: 12 13 14 15 16 17 36 37 38 39 40 41
> > node 2 size: 32253 MB
> > node 2 free: 32174 MB
> > node 3 cpus: 18 19 20 21 22 23 42 43 44 45 46 47
> > node 3 size: 32252 MB
> > node 3 free: 31330 MB
> > node distances:
> > node   0   1   2   3
> >   0:  10  21  21  21
> >   1:  21  10  21  21
> >   2:  21  21  10  21
> >   3:  21  21  21  10
> > 
> > > 
> > > Thanks,
> > > Feng
> > > 
> > > > > [ 3319.284456] WARNING: CPU: 13 PID: 130949 at mm/util.c:835 __vm_enough_memory+0x1dc/0x1f0
> > > > > [ 3319.284485] Modules linked in: brd ext4 crc16 mbcache jbd2 loop kvm_hv kvm ip_tables x_tables xfs sd_mod ahci libahci bnx2x libata mdio tg3 libphy firmware_class dm_mirror dm_region_hash dm_log dm_mod
> > > > > [ 3319.284538] CPU: 13 PID: 130949 Comm: oom01 Not tainted 5.7.0-rc6-next-20200521+ #115
> > > > > [ 3319.284551] NIP:  c00000000043027c LR: c000000000430278 CTR: c0000000007bd120
> > > > > [ 3319.284572] REGS: c00000064a42f710 TRAP: 0700   Not tainted  (5.7.0-rc6-next-20200521+)
> > > > > [ 3319.284602] MSR:  900000000282b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28222422  XER: 20040000
> > > > > [ 3319.284638] CFAR: c000000000119098 IRQMASK: 0 
> > > > >                GPR00: c000000000430278 c00000064a42f9a0 c000000001765500 000000000000001b 
> > > > >                GPR04: c00000000179c3b0 000000000000000b 0000000066726564 c00000000429ac28 
> > > > >                GPR08: 0000000000000001 0000000000000000 0000000000000000 c000001301facc80 
> > > > >                GPR12: 0000000000002000 c000001fffff3d80 0000000000000000 0000000000000000 
> > > > >                GPR16: 0000000000000000 0000000000000000 c0000014f358dd60 fffffffffff7dfff 
> > > > >                GPR20: c0000003725a9128 c0000003725a3928 c000000b0a0c0670 c000000b0a0c0678 
> > > > >                GPR24: c000000b0a0c0660 c00000064a42fa58 c000000b0a0c0650 c0000003725a9080 
> > > > >                GPR28: 0000000000000001 0000000000000000 c000000001620178 0000000000000001 
> > > > > [ 3319.284825] NIP [c00000000043027c] __vm_enough_memory+0x1dc/0x1f0
> > > > > [ 3319.284853] LR [c000000000430278] __vm_enough_memory+0x1d8/0x1f0
> > > > > [ 3319.284872] Call Trace:
> > > > > [ 3319.284889] [c00000064a42f9a0] [c000000000430278] __vm_enough_memory+0x1d8/0x1f0 (unreliable)
> > > > > [ 3319.284930] [c00000064a42fa30] [c000000000114258] dup_mm+0x2a8/0x700
> > > > > [ 3319.284960] [c00000064a42fae0] [c000000000115c7c] copy_process+0xeac/0x1a00
> > > > > [ 3319.284981] [c00000064a42fbf0] [c000000000116b3c] _do_fork+0xac/0xce0
> > > > > [ 3319.285002] [c00000064a42fd00] [c000000000117928] __do_sys_clone+0x98/0xe0
> > > > > [ 3319.285032] [c00000064a42fdc0] [c000000000039e78] system_call_exception+0x108/0x1d0
> > > > > [ 3319.285064] [c00000064a42fe20] [c00000000000c9f0] system_call_common+0xf0/0x278
> > > > > [ 3319.285093] Instruction dump:
> > > > > [ 3319.285109] 60000000 73a90001 4182000c e8be0002 4bfffeb8 3c62ff51 39200001 3d42fff9 
> > > > > [ 3319.285142] 38636690 992a6ad6 4bce8dbd 60000000 <0fe00000> e8be0002 4bfffe90 60000000 
