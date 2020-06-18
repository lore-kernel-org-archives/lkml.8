Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8770C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA20208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m8WGi2kU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgFRSdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbgFRSdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 14:33:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53426C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 11:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aVLm8R+Q91+8RmIp//VNNtXJYZuPXUFZIZifzMG6rG0=; b=m8WGi2kU1DEDwDunDM6TNESyDX
        d+hJpplcx22KNNFGei81awuCCPTrAIQKLBuTAS8LOjo3z3aO5F6d/5k9TbA2DnSVZp5EtCrie7Fov
        KmwLFtB7vadvukNaLzgoSGM6STPSbtKH2NfA86ZrgV8wmMqOkgp5Ts1FmKkBnW5UMq5HIuCrmip3A
        jK5A4PbuXlY8pyXbvkVt5ogvG1WFtQL4lu69g1G2XlSIbMmS7rcFmrGzjXeommzDRigHDSheXfaJm
        G78pTZ8AYQR7C5Fvp0AjeIXyhV0Qxo09yy7QDft+lGSMyNaHpela5TzfNuC3Vh9o5BljdLCtLrz1M
        ozAtU5rA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlzLV-0005rw-Dl; Thu, 18 Jun 2020 18:33:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E007B303CE9;
        Thu, 18 Jun 2020 20:33:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D093D2128846A; Thu, 18 Jun 2020 20:33:02 +0200 (CEST)
Date:   Thu, 18 Jun 2020 20:33:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Tejun Heo <tj@kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Francis Ricci <fjricci@fb.com>
Subject: Re: WARNING with LBR + precise_ip=2 + bpf_get_stackid()
Message-ID: <20200618183302.GN576905@hirez.programming.kicks-ass.net>
References: <ED7B9430-6489-4260-B3C5-9CFA2E3AA87A@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ED7B9430-6489-4260-B3C5-9CFA2E3AA87A@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 05:25:24PM +0000, Song Liu wrote:

> PID: 80430  TASK: ffff888d92c62a80  CPU: 24  COMMAND: "25_scheduler"
> #0 [fffffe00004cfd88] machine_kexec at ffffffff8104a646
> #1 [fffffe00004cfdd8] __crash_kexec at ffffffff8114a82f
> #2 [fffffe00004cfea0] panic at ffffffff810ba99c
> #3 [fffffe00004cff20] df_debug at ffffffff8104e21d
> #4 [fffffe00004cff30] do_double_fault at ffffffff8101c9b4
> #5 [fffffe00004cff50] double_fault at ffffffff81c00b3e
> [exception RIP: vsnprintf+14]
> RIP: ffffffff81a3ee6e  RSP: fffffe00004d0ff8  RFLAGS: 00010082
> RAX: fffffe00004d1070  RBX: fffffe00004d1101  RCX: fffffe00004d1050
> RDX: ffffffff822c42f5  RSI: 000000007fffffff  RDI: fffffe00004d111a
> RBP: fffffe00004d10a0   R8: 0000000000000067   R9: ffffffff82209d05
> R10: ffffffff822a5fd0  R11: ffffffff822a6358  R12: 0000000000000019
> R13: 0000000000000001  R14: 0000000000000019  R15: ffffffff822b5fd6
> ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> --- <DOUBLEFAULT exception stack> ---
> #6 [fffffe00004d0ff8] vsnprintf at ffffffff81a3ee6e
> bt: cannot transition from exception stack to current process stack:
> exception stack pointer: fffffe00004cfd88
> process stack pointer: fffffe00004d1048
> current stack base: ffffc900241a0000
> 
> 0xfffffe00004d1040 kallsyms_token_index
> 0xfffffe00004d1048 sprintf
> 0xfffffe00004d1078 kallsyms_lookup
> 0xfffffe00004d1098 kallsyms_names
> 0xfffffe00004d10a8 __sprint_symbol
> 0xfffffe00004d10d8 textbuf.47672
> 0xfffffe00004d10e0 always_kmsg_dump
> 0xfffffe00004d10f8 symbol_string
> 0xfffffe00004d11c0 textbuf.47672
> 0xfffffe00004d11e8 textbuf.47672
> 0xfffffe00004d11f8 textbuf.47672
> 0xfffffe00004d1200 always_kmsg_dump
> 0xfffffe00004d1210 kallsyms_token_index
> 0xfffffe00004d1218 vsnprintf
> 0xfffffe00004d1220 textbuf.47672
> 0xfffffe00004d1258 kallsyms_token_index
> 0xfffffe00004d1270 vscnprintf
> 0xfffffe00004d1280 vprintk_store
> 0xfffffe00004d1290 wake_up_klogd
> 0xfffffe00004d12b0 kallsyms_token_index
> 0xfffffe00004d12c8 vprintk_emit
> 0xfffffe00004d1300 entry_SYSCALL_64
> 0xfffffe00004d1318 vprintk_deferred
> 0xfffffe00004d1328 printk_deferred
> 0xfffffe00004d1360 entry_SYSCALL_64
> 0xfffffe00004d1380 __start_orc_unwind
> 0xfffffe00004d1388 unwind_next_frame.cold.7
> 0xfffffe00004d13c8 perf_callchain_kernel
> 0xfffffe00004d1418 entry_SYSCALL_64
> 0xfffffe00004d1450 get_perf_callchain
> 0xfffffe00004d14b0 bpf_get_stack

This, this is where it gets buggerd. This is a BPF problem, not a perf
problem.

You'll note that if you ask perf for a PERF_SAMPLE_CALLCHAIN we'll do
that early in setup_pebs_fixed_sample_data().

> 0xfffffe00004d1730 bpf_overflow_handler
> 0xfffffe00004d1788 __perf_event_overflow
> 0xfffffe00004d17a0 x86_pmu
> 0xfffffe00004d17b8 __intel_pmu_pebs_event
> 0xfffffe00004d17e0 setup_pebs_fixed_sample_data
> 0xfffffe00004d1890 entry_SYSCALL_64
> 0xfffffe00004d1ab8 intel_pmu_drain_pebs_nhm
> 0xfffffe00004d1ac0 setup_pebs_fixed_sample_data
> 0xfffffe00004d1bb8 handle_pmi_common
> 0xfffffe00004d1d00 insn_get_sib.part.5
> 0xfffffe00004d1d10 insn_get_displacement.part.6
> 0xfffffe00004d1d20 insn_get_immediate.part.7
> 0xfffffe00004d1d38 __set_pte_vaddr
> 0xfffffe00004d1d78 __native_set_fixmap
> 0xfffffe00004d1d80 ghes_copy_tofrom_phys
> 0xfffffe00004d1e08 intel_pmu_handle_irq
> 0xfffffe00004d1e48 perf_event_nmi_handler
> 0xfffffe00004d1e50 perf_event_nmi_handler_na.47078
> 0xfffffe00004d1e58 nmi_reason_lock
> 0xfffffe00004d1e60 nmi_handle
> 0xfffffe00004d1e70 nmi_desc
> 0xfffffe00004d1e90 nmi_reason_lock
> 0xfffffe00004d1eb8 default_do_nmi
> 0xfffffe00004d1ed8 do_nmi
> 0xfffffe00004d1ef0 nmi
> 0xfffffe00004d1f78 entry_SYSCALL_64
> 0xfffffe00004d1fa0 entry_SYSCALL_64
> 0xfffffe00004d1fd8 entry_SYSCALL_64
> 
> The kernel is running the normal NMI path and triggers the above mentioned warnings, 
> which calls into string formatting path for the warning messages. 

> However, NMIs run 
> off of its dedicated exception stack which is 4k in size, which is too small for the 
> full string formatting path to run,

Say what ?! Has printk() grown into such a freakish monster that it
cannot run on 4k stacks anymore?

I suppose that KSYM_SYMBOL_LEN on-stack buffer in symbol_string()
doesn't help.

> We noticed that this only happens with precise_ip >= 2. This is caused by 
> setup_pebs_fixed_sample_data() using pens->real_ip:
> 
> 	set_linear_ip(regs, pebs->real_ip);
> 
> For our use case, we do need precise_ip=2. So we would like suggestions to fix the
> warning and/or to avoid double fault. 

It all works as advertised. The BPF program is broken for calling
bpf_get_stack() on a PEBS event.
