Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7E6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0BD4207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590581366;
	bh=VrdlrClycSy9gtf/KSdBi9zHr+KuvDzq8tsxgjnV8Fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZT4N8HXX6vmZKYwaRM7W59f6y9xqLBcV+eJDZJEPr1VIKAuBeU5Q+V0XJ3OfZM4nb
	 Lr9of9Do5Iyg1BP6dARkK18e4L6s7yxQY8RsDME2fX4xdhkw5500HvD8gEET3ALKS+
	 JhU0zjt3ckdhX/ga2m9NKwVT9PYO07hiDHuVD3t4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgE0MJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 08:09:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33169 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgE0MJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:09:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id j198so2134239wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 05:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8fod+w8sp6AZ7X1I57Z7BArlEq5eDNaW6/lgL38pnK0=;
        b=ae/Vb/DtriHnVnCYreU1vV4dwT60DGiPOJz+EJsa1RFj0FmnGgPn0Y/0NENpsp5O9c
         PBIIMvDr9OByvHVJQvTLE1+ttloOAI2uJU0cYjkADyPznd8OzVur48+dkbKHlDhUP3Lr
         dzD7gxjJLSydc8HeRNqD2lA8NNXMMc9GSEL9IJcoEgVcao6zkXY2vqgYKoQIjqFNvLLE
         WAmU+j3kBlVjFwCayKOiMiXo2A/HpQOCwUL9Sl939wJ39DG/KGBbgcwWiugx+voxfTHZ
         Iu9L1evR86JWfd5MSUmci57adplWS7ryK+amM2B/aElzZGDaMQHBbcThfcRzxMrtc0uw
         kuqg==
X-Gm-Message-State: AOAM5339KugncFHC8b9jhLVW6kIfl8XhEc4OSsH0YrEafzIfNtvjSmYk
        I4AxNeCoGAZWYUyaZTnlSAM=
X-Google-Smtp-Source: ABdhPJyDzXwJbv3Cz/+r7FTSvD0ZSpnkPr2nL+VIbkVCZeGhK9U8UDrFhRsOPJMdybDLh3Zv1tUFBg==
X-Received: by 2002:a1c:2bc1:: with SMTP id r184mr4094495wmr.58.1590581360832;
        Wed, 27 May 2020 05:09:20 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u13sm2623270wrp.53.2020.05.27.05.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 05:09:20 -0700 (PDT)
Date:   Wed, 27 May 2020 12:09:18 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
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
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V9 30/39] x86/entry: Convert various hypervisor vectors
 to IDTENTRY_SYSVEC
Message-ID: <20200527120918.ly5vuhvxzqesdt6j@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
References: <20200521200513.656533920@linutronix.de>
 <20200521202119.647997594@linutronix.de>
 <20200527014616.GA123239@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200527083803.gpigonfy2kd2g5t4@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527083803.gpigonfy2kd2g5t4@debian>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 09:38:03AM +0100, Wei Liu wrote:
> On Wed, May 27, 2020 at 09:46:16AM +0800, Boqun Feng wrote:
> > Hi Thomas,
> > 
> > On Thu, May 21, 2020 at 10:05:43PM +0200, Thomas Gleixner wrote:
> > > From: Thomas Gleixner <tglx@linutronix.de>
> > > 
> > > Convert various hypervisor vectors to IDTENTRY_SYSVEC
> > >   - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
> > >   - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
> > >   - Remove the ASM idtentries in 64bit
> > >   - Remove the BUILD_INTERRUPT entries in 32bit
> > >   - Remove the old prototypes
> > > 
> > > No functional change.
> > > 
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > Acked-by: Andy Lutomirski <luto@kernel.org>
> > 
> > I hit the following while trying to test the whole patchset on a Hyper-V
> > guest, and git bisect told me this patch introduced the problem, the
> > config file is in the attachment.
> > 
> > Regards,
> > Boqun
> > 
> 
> Hi Boqun,
> 
> Thanks for testing and reporting.
> 
> This patch modifies Hyper-V's entry point so no wonder you pin down this
> patch.
> 
> > [    3.366637] BUG: kernel NULL pointer dereference, address: 0000000000000010
> > [    3.369959] #PF: supervisor instruction fetch in kernel mode
> > [    3.369959] #PF: error_code(0x0010) - not-present page
> > [    3.369959] PGD 0 P4D 0
> > [    3.369959] Oops: 0010 [#1] PREEMPT SMP PTI
> > [    3.369959] CPU: 27 PID: 0 Comm: swapper/27 Not tainted 5.7.0-rc5-00374-ge2d215d23d72 #23
> > [    3.369959] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.0 05/16/2019
> > [    3.369959] RIP: 0010:0x10
> 
> Hmmm... NULL pointer here.
> 
> > [    3.369959] Code: Bad RIP value.
> > [    3.369959] RSP: 0000:ffffbf444018beb8 EFLAGS: 00010086
> > [    3.369959] RAX: 000000000000001b RBX: ffffa04620900000 RCX: 00000000c8aab6dc
> > [    3.369959] RDX: 0000000000000001 RSI: ffffffffb390feaf RDI: ffffffffb3919e60
> > [    3.369959] RBP: 000000000000001b R08: 0000000000000000 R09: 0000000000000101
> > [    3.369959] R10: 0000000000dda899 R11: 0000000001d417ad R12: 0000000000000000
> > [    3.369959] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > [    3.369959] FS:  0000000000000000(0000) GS:ffffa04627ac0000(0000) knlGS:0000000000000000
> > [    3.369959] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    3.369959] CR2: ffffffffffffffe6 CR3: 000000101bcba002 CR4: 00000000003606e0
> > [    3.369959] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [    3.369959] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [    3.369959] Call Trace:
> > [    3.369959]  ? default_idle+0x1c/0x190
> > [    3.369959]  ? do_idle+0x1cd/0x230
> > [    3.369959]  ? cpu_startup_entry+0x19/0x20
> > [    3.369959]  ? secondary_startup_64+0xa4/0xb0
> 
> And I certainly didn't expect this.
> 
> > [    3.369959] Modules linked in: crc32c_intel hv_vmbus(+)
> 
> VMBus is being loaded. That gives me some clue.
> 
> I notice a hunk in the patch:
> 
> @@ -331,17 +327,19 @@ static void __init ms_hyperv_init_platfo
>         x86_platform.apic_post_init = hyperv_init;
>         hyperv_setup_mmu_ops();
>         /* Setup the IDT for hypervisor callback */
> -       alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, hyperv_callback_vector);
> +       alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, sysvec_hyperv_callback);
> 
> It is not using the asm variant.
> 
> Could this be the culprit? Thomas?
> 

I'm able to reproduce the issue locally.  And after applying the
following diff I'm able to get a VM booting again on Hyper-V.

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index a103e1c0b90e..af94f05a5c66 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -327,7 +327,7 @@ static void __init ms_hyperv_init_platform(void)
        x86_platform.apic_post_init = hyperv_init;
        hyperv_setup_mmu_ops();
        /* Setup the IDT for hypervisor callback */
-       alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, sysvec_hyperv_callback);
+       alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_hyperv_callback);

        /* Setup the IDT for reenlightenment notifications */
        if (ms_hyperv.features & HV_X64_ACCESS_REENLIGHTENMENT) {

Boqun, can you give this a try?

Thomas, feel free to fold this in.

Wei.
