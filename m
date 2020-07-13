Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD544C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43FED2068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Ze5gLer4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgGMP6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgGMP6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:58:10 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EA5C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 08:58:09 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id dm12so5983698qvb.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 08:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=heuTuwEfzS/FJuTn9iH9vkI2bV3+gqB1nRE4e1uwaxk=;
        b=Ze5gLer4rPet5ltZlEvqwnzwEBrKsY1SaMif0oVYl+jHWm/xlbacYqbl1aWjCXlPHh
         0zsga3MeGO67fsqPtNVKA5J3dEavWS/ijB3QncR5/j9Rpqgbff9rRvrGOnJmcRwCZj1c
         2/ZzCEepvdKc3x2T6vicaIaD6S7nxjI4v6Eh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=heuTuwEfzS/FJuTn9iH9vkI2bV3+gqB1nRE4e1uwaxk=;
        b=W7mJIHaPxnsRulFC5atRt3qjbf0mQyZcnvWWcG9JiOiCmL7RDOcbZJPdiDo4Opwjwv
         vcXS9l1b3SxjzOHDDA/tePFVVyxd/gWJVvTlz355GcamRkQOEe8P2TWBKfqmoCC8TVDX
         IzcT5U3L00YQwUb75EA3UhvqO4x5cQEg5lIgflkp2YcGA1lB12UX03GLdLuYXglct/+w
         9/oSeEO6m1ejIhzu68N+hdrfywDdhd2OJx0eCZvyrWBmzFPbIln0mxJ1Afz2I8om0mwU
         biHujwL608TEVbqQNU1kY+s2tDlHODJl/b6oOxwA0wc6FtWRBOL5UllwqIOZJKyGd94K
         JO8A==
X-Gm-Message-State: AOAM532HGr7sm8x6cqdw+/6g6nk8NHeE+iVywR36hraI3+LTQRyppP/I
        CK1z0hZo118HKaLwMS4Vc9tx/Q==
X-Google-Smtp-Source: ABdhPJyDNCZB+vbrYv0pat2Rel3FhQandEExY/wz2h+0iFtLVaMOuCtvjq9oJahQfN/dqESC4ssCJw==
X-Received: by 2002:a0c:8643:: with SMTP id p61mr112760qva.43.1594655887385;
        Mon, 13 Jul 2020 08:58:07 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id h41sm20276419qtk.68.2020.07.13.08.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 08:58:06 -0700 (PDT)
Date:   Mon, 13 Jul 2020 11:58:06 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineethrp@gmail.com,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 14/16] irq: Add support for core-wide protection of
 IRQ and softirq
Message-ID: <20200713155806.GA3962782@google.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <c783b3890b6df669a72c7c4a3012950d009b8034.1593530334.git.vpillai@digitalocean.com>
 <ed837e01-043b-e19b-293c-30d44df6f3a8@linux.intel.com>
 <20200710132129.GA303583@google.com>
 <dc71306f-2693-0e02-8886-5daf96cfa11d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc71306f-2693-0e02-8886-5daf96cfa11d@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 10:23:31AM +0800, Li, Aubrey wrote:
> On 2020/7/10 21:21, Joel Fernandes wrote:
> > On Fri, Jul 10, 2020 at 08:19:24PM +0800, Li, Aubrey wrote:
> >> Hi Joel/Vineeth,
> >>
> >>
> >> The problem is gone when we reverted this patch. We are running multiple
> >> uperf threads(equal to cpu number) in a cgroup with coresched enabled.
> >> This is 100% reproducible on our side.
> > 
> > Interesting. I am guessing you are not doing any hotplug since those fixes
> > were removed from v6 to expose those hotplug issues..
> > 
> > The last known lockups with this patch were fixed. Appreciate if you can dig
> > in more and provide logs/traces. The last one I remember was:
> > 
> > HT1                                  HT2
> >                                      irq_enter()
> > 				     	- sets the core-wide flag
> > <softirq running>                    
> >       acquires a lock.
> >   <gets irq>
> >   irq_enter() - do nothing.
> >   irq_exit() - busy wait on flag.
> >                                      irq_exit()
> > 				       <softirq running>
> > 				       acquire a lock and deadlock.
> > 
> > The fix was to call sched_core_irq_enter() when you enter enter a softirq
> > from paths other than irq_exit().
> > 
> > Other than this one, we have not seen lockups in heavy testing over the last
> > 2 months since we redesigned this patch to enter the 'private state' on the
> > outer-most core-wide sched_core_irq_enter().
> 
> When the first soft lockup panic on CPU75, it's waiting on flush tlb IPI.
> 
> [  170.641645] CPU: 75 PID: 5393 Comm: uperf Kdump: loaded Not tainted 5.7.6+ #3
> [  170.641651] RIP: 0010:smp_call_function_many_cond+0x2b1/0x2e0
> ----snip----
> [  170.641660] Call Trace:
> [  170.641666]  ? flush_tlb_func_common.constprop.10+0x220/0x220
> [  170.641668]  ? x86_configure_nx+0x50/0x50
> [  170.641669]  ? flush_tlb_func_common.constprop.10+0x220/0x220
> [  170.641670]  on_each_cpu_cond_mask+0x2f/0x80
> [  170.641671]  flush_tlb_mm_range+0xab/0xe0
> [  170.641677]  change_protection+0x18a/0xca0
> [  170.641682]  ? __switch_to_asm+0x34/0x70
> [  170.641685]  change_prot_numa+0x15/0x30
> [  170.641689]  task_numa_work+0x1aa/0x2c0
> [  170.641694]  task_work_run+0x76/0xa0
> [  170.641698]  exit_to_usermode_loop+0xeb/0xf0
> [  170.641700]  do_syscall_64+0x1aa/0x1d0
> [  170.641701]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> If I read the code correctly, I assume someone is pending on irq_exit() so IPI
> can't return to CPU75, and I found it's CPU91
> 
> [  170.652257] CPU: 91 PID: 5401 Comm: uperf Kdump: loaded Not tainted 5.7.6+ #3
> [  170.652257] RIP: 0010:sched_core_irq_exit+0xcc/0x110
> ----snip----
> [  170.652261] Call Trace:
> [  170.652262]  <IRQ>
> [  170.652262]  irq_exit+0x6a/0xb0
> [  170.652262]  smp_apic_timer_interrupt+0x74/0x130
> [  170.652262]  apic_timer_interrupt+0xf/0x20
> 
> Then I check the stack of CPU91's sibling CPU19, and found it's on a spin lock.
> 
> [  170.643678] CPU: 19 PID: 5385 Comm: uperf Kdump: loaded Not tainted 5.7.6+ #3
> [  170.643679] RIP: 0010:native_queued_spin_lock_slowpath+0x137/0x1e0
> [  170.643684] Call Trace:
> [  170.643684]  <IRQ>
> [  170.643684]  _raw_spin_lock+0x1b/0x20
> [  170.643685]  tcp_delack_timer+0x2c/0xf0
> [  170.643685]  ? tcp_delack_timer_handler+0x170/0x170
> [  170.643685]  call_timer_fn+0x2d/0x130
> [  170.643685]  run_timer_softirq+0x420/0x450
> [  170.643686]  ? enqueue_hrtimer+0x39/0x90
> [  170.643686]  ? __hrtimer_run_queues+0x138/0x290
> [  170.643686]  __do_softirq+0xed/0x2f0
> [  170.643686]  irq_exit+0xad/0xb0
> [  170.643686]  smp_apic_timer_interrupt+0x74/0x130
> [  170.643687]  apic_timer_interrupt+0xf/0x20
> ----snip----
> [  170.643738]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> So I guess the problem is,
> 
> CPU91					CPU19
> (1)hold a bh_lock_sock(sk)
> (2)<gets irq>
> 					(3) <gets irq>
> (4) irq_exit()
>     -> sched_core_irq_exit()
>        - not outermost, wait()
> 					(5) invoke softirq
> 					(6) acquire bh_lock_sock() and deadlock
> 					(7) sched_core_irq_exit()
> 
> In case I understood anything wrong, I attached the full dmesg.

Thanks a lot for the debugging. This matches the case I mentioned yesterday
so I think that's it.

> IMHO, can we let irq exit and wait before return user mode? I think we
> can trust anything running in the kernel.

Sure, we are waiting in the schedule loop after context_switch(), so per the
patch Vineeth sent, that does exactly what you mentioned.

Another idea is to do it from softirq (so we can raise_softirq). That will
eliminate the deadlock you mentioned since the CPU91 holding the bh_lock_sock
will keep bh disabled until the lock is dropped. Once the lock is dropped, it
will then do the wait in softirq.

But we are thinking softirq-wait might not be needed and resched_curr(rq) from
irq_exit() is sufficient, if the performance of calling into the
schedule_loop is not that much. Vineeth is collecting some data on this.

I was also thinking we should add lockdep annotations to the wait code to
have lockdep catch lock vs wait dependency issues. But probably that is more
useful only if we decide to go the softirq route (sinch in the __schedule()
code, we drop the rq lock before spinning and no other lock should be held).

thanks,

 - Joel


> [    0.000000] Linux version 5.7.6+ (root@ssp_clx_cdi391) (gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04), GNU ld (GNU Binutils for Ubuntu) 2.30) #3 SMP Mon Jul 13 01:11:27 UTC 2020
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.7.6+ root=/dev/mapper/ubuntu--vg-ubuntu--lv ro console=tty0 console=ttyS0,115200n8 softlockup_panic=1 crashkernel=512M-:768M
> [    0.000000] KERNEL supported cpus:
> [    0.000000]   Intel GenuineIntel
> [    0.000000]   AMD AuthenticAMD
> [    0.000000]   Hygon HygonGenuine
> [    0.000000]   Centaur CentaurHauls
> [    0.000000]   zhaoxin   Shanghai  
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
> [    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
> [    0.000000] x86/fpu: xstate_offset[5]:  960, xstate_sizes[5]:   64
> [    0.000000] x86/fpu: xstate_offset[6]: 1024, xstate_sizes[6]:  512
> [    0.000000] x86/fpu: xstate_offset[7]: 1536, xstate_sizes[7]: 1024
> [    0.000000] x86/fpu: xstate_offset[9]: 2560, xstate_sizes[9]:    8
> [    0.000000] x86/fpu: Enabled xstate features 0x2ff, context size is 2568 bytes, using 'compacted' format.
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009dfff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009efff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000065e0efff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000065e0f000-0x000000006764efff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000006764f000-0x0000000068ca7fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x0000000068ca8000-0x00000000695fdfff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x00000000695fe000-0x000000006f7fffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000006f800000-0x000000008fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000506fffffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] e820: update [mem 0x5c84f018-0x5c883c57] usable ==> usable
> [    0.000000] e820: update [mem 0x5c84f018-0x5c883c57] usable ==> usable
> [    0.000000] e820: update [mem 0x5c81a018-0x5c84ec57] usable ==> usable
> [    0.000000] e820: update [mem 0x5c81a018-0x5c84ec57] usable ==> usable
> [    0.000000] extended physical RAM map:
> [    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009dfff] usable
> [    0.000000] reserve setup_data: [mem 0x000000000009e000-0x000000000009efff] reserved
> [    0.000000] reserve setup_data: [mem 0x000000000009f000-0x000000000009ffff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000005c81a017] usable
> [    0.000000] reserve setup_data: [mem 0x000000005c81a018-0x000000005c84ec57] usable
> [    0.000000] reserve setup_data: [mem 0x000000005c84ec58-0x000000005c84f017] usable
> [    0.000000] reserve setup_data: [mem 0x000000005c84f018-0x000000005c883c57] usable
> [    0.000000] reserve setup_data: [mem 0x000000005c883c58-0x0000000065e0efff] usable
> [    0.000000] reserve setup_data: [mem 0x0000000065e0f000-0x000000006764efff] reserved
> [    0.000000] reserve setup_data: [mem 0x000000006764f000-0x0000000068ca7fff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 0x0000000068ca8000-0x00000000695fdfff] ACPI data
> [    0.000000] reserve setup_data: [mem 0x00000000695fe000-0x000000006f7fffff] usable
> [    0.000000] reserve setup_data: [mem 0x000000006f800000-0x000000008fffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000506fffffff] usable
> [    0.000000] efi: EFI v2.70 by EDK II
> [    0.000000] efi:  ACPI=0x695fd000  ACPI 2.0=0x695fd014  TPMFinalLog=0x68bee000  SMBIOS=0x65e98000  SMBIOS 3.0=0x65e96000  MEMATTR=0x65d35018  TPMEventLog=0x5f610018 
> [    0.000000] SMBIOS 3.2.0 present.
> [    0.000000] DMI: Intel Corporation CooperCity/CooperCity, BIOS WLYDCRB1.SYS.0016.P38.2006170234 06/17/2020
> [    0.000000] tsc: Detected 2500.000 MHz processor
> [    0.000541] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000542] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000547] last_pfn = 0x5070000 max_arch_pfn = 0x400000000
> [    0.000551] MTRR default type: uncachable
> [    0.000552] MTRR fixed ranges enabled:
> [    0.000553]   00000-9FFFF write-back
> [    0.000554]   A0000-FFFFF uncachable
> [    0.000554] MTRR variable ranges enabled:
> [    0.000556]   0 base 000000000000 mask 3FC000000000 write-back
> [    0.000557]   1 base 004000000000 mask 3FF000000000 write-back
> [    0.000557]   2 base 005000000000 mask 3FFF80000000 write-back
> [    0.000558]   3 base 005070000000 mask 3FFFF0000000 uncachable
> [    0.000559]   4 base 000080000000 mask 3FFF80000000 uncachable
> [    0.000560]   5 base 00007F000000 mask 3FFFFF000000 uncachable
> [    0.000560]   6 disabled
> [    0.000561]   7 disabled
> [    0.000561]   8 disabled
> [    0.000562]   9 disabled
> [    0.001367] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.002413] total RAM covered: 327408M
> [    0.002560]  gran_size: 64K 	chunk_size: 64K 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002562]  gran_size: 64K 	chunk_size: 128K 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002563]  gran_size: 64K 	chunk_size: 256K 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002564]  gran_size: 64K 	chunk_size: 512K 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002565]  gran_size: 64K 	chunk_size: 1M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002567]  gran_size: 64K 	chunk_size: 2M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002568]  gran_size: 64K 	chunk_size: 4M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002569]  gran_size: 64K 	chunk_size: 8M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002570]  gran_size: 64K 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002571]  gran_size: 64K 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002572]  gran_size: 64K 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002573]  gran_size: 64K 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002575]  gran_size: 64K 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002576] *BAD*gran_size: 64K 	chunk_size: 512M 	num_reg: 10  	lose cover RAM: -256M
> [    0.002577] *BAD*gran_size: 64K 	chunk_size: 1G 	num_reg: 10  	lose cover RAM: -256M
> [    0.002578] *BAD*gran_size: 64K 	chunk_size: 2G 	num_reg: 10  	lose cover RAM: -256M
> [    0.002579]  gran_size: 128K 	chunk_size: 128K 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002580]  gran_size: 128K 	chunk_size: 256K 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002582]  gran_size: 128K 	chunk_size: 512K 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002583]  gran_size: 128K 	chunk_size: 1M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002584]  gran_size: 128K 	chunk_size: 2M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002585]  gran_size: 128K 	chunk_size: 4M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002586]  gran_size: 128K 	chunk_size: 8M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002587]  gran_size: 128K 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002588]  gran_size: 128K 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002589]  gran_size: 128K 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002590]  gran_size: 128K 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002592]  gran_size: 128K 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002593] *BAD*gran_size: 128K 	chunk_size: 512M 	num_reg: 10  	lose cover RAM: -256M
> [    0.002594] *BAD*gran_size: 128K 	chunk_size: 1G 	num_reg: 10  	lose cover RAM: -256M
> [    0.002595] *BAD*gran_size: 128K 	chunk_size: 2G 	num_reg: 10  	lose cover RAM: -256M
> [    0.002596]  gran_size: 256K 	chunk_size: 256K 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002597]  gran_size: 256K 	chunk_size: 512K 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002598]  gran_size: 256K 	chunk_size: 1M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002599]  gran_size: 256K 	chunk_size: 2M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002601]  gran_size: 256K 	chunk_size: 4M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002602]  gran_size: 256K 	chunk_size: 8M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002603]  gran_size: 256K 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002604]  gran_size: 256K 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002605]  gran_size: 256K 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002606]  gran_size: 256K 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002607]  gran_size: 256K 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002608] *BAD*gran_size: 256K 	chunk_size: 512M 	num_reg: 10  	lose cover RAM: -256M
> [    0.002610] *BAD*gran_size: 256K 	chunk_size: 1G 	num_reg: 10  	lose cover RAM: -256M
> [    0.002611] *BAD*gran_size: 256K 	chunk_size: 2G 	num_reg: 10  	lose cover RAM: -256M
> [    0.002612]  gran_size: 512K 	chunk_size: 512K 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002613]  gran_size: 512K 	chunk_size: 1M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002614]  gran_size: 512K 	chunk_size: 2M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002615]  gran_size: 512K 	chunk_size: 4M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002616]  gran_size: 512K 	chunk_size: 8M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002617]  gran_size: 512K 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002618]  gran_size: 512K 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002619]  gran_size: 512K 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002621]  gran_size: 512K 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002622]  gran_size: 512K 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002623] *BAD*gran_size: 512K 	chunk_size: 512M 	num_reg: 10  	lose cover RAM: -256M
> [    0.002624] *BAD*gran_size: 512K 	chunk_size: 1G 	num_reg: 10  	lose cover RAM: -256M
> [    0.002625] *BAD*gran_size: 512K 	chunk_size: 2G 	num_reg: 10  	lose cover RAM: -256M
> [    0.002626]  gran_size: 1M 	chunk_size: 1M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002627]  gran_size: 1M 	chunk_size: 2M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002629]  gran_size: 1M 	chunk_size: 4M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002630]  gran_size: 1M 	chunk_size: 8M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002631]  gran_size: 1M 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002632]  gran_size: 1M 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002633]  gran_size: 1M 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002634]  gran_size: 1M 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002635]  gran_size: 1M 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002636] *BAD*gran_size: 1M 	chunk_size: 512M 	num_reg: 10  	lose cover RAM: -256M
> [    0.002638] *BAD*gran_size: 1M 	chunk_size: 1G 	num_reg: 10  	lose cover RAM: -256M
> [    0.002639] *BAD*gran_size: 1M 	chunk_size: 2G 	num_reg: 10  	lose cover RAM: -256M
> [    0.002640]  gran_size: 2M 	chunk_size: 2M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002641]  gran_size: 2M 	chunk_size: 4M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002642]  gran_size: 2M 	chunk_size: 8M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002643]  gran_size: 2M 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002644]  gran_size: 2M 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002645]  gran_size: 2M 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002646]  gran_size: 2M 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002648]  gran_size: 2M 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002649] *BAD*gran_size: 2M 	chunk_size: 512M 	num_reg: 10  	lose cover RAM: -256M
> [    0.002650] *BAD*gran_size: 2M 	chunk_size: 1G 	num_reg: 10  	lose cover RAM: -256M
> [    0.002651] *BAD*gran_size: 2M 	chunk_size: 2G 	num_reg: 10  	lose cover RAM: -256M
> [    0.002652]  gran_size: 4M 	chunk_size: 4M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002653]  gran_size: 4M 	chunk_size: 8M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002654]  gran_size: 4M 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002655]  gran_size: 4M 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002656]  gran_size: 4M 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002657]  gran_size: 4M 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002659]  gran_size: 4M 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002660] *BAD*gran_size: 4M 	chunk_size: 512M 	num_reg: 10  	lose cover RAM: -256M
> [    0.002661] *BAD*gran_size: 4M 	chunk_size: 1G 	num_reg: 10  	lose cover RAM: -256M
> [    0.002662] *BAD*gran_size: 4M 	chunk_size: 2G 	num_reg: 10  	lose cover RAM: -256M
> [    0.002663]  gran_size: 8M 	chunk_size: 8M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002664]  gran_size: 8M 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002665]  gran_size: 8M 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002666]  gran_size: 8M 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002667]  gran_size: 8M 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002669]  gran_size: 8M 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002670] *BAD*gran_size: 8M 	chunk_size: 512M 	num_reg: 10  	lose cover RAM: -256M
> [    0.002671] *BAD*gran_size: 8M 	chunk_size: 1G 	num_reg: 10  	lose cover RAM: -256M
> [    0.002672] *BAD*gran_size: 8M 	chunk_size: 2G 	num_reg: 10  	lose cover RAM: -256M
> [    0.002673]  gran_size: 16M 	chunk_size: 16M 	num_reg: 10  	lose cover RAM: 296704M
> [    0.002674]  gran_size: 16M 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002675]  gran_size: 16M 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002676]  gran_size: 16M 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002677]  gran_size: 16M 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 768M
> [    0.002679] *BAD*gran_size: 16M 	chunk_size: 512M 	num_reg: 10  	lose cover RAM: -256M
> [    0.002680] *BAD*gran_size: 16M 	chunk_size: 1G 	num_reg: 10  	lose cover RAM: -256M
> [    0.002681] *BAD*gran_size: 16M 	chunk_size: 2G 	num_reg: 10  	lose cover RAM: -256M
> [    0.002682]  gran_size: 32M 	chunk_size: 32M 	num_reg: 10  	lose cover RAM: 263952M
> [    0.002683]  gran_size: 32M 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 784M
> [    0.002684]  gran_size: 32M 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 784M
> [    0.002685]  gran_size: 32M 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 784M
> [    0.002687] *BAD*gran_size: 32M 	chunk_size: 512M 	num_reg: 10  	lose cover RAM: -240M
> [    0.002688] *BAD*gran_size: 32M 	chunk_size: 1G 	num_reg: 10  	lose cover RAM: -240M
> [    0.002689] *BAD*gran_size: 32M 	chunk_size: 2G 	num_reg: 10  	lose cover RAM: -240M
> [    0.002690]  gran_size: 64M 	chunk_size: 64M 	num_reg: 10  	lose cover RAM: 198448M
> [    0.002691]  gran_size: 64M 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 816M
> [    0.002692]  gran_size: 64M 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 816M
> [    0.002693] *BAD*gran_size: 64M 	chunk_size: 512M 	num_reg: 10  	lose cover RAM: -208M
> [    0.002694] *BAD*gran_size: 64M 	chunk_size: 1G 	num_reg: 10  	lose cover RAM: -208M
> [    0.002696] *BAD*gran_size: 64M 	chunk_size: 2G 	num_reg: 10  	lose cover RAM: -208M
> [    0.002697]  gran_size: 128M 	chunk_size: 128M 	num_reg: 10  	lose cover RAM: 67440M
> [    0.002698]  gran_size: 128M 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 880M
> [    0.002699] *BAD*gran_size: 128M 	chunk_size: 512M 	num_reg: 10  	lose cover RAM: -144M
> [    0.002700] *BAD*gran_size: 128M 	chunk_size: 1G 	num_reg: 10  	lose cover RAM: -144M
> [    0.002701] *BAD*gran_size: 128M 	chunk_size: 2G 	num_reg: 10  	lose cover RAM: -144M
> [    0.002702]  gran_size: 256M 	chunk_size: 256M 	num_reg: 10  	lose cover RAM: 2032M
> [    0.002704] *BAD*gran_size: 256M 	chunk_size: 512M 	num_reg: 10  	lose cover RAM: -16M
> [    0.002705] *BAD*gran_size: 256M 	chunk_size: 1G 	num_reg: 10  	lose cover RAM: -16M
> [    0.002706] *BAD*gran_size: 256M 	chunk_size: 2G 	num_reg: 10  	lose cover RAM: -16M
> [    0.002707]  gran_size: 512M 	chunk_size: 512M 	num_reg: 10  	lose cover RAM: 1264M
> [    0.002708]  gran_size: 512M 	chunk_size: 1G 	num_reg: 10  	lose cover RAM: 240M
> [    0.002709]  gran_size: 512M 	chunk_size: 2G 	num_reg: 10  	lose cover RAM: 240M
> [    0.002711]  gran_size: 1G 	chunk_size: 1G 	num_reg: 9  	lose cover RAM: 1776M
> [    0.002712]  gran_size: 1G 	chunk_size: 2G 	num_reg: 10  	lose cover RAM: 1776M
> [    0.002713]  gran_size: 2G 	chunk_size: 2G 	num_reg: 7  	lose cover RAM: 3824M
> [    0.002714] mtrr_cleanup: can not find optimal value
> [    0.002715] please specify mtrr_gran_size/mtrr_chunk_size
> [    0.002719] e820: update [mem 0x7f000000-0xffffffff] usable ==> reserved
> [    0.002722] last_pfn = 0x6f800 max_arch_pfn = 0x400000000
> [    0.028467] check: Scanning 1 areas for low memory corruption
> [    0.028471] kexec: Reserving the low 1M of memory for crashkernel
> [    0.028475] Using GB pages for direct mapping
> [    0.028812] Secure boot disabled
> [    0.028813] RAMDISK: [mem 0x3c803000-0x3fffdfff]
> [    0.028826] ACPI: Early table checksum verification disabled
> [    0.028829] ACPI: RSDP 0x00000000695FD014 000024 (v02 INTEL )
> [    0.028833] ACPI: XSDT 0x0000000068E98188 0000F4 (v01 INTEL  INTEL ID 00000000 INTL 01000013)
> [    0.028839] ACPI: FACP 0x00000000695F4000 000114 (v06 INTEL  INTEL ID 00000000 INTL 20091013)
> [    0.028844] ACPI: DSDT 0x000000006955C000 091BA6 (v02 INTEL  INTEL ID 00000003 INTL 20091013)
> [    0.028848] ACPI: FACS 0x0000000068BE5000 000040
> [    0.028850] ACPI: SSDT 0x00000000695FB000 0004C5 (v02 INTEL  INTEL ID 00000000 MSFT 0100000D)
> [    0.028853] ACPI: SSDT 0x00000000695FA000 000479 (v02 INTEL  RAS_ACPI 00000001 INTL 20181003)
> [    0.028856] ACPI: SSDT 0x00000000695F9000 00060E (v02 INTEL  Tpm2Tabl 00001000 INTL 20181003)
> [    0.028859] ACPI: TPM2 0x00000000695F8000 00004C (v04 INTEL  INTEL ID 00000002 INTL 01000013)
> [    0.028862] ACPI: SSDT 0x00000000695F7000 000663 (v02 INTEL  ADDRXLAT 00000001 INTL 20181003)
> [    0.028865] ACPI: BERT 0x00000000695F6000 000030 (v01 INTEL  INTEL ID 00000001 INTL 00000001)
> [    0.028868] ACPI: ERST 0x00000000695F5000 000230 (v01 INTEL  INTEL ID 00000001 INTL 00000001)
> [    0.028870] ACPI: HMAT 0x00000000695F3000 000270 (v01 INTEL  INTEL ID 00000001 INTL 20091013)
> [    0.028873] ACPI: HPET 0x00000000695F2000 000038 (v01 INTEL  INTEL ID 00000001 INTL 20091013)
> [    0.028876] ACPI: MCFG 0x00000000695F1000 00003C (v01 INTEL  INTEL ID 00000001 INTL 20091013)
> [    0.028879] ACPI: MIGT 0x00000000695F0000 000040 (v01 INTEL  INTEL ID 00000000 INTL 20091013)
> [    0.028882] ACPI: MSCT 0x00000000695EF000 0000E8 (v01 INTEL  INTEL ID 00000001 INTL 20091013)
> [    0.028884] ACPI: WDDT 0x00000000695EE000 000040 (v01 INTEL  INTEL ID 00000000 INTL 20091013)
> [    0.028887] ACPI: APIC 0x000000006955B000 00059E (v04 INTEL  INTEL ID 00000000 INTL 20091013)
> [    0.028890] ACPI: SLIT 0x0000000069556000 00402C (v01 INTEL  INTEL ID 00000001 INTL 01000013)
> [    0.028893] ACPI: SRAT 0x000000006954A000 00B430 (v03 INTEL  INTEL ID 00000002 INTL 01000013)
> [    0.028896] ACPI: OEM4 0x000000006923A000 30F461 (v02 INTEL  CPU  CST 00003000 INTL 20181003)
> [    0.028899] ACPI: OEM1 0x0000000069013000 226889 (v02 INTEL  CPU EIST 00003000 INTL 20181003)
> [    0.028902] ACPI: OEM2 0x0000000068F86000 08C031 (v02 INTEL  CPU  HWP 00003000 INTL 20181003)
> [    0.028905] ACPI: SSDT 0x0000000068E99000 0EC8A5 (v02 INTEL  SSDT  PM 00004000 INTL 20181003)
> [    0.028907] ACPI: SSDT 0x00000000695FC000 000943 (v02 INTEL  INTEL ID 00000000 INTL 20091013)
> [    0.028910] ACPI: HEST 0x0000000068E97000 00013C (v01 INTEL  INTEL ID 00000001 INTL 00000001)
> [    0.028913] ACPI: SSDT 0x0000000068E88000 00E497 (v02 INTEL  SpsNm    00000002 INTL 20181003)
> [    0.028916] ACPI: SPCR 0x0000000068E87000 000050 (v02 INTEL  INTEL ID 00000000 INTL 01000013)
> [    0.028919] ACPI: FPDT 0x0000000068E86000 000044 (v01 INTEL  INTEL ID 00000002 INTL 01000013)
> [    0.028926] ACPI: Local APIC address 0xfee00000
> [    0.029007] SRAT: PXM 0 -> APIC 0x00 -> Node 0
> [    0.029008] SRAT: PXM 0 -> APIC 0x02 -> Node 0
> [    0.029008] SRAT: PXM 0 -> APIC 0x04 -> Node 0
> [    0.029009] SRAT: PXM 0 -> APIC 0x06 -> Node 0
> [    0.029010] SRAT: PXM 0 -> APIC 0x08 -> Node 0
> [    0.029011] SRAT: PXM 0 -> APIC 0x10 -> Node 0
> [    0.029012] SRAT: PXM 0 -> APIC 0x12 -> Node 0
> [    0.029012] SRAT: PXM 0 -> APIC 0x14 -> Node 0
> [    0.029013] SRAT: PXM 0 -> APIC 0x16 -> Node 0
> [    0.029014] SRAT: PXM 0 -> APIC 0x20 -> Node 0
> [    0.029015] SRAT: PXM 0 -> APIC 0x22 -> Node 0
> [    0.029015] SRAT: PXM 0 -> APIC 0x24 -> Node 0
> [    0.029016] SRAT: PXM 0 -> APIC 0x26 -> Node 0
> [    0.029017] SRAT: PXM 0 -> APIC 0x28 -> Node 0
> [    0.029018] SRAT: PXM 0 -> APIC 0x30 -> Node 0
> [    0.029018] SRAT: PXM 0 -> APIC 0x32 -> Node 0
> [    0.029019] SRAT: PXM 0 -> APIC 0x34 -> Node 0
> [    0.029020] SRAT: PXM 0 -> APIC 0x36 -> Node 0
> [    0.029021] SRAT: PXM 1 -> APIC 0x40 -> Node 1
> [    0.029021] SRAT: PXM 1 -> APIC 0x42 -> Node 1
> [    0.029022] SRAT: PXM 1 -> APIC 0x44 -> Node 1
> [    0.029023] SRAT: PXM 1 -> APIC 0x46 -> Node 1
> [    0.029024] SRAT: PXM 1 -> APIC 0x48 -> Node 1
> [    0.029024] SRAT: PXM 1 -> APIC 0x50 -> Node 1
> [    0.029025] SRAT: PXM 1 -> APIC 0x52 -> Node 1
> [    0.029026] SRAT: PXM 1 -> APIC 0x54 -> Node 1
> [    0.029027] SRAT: PXM 1 -> APIC 0x56 -> Node 1
> [    0.029027] SRAT: PXM 1 -> APIC 0x60 -> Node 1
> [    0.029028] SRAT: PXM 1 -> APIC 0x62 -> Node 1
> [    0.029029] SRAT: PXM 1 -> APIC 0x64 -> Node 1
> [    0.029030] SRAT: PXM 1 -> APIC 0x66 -> Node 1
> [    0.029030] SRAT: PXM 1 -> APIC 0x68 -> Node 1
> [    0.029031] SRAT: PXM 1 -> APIC 0x70 -> Node 1
> [    0.029032] SRAT: PXM 1 -> APIC 0x72 -> Node 1
> [    0.029033] SRAT: PXM 1 -> APIC 0x74 -> Node 1
> [    0.029033] SRAT: PXM 1 -> APIC 0x76 -> Node 1
> [    0.029034] SRAT: PXM 2 -> APIC 0x80 -> Node 2
> [    0.029035] SRAT: PXM 2 -> APIC 0x82 -> Node 2
> [    0.029036] SRAT: PXM 2 -> APIC 0x84 -> Node 2
> [    0.029036] SRAT: PXM 2 -> APIC 0x86 -> Node 2
> [    0.029037] SRAT: PXM 2 -> APIC 0x88 -> Node 2
> [    0.029038] SRAT: PXM 2 -> APIC 0x90 -> Node 2
> [    0.029039] SRAT: PXM 2 -> APIC 0x92 -> Node 2
> [    0.029039] SRAT: PXM 2 -> APIC 0x94 -> Node 2
> [    0.029040] SRAT: PXM 2 -> APIC 0x96 -> Node 2
> [    0.029041] SRAT: PXM 2 -> APIC 0xa0 -> Node 2
> [    0.029042] SRAT: PXM 2 -> APIC 0xa2 -> Node 2
> [    0.029042] SRAT: PXM 2 -> APIC 0xa4 -> Node 2
> [    0.029043] SRAT: PXM 2 -> APIC 0xa6 -> Node 2
> [    0.029044] SRAT: PXM 2 -> APIC 0xa8 -> Node 2
> [    0.029045] SRAT: PXM 2 -> APIC 0xb0 -> Node 2
> [    0.029045] SRAT: PXM 2 -> APIC 0xb2 -> Node 2
> [    0.029046] SRAT: PXM 2 -> APIC 0xb4 -> Node 2
> [    0.029047] SRAT: PXM 2 -> APIC 0xb6 -> Node 2
> [    0.029048] SRAT: PXM 3 -> APIC 0xc0 -> Node 3
> [    0.029048] SRAT: PXM 3 -> APIC 0xc2 -> Node 3
> [    0.029049] SRAT: PXM 3 -> APIC 0xc4 -> Node 3
> [    0.029050] SRAT: PXM 3 -> APIC 0xc6 -> Node 3
> [    0.029051] SRAT: PXM 3 -> APIC 0xc8 -> Node 3
> [    0.029051] SRAT: PXM 3 -> APIC 0xd0 -> Node 3
> [    0.029052] SRAT: PXM 3 -> APIC 0xd2 -> Node 3
> [    0.029053] SRAT: PXM 3 -> APIC 0xd4 -> Node 3
> [    0.029054] SRAT: PXM 3 -> APIC 0xd6 -> Node 3
> [    0.029054] SRAT: PXM 3 -> APIC 0xe0 -> Node 3
> [    0.029055] SRAT: PXM 3 -> APIC 0xe2 -> Node 3
> [    0.029056] SRAT: PXM 3 -> APIC 0xe4 -> Node 3
> [    0.029057] SRAT: PXM 3 -> APIC 0xe6 -> Node 3
> [    0.029057] SRAT: PXM 3 -> APIC 0xe8 -> Node 3
> [    0.029058] SRAT: PXM 3 -> APIC 0xf0 -> Node 3
> [    0.029059] SRAT: PXM 3 -> APIC 0xf2 -> Node 3
> [    0.029060] SRAT: PXM 3 -> APIC 0xf4 -> Node 3
> [    0.029060] SRAT: PXM 3 -> APIC 0xf6 -> Node 3
> [    0.029061] SRAT: PXM 0 -> APIC 0x01 -> Node 0
> [    0.029062] SRAT: PXM 0 -> APIC 0x03 -> Node 0
> [    0.029063] SRAT: PXM 0 -> APIC 0x05 -> Node 0
> [    0.029063] SRAT: PXM 0 -> APIC 0x07 -> Node 0
> [    0.029064] SRAT: PXM 0 -> APIC 0x09 -> Node 0
> [    0.029065] SRAT: PXM 0 -> APIC 0x11 -> Node 0
> [    0.029066] SRAT: PXM 0 -> APIC 0x13 -> Node 0
> [    0.029066] SRAT: PXM 0 -> APIC 0x15 -> Node 0
> [    0.029067] SRAT: PXM 0 -> APIC 0x17 -> Node 0
> [    0.029068] SRAT: PXM 0 -> APIC 0x21 -> Node 0
> [    0.029069] SRAT: PXM 0 -> APIC 0x23 -> Node 0
> [    0.029069] SRAT: PXM 0 -> APIC 0x25 -> Node 0
> [    0.029070] SRAT: PXM 0 -> APIC 0x27 -> Node 0
> [    0.029071] SRAT: PXM 0 -> APIC 0x29 -> Node 0
> [    0.029071] SRAT: PXM 0 -> APIC 0x31 -> Node 0
> [    0.029072] SRAT: PXM 0 -> APIC 0x33 -> Node 0
> [    0.029073] SRAT: PXM 0 -> APIC 0x35 -> Node 0
> [    0.029074] SRAT: PXM 0 -> APIC 0x37 -> Node 0
> [    0.029074] SRAT: PXM 1 -> APIC 0x41 -> Node 1
> [    0.029075] SRAT: PXM 1 -> APIC 0x43 -> Node 1
> [    0.029076] SRAT: PXM 1 -> APIC 0x45 -> Node 1
> [    0.029077] SRAT: PXM 1 -> APIC 0x47 -> Node 1
> [    0.029077] SRAT: PXM 1 -> APIC 0x49 -> Node 1
> [    0.029078] SRAT: PXM 1 -> APIC 0x51 -> Node 1
> [    0.029079] SRAT: PXM 1 -> APIC 0x53 -> Node 1
> [    0.029080] SRAT: PXM 1 -> APIC 0x55 -> Node 1
> [    0.029080] SRAT: PXM 1 -> APIC 0x57 -> Node 1
> [    0.029081] SRAT: PXM 1 -> APIC 0x61 -> Node 1
> [    0.029082] SRAT: PXM 1 -> APIC 0x63 -> Node 1
> [    0.029083] SRAT: PXM 1 -> APIC 0x65 -> Node 1
> [    0.029083] SRAT: PXM 1 -> APIC 0x67 -> Node 1
> [    0.029084] SRAT: PXM 1 -> APIC 0x69 -> Node 1
> [    0.029085] SRAT: PXM 1 -> APIC 0x71 -> Node 1
> [    0.029086] SRAT: PXM 1 -> APIC 0x73 -> Node 1
> [    0.029086] SRAT: PXM 1 -> APIC 0x75 -> Node 1
> [    0.029087] SRAT: PXM 1 -> APIC 0x77 -> Node 1
> [    0.029088] SRAT: PXM 2 -> APIC 0x81 -> Node 2
> [    0.029089] SRAT: PXM 2 -> APIC 0x83 -> Node 2
> [    0.029089] SRAT: PXM 2 -> APIC 0x85 -> Node 2
> [    0.029090] SRAT: PXM 2 -> APIC 0x87 -> Node 2
> [    0.029091] SRAT: PXM 2 -> APIC 0x89 -> Node 2
> [    0.029092] SRAT: PXM 2 -> APIC 0x91 -> Node 2
> [    0.029092] SRAT: PXM 2 -> APIC 0x93 -> Node 2
> [    0.029093] SRAT: PXM 2 -> APIC 0x95 -> Node 2
> [    0.029094] SRAT: PXM 2 -> APIC 0x97 -> Node 2
> [    0.029095] SRAT: PXM 2 -> APIC 0xa1 -> Node 2
> [    0.029095] SRAT: PXM 2 -> APIC 0xa3 -> Node 2
> [    0.029096] SRAT: PXM 2 -> APIC 0xa5 -> Node 2
> [    0.029097] SRAT: PXM 2 -> APIC 0xa7 -> Node 2
> [    0.029097] SRAT: PXM 2 -> APIC 0xa9 -> Node 2
> [    0.029098] SRAT: PXM 2 -> APIC 0xb1 -> Node 2
> [    0.029099] SRAT: PXM 2 -> APIC 0xb3 -> Node 2
> [    0.029100] SRAT: PXM 2 -> APIC 0xb5 -> Node 2
> [    0.029100] SRAT: PXM 2 -> APIC 0xb7 -> Node 2
> [    0.029101] SRAT: PXM 3 -> APIC 0xc1 -> Node 3
> [    0.029102] SRAT: PXM 3 -> APIC 0xc3 -> Node 3
> [    0.029103] SRAT: PXM 3 -> APIC 0xc5 -> Node 3
> [    0.029103] SRAT: PXM 3 -> APIC 0xc7 -> Node 3
> [    0.029104] SRAT: PXM 3 -> APIC 0xc9 -> Node 3
> [    0.029105] SRAT: PXM 3 -> APIC 0xd1 -> Node 3
> [    0.029106] SRAT: PXM 3 -> APIC 0xd3 -> Node 3
> [    0.029106] SRAT: PXM 3 -> APIC 0xd5 -> Node 3
> [    0.029107] SRAT: PXM 3 -> APIC 0xd7 -> Node 3
> [    0.029108] SRAT: PXM 3 -> APIC 0xe1 -> Node 3
> [    0.029109] SRAT: PXM 3 -> APIC 0xe3 -> Node 3
> [    0.029109] SRAT: PXM 3 -> APIC 0xe5 -> Node 3
> [    0.029110] SRAT: PXM 3 -> APIC 0xe7 -> Node 3
> [    0.029111] SRAT: PXM 3 -> APIC 0xe9 -> Node 3
> [    0.029112] SRAT: PXM 3 -> APIC 0xf1 -> Node 3
> [    0.029112] SRAT: PXM 3 -> APIC 0xf3 -> Node 3
> [    0.029113] SRAT: PXM 3 -> APIC 0xf5 -> Node 3
> [    0.029114] SRAT: PXM 3 -> APIC 0xf7 -> Node 3
> [    0.029167] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
> [    0.029168] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x186fffffff]
> [    0.029169] ACPI: SRAT: Node 1 PXM 1 [mem 0x1870000000-0x306fffffff]
> [    0.029170] ACPI: SRAT: Node 2 PXM 2 [mem 0x3070000000-0x406fffffff]
> [    0.029171] ACPI: SRAT: Node 3 PXM 3 [mem 0x4070000000-0x506fffffff]
> [    0.029184] NUMA: Initialized distance table, cnt=4
> [    0.029187] NUMA: Node 0 [mem 0x00000000-0x7fffffff] + [mem 0x100000000-0x186fffffff] -> [mem 0x00000000-0x186fffffff]
> [    0.029193] NODE_DATA(0) allocated [mem 0x186fffb000-0x186fffffff]
> [    0.029198] NODE_DATA(1) allocated [mem 0x306fffb000-0x306fffffff]
> [    0.029205] NODE_DATA(2) allocated [mem 0x406fffb000-0x406fffffff]
> [    0.029213] NODE_DATA(3) allocated [mem 0x506fffa000-0x506fffefff]
> [    0.029230] Reserving 768MB of memory at 192MB for crashkernel (System RAM: 327103MB)
> [    0.029595] Zone ranges:
> [    0.029596]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.029597]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.029598]   Normal   [mem 0x0000000100000000-0x000000506fffffff]
> [    0.029599]   Device   empty
> [    0.029600] Movable zone start for each node
> [    0.029601] Early memory node ranges
> [    0.029602]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
> [    0.029604]   node   0: [mem 0x0000000000100000-0x0000000065e0efff]
> [    0.029605]   node   0: [mem 0x00000000695fe000-0x000000006f7fffff]
> [    0.029606]   node   0: [mem 0x0000000100000000-0x000000186fffffff]
> [    0.029614]   node   1: [mem 0x0000001870000000-0x000000306fffffff]
> [    0.029623]   node   2: [mem 0x0000003070000000-0x000000406fffffff]
> [    0.029629]   node   3: [mem 0x0000004070000000-0x000000506fffffff]
> [    0.029819] Zeroed struct page in unavailable ranges: 16466 pages
> [    0.029820] Initmem setup node 0 [mem 0x0000000000001000-0x000000186fffffff]
> [    0.029822] On node 0 totalpages: 25018286
> [    0.029823]   DMA zone: 64 pages used for memmap
> [    0.029824]   DMA zone: 157 pages reserved
> [    0.029825]   DMA zone: 3997 pages, LIFO batch:0
> [    0.029895]   DMA32 zone: 6849 pages used for memmap
> [    0.029896]   DMA32 zone: 438289 pages, LIFO batch:63
> [    0.037451]   Normal zone: 384000 pages used for memmap
> [    0.037452]   Normal zone: 24576000 pages, LIFO batch:63
> [    0.437523] Initmem setup node 1 [mem 0x0000001870000000-0x000000306fffffff]
> [    0.437525] On node 1 totalpages: 25165824
> [    0.437526]   Normal zone: 393216 pages used for memmap
> [    0.437526]   Normal zone: 25165824 pages, LIFO batch:63
> [    0.886342] Initmem setup node 2 [mem 0x0000003070000000-0x000000406fffffff]
> [    0.886344] On node 2 totalpages: 16777216
> [    0.886344]   Normal zone: 262144 pages used for memmap
> [    0.886345]   Normal zone: 16777216 pages, LIFO batch:63
> [    1.187252] Initmem setup node 3 [mem 0x0000004070000000-0x000000506fffffff]
> [    1.187253] On node 3 totalpages: 16777216
> [    1.187254]   Normal zone: 262144 pages used for memmap
> [    1.187254]   Normal zone: 16777216 pages, LIFO batch:63
> [    1.485872] ACPI: PM-Timer IO Port: 0x508
> [    1.485874] ACPI: Local APIC address 0xfee00000
> [    1.485897] ACPI: X2APIC_NMI (uid[0xffffffff] high edge lint[0x1])
> [    1.485900] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
> [    1.485922] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
> [    1.485926] IOAPIC[1]: apic_id 9, version 32, address 0xfec01000, GSI 24-31
> [    1.485931] IOAPIC[2]: apic_id 10, version 32, address 0xfec08000, GSI 32-39
> [    1.485935] IOAPIC[3]: apic_id 11, version 32, address 0xfec10000, GSI 40-47
> [    1.485939] IOAPIC[4]: apic_id 12, version 32, address 0xfec18000, GSI 48-55
> [    1.485944] IOAPIC[5]: apic_id 13, version 32, address 0xfec20000, GSI 56-63
> [    1.485948] IOAPIC[6]: apic_id 14, version 32, address 0xfec28000, GSI 64-71
> [    1.485953] IOAPIC[7]: apic_id 15, version 32, address 0xfec30000, GSI 72-79
> [    1.485957] IOAPIC[8]: apic_id 16, version 32, address 0xfec38000, GSI 80-87
> [    1.485962] IOAPIC[9]: apic_id 17, version 32, address 0xfec40000, GSI 88-95
> [    1.485967] IOAPIC[10]: apic_id 18, version 32, address 0xfec48000, GSI 96-103
> [    1.485972] IOAPIC[11]: apic_id 19, version 32, address 0xfec50000, GSI 104-111
> [    1.485976] IOAPIC[12]: apic_id 20, version 32, address 0xfec58000, GSI 112-119
> [    1.485981] IOAPIC[13]: apic_id 21, version 32, address 0xfec60000, GSI 120-127
> [    1.485986] IOAPIC[14]: apic_id 22, version 32, address 0xfec68000, GSI 128-135
> [    1.485991] IOAPIC[15]: apic_id 23, version 32, address 0xfec70000, GSI 136-143
> [    1.485995] IOAPIC[16]: apic_id 24, version 32, address 0xfec78000, GSI 144-151
> [    1.485998] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    1.486000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    1.486002] ACPI: IRQ0 used by override.
> [    1.486003] ACPI: IRQ9 used by override.
> [    1.486006] Using ACPI (MADT) for SMP configuration information
> [    1.486007] ACPI: HPET id: 0x8086a701 base: 0xfed00000
> [    1.486011] ACPI: SPCR: console: uart,io,0x3f8,115200
> [    1.486012] TSC deadline timer available
> [    1.486013] smpboot: Allowing 144 CPUs, 0 hotplug CPUs
> [    1.486040] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    1.486042] PM: hibernation: Registered nosave memory: [mem 0x0009e000-0x0009efff]
> [    1.486043] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
> [    1.486044] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
> [    1.486046] PM: hibernation: Registered nosave memory: [mem 0x5c81a000-0x5c81afff]
> [    1.486048] PM: hibernation: Registered nosave memory: [mem 0x5c84e000-0x5c84efff]
> [    1.486049] PM: hibernation: Registered nosave memory: [mem 0x5c84f000-0x5c84ffff]
> [    1.486051] PM: hibernation: Registered nosave memory: [mem 0x5c883000-0x5c883fff]
> [    1.486053] PM: hibernation: Registered nosave memory: [mem 0x65e0f000-0x6764efff]
> [    1.486054] PM: hibernation: Registered nosave memory: [mem 0x6764f000-0x68ca7fff]
> [    1.486054] PM: hibernation: Registered nosave memory: [mem 0x68ca8000-0x695fdfff]
> [    1.486056] PM: hibernation: Registered nosave memory: [mem 0x6f800000-0x8fffffff]
> [    1.486057] PM: hibernation: Registered nosave memory: [mem 0x90000000-0xfdffffff]
> [    1.486058] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
> [    1.486059] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xffffffff]
> [    1.486061] [mem 0x90000000-0xfdffffff] available for PCI devices
> [    1.486062] Booting paravirtualized kernel on bare hardware
> [    1.486065] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
> [    1.491035] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:144 nr_node_ids:4
> [    1.507188] percpu: Embedded 56 pages/cpu s188440 r8192 d32744 u262144
> [    1.507206] pcpu-alloc: s188440 r8192 d32744 u262144 alloc=1*2097152
> [    1.507207] pcpu-alloc: [0] 000 001 002 003 004 005 006 007 
> [    1.507209] pcpu-alloc: [0] 008 009 010 011 012 013 014 015 
> [    1.507211] pcpu-alloc: [0] 016 017 072 073 074 075 076 077 
> [    1.507213] pcpu-alloc: [0] 078 079 080 081 082 083 084 085 
> [    1.507215] pcpu-alloc: [0] 086 087 088 089 --- --- --- --- 
> [    1.507217] pcpu-alloc: [1] 018 019 020 021 022 023 024 025 
> [    1.507219] pcpu-alloc: [1] 026 027 028 029 030 031 032 033 
> [    1.507221] pcpu-alloc: [1] 034 035 090 091 092 093 094 095 
> [    1.507222] pcpu-alloc: [1] 096 097 098 099 100 101 102 103 
> [    1.507224] pcpu-alloc: [1] 104 105 106 107 --- --- --- --- 
> [    1.507226] pcpu-alloc: [2] 036 037 038 039 040 041 042 043 
> [    1.507228] pcpu-alloc: [2] 044 045 046 047 048 049 050 051 
> [    1.507230] pcpu-alloc: [2] 052 053 108 109 110 111 112 113 
> [    1.507232] pcpu-alloc: [2] 114 115 116 117 118 119 120 121 
> [    1.507233] pcpu-alloc: [2] 122 123 124 125 --- --- --- --- 
> [    1.507235] pcpu-alloc: [3] 054 055 056 057 058 059 060 061 
> [    1.507237] pcpu-alloc: [3] 062 063 064 065 066 067 068 069 
> [    1.507239] pcpu-alloc: [3] 070 071 126 127 128 129 130 131 
> [    1.507241] pcpu-alloc: [3] 132 133 134 135 136 137 138 139 
> [    1.507242] pcpu-alloc: [3] 140 141 142 143 --- --- --- --- 
> [    1.507310] Built 4 zonelists, mobility grouping on.  Total pages: 82429968
> [    1.507311] Policy zone: Normal
> [    1.507313] Kernel command line: BOOT_IMAGE=/vmlinuz-5.7.6+ root=/dev/mapper/ubuntu--vg-ubuntu--lv ro console=tty0 console=ttyS0,115200n8 softlockup_panic=1 crashkernel=512M-:768M
> [    1.507452] printk: log_buf_len individual max cpu contribution: 4096 bytes
> [    1.507453] printk: log_buf_len total cpu_extra contributions: 585728 bytes
> [    1.507453] printk: log_buf_len min size: 262144 bytes
> [    1.507789] printk: log_buf_len: 1048576 bytes
> [    1.507790] printk: early log buf free: 224012(85%)
> [    1.510295] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    2.362842] Memory: 328546464K/334954168K available (12291K kernel code, 1669K rwdata, 8216K rodata, 1780K init, 2752K bss, 6407704K reserved, 0K cma-reserved)
> [    2.364642] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=144, Nodes=4
> [    2.364729] ftrace: allocating 42557 entries in 167 pages
> [    2.384214] ftrace: allocated 167 pages with 5 groups
> [    2.384329] 
> [    2.384330] **********************************************************
> [    2.384330] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
> [    2.384331] **                                                      **
> [    2.384331] ** trace_printk() being used. Allocating extra memory.  **
> [    2.384332] **                                                      **
> [    2.384333] ** This means that this is a DEBUG kernel and it is     **
> [    2.384333] ** unsafe for production use.                           **
> [    2.384334] **                                                      **
> [    2.384335] ** If you see this message and you are not debugging    **
> [    2.384335] ** the kernel, report this immediately to your vendor!  **
> [    2.384336] **                                                      **
> [    2.384336] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
> [    2.384337] **********************************************************
> [    2.385516] rcu: Hierarchical RCU implementation.
> [    2.385518] rcu: 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=144.
> [    2.385520] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> [    2.385521] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=144
> [    2.389286] NR_IRQS: 33024, nr_irqs: 3752, preallocated irqs: 16
> [    2.390192] random: get_random_bytes called from start_kernel+0x371/0x558 with crng_init=0
> [    2.390433] Console: colour dummy device 80x25
> [    2.391152] printk: console [tty0] enabled
> [    5.520858] printk: console [ttyS0] enabled
> [    5.525370] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
> [    5.536556] ACPI: Core revision 20200326
> [    5.546943] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
> [    5.556022] APIC: Switch to symmetric I/O mode setup
> [    5.561290] x2apic: IRQ remapping doesn't support X2APIC mode
> [    5.567225] Switched APIC routing to physical flat.
> [    5.573427] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    5.595930] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x240939f1bb2, max_idle_ns: 440795263295 ns
> [    5.606425] Calibrating delay loop (skipped), value calculated using timer frequency.. 5000.00 BogoMIPS (lpj=10000000)
> [    5.610424] pid_max: default: 147456 minimum: 1152
> [    5.624339] LSM: Security Framework initializing
> [    5.626431] Yama: becoming mindful.
> [    5.630494] AppArmor: AppArmor initialized
> [    5.634425] TOMOYO Linux initialized
> [    5.664730] Dentry cache hash table entries: 16777216 (order: 15, 134217728 bytes, vmalloc)
> [    5.680915] Inode-cache hash table entries: 8388608 (order: 14, 67108864 bytes, vmalloc)
> [    5.682900] Mount-cache hash table entries: 262144 (order: 9, 2097152 bytes, vmalloc)
> [    5.686785] Mountpoint-cache hash table entries: 262144 (order: 9, 2097152 bytes, vmalloc)
> [    5.695446] mce: CPU0: Thermal monitoring enabled (TM1)
> [    5.698484] process: using mwait in idle threads
> [    5.702426] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
> [    5.706423] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
> [    5.710429] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [    5.714424] Spectre V2 : Mitigation: Enhanced IBRS
> [    5.718423] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [    5.722425] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> [    5.726425] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
> [    5.730905] Freeing SMP alternatives memory: 40K
> [    5.740732] smpboot: CPU0: Genuine Intel(R) CPU 0000%@ (family: 0x6, model: 0x55, stepping: 0xb)
> [    5.742751] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
> [    5.746427] ... version:                4
> [    5.750424] ... bit width:              48
> [    5.754423] ... generic registers:      4
> [    5.758424] ... value mask:             0000ffffffffffff
> [    5.762424] ... max period:             00007fffffffffff
> [    5.766423] ... fixed-purpose events:   3
> [    5.770424] ... event mask:             000000070000000f
> [    5.774621] core: 0 -> 0
> [    5.777154] rcu: Hierarchical SRCU implementation.
> [    5.793265] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    5.796304] smp: Bringing up secondary CPUs ...
> [    5.798631] x86: Booting SMP configuration:
> [    5.802425] .... node  #0, CPUs:          #1
> [    3.180284] core: 1 -> 1
> [    5.811825]    #2
> [    3.180284] core: 2 -> 2
> [    5.819129]    #3
> [    3.180284] core: 3 -> 3
> [    5.826649]    #4
> [    3.180284] core: 4 -> 4
> [    5.833874]    #5
> [    3.180284] core: 5 -> 5
> [    5.841260]    #6
> [    3.180284] core: 6 -> 6
> [    5.848513]    #7
> [    3.180284] core: 7 -> 7
> [    5.855778]    #8
> [    3.180284] core: 8 -> 8
> [    5.863078]    #9
> [    3.180284] core: 9 -> 9
> [    5.870650]   #10
> [    3.180284] core: 10 -> 10
> [    5.877912]   #11
> [    3.180284] core: 11 -> 11
> [    5.885305]   #12
> [    3.180284] core: 12 -> 12
> [    5.892804]   #13
> [    3.180284] core: 13 -> 13
> [    5.900433]   #14
> [    3.180284] core: 14 -> 14
> [    5.907905]   #15
> [    3.180284] core: 15 -> 15
> [    5.915299]   #16
> [    3.180284] core: 16 -> 16
> [    5.922814]   #17
> [    3.180284] core: 17 -> 17
> [    5.930718] .... node  #1, CPUs:    #18
> [    3.180284] smpboot: CPU 18 Converting physical 0 to logical die 1
> [    3.180284] core: 18 -> 18
> [    6.026679]   #19
> [    3.180284] core: 19 -> 19
> [    6.034470]   #20
> [    3.180284] core: 20 -> 20
> [    6.041621]   #21
> [    3.180284] core: 21 -> 21
> [    6.049191]   #22
> [    3.180284] core: 22 -> 22
> [    6.056874]   #23
> [    3.180284] core: 23 -> 23
> [    6.064488]   #24
> [    3.180284] core: 24 -> 24
> [    6.071963]   #25
> [    3.180284] core: 25 -> 25
> [    6.079457]   #26
> [    3.180284] core: 26 -> 26
> [    6.087035]   #27
> [    3.180284] core: 27 -> 27
> [    6.094683]   #28
> [    3.180284] core: 28 -> 28
> [    6.102664]   #29
> [    3.180284] core: 29 -> 29
> [    6.109793]   #30
> [    3.180284] core: 30 -> 30
> [    6.117405]   #31
> [    3.180284] core: 31 -> 31
> [    6.125147]   #32
> [    3.180284] core: 32 -> 32
> [    6.132735]   #33
> [    3.180284] core: 33 -> 33
> [    6.140281]   #34
> [    3.180284] core: 34 -> 34
> [    6.147827]   #35
> [    3.180284] core: 35 -> 35
> [    6.155499] .... node  #2, CPUs:    #36
> [    3.180284] smpboot: CPU 36 Converting physical 0 to logical die 2
> [    3.180284] core: 36 -> 36
> [    6.250677]   #37
> [    3.180284] core: 37 -> 37
> [    6.258524]   #38
> [    3.180284] core: 38 -> 38
> [    6.265713]   #39
> [    3.180284] core: 39 -> 39
> [    6.273291]   #40
> [    3.180284] core: 40 -> 40
> [    6.280915]   #41
> [    3.180284] core: 41 -> 41
> [    6.288556]   #42
> [    3.180284] core: 42 -> 42
> [    6.296104]   #43
> [    3.180284] core: 43 -> 43
> [    6.303635]   #44
> [    3.180284] core: 44 -> 44
> [    6.311240]   #45
> [    3.180284] core: 45 -> 45
> [    6.318939]   #46
> [    3.180284] core: 46 -> 46
> [    6.326672]   #47
> [    3.180284] core: 47 -> 47
> [    6.334513]   #48
> [    3.180284] core: 48 -> 48
> [    6.341710]   #49
> [    3.180284] core: 49 -> 49
> [    6.349393]   #50
> [    3.180284] core: 50 -> 50
> [    6.357069]   #51
> [    3.180284] core: 51 -> 51
> [    6.364647]   #52
> [    3.180284] core: 52 -> 52
> [    6.372279]   #53
> [    3.180284] core: 53 -> 53
> [    6.379986] .... node  #3, CPUs:    #54
> [    3.180284] smpboot: CPU 54 Converting physical 0 to logical die 3
> [    3.180284] core: 54 -> 54
> [    6.474698]   #55
> [    3.180284] core: 55 -> 55
> [    6.482665]   #56
> [    3.180284] core: 56 -> 56
> [    6.489900]   #57
> [    3.180284] core: 57 -> 57
> [    6.497557]   #58
> [    3.180284] core: 58 -> 58
> [    6.505282]   #59
> [    3.180284] core: 59 -> 59
> [    6.513000]   #60
> [    3.180284] core: 60 -> 60
> [    6.520607]   #61
> [    3.180284] core: 61 -> 61
> [    6.528202]   #62
> [    3.180284] core: 62 -> 62
> [    6.535894]   #63
> [    3.180284] core: 63 -> 63
> [    6.543752]   #64
> [    3.180284] core: 64 -> 64
> [    6.551475]   #65
> [    3.180284] core: 65 -> 65
> [    6.559134]   #66
> [    3.180284] core: 66 -> 66
> [    6.566790]   #67
> [    3.180284] core: 67 -> 67
> [    6.574673]   #68
> [    3.180284] core: 68 -> 68
> [    6.582690]   #69
> [    3.180284] core: 69 -> 69
> [    6.589978]   #70
> [    3.180284] core: 70 -> 70
> [    6.597673]   #71
> [    3.180284] core: 71 -> 71
> [    6.605486] .... node  #0, CPUs:    #72
> [    3.180284] core: 72 -> 0
> [    6.613660]   #73
> [    3.180284] core: 73 -> 1
> [    6.621322]   #74
> [    3.180284] core: 74 -> 2
> [    6.628771]   #75
> [    3.180284] core: 75 -> 3
> [    6.636258]   #76
> [    3.180284] core: 76 -> 4
> [    6.643814]   #77
> [    3.180284] core: 77 -> 5
> [    6.651394]   #78
> [    3.180284] core: 78 -> 6
> [    6.658850]   #79
> [    3.180284] core: 79 -> 7
> [    6.666659]   #80
> [    3.180284] core: 80 -> 8
> [    6.673780]   #81
> [    3.180284] core: 81 -> 9
> [    6.681287]   #82
> [    3.180284] core: 82 -> 10
> [    6.688870]   #83
> [    3.180284] core: 83 -> 11
> [    6.696357]   #84
> [    3.180284] core: 84 -> 12
> [    6.704053]   #85
> [    3.180284] core: 85 -> 13
> [    6.711881]   #86
> [    3.180284] core: 86 -> 14
> [    6.719458]   #87
> [    3.180284] core: 87 -> 15
> [    6.726971]   #88
> [    3.180284] core: 88 -> 16
> [    6.734662]   #89
> [    3.180284] core: 89 -> 17
> [    6.742727] .... node  #1, CPUs:    #90
> [    3.180284] core: 90 -> 18
> [    6.751856]   #91
> [    3.180284] core: 91 -> 19
> [    6.759556]   #92
> [    3.180284] core: 92 -> 20
> [    6.767150]   #93
> [    3.180284] core: 93 -> 21
> [    6.774786]   #94
> [    3.180284] core: 94 -> 22
> [    6.782696]   #95
> [    3.180284] core: 95 -> 23
> [    6.790660]   #96
> [    3.180284] core: 96 -> 24
> [    6.797792]   #97
> [    3.180284] core: 97 -> 25
> [    6.805373]   #98
> [    3.180284] core: 98 -> 26
> [    6.813082]   #99
> [    3.180284] core: 99 -> 27
> [    6.820835]  #100
> [    3.180284] core: 100 -> 28
> [    6.828563]  #101
> [    3.180284] core: 101 -> 29
> [    6.836315]  #102
> [    3.180284] core: 102 -> 30
> [    6.844093]  #103
> [    3.180284] core: 103 -> 31
> [    6.852007]  #104
> [    3.180284] core: 104 -> 32
> [    6.859778]  #105
> [    3.180284] core: 105 -> 33
> [    6.867486]  #106
> [    3.180284] core: 106 -> 34
> [    6.875230]  #107
> [    3.180284] core: 107 -> 35
> [    6.883085] .... node  #2, CPUs:   #108
> [    3.180284] core: 108 -> 36
> [    6.892931]  #109
> [    3.180284] core: 109 -> 37
> [    6.900752]  #110
> [    3.180284] core: 110 -> 38
> [    6.908510]  #111
> [    3.180284] core: 111 -> 39
> [    6.916281]  #112
> [    3.180284] core: 112 -> 40
> [    6.924094]  #113
> [    3.180284] core: 113 -> 41
> [    6.931914]  #114
> [    3.180284] core: 114 -> 42
> [    6.939622]  #115
> [    3.180284] core: 115 -> 43
> [    6.947351]  #116
> [    3.180284] core: 116 -> 44
> [    6.955130]  #117
> [    3.180284] core: 117 -> 45
> [    6.962991]  #118
> [    3.180284] core: 118 -> 46
> [    6.970725]  #119
> [    3.180284] core: 119 -> 47
> [    6.978680]  #120
> [    3.180284] core: 120 -> 48
> [    6.986676]  #121
> [    3.180284] core: 121 -> 49
> [    6.994641]  #122
> [    3.180284] core: 122 -> 50
> [    7.002541]  #123
> [    3.180284] core: 123 -> 51
> [    7.009793]  #124
> [    3.180284] core: 124 -> 52
> [    7.017584]  #125
> [    3.180284] core: 125 -> 53
> [    7.025473] .... node  #3, CPUs:   #126
> [    3.180284] core: 126 -> 54
> [    7.035294]  #127
> [    3.180284] core: 127 -> 55
> [    7.043254]  #128
> [    3.180284] core: 128 -> 56
> [    7.051111]  #129
> [    3.180284] core: 129 -> 57
> [    7.058952]  #130
> [    3.180284] core: 130 -> 58
> [    7.066914]  #131
> [    3.180284] core: 131 -> 59
> [    7.074839]  #132
> [    3.180284] core: 132 -> 60
> [    7.082708]  #133
> [    3.180284] core: 133 -> 61
> [    7.090720]  #134
> [    3.180284] core: 134 -> 62
> [    7.098679]  #135
> [    3.180284] core: 135 -> 63
> [    7.106669]  #136
> [    3.180284] core: 136 -> 64
> [    7.114697]  #137
> [    3.180284] core: 137 -> 65
> [    7.122632]  #138
> [    3.180284] core: 138 -> 66
> [    7.130491]  #139
> [    3.180284] core: 139 -> 67
> [    7.138475]  #140
> [    3.180284] core: 140 -> 68
> [    7.145811]  #141
> [    3.180284] core: 141 -> 69
> [    7.153662]  #142
> [    3.180284] core: 142 -> 70
> [    7.161531]  #143
> [    3.180284] core: 143 -> 71
> [    7.169477] smp: Brought up 4 nodes, 144 CPUs
> [    7.170425] smpboot: Max logical packages: 4
> [    7.174428] smpboot: Total of 144 processors activated (720297.64 BogoMIPS)
> [    7.205286] devtmpfs: initialized
> [    7.206478] x86/mm: Memory block size: 256MB
> [    7.263082] PM: Registering ACPI NVS region [mem 0x0009f000-0x0009ffff] (4096 bytes)
> [    7.266425] PM: Registering ACPI NVS region [mem 0x6764f000-0x68ca7fff] (23433216 bytes)
> [    7.271171] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> [    7.274548] futex hash table entries: 65536 (order: 10, 4194304 bytes, vmalloc)
> [    7.280264] pinctrl core: initialized pinctrl subsystem
> [    7.282603] PM: RTC time: 01:14:52, date: 2020-07-13
> [    7.286426] thermal_sys: Registered thermal governor 'fair_share'
> [    7.286427] thermal_sys: Registered thermal governor 'bang_bang'
> [    7.290424] thermal_sys: Registered thermal governor 'step_wise'
> [    7.294424] thermal_sys: Registered thermal governor 'user_space'
> [    7.298952] NET: Registered protocol family 16
> [    7.306519] audit: initializing netlink subsys (disabled)
> [    7.310453] audit: type=2000 audit(1594602887.744:1): state=initialized audit_enabled=0 res=1
> [    7.318428] cpuidle: using governor ladder
> [    7.322458] cpuidle: using governor menu
> [    7.326558] ACPI: bus type PCI registered
> [    7.330427] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    7.334676] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> [    7.346506] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
> [    7.350447] pmd_set_huge: Cannot satisfy [mem 0x80000000-0x80200000] with a huge-page mapping due to MTRR override.
> [    7.362838] PCI: Using configuration type 1 for base access
> [    7.418430] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> [    7.426888] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> [    7.430426] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    7.443003] ACPI: Added _OSI(Module Device)
> [    7.446425] ACPI: Added _OSI(Processor Device)
> [    7.450424] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    7.454424] ACPI: Added _OSI(Processor Aggregator Device)
> [    7.462424] ACPI: Added _OSI(Linux-Dell-Video)
> [    7.466424] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [    7.470424] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> [    7.733400] ACPI: 8 ACPI AML tables successfully acquired and loaded
> [    7.802010] ACPI: Dynamic OEM Table Load:
> [    8.057172] ACPI: Dynamic OEM Table Load:
> [    8.105768] ACPI: Dynamic OEM Table Load:
> [    8.632513] ACPI: Interpreter enabled
> [    8.638445] ACPI: (supports S0 S3 S4 S5)
> [    8.642365] ACPI: Using IOAPIC for interrupt routing
> [    8.646524] HEST: Table parsing has been initialized.
> [    8.650426] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    8.696839] ACPI: Enabled 6 GPEs in block 00 to 7F
> [    8.885041] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-14])
> [    8.890428] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [    8.902460] acpi PNP0A08:00: PCIe AER handled by firmware
> [    8.906456] acpi PNP0A08:00: _OSC: platform does not support [LTR]
> [    8.910480] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> [    8.919970] PCI host bridge to bus 0000:00
> [    8.926425] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    8.930424] pci_bus 0000:00: root bus resource [io  0x1000-0x4fff window]
> [    8.938424] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    8.946424] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
> [    8.954424] pci_bus 0000:00: root bus resource [mem 0xfe010000-0xfe010fff window]
> [    8.962425] pci_bus 0000:00: root bus resource [mem 0x90000000-0x96bfffff window]
> [    8.970424] pci_bus 0000:00: root bus resource [mem 0x200000000000-0x200fffffffff window]
> [    8.978424] pci_bus 0000:00: root bus resource [bus 00-14]
> [    8.982434] pci 0000:00:00.0: [8086:2020] type 00 class 0x060000
> [    8.991125] pci 0000:00:04.0: [8086:2021] type 00 class 0x088000
> [    8.994435] pci 0000:00:04.0: reg 0x10: [mem 0x200ffff2c000-0x200ffff2ffff 64bit]
> [    9.003060] pci 0000:00:04.1: [8086:2021] type 00 class 0x088000
> [    9.010434] pci 0000:00:04.1: reg 0x10: [mem 0x200ffff28000-0x200ffff2bfff 64bit]
> [    9.019058] pci 0000:00:04.2: [8086:2021] type 00 class 0x088000
> [    9.022434] pci 0000:00:04.2: reg 0x10: [mem 0x200ffff24000-0x200ffff27fff 64bit]
> [    9.031055] pci 0000:00:04.3: [8086:2021] type 00 class 0x088000
> [    9.038434] pci 0000:00:04.3: reg 0x10: [mem 0x200ffff20000-0x200ffff23fff 64bit]
> [    9.047057] pci 0000:00:04.4: [8086:2021] type 00 class 0x088000
> [    9.050433] pci 0000:00:04.4: reg 0x10: [mem 0x200ffff1c000-0x200ffff1ffff 64bit]
> [    9.059054] pci 0000:00:04.5: [8086:2021] type 00 class 0x088000
> [    9.066434] pci 0000:00:04.5: reg 0x10: [mem 0x200ffff18000-0x200ffff1bfff 64bit]
> [    9.075053] pci 0000:00:04.6: [8086:2021] type 00 class 0x088000
> [    9.078433] pci 0000:00:04.6: reg 0x10: [mem 0x200ffff14000-0x200ffff17fff 64bit]
> [    9.087053] pci 0000:00:04.7: [8086:2021] type 00 class 0x088000
> [    9.094435] pci 0000:00:04.7: reg 0x10: [mem 0x200ffff10000-0x200ffff13fff 64bit]
> [    9.103057] pci 0000:00:05.0: [8086:2024] type 00 class 0x088000
> [    9.107053] pci 0000:00:05.2: [8086:2025] type 00 class 0x088000
> [    9.115047] pci 0000:00:05.4: [8086:2026] type 00 class 0x080020
> [    9.122434] pci 0000:00:05.4: reg 0x10: [mem 0x9230b000-0x9230bfff]
> [    9.127048] pci 0000:00:08.0: [8086:2014] type 00 class 0x088000
> [    9.135044] pci 0000:00:08.1: [8086:2015] type 00 class 0x110100
> [    9.143023] pci 0000:00:08.2: [8086:2016] type 00 class 0x088000
> [    9.147048] pci 0000:00:11.0: [8086:a1ec] type 00 class 0xff0000
> [    9.155067] pci 0000:00:11.1: [8086:a1ed] type 00 class 0xff0000
> [    9.163068] pci 0000:00:11.5: [8086:a1d2] type 00 class 0x010601
> [    9.166441] pci 0000:00:11.5: reg 0x10: [mem 0x92306000-0x92307fff]
> [    9.174430] pci 0000:00:11.5: reg 0x14: [mem 0x9230a000-0x9230a0ff]
> [    9.178430] pci 0000:00:11.5: reg 0x18: [io  0x4068-0x406f]
> [    9.186430] pci 0000:00:11.5: reg 0x1c: [io  0x4074-0x4077]
> [    9.190430] pci 0000:00:11.5: reg 0x20: [io  0x4040-0x405f]
> [    9.194430] pci 0000:00:11.5: reg 0x24: [mem 0x92280000-0x922fffff]
> [    9.202462] pci 0000:00:11.5: PME# supported from D3hot
> [    9.207075] pci 0000:00:14.0: [8086:a1af] type 00 class 0x0c0330
> [    9.214445] pci 0000:00:14.0: reg 0x10: [mem 0x200ffff00000-0x200ffff0ffff 64bit]
> [    9.222488] pci 0000:00:14.0: PME# supported from D3hot D3cold
> [    9.227060] pci 0000:00:14.2: [8086:a1b1] type 00 class 0x118000
> [    9.234444] pci 0000:00:14.2: reg 0x10: [mem 0x200ffff34000-0x200ffff34fff 64bit]
> [    9.243100] pci 0000:00:16.0: [8086:a1ba] type 00 class 0x078000
> [    9.250456] pci 0000:00:16.0: reg 0x10: [mem 0x200ffff33000-0x200ffff33fff 64bit]
> [    9.254508] pci 0000:00:16.0: PME# supported from D3hot
> [    9.263037] pci 0000:00:16.1: [8086:a1bb] type 00 class 0x078000
> [    9.266452] pci 0000:00:16.1: reg 0x10: [mem 0x200ffff32000-0x200ffff32fff 64bit]
> [    9.274508] pci 0000:00:16.1: PME# supported from D3hot
> [    9.283041] pci 0000:00:16.4: [8086:a1be] type 00 class 0x078000
> [    9.286451] pci 0000:00:16.4: reg 0x10: [mem 0x200ffff31000-0x200ffff31fff 64bit]
> [    9.294506] pci 0000:00:16.4: PME# supported from D3hot
> [    9.299040] pci 0000:00:17.0: [8086:a182] type 00 class 0x010601
> [    9.306441] pci 0000:00:17.0: reg 0x10: [mem 0x92304000-0x92305fff]
> [    9.314436] pci 0000:00:17.0: reg 0x14: [mem 0x92309000-0x923090ff]
> [    9.318430] pci 0000:00:17.0: reg 0x18: [io  0x4060-0x4067]
> [    9.326430] pci 0000:00:17.0: reg 0x1c: [io  0x4070-0x4073]
> [    9.330430] pci 0000:00:17.0: reg 0x20: [io  0x4020-0x403f]
> [    9.334430] pci 0000:00:17.0: reg 0x24: [mem 0x92200000-0x9227ffff]
> [    9.342487] pci 0000:00:17.0: PME# supported from D3hot
> [    9.347101] pci 0000:00:1c.0: [8086:a194] type 01 class 0x060400
> [    9.354503] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    9.359109] pci 0000:00:1c.5: [8086:a195] type 01 class 0x060400
> [    9.366500] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
> [    9.375097] pci 0000:00:1f.0: [8086:a1c6] type 00 class 0x060100
> [    9.379124] pci 0000:00:1f.2: [8086:a1a1] type 00 class 0x058000
> [    9.386437] pci 0000:00:1f.2: reg 0x10: [mem 0x92300000-0x92303fff]
> [    9.395086] pci 0000:00:1f.4: [8086:a1a3] type 00 class 0x0c0500
> [    9.398441] pci 0000:00:1f.4: reg 0x10: [mem 0x200ffff30000-0x200ffff300ff 64bit]
> [    9.406440] pci 0000:00:1f.4: reg 0x20: [io  0x4000-0x401f]
> [    9.411041] pci 0000:00:1f.5: [8086:a1a4] type 00 class 0x0c8000
> [    9.418440] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
> [    9.427146] pci 0000:01:00.0: [8086:1533] type 00 class 0x020000
> [    9.430463] pci 0000:01:00.0: reg 0x10: [mem 0x92100000-0x9217ffff]
> [    9.438450] pci 0000:01:00.0: reg 0x18: [io  0x3000-0x301f]
> [    9.442441] pci 0000:01:00.0: reg 0x1c: [mem 0x92180000-0x92183fff]
> [    9.450559] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> [    9.454571] pci 0000:00:1c.0: PCI bridge to [bus 01]
> [    9.462426] pci 0000:00:1c.0:   bridge window [io  0x3000-0x3fff]
> [    9.466426] pci 0000:00:1c.0:   bridge window [mem 0x92100000-0x921fffff]
> [    9.474487] pci 0000:02:00.0: [1a03:1150] type 01 class 0x060400
> [    9.478505] pci 0000:02:00.0: enabling Extended Tags
> [    9.486506] pci 0000:02:00.0: supports D1 D2
> [    9.490424] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    9.494540] pci 0000:00:1c.5: PCI bridge to [bus 02-03]
> [    9.502426] pci 0000:00:1c.5:   bridge window [io  0x2000-0x2fff]
> [    9.506425] pci 0000:00:1c.5:   bridge window [mem 0x91000000-0x920fffff]
> [    9.514477] pci_bus 0000:03: extended config space not accessible
> [    9.518451] pci 0000:03:00.0: [1a03:2000] type 00 class 0x030000
> [    9.526451] pci 0000:03:00.0: reg 0x10: [mem 0x91000000-0x91ffffff]
> [    9.534439] pci 0000:03:00.0: reg 0x14: [mem 0x92000000-0x9201ffff]
> [    9.538438] pci 0000:03:00.0: reg 0x18: [io  0x2000-0x207f]
> [    9.542492] pci 0000:03:00.0: BAR 0: assigned to efifb
> [    9.550478] pci 0000:03:00.0: supports D1 D2
> [    9.554424] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    9.562538] pci 0000:02:00.0: PCI bridge to [bus 03]
> [    9.566432] pci 0000:02:00.0:   bridge window [io  0x2000-0x2fff]
> [    9.570430] pci 0000:02:00.0:   bridge window [mem 0x91000000-0x920fffff]
> [    9.578451] pci_bus 0000:00: on NUMA node 0
> [    9.578969] ACPI: PCI Root Bridge [PC01] (domain 0000 [bus 15-22])
> [    9.586427] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [    9.594489] acpi PNP0A08:01: PCIe AER handled by firmware
> [    9.598845] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> [    9.606583] PCI host bridge to bus 0000:15
> [    9.610425] pci_bus 0000:15: root bus resource [io  0x5000-0x5fff window]
> [    9.618424] pci_bus 0000:15: root bus resource [mem 0x96c00000-0x9d7fffff window]
> [    9.626424] pci_bus 0000:15: root bus resource [mem 0x201000000000-0x201fffffffff window]
> [    9.634425] pci_bus 0000:15: root bus resource [bus 15-22]
> [    9.638433] pci 0000:15:05.0: [8086:2034] type 00 class 0x088000
> [    9.646515] pci 0000:15:05.2: [8086:2035] type 00 class 0x088000
> [    9.650505] pci 0000:15:05.4: [8086:2036] type 00 class 0x080020
> [    9.658432] pci 0000:15:05.4: reg 0x10: [mem 0x96c00000-0x96c00fff]
> [    9.662511] pci 0000:15:08.0: [8086:208d] type 00 class 0x088000
> [    9.670496] pci 0000:15:08.1: [8086:208d] type 00 class 0x088000
> [    9.678480] pci 0000:15:08.2: [8086:208d] type 00 class 0x088000
> [    9.682481] pci 0000:15:08.3: [8086:208d] type 00 class 0x088000
> [    9.690480] pci 0000:15:08.4: [8086:208d] type 00 class 0x088000
> [    9.694481] pci 0000:15:08.5: [8086:208d] type 00 class 0x088000
> [    9.702480] pci 0000:15:08.6: [8086:208d] type 00 class 0x088000
> [    9.706477] pci 0000:15:08.7: [8086:208d] type 00 class 0x088000
> [    9.714481] pci 0000:15:09.0: [8086:208d] type 00 class 0x088000
> [    9.718491] pci 0000:15:09.1: [8086:208d] type 00 class 0x088000
> [    9.726478] pci 0000:15:09.2: [8086:208d] type 00 class 0x088000
> [    9.730480] pci 0000:15:09.3: [8086:208d] type 00 class 0x088000
> [    9.738480] pci 0000:15:09.4: [8086:208d] type 00 class 0x088000
> [    9.742481] pci 0000:15:09.5: [8086:208d] type 00 class 0x088000
> [    9.750478] pci 0000:15:09.6: [8086:208d] type 00 class 0x088000
> [    9.754479] pci 0000:15:09.7: [8086:208d] type 00 class 0x088000
> [    9.762481] pci 0000:15:0a.0: [8086:208d] type 00 class 0x088000
> [    9.766488] pci 0000:15:0a.1: [8086:208d] type 00 class 0x088000
> [    9.774480] pci 0000:15:0a.2: [8086:208d] type 00 class 0x088000
> [    9.778480] pci 0000:15:0a.3: [8086:208d] type 00 class 0x088000
> [    9.786480] pci 0000:15:0a.4: [8086:208d] type 00 class 0x088000
> [    9.790482] pci 0000:15:0a.5: [8086:208d] type 00 class 0x088000
> [    9.798479] pci 0000:15:0a.6: [8086:208d] type 00 class 0x088000
> [    9.802479] pci 0000:15:0a.7: [8086:208d] type 00 class 0x088000
> [    9.810481] pci 0000:15:0b.0: [8086:208d] type 00 class 0x088000
> [    9.814488] pci 0000:15:0b.1: [8086:208d] type 00 class 0x088000
> [    9.822483] pci 0000:15:0b.2: [8086:208d] type 00 class 0x088000
> [    9.826479] pci 0000:15:0b.3: [8086:208d] type 00 class 0x088000
> [    9.834485] pci 0000:15:0e.0: [8086:208e] type 00 class 0x088000
> [    9.838490] pci 0000:15:0e.1: [8086:208e] type 00 class 0x088000
> [    9.846482] pci 0000:15:0e.2: [8086:208e] type 00 class 0x088000
> [    9.850481] pci 0000:15:0e.3: [8086:208e] type 00 class 0x088000
> [    9.858481] pci 0000:15:0e.4: [8086:208e] type 00 class 0x088000
> [    9.862478] pci 0000:15:0e.5: [8086:208e] type 00 class 0x088000
> [    9.870481] pci 0000:15:0e.6: [8086:208e] type 00 class 0x088000
> [    9.874478] pci 0000:15:0e.7: [8086:208e] type 00 class 0x088000
> [    9.882483] pci 0000:15:0f.0: [8086:208e] type 00 class 0x088000
> [    9.886495] pci 0000:15:0f.1: [8086:208e] type 00 class 0x088000
> [    9.894479] pci 0000:15:0f.2: [8086:208e] type 00 class 0x088000
> [    9.898480] pci 0000:15:0f.3: [8086:208e] type 00 class 0x088000
> [    9.906482] pci 0000:15:0f.4: [8086:208e] type 00 class 0x088000
> [    9.910480] pci 0000:15:0f.5: [8086:208e] type 00 class 0x088000
> [    9.918482] pci 0000:15:0f.6: [8086:208e] type 00 class 0x088000
> [    9.926480] pci 0000:15:0f.7: [8086:208e] type 00 class 0x088000
> [    9.930484] pci 0000:15:10.0: [8086:208e] type 00 class 0x088000
> [    9.938492] pci 0000:15:10.1: [8086:208e] type 00 class 0x088000
> [    9.942479] pci 0000:15:10.2: [8086:208e] type 00 class 0x088000
> [    9.950479] pci 0000:15:10.3: [8086:208e] type 00 class 0x088000
> [    9.954481] pci 0000:15:10.4: [8086:208e] type 00 class 0x088000
> [    9.962484] pci 0000:15:10.5: [8086:208e] type 00 class 0x088000
> [    9.966487] pci 0000:15:10.6: [8086:208e] type 00 class 0x088000
> [    9.974477] pci 0000:15:10.7: [8086:208e] type 00 class 0x088000
> [    9.978483] pci 0000:15:11.0: [8086:208e] type 00 class 0x088000
> [    9.986490] pci 0000:15:11.1: [8086:208e] type 00 class 0x088000
> [    9.990479] pci 0000:15:11.2: [8086:208e] type 00 class 0x088000
> [    9.998482] pci 0000:15:11.3: [8086:208e] type 00 class 0x088000
> [   10.002493] pci 0000:15:1d.0: [8086:2054] type 00 class 0x088000
> [   10.010492] pci 0000:15:1d.1: [8086:2055] type 00 class 0x088000
> [   10.014482] pci 0000:15:1d.2: [8086:2056] type 00 class 0x088000
> [   10.022479] pci 0000:15:1d.3: [8086:2057] type 00 class 0x088000
> [   10.026488] pci 0000:15:1e.0: [8086:2080] type 00 class 0x088000
> [   10.034492] pci 0000:15:1e.1: [8086:2081] type 00 class 0x088000
> [   10.038484] pci 0000:15:1e.2: [8086:2082] type 00 class 0x088000
> [   10.046482] pci 0000:15:1e.3: [8086:2083] type 00 class 0x088000
> [   10.050603] pci 0000:15:1e.4: [8086:2084] type 00 class 0x088000
> [   10.058478] pci 0000:15:1e.5: [8086:2085] type 00 class 0x088000
> [   10.062483] pci 0000:15:1e.6: [8086:2086] type 00 class 0x088000
> [   10.070483] pci_bus 0000:15: on NUMA node 0
> [   10.070637] ACPI: PCI Root Bridge [PC02] (domain 0000 [bus 23-30])
> [   10.074426] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   10.086489] acpi PNP0A08:02: PCIe AER handled by firmware
> [   10.090843] acpi PNP0A08:02: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> [   10.098539] PCI host bridge to bus 0000:23
> [   10.102425] pci_bus 0000:23: root bus resource [io  0x6000-0x6fff window]
> [   10.110424] pci_bus 0000:23: root bus resource [mem 0x9d800000-0xa43fffff window]
> [   10.118424] pci_bus 0000:23: root bus resource [mem 0x202000000000-0x202fffffffff window]
> [   10.126424] pci_bus 0000:23: root bus resource [bus 23-30]
> [   10.130433] pci 0000:23:05.0: [8086:2034] type 00 class 0x088000
> [   10.138507] pci 0000:23:05.2: [8086:2035] type 00 class 0x088000
> [   10.142498] pci 0000:23:05.4: [8086:2036] type 00 class 0x080020
> [   10.150432] pci 0000:23:05.4: reg 0x10: [mem 0x9d800000-0x9d800fff]
> [   10.154505] pci 0000:23:08.0: [8086:2066] type 00 class 0x088000
> [   10.162504] pci 0000:23:09.0: [8086:2066] type 00 class 0x088000
> [   10.166504] pci 0000:23:0a.0: [8086:2040] type 00 class 0x088000
> [   10.174513] pci 0000:23:0a.1: [8086:2041] type 00 class 0x088000
> [   10.178488] pci 0000:23:0a.2: [8086:2042] type 00 class 0x088000
> [   10.186498] pci 0000:23:0a.3: [8086:2043] type 00 class 0x088000
> [   10.190490] pci 0000:23:0a.4: [8086:2044] type 00 class 0x088000
> [   10.198486] pci 0000:23:0a.5: [8086:2045] type 00 class 0x088000
> [   10.202495] pci 0000:23:0a.6: [8086:2046] type 00 class 0x088000
> [   10.210489] pci 0000:23:0a.7: [8086:2047] type 00 class 0x088000
> [   10.214487] pci 0000:23:0b.0: [8086:2048] type 00 class 0x088000
> [   10.222499] pci 0000:23:0b.1: [8086:2049] type 00 class 0x088000
> [   10.226489] pci 0000:23:0b.2: [8086:204a] type 00 class 0x088000
> [   10.234487] pci 0000:23:0b.3: [8086:204b] type 00 class 0x088000
> [   10.238490] pci 0000:23:0c.0: [8086:2040] type 00 class 0x088000
> [   10.246500] pci 0000:23:0c.1: [8086:2041] type 00 class 0x088000
> [   10.250490] pci 0000:23:0c.2: [8086:2042] type 00 class 0x088000
> [   10.258487] pci 0000:23:0c.3: [8086:2043] type 00 class 0x088000
> [   10.262489] pci 0000:23:0c.4: [8086:2044] type 00 class 0x088000
> [   10.270491] pci 0000:23:0c.5: [8086:2045] type 00 class 0x088000
> [   10.278488] pci 0000:23:0c.6: [8086:2046] type 00 class 0x088000
> [   10.282490] pci 0000:23:0c.7: [8086:2047] type 00 class 0x088000
> [   10.290492] pci 0000:23:0d.0: [8086:2048] type 00 class 0x088000
> [   10.294498] pci 0000:23:0d.1: [8086:2049] type 00 class 0x088000
> [   10.302494] pci 0000:23:0d.2: [8086:204a] type 00 class 0x088000
> [   10.306491] pci 0000:23:0d.3: [8086:204b] type 00 class 0x088000
> [   10.314499] pci_bus 0000:23: on NUMA node 0
> [   10.314626] ACPI: PCI Root Bridge [UC03] (domain 0000 [bus 31])
> [   10.318426] acpi PNP0A08:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   10.326476] acpi PNP0A08:03: PCIe AER handled by firmware
> [   10.334490] acpi PNP0A08:03: _OSC: platform does not support [LTR]
> [   10.338545] acpi PNP0A08:03: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> [   10.346477] PCI host bridge to bus 0000:31
> [   10.350424] pci_bus 0000:31: root bus resource [bus 31]
> [   10.358435] pci 0000:31:0e.0: [8086:2058] type 00 class 0x110100
> [   10.362483] pci 0000:31:0e.1: [8086:2059] type 00 class 0x088000
> [   10.370480] pci 0000:31:0e.4: [8086:2058] type 00 class 0xffffff
> [   10.374478] pci 0000:31:0e.5: [8086:2059] type 00 class 0xffffff
> [   10.382489] pci 0000:31:0e.6: [8086:205a] type 00 class 0xffffff
> [   10.386475] pci 0000:31:0f.0: [8086:2058] type 00 class 0x110100
> [   10.394478] pci 0000:31:0f.1: [8086:2059] type 00 class 0x088000
> [   10.398480] pci 0000:31:0f.3: [8086:205b] type 00 class 0xffffff
> [   10.406475] pci 0000:31:0f.4: [8086:2058] type 00 class 0xffffff
> [   10.410477] pci 0000:31:0f.5: [8086:2059] type 00 class 0xffffff
> [   10.418479] pci 0000:31:0f.6: [8086:205a] type 00 class 0xffffff
> [   10.422476] pci 0000:31:10.0: [8086:2058] type 00 class 0x110100
> [   10.430480] pci 0000:31:10.1: [8086:2059] type 00 class 0x088000
> [   10.434478] pci 0000:31:10.4: [8086:2058] type 00 class 0xffffff
> [   10.442479] pci 0000:31:10.5: [8086:2059] type 00 class 0xffffff
> [   10.446480] pci 0000:31:10.6: [8086:205a] type 00 class 0xffffff
> [   10.454477] pci 0000:31:12.0: [8086:204c] type 00 class 0x110100
> [   10.458476] pci 0000:31:12.1: [8086:204d] type 00 class 0x110100
> [   10.466466] pci 0000:31:12.2: [8086:204e] type 00 class 0x088000
> [   10.470466] pci 0000:31:13.0: [8086:204c] type 00 class 0xffffff
> [   10.478478] pci 0000:31:13.1: [8086:204d] type 00 class 0xffffff
> [   10.482463] pci 0000:31:13.2: [8086:204e] type 00 class 0xffffff
> [   10.490463] pci 0000:31:13.3: [8086:204f] type 00 class 0xffffff
> [   10.494468] pci 0000:31:14.0: [8086:204c] type 00 class 0xffffff
> [   10.502475] pci 0000:31:14.1: [8086:204d] type 00 class 0xffffff
> [   10.506465] pci 0000:31:14.2: [8086:204e] type 00 class 0xffffff
> [   10.514462] pci 0000:31:14.3: [8086:204f] type 00 class 0xffffff
> [   10.518467] pci 0000:31:15.0: [8086:2018] type 00 class 0x088000
> [   10.526464] pci 0000:31:15.1: [8086:2088] type 00 class 0x110100
> [   10.530464] pci 0000:31:16.0: [8086:2018] type 00 class 0x088000
> [   10.538462] pci 0000:31:16.1: [8086:2088] type 00 class 0x110100
> [   10.542465] pci 0000:31:17.0: [8086:2018] type 00 class 0x088000
> [   10.550464] pci 0000:31:17.1: [8086:2088] type 00 class 0x110100
> [   10.554469] pci_bus 0000:31: on NUMA node 0
> [   10.554538] ACPI: PCI Root Bridge [PC04] (domain 0000 [bus 32-3d])
> [   10.562426] acpi PNP0A08:04: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   10.570485] acpi PNP0A08:04: PCIe AER handled by firmware
> [   10.578839] acpi PNP0A08:04: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> [   10.586501] PCI host bridge to bus 0000:32
> [   10.590425] pci_bus 0000:32: root bus resource [io  0x7000-0x7fff window]
> [   10.594424] pci_bus 0000:32: root bus resource [mem 0xa4400000-0xaaafffff window]
> [   10.602424] pci_bus 0000:32: root bus resource [mem 0x203000000000-0x203fffffffff window]
> [   10.610424] pci_bus 0000:32: root bus resource [bus 32-3d]
> [   10.618433] pci 0000:32:05.0: [8086:2034] type 00 class 0x088000
> [   10.622512] pci 0000:32:05.2: [8086:2035] type 00 class 0x088000
> [   10.630492] pci 0000:32:05.4: [8086:2036] type 00 class 0x080020
> [   10.634432] pci 0000:32:05.4: reg 0x10: [mem 0xa4400000-0xa4400fff]
> [   10.642504] pci_bus 0000:32: on NUMA node 0
> [   10.642613] ACPI: PCI Root Bridge [PC06] (domain 0000 [bus 40-42])
> [   10.646425] acpi PNP0A08:05: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   10.658484] acpi PNP0A08:05: PCIe AER handled by firmware
> [   10.662708] acpi PNP0A08:05: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> [   10.670526] PCI host bridge to bus 0000:40
> [   10.674424] pci_bus 0000:40: root bus resource [io  0x8000-0x8fff window]
> [   10.682424] pci_bus 0000:40: root bus resource [mem 0xab000000-0xb1bfffff window]
> [   10.690425] pci_bus 0000:40: root bus resource [mem 0x204000000000-0x204fffffffff window]
> [   10.698424] pci_bus 0000:40: root bus resource [bus 40-42]
> [   10.702432] pci 0000:40:04.0: [8086:2021] type 00 class 0x088000
> [   10.710433] pci 0000:40:04.0: reg 0x10: [mem 0x204ffff1c000-0x204ffff1ffff 64bit]
> [   10.714511] pci 0000:40:04.1: [8086:2021] type 00 class 0x088000
> [   10.722433] pci 0000:40:04.1: reg 0x10: [mem 0x204ffff18000-0x204ffff1bfff 64bit]
> [   10.730508] pci 0000:40:04.2: [8086:2021] type 00 class 0x088000
> [   10.734432] pci 0000:40:04.2: reg 0x10: [mem 0x204ffff14000-0x204ffff17fff 64bit]
> [   10.742503] pci 0000:40:04.3: [8086:2021] type 00 class 0x088000
> [   10.750432] pci 0000:40:04.3: reg 0x10: [mem 0x204ffff10000-0x204ffff13fff 64bit]
> [   10.758502] pci 0000:40:04.4: [8086:2021] type 00 class 0x088000
> [   10.762432] pci 0000:40:04.4: reg 0x10: [mem 0x204ffff0c000-0x204ffff0ffff 64bit]
> [   10.770501] pci 0000:40:04.5: [8086:2021] type 00 class 0x088000
> [   10.774432] pci 0000:40:04.5: reg 0x10: [mem 0x204ffff08000-0x204ffff0bfff 64bit]
> [   10.782505] pci 0000:40:04.6: [8086:2021] type 00 class 0x088000
> [   10.790432] pci 0000:40:04.6: reg 0x10: [mem 0x204ffff04000-0x204ffff07fff 64bit]
> [   10.798501] pci 0000:40:04.7: [8086:2021] type 00 class 0x088000
> [   10.802432] pci 0000:40:04.7: reg 0x10: [mem 0x204ffff00000-0x204ffff03fff 64bit]
> [   10.810510] pci 0000:40:05.0: [8086:2024] type 00 class 0x088000
> [   10.818504] pci 0000:40:05.2: [8086:2025] type 00 class 0x088000
> [   10.822502] pci 0000:40:05.4: [8086:2026] type 00 class 0x080020
> [   10.830431] pci 0000:40:05.4: reg 0x10: [mem 0xab000000-0xab000fff]
> [   10.834495] pci 0000:40:08.0: [8086:2014] type 00 class 0x088000
> [   10.842490] pci 0000:40:08.1: [8086:2015] type 00 class 0x110100
> [   10.846472] pci 0000:40:08.2: [8086:2016] type 00 class 0x088000
> [   10.854489] pci_bus 0000:40: on NUMA node 1
> [   10.854574] ACPI: PCI Root Bridge [PC07] (domain 0000 [bus 43-56])
> [   10.858426] acpi PNP0A08:06: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   10.870486] acpi PNP0A08:06: PCIe AER handled by firmware
> [   10.874840] acpi PNP0A08:06: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> [   10.882568] PCI host bridge to bus 0000:43
> [   10.886425] pci_bus 0000:43: root bus resource [io  0x9000-0x9fff window]
> [   10.894424] pci_bus 0000:43: root bus resource [mem 0xb1c00000-0xb87fffff window]
> [   10.902424] pci_bus 0000:43: root bus resource [mem 0x205000000000-0x205fffffffff window]
> [   10.910424] pci_bus 0000:43: root bus resource [bus 43-56]
> [   10.914432] pci 0000:43:05.0: [8086:2034] type 00 class 0x088000
> [   10.922507] pci 0000:43:05.2: [8086:2035] type 00 class 0x088000
> [   10.926502] pci 0000:43:05.4: [8086:2036] type 00 class 0x080020
> [   10.934432] pci 0000:43:05.4: reg 0x10: [mem 0xb1c00000-0xb1c00fff]
> [   10.938502] pci 0000:43:08.0: [8086:208d] type 00 class 0x088000
> [   10.946493] pci 0000:43:08.1: [8086:208d] type 00 class 0x088000
> [   10.950478] pci 0000:43:08.2: [8086:208d] type 00 class 0x088000
> [   10.958475] pci 0000:43:08.3: [8086:208d] type 00 class 0x088000
> [   10.962477] pci 0000:43:08.4: [8086:208d] type 00 class 0x088000
> [   10.970475] pci 0000:43:08.5: [8086:208d] type 00 class 0x088000
> [   10.974476] pci 0000:43:08.6: [8086:208d] type 00 class 0x088000
> [   10.982479] pci 0000:43:08.7: [8086:208d] type 00 class 0x088000
> [   10.986475] pci 0000:43:09.0: [8086:208d] type 00 class 0x088000
> [   10.994487] pci 0000:43:09.1: [8086:208d] type 00 class 0x088000
> [   10.998479] pci 0000:43:09.2: [8086:208d] type 00 class 0x088000
> [   11.006475] pci 0000:43:09.3: [8086:208d] type 00 class 0x088000
> [   11.010477] pci 0000:43:09.4: [8086:208d] type 00 class 0x088000
> [   11.018476] pci 0000:43:09.5: [8086:208d] type 00 class 0x088000
> [   11.022478] pci 0000:43:09.6: [8086:208d] type 00 class 0x088000
> [   11.030479] pci 0000:43:09.7: [8086:208d] type 00 class 0x088000
> [   11.034476] pci 0000:43:0a.0: [8086:208d] type 00 class 0x088000
> [   11.042488] pci 0000:43:0a.1: [8086:208d] type 00 class 0x088000
> [   11.046478] pci 0000:43:0a.2: [8086:208d] type 00 class 0x088000
> [   11.054474] pci 0000:43:0a.3: [8086:208d] type 00 class 0x088000
> [   11.058476] pci 0000:43:0a.4: [8086:208d] type 00 class 0x088000
> [   11.066474] pci 0000:43:0a.5: [8086:208d] type 00 class 0x088000
> [   11.070476] pci 0000:43:0a.6: [8086:208d] type 00 class 0x088000
> [   11.078478] pci 0000:43:0a.7: [8086:208d] type 00 class 0x088000
> [   11.082478] pci 0000:43:0b.0: [8086:208d] type 00 class 0x088000
> [   11.090488] pci 0000:43:0b.1: [8086:208d] type 00 class 0x088000
> [   11.094475] pci 0000:43:0b.2: [8086:208d] type 00 class 0x088000
> [   11.102477] pci 0000:43:0b.3: [8086:208d] type 00 class 0x088000
> [   11.106485] pci 0000:43:0e.0: [8086:208e] type 00 class 0x088000
> [   11.114484] pci 0000:43:0e.1: [8086:208e] type 00 class 0x088000
> [   11.118476] pci 0000:43:0e.2: [8086:208e] type 00 class 0x088000
> [   11.126478] pci 0000:43:0e.3: [8086:208e] type 00 class 0x088000
> [   11.130474] pci 0000:43:0e.4: [8086:208e] type 00 class 0x088000
> [   11.138476] pci 0000:43:0e.5: [8086:208e] type 00 class 0x088000
> [   11.142475] pci 0000:43:0e.6: [8086:208e] type 00 class 0x088000
> [   11.150477] pci 0000:43:0e.7: [8086:208e] type 00 class 0x088000
> [   11.154476] pci 0000:43:0f.0: [8086:208e] type 00 class 0x088000
> [   11.162486] pci 0000:43:0f.1: [8086:208e] type 00 class 0x088000
> [   11.170486] pci 0000:43:0f.2: [8086:208e] type 00 class 0x088000
> [   11.174479] pci 0000:43:0f.3: [8086:208e] type 00 class 0x088000
> [   11.182476] pci 0000:43:0f.4: [8086:208e] type 00 class 0x088000
> [   11.186478] pci 0000:43:0f.5: [8086:208e] type 00 class 0x088000
> [   11.194475] pci 0000:43:0f.6: [8086:208e] type 00 class 0x088000
> [   11.198478] pci 0000:43:0f.7: [8086:208e] type 00 class 0x088000
> [   11.206481] pci 0000:43:10.0: [8086:208e] type 00 class 0x088000
> [   11.210492] pci 0000:43:10.1: [8086:208e] type 00 class 0x088000
> [   11.218478] pci 0000:43:10.2: [8086:208e] type 00 class 0x088000
> [   11.222477] pci 0000:43:10.3: [8086:208e] type 00 class 0x088000
> [   11.230477] pci 0000:43:10.4: [8086:208e] type 00 class 0x088000
> [   11.234477] pci 0000:43:10.5: [8086:208e] type 00 class 0x088000
> [   11.242475] pci 0000:43:10.6: [8086:208e] type 00 class 0x088000
> [   11.246477] pci 0000:43:10.7: [8086:208e] type 00 class 0x088000
> [   11.254476] pci 0000:43:11.0: [8086:208e] type 00 class 0x088000
> [   11.258488] pci 0000:43:11.1: [8086:208e] type 00 class 0x088000
> [   11.266477] pci 0000:43:11.2: [8086:208e] type 00 class 0x088000
> [   11.270477] pci 0000:43:11.3: [8086:208e] type 00 class 0x088000
> [   11.278490] pci 0000:43:1d.0: [8086:2054] type 00 class 0x088000
> [   11.282489] pci 0000:43:1d.1: [8086:2055] type 00 class 0x088000
> [   11.290476] pci 0000:43:1d.2: [8086:2056] type 00 class 0x088000
> [   11.294478] pci 0000:43:1d.3: [8086:2057] type 00 class 0x088000
> [   11.302481] pci 0000:43:1e.0: [8086:2080] type 00 class 0x088000
> [   11.306485] pci 0000:43:1e.1: [8086:2081] type 00 class 0x088000
> [   11.314487] pci 0000:43:1e.2: [8086:2082] type 00 class 0x088000
> [   11.318481] pci 0000:43:1e.3: [8086:2083] type 00 class 0x088000
> [   11.326477] pci 0000:43:1e.4: [8086:2084] type 00 class 0x088000
> [   11.330477] pci 0000:43:1e.5: [8086:2085] type 00 class 0x088000
> [   11.338476] pci 0000:43:1e.6: [8086:2086] type 00 class 0x088000
> [   11.342480] pci_bus 0000:43: on NUMA node 1
> [   11.342648] ACPI: PCI Root Bridge [PC08] (domain 0000 [bus 57-6a])
> [   11.350426] acpi PNP0A08:07: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   11.358486] acpi PNP0A08:07: PCIe AER handled by firmware
> [   11.366841] acpi PNP0A08:07: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> [   11.374545] PCI host bridge to bus 0000:57
> [   11.378425] pci_bus 0000:57: root bus resource [io  0xa000-0xafff window]
> [   11.382424] pci_bus 0000:57: root bus resource [mem 0xb8800000-0xbf3fffff window]
> [   11.390424] pci_bus 0000:57: root bus resource [mem 0x206000000000-0x206fffffffff window]
> [   11.398424] pci_bus 0000:57: root bus resource [bus 57-6a]
> [   11.406432] pci 0000:57:05.0: [8086:2034] type 00 class 0x088000
> [   11.410499] pci 0000:57:05.2: [8086:2035] type 00 class 0x088000
> [   11.418494] pci 0000:57:05.4: [8086:2036] type 00 class 0x080020
> [   11.422431] pci 0000:57:05.4: reg 0x10: [mem 0xb8800000-0xb8800fff]
> [   11.430498] pci 0000:57:08.0: [8086:2066] type 00 class 0x088000
> [   11.434499] pci 0000:57:09.0: [8086:2066] type 00 class 0x088000
> [   11.442497] pci 0000:57:0a.0: [8086:2040] type 00 class 0x088000
> [   11.446492] pci 0000:57:0a.1: [8086:2041] type 00 class 0x088000
> [   11.454486] pci 0000:57:0a.2: [8086:2042] type 00 class 0x088000
> [   11.458484] pci 0000:57:0a.3: [8086:2043] type 00 class 0x088000
> [   11.466482] pci 0000:57:0a.4: [8086:2044] type 00 class 0x088000
> [   11.470483] pci 0000:57:0a.5: [8086:2045] type 00 class 0x088000
> [   11.478480] pci 0000:57:0a.6: [8086:2046] type 00 class 0x088000
> [   11.482484] pci 0000:57:0a.7: [8086:2047] type 00 class 0x088000
> [   11.490487] pci 0000:57:0b.0: [8086:2048] type 00 class 0x088000
> [   11.494494] pci 0000:57:0b.1: [8086:2049] type 00 class 0x088000
> [   11.502482] pci 0000:57:0b.2: [8086:204a] type 00 class 0x088000
> [   11.506484] pci 0000:57:0b.3: [8086:204b] type 00 class 0x088000
> [   11.514483] pci 0000:57:0c.0: [8086:2040] type 00 class 0x088000
> [   11.518497] pci 0000:57:0c.1: [8086:2041] type 00 class 0x088000
> [   11.526482] pci 0000:57:0c.2: [8086:2042] type 00 class 0x088000
> [   11.530486] pci 0000:57:0c.3: [8086:2043] type 00 class 0x088000
> [   11.538483] pci 0000:57:0c.4: [8086:2044] type 00 class 0x088000
> [   11.542483] pci 0000:57:0c.5: [8086:2045] type 00 class 0x088000
> [   11.550486] pci 0000:57:0c.6: [8086:2046] type 00 class 0x088000
> [   11.558484] pci 0000:57:0c.7: [8086:2047] type 00 class 0x088000
> [   11.562485] pci 0000:57:0d.0: [8086:2048] type 00 class 0x088000
> [   11.570498] pci 0000:57:0d.1: [8086:2049] type 00 class 0x088000
> [   11.574485] pci 0000:57:0d.2: [8086:204a] type 00 class 0x088000
> [   11.582494] pci 0000:57:0d.3: [8086:204b] type 00 class 0x088000
> [   11.586494] pci_bus 0000:57: on NUMA node 1
> [   11.586624] ACPI: PCI Root Bridge [UC13] (domain 0000 [bus 6b])
> [   11.594427] acpi PNP0A08:08: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   11.602475] acpi PNP0A08:08: PCIe AER handled by firmware
> [   11.606490] acpi PNP0A08:08: _OSC: platform does not support [LTR]
> [   11.614546] acpi PNP0A08:08: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> [   11.622478] PCI host bridge to bus 0000:6b
> [   11.626424] pci_bus 0000:6b: root bus resource [bus 6b]
> [   11.630433] pci 0000:6b:0e.0: [8086:2058] type 00 class 0x110100
> [   11.638474] pci 0000:6b:0e.1: [8086:2059] type 00 class 0x088000
> [   11.642474] pci 0000:6b:0e.4: [8086:2058] type 00 class 0xffffff
> [   11.650474] pci 0000:6b:0e.5: [8086:2059] type 00 class 0xffffff
> [   11.654470] pci 0000:6b:0e.6: [8086:205a] type 00 class 0xffffff
> [   11.662472] pci 0000:6b:0f.0: [8086:2058] type 00 class 0x110100
> [   11.666471] pci 0000:6b:0f.1: [8086:2059] type 00 class 0x088000
> [   11.674475] pci 0000:6b:0f.3: [8086:205b] type 00 class 0xffffff
> [   11.678471] pci 0000:6b:0f.4: [8086:2058] type 00 class 0xffffff
> [   11.686470] pci 0000:6b:0f.5: [8086:2059] type 00 class 0xffffff
> [   11.690471] pci 0000:6b:0f.6: [8086:205a] type 00 class 0xffffff
> [   11.698473] pci 0000:6b:10.0: [8086:2058] type 00 class 0x110100
> [   11.702471] pci 0000:6b:10.1: [8086:2059] type 00 class 0x088000
> [   11.710473] pci 0000:6b:10.4: [8086:2058] type 00 class 0xffffff
> [   11.714474] pci 0000:6b:10.5: [8086:2059] type 00 class 0xffffff
> [   11.722473] pci 0000:6b:10.6: [8086:205a] type 00 class 0xffffff
> [   11.726476] pci 0000:6b:12.0: [8086:204c] type 00 class 0x110100
> [   11.734470] pci 0000:6b:12.1: [8086:204d] type 00 class 0x110100
> [   11.738459] pci 0000:6b:12.2: [8086:204e] type 00 class 0x088000
> [   11.746466] pci 0000:6b:13.0: [8086:204c] type 00 class 0xffffff
> [   11.750469] pci 0000:6b:13.1: [8086:204d] type 00 class 0xffffff
> [   11.758461] pci 0000:6b:13.2: [8086:204e] type 00 class 0xffffff
> [   11.762459] pci 0000:6b:13.3: [8086:204f] type 00 class 0xffffff
> [   11.770465] pci 0000:6b:14.0: [8086:204c] type 00 class 0xffffff
> [   11.774473] pci 0000:6b:14.1: [8086:204d] type 00 class 0xffffff
> [   11.782458] pci 0000:6b:14.2: [8086:204e] type 00 class 0xffffff
> [   11.786460] pci 0000:6b:14.3: [8086:204f] type 00 class 0xffffff
> [   11.794459] pci 0000:6b:15.0: [8086:2018] type 00 class 0x088000
> [   11.798459] pci 0000:6b:15.1: [8086:2088] type 00 class 0x110100
> [   11.806462] pci 0000:6b:16.0: [8086:2018] type 00 class 0x088000
> [   11.810458] pci 0000:6b:16.1: [8086:2088] type 00 class 0x110100
> [   11.818464] pci 0000:6b:17.0: [8086:2018] type 00 class 0x088000
> [   11.822457] pci 0000:6b:17.1: [8086:2088] type 00 class 0x110100
> [   11.830467] pci_bus 0000:6b: on NUMA node 1
> [   11.830535] ACPI: PCI Root Bridge [PC10] (domain 0000 [bus 6c-7d])
> [   11.834425] acpi PNP0A08:09: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   11.846484] acpi PNP0A08:09: PCIe AER handled by firmware
> [   11.850840] acpi PNP0A08:09: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> [   11.858503] PCI host bridge to bus 0000:6c
> [   11.862425] pci_bus 0000:6c: root bus resource [io  0xb000-0xbfff window]
> [   11.870424] pci_bus 0000:6c: root bus resource [mem 0xbf400000-0xc5afffff window]
> [   11.878424] pci_bus 0000:6c: root bus resource [mem 0x207000000000-0x207fffffffff window]
> [   11.886424] pci_bus 0000:6c: root bus resource [bus 6c-7d]
> [   11.890431] pci 0000:6c:00.0: [8086:203f] type 01 class 0x060400
> [   11.898450] pci 0000:6c:00.0: enabling Extended Tags
> [   11.902455] pci 0000:6c:00.0: PME# supported from D0 D3hot D3cold
> [   11.906524] pci 0000:6c:05.0: [8086:2034] type 00 class 0x088000
> [   11.914494] pci 0000:6c:05.2: [8086:2035] type 00 class 0x088000
> [   11.918488] pci 0000:6c:05.4: [8086:2036] type 00 class 0x080020
> [   11.926431] pci 0000:6c:05.4: reg 0x10: [mem 0xbf880000-0xbf880fff]
> [   11.930623] acpiphp: Slot [9] registered
> [   11.934457] pci 0000:6d:00.0: [8086:1563] type 00 class 0x020000
> [   11.942448] pci 0000:6d:00.0: reg 0x10: [mem 0x207fff800000-0x207fffbfffff 64bit pref]
> [   11.950442] pci 0000:6d:00.0: reg 0x20: [mem 0x207fffc04000-0x207fffc07fff 64bit pref]
> [   11.958432] pci 0000:6d:00.0: reg 0x30: [mem 0xfff80000-0xffffffff pref]
> [   11.966490] pci 0000:6d:00.0: PME# supported from D0 D3hot
> [   11.970449] pci 0000:6d:00.0: reg 0x184: [mem 0xbf400000-0xbf403fff 64bit]
> [   11.978426] pci 0000:6d:00.0: VF(n) BAR0 space: [mem 0xbf400000-0xbf4fffff 64bit] (contains BAR0 for 64 VFs)
> [   11.986436] pci 0000:6d:00.0: reg 0x190: [mem 0xbf500000-0xbf503fff 64bit]
> [   11.994424] pci 0000:6d:00.0: VF(n) BAR3 space: [mem 0xbf500000-0xbf5fffff 64bit] (contains BAR3 for 64 VFs)
> [   12.002631] pci 0000:6d:00.1: [8086:1563] type 00 class 0x020000
> [   12.010446] pci 0000:6d:00.1: reg 0x10: [mem 0x207fff400000-0x207fff7fffff 64bit pref]
> [   12.018442] pci 0000:6d:00.1: reg 0x20: [mem 0x207fffc00000-0x207fffc03fff 64bit pref]
> [   12.026432] pci 0000:6d:00.1: reg 0x30: [mem 0xfff80000-0xffffffff pref]
> [   12.030496] pci 0000:6d:00.1: PME# supported from D0 D3hot
> [   12.038445] pci 0000:6d:00.1: reg 0x184: [mem 0xbf600000-0xbf603fff 64bit]
> [   12.046424] pci 0000:6d:00.1: VF(n) BAR0 space: [mem 0xbf600000-0xbf6fffff 64bit] (contains BAR0 for 64 VFs)
> [   12.054436] pci 0000:6d:00.1: reg 0x190: [mem 0xbf700000-0xbf703fff 64bit]
> [   12.062424] pci 0000:6d:00.1: VF(n) BAR3 space: [mem 0xbf700000-0xbf7fffff 64bit] (contains BAR3 for 64 VFs)
> [   12.070641] pci 0000:6c:00.0: PCI bridge to [bus 6d-6e]
> [   12.078426] pci 0000:6c:00.0:   bridge window [mem 0xbf400000-0xbf7fffff]
> [   12.082426] pci 0000:6c:00.0:   bridge window [mem 0x207fff400000-0x207fffcfffff 64bit pref]
> [   12.090428] pci_bus 0000:6c: on NUMA node 1
> [   12.090534] ACPI: PCI Root Bridge [PC12] (domain 0000 [bus 80-82])
> [   12.098426] acpi PNP0A08:0a: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   12.106488] acpi PNP0A08:0a: PCIe AER handled by firmware
> [   12.114716] acpi PNP0A08:0a: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> [   12.122528] PCI host bridge to bus 0000:80
> [   12.126425] pci_bus 0000:80: root bus resource [io  0xc000-0xcfff window]
> [   12.130424] pci_bus 0000:80: root bus resource [mem 0xc6000000-0xccbfffff window]
> [   12.138424] pci_bus 0000:80: root bus resource [mem 0x208000000000-0x208fffffffff window]
> [   12.146424] pci_bus 0000:80: root bus resource [bus 80-82]
> [   12.154431] pci 0000:80:00.0: [8086:2020] type 00 class 0x060000
> [   12.158588] pci 0000:80:04.0: [8086:2021] type 00 class 0x088000
> [   12.166434] pci 0000:80:04.0: reg 0x10: [mem 0x208ffff1c000-0x208ffff1ffff 64bit]
> [   12.174522] pci 0000:80:04.1: [8086:2021] type 00 class 0x088000
> [   12.178433] pci 0000:80:04.1: reg 0x10: [mem 0x208ffff18000-0x208ffff1bfff 64bit]
> [   12.186511] pci 0000:80:04.2: [8086:2021] type 00 class 0x088000
> [   12.190434] pci 0000:80:04.2: reg 0x10: [mem 0x208ffff14000-0x208ffff17fff 64bit]
> [   12.198510] pci 0000:80:04.3: [8086:2021] type 00 class 0x088000
> [   12.206433] pci 0000:80:04.3: reg 0x10: [mem 0x208ffff10000-0x208ffff13fff 64bit]
> [   12.214509] pci 0000:80:04.4: [8086:2021] type 00 class 0x088000
> [   12.218433] pci 0000:80:04.4: reg 0x10: [mem 0x208ffff0c000-0x208ffff0ffff 64bit]
> [   12.226510] pci 0000:80:04.5: [8086:2021] type 00 class 0x088000
> [   12.234436] pci 0000:80:04.5: reg 0x10: [mem 0x208ffff08000-0x208ffff0bfff 64bit]
> [   12.238515] pci 0000:80:04.6: [8086:2021] type 00 class 0x088000
> [   12.246434] pci 0000:80:04.6: reg 0x10: [mem 0x208ffff04000-0x208ffff07fff 64bit]
> [   12.254510] pci 0000:80:04.7: [8086:2021] type 00 class 0x088000
> [   12.258433] pci 0000:80:04.7: reg 0x10: [mem 0x208ffff00000-0x208ffff03fff 64bit]
> [   12.266509] pci 0000:80:05.0: [8086:2024] type 00 class 0x088000
> [   12.274514] pci 0000:80:05.2: [8086:2025] type 00 class 0x088000
> [   12.278501] pci 0000:80:05.4: [8086:2026] type 00 class 0x080020
> [   12.286432] pci 0000:80:05.4: reg 0x10: [mem 0xc6000000-0xc6000fff]
> [   12.290503] pci 0000:80:08.0: [8086:2014] type 00 class 0x088000
> [   12.298494] pci 0000:80:08.1: [8086:2015] type 00 class 0x110100
> [   12.302477] pci 0000:80:08.2: [8086:2016] type 00 class 0x088000
> [   12.310497] pci_bus 0000:80: on NUMA node 2
> [   12.310584] ACPI: PCI Root Bridge [PC13] (domain 0000 [bus 83-96])
> [   12.314426] acpi PNP0A08:0b: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   12.326488] acpi PNP0A08:0b: PCIe AER handled by firmware
> [   12.330844] acpi PNP0A08:0b: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> [   12.338567] PCI host bridge to bus 0000:83
> [   12.342425] pci_bus 0000:83: root bus resource [io  0xd000-0xdfff window]
> [   12.350424] pci_bus 0000:83: root bus resource [mem 0xccc00000-0xd37fffff window]
> [   12.358424] pci_bus 0000:83: root bus resource [mem 0x209000000000-0x209fffffffff window]
> [   12.366425] pci_bus 0000:83: root bus resource [bus 83-96]
> [   12.370433] pci 0000:83:05.0: [8086:2034] type 00 class 0x088000
> [   12.378516] pci 0000:83:05.2: [8086:2035] type 00 class 0x088000
> [   12.382507] pci 0000:83:05.4: [8086:2036] type 00 class 0x080020
> [   12.390432] pci 0000:83:05.4: reg 0x10: [mem 0xccc00000-0xccc00fff]
> [   12.394506] pci 0000:83:08.0: [8086:208d] type 00 class 0x088000
> [   12.402500] pci 0000:83:08.1: [8086:208d] type 00 class 0x088000
> [   12.406483] pci 0000:83:08.2: [8086:208d] type 00 class 0x088000
> [   12.414480] pci 0000:83:08.3: [8086:208d] type 00 class 0x088000
> [   12.418481] pci 0000:83:08.4: [8086:208d] type 00 class 0x088000
> [   12.426480] pci 0000:83:08.5: [8086:208d] type 00 class 0x088000
> [   12.430479] pci 0000:83:08.6: [8086:208d] type 00 class 0x088000
> [   12.438480] pci 0000:83:08.7: [8086:208d] type 00 class 0x088000
> [   12.442479] pci 0000:83:09.0: [8086:208d] type 00 class 0x088000
> [   12.450492] pci 0000:83:09.1: [8086:208d] type 00 class 0x088000
> [   12.454481] pci 0000:83:09.2: [8086:208d] type 00 class 0x088000
> [   12.462479] pci 0000:83:09.3: [8086:208d] type 00 class 0x088000
> [   12.466481] pci 0000:83:09.4: [8086:208d] type 00 class 0x088000
> [   12.474478] pci 0000:83:09.5: [8086:208d] type 00 class 0x088000
> [   12.478483] pci 0000:83:09.6: [8086:208d] type 00 class 0x088000
> [   12.486481] pci 0000:83:09.7: [8086:208d] type 00 class 0x088000
> [   12.490479] pci 0000:83:0a.0: [8086:208d] type 00 class 0x088000
> [   12.498495] pci 0000:83:0a.1: [8086:208d] type 00 class 0x088000
> [   12.502481] pci 0000:83:0a.2: [8086:208d] type 00 class 0x088000
> [   12.510478] pci 0000:83:0a.3: [8086:208d] type 00 class 0x088000
> [   12.518484] pci 0000:83:0a.4: [8086:208d] type 00 class 0x088000
> [   12.522478] pci 0000:83:0a.5: [8086:208d] type 00 class 0x088000
> [   12.530481] pci 0000:83:0a.6: [8086:208d] type 00 class 0x088000
> [   12.534481] pci 0000:83:0a.7: [8086:208d] type 00 class 0x088000
> [   12.542479] pci 0000:83:0b.0: [8086:208d] type 00 class 0x088000
> [   12.546493] pci 0000:83:0b.1: [8086:208d] type 00 class 0x088000
> [   12.554482] pci 0000:83:0b.2: [8086:208d] type 00 class 0x088000
> [   12.558479] pci 0000:83:0b.3: [8086:208d] type 00 class 0x088000
> [   12.566487] pci 0000:83:0e.0: [8086:208e] type 00 class 0x088000
> [   12.570491] pci 0000:83:0e.1: [8086:208e] type 00 class 0x088000
> [   12.578481] pci 0000:83:0e.2: [8086:208e] type 00 class 0x088000
> [   12.582481] pci 0000:83:0e.3: [8086:208e] type 00 class 0x088000
> [   12.590480] pci 0000:83:0e.4: [8086:208e] type 00 class 0x088000
> [   12.594481] pci 0000:83:0e.5: [8086:208e] type 00 class 0x088000
> [   12.602479] pci 0000:83:0e.6: [8086:208e] type 00 class 0x088000
> [   12.606482] pci 0000:83:0e.7: [8086:208e] type 00 class 0x088000
> [   12.614482] pci 0000:83:0f.0: [8086:208e] type 00 class 0x088000
> [   12.618488] pci 0000:83:0f.1: [8086:208e] type 00 class 0x088000
> [   12.626484] pci 0000:83:0f.2: [8086:208e] type 00 class 0x088000
> [   12.630480] pci 0000:83:0f.3: [8086:208e] type 00 class 0x088000
> [   12.638479] pci 0000:83:0f.4: [8086:208e] type 00 class 0x088000
> [   12.642482] pci 0000:83:0f.5: [8086:208e] type 00 class 0x088000
> [   12.650481] pci 0000:83:0f.6: [8086:208e] type 00 class 0x088000
> [   12.654482] pci 0000:83:0f.7: [8086:208e] type 00 class 0x088000
> [   12.662482] pci 0000:83:10.0: [8086:208e] type 00 class 0x088000
> [   12.666489] pci 0000:83:10.1: [8086:208e] type 00 class 0x088000
> [   12.674483] pci 0000:83:10.2: [8086:208e] type 00 class 0x088000
> [   12.678480] pci 0000:83:10.3: [8086:208e] type 00 class 0x088000
> [   12.686479] pci 0000:83:10.4: [8086:208e] type 00 class 0x088000
> [   12.690481] pci 0000:83:10.5: [8086:208e] type 00 class 0x088000
> [   12.698479] pci 0000:83:10.6: [8086:208e] type 00 class 0x088000
> [   12.702480] pci 0000:83:10.7: [8086:208e] type 00 class 0x088000
> [   12.710479] pci 0000:83:11.0: [8086:208e] type 00 class 0x088000
> [   12.714491] pci 0000:83:11.1: [8086:208e] type 00 class 0x088000
> [   12.722482] pci 0000:83:11.2: [8086:208e] type 00 class 0x088000
> [   12.726479] pci 0000:83:11.3: [8086:208e] type 00 class 0x088000
> [   12.734495] pci 0000:83:1d.0: [8086:2054] type 00 class 0x088000
> [   12.738494] pci 0000:83:1d.1: [8086:2055] type 00 class 0x088000
> [   12.746481] pci 0000:83:1d.2: [8086:2056] type 00 class 0x088000
> [   12.750482] pci 0000:83:1d.3: [8086:2057] type 00 class 0x088000
> [   12.758487] pci 0000:83:1e.0: [8086:2080] type 00 class 0x088000
> [   12.762490] pci 0000:83:1e.1: [8086:2081] type 00 class 0x088000
> [   12.770484] pci 0000:83:1e.2: [8086:2082] type 00 class 0x088000
> [   12.778482] pci 0000:83:1e.3: [8086:2083] type 00 class 0x088000
> [   12.782481] pci 0000:83:1e.4: [8086:2084] type 00 class 0x088000
> [   12.790483] pci 0000:83:1e.5: [8086:2085] type 00 class 0x088000
> [   12.794479] pci 0000:83:1e.6: [8086:2086] type 00 class 0x088000
> [   12.802494] pci_bus 0000:83: on NUMA node 2
> [   12.802648] ACPI: PCI Root Bridge [PC14] (domain 0000 [bus 97-aa])
> [   12.806426] acpi PNP0A08:0c: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   12.814487] acpi PNP0A08:0c: PCIe AER handled by firmware
> [   12.822843] acpi PNP0A08:0c: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> [   12.830545] PCI host bridge to bus 0000:97
> [   12.834425] pci_bus 0000:97: root bus resource [io  0xe000-0xefff window]
> [   12.842424] pci_bus 0000:97: root bus resource [mem 0xd3800000-0xda3fffff window]
> [   12.846424] pci_bus 0000:97: root bus resource [mem 0x20a000000000-0x20afffffffff window]
> [   12.858424] pci_bus 0000:97: root bus resource [bus 97-aa]
> [   12.862433] pci 0000:97:05.0: [8086:2034] type 00 class 0x088000
> [   12.866504] pci 0000:97:05.2: [8086:2035] type 00 class 0x088000
> [   12.874500] pci 0000:97:05.4: [8086:2036] type 00 class 0x080020
> [   12.878432] pci 0000:97:05.4: reg 0x10: [mem 0xd3800000-0xd3800fff]
> [   12.886506] pci 0000:97:08.0: [8086:2066] type 00 class 0x088000
> [   12.890504] pci 0000:97:09.0: [8086:2066] type 00 class 0x088000
> [   12.898506] pci 0000:97:0a.0: [8086:2040] type 00 class 0x088000
> [   12.906499] pci 0000:97:0a.1: [8086:2041] type 00 class 0x088000
> [   12.910491] pci 0000:97:0a.2: [8086:2042] type 00 class 0x088000
> [   12.918490] pci 0000:97:0a.3: [8086:2043] type 00 class 0x088000
> [   12.922489] pci 0000:97:0a.4: [8086:2044] type 00 class 0x088000
> [   12.930489] pci 0000:97:0a.5: [8086:2045] type 00 class 0x088000
> [   12.934490] pci 0000:97:0a.6: [8086:2046] type 00 class 0x088000
> [   12.942488] pci 0000:97:0a.7: [8086:2047] type 00 class 0x088000
> [   12.946490] pci 0000:97:0b.0: [8086:2048] type 00 class 0x088000
> [   12.954501] pci 0000:97:0b.1: [8086:2049] type 00 class 0x088000
> [   12.958488] pci 0000:97:0b.2: [8086:204a] type 00 class 0x088000
> [   12.966490] pci 0000:97:0b.3: [8086:204b] type 00 class 0x088000
> [   12.970492] pci 0000:97:0c.0: [8086:2040] type 00 class 0x088000
> [   12.978502] pci 0000:97:0c.1: [8086:2041] type 00 class 0x088000
> [   12.982490] pci 0000:97:0c.2: [8086:2042] type 00 class 0x088000
> [   12.990492] pci 0000:97:0c.3: [8086:2043] type 00 class 0x088000
> [   12.994492] pci 0000:97:0c.4: [8086:2044] type 00 class 0x088000
> [   13.002488] pci 0000:97:0c.5: [8086:2045] type 00 class 0x088000
> [   13.006491] pci 0000:97:0c.6: [8086:2046] type 00 class 0x088000
> [   13.014489] pci 0000:97:0c.7: [8086:2047] type 00 class 0x088000
> [   13.018491] pci 0000:97:0d.0: [8086:2048] type 00 class 0x088000
> [   13.026501] pci 0000:97:0d.1: [8086:2049] type 00 class 0x088000
> [   13.030493] pci 0000:97:0d.2: [8086:204a] type 00 class 0x088000
> [   13.038489] pci 0000:97:0d.3: [8086:204b] type 00 class 0x088000
> [   13.042502] pci_bus 0000:97: on NUMA node 2
> [   13.042621] ACPI: PCI Root Bridge [UC23] (domain 0000 [bus ab])
> [   13.050425] acpi PNP0A08:0d: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   13.058475] acpi PNP0A08:0d: PCIe AER handled by firmware
> [   13.062490] acpi PNP0A08:0d: _OSC: platform does not support [LTR]
> [   13.070545] acpi PNP0A08:0d: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> [   13.078478] PCI host bridge to bus 0000:ab
> [   13.082424] pci_bus 0000:ab: root bus resource [bus ab]
> [   13.086435] pci 0000:ab:0e.0: [8086:2058] type 00 class 0x110100
> [   13.094481] pci 0000:ab:0e.1: [8086:2059] type 00 class 0x088000
> [   13.098479] pci 0000:ab:0e.4: [8086:2058] type 00 class 0xffffff
> [   13.106477] pci 0000:ab:0e.5: [8086:2059] type 00 class 0xffffff
> [   13.110477] pci 0000:ab:0e.6: [8086:205a] type 00 class 0xffffff
> [   13.118478] pci 0000:ab:0f.0: [8086:2058] type 00 class 0x110100
> [   13.122478] pci 0000:ab:0f.1: [8086:2059] type 00 class 0x088000
> [   13.130481] pci 0000:ab:0f.3: [8086:205b] type 00 class 0xffffff
> [   13.134479] pci 0000:ab:0f.4: [8086:2058] type 00 class 0xffffff
> [   13.142477] pci 0000:ab:0f.5: [8086:2059] type 00 class 0xffffff
> [   13.146480] pci 0000:ab:0f.6: [8086:205a] type 00 class 0xffffff
> [   13.154488] pci 0000:ab:10.0: [8086:2058] type 00 class 0x110100
> [   13.158477] pci 0000:ab:10.1: [8086:2059] type 00 class 0x088000
> [   13.166481] pci 0000:ab:10.4: [8086:2058] type 00 class 0xffffff
> [   13.170479] pci 0000:ab:10.5: [8086:2059] type 00 class 0xffffff
> [   13.178477] pci 0000:ab:10.6: [8086:205a] type 00 class 0xffffff
> [   13.182481] pci 0000:ab:12.0: [8086:204c] type 00 class 0x110100
> [   13.190477] pci 0000:ab:12.1: [8086:204d] type 00 class 0x110100
> [   13.198463] pci 0000:ab:12.2: [8086:204e] type 00 class 0x088000
> [   13.202469] pci 0000:ab:13.0: [8086:204c] type 00 class 0xffffff
> [   13.210475] pci 0000:ab:13.1: [8086:204d] type 00 class 0xffffff
> [   13.214465] pci 0000:ab:13.2: [8086:204e] type 00 class 0xffffff
> [   13.222465] pci 0000:ab:13.3: [8086:204f] type 00 class 0xffffff
> [   13.226465] pci 0000:ab:14.0: [8086:204c] type 00 class 0xffffff
> [   13.234483] pci 0000:ab:14.1: [8086:204d] type 00 class 0xffffff
> [   13.238462] pci 0000:ab:14.2: [8086:204e] type 00 class 0xffffff
> [   13.246463] pci 0000:ab:14.3: [8086:204f] type 00 class 0xffffff
> [   13.250466] pci 0000:ab:15.0: [8086:2018] type 00 class 0x088000
> [   13.258461] pci 0000:ab:15.1: [8086:2088] type 00 class 0x110100
> [   13.262468] pci 0000:ab:16.0: [8086:2018] type 00 class 0x088000
> [   13.270462] pci 0000:ab:16.1: [8086:2088] type 00 class 0x110100
> [   13.274467] pci 0000:ab:17.0: [8086:2018] type 00 class 0x088000
> [   13.282462] pci 0000:ab:17.1: [8086:2088] type 00 class 0x110100
> [   13.286476] pci_bus 0000:ab: on NUMA node 2
> [   13.286545] ACPI: PCI Root Bridge [PC16] (domain 0000 [bus ac-bd])
> [   13.294426] acpi PNP0A08:0e: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   13.302485] acpi PNP0A08:0e: PCIe AER handled by firmware
> [   13.306842] acpi PNP0A08:0e: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> [   13.314505] PCI host bridge to bus 0000:ac
> [   13.318425] pci_bus 0000:ac: root bus resource [io  0xf000-0xffff window]
> [   13.326424] pci_bus 0000:ac: root bus resource [mem 0xda400000-0xe0afffff window]
> [   13.334424] pci_bus 0000:ac: root bus resource [mem 0x20b000000000-0x20bfffffffff window]
> [   13.342424] pci_bus 0000:ac: root bus resource [bus ac-bd]
> [   13.346433] pci 0000:ac:05.0: [8086:2034] type 00 class 0x088000
> [   13.354496] pci 0000:ac:05.2: [8086:2035] type 00 class 0x088000
> [   13.358495] pci 0000:ac:05.4: [8086:2036] type 00 class 0x080020
> [   13.366432] pci 0000:ac:05.4: reg 0x10: [mem 0xda400000-0xda400fff]
> [   13.374505] pci_bus 0000:ac: on NUMA node 2
> [   13.374604] ACPI: PCI Root Bridge [PC18] (domain 0000 [bus c0-c2])
> [   13.378426] acpi PNP0A08:0f: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   13.386484] acpi PNP0A08:0f: PCIe AER handled by firmware
> [   13.394710] acpi PNP0A08:0f: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> [   13.402462] acpi PNP0A08:0f: host bridge window [io  0x0000 window] (ignored, not CPU addressable)
> [   13.410488] PCI host bridge to bus 0000:c0
> [   13.414424] pci_bus 0000:c0: root bus resource [mem 0xe1000000-0xe7bfffff window]
> [   13.422424] pci_bus 0000:c0: root bus resource [mem 0x20c000000000-0x20cfffffffff window]
> [   13.430424] pci_bus 0000:c0: root bus resource [bus c0-c2]
> [   13.434433] pci 0000:c0:04.0: [8086:2021] type 00 class 0x088000
> [   13.442434] pci 0000:c0:04.0: reg 0x10: [mem 0x20cffff1c000-0x20cffff1ffff 64bit]
> [   13.450515] pci 0000:c0:04.1: [8086:2021] type 00 class 0x088000
> [   13.454433] pci 0000:c0:04.1: reg 0x10: [mem 0x20cffff18000-0x20cffff1bfff 64bit]
> [   13.462519] pci 0000:c0:04.2: [8086:2021] type 00 class 0x088000
> [   13.470433] pci 0000:c0:04.2: reg 0x10: [mem 0x20cffff14000-0x20cffff17fff 64bit]
> [   13.474512] pci 0000:c0:04.3: [8086:2021] type 00 class 0x088000
> [   13.482433] pci 0000:c0:04.3: reg 0x10: [mem 0x20cffff10000-0x20cffff13fff 64bit]
> [   13.490510] pci 0000:c0:04.4: [8086:2021] type 00 class 0x088000
> [   13.494434] pci 0000:c0:04.4: reg 0x10: [mem 0x20cffff0c000-0x20cffff0ffff 64bit]
> [   13.502510] pci 0000:c0:04.5: [8086:2021] type 00 class 0x088000
> [   13.510433] pci 0000:c0:04.5: reg 0x10: [mem 0x20cffff08000-0x20cffff0bfff 64bit]
> [   13.518510] pci 0000:c0:04.6: [8086:2021] type 00 class 0x088000
> [   13.522433] pci 0000:c0:04.6: reg 0x10: [mem 0x20cffff04000-0x20cffff07fff 64bit]
> [   13.530512] pci 0000:c0:04.7: [8086:2021] type 00 class 0x088000
> [   13.538434] pci 0000:c0:04.7: reg 0x10: [mem 0x20cffff00000-0x20cffff03fff 64bit]
> [   13.542508] pci 0000:c0:05.0: [8086:2024] type 00 class 0x088000
> [   13.550512] pci 0000:c0:05.2: [8086:2025] type 00 class 0x088000
> [   13.554499] pci 0000:c0:05.4: [8086:2026] type 00 class 0x080020
> [   13.562432] pci 0000:c0:05.4: reg 0x10: [mem 0xe1000000-0xe1000fff]
> [   13.566516] pci 0000:c0:08.0: [8086:2014] type 00 class 0x088000
> [   13.574497] pci 0000:c0:08.1: [8086:2015] type 00 class 0x110100
> [   13.582476] pci 0000:c0:08.2: [8086:2016] type 00 class 0x088000
> [   13.586495] pci_bus 0000:c0: on NUMA node 3
> [   13.586580] ACPI: PCI Root Bridge [PC19] (domain 0000 [bus c3-d6])
> [   13.594426] acpi PNP0A08:10: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   13.602485] acpi PNP0A08:10: PCIe AER handled by firmware
> [   13.606847] acpi PNP0A08:10: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> [   13.614460] acpi PNP0A08:10: host bridge window [io  0x0000 window] (ignored, not CPU addressable)
> [   13.626537] PCI host bridge to bus 0000:c3
> [   13.630425] pci_bus 0000:c3: root bus resource [mem 0xe7c00000-0xee7fffff window]
> [   13.634424] pci_bus 0000:c3: root bus resource [mem 0x20d000000000-0x20dfffffffff window]
> [   13.646424] pci_bus 0000:c3: root bus resource [bus c3-d6]
> [   13.650433] pci 0000:c3:05.0: [8086:2034] type 00 class 0x088000
> [   13.654513] pci 0000:c3:05.2: [8086:2035] type 00 class 0x088000
> [   13.662506] pci 0000:c3:05.4: [8086:2036] type 00 class 0x080020
> [   13.666432] pci 0000:c3:05.4: reg 0x10: [mem 0xe7c00000-0xe7c00fff]
> [   13.674511] pci 0000:c3:08.0: [8086:208d] type 00 class 0x088000
> [   13.678495] pci 0000:c3:08.1: [8086:208d] type 00 class 0x088000
> [   13.686480] pci 0000:c3:08.2: [8086:208d] type 00 class 0x088000
> [   13.694482] pci 0000:c3:08.3: [8086:208d] type 00 class 0x088000
> [   13.698478] pci 0000:c3:08.4: [8086:208d] type 00 class 0x088000
> [   13.706482] pci 0000:c3:08.5: [8086:208d] type 00 class 0x088000
> [   13.710482] pci 0000:c3:08.6: [8086:208d] type 00 class 0x088000
> [   13.718479] pci 0000:c3:08.7: [8086:208d] type 00 class 0x088000
> [   13.722482] pci 0000:c3:09.0: [8086:208d] type 00 class 0x088000
> [   13.730495] pci 0000:c3:09.1: [8086:208d] type 00 class 0x088000
> [   13.734478] pci 0000:c3:09.2: [8086:208d] type 00 class 0x088000
> [   13.742480] pci 0000:c3:09.3: [8086:208d] type 00 class 0x088000
> [   13.746479] pci 0000:c3:09.4: [8086:208d] type 00 class 0x088000
> [   13.754484] pci 0000:c3:09.5: [8086:208d] type 00 class 0x088000
> [   13.758482] pci 0000:c3:09.6: [8086:208d] type 00 class 0x088000
> [   13.766481] pci 0000:c3:09.7: [8086:208d] type 00 class 0x088000
> [   13.770481] pci 0000:c3:0a.0: [8086:208d] type 00 class 0x088000
> [   13.778495] pci 0000:c3:0a.1: [8086:208d] type 00 class 0x088000
> [   13.782480] pci 0000:c3:0a.2: [8086:208d] type 00 class 0x088000
> [   13.790483] pci 0000:c3:0a.3: [8086:208d] type 00 class 0x088000
> [   13.794480] pci 0000:c3:0a.4: [8086:208d] type 00 class 0x088000
> [   13.802483] pci 0000:c3:0a.5: [8086:208d] type 00 class 0x088000
> [   13.806484] pci 0000:c3:0a.6: [8086:208d] type 00 class 0x088000
> [   13.814481] pci 0000:c3:0a.7: [8086:208d] type 00 class 0x088000
> [   13.818483] pci 0000:c3:0b.0: [8086:208d] type 00 class 0x088000
> [   13.826491] pci 0000:c3:0b.1: [8086:208d] type 00 class 0x088000
> [   13.830482] pci 0000:c3:0b.2: [8086:208d] type 00 class 0x088000
> [   13.838481] pci 0000:c3:0b.3: [8086:208d] type 00 class 0x088000
> [   13.842483] pci 0000:c3:0e.0: [8086:208e] type 00 class 0x088000
> [   13.850492] pci 0000:c3:0e.1: [8086:208e] type 00 class 0x088000
> [   13.854481] pci 0000:c3:0e.2: [8086:208e] type 00 class 0x088000
> [   13.862478] pci 0000:c3:0e.3: [8086:208e] type 00 class 0x088000
> [   13.866481] pci 0000:c3:0e.4: [8086:208e] type 00 class 0x088000
> [   13.874486] pci 0000:c3:0e.5: [8086:208e] type 00 class 0x088000
> [   13.878480] pci 0000:c3:0e.6: [8086:208e] type 00 class 0x088000
> [   13.886478] pci 0000:c3:0e.7: [8086:208e] type 00 class 0x088000
> [   13.890482] pci 0000:c3:0f.0: [8086:208e] type 00 class 0x088000
> [   13.898494] pci 0000:c3:0f.1: [8086:208e] type 00 class 0x088000
> [   13.902482] pci 0000:c3:0f.2: [8086:208e] type 00 class 0x088000
> [   13.910479] pci 0000:c3:0f.3: [8086:208e] type 00 class 0x088000
> [   13.914481] pci 0000:c3:0f.4: [8086:208e] type 00 class 0x088000
> [   13.922481] pci 0000:c3:0f.5: [8086:208e] type 00 class 0x088000
> [   13.926482] pci 0000:c3:0f.6: [8086:208e] type 00 class 0x088000
> [   13.934479] pci 0000:c3:0f.7: [8086:208e] type 00 class 0x088000
> [   13.942482] pci 0000:c3:10.0: [8086:208e] type 00 class 0x088000
> [   13.946494] pci 0000:c3:10.1: [8086:208e] type 00 class 0x088000
> [   13.954482] pci 0000:c3:10.2: [8086:208e] type 00 class 0x088000
> [   13.958481] pci 0000:c3:10.3: [8086:208e] type 00 class 0x088000
> [   13.966485] pci 0000:c3:10.4: [8086:208e] type 00 class 0x088000
> [   13.970479] pci 0000:c3:10.5: [8086:208e] type 00 class 0x088000
> [   13.978481] pci 0000:c3:10.6: [8086:208e] type 00 class 0x088000
> [   13.982479] pci 0000:c3:10.7: [8086:208e] type 00 class 0x088000
> [   13.990483] pci 0000:c3:11.0: [8086:208e] type 00 class 0x088000
> [   13.994494] pci 0000:c3:11.1: [8086:208e] type 00 class 0x088000
> [   14.002479] pci 0000:c3:11.2: [8086:208e] type 00 class 0x088000
> [   14.006481] pci 0000:c3:11.3: [8086:208e] type 00 class 0x088000
> [   14.014492] pci 0000:c3:1d.0: [8086:2054] type 00 class 0x088000
> [   14.018495] pci 0000:c3:1d.1: [8086:2055] type 00 class 0x088000
> [   14.026483] pci 0000:c3:1d.2: [8086:2056] type 00 class 0x088000
> [   14.030481] pci 0000:c3:1d.3: [8086:2057] type 00 class 0x088000
> [   14.038490] pci 0000:c3:1e.0: [8086:2080] type 00 class 0x088000
> [   14.042495] pci 0000:c3:1e.1: [8086:2081] type 00 class 0x088000
> [   14.050482] pci 0000:c3:1e.2: [8086:2082] type 00 class 0x088000
> [   14.054480] pci 0000:c3:1e.3: [8086:2083] type 00 class 0x088000
> [   14.062483] pci 0000:c3:1e.4: [8086:2084] type 00 class 0x088000
> [   14.066480] pci 0000:c3:1e.5: [8086:2085] type 00 class 0x088000
> [   14.074482] pci 0000:c3:1e.6: [8086:2086] type 00 class 0x088000
> [   14.078481] pci_bus 0000:c3: on NUMA node 3
> [   14.078635] ACPI: PCI Root Bridge [PC20] (domain 0000 [bus d7-ea])
> [   14.086426] acpi PNP0A08:11: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   14.094487] acpi PNP0A08:11: PCIe AER handled by firmware
> [   14.098847] acpi PNP0A08:11: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> [   14.110462] acpi PNP0A08:11: host bridge window [io  0x0000 window] (ignored, not CPU addressable)
> [   14.118504] PCI host bridge to bus 0000:d7
> [   14.122424] pci_bus 0000:d7: root bus resource [mem 0xee800000-0xf53fffff window]
> [   14.130424] pci_bus 0000:d7: root bus resource [mem 0x20e000000000-0x20efffffffff window]
> [   14.138424] pci_bus 0000:d7: root bus resource [bus d7-ea]
> [   14.142433] pci 0000:d7:05.0: [8086:2034] type 00 class 0x088000
> [   14.150507] pci 0000:d7:05.2: [8086:2035] type 00 class 0x088000
> [   14.154498] pci 0000:d7:05.4: [8086:2036] type 00 class 0x080020
> [   14.162432] pci 0000:d7:05.4: reg 0x10: [mem 0xee800000-0xee800fff]
> [   14.166504] pci 0000:d7:08.0: [8086:2066] type 00 class 0x088000
> [   14.174517] pci 0000:d7:09.0: [8086:2066] type 00 class 0x088000
> [   14.178506] pci 0000:d7:0a.0: [8086:2040] type 00 class 0x088000
> [   14.186504] pci 0000:d7:0a.1: [8086:2041] type 00 class 0x088000
> [   14.190489] pci 0000:d7:0a.2: [8086:2042] type 00 class 0x088000
> [   14.198493] pci 0000:d7:0a.3: [8086:2043] type 00 class 0x088000
> [   14.202491] pci 0000:d7:0a.4: [8086:2044] type 00 class 0x088000
> [   14.210497] pci 0000:d7:0a.5: [8086:2045] type 00 class 0x088000
> [   14.214498] pci 0000:d7:0a.6: [8086:2046] type 00 class 0x088000
> [   14.222492] pci 0000:d7:0a.7: [8086:2047] type 00 class 0x088000
> [   14.226488] pci 0000:d7:0b.0: [8086:2048] type 00 class 0x088000
> [   14.234504] pci 0000:d7:0b.1: [8086:2049] type 00 class 0x088000
> [   14.238489] pci 0000:d7:0b.2: [8086:204a] type 00 class 0x088000
> [   14.246492] pci 0000:d7:0b.3: [8086:204b] type 00 class 0x088000
> [   14.250489] pci 0000:d7:0c.0: [8086:2040] type 00 class 0x088000
> [   14.258501] pci 0000:d7:0c.1: [8086:2041] type 00 class 0x088000
> [   14.262492] pci 0000:d7:0c.2: [8086:2042] type 00 class 0x088000
> [   14.270489] pci 0000:d7:0c.3: [8086:2043] type 00 class 0x088000
> [   14.278491] pci 0000:d7:0c.4: [8086:2044] type 00 class 0x088000
> [   14.282493] pci 0000:d7:0c.5: [8086:2045] type 00 class 0x088000
> [   14.290489] pci 0000:d7:0c.6: [8086:2046] type 00 class 0x088000
> [   14.294492] pci 0000:d7:0c.7: [8086:2047] type 00 class 0x088000
> [   14.302492] pci 0000:d7:0d.0: [8086:2048] type 00 class 0x088000
> [   14.306502] pci 0000:d7:0d.1: [8086:2049] type 00 class 0x088000
> [   14.314489] pci 0000:d7:0d.2: [8086:204a] type 00 class 0x088000
> [   14.318492] pci 0000:d7:0d.3: [8086:204b] type 00 class 0x088000
> [   14.326508] pci_bus 0000:d7: on NUMA node 3
> [   14.326634] ACPI: PCI Root Bridge [UC33] (domain 0000 [bus eb])
> [   14.330426] acpi PNP0A08:12: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   14.338476] acpi PNP0A08:12: PCIe AER handled by firmware
> [   14.346491] acpi PNP0A08:12: _OSC: platform does not support [LTR]
> [   14.350546] acpi PNP0A08:12: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
> [   14.358477] PCI host bridge to bus 0000:eb
> [   14.362425] pci_bus 0000:eb: root bus resource [bus eb]
> [   14.370435] pci 0000:eb:0e.0: [8086:2058] type 00 class 0x110100
> [   14.374484] pci 0000:eb:0e.1: [8086:2059] type 00 class 0x088000
> [   14.382477] pci 0000:eb:0e.4: [8086:2058] type 00 class 0xffffff
> [   14.386481] pci 0000:eb:0e.5: [8086:2059] type 00 class 0xffffff
> [   14.394479] pci 0000:eb:0e.6: [8086:205a] type 00 class 0xffffff
> [   14.398478] pci 0000:eb:0f.0: [8086:2058] type 00 class 0x110100
> [   14.406478] pci 0000:eb:0f.1: [8086:2059] type 00 class 0x088000
> [   14.410479] pci 0000:eb:0f.3: [8086:205b] type 00 class 0xffffff
> [   14.418475] pci 0000:eb:0f.4: [8086:2058] type 00 class 0xffffff
> [   14.422480] pci 0000:eb:0f.5: [8086:2059] type 00 class 0xffffff
> [   14.430480] pci 0000:eb:0f.6: [8086:205a] type 00 class 0xffffff
> [   14.434479] pci 0000:eb:10.0: [8086:2058] type 00 class 0x110100
> [   14.442482] pci 0000:eb:10.1: [8086:2059] type 00 class 0x088000
> [   14.446482] pci 0000:eb:10.4: [8086:2058] type 00 class 0xffffff
> [   14.454477] pci 0000:eb:10.5: [8086:2059] type 00 class 0xffffff
> [   14.458481] pci 0000:eb:10.6: [8086:205a] type 00 class 0xffffff
> [   14.466479] pci 0000:eb:12.0: [8086:204c] type 00 class 0x110100
> [   14.470478] pci 0000:eb:12.1: [8086:204d] type 00 class 0x110100
> [   14.478469] pci 0000:eb:12.2: [8086:204e] type 00 class 0x088000
> [   14.482468] pci 0000:eb:13.0: [8086:204c] type 00 class 0xffffff
> [   14.490480] pci 0000:eb:13.1: [8086:204d] type 00 class 0xffffff
> [   14.494463] pci 0000:eb:13.2: [8086:204e] type 00 class 0xffffff
> [   14.502465] pci 0000:eb:13.3: [8086:204f] type 00 class 0xffffff
> [   14.506469] pci 0000:eb:14.0: [8086:204c] type 00 class 0xffffff
> [   14.514477] pci 0000:eb:14.1: [8086:204d] type 00 class 0xffffff
> [   14.518467] pci 0000:eb:14.2: [8086:204e] type 00 class 0xffffff
> [   14.526464] pci 0000:eb:14.3: [8086:204f] type 00 class 0xffffff
> [   14.530467] pci 0000:eb:15.0: [8086:2018] type 00 class 0x088000
> [   14.538466] pci 0000:eb:15.1: [8086:2088] type 00 class 0x110100
> [   14.542466] pci 0000:eb:16.0: [8086:2018] type 00 class 0x088000
> [   14.550464] pci 0000:eb:16.1: [8086:2088] type 00 class 0x110100
> [   14.554466] pci 0000:eb:17.0: [8086:2018] type 00 class 0x088000
> [   14.562466] pci 0000:eb:17.1: [8086:2088] type 00 class 0x110100
> [   14.566470] pci_bus 0000:eb: on NUMA node 3
> [   14.566541] ACPI: PCI Root Bridge [PC22] (domain 0000 [bus ec-fd])
> [   14.574426] acpi PNP0A08:13: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [   14.582486] acpi PNP0A08:13: PCIe AER handled by firmware
> [   14.590844] acpi PNP0A08:13: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR]
> [   14.598461] acpi PNP0A08:13: host bridge window [io  0x0000 window] (ignored, not CPU addressable)
> [   14.606473] PCI host bridge to bus 0000:ec
> [   14.610425] pci_bus 0000:ec: root bus resource [mem 0xf5400000-0xfbafffff window]
> [   14.618424] pci_bus 0000:ec: root bus resource [mem 0x20f000000000-0x20ffffffffff window]
> [   14.626424] pci_bus 0000:ec: root bus resource [bus ec-fd]
> [   14.630433] pci 0000:ec:05.0: [8086:2034] type 00 class 0x088000
> [   14.638501] pci 0000:ec:05.2: [8086:2035] type 00 class 0x088000
> [   14.642497] pci 0000:ec:05.4: [8086:2036] type 00 class 0x080020
> [   14.650433] pci 0000:ec:05.4: reg 0x10: [mem 0xf5400000-0xf5400fff]
> [   14.654503] pci_bus 0000:ec: on NUMA node 3
> [   14.658462] iommu: Default domain type: Translated 
> [   14.662467] pci 0000:03:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
> [   14.670589] pci 0000:03:00.0: vgaarb: bridge control possible
> [   14.678424] pci 0000:03:00.0: vgaarb: setting as boot device
> [   14.682424] vgaarb: loaded
> [   14.685551] SCSI subsystem initialized
> [   14.690669] libata version 3.00 loaded.
> [   14.690669] ACPI: bus type USB registered
> [   14.694436] usbcore: registered new interface driver usbfs
> [   14.698429] usbcore: registered new interface driver hub
> [   14.706821] usbcore: registered new device driver usb
> [   14.710791] EDAC MC: Ver: 3.0.0
> [   14.714892] Registered efivars operations
> [   14.718473] PCI: Using ACPI for IRQ routing
> [   14.725960] PCI: pci_cache_line_size set to 64 bytes
> [   14.726625] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
> [   14.726626] e820: reserve RAM buffer [mem 0x5c81a018-0x5fffffff]
> [   14.726627] e820: reserve RAM buffer [mem 0x5c84f018-0x5fffffff]
> [   14.726628] e820: reserve RAM buffer [mem 0x65e0f000-0x67ffffff]
> [   14.726629] e820: reserve RAM buffer [mem 0x6f800000-0x6fffffff]
> [   14.726840] NetLabel: Initializing
> [   14.730236] NetLabel:  domain hash size = 128
> [   14.734424] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [   14.742439] NetLabel:  unlabeled traffic allowed by default
> [   14.747132] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> [   14.754426] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
> [   14.762577] clocksource: Switched to clocksource tsc-early
> [   14.782582] VFS: Disk quotas dquot_6.6.0
> [   14.786572] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [   14.793674] AppArmor: AppArmor Filesystem Enabled
> [   14.798397] pnp: PnP ACPI init
> [   14.820035] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
> [   14.820390] system 00:01: [io  0x0500-0x05fe] has been reserved
> [   14.826301] system 00:01: [io  0x0400-0x041f] has been reserved
> [   14.832206] system 00:01: [io  0x0600-0x061f] has been reserved
> [   14.838108] system 00:01: [io  0x0ca0-0x0ca1] has been reserved
> [   14.844014] system 00:01: [io  0x0ca4-0x0ca6] has been reserved
> [   14.849921] system 00:01: [mem 0xfed40000-0xfed47fff] could not be reserved
> [   14.856863] system 00:01: [mem 0xff000000-0xffffffff] has been reserved
> [   14.863465] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
> [   14.863663] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
> [   14.863826] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
> [   14.864172] system 00:04: [mem 0xfd000000-0xfdabffff] has been reserved
> [   14.870776] system 00:04: [mem 0xfdad0000-0xfdadffff] has been reserved
> [   14.877372] system 00:04: [mem 0xfdb00000-0xfdffffff] has been reserved
> [   14.883969] system 00:04: [mem 0xfe000000-0xfe00ffff] has been reserved
> [   14.890568] system 00:04: [mem 0xfe011000-0xfe01ffff] has been reserved
> [   14.897163] system 00:04: [mem 0xfe036000-0xfe03bfff] has been reserved
> [   14.903763] system 00:04: [mem 0xfe03d000-0xfe3fffff] has been reserved
> [   14.910356] system 00:04: [mem 0xfe410000-0xfe7fffff] has been reserved
> [   14.916958] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
> [   14.917444] system 00:05: [io  0x1000-0x10fe] has been reserved
> [   14.923356] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
> [   14.924549] pnp: PnP ACPI: found 6 devices
> [   14.934800] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [   14.943684] pci 0000:6d:00.0: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
> [   14.953572] pci 0000:6d:00.1: can't claim BAR 6 [mem 0xfff80000-0xffffffff pref]: no compatible bridge window
> [   14.963470] pci 0000:00:1c.0: PCI bridge to [bus 01]
> [   14.968427] pci 0000:00:1c.0:   bridge window [io  0x3000-0x3fff]
> [   14.974506] pci 0000:00:1c.0:   bridge window [mem 0x92100000-0x921fffff]
> [   14.981278] pci 0000:02:00.0: PCI bridge to [bus 03]
> [   14.986232] pci 0000:02:00.0:   bridge window [io  0x2000-0x2fff]
> [   14.992312] pci 0000:02:00.0:   bridge window [mem 0x91000000-0x920fffff]
> [   14.999088] pci 0000:00:1c.5: PCI bridge to [bus 02-03]
> [   15.004301] pci 0000:00:1c.5:   bridge window [io  0x2000-0x2fff]
> [   15.010378] pci 0000:00:1c.5:   bridge window [mem 0x91000000-0x920fffff]
> [   15.017153] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [   15.023310] pci_bus 0000:00: resource 5 [io  0x1000-0x4fff window]
> [   15.029476] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> [   15.036333] pci_bus 0000:00: resource 7 [mem 0x000c4000-0x000c7fff window]
> [   15.043189] pci_bus 0000:00: resource 8 [mem 0xfe010000-0xfe010fff window]
> [   15.050045] pci_bus 0000:00: resource 9 [mem 0x90000000-0x96bfffff window]
> [   15.056904] pci_bus 0000:00: resource 10 [mem 0x200000000000-0x200fffffffff window]
> [   15.064540] pci_bus 0000:01: resource 0 [io  0x3000-0x3fff]
> [   15.070106] pci_bus 0000:01: resource 1 [mem 0x92100000-0x921fffff]
> [   15.076358] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
> [   15.081916] pci_bus 0000:02: resource 1 [mem 0x91000000-0x920fffff]
> [   15.088168] pci_bus 0000:03: resource 0 [io  0x2000-0x2fff]
> [   15.093727] pci_bus 0000:03: resource 1 [mem 0x91000000-0x920fffff]
> [   15.100055] pci_bus 0000:15: resource 4 [io  0x5000-0x5fff window]
> [   15.106222] pci_bus 0000:15: resource 5 [mem 0x96c00000-0x9d7fffff window]
> [   15.113076] pci_bus 0000:15: resource 6 [mem 0x201000000000-0x201fffffffff window]
> [   15.120652] pci_bus 0000:23: resource 4 [io  0x6000-0x6fff window]
> [   15.126815] pci_bus 0000:23: resource 5 [mem 0x9d800000-0xa43fffff window]
> [   15.133670] pci_bus 0000:23: resource 6 [mem 0x202000000000-0x202fffffffff window]
> [   15.141252] pci_bus 0000:32: resource 4 [io  0x7000-0x7fff window]
> [   15.147422] pci_bus 0000:32: resource 5 [mem 0xa4400000-0xaaafffff window]
> [   15.154277] pci_bus 0000:32: resource 6 [mem 0x203000000000-0x203fffffffff window]
> [   15.161844] pci_bus 0000:40: resource 4 [io  0x8000-0x8fff window]
> [   15.168016] pci_bus 0000:40: resource 5 [mem 0xab000000-0xb1bfffff window]
> [   15.174873] pci_bus 0000:40: resource 6 [mem 0x204000000000-0x204fffffffff window]
> [   15.182447] pci_bus 0000:43: resource 4 [io  0x9000-0x9fff window]
> [   15.188609] pci_bus 0000:43: resource 5 [mem 0xb1c00000-0xb87fffff window]
> [   15.195465] pci_bus 0000:43: resource 6 [mem 0x205000000000-0x205fffffffff window]
> [   15.203042] pci_bus 0000:57: resource 4 [io  0xa000-0xafff window]
> [   15.209203] pci_bus 0000:57: resource 5 [mem 0xb8800000-0xbf3fffff window]
> [   15.216061] pci_bus 0000:57: resource 6 [mem 0x206000000000-0x206fffffffff window]
> [   15.223641] pci 0000:6d:00.0: BAR 6: no space for [mem size 0x00080000 pref]
> [   15.230673] pci 0000:6d:00.0: BAR 6: failed to assign [mem size 0x00080000 pref]
> [   15.238049] pci 0000:6d:00.1: BAR 6: no space for [mem size 0x00080000 pref]
> [   15.245079] pci 0000:6d:00.1: BAR 6: failed to assign [mem size 0x00080000 pref]
> [   15.252452] pci 0000:6c:00.0: PCI bridge to [bus 6d-6e]
> [   15.257669] pci 0000:6c:00.0:   bridge window [mem 0xbf400000-0xbf7fffff]
> [   15.264437] pci 0000:6c:00.0:   bridge window [mem 0x207fff400000-0x207fffcfffff 64bit pref]
> [   15.272854] pci_bus 0000:6c: resource 4 [io  0xb000-0xbfff window]
> [   15.279021] pci_bus 0000:6c: resource 5 [mem 0xbf400000-0xc5afffff window]
> [   15.285871] pci_bus 0000:6c: resource 6 [mem 0x207000000000-0x207fffffffff window]
> [   15.293418] pci_bus 0000:6d: resource 1 [mem 0xbf400000-0xbf7fffff]
> [   15.299669] pci_bus 0000:6d: resource 2 [mem 0x207fff400000-0x207fffcfffff 64bit pref]
> [   15.307584] pci_bus 0000:80: resource 4 [io  0xc000-0xcfff window]
> [   15.313747] pci_bus 0000:80: resource 5 [mem 0xc6000000-0xccbfffff window]
> [   15.320603] pci_bus 0000:80: resource 6 [mem 0x208000000000-0x208fffffffff window]
> [   15.328168] pci_bus 0000:83: resource 4 [io  0xd000-0xdfff window]
> [   15.334335] pci_bus 0000:83: resource 5 [mem 0xccc00000-0xd37fffff window]
> [   15.341190] pci_bus 0000:83: resource 6 [mem 0x209000000000-0x209fffffffff window]
> [   15.348765] pci_bus 0000:97: resource 4 [io  0xe000-0xefff window]
> [   15.354927] pci_bus 0000:97: resource 5 [mem 0xd3800000-0xda3fffff window]
> [   15.361785] pci_bus 0000:97: resource 6 [mem 0x20a000000000-0x20afffffffff window]
> [   15.369359] pci_bus 0000:ac: resource 4 [io  0xf000-0xffff window]
> [   15.375522] pci_bus 0000:ac: resource 5 [mem 0xda400000-0xe0afffff window]
> [   15.382371] pci_bus 0000:ac: resource 6 [mem 0x20b000000000-0x20bfffffffff window]
> [   15.389939] pci_bus 0000:c0: resource 4 [mem 0xe1000000-0xe7bfffff window]
> [   15.396794] pci_bus 0000:c0: resource 5 [mem 0x20c000000000-0x20cfffffffff window]
> [   15.404359] pci_bus 0000:c3: resource 4 [mem 0xe7c00000-0xee7fffff window]
> [   15.411215] pci_bus 0000:c3: resource 5 [mem 0x20d000000000-0x20dfffffffff window]
> [   15.418790] pci_bus 0000:d7: resource 4 [mem 0xee800000-0xf53fffff window]
> [   15.425647] pci_bus 0000:d7: resource 5 [mem 0x20e000000000-0x20efffffffff window]
> [   15.433218] pci_bus 0000:ec: resource 4 [mem 0xf5400000-0xfbafffff window]
> [   15.440076] pci_bus 0000:ec: resource 5 [mem 0x20f000000000-0x20ffffffffff window]
> [   15.447852] NET: Registered protocol family 2
> [   15.452970] tcp_listen_portaddr_hash hash table entries: 65536 (order: 8, 1048576 bytes, vmalloc)
> [   15.462122] TCP established hash table entries: 524288 (order: 10, 4194304 bytes, vmalloc)
> [   15.471084] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, vmalloc)
> [   15.478715] TCP: Hash tables configured (established 524288 bind 65536)
> [   15.485631] UDP hash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
> [   15.493061] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
> [   15.501370] NET: Registered protocol family 1
> [   15.506362] pci 0000:15:05.0: disabled boot interrupts on device [8086:2034]
> [   15.513484] pci 0000:23:05.0: disabled boot interrupts on device [8086:2034]
> [   15.520599] pci 0000:32:05.0: disabled boot interrupts on device [8086:2034]
> [   15.527656] pci 0000:43:05.0: disabled boot interrupts on device [8086:2034]
> [   15.534772] pci 0000:57:05.0: disabled boot interrupts on device [8086:2034]
> [   15.541890] pci 0000:6c:05.0: disabled boot interrupts on device [8086:2034]
> [   15.548935] pci 0000:6d:00.0: CLS mismatch (128 != 32), using 64 bytes
> [   15.555470] pci 0000:83:05.0: disabled boot interrupts on device [8086:2034]
> [   15.562566] pci 0000:97:05.0: disabled boot interrupts on device [8086:2034]
> [   15.569655] pci 0000:ac:05.0: disabled boot interrupts on device [8086:2034]
> [   15.576704] pci 0000:c3:05.0: disabled boot interrupts on device [8086:2034]
> [   15.583801] pci 0000:d7:05.0: disabled boot interrupts on device [8086:2034]
> [   15.590894] pci 0000:ec:05.0: disabled boot interrupts on device [8086:2034]
> [   15.597981] Trying to unpack rootfs image as initramfs...
> [   16.459493] Freeing initrd memory: 57324K
> [   16.463533] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [   16.469966] software IO TLB: mapped [mem 0x587a2000-0x5c7a2000] (64MB)
> [   16.477930] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 655360 ms ovfl timer
> [   16.485831] RAPL PMU: hw unit of domain package 2^-14 Joules
> [   16.491482] RAPL PMU: hw unit of domain dram 2^-16 Joules
> [   16.506481] check: Scanning for low memory corruption every 60 seconds
> [   16.515515] Initialise system trusted keyrings
> [   16.519967] Key type blacklist registered
> [   16.524166] workingset: timestamp_bits=40 max_order=27 bucket_order=0
> [   16.531698] zbud: loaded
> [   16.534709] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [   16.540753] fuse: init (API version 7.31)
> [   16.548302] Key type asymmetric registered
> [   16.552414] Asymmetric key parser 'x509' registered
> [   16.557295] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
> [   16.565005] io scheduler mq-deadline registered
> [   16.569531] io scheduler kyber registered
> [   16.575208] pcieport 0000:00:1c.0: PME: Signaling with IRQ 24
> [   16.581226] pcieport 0000:00:1c.5: PME: Signaling with IRQ 25
> [   16.587318] pcieport 0000:6c:00.0: PME: Signaling with IRQ 27
> [   16.593873] efifb: probing for efifb
> [   16.597479] efifb: framebuffer at 0x91000000, using 1876k, total 1875k
> [   16.603993] efifb: mode is 800x600x32, linelength=3200, pages=1
> [   16.609900] efifb: scrolling: redraw
> [   16.613470] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> [   16.624423] Console: switching to colour frame buffer device 100x37
> [   16.635845] fb0: EFI VGA frame buffer device
> [   16.640265] intel_idle: MWAIT substates: 0x2020
> [   16.640401] Monitor-Mwait will be used to enter C-1 state
> [   16.640489] Monitor-Mwait will be used to enter C-2 state
> [   16.640496] ACPI: \_SB_.SCK0.C000: Found 2 idle states
> [   16.645704] intel_idle: v0.5.1 model 0x55
> [   16.650797] intel_idle: Local APIC timer is reliable in all C-states
> [   16.652329] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> [   16.659908] ACPI: Power Button [PWRF]
> [   16.678008] ERST: Error Record Serialization Table (ERST) support is initialized.
> [   16.685587] pstore: Registered erst as persistent store backend
> [   16.691686] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
> [   16.699551] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> [   16.706077] 00:02: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [   16.713633] 00:03: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> [   16.722868] Linux agpgart interface v0.103
> [   16.732273] tpm_tis IFX0762:00: 2.0 TPM (device-id 0x1B, rev-id 16)
> [   16.822422] loop: module loaded
> [   16.829282] libphy: Fixed MDIO Bus: probed
> [   16.836190] tun: Universal TUN/TAP device driver, 1.6
> [   16.844089] PPP generic driver version 2.4.2
> [   16.851158] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [   16.860495] ehci-pci: EHCI PCI platform driver
> [   16.867796] ehci-platform: EHCI generic platform driver
> [   16.875811] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [   16.884766] ohci-pci: OHCI PCI platform driver
> [   16.892016] ohci-platform: OHCI generic platform driver
> [   16.900020] uhci_hcd: USB Universal Host Controller Interface driver
> [   16.909629] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [   16.917644] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
> [   16.928938] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000000009810
> [   16.943647] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
> [   16.953538] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.07
> [   16.964826] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [   16.975115] usb usb1: Product: xHCI Host Controller
> [   16.983041] usb usb1: Manufacturer: Linux 5.7.6+ xhci-hcd
> [   16.991466] usb usb1: SerialNumber: 0000:00:14.0
> [   16.999201] hub 1-0:1.0: USB hub found
> [   17.005946] hub 1-0:1.0: 16 ports detected
> [   17.014272] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [   17.022464] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
> [   17.032836] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
> [   17.042095] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.07
> [   17.053345] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [   17.063530] usb usb2: Product: xHCI Host Controller
> [   17.071318] usb usb2: Manufacturer: Linux 5.7.6+ xhci-hcd
> [   17.079590] usb usb2: SerialNumber: 0000:00:14.0
> [   17.087137] hub 2-0:1.0: USB hub found
> [   17.093671] hub 2-0:1.0: 10 ports detected
> [   17.100906] usb: port power management may be unreliable
> [   17.109387] i8042: PNP: No PS/2 controller found.
> [   17.116937] mousedev: PS/2 mouse device common for all mice
> [   17.125396] rtc_cmos 00:00: RTC can wake from S4
> [   17.133089] rtc_cmos 00:00: registered as rtc0
> [   17.140425] rtc_cmos 00:00: setting system clock to 2020-07-13T01:15:01 UTC (1594602901)
> [   17.151319] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
> [   17.161774] i2c /dev entries driver
> [   17.168109] device-mapper: uevent: version 1.0.3
> [   17.175597] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27) initialised: dm-devel@redhat.com
> [   17.186872] intel_pstate: Intel P-state driver initializing
> [   17.218306] intel_pstate: HWP enabled
> [   17.233297] ledtrig-cpu: registered to indicate activity on CPUs
> [   17.242177] EFI Variables Facility v0.08 2004-May-17
> [   17.251912] drop_monitor: Initializing network drop monitor service
> [   17.261294] NET: Registered protocol family 10
> [   17.269435] Segment Routing with IPv6
> [   17.275941] NET: Registered protocol family 17
> [   17.283187] Key type dns_resolver registered
> [   17.306053] microcode: sig=0x5065b, pf=0x80, revision=0x700001c
> [   17.322630] microcode: Microcode Update Driver: v2.2.
> [   17.322634] IPI shorthand broadcast: enabled
> [   17.337292] sched_clock: Marking stable (14160999482, 3176284304)->(17654284093, -317000307)
> [   17.346505] usb 1-2: new high-speed USB device number 2 using xhci_hcd
> [   17.358225] registered taskstats version 1
> [   17.365146] Loading compiled-in X.509 certificates
> [   17.373536] Loaded X.509 cert 'Build time autogenerated kernel key: 2621fd24cd5cb190d3a45c4a3990fd12787c67b2'
> [   17.389409] zswap: loaded using pool lzo/zbud
> [   17.397290] pstore: Using crash dump compression: deflate
> [   17.408686] Key type big_key registered
> [   17.416605] Key type trusted registered
> [   17.424426] Key type encrypted registered
> [   17.431222] AppArmor: AppArmor sha1 policy hashing enabled
> [   17.439534] ima: Allocated hash algorithm: sha1
> [   17.483973] ima: No architecture policies found
> [   17.491350] evm: Initialising EVM extended attributes:
> [   17.499327] evm: security.selinux
> [   17.503875] usb 1-2: New USB device found, idVendor=1d6b, idProduct=0107, bcdDevice= 1.00
> [   17.505457] evm: security.SMACK64
> [   17.516536] usb 1-2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [   17.522742] evm: security.SMACK64EXEC
> [   17.522745] evm: security.SMACK64TRANSMUTE
> [   17.530513] tsc: Refined TSC clocksource calibration: 2494.279 MHz
> [   17.530592] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x23f41d64cb8, max_idle_ns: 440795293669 ns
> [   17.532887] usb 1-2: Product: USB Virtual Hub
> [   17.539484] evm: security.SMACK64MMAP
> [   17.546464] usb 1-2: Manufacturer: Aspeed
> [   17.546466] usb 1-2: SerialNumber: 00000000
> [   17.555549] evm: security.apparmor
> [   17.605326] evm: security.ima
> [   17.611018] evm: security.capability
> [   17.617289] evm: HMAC attrs: 0x1
> [   17.623297] clocksource: Switched to clocksource tsc
> [   17.623768] hub 1-2:1.0: USB hub found
> [   17.625197] PM:   Magic number: 12:253:205
> [   17.625497] acpi device:357: hash matches
> [   17.625503] acpi device:32a: hash matches
> [   17.625565] acpi PNP0A08:0a: hash matches
> [   17.625635] acpi device:2d: hash matches
> [   17.625979] memory memory772: hash matches
> [   17.676770] hub 1-2:1.0: 5 ports detected
> [   17.684010] Freeing unused kernel image (initmem) memory: 1780K
> [   17.692240] Write protecting the kernel read-only data: 24576k
> [   17.701416] Freeing unused kernel image (text/rodata gap) memory: 2044K
> [   17.711503] Freeing unused kernel image (rodata/data gap) memory: 2024K
> [   17.720399] Run /init as init process
> [   17.726375]   with arguments:
> [   17.726376]     /init
> [   17.726376]   with environment:
> [   17.726376]     HOME=/
> [   17.726377]     TERM=linux
> [   17.726377]     BOOT_IMAGE=/vmlinuz-5.7.6+
> [   17.726378]     crashkernel=512M-:768M
> [   17.810720] usb 1-5: new high-speed USB device number 3 using xhci_hcd
> [   17.967728] usb 1-5: New USB device found, idVendor=14dd, idProduct=0002, bcdDevice= 0.01
> [   17.978350] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [   17.987919] usb 1-5: Product: Multidevice
> [   17.994347] usb 1-5: Manufacturer: Peppercon AG
> [   18.001295] usb 1-5: SerialNumber: B0BD311A39339843C0C54A0DB8EAECBF
> [   18.062467] hid: raw HID events driver (C) Jiri Kosina
> [   18.066655] usb 1-2.1: new high-speed USB device number 4 using xhci_hcd
> [   18.082914] usbcore: registered new interface driver usbhid
> [   18.090848] usbhid: USB HID core driver
> [   18.102110] input: Peppercon AG Multidevice as /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.0/0003:14DD:0002.0001/input/input1
> [   18.122089] pps_core: LinuxPPS API ver. 1 registered
> [   18.129537] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [   18.144124] ahci 0000:00:11.5: version 3.0
> [   18.144425] ahci 0000:00:11.5: AHCI 0001.0301 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
> [   18.155122] ahci 0000:00:11.5: flags: 64bit ncq sntf pm led clo only pio slum part ems deso sadm sds apst 
> [   18.170624] PTP clock support registered
> [   18.180851] cryptd: max_cpu_qlen set to 1000
> [   18.182759] hid-generic 0003:14DD:0002.0001: input,hidraw0: USB HID v1.01 Keyboard [Peppercon AG Multidevice] on usb-0000:00:14.0-5/input0
> [   18.192006] usb 1-2.1: New USB device found, idVendor=1d6b, idProduct=0104, bcdDevice= 1.00
> [   18.206519] input: Peppercon AG Multidevice as /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.1/0003:14DD:0002.0002/input/input2
> [   18.217551] usb 1-2.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [   18.217552] usb 1-2.1: Product: virtual_input
> [   18.217552] usb 1-2.1: Manufacturer: OpenBMC
> [   18.217553] usb 1-2.1: SerialNumber: OBMC0001
> [   18.218516] scsi host0: ahci
> [   18.235600] hid-generic 0003:14DD:0002.0002: input,hidraw1: USB HID v1.01 Mouse [Peppercon AG Multidevice] on usb-0000:00:14.0-5/input1
> [   18.246371] scsi host1: ahci
> [   18.300367] ata1: SATA max UDMA/133 abar m524288@0x92280000 port 0x92280100 irq 29
> [   18.311436] ata2: SATA max UDMA/133 abar m524288@0x92280000 port 0x92280180 irq 29
> [   18.323099] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0xff impl SATA mode
> [   18.334764] ahci 0000:00:17.0: flags: 64bit ncq sntf ilck pm led clo only pio slum part ems deso sadm sds apst 
> [   18.352218] AVX2 version of gcm_enc/dec engaged.
> [   18.352297] dca service started, version 1.12.1
> [   18.353454] input: OpenBMC virtual_input as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.1/1-2.1:1.0/0003:1D6B:0104.0003/input/input3
> [   18.360352] AES CTR mode by8 optimization enabled
> [   18.410800] hid-generic 0003:1D6B:0104.0003: input,hidraw2: USB HID v1.01 Keyboard [OpenBMC virtual_input] on usb-0000:00:14.0-2.1/input0
> [   18.431658] input: OpenBMC virtual_input as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2.1/1-2.1:1.1/0003:1D6B:0104.0004/input/input4
> [   18.451358] hid-generic 0003:1D6B:0104.0004: input,hidraw3: USB HID v1.01 Mouse [OpenBMC virtual_input] on usb-0000:00:14.0-2.1/input1
> [   18.471613] scsi host2: ahci
> [   18.478356] scsi host3: ahci
> [   18.484957] scsi host4: ahci
> [   18.491543] scsi host5: ahci
> [   18.498129] scsi host6: ahci
> [   18.504609] scsi host7: ahci
> [   18.510998] scsi host8: ahci
> [   18.517265] scsi host9: ahci
> [   18.523289] ata3: SATA max UDMA/133 abar m524288@0x92200000 port 0x92200100 irq 30
> [   18.533969] ata4: SATA max UDMA/133 abar m524288@0x92200000 port 0x92200180 irq 30
> [   18.544547] ata5: SATA max UDMA/133 abar m524288@0x92200000 port 0x92200200 irq 30
> [   18.555011] ata6: SATA max UDMA/133 abar m524288@0x92200000 port 0x92200280 irq 30
> [   18.565377] ata7: SATA max UDMA/133 abar m524288@0x92200000 port 0x92200300 irq 30
> [   18.575623] ata8: SATA max UDMA/133 abar m524288@0x92200000 port 0x92200380 irq 30
> [   18.585792] ata9: SATA max UDMA/133 abar m524288@0x92200000 port 0x92200400 irq 30
> [   18.595945] ata10: SATA max UDMA/133 abar m524288@0x92200000 port 0x92200480 irq 30
> [   18.607300] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 5.1.0-k
> [   18.607301] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.6.0-k
> [   18.607303] igb: Copyright (c) 2007-2014 Intel Corporation.
> [   18.617657] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
> [   18.627408] igb 0000:01:00.0: enabling device (0140 -> 0142)
> [   18.635519] ata2: SATA link down (SStatus 4 SControl 300)
> [   18.635719] ixgbe 0000:6d:00.0: enabling device (0140 -> 0142)
> [   18.668829] ata1: SATA link down (SStatus 4 SControl 300)
> [   18.678953] pps pps0: new PPS source ptp0
> [   18.685545] igb 0000:01:00.0: added PHC on eth0
> [   18.692587] igb 0000:01:00.0: Intel(R) Gigabit Ethernet Network Connection
> [   18.702016] igb 0000:01:00.0: eth0: (PCIe:2.5Gb/s:Width x1) a4:bf:01:70:01:b6
> [   18.711706] igb 0000:01:00.0: eth0: PBA No: 000300-000
> [   18.719238] igb 0000:01:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
> [   18.742755] igb 0000:01:00.0 enp1s0: renamed from eth0
> [   18.750633] checking generic (91000000 1d5000) vs hw (91000000 1000000)
> [   18.750637] fb0: switching to astdrmfb from EFI VGA
> [   18.757954] Console: switching to colour dummy device 80x25
> [   18.763667] [drm] P2A bridge disabled, using default configuration
> [   18.769842] [drm] AST 2500 detected
> [   18.773343] [drm] Analog VGA only
> [   18.776672] [drm] dram MCLK=800 Mhz type=1 bus_width=16 size=01000000
> [   18.783313] [TTM] Zone  kernel: Available graphics memory: 164401722 KiB
> [   18.790020] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
> [   18.796540] [TTM] Initializing pool allocator
> [   18.800895] [TTM] Initializing DMA pool allocator
> [   18.921958] ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [   18.928161] ata9: SATA link down (SStatus 4 SControl 300)
> [   18.933582] ata5: SATA link down (SStatus 4 SControl 300)
> [   18.939014] ata6: SATA link down (SStatus 4 SControl 300)
> [   18.944428] fbcon: astdrmfb (fb0) is primary device
> [   18.944445] ata8: SATA link down (SStatus 4 SControl 300)
> [   18.944463] ata10: SATA link down (SStatus 4 SControl 300)
> [   18.944482] ata3: SATA link down (SStatus 4 SControl 300)
> [   18.944499] ata4: SATA link down (SStatus 4 SControl 300)
> [   18.944523] ata7.00: ATA-10: INTEL SSDSC2KG960G8, XCV10110, max UDMA/133
> [   18.944525] ata7.00: 1875385008 sectors, multi 1: LBA48 NCQ (depth 32)
> [   18.944982] ata7.00: configured for UDMA/133
> [   18.950948] scsi 6:0:0:0: Direct-Access     ATA      INTEL SSDSC2KG96 0110 PQ: 0 ANSI: 5
> [   18.952397] sd 6:0:0:0: Attached scsi generic sg0 type 0
> [   18.952946] ata7.00: Enabling discard_zeroes_data
> [   18.953049] sd 6:0:0:0: [sda] 1875385008 512-byte logical blocks: (960 GB/894 GiB)
> [   18.953050] sd 6:0:0:0: [sda] 4096-byte physical blocks
> [   18.953089] sd 6:0:0:0: [sda] Write Protect is off
> [   18.953090] sd 6:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [   18.953095] sd 6:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [   18.957125] Console: switching to colour frame buffer device 128x48
> [   19.053243] ast 0000:03:00.0: fb0: astdrmfb frame buffer device
> [   19.078946] ata7.00: Enabling discard_zeroes_data
> [   19.086057]  sda: sda1 sda2 sda3
> [   19.090485] ata7.00: Enabling discard_zeroes_data
> [   19.094837] [drm] Initialized ast 0.1.0 20120228 for 0000:03:00.0 on minor 0
> [   19.095407] sd 6:0:0:0: [sda] Attached SCSI disk
> [   19.112357] random: lvm: uninitialized urandom read (4 bytes read)
> [   19.130820] random: lvm: uninitialized urandom read (2 bytes read)
> [   19.348421] ixgbe 0000:6d:00.0: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63 XDP Queue count = 0
> [   19.460872] ixgbe 0000:6d:00.0: 31.504 Gb/s available PCIe bandwidth (8.0 GT/s PCIe x4 link)
> [   19.584847] ixgbe 0000:6d:00.0: MAC: 4, PHY: 0, PBA No: H86377-006
> [   19.591423] ixgbe 0000:6d:00.0: b4:96:91:46:86:a8
> [   19.760928] ixgbe 0000:6d:00.0: Intel(R) 10 Gigabit Network Connection
> [   19.767945] libphy: ixgbe-mdio: probed
> [   19.780470] ixgbe 0000:6d:00.1: enabling device (0140 -> 0142)
> [   20.476018] ixgbe 0000:6d:00.1: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63 XDP Queue count = 0
> [   20.587180] ixgbe 0000:6d:00.1: 31.504 Gb/s available PCIe bandwidth (8.0 GT/s PCIe x4 link)
> [   20.711184] ixgbe 0000:6d:00.1: MAC: 4, PHY: 0, PBA No: H86377-006
> [   20.717771] ixgbe 0000:6d:00.1: b4:96:91:46:86:a9
> [   20.887186] ixgbe 0000:6d:00.1: Intel(R) 10 Gigabit Network Connection
> [   20.894185] libphy: ixgbe-mdio: probed
> [   20.899926] ixgbe 0000:6d:00.0 ens9f0: renamed from eth0
> [   20.943086] ixgbe 0000:6d:00.1 ens9f1: renamed from eth1
> [   21.166694] raid6: avx512x4 gen() 16567 MB/s
> [   21.238696] raid6: avx512x4 xor() 10251 MB/s
> [   21.310698] raid6: avx512x2 gen() 16589 MB/s
> [   21.382693] raid6: avx512x2 xor() 34532 MB/s
> [   21.454694] raid6: avx512x1 gen() 16566 MB/s
> [   21.526697] raid6: avx512x1 xor() 30507 MB/s
> [   21.598689] raid6: avx2x4   gen() 16486 MB/s
> [   21.670697] raid6: avx2x4   xor()  8626 MB/s
> [   21.742701] raid6: avx2x2   gen() 16556 MB/s
> [   21.814695] raid6: avx2x2   xor() 25098 MB/s
> [   21.886687] raid6: avx2x1   gen() 12603 MB/s
> [   21.958699] raid6: avx2x1   xor() 19952 MB/s
> [   22.030685] raid6: sse2x4   gen() 12875 MB/s
> [   22.102694] raid6: sse2x4   xor()  7747 MB/s
> [   22.174692] raid6: sse2x2   gen() 12740 MB/s
> [   22.246701] raid6: sse2x2   xor()  8453 MB/s
> [   22.318694] raid6: sse2x1   gen() 12492 MB/s
> [   22.390699] raid6: sse2x1   xor()  6813 MB/s
> [   22.395311] raid6: using algorithm avx512x2 gen() 16589 MB/s
> [   22.401282] raid6: .... xor() 34532 MB/s, rmw enabled
> [   22.406643] raid6: using avx512x2 recovery algorithm
> [   22.414609] xor: automatically using best checksumming function   avx       
> [   22.427982] async_tx: api initialized (async)
> [   22.452788] random: lvm: uninitialized urandom read (4 bytes read)
> [   22.499747] Btrfs loaded, crc32c=crc32c-intel
> [   22.531785] process '/bin/fstype' started with executable stack
> [   22.551719] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: (null)
> [   22.643394] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
> [   22.695947] random: fast init done
> [   22.783398] systemd[1]: systemd 237 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
> [   22.840304] systemd[1]: Detected architecture x86-64.
> [   22.883983] systemd[1]: Set hostname to <ssp_clx_cdi391>.
> [   22.989699] systemd[1]: File /lib/systemd/system/systemd-journald.service:36 configures an IP firewall (IPAddressDeny=any), but the local system does not support BPF/cgroup based firewalling.
> [   23.010818] systemd[1]: Proceeding WITHOUT firewalling in effect! (This warning is only shown for the first loaded unit using IP firewalling.)
> [   23.049149] systemd[1]: /etc/systemd/system/snapd.service.d/snap_proxy.conf:4: Missing '='.
> [   23.080938] random: systemd: uninitialized urandom read (16 bytes read)
> [   23.092077] systemd[1]: Created slice System Slice.
> [   23.110831] random: systemd: uninitialized urandom read (16 bytes read)
> [   23.117976] systemd[1]: Listening on Journal Socket (/dev/log).
> [   23.138909] systemd[1]: Listening on udev Kernel Socket.
> [   23.158850] systemd[1]: Listening on LVM2 poll daemon socket.
> [   23.548163] Loading iSCSI transport class v2.0-870.
> [   23.568945] iscsi: registered transport (tcp)
> [   23.598204] EXT4-fs (dm-0): re-mounted. Opts: (null)
> [   23.614287] iscsi: registered transport (iser)
> [   23.807968] swapon: swapfile has holes
> [   24.306066] systemd-journald[1512]: Received request to flush runtime journal from PID 1
> [   24.437411] IPMI message handler: version 39.2
> [   24.494999] power_meter ACPI000D:00: Found ACPI power meter.
> [   24.495816] power_meter ACPI000D:00: Ignoring unsafe software power cap!
> [   24.495843] ipmi device interface
> [   24.496136] power_meter ACPI000D:00: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
> [   24.502615] ipmi_si: IPMI System Interface driver
> [   24.502891] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
> [   24.502893] ipmi_platform: ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
> [   24.502894] ipmi_si: Adding SMBIOS-specified kcs state machine
> [   24.503799] ipmi_si IPI0001:00: ipmi_platform: probing via ACPI
> [   24.503814] ipmi_si IPI0001:00: ipmi_platform: [io  0x0ca2-0x0ca3] regsize 1 spacing 1 irq 0
> [   24.503815] ipmi_si dmi-ipmi-si.0: Removing SMBIOS-specified kcs state machine in favor of ACPI
> [   24.503816] ipmi_si: Adding ACPI-specified kcs state machine
> [   24.504732] ipmi_si: Trying ACPI-specified kcs state machine at i/o address 0xca2, slave address 0x20, irq 0
> [   24.717623] ioatdma: Intel(R) QuickData Technology Driver 5.00
> [   24.718225] ioatdma 0000:00:04.0: enabling device (0004 -> 0006)
> [   24.733114] ioatdma 0000:00:04.1: enabling device (0004 -> 0006)
> [   24.745640] ioatdma 0000:00:04.2: enabling device (0004 -> 0006)
> [   24.753908] ioatdma 0000:00:04.3: enabling device (0004 -> 0006)
> [   24.761207] ioatdma 0000:00:04.4: enabling device (0004 -> 0006)
> [   24.769541] ioatdma 0000:00:04.5: enabling device (0004 -> 0006)
> [   24.779266] lpc_ich 0000:00:1f.0: I/O space for ACPI uninitialized
> [   24.779267] lpc_ich 0000:00:1f.0: No MFD cells added
> [   24.779464] ioatdma 0000:00:04.6: enabling device (0004 -> 0006)
> [   24.788609] ioatdma 0000:00:04.7: enabling device (0004 -> 0006)
> [   24.793000] mei_me 0000:00:16.0: Device doesn't have valid ME Interface
> [   24.796171] ioatdma 0000:40:04.0: enabling device (0004 -> 0006)
> [   24.806485] ioatdma 0000:40:04.1: enabling device (0004 -> 0006)
> [   24.814306] ioatdma 0000:40:04.2: enabling device (0004 -> 0006)
> [   24.820992] ioatdma 0000:40:04.3: enabling device (0004 -> 0006)
> [   24.827464] ioatdma 0000:40:04.4: enabling device (0004 -> 0006)
> [   24.834392] ioatdma 0000:40:04.5: enabling device (0004 -> 0006)
> [   24.840857] ioatdma 0000:40:04.6: enabling device (0004 -> 0006)
> [   24.847475] ioatdma 0000:40:04.7: enabling device (0004 -> 0006)
> [   24.854042] ioatdma 0000:80:04.0: enabling device (0004 -> 0006)
> [   24.863727] ioatdma 0000:80:04.1: enabling device (0004 -> 0006)
> [   24.871113] ioatdma 0000:80:04.2: enabling device (0004 -> 0006)
> [   24.877372] ioatdma 0000:80:04.3: enabling device (0004 -> 0006)
> [   24.884084] ioatdma 0000:80:04.4: enabling device (0004 -> 0006)
> [   24.890571] ioatdma 0000:80:04.5: enabling device (0004 -> 0006)
> [   24.890703] ipmi_si IPI0001:00: The BMC does not support clearing the recv irq bit, compensating, but the BMC needs to be fixed.
> [   24.897757] ioatdma 0000:80:04.6: enabling device (0004 -> 0006)
> [   24.903505] ioatdma 0000:80:04.7: enabling device (0004 -> 0006)
> [   24.908744] pstore: ignoring unexpected backend 'efi'
> [   24.909914] ioatdma 0000:c0:04.0: enabling device (0004 -> 0006)
> [   24.920021] ioatdma 0000:c0:04.1: enabling device (0004 -> 0006)
> [   24.929095] ioatdma 0000:c0:04.2: enabling device (0004 -> 0006)
> [   24.938541] ioatdma 0000:c0:04.3: enabling device (0004 -> 0006)
> [   24.948251] ioatdma 0000:c0:04.4: enabling device (0004 -> 0006)
> [   24.957287] ioatdma 0000:c0:04.5: enabling device (0004 -> 0006)
> [   24.965213] ioatdma 0000:c0:04.6: enabling device (0004 -> 0006)
> [   24.973148] ioatdma 0000:c0:04.7: enabling device (0004 -> 0006)
> [   25.126247] ipmi_si IPI0001:00: IPMI message handler: Found new BMC (man_id: 0x000157, prod_id: 0x009d, dev_id: 0x23)
> [   25.137772] EDAC MC0: Giving out device to module skx_edac controller Skylake Socket#0 IMC#0: DEV 0000:23:0a.0 (INTERRUPT)
> [   25.139660] EDAC MC1: Giving out device to module skx_edac controller Skylake Socket#0 IMC#1: DEV 0000:23:0c.0 (INTERRUPT)
> [   25.141569] EDAC MC2: Giving out device to module skx_edac controller Skylake Socket#1 IMC#0: DEV 0000:57:0a.0 (INTERRUPT)
> [   25.143545] EDAC MC3: Giving out device to module skx_edac controller Skylake Socket#1 IMC#1: DEV 0000:57:0c.0 (INTERRUPT)
> [   25.146823] EDAC MC4: Giving out device to module skx_edac controller Skylake Socket#2 IMC#0: DEV 0000:97:0a.0 (INTERRUPT)
> [   25.148615] EDAC MC5: Giving out device to module skx_edac controller Skylake Socket#2 IMC#1: DEV 0000:97:0c.0 (INTERRUPT)
> [   25.152571] EDAC MC6: Giving out device to module skx_edac controller Skylake Socket#3 IMC#0: DEV 0000:d7:0a.0 (INTERRUPT)
> [   25.157823] EDAC MC7: Giving out device to module skx_edac controller Skylake Socket#3 IMC#1: DEV 0000:d7:0c.0 (INTERRUPT)
> [   25.290190] intel_rapl_common: Found RAPL domain package
> [   25.290194] intel_rapl_common: Found RAPL domain dram
> [   25.290195] intel_rapl_common: DRAM domain energy unit 15300pj
> [   25.291652] intel_rapl_common: Found RAPL domain package
> [   25.291656] intel_rapl_common: Found RAPL domain dram
> [   25.291657] intel_rapl_common: DRAM domain energy unit 15300pj
> [   25.292226] intel_rapl_common: Found RAPL domain package
> [   25.292230] intel_rapl_common: Found RAPL domain dram
> [   25.292231] intel_rapl_common: DRAM domain energy unit 15300pj
> [   25.292863] intel_rapl_common: Found RAPL domain package
> [   25.292870] intel_rapl_common: Found RAPL domain dram
> [   25.292872] intel_rapl_common: DRAM domain energy unit 15300pj
> [   25.574964] ipmi_si IPI0001:00: IPMI kcs interface initialized
> [   25.577234] ipmi_ssif: IPMI SSIF Interface driver
> [   25.594902] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
> [   25.619499] FAT-fs (sda1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
> [   25.851473] audit: type=1400 audit(1594602910.206:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/lxc-start" pid=4764 comm="apparmor_parser"
> [   25.854466] audit: type=1400 audit(1594602910.206:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=4765 comm="apparmor_parser"
> [   25.854468] audit: type=1400 audit(1594602910.206:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=4765 comm="apparmor_parser"
> [   25.854469] audit: type=1400 audit(1594602910.206:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=4765 comm="apparmor_parser"
> [   25.856163] audit: type=1400 audit(1594602910.210:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/snapd/snap-confine" pid=4766 comm="apparmor_parser"
> [   25.856166] audit: type=1400 audit(1594602910.210:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/snapd/snap-confine//mount-namespace-capture-helper" pid=4766 comm="apparmor_parser"
> [   25.857153] audit: type=1400 audit(1594602910.210:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/tcpdump" pid=4768 comm="apparmor_parser"
> [   25.859144] audit: type=1400 audit(1594602910.214:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lxc-container-default" pid=4762 comm="apparmor_parser"
> [   25.859146] audit: type=1400 audit(1594602910.214:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lxc-container-default-cgns" pid=4762 comm="apparmor_parser"
> [   25.859148] audit: type=1400 audit(1594602910.214:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lxc-container-default-with-mounting" pid=4762 comm="apparmor_parser"
> [   26.372887] random: crng init done
> [   26.372890] random: 5 urandom warning(s) missed due to ratelimiting
> [   29.903345] igb 0000:01:00.0 enp1s0: igb: enp1s0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
> [   29.903653] IPv6: ADDRCONF(NETDEV_CHANGE): enp1s0: link becomes ready
> [   34.417764] new mount options do not match the existing superblock, will be ignored
> [  128.500959] core sched enabled
> [  128.593222] core sched disabled
> [  139.711143] core sched enabled
> [  141.774846] NOHZ: local_softirq_pending 0a
> [  141.782905] NOHZ: local_softirq_pending 0a
> [  141.790973] NOHZ: local_softirq_pending 20a
> [  141.794644] NOHZ: local_softirq_pending 20a
> [  141.798640] NOHZ: local_softirq_pending 20a
> [  141.798641] NOHZ: local_softirq_pending 20a
> [  141.826902] NOHZ: local_softirq_pending 0a
> [  141.830641] NOHZ: local_softirq_pending 0a
> [  141.894765] NOHZ: local_softirq_pending 0a
> [  141.922850] NOHZ: local_softirq_pending 208
> [  170.634633] watchdog: BUG: soft lockup - CPU#75 stuck for 22s! [uperf:5393]
> [  170.641614] Modules linked in: binfmt_misc ipmi_ssif intel_rapl_msr intel_rapl_common skx_edac nfit x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass joydev efi_pstore input_leds mei_me lpc_ich mei ioatdma ipmi_si ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter mac_hid sch_fq_codel ib_iser rdma_cm iw_cm ib_cm ib_core configfs iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi ip_tables x_tables autofs4 btrfs blake2b_generic zstd_decompress zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear ast drm_vram_helper drm_ttm_helper ttm crct10dif_pclmul ixgbe drm_kms_helper crc32_pclmul igb ghash_clmulni_intel aesni_intel syscopyarea crypto_simd sysfillrect dca cryptd sysimgblt glue_helper fb_sys_fops ptp mdio ahci pps_core drm i2c_algo_bit libahci wmi hid_generic usbhid hid
> [  170.641645] CPU: 75 PID: 5393 Comm: uperf Kdump: loaded Not tainted 5.7.6+ #3
> [  170.641646] Hardware name: Intel Corporation CooperCity/CooperCity, BIOS WLYDCRB1.SYS.0016.P38.2006170234 06/17/2020
> [  170.641651] RIP: 0010:smp_call_function_many_cond+0x2b1/0x2e0
> [  170.641653] Code: c7 e8 d3 c5 3c 00 3b 05 71 1b 86 01 0f 83 e8 fd ff ff 48 63 c8 48 8b 13 48 03 14 cd 20 29 58 90 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c6 0f 0b e9 97 fd ff ff 48 c7 c2 e0 80
> [  170.641654] RSP: 0018:ffffb115617afca0 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [  170.641655] RAX: 0000000000000014 RBX: ffff9e559016dc40 RCX: 0000000000000001
> [  170.641655] RDX: ffff9e6d8f4b44c0 RSI: 0000000000000000 RDI: ffff9e559016dc48
> [  170.641656] RBP: 000000000000005b R08: 0000000000000000 R09: 0000000000000014
> [  170.641656] R10: 0000000000000007 R11: 0000000000000008 R12: ffffffff8f078800
> [  170.641656] R13: 0000000000000001 R14: ffff9e559016c600 R15: 0000000000000200
> [  170.641657] FS:  00007f0051ffb700(0000) GS:ffff9e5590140000(0000) knlGS:0000000000000000
> [  170.641657] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  170.641658] CR2: 00007f00678b9400 CR3: 00000017e5fb0001 CR4: 00000000007606e0
> [  170.641659] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  170.641659] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  170.641659] PKRU: 55555554
> [  170.641660] Call Trace:
> [  170.641666]  ? flush_tlb_func_common.constprop.10+0x220/0x220
> [  170.641668]  ? x86_configure_nx+0x50/0x50
> [  170.641669]  ? flush_tlb_func_common.constprop.10+0x220/0x220
> [  170.641670]  on_each_cpu_cond_mask+0x2f/0x80
> [  170.641671]  flush_tlb_mm_range+0xab/0xe0
> [  170.641677]  change_protection+0x18a/0xca0
> [  170.641682]  ? __switch_to_asm+0x34/0x70
> [  170.641685]  change_prot_numa+0x15/0x30
> [  170.641689]  task_numa_work+0x1aa/0x2c0
> [  170.641694]  task_work_run+0x76/0xa0
> [  170.641698]  exit_to_usermode_loop+0xeb/0xf0
> [  170.641700]  do_syscall_64+0x1aa/0x1d0
> [  170.641701]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  170.641703] RIP: 0033:0x7f00676ac2c7
> [  170.641704] Code: 44 00 00 41 54 55 49 89 d4 53 48 89 f5 89 fb 48 83 ec 10 e8 5b fd ff ff 4c 89 e2 41 89 c0 48 89 ee 89 df b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 94 fd ff ff 48
> [  170.641705] RSP: 002b:00007f0051ffa9b0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> [  170.641705] RAX: 000000000000005a RBX: 000000000000002a RCX: 00007f00676ac2c7
> [  170.641706] RDX: 000000000000005a RSI: 00007f0030000b20 RDI: 000000000000002a
> [  170.641706] RBP: 00007f0030000b20 R08: 0000000000000000 R09: 0000563ccd7ca0b4
> [  170.641707] R10: 0000000000000000 R11: 0000000000000293 R12: 000000000000005a
> [  170.641707] R13: 00007f006804e228 R14: 0000000000000000 R15: 0000000000000000
> [  170.641710] Sending NMI from CPU 75 to CPUs 0-74,76-143:
> [  170.641749] NMI backtrace for cpu 0
> [  170.641749] CPU: 0 PID: 5406 Comm: uperf Kdump: loaded Not tainted 5.7.6+ #3
> [  170.641749] Hardware name: Intel Corporation CooperCity/CooperCity, BIOS WLYDCRB1.SYS.0016.P38.2006170234 06/17/2020
> [  170.641750] RIP: 0010:smp_call_function_many_cond+0x2b1/0x2e0
> [  170.641750] Code: c7 e8 d3 c5 3c 00 3b 05 71 1b 86 01 0f 83 e8 fd ff ff 48 63 c8 48 8b 13 48 03 14 cd 20 29 58 90 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c6 0f 0b e9 97 fd ff ff 48 c7 c2 e0 80
> [  170.641751] RSP: 0018:ffffb11561c3fca0 EFLAGS: 00000202
> [  170.641752] RAX: 000000000000005b RBX: ffff9e558fc2dc40 RCX: 0000000000000001
> [  170.641752] RDX: ffff9e6d8f8f20c0 RSI: 0000000000000000 RDI: ffff9e558fc2dc48
> [  170.641752] RBP: 000000000000005d R08: 0000000000000000 R09: 000000000000001b
> [  170.641753] R10: 0000000000000001 R11: 0000000000000008 R12: ffffffff8f078800
> [  170.641753] R13: 0000000000000001 R14: ffff9e558fc2c600 R15: 0000000000000200
> [  170.641753] FS:  00007fed9d743700(0000) GS:ffff9e558fc00000(0000) knlGS:0000000000000000
> [  170.641753] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  170.641754] CR2: 00007f002f7fea08 CR3: 00000017eb8b8001 CR4: 00000000007606f0
> [  170.641754] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  170.641754] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  170.641754] PKRU: 55555554
> [  170.641754] Call Trace:
> [  170.641755]  ? flush_tlb_func_common.constprop.10+0x220/0x220
> [  170.641755]  ? x86_configure_nx+0x50/0x50
> [  170.641755]  ? flush_tlb_func_common.constprop.10+0x220/0x220
> [  170.641755]  on_each_cpu_cond_mask+0x2f/0x80
> [  170.641755]  flush_tlb_mm_range+0xab/0xe0
> [  170.641756]  change_protection+0x18a/0xca0
> [  170.641756]  change_prot_numa+0x15/0x30
> [  170.641756]  task_numa_work+0x1aa/0x2c0
> [  170.641756]  task_work_run+0x76/0xa0
> [  170.641756]  exit_to_usermode_loop+0xeb/0xf0
> [  170.641757]  do_syscall_64+0x1aa/0x1d0
> [  170.641757]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  170.641757] RIP: 0033:0x7feda134d394
> [  170.641757] Code: 84 00 00 00 00 00 41 54 55 49 89 d4 53 48 89 f5 89 fb 48 83 ec 10 e8 8b fc ff ff 4c 89 e2 41 89 c0 48 89 ee 89 df 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 38 44 89 c7 48 89 44 24 08 e8 c7 fc ff ff 48
> [  170.641758] RSP: 002b:00007fed9d742980 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [  170.641758] RAX: 000000000000005a RBX: 0000000000000031 RCX: 00007feda134d394
> [  170.641758] RDX: 000000000000005a RSI: 00007fed78000b20 RDI: 0000000000000031
> [  170.641759] RBP: 00007fed78000b20 R08: 0000000000000000 R09: 00007ffcfe964080
> [  170.641759] R10: 00007fed9d742dd0 R11: 0000000000000246 R12: 000000000000005a
> [  170.641759] R13: 00007feda1d15d50 R14: 0000000000000000 R15: 0000000000000000
> [  170.641842] NMI backtrace for cpu 1
> [  170.641844] CPU: 1 PID: 5412 Comm: uperf Kdump: loaded Not tainted 5.7.6+ #3
> [  170.641845] Hardware name: Intel Corporation CooperCity/CooperCity, BIOS WLYDCRB1.SYS.0016.P38.2006170234 06/17/2020
> [  170.641847] RIP: 0010:smp_call_function_many_cond+0x2b1/0x2e0
> [  170.641848] Code: c7 e8 d3 c5 3c 00 3b 05 71 1b 86 01 0f 83 e8 fd ff ff 48 63 c8 48 8b 13 48 03 14 cd 20 29 58 90 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c6 0f 0b e9 97 fd ff ff 48 c7 c2 e0 80
> [  170.641849] RSP: 0018:ffffb11561c6fca0 EFLAGS: 00000202
> [  170.641852] RAX: 000000000000005b RBX: ffff9e558fc6dc40 RCX: 0000000000000001
> [  170.641854] RDX: ffff9e6d8f8f38c0 RSI: 0000000000000000 RDI: ffff9e558fc6dc48
> [  170.641855] RBP: 000000000000005d R08: 0000000000000000 R09: 000000000000001b
> [  170.641857] R10: 0000000000000001 R11: 0000000000000008 R12: ffffffff8f078800
> [  170.641858] R13: 0000000000000001 R14: ffff9e558fc6c600 R15: 0000000000000200
> [  170.641863] FS:  00007fed7dffb700(0000) GS:ffff9e558fc40000(0000) knlGS:0000000000000000
> [  170.641864] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  170.641866] CR2: 00007f0058000b20 CR3: 00000017eb8b8004 CR4: 00000000007606e0
> [  170.641867] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  170.641869] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  170.641870] PKRU: 55555554
> [  170.641872] Call Trace:
> [  170.641873]  ? flush_tlb_func_common.constprop.10+0x220/0x220
> [  170.641875]  ? x86_configure_nx+0x50/0x50
> [  170.641876]  ? flush_tlb_func_common.constprop.10+0x220/0x220
> [  170.641877]  on_each_cpu_cond_mask+0x2f/0x80
> [  170.641879]  flush_tlb_mm_range+0xab/0xe0
> [  170.641880]  change_protection+0x18a/0xca0
> [  170.641882]  change_prot_numa+0x15/0x30
> [  170.641883]  task_numa_work+0x1aa/0x2c0
> [  170.641885]  task_work_run+0x76/0xa0
> [  170.641886]  exit_to_usermode_loop+0xeb/0xf0
> [  170.641888]  do_syscall_64+0x1aa/0x1d0
> [  170.641889]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  170.641890] RIP: 0033:0x7feda134d394
> [  170.641892] Code: 84 00 00 00 00 00 41 54 55 49 89 d4 53 48 89 f5 89 fb 48 83 ec 10 e8 8b fc ff ff 4c 89 e2 41 89 c0 48 89 ee 89 df 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 38 44 89 c7 48 89 44 24 08 e8 c7 fc ff ff 48
> [  170.641894] RSP: 002b:00007fed7dffa980 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [  170.641896] RAX: 000000000000005a RBX: 0000000000000043 RCX: 00007feda134d394
> [  170.641898] RDX: 000000000000005a RSI: 00007fed5c000b20 RDI: 0000000000000043
> [  170.641899] RBP: 00007fed5c000b20 R08: 0000000000000000 R09: 00007ffcfe964080
> [  170.641901] R10: 00007fed7dffadd0 R11: 0000000000000246 R12: 000000000000005a
> [  170.641902] R13: 00007feda1d166e0 R14: 0000000000000000 R15: 0000000000000000
> [  170.641917] NMI backtrace for cpu 2 skipped: idling at intel_idle+0x85/0x130
> [  170.642016] NMI backtrace for cpu 3 skipped: idling at intel_idle+0x85/0x130
> [  170.642201] NMI backtrace for cpu 4
> [  170.642202] CPU: 4 PID: 1512 Comm: systemd-journal Kdump: loaded Not tainted 5.7.6+ #3
> [  170.642203] Hardware name: Intel Corporation CooperCity/CooperCity, BIOS WLYDCRB1.SYS.0016.P38.2006170234 06/17/2020
> [  170.642204] RIP: 0010:memset_erms+0x9/0x10
> [  170.642206] Code: c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 f3 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 <f3> aa 4c 89 c8 c3 90 49 89 fa 40 0f b6 ce 48 b8 01 01 01 01 01 01
> [  170.642206] RSP: 0018:ffffb115603a7da8 EFLAGS: 00010246
> [  170.642208] RAX: ffff9e7da8114900 RBX: 0000000000000000 RCX: 0000000000000fc0
> [  170.642209] RDX: 0000000000004000 RSI: 0000000000000000 RDI: ffffb1156038b040
> [  170.642210] RBP: ffffb115603a7e50 R08: ffffd0dd1fd19350 R09: ffffb11560388000
> [  170.642211] R10: 00007ff8b36aa9d0 R11: 0000000000000000 R12: 00000000003d0f00
> [  170.642212] R13: 00000000ffffffff R14: ffff9e5587749640 R15: ffffb115603a7ec8
> [  170.642213] FS:  00007ff8b8c98940(0000) GS:ffff9e558fd00000(0000) knlGS:0000000000000000
> [  170.642213] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  170.642214] CR2: 00007ff8b36a9db8 CR3: 000000501eef6005 CR4: 00000000007606e0
> [  170.642215] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  170.642216] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  170.642217] PKRU: 55555554
> [  170.642219] Call Trace:
> [  170.642221]  copy_process+0x22c/0x19f0
> [  170.642223]  ? mem_cgroup_throttle_swaprate+0x19/0x140
> [  170.642224]  _do_fork+0x74/0x3b0
> [  170.642226]  __do_sys_clone+0x7e/0xb0
> [  170.642228]  do_syscall_64+0x52/0x1d0
> [  170.642230]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  170.642231] RIP: 0033:0x7ff8b87bda31
> [  170.642234] Code: 48 85 ff 74 3d 48 85 f6 74 38 48 83 ee 10 48 89 4e 08 48 89 3e 48 89 d7 4c 89 c2 4d 89 c8 4c 8b 54 24 08 b8 38 00 00 00 0f 05 <48> 85 c0 7c 13 74 01 c3 31 ed 58 5f ff d0 48 89 c7 b8 3c 00 00 00
> [  170.642235] RSP: 002b:00007fff9a239518 EFLAGS: 00000202 ORIG_RAX: 0000000000000038
> [  170.642239] RAX: ffffffffffffffda RBX: 00007ff8b36aa700 RCX: 00007ff8b87bda31
> [  170.642241] RDX: 00007ff8b36aa9d0 RSI: 00007ff8b36a9db0 RDI: 00000000003d0f00
> [  170.642243] RBP: 00007fff9a2395f0 R08: 00007ff8b36aa700 R09: 00007ff8b36aa700
> [  170.642244] R10: 00007ff8b36aa9d0 R11: 0000000000000202 R12: 00007ff8b36a9dc0
> [  170.642246] R13: 0000000000000000 R14: 000056283a684980 R15: 00007fff9a239580
> [  170.642273] NMI backtrace for cpu 5 skipped: idling at intel_idle+0x85/0x130
> [  170.642333] NMI backtrace for cpu 6 skipped: idling at intel_idle+0x85/0x130
> [  170.642476] NMI backtrace for cpu 7 skipped: idling at intel_idle+0x85/0x130
> [  170.642529] NMI backtrace for cpu 8 skipped: idling at intel_idle+0x85/0x130
> [  170.642665] NMI backtrace for cpu 9
> [  170.642667] CPU: 9 PID: 0 Comm: swapper/9 Kdump: loaded Not tainted 5.7.6+ #3
> [  170.642668] Hardware name: Intel Corporation CooperCity/CooperCity, BIOS WLYDCRB1.SYS.0016.P38.2006170234 06/17/2020
> [  170.642668] RIP: 0010:cpu_startup_entry+0x14/0x20
> [  170.642670] Code: e0 9e 9f 8f 72 0a 48 81 ff 86 a7 9f 8f 0f 92 c0 f3 c3 0f 1f 40 00 0f 1f 44 00 00 53 89 fb e8 b3 fb ff ff 89 df e8 0c 71 fc ff <e8> 07 fc ff ff eb f9 cc cc cc cc cc 0f 1f 44 00 00 48 8b 8f 58 04
> [  170.642671] RSP: 0018:ffffb115401f7f28 EFLAGS: 00000286
> [  170.642673] RAX: 0000000000000000 RBX: 000000000000008e RCX: 0000000000000000
> [  170.642674] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9e558fe6ccc0
> [  170.642675] RBP: 0000000000000000 R08: 0000000000000000 R09: ffff9e558ac58000
> [  170.642676] R10: 0000000000000007 R11: ffff9e558b138a00 R12: 0000000000000000
> [  170.642676] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  170.642677] FS:  0000000000000000(0000) GS:ffff9e558fe40000(0000) knlGS:0000000000000000
> [  170.642678] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  170.642679] CR2: 000055ed9a8a4e04 CR3: 00000017eb532004 CR4: 00000000007606e0
> [  170.642680] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  170.642681] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  170.642681] PKRU: 55555554
> [  170.642682] Call Trace:
> [  170.642682]  start_secondary+0x169/0x1c0
> [  170.642683]  secondary_startup_64+0xb6/0xc0
> [  170.642769] NMI backtrace for cpu 10 skipped: idling at intel_idle+0x85/0x130
> [  170.642868] NMI backtrace for cpu 11 skipped: idling at intel_idle+0x85/0x130
> [  170.642969] NMI backtrace for cpu 12 skipped: idling at intel_idle+0x85/0x130
> [  170.643067] NMI backtrace for cpu 13 skipped: idling at intel_idle+0x85/0x130
> [  170.643171] NMI backtrace for cpu 14 skipped: idling at intel_idle+0x85/0x130
> [  170.643268] NMI backtrace for cpu 15 skipped: idling at intel_idle+0x85/0x130
> [  170.643372] NMI backtrace for cpu 16 skipped: idling at intel_idle+0x85/0x130
> [  170.643473] NMI backtrace for cpu 17 skipped: idling at intel_idle+0x85/0x130
> [  170.643555] NMI backtrace for cpu 18
> [  170.643556] CPU: 18 PID: 5389 Comm: uperf Kdump: loaded Not tainted 5.7.6+ #3
> [  170.643556] Hardware name: Intel Corporation CooperCity/CooperCity, BIOS WLYDCRB1.SYS.0016.P38.2006170234 06/17/2020
> [  170.643557] RIP: 0010:smp_call_function_many_cond+0x2b1/0x2e0
> [  170.643558] Code: c7 e8 d3 c5 3c 00 3b 05 71 1b 86 01 0f 83 e8 fd ff ff 48 63 c8 48 8b 13 48 03 14 cd 20 29 58 90 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c6 0f 0b e9 97 fd ff ff 48 c7 c2 e0 80
> [  170.643558] RSP: 0018:ffffb1156178fca0 EFLAGS: 00000202
> [  170.643559] RAX: 0000000000000014 RBX: ffff9e6d8f42dc40 RCX: 0000000000000001
> [  170.643560] RDX: ffff9e6d8f4b3da0 RSI: 0000000000000000 RDI: ffff9e6d8f42dc48
> [  170.643560] RBP: 000000000000005a R08: 0000000000000000 R09: 0000000000000014
> [  170.643560] R10: 0000000000000007 R11: 0000000000000008 R12: ffffffff8f078800
> [  170.643560] R13: 0000000000000001 R14: ffff9e6d8f42c600 R15: 0000000000000200
> [  170.643561] FS:  00007f0053fff700(0000) GS:ffff9e6d8f400000(0000) knlGS:0000000000000000
> [  170.643561] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  170.643561] CR2: 00007f0054002e58 CR3: 00000017e5fb0002 CR4: 00000000007606e0
> [  170.643561] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  170.643562] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  170.643562] PKRU: 55555554
> [  170.643562] Call Trace:
> [  170.643562]  ? flush_tlb_func_common.constprop.10+0x220/0x220
> [  170.643562]  ? x86_configure_nx+0x50/0x50
> [  170.643563]  ? flush_tlb_func_common.constprop.10+0x220/0x220
> [  170.643563]  on_each_cpu_cond_mask+0x2f/0x80
> [  170.643563]  flush_tlb_mm_range+0xab/0xe0
> [  170.643563]  change_protection+0x18a/0xca0
> [  170.643564]  change_prot_numa+0x15/0x30
> [  170.643564]  task_numa_work+0x1aa/0x2c0
> [  170.643564]  task_work_run+0x76/0xa0
> [  170.643565]  exit_to_usermode_loop+0xeb/0xf0
> [  170.643565]  do_syscall_64+0x1aa/0x1d0
> [  170.643565]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  170.643566] RIP: 0033:0x7f00676ac394
> [  170.643566] Code: 84 00 00 00 00 00 41 54 55 49 89 d4 53 48 89 f5 89 fb 48 83 ec 10 e8 8b fc ff ff 4c 89 e2 41 89 c0 48 89 ee 89 df 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 38 44 89 c7 48 89 44 24 08 e8 c7 fc ff ff 48
> [  170.643566] RSP: 002b:00007f0053ffe980 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [  170.643567] RAX: 000000000000005a RBX: 0000000000000028 RCX: 00007f00676ac394
> [  170.643567] RDX: 000000000000005a RSI: 00007f0040000b20 RDI: 0000000000000028
> [  170.643567] RBP: 00007f0040000b20 R08: 0000000000000000 R09: 0000563ccd7ca0b4
> [  170.643568] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000005a
> [  170.643568] R13: 00007f006804dbc8 R14: 0000000000000004 R15: 0000000000000000
> [  170.643678] NMI backtrace for cpu 19
> [  170.643678] CPU: 19 PID: 5385 Comm: uperf Kdump: loaded Not tainted 5.7.6+ #3
> [  170.643679] Hardware name: Intel Corporation CooperCity/CooperCity, BIOS WLYDCRB1.SYS.0016.P38.2006170234 06/17/2020
> [  170.643679] RIP: 0010:native_queued_spin_lock_slowpath+0x137/0x1e0
> [  170.643680] Code: 6a ff ff ff 41 83 c0 01 c1 e1 10 41 c1 e0 12 44 09 c1 89 c8 c1 e8 10 66 87 47 02 89 c6 c1 e6 10 85 f6 75 3c 31 f6 eb 02 f3 90 <8b> 07 66 85 c0 75 f7 41 89 c0 66 45 31 c0 44 39 c1 74 7e 48 85 f6
> [  170.643681] RSP: 0018:ffffb1154d43ce78 EFLAGS: 00000202
> [  170.643681] RAX: 0000000000500101 RBX: ffff9e555dea2948 RCX: 0000000000500000
> [  170.643681] RDX: ffff9e6d8f46d9c0 RSI: 0000000000000000 RDI: ffff9e555dea2588
> [  170.643682] RBP: ffff9e555dea2588 R08: 0000000000500000 R09: ffff9e6d8f45dc28
> [  170.643682] R10: ffffb1154d43cef8 R11: ffff9e6d8f45dc70 R12: ffff9e555dea2500
> [  170.643682] R13: ffff9e555dea2580 R14: 0000000000000001 R15: ffff9e555dea2948
> [  170.643683] FS:  00007f00662a7700(0000) GS:ffff9e6d8f440000(0000) knlGS:0000000000000000
> [  170.643683] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  170.643683] CR2: 00007f00678b9400 CR3: 00000017e5fb0003 CR4: 00000000007606e0
> [  170.643683] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  170.643684] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  170.643684] PKRU: 55555554
> [  170.643684] Call Trace:
> [  170.643684]  <IRQ>
> [  170.643684]  _raw_spin_lock+0x1b/0x20
> [  170.643685]  tcp_delack_timer+0x2c/0xf0
> [  170.643685]  ? tcp_delack_timer_handler+0x170/0x170
> [  170.643685]  call_timer_fn+0x2d/0x130
> [  170.643685]  run_timer_softirq+0x420/0x450
> [  170.643686]  ? enqueue_hrtimer+0x39/0x90
> [  170.643686]  ? __hrtimer_run_queues+0x138/0x290
> [  170.643686]  __do_softirq+0xed/0x2f0
> [  170.643686]  irq_exit+0xad/0xb0
> [  170.643686]  smp_apic_timer_interrupt+0x74/0x130
> [  170.643687]  apic_timer_interrupt+0xf/0x20
> [  170.643687]  </IRQ>
> [  170.643687] RIP: 0010:do_softirq.part.18+0x29/0x50
> [  170.643688] Code: 90 0f 1f 44 00 00 53 9c 58 0f 1f 44 00 00 48 89 c3 fa 66 0f 1f 44 00 00 65 66 8b 3d 81 80 f9 70 66 85 ff 75 0c 48 89 df 57 9d <0f> 1f 44 00 00 5b c3 0f b7 ff e8 a8 fc ff ff 84 c0 75 e8 e8 bf ca
> [  170.643688] RSP: 0018:ffffb1156174fac8 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [  170.643688] RAX: ffff9e555de3ac80 RBX: 0000000000000202 RCX: ffff9e6d8f46ccc0
> [  170.643689] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000202
> [  170.643691] RBP: ffffb1156174fb30 R08: 0000000000000001 R09: 0000000000000101
> [  170.643694] R10: ffffb1154d43cb08 R11: 0000000000000320 R12: ffff9e6d733c2ae0
> [  170.643696] R13: 0000000000000010 R14: 000000000000000e R15: 0000000000000000
> [  170.643698]  __local_bh_enable_ip+0x4b/0x50
> [  170.643701]  ip_finish_output2+0x1af/0x5a0
> [  170.643703]  ? __switch_to_asm+0x34/0x70
> [  170.643705]  ? __switch_to_asm+0x40/0x70
> [  170.643707]  ? ip_output+0x6d/0xe0
> [  170.643709]  ip_output+0x6d/0xe0
> [  170.643711]  ? __ip_finish_output+0x1c0/0x1c0
> [  170.643713]  __ip_queue_xmit+0x14d/0x3d0
> [  170.643716]  __tcp_transmit_skb+0x594/0xb20
> [  170.643718]  tcp_write_xmit+0x241/0x1150
> [  170.643720]  __tcp_push_pending_frames+0x32/0xf0
> [  170.643722]  tcp_sendmsg_locked+0x50f/0xd30
> [  170.643724]  tcp_sendmsg+0x27/0x40
> [  170.643726]  sock_sendmsg+0x3e/0x60
> [  170.643728]  sock_write_iter+0x97/0x100
> [  170.643730]  new_sync_write+0x1b6/0x1d0
> [  170.643732]  vfs_write+0xad/0x1b0
> [  170.643734]  ksys_write+0x50/0xe0
> [  170.643736]  do_syscall_64+0x52/0x1d0
> [  170.643738]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  170.643740] RIP: 0033:0x7f00676ac2c7
> [  170.643742] Code: 44 00 00 41 54 55 49 89 d4 53 48 89 f5 89 fb 48 83 ec 10 e8 5b fd ff ff 4c 89 e2 41 89 c0 48 89 ee 89 df b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 94 fd ff ff 48
> [  170.643744] RSP: 002b:00007f00662a69b0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> [  170.643748] RAX: ffffffffffffffda RBX: 0000000000000026 RCX: 00007f00676ac2c7
> [  170.643750] RDX: 000000000000005a RSI: 00007f005c000b20 RDI: 0000000000000026
> [  170.643752] RBP: 00007f005c000b20 R08: 0000000000000000 R09: 0000563ccd7ca0b4
> [  170.643754] R10: 0000000000000000 R11: 0000000000000293 R12: 000000000000005a
> [  170.643756] R13: 00007f006804d568 R14: 0000000000000000 R15: 0000000000000000
> [  170.643759] NMI backtrace for cpu 21 skipped: idling at intel_idle+0x85/0x130
> [  170.643767] NMI backtrace for cpu 22 skipped: idling at intel_idle+0x85/0x130
> [  170.643827] NMI backtrace for cpu 24 skipped: idling at intel_idle+0x85/0x130
> [  170.643865] NMI backtrace for cpu 23 skipped: idling at intel_idle+0x85/0x130
> [  170.643965] NMI backtrace for cpu 25 skipped: idling at intel_idle+0x85/0x130
> [  170.643986] NMI backtrace for cpu 26 skipped: idling at intel_idle+0x85/0x130
> [  170.644062] NMI backtrace for cpu 28 skipped: idling at intel_idle+0x85/0x130
> [  170.644066] NMI backtrace for cpu 27 skipped: idling at intel_idle+0x85/0x130
> [  170.644164] NMI backtrace for cpu 29 skipped: idling at intel_idle+0x85/0x130
> [  170.644187] NMI backtrace for cpu 30 skipped: idling at intel_idle+0x85/0x130
> [  170.644267] NMI backtrace for cpu 31 skipped: idling at intel_idle+0x85/0x130
> [  170.644271] NMI backtrace for cpu 32 skipped: idling at intel_idle+0x85/0x130
> [  170.644369] NMI backtrace for cpu 33 skipped: idling at intel_idle+0x85/0x130
> [  170.644373] NMI backtrace for cpu 34 skipped: idling at intel_idle+0x85/0x130
> [  170.644464] NMI backtrace for cpu 36 skipped: idling at intel_idle+0x85/0x130
> [  170.644467] NMI backtrace for cpu 35 skipped: idling at intel_idle+0x85/0x130
> [  170.644571] NMI backtrace for cpu 37 skipped: idling at intel_idle+0x85/0x130
> [  170.644586] NMI backtrace for cpu 38 skipped: idling at intel_idle+0x85/0x130
> [  170.644661] NMI backtrace for cpu 40 skipped: idling at intel_idle+0x85/0x130
> [  170.644665] NMI backtrace for cpu 39 skipped: idling at intel_idle+0x85/0x130
> [  170.644760] NMI backtrace for cpu 41 skipped: idling at intel_idle+0x85/0x130
> [  170.644764] NMI backtrace for cpu 42 skipped: idling at intel_idle+0x85/0x130
> [  170.644860] NMI backtrace for cpu 43 skipped: idling at intel_idle+0x85/0x130
> [  170.644864] NMI backtrace for cpu 44 skipped: idling at intel_idle+0x85/0x130
> [  170.644965] NMI backtrace for cpu 45 skipped: idling at intel_idle+0x85/0x130
> [  170.645073] NMI backtrace for cpu 46 skipped: idling at intel_idle+0x85/0x130
> [  170.645177] NMI backtrace for cpu 47 skipped: idling at intel_idle+0x85/0x130
> [  170.645270] NMI backtrace for cpu 48 skipped: idling at intel_idle+0x85/0x130
> [  170.645367] NMI backtrace for cpu 49 skipped: idling at intel_idle+0x85/0x130
> [  170.645465] NMI backtrace for cpu 50 skipped: idling at intel_idle+0x85/0x130
> [  170.645469] NMI backtrace for cpu 51 skipped: idling at intel_idle+0x85/0x130
> [  170.645551] NMI backtrace for cpu 53 skipped: idling at intel_idle+0x85/0x130
> [  170.645573] NMI backtrace for cpu 52 skipped: idling at intel_idle+0x85/0x130
> [  170.645666] NMI backtrace for cpu 54 skipped: idling at intel_idle+0x85/0x130
> [  170.645673] NMI backtrace for cpu 55 skipped: idling at intel_idle+0x85/0x130
> [  170.645763] NMI backtrace for cpu 56 skipped: idling at intel_idle+0x85/0x130
> [  170.645782] NMI backtrace for cpu 57 skipped: idling at intel_idle+0x85/0x130
> [  170.645857] NMI backtrace for cpu 58 skipped: idling at intel_idle+0x85/0x130
> [  170.645861] NMI backtrace for cpu 59 skipped: idling at intel_idle+0x85/0x130
> [  170.645958] NMI backtrace for cpu 61 skipped: idling at intel_idle+0x85/0x130
> [  170.645962] NMI backtrace for cpu 60 skipped: idling at intel_idle+0x85/0x130
> [  170.646061] NMI backtrace for cpu 62 skipped: idling at intel_idle+0x85/0x130
> [  170.646081] NMI backtrace for cpu 63 skipped: idling at intel_idle+0x85/0x130
> [  170.646158] NMI backtrace for cpu 64 skipped: idling at intel_idle+0x85/0x130
> [  170.646162] NMI backtrace for cpu 65 skipped: idling at intel_idle+0x85/0x130
> [  170.646260] NMI backtrace for cpu 66 skipped: idling at intel_idle+0x85/0x130
> [  170.646281] NMI backtrace for cpu 67 skipped: idling at intel_idle+0x85/0x130
> [  170.646360] NMI backtrace for cpu 68 skipped: idling at intel_idle+0x85/0x130
> [  170.646381] NMI backtrace for cpu 69 skipped: idling at intel_idle+0x85/0x130
> [  170.646450] NMI backtrace for cpu 71 skipped: idling at intel_idle+0x85/0x130
> [  170.646461] NMI backtrace for cpu 70 skipped: idling at intel_idle+0x85/0x130
> [  170.646505] NMI backtrace for cpu 73 skipped: idling at intel_idle+0x85/0x130
> [  170.646507] NMI backtrace for cpu 72 skipped: idling at intel_idle+0x85/0x130
> [  170.646629] NMI backtrace for cpu 74
> [  170.646629] CPU: 74 PID: 5413 Comm: uperf Kdump: loaded Not tainted 5.7.6+ #3
> [  170.646630] Hardware name: Intel Corporation CooperCity/CooperCity, BIOS WLYDCRB1.SYS.0016.P38.2006170234 06/17/2020
> [  170.646630] RIP: 0010:smp_call_function_many_cond+0x2b4/0x2e0
> [  170.646631] Code: c5 3c 00 3b 05 71 1b 86 01 0f 83 e8 fd ff ff 48 63 c8 48 8b 13 48 03 14 cd 20 29 58 90 8b 4a 18 83 e1 01 74 0a f3 90 8b 4a 18 <83> e1 01 75 f6 eb c6 0f 0b e9 97 fd ff ff 48 c7 c2 e0 80 99 90 48
> [  170.646632] RSP: 0018:ffffb11561c77ca0 EFLAGS: 00000202
> [  170.646633] RAX: 000000000000005b RBX: ffff9e559012dc40 RCX: 0000000000000003
> [  170.646633] RDX: ffff9e6d8f8f44a0 RSI: 0000000000000000 RDI: ffff9e559012dc48
> [  170.646633] RBP: 000000000000005d R08: 0000000000000000 R09: 000000000000001b
> [  170.646634] R10: 0000000000000001 R11: 0000000000000008 R12: ffffffff8f078800
> [  170.646634] R13: 0000000000000001 R14: ffff9e559012c600 R15: 0000000000000200
> [  170.646634] FS:  00007fed7d7fa700(0000) GS:ffff9e5590100000(0000) knlGS:0000000000000000
> [  170.646634] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  170.646634] CR2: 000055fd7314e1e0 CR3: 00000017eb8b8006 CR4: 00000000007606e0
> [  170.646635] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  170.646635] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  170.646635] PKRU: 55555554
> [  170.646635] Call Trace:
> [  170.646636]  ? flush_tlb_func_common.constprop.10+0x220/0x220
> [  170.646636]  ? x86_configure_nx+0x50/0x50
> [  170.646636]  ? flush_tlb_func_common.constprop.10+0x220/0x220
> [  170.646636]  on_each_cpu_cond_mask+0x2f/0x80
> [  170.646636]  flush_tlb_mm_range+0xab/0xe0
> [  170.646637]  change_protection+0x18a/0xca0
> [  170.646637]  ? __switch_to_asm+0x34/0x70
> [  170.646637]  change_prot_numa+0x15/0x30
> [  170.646637]  task_numa_work+0x1aa/0x2c0
> [  170.646637]  task_work_run+0x76/0xa0
> [  170.646637]  exit_to_usermode_loop+0xeb/0xf0
> [  170.646638]  do_syscall_64+0x1aa/0x1d0
> [  170.646638]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  170.646638] RIP: 0033:0x7feda134d2c7
> [  170.646639] Code: 44 00 00 41 54 55 49 89 d4 53 48 89 f5 89 fb 48 83 ec 10 e8 5b fd ff ff 4c 89 e2 41 89 c0 48 89 ee 89 df b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 94 fd ff ff 48
> [  170.646639] RSP: 002b:00007fed7d7f99b0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> [  170.646640] RAX: 000000000000005a RBX: 0000000000000025 RCX: 00007feda134d2c7
> [  170.646640] RDX: 000000000000005a RSI: 00007fed60000b20 RDI: 0000000000000025
> [  170.646641] RBP: 00007fed60000b20 R08: 0000000000000000 R09: 00007ffcfe964080
> [  170.646641] R10: 00007fed7d7f9dd0 R11: 0000000000000293 R12: 000000000000005a
> [  170.646641] R13: 00007feda1d16878 R14: 0000000000000004 R15: 0000000000000000
> [  170.646724] NMI backtrace for cpu 76 skipped: idling at intel_idle+0x85/0x130
> [  170.646822] NMI backtrace for cpu 77 skipped: idling at intel_idle+0x85/0x130
> [  170.646826] NMI backtrace for cpu 78
> [  170.646827] CPU: 78 PID: 4845 Comm: rs:main Q:Reg Kdump: loaded Not tainted 5.7.6+ #3
> [  170.646829] Hardware name: Intel Corporation CooperCity/CooperCity, BIOS WLYDCRB1.SYS.0016.P38.2006170234 06/17/2020
> [  170.646830] RIP: 0033:0x5614d82f7e11
> [  170.646832] Code: 10 45 31 c9 48 85 c9 74 6b 49 89 c2 48 89 de 49 29 ca 48 39 c1 b8 00 00 00 00 4c 0f 43 d0 45 31 c9 4d 39 d1 41 0f 96 c0 31 ff <85> ff 75 3b 45 84 c0 74 36 48 8b 55 00 0f b6 02 38 06 75 1d 31 c0
> [  170.646833] RSP: 002b:00007fc035a059b0 EFLAGS: 00000246
> [  170.646835] RAX: 000000000000005b RBX: 0000000000000055 RCX: 0000000000000005
> [  170.646836] RDX: 00005614d963e200 RSI: 00007fc028022d06 RDI: 0000000000000000
> [  170.646837] RBP: 00005614d963e1e0 R08: 00007fc035a05a01 R09: 0000000000000006
> [  170.646839] R10: 0000000000000024 R11: 0000000000000000 R12: 00005614d963e010
> [  170.646841] R13: 00005614d833aef8 R14: 00005614d855926c R15: 0000000000000000
> [  170.646843] FS:  00007fc035a06700 GS:  0000000000000000
> [  170.646958] NMI backtrace for cpu 79 skipped: idling at intel_idle+0x85/0x130
> [  170.647073] NMI backtrace for cpu 80
> [  170.647074] CPU: 80 PID: 0 Comm: swapper/80 Kdump: loaded Not tainted 5.7.6+ #3
> [  170.647075] Hardware name: Intel Corporation CooperCity/CooperCity, BIOS WLYDCRB1.SYS.0016.P38.2006170234 06/17/2020
> [  170.647076] RIP: 0010:pick_task_fair+0xb/0x90
> [  170.647077] Code: 01 00 00 48 83 c1 01 48 f7 f1 49 89 86 50 0a 00 00 e9 a4 fc ff ff 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 8b 8f d0 00 00 00 <85> c9 74 72 55 53 48 8d 9f c0 00 00 00 48 83 ec 08 eb 1f 8b 55 38
> [  170.647078] RSP: 0018:ffffb115407d7e18 EFLAGS: 00000046
> [  170.647080] RAX: ffffffff8f0cf510 RBX: ffff9e55902accc0 RCX: 0000000000000001
> [  170.647081] RDX: 0000000000010001 RSI: 0000000000000000 RDI: ffff9e55902accc0
> [  170.647082] RBP: ffffb115407d7ec8 R08: 0000000000000000 R09: 0000000000000010
> [  170.647083] R10: 0000000000000007 R11: 000000000000002d R12: 0000000000000000
> [  170.647083] R13: 0000000000000050 R14: 0000000000000000 R15: 0000000000000000
> [  170.647084] FS:  0000000000000000(0000) GS:ffff9e5590280000(0000) knlGS:0000000000000000
> [  170.647085] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  170.647086] CR2: 000055e027ae2868 CR3: 00000017e5c30005 CR4: 00000000007606e0
> [  170.647087] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  170.647088] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  170.647088] PKRU: 55555554
> [  170.647089] Call Trace:
> [  170.647089]  __schedule+0x7a1/0x1450
> [  170.647090]  ? sched_clock+0x5/0x10
> [  170.647091]  ? update_ts_time_stats+0x53/0x80
> [  170.647091]  schedule_idle+0x1e/0x40
> [  170.647092]  do_idle+0x174/0x280
> [  170.647093]  cpu_startup_entry+0x19/0x20
> [  170.647093]  start_secondary+0x169/0x1c0
> [  170.647094]  secondary_startup_64+0xb6/0xc0
> [  170.647113] NMI backtrace for cpu 81 skipped: idling at intel_idle+0x85/0x130
> [  170.647246] NMI backtrace for cpu 82 skipped: idling at intel_idle+0x85/0x130
> [  170.647316] NMI backtrace for cpu 83 skipped: idling at intel_idle+0x85/0x130
> [  170.647457] NMI backtrace for cpu 84 skipped: idling at intel_idle+0x85/0x130
> [  170.647569] NMI backtrace for cpu 85 skipped: idling at intel_idle+0x85/0x130
> [  170.647661] NMI backtrace for cpu 86 skipped: idling at intel_idle+0x85/0x130
> [  170.647756] NMI backtrace for cpu 87 skipped: idling at intel_idle+0x85/0x130
> [  170.647859] NMI backtrace for cpu 88 skipped: idling at intel_idle+0x85/0x130
> [  170.647954] NMI backtrace for cpu 89 skipped: idling at intel_idle+0x85/0x130
> [  170.648001] NMI backtrace for cpu 90 skipped: idling at intel_idle+0x85/0x130
> [  170.648147] NMI backtrace for cpu 92
> [  170.648148] CPU: 92 PID: 5404 Comm: uperf Kdump: loaded Not tainted 5.7.6+ #3
> [  170.648149] Hardware name: Intel Corporation CooperCity/CooperCity, BIOS WLYDCRB1.SYS.0016.P38.2006170234 06/17/2020
> [  170.648149] RIP: 0010:native_queued_spin_lock_slowpath+0x63/0x1e0
> [  170.648150] Code: ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 1e 85 c0 75 0b b8 01 00 00 00 66 89 07 c3 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 f6 c4 01 75 04 c6 47
> [  170.648151] RSP: 0018:ffffb1154e0d8d68 EFLAGS: 00000202
> [  170.648152] RAX: 0000000000500101 RBX: ffff9e555d8354e0 RCX: 0000000000000020
> [  170.648152] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9e555dea2588
> [  170.648152] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> [  170.648152] R10: 000000000100007f R11: 000000000000b7c2 R12: ffff9e555dea2588
> [  170.648153] R13: ffffffff9093cb40 R14: ffff9e555dea2500 R15: ffff9e8da197e120
> [  170.648153] FS:  00007fed9e745700(0000) GS:ffff9e6d8f900000(0000) knlGS:0000000000000000
> [  170.648153] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  170.648154] CR2: 00007f0018000b20 CR3: 00000017eb8b8006 CR4: 00000000007606e0
> [  170.648154] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  170.648154] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  170.648154] PKRU: 55555554
> [  170.648155] Call Trace:
> [  170.648155]  <IRQ>
> [  170.648155]  _raw_spin_lock+0x1b/0x20
> [  170.648155]  tcp_v4_rcv+0xaa5/0xbc0
> [  170.648155]  ip_protocol_deliver_rcu+0x2c/0x1a0
> [  170.648156]  ip_local_deliver_finish+0x44/0x50
> [  170.648156]  ip_local_deliver+0x79/0xe0
> [  170.648156]  ? ip_rcv_finish+0x64/0xa0
> [  170.648156]  ip_rcv+0xbc/0xd0
> [  170.648156]  __netif_receive_skb_one_core+0x85/0xa0
> [  170.648157]  process_backlog+0x9b/0x150
> [  170.648157]  net_rx_action+0x149/0x3f0
> [  170.648157]  __do_softirq+0xed/0x2f0
> [  170.648157]  do_softirq_own_stack+0x2a/0x40
> [  170.648157]  </IRQ>
> [  170.648158]  do_softirq.part.18+0x41/0x50
> [  170.648158]  __local_bh_enable_ip+0x4b/0x50
> [  170.648158]  ip_finish_output2+0x1af/0x5a0
> [  170.648158]  ? __switch_to_asm+0x34/0x70
> [  170.648159]  ? __switch_to_asm+0x40/0x70
> [  170.648159]  ? ip_output+0x6d/0xe0
> [  170.648159]  ip_output+0x6d/0xe0
> [  170.648159]  ? __ip_finish_output+0x1c0/0x1c0
> [  170.648159]  __ip_queue_xmit+0x14d/0x3d0
> [  170.648160]  __tcp_transmit_skb+0x594/0xb20
> [  170.648160]  tcp_write_xmit+0x241/0x1150
> [  170.648160]  __tcp_push_pending_frames+0x32/0xf0
> [  170.648160]  tcp_sendmsg_locked+0x50f/0xd30
> [  170.648161]  tcp_sendmsg+0x27/0x40
> [  170.648161]  sock_sendmsg+0x3e/0x60
> [  170.648161]  sock_write_iter+0x97/0x100
> [  170.648161]  new_sync_write+0x1b6/0x1d0
> [  170.648161]  vfs_write+0xad/0x1b0
> [  170.648162]  ksys_write+0x50/0xe0
> [  170.648162]  do_syscall_64+0x52/0x1d0
> [  170.648162]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  170.648162] RIP: 0033:0x7feda134d2c7
> [  170.648163] Code: 44 00 00 41 54 55 49 89 d4 53 48 89 f5 89 fb 48 83 ec 10 e8 5b fd ff ff 4c 89 e2 41 89 c0 48 89 ee 89 df b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 94 fd ff ff 48
> [  170.648163] RSP: 002b:00007fed9e7449b0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> [  170.648164] RAX: ffffffffffffffda RBX: 000000000000002c RCX: 00007feda134d2c7
> [  170.648164] RDX: 000000000000005a RSI: 00007fed80000b20 RDI: 000000000000002c
> [  170.648164] RBP: 00007fed80000b20 R08: 0000000000000000 R09: 00007ffcfe964080
> [  170.648165] R10: 00007fed9e744dd0 R11: 0000000000000293 R12: 000000000000005a
> [  170.648165] R13: 00007feda1d15a20 R14: 0000000000000004 R15: 0000000000000000
> [  170.648240] NMI backtrace for cpu 93
> [  170.648241] CPU: 93 PID: 5402 Comm: uperf Kdump: loaded Not tainted 5.7.6+ #3
> [  170.648241] Hardware name: Intel Corporation CooperCity/CooperCity, BIOS WLYDCRB1.SYS.0016.P38.2006170234 06/17/2020
> [  170.648242] RIP: 0010:smp_call_function_many_cond+0x2b1/0x2e0
> [  170.648242] Code: c7 e8 d3 c5 3c 00 3b 05 71 1b 86 01 0f 83 e8 fd ff ff 48 63 c8 48 8b 13 48 03 14 cd 20 29 58 90 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c6 0f 0b e9 97 fd ff ff 48 c7 c2 e0 80
> [  170.648243] RSP: 0018:ffffb11561c17ca0 EFLAGS: 00000202
> [  170.648243] RAX: 000000000000005b RBX: ffff9e6d8f96dc40 RCX: 0000000000000001
> [  170.648244] RDX: ffff9e6d8f8f4700 RSI: 0000000000000000 RDI: ffff9e6d8f96dc48
> [  170.648244] RBP: 000000000000005c R08: 0000000000000000 R09: 000000000000001b
> [  170.648244] R10: 0000000000000001 R11: 0000000000000008 R12: ffffffff8f078800
> [  170.648244] R13: 0000000000000001 R14: ffff9e6d8f96c600 R15: 0000000000000200
> [  170.648245] FS:  00007fed9f747700(0000) GS:ffff9e6d8f940000(0000) knlGS:0000000000000000
> [  170.648245] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  170.648245] CR2: 00007f006804d9b8 CR3: 00000017eb8b8001 CR4: 00000000007606e0
> [  170.648245] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  170.648246] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  170.648246] PKRU: 55555554
> [  170.648246] Call Trace:
> [  170.648246]  ? flush_tlb_func_common.constprop.10+0x220/0x220
> [  170.648246]  ? x86_configure_nx+0x50/0x50
> [  170.648247]  ? flush_tlb_func_common.constprop.10+0x220/0x220
> [  170.648247]  on_each_cpu_cond_mask+0x2f/0x80
> [  170.648247]  flush_tlb_mm_range+0xab/0xe0
> [  170.648247]  change_protection+0x18a/0xca0
> [  170.648247]  change_prot_numa+0x15/0x30
> [  170.648248]  task_numa_work+0x1aa/0x2c0
> [  170.648248]  task_work_run+0x76/0xa0
> [  170.648248]  exit_to_usermode_loop+0xeb/0xf0
> [  170.648248]  do_syscall_64+0x1aa/0x1d0
> [  170.648248]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  170.648249] RIP: 0033:0x7feda134d2c7
> [  170.648249] Code: 44 00 00 41 54 55 49 89 d4 53 48 89 f5 89 fb 48 83 ec 10 e8 5b fd ff ff 4c 89 e2 41 89 c0 48 89 ee 89 df b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 94 fd ff ff 48
> [  170.648249] RSP: 002b:00007fed9f7469b0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> [  170.648250] RAX: 000000000000005a RBX: 0000000000000034 RCX: 00007feda134d2c7
> [  170.648250] RDX: 000000000000005a RSI: 00007fed88000b20 RDI: 0000000000000034
> [  170.648250] RBP: 00007fed88000b20 R08: 0000000000000000 R09: 00007ffcfe964080
> [  170.648250] R10: 00007fed9f746dd0 R11: 0000000000000293 R12: 000000000000005a
> [  170.648251] R13: 00007feda1d156f0 R14: 0000000000000004 R15: 0000000000000000
> [  170.648259] NMI backtrace for cpu 94 skipped: idling at intel_idle+0x85/0x130
> [  170.648354] NMI backtrace for cpu 95 skipped: idling at intel_idle+0x85/0x130
> [  170.648373] NMI backtrace for cpu 96 skipped: idling at intel_idle+0x85/0x130
> [  170.648453] NMI backtrace for cpu 97 skipped: idling at intel_idle+0x85/0x130
> [  170.648475] NMI backtrace for cpu 98 skipped: idling at intel_idle+0x85/0x130
> [  170.648550] NMI backtrace for cpu 100 skipped: idling at intel_idle+0x85/0x130
> [  170.648554] NMI backtrace for cpu 99 skipped: idling at intel_idle+0x85/0x130
> [  170.648653] NMI backtrace for cpu 101 skipped: idling at intel_idle+0x85/0x130
> [  170.648673] NMI backtrace for cpu 102 skipped: idling at intel_idle+0x85/0x130
> [  170.648755] NMI backtrace for cpu 104 skipped: idling at intel_idle+0x85/0x130
> [  170.648759] NMI backtrace for cpu 103 skipped: idling at intel_idle+0x85/0x130
> [  170.648855] NMI backtrace for cpu 105 skipped: idling at intel_idle+0x85/0x130
> [  170.648858] NMI backtrace for cpu 106 skipped: idling at intel_idle+0x85/0x130
> [  170.648954] NMI backtrace for cpu 108 skipped: idling at intel_idle+0x85/0x130
> [  170.648958] NMI backtrace for cpu 107 skipped: idling at intel_idle+0x85/0x130
> [  170.649053] NMI backtrace for cpu 109 skipped: idling at intel_idle+0x85/0x130
> [  170.649074] NMI backtrace for cpu 110 skipped: idling at intel_idle+0x85/0x130
> [  170.649149] NMI backtrace for cpu 111 skipped: idling at intel_idle+0x85/0x130
> [  170.649153] NMI backtrace for cpu 112 skipped: idling at intel_idle+0x85/0x130
> [  170.649249] NMI backtrace for cpu 114 skipped: idling at intel_idle+0x85/0x130
> [  170.649253] NMI backtrace for cpu 113 skipped: idling at intel_idle+0x85/0x130
> [  170.649352] NMI backtrace for cpu 115 skipped: idling at intel_idle+0x85/0x130
> [  170.649453] NMI backtrace for cpu 116 skipped: idling at intel_idle+0x85/0x130
> [  170.649552] NMI backtrace for cpu 117 skipped: idling at intel_idle+0x85/0x130
> [  170.649652] NMI backtrace for cpu 118 skipped: idling at intel_idle+0x85/0x130
> [  170.649752] NMI backtrace for cpu 119 skipped: idling at intel_idle+0x85/0x130
> [  170.649852] NMI backtrace for cpu 121 skipped: idling at intel_idle+0x85/0x130
> [  170.649856] NMI backtrace for cpu 120 skipped: idling at intel_idle+0x85/0x130
> [  170.649954] NMI backtrace for cpu 122 skipped: idling at intel_idle+0x85/0x130
> [  170.649957] NMI backtrace for cpu 123 skipped: idling at intel_idle+0x85/0x130
> [  170.650057] NMI backtrace for cpu 124 skipped: idling at intel_idle+0x85/0x130
> [  170.650148] NMI backtrace for cpu 125 skipped: idling at intel_idle+0x85/0x130
> [  170.650250] NMI backtrace for cpu 126 skipped: idling at intel_idle+0x85/0x130
> [  170.650254] NMI backtrace for cpu 127 skipped: idling at intel_idle+0x85/0x130
> [  170.650347] NMI backtrace for cpu 128 skipped: idling at intel_idle+0x85/0x130
> [  170.650351] NMI backtrace for cpu 129 skipped: idling at intel_idle+0x85/0x130
> [  170.650446] NMI backtrace for cpu 130 skipped: idling at intel_idle+0x85/0x130
> [  170.650450] NMI backtrace for cpu 131 skipped: idling at intel_idle+0x85/0x130
> [  170.650549] NMI backtrace for cpu 132 skipped: idling at intel_idle+0x85/0x130
> [  170.650573] NMI backtrace for cpu 133 skipped: idling at intel_idle+0x85/0x130
> [  170.650649] NMI backtrace for cpu 134 skipped: idling at intel_idle+0x85/0x130
> [  170.650749] NMI backtrace for cpu 135 skipped: idling at intel_idle+0x85/0x130
> [  170.650848] NMI backtrace for cpu 136 skipped: idling at intel_idle+0x85/0x130
> [  170.650945] NMI backtrace for cpu 138 skipped: idling at intel_idle+0x85/0x130
> [  170.650949] NMI backtrace for cpu 137 skipped: idling at intel_idle+0x85/0x130
> [  170.651046] NMI backtrace for cpu 139 skipped: idling at intel_idle+0x85/0x130
> [  170.651050] NMI backtrace for cpu 140 skipped: idling at intel_idle+0x85/0x130
> [  170.651145] NMI backtrace for cpu 142 skipped: idling at intel_idle+0x85/0x130
> [  170.651149] NMI backtrace for cpu 141 skipped: idling at intel_idle+0x85/0x130
> [  170.651244] NMI backtrace for cpu 143 skipped: idling at intel_idle+0x85/0x130
> [  170.652186] NMI watchdog: Watchdog detected hard LOCKUP on cpu 20
> [  170.652186] Modules linked in: binfmt_misc ipmi_ssif intel_rapl_msr intel_rapl_common skx_edac nfit x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass joydev efi_pstore input_leds mei_me lpc_ich mei ioatdma ipmi_si ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter mac_hid sch_fq_codel ib_iser rdma_cm iw_cm ib_cm ib_core configfs iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi ip_tables x_tables autofs4 btrfs blake2b_generic zstd_decompress zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear ast drm_vram_helper drm_ttm_helper ttm crct10dif_pclmul ixgbe drm_kms_helper crc32_pclmul igb ghash_clmulni_intel aesni_intel syscopyarea crypto_simd sysfillrect dca cryptd sysimgblt glue_helper fb_sys_fops ptp mdio ahci pps_core drm i2c_algo_bit libahci wmi hid_generic usbhid hid
> [  170.652198] CPU: 20 PID: 5388 Comm: uperf Kdump: loaded Not tainted 5.7.6+ #3
> [  170.652199] Hardware name: Intel Corporation CooperCity/CooperCity, BIOS WLYDCRB1.SYS.0016.P38.2006170234 06/17/2020
> [  170.652199] RIP: 0010:sched_core_irq_exit+0xcc/0x110
> [  170.652200] Code: 48 8b 8b 30 0c 00 00 83 e8 01 89 81 68 0c 00 00 e9 3c 00 00 00 48 89 df c6 07 00 0f 1f 40 00 84 d2 75 07 e9 4f ff ff ff f3 90 <48> 8b 83 30 0c 00 00 8b 80 68 0c 00 00 85 c0 75 ed 5b c3 48 8b bb
> [  170.652201] RSP: 0018:ffffb1154d468fe0 EFLAGS: 00000002
> [  170.652201] RAX: 0000000000000001 RBX: ffff9e6d8f4accc0 RCX: ffff9e6d8f4accc0
> [  170.652202] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff9e6d8f4accc0
> [  170.652202] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [  170.652202] R10: ffffb1154d468f80 R11: 0000000000000000 R12: 0000000000000000
> [  170.652203] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  170.652203] FS:  00007f0064aa4700(0000) GS:ffff9e6d8f480000(0000) knlGS:0000000000000000
> [  170.652203] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  170.652203] CR2: 00007f002effda08 CR3: 00000017e5fb0002 CR4: 00000000007606e0
> [  170.652204] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  170.652204] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  170.652204] PKRU: 55555554
> [  170.652204] Call Trace:
> [  170.652204]  <IRQ>
> [  170.652205]  irq_exit+0x6a/0xb0
> [  170.652205]  call_function_interrupt+0xf/0x20
> [  170.652205]  </IRQ>
> [  170.652205] RIP: 0010:_raw_spin_lock_bh+0x1b/0x30
> [  170.652206] Code: 0f b1 17 75 06 b8 01 00 00 00 c3 31 c0 c3 90 0f 1f 44 00 00 65 81 05 18 e3 61 70 00 02 00 00 31 c0 ba 01 00 00 00 f0 0f b1 17 <75> 02 f3 c3 89 c6 e8 8a 2e 6f ff 66 90 c3 0f 1f 80 00 00 00 00 0f
> [  170.652206] RSP: 0018:ffffb11561787cd8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff03
> [  170.652206] RAX: 0000000000000000 RBX: ffff9e555dea2588 RCX: 0000000000000000
> [  170.652206] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9e555dea2588
> [  170.652207] RBP: ffff9e555dea2500 R08: 0000000000000000 R09: ffffb11561787dbc
> [  170.652207] R10: ffffb11561787ea0 R11: ffff9e555ff10e38 R12: 0000000000000000
> [  170.652207] R13: ffff9e555dea2500 R14: ffff9e555ff10e00 R15: 0000000000000000
> [  170.652207]  ? _cond_resched+0x15/0x40
> [  170.652207]  lock_sock_nested+0x1e/0x60
> [  170.652208]  tcp_recvmsg+0x8c/0xb50
> [  170.652208]  ? _cond_resched+0x15/0x40
> [  170.652208]  ? aa_sk_perm+0x3e/0x1f0
> [  170.652208]  inet6_recvmsg+0x5d/0xe0
> [  170.652208]  sock_read_iter+0x92/0xf0
> [  170.652209]  new_sync_read+0x1a7/0x1c0
> [  170.652209]  vfs_read+0x89/0x140
> [  170.652209]  ksys_read+0x50/0xe0
> [  170.652209]  do_syscall_64+0x52/0x1d0
> [  170.652209]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  170.652209] RIP: 0033:0x7f00676ac394
> [  170.652210] Code: 84 00 00 00 00 00 41 54 55 49 89 d4 53 48 89 f5 89 fb 48 83 ec 10 e8 8b fc ff ff 4c 89 e2 41 89 c0 48 89 ee 89 df 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 38 44 89 c7 48 89 44 24 08 e8 c7 fc ff ff 48
> [  170.652210] RSP: 002b:00007f0064aa3980 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [  170.652210] RAX: ffffffffffffffda RBX: 000000000000001d RCX: 00007f00676ac394
> [  170.652211] RDX: 000000000000005a RSI: 00007f0048000b20 RDI: 000000000000001d
> [  170.652211] RBP: 00007f0048000b20 R08: 0000000000000000 R09: 0000563ccd7ca0b4
> [  170.652211] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000005a
> [  170.652211] R13: 00007f006804da30 R14: 0000000000000004 R15: 0000000000000000
> [  170.652212] NMI backtrace for cpu 20
> [  170.652212] CPU: 20 PID: 5388 Comm: uperf Kdump: loaded Not tainted 5.7.6+ #3
> [  170.652212] Hardware name: Intel Corporation CooperCity/CooperCity, BIOS WLYDCRB1.SYS.0016.P38.2006170234 06/17/2020
> [  170.652212] RIP: 0010:sched_core_irq_exit+0xcc/0x110
> [  170.652213] Code: 48 8b 8b 30 0c 00 00 83 e8 01 89 81 68 0c 00 00 e9 3c 00 00 00 48 89 df c6 07 00 0f 1f 40 00 84 d2 75 07 e9 4f ff ff ff f3 90 <48> 8b 83 30 0c 00 00 8b 80 68 0c 00 00 85 c0 75 ed 5b c3 48 8b bb
> [  170.652214] RSP: 0018:ffffb1154d468fe0 EFLAGS: 00000002
> [  170.652214] RAX: 0000000000000001 RBX: ffff9e6d8f4accc0 RCX: ffff9e6d8f4accc0
> [  170.652214] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff9e6d8f4accc0
> [  170.652215] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [  170.652215] R10: ffffb1154d468f80 R11: 0000000000000000 R12: 0000000000000000
> [  170.652216] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  170.652216] FS:  00007f0064aa4700(0000) GS:ffff9e6d8f480000(0000) knlGS:0000000000000000
> [  170.652216] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  170.652217] CR2: 00007f002effda08 CR3: 00000017e5fb0002 CR4: 00000000007606e0
> [  170.652217] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  170.652217] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  170.652217] PKRU: 55555554
> [  170.652217] Call Trace:
> [  170.652218]  <IRQ>
> [  170.652218]  irq_exit+0x6a/0xb0
> [  170.652218]  call_function_interrupt+0xf/0x20
> [  170.652218]  </IRQ>
> [  170.652218] RIP: 0010:_raw_spin_lock_bh+0x1b/0x30
> [  170.652219] Code: 0f b1 17 75 06 b8 01 00 00 00 c3 31 c0 c3 90 0f 1f 44 00 00 65 81 05 18 e3 61 70 00 02 00 00 31 c0 ba 01 00 00 00 f0 0f b1 17 <75> 02 f3 c3 89 c6 e8 8a 2e 6f ff 66 90 c3 0f 1f 80 00 00 00 00 0f
> [  170.652219] RSP: 0018:ffffb11561787cd8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff03
> [  170.652219] RAX: 0000000000000000 RBX: ffff9e555dea2588 RCX: 0000000000000000
> [  170.652220] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9e555dea2588
> [  170.652220] RBP: ffff9e555dea2500 R08: 0000000000000000 R09: ffffb11561787dbc
> [  170.652220] R10: ffffb11561787ea0 R11: ffff9e555ff10e38 R12: 0000000000000000
> [  170.652221] R13: ffff9e555dea2500 R14: ffff9e555ff10e00 R15: 0000000000000000
> [  170.652221]  ? _cond_resched+0x15/0x40
> [  170.652221]  lock_sock_nested+0x1e/0x60
> [  170.652221]  tcp_recvmsg+0x8c/0xb50
> [  170.652222]  ? _cond_resched+0x15/0x40
> [  170.652222]  ? aa_sk_perm+0x3e/0x1f0
> [  170.652222]  inet6_recvmsg+0x5d/0xe0
> [  170.652222]  sock_read_iter+0x92/0xf0
> [  170.652222]  new_sync_read+0x1a7/0x1c0
> [  170.652222]  vfs_read+0x89/0x140
> [  170.652223]  ksys_read+0x50/0xe0
> [  170.652224]  do_syscall_64+0x52/0x1d0
> [  170.652224]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  170.652224] RIP: 0033:0x7f00676ac394
> [  170.652225] Code: 84 00 00 00 00 00 41 54 55 49 89 d4 53 48 89 f5 89 fb 48 83 ec 10 e8 8b fc ff ff 4c 89 e2 41 89 c0 48 89 ee 89 df 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 38 44 89 c7 48 89 44 24 08 e8 c7 fc ff ff 48
> [  170.652225] RSP: 002b:00007f0064aa3980 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [  170.652225] RAX: ffffffffffffffda RBX: 000000000000001d RCX: 00007f00676ac394
> [  170.652226] RDX: 000000000000005a RSI: 00007f0048000b20 RDI: 000000000000001d
> [  170.652226] RBP: 00007f0048000b20 R08: 0000000000000000 R09: 0000563ccd7ca0b4
> [  170.652226] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000005a
> [  170.652226] R13: 00007f006804da30 R14: 0000000000000004 R15: 0000000000000000
> [  170.652256] NMI backtrace for cpu 91
> [  170.652257] CPU: 91 PID: 5401 Comm: uperf Kdump: loaded Not tainted 5.7.6+ #3
> [  170.652257] Hardware name: Intel Corporation CooperCity/CooperCity, BIOS WLYDCRB1.SYS.0016.P38.2006170234 06/17/2020
> [  170.652257] RIP: 0010:sched_core_irq_exit+0xcc/0x110
> [  170.652258] Code: 48 8b 8b 30 0c 00 00 83 e8 01 89 81 68 0c 00 00 e9 3c 00 00 00 48 89 df c6 07 00 0f 1f 40 00 84 d2 75 07 e9 4f ff ff ff f3 90 <48> 8b 83 30 0c 00 00 8b 80 68 0c 00 00 85 c0 75 ed 5b c3 48 8b bb
> [  170.652258] RSP: 0018:ffffb1154e0acfc8 EFLAGS: 00000002
> [  170.652258] RAX: 0000000000000001 RBX: ffff9e6d8f8eccc0 RCX: ffff9e6d8f46ccc0
> [  170.652258] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9e6d8f46ccc0
> [  170.652259] RBP: 0000000000000000 R08: ffff9e6d82763e00 R09: 0000000000000100
> [  170.652259] R10: 0000000000000000 R11: 0000000000000329 R12: 0000000000000000
> [  170.652259] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  170.652260] FS:  00007fed9ff48700(0000) GS:ffff9e6d8f8c0000(0000) knlGS:0000000000000000
> [  170.652260] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  170.652260] CR2: 00007f0053fffa08 CR3: 00000017eb8b8006 CR4: 00000000007606e0
> [  170.652261] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  170.652261] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  170.652261] PKRU: 55555554
> [  170.652261] Call Trace:
> [  170.652262]  <IRQ>
> [  170.652262]  irq_exit+0x6a/0xb0
> [  170.652262]  smp_apic_timer_interrupt+0x74/0x130
> [  170.652262]  apic_timer_interrupt+0xf/0x20
> [  170.652262]  </IRQ>
> [  170.652263] RIP: 0010:finish_task_switch+0x7e/0x280
> [  170.652263] Code: 01 00 0f 1f 44 00 00 0f 1f 44 00 00 41 c7 47 38 00 00 00 00 e9 00 01 00 00 48 89 df c6 07 00 0f 1f 40 00 fb 66 0f 1f 44 00 00 <65> 48 8b 04 25 c0 8b 01 00 0f 1f 44 00 00 4d 85 e4 74 22 65 48 8b
> [  170.652263] RSP: 0018:ffffb11561c0fb08 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [  170.652264] RAX: 0000000000000001 RBX: ffff9e6d8f8eccc0 RCX: 0000000000000000
> [  170.652264] RDX: 0000000080004000 RSI: 0000000000000009 RDI: ffff9e6d8f46ccc0
> [  170.652264] RBP: ffffb11561c0fb30 R08: 0000000000000001 R09: 0000000000000000
> [  170.652265] R10: ffffb11540a5bd98 R11: ffff9e6d8bb37600 R12: ffff9e5567070440
> [  170.652265] R13: 0000000000000000 R14: ffff9e555de62c80 R15: ffff9e6d8baac2c0
> [  170.652265]  ? __switch_to_asm+0x34/0x70
> [  170.652265]  __schedule+0x300/0x1450
> [  170.652265]  schedule+0x40/0xb0
> [  170.652266]  schedule_timeout+0x1dd/0x300
> [  170.652266]  wait_woken+0x44/0x80
> [  170.652266]  ? release_sock+0x43/0x90
> [  170.652266]  sk_wait_data+0x128/0x140
> [  170.652266]  ? do_wait_intr_irq+0x90/0x90
> [  170.652267]  tcp_recvmsg+0x5e0/0xb50
> [  170.652267]  ? _cond_resched+0x15/0x40
> [  170.652267]  ? aa_sk_perm+0x3e/0x1f0
> [  170.652267]  inet6_recvmsg+0x5d/0xe0
> [  170.652267]  sock_read_iter+0x92/0xf0
> [  170.652267]  new_sync_read+0x1a7/0x1c0
> [  170.652268]  vfs_read+0x89/0x140
> [  170.652268]  ksys_read+0x50/0xe0
> [  170.652268]  do_syscall_64+0x52/0x1d0
> [  170.652268]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  170.652268] RIP: 0033:0x7feda134d394
> [  170.652269] Code: 84 00 00 00 00 00 41 54 55 49 89 d4 53 48 89 f5 89 fb 48 83 ec 10 e8 8b fc ff ff 4c 89 e2 41 89 c0 48 89 ee 89 df 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 38 44 89 c7 48 89 44 24 08 e8 c7 fc ff ff 48
> [  170.652269] RSP: 002b:00007fed9ff47980 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [  170.652269] RAX: ffffffffffffffda RBX: 0000000000000035 RCX: 00007feda134d394
> [  170.652270] RDX: 000000000000005a RSI: 00007fed94000b20 RDI: 0000000000000035
> [  170.652270] RBP: 00007fed94000b20 R08: 0000000000000000 R09: 00007ffcfe964080
> [  170.652270] R10: 00007fed9ff47dd0 R11: 0000000000000246 R12: 000000000000005a
> [  170.652270] R13: 00007feda1d15558 R14: 0000000000000000 R15: 0000000000000000
> [  170.652299] Kernel panic - not syncing: softlockup: hung tasks
> [  171.760272] CPU: 75 PID: 5393 Comm: uperf Kdump: loaded Tainted: G             L    5.7.6+ #3
> [  171.769122] Hardware name: Intel Corporation CooperCity/CooperCity, BIOS WLYDCRB1.SYS.0016.P38.2006170234 06/17/2020
> [  171.779996] Call Trace:
> [  171.782818]  <IRQ>
> [  171.785183]  dump_stack+0x66/0x8b
> [  171.788850]  panic+0xfe/0x2e0
> [  171.792187]  watchdog_timer_fn+0x210/0x220
> [  171.796638]  ? softlockup_fn+0x30/0x30
> [  171.800744]  __hrtimer_run_queues+0x108/0x290
> [  171.805459]  hrtimer_interrupt+0xe5/0x240
> [  171.809830]  smp_apic_timer_interrupt+0x6a/0x130
> [  171.814823]  apic_timer_interrupt+0xf/0x20
> [  171.819272]  </IRQ>
> [  171.821710] RIP: 0010:smp_call_function_many_cond+0x2b1/0x2e0
> [  171.827795] Code: c7 e8 d3 c5 3c 00 3b 05 71 1b 86 01 0f 83 e8 fd ff ff 48 63 c8 48 8b 13 48 03 14 cd 20 29 58 90 8b 4a 18 83 e1 01 74 0a f3 90 <8b> 4a 18 83 e1 01 75 f6 eb c6 0f 0b e9 97 fd ff ff 48 c7 c2 e0 80
> [  171.847266] RSP: 0018:ffffb115617afca0 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
> [  171.855198] RAX: 0000000000000014 RBX: ffff9e559016dc40 RCX: 0000000000000001
> [  171.862702] RDX: ffff9e6d8f4b44c0 RSI: 0000000000000000 RDI: ffff9e559016dc48
> [  171.870194] RBP: 000000000000005b R08: 0000000000000000 R09: 0000000000000014
> [  171.877686] R10: 0000000000000007 R11: 0000000000000008 R12: ffffffff8f078800
> [  171.885174] R13: 0000000000000001 R14: ffff9e559016c600 R15: 0000000000000200
> [  171.892667]  ? x86_configure_nx+0x50/0x50
> [  171.897047]  ? flush_tlb_func_common.constprop.10+0x220/0x220
> [  171.903173]  ? x86_configure_nx+0x50/0x50
> [  171.907565]  ? flush_tlb_func_common.constprop.10+0x220/0x220
> [  171.913688]  on_each_cpu_cond_mask+0x2f/0x80
> [  171.918343]  flush_tlb_mm_range+0xab/0xe0
> [  171.922758]  change_protection+0x18a/0xca0
> [  171.927248]  ? __switch_to_asm+0x34/0x70
> [  171.931565]  change_prot_numa+0x15/0x30
> [  171.935794]  task_numa_work+0x1aa/0x2c0
> [  171.940036]  task_work_run+0x76/0xa0
> [  171.944020]  exit_to_usermode_loop+0xeb/0xf0
> [  171.948683]  do_syscall_64+0x1aa/0x1d0
> [  171.952827]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  171.958275] RIP: 0033:0x7f00676ac2c7
> [  171.962251] Code: 44 00 00 41 54 55 49 89 d4 53 48 89 f5 89 fb 48 83 ec 10 e8 5b fd ff ff 4c 89 e2 41 89 c0 48 89 ee 89 df b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 94 fd ff ff 48
> [  171.981817] RSP: 002b:00007f0051ffa9b0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> [  171.989788] RAX: 000000000000005a RBX: 000000000000002a RCX: 00007f00676ac2c7
> [  171.997322] RDX: 000000000000005a RSI: 00007f0030000b20 RDI: 000000000000002a
> [  172.004849] RBP: 00007f0030000b20 R08: 0000000000000000 R09: 0000563ccd7ca0b4
> [  172.012390] R10: 0000000000000000 R11: 0000000000000293 R12: 000000000000005a
> [  172.019929] R13: 00007f006804e228 R14: 0000000000000000 R15: 0000000000000000

