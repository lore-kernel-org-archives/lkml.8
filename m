Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C172C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BBA2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="khIynogh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgDFKV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 06:21:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58752 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgDFKVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 06:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7HULiCo0Bk8vmaxX5+hLzxEjatTFSFqcDu3M2RLxE0M=; b=khIynoghPES657egNG6RavBCQC
        g0vTyhMcvOu4TkmVd9hzcTMNEavXGh+2Esr5OzLIfDBBVQ05gx3M5skhWs2CVMrO1uWlw+dlXEBpc
        IjlYMHepOP2o0LJ1JYhHWueYOcc0AmySRO8krfidzLJU+NaPmg6zMuVbjSlK94ejoOih3XQlmQihf
        NgzctzBhJUgqdHlb+AVMlomUbdd7lSTjpDGf4xe6ApsNLVx8IKJARdKSaQtsGI54GNOYPQcu+WX0j
        zfe9MlsewwrbD0of6LJ3CpoBpukZejEyxeHjfMb/KfoR5Xa03QZR52mbXiTVVnGNtzNGgXx8SIiEQ
        A83P1FGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLOsR-00056x-7X; Mon, 06 Apr 2020 10:21:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB1493025C3;
        Mon,  6 Apr 2020 12:21:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A3B1B2B155621; Mon,  6 Apr 2020 12:21:07 +0200 (CEST)
Date:   Mon, 6 Apr 2020 12:21:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jann Horn <jannh@google.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse, -msse2
 without any visible FPU state protection
Message-ID: <20200406102107.GI20730@hirez.programming.kicks-ass.net>
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
 <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
 <20200402141308.GB20730@hirez.programming.kicks-ass.net>
 <20200403142837.f61a18d7bd32fd73777479ad@kernel.org>
 <20200403112113.GN20730@hirez.programming.kicks-ass.net>
 <20200404120808.05e9aa61500265be2e031bd6@kernel.org>
 <20200404143224.GL2452@worktop.programming.kicks-ass.net>
 <20200405121930.e3ea3e7acc7588102de483e2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200405121930.e3ea3e7acc7588102de483e2@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 05, 2020 at 12:19:30PM +0900, Masami Hiramatsu wrote:

> > @@ -269,14 +269,14 @@ d4: AAM Ib (i64)
> >  d5: AAD Ib (i64)
> >  d6:
> >  d7: XLAT/XLATB
> > -d8: ESC
> > -d9: ESC
> > -da: ESC
> > -db: ESC
> > -dc: ESC
> > -dd: ESC
> > -de: ESC
> > -df: ESC
> > +d8: FPU
> > +d9: FPU
> > +da: FPU
> > +db: FPU
> > +dc: FPU
> > +dd: FPU
> > +de: FPU
> > +df: FPU
> 
> I don't want to use FPU since Intel SDM is still using ESC because it
> is co-processor escape code.

But we all know that co-processor is x87. Can we then perhaps put in
'x87' as an escape code instead of 'ESC' ?

> Here is the new patch. 
> 
> From d7eca4946ab3f0d08ad1268f49418f8655aaf57c Mon Sep 17 00:00:00 2001
> From: Masami Hiramatsu <mhiramat@kernel.org>
> Date: Fri, 3 Apr 2020 16:58:22 +0900
> Subject: [PATCH] x86: insn: Add insn_is_fpu()
> 
> Add insn_is_fpu(insn) which tells that the insn is
> whether touch the MMX/XMM/YMM register or the instruction
> of FP coprocessor.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

arch/x86/mm/extable.o: warning: objtool: ex_handler_fprestore()+0x8b: fpu_safe hint not an FPU instruction
008b  36b:      48 0f ae 0d 00 00 00    fxrstor64 0x0(%rip)        # 373 <ex_handler_fprestore+0x93>

arch/x86/kvm/x86.o: warning: objtool: kvm_load_guest_fpu.isra.0()+0x1fa: fpu_safe hint not an FPU instruction
01fa    1d2fa:  48 0f ae 4b 40          fxrstor64 0x40(%rbx)



Also, all the VMX bits seems to qualify as FPU (I can't remember seeing
that previously):

arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_apic_eoi_induced()+0x20: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_apic_write()+0x20: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_invlpg()+0x20: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_get_interrupt_shadow()+0x1c: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_decache_cr4_guest_bits()+0x5a: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_decache_cr0_guest_bits()+0x5a: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_io()+0x24: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_apic_access()+0x39: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_get_idt()+0x57: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_get_exit_info()+0x58: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_get_gdt()+0x57: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_guest_apic_has_interrupt()+0xf8: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_nmi_allowed()+0x98: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_handle_exit_irqoff()+0xb3: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_get_nmi_mask()+0x8a: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_get_rflags()+0x99: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_ept_misconfig()+0x22: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_interrupt_allowed()+0x8d: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_write_pml_buffer()+0x1c5: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_invpcid()+0x26a: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_read_guest_seg_ar()+0x9b: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_read_guest_seg_selector()+0x96: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_read_guest_seg_base()+0x9b: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_get_segment()+0x2da: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmwrite_error()+0x161: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: exec_controls_set.isra.0()+0x5a: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_dr()+0x1bc: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: update_exception_bitmap()+0x136: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_interrupt_shadow()+0x8b: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: skip_emulated_instruction()+0xe9: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_exception_nmi()+0x674: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_clear_hlt.isra.0()+0xe5: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_idt()+0x65: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_gdt()+0x65: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: seg_setup()+0x125: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_nmi_mask()+0x11c: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: __vmx_complete_interrupts()+0x167: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_task_switch()+0x34d: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_dr7()+0x1e: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: update_cr8_intercept()+0x1a2: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_hwapic_isr_update()+0x8a: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_rvi()+0x87: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_load_eoi_exitmap()+0x107: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_rflags()+0x20f: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: fix_rmode_seg()+0x1de: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_segment()+0x28b: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: enter_pmode()+0x1ad: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: enter_rmode()+0x27e: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_write_l1_tsc_offset()+0x11b: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_pml_full()+0x138: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_cancel_injection()+0x5d: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_queue_exception()+0x10d: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_inject_nmi()+0xd1: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_inject_irq()+0x127: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_ept_violation()+0x13e: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: enable_irq_window()+0x71: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_interrupt_window()+0x71: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_nmi_window()+0x92: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_sync_dirty_debug_regs()+0x203: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: enable_nmi_window()+0xca: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: clear_atomic_switch_msr()+0x2ba: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: add_atomic_switch_msr.constprop.0()+0x314: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_vcpu_run()+0xc16: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_host_fs_gs()+0x1f9: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_vcpu_load_vmcs()+0x404: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_cr4()+0x240: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_get_msr()+0x49d: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_cpuid_update()+0xc89: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: ept_save_pdptrs()+0x176: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_cache_reg()+0xe3: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_cr3()+0x47: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_apic_access_page_addr()+0x9f: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_efer()+0x22f: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_cr0()+0x15e: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: handle_cr()+0xe1d: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_vcpu_reset()+0x1a98: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_virtual_apic_mode()+0x216: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_refresh_apicv_exec_ctrl()+0x2e0: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_msr()+0xf26: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_set_constant_host_state()+0x364: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: set_cr4_guest_host_mask()+0xda: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: init_vmcs()+0x1705: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: dump_vmcs.cold()+0x193c: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_handle_exit()+0xcfc: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_update_host_rsp()+0x65: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_dump_dtsel()+0x5d: FPU instruction outside of kernel_fpu_{begin,end}()
arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_dump_sel()+0xda: FPU instruction outside of kernel_fpu_{begin,end}()


./objdump-func.sh defconfig-build/arch/x86/kvm/vmx/vmx.o ept_save_pdptrs | grep 176
0176    1d436:  41 0f 78 c4             vmread %rax,%r12


