Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EDAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 17:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A5A2077D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 17:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ffoeAA0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgFERhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 13:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgFERhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 13:37:18 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB06C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 10:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Yezmn5hVTSUiHfhN+LW0dohk3ddW8YwIqe/hWDFA/L4=; b=ffoeAA0cGJjVqdIEbzSavjeM1Z
        1iRAvPaEGXX5Ui9/CHoWom5FVxE9ZhBhBuLiqCqQnrih7G33MRABInKgN17dvb5pe3sf1q86beOkm
        zsmI0OJt5L9lKalQaDZbnDtf1NvYGgzG3E5HlFCgo5SCfjGF/65NGWp5yJ8XDKWqQXmba5dexzSxo
        oe/2VjokwDcN29tL3u9NRvQaH+/Js4jLaT2yID3r25M1XJPEUxdyTdeoGkntaoGmJE7NTxIDpmXkx
        qeBVRUvfU+piSjeLMj4MbcKXQQ5TZ5NKHLxLSHSmYcWH4QdZMfNRbDQFePV3sHB2+DOl224b7SGeI
        aKqtnTwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhGGZ-0007qX-Eq; Fri, 05 Jun 2020 17:36:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0C88F301DFC;
        Fri,  5 Jun 2020 19:36:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C16E221A75218; Fri,  5 Jun 2020 19:36:22 +0200 (CEST)
Date:   Fri, 5 Jun 2020 19:36:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [patch V9 10/39] x86/entry: Provide helpers for execute on
 irqstack
Message-ID: <20200605173622.GL3976@hirez.programming.kicks-ass.net>
References: <20200521200513.656533920@linutronix.de>
 <20200521202117.763775313@linutronix.de>
 <20200605171816.GA4259@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605171816.GA4259@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 01:18:16PM -0400, Qian Cai wrote:
> On Thu, May 21, 2020 at 10:05:23PM +0200, Thomas Gleixner wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > Device interrupt handlers and system vector handlers are executed on the
> > interrupt stack. The stack switch happens in the low level assembly entry
> > code. This conflicts with the efforts to consolidate the exit code in C to
> > ensure correctness vs. RCU and tracing.
> > 
> > As there is no way to move #DB away from IST due to the MOV SS issue, the
> > requirements vs. #DB and NMI for switching to the interrupt stack do not
> > exist anymore. The only requirement is that interrupts are disabled.
> > 
> > That allows to move the stack switching to C code which simplifies the
> > entry/exit handling further because it allows to switch stacks after
> > handling the entry and on exit before handling RCU, return to usermode and
> > kernel preemption in the same way as for regular exceptions.
> > 
> > The initial attempt of having the stack switching in inline ASM caused too
> > much headache vs. objtool and the unwinder. After analysing the use cases
> > it was agreed on that having the stack switch in ASM for the price of an
> > indirect call is acceptable as the main users are indirect call heavy
> > anyway and the few system vectors which are empty shells (scheduler IPI and
> > KVM posted interrupt vectors) can run from the regular stack.
> > 
> > Provide helper functions to check whether the interrupt stack is already
> > active and whether stack switching is required.
> > 
> > 64 bit only for now. 32 bit has a variant of that already. Once this is
> > cleaned up the two implementations might be consolidated as a cleanup on
> > top.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Reverted this commit and the rest of series (with trivial fixup) as well
> as the two dependencies [1],
> 
> 8449e768dcb8 ("x86/entry: Remove debug IDT frobbing")
> 029149180d1d ("x86/entry: Rename trace_hardirqs_off_prepare()")
> 
> fixed the warning under some memory pressure on AMD NUMA servers.

The warning ?

> [ 9371.959858]  asm_call_on_stack+0x12/0x20
> asm_call_on_stack at arch/x86/entry/entry_64.S:710

^^ what's that?

> The .config (if ever matters),
> https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config
> 
> [ 9371.260161] ------------[ cut here ]------------
> [ 9371.267143] Stack depot reached limit capacity
> [ 9371.267193] WARNING: CPU: 19 PID: 1181 at lib/stackdepot.c:115 stack_depot_save+0x3d9/0x57d

Is this _the_ warning?

Maybe it really is running out of storage, I don't think this patch is
to blame. The unwind here looks good, so why would the stack-depot
unwind be any different?

> [ 9371.281470] Modules linked in: brd vfat fat ext4 crc16 mbcache jbd2 loop kvm_amd kvm ses enclosure dax_pmem irqbypass dax_pmem_core acpi_cpufreq ip_tables x_table
> s xfs sd_mod bnxt_en smartpqi scsi_transport_sas tg3 i40e libphy firmware_class dm_mirror dm_region_hash dm_log dm_mod [last unloaded: dummy_del_mod]
> [ 9371.310176] CPU: 19 PID: 1181 Comm: systemd-journal Tainted: G           O      5.7.0-next-20200604+ #1
> [ 9371.320700] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 03/09/2018
> [ 9371.329987] RIP: 0010:stack_depot_save+0x3d9/0x57d
> [ 9371.335513] Code: 1d 9b bc 68 01 80 fb 01 0f 87 c0 01 00 00 80 e3 01 75 1f 4c 89 45 c0 c6 05 82 bc 68 01 01 48 c7 c7 e0 85 63 9f e8 9d 74 9d ff <0f> 0b 90 90 4c 8
> b 45 c0 48 c7 c7 80 1a d0 9f 4c 89 c6 e8 b0 2b 46
> [ 9371.355426] RSP: 0018:ffffc90007260490 EFLAGS: 00010082
> [ 9371.361387] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff9ed3207f
> [ 9371.369544] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: 0000000000000000
> [ 9371.377428] RBP: ffffc900072604f8 R08: fffffbfff3f37539 R09: fffffbfff3f37539
> [ 9371.385310] R10: ffffffff9f9ba9c3 R11: fffffbfff3f37538 R12: ffffc90007260508
> [ 9371.393521] R13: 0000000000000036 R14: 0000000000000000 R15: 000000000009fb52
> [ 9371.401403] FS:  00007fc9849f2980(0000) GS:ffff88942fb80000(0000) knlGS:0000000000000000
> [ 9371.410244] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 9371.417007] CR2: 00007f20d02c3000 CR3: 0000000440b9c000 CR4: 00000000003406e0
> [ 9371.424889] Call Trace:
> [ 9371.428054]  <IRQ>
> [ 9371.436315]  save_stack+0x3f/0x50
> [ 9371.734034]  kasan_slab_free+0xe/0x10
> [ 9371.738798]  slab_free_freelist_hook+0x5d/0x1c0
> [ 9371.748886]  kmem_cache_free+0x10c/0x390
> [ 9371.758450]  mempool_free_slab+0x17/0x20
> [ 9371.763522]  mempool_free+0x65/0x170
> [ 9371.767825]  bio_free+0x14c/0x210
> [ 9371.771864]  bio_put+0x59/0x70
> [ 9371.775644]  end_swap_bio_write+0x199/0x250
> [ 9371.780556]  bio_endio+0x22c/0x4e0
> [ 9371.784709]  dec_pending+0x1bf/0x3e0 [dm_mod]
> [ 9371.790207]  clone_endio+0x129/0x3d0 [dm_mod]
> [ 9371.800746]  bio_endio+0x22c/0x4e0
> [ 9371.809262]  blk_update_request+0x3bb/0x980
> [ 9371.814605]  scsi_end_request+0x53/0x420
> [ 9371.824002]  scsi_io_completion+0x10a/0x830
> [ 9371.844445]  scsi_finish_command+0x1b9/0x250
> [ 9371.849445]  scsi_softirq_done+0x1ab/0x1f0
> [ 9371.854272]  blk_mq_force_complete_rq+0x217/0x250
> [ 9371.859708]  blk_mq_complete_request+0xe/0x20
> [ 9371.865171]  scsi_mq_done+0xc1/0x220
> [ 9371.869479]  pqi_aio_io_complete+0x83/0x2c0 [smartpqi]
> [ 9371.881764]  pqi_irq_handler+0x1fc/0x13f0 [smartpqi]
> [ 9371.914115]  __handle_irq_event_percpu+0x81/0x550
> [ 9371.924289]  handle_irq_event_percpu+0x70/0x100
> [ 9371.945559]  handle_irq_event+0x5a/0x8b
> [ 9371.950121]  handle_edge_irq+0x10c/0x370
> [ 9371.950121]  handle_edge_irq+0x10c/0x370
> [ 9371.959858]  asm_call_on_stack+0x12/0x20
> asm_call_on_stack at arch/x86/entry/entry_64.S:710
> [ 9371.964899]  </IRQ>
> [ 9371.967716]  common_interrupt+0x185/0x2a0
> [ 9371.972455]  asm_common_interrupt+0x1e/0x40
> [ 9371.977368] RIP: 0010:__asan_load4+0x8/0xa0
> [ 9371.982281] Code: 00 e8 5c f4 ff ff 5d c3 40 38 f0 0f 9e c0 84 c0 75 e5 5d c3 48 c1 e8 03 80 3c 10 00 75 ed 5d c3 66 90 55 48 89 e5 48 8b 4d 08 <48> 83 ff fb 77 6c eb 3a 0f 1f 00 48 b8 00 00 00 00 00 00 00 ff 48
> [ 9372.002246] RSP: 0018:ffffc9000b12f0e8 EFLAGS: 00000202
> [ 9372.008207] RAX: 0000000000000000 RBX: ffffc9000b12f150 RCX: ffffffff9ed32487
> [ 9372.016489] RDX: 0000000000000007 RSI: 0000000000000002 RDI: ffffffff9ff92a94
> [ 9372.024370] RBP: ffffc9000b12f0e8 R08: fffffbfff3ff1d4d R09: fffffbfff3ff1d4d
> [ 9372.032252] R10: ffffffff9ff8ea67 R11: fffffbfff3ff1d4c R12: 0000000000000000
> [ 9372.040490] R13: ffffc9000b12f358 R14: 000000000000000c R15: 0000000000000005
> [ 9372.053899]  debug_lockdep_rcu_enabled+0x27/0x60
> [ 9372.059248]  rcu_read_lock_held_common+0x12/0x60
> [ 9372.064989]  rcu_read_lock_sched_held+0x60/0xe0
> [ 9372.080338]  shrink_active_list+0xbfd/0xc30
> [ 9372.120481]  shrink_lruvec+0xbf1/0x11b0
> [ 9372.150410]  shrink_node+0x344/0xd10
> [ 9372.154719]  do_try_to_free_pages+0x263/0xa00
> [ 9372.169860]  try_to_free_pages+0x239/0x570
> [ 9372.179356]  __alloc_pages_slowpath.constprop.59+0x5dd/0x1880
> [ 9372.215762]  __alloc_pages_nodemask+0x562/0x670
> [ 9372.232686]  alloc_pages_current+0x9c/0x110
> [ 9372.237599]  alloc_slab_page+0x355/0x530
> [ 9372.242755]  allocate_slab+0x485/0x5a0
> [ 9372.247232]  new_slab+0x46/0x70
> [ 9372.251095]  ___slab_alloc+0x35f/0x810
> [ 9372.274485]  __slab_alloc+0x43/0x70
> [ 9372.287650]  kmem_cache_alloc+0x257/0x3d0
> [ 9372.298182]  prepare_creds+0x26/0x130
> [ 9372.302571]  do_faccessat+0x255/0x3e0
> [ 9372.321591]  __x64_sys_access+0x38/0x40
> [ 9372.326154]  do_syscall_64+0x64/0x340
> [ 9372.330542]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 9372.336329] RIP: 0033:0x7fc983a21bfb
> [ 9372.341050] Code: Bad RIP value.
> [ 9372.345000] RSP: 002b:00007fffd543cde8 EFLAGS: 00000246 ORIG_RAX: 0000000000000015
> [ 9372.353319] RAX: ffffffffffffffda RBX: 00007fffd543fa40 RCX: 00007fc983a21bfb
> [ 9372.361199] RDX: 00007fc983cf1c00 RSI: 0000000000000000 RDI: 00005573ed458090
> [ 9372.369512] RBP: 00007fffd543cf30 R08: 00005573ed44ab99 R09: 0000000000000007
> [ 9372.377393] R10: 0000000000000041 R11: 0000000000000246 R12: 0000000000000000
> [ 9372.385275] R13: 0000000000000000 R14: 00007fffd543cea0 R15: 00005573eecd2990
> [ 9372.393608] irq event stamp: 27274496
> [ 9372.397999] hardirqs last  enabled at (27274495): [<ffffffff9e635b8e>] free_unref_page_list+0x2ee/0x400
> [ 9372.408152] hardirqs last disabled at (27274496): [<ffffffff9ed2c22b>] idtentry_enter_cond_rcu+0x1b/0x50
> [ 9372.418695] softirqs last  enabled at (27272816): [<ffffffff9f000478>] __do_softirq+0x478/0x784
> [ 9372.428154] softirqs last disabled at (27272807): [<ffffffff9e2d0b41>] irq_exit_rcu+0xd1/0xe0
> [ 9372.437435] ---[ end trace d2ebac1fad6e452e ]---
