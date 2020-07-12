Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0EBC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BBDA206D9
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594561077;
	bh=bhY7zQPI40DPChwSXUzdQqdIEuZ9kJIomhYQgBXWoI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=XmESvMHSneqkWGUD7JgHp5YnVMqPP4037fpyofdDDvIpG6sWBM6cQZ+kVXrj7OHal
	 Vh7FyU6G0yEL7j4MCr16memMoC4+kFoIklWwcjn5n3YQpdCEkPSY3Kxli5PMyD0n9P
	 dT371EkCD59oUX4IY1fU7vymf7na4Oan0cTcqPQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgGLNhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:37:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbgGLNhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:37:55 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6028D206B6;
        Sun, 12 Jul 2020 13:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594561074;
        bh=bhY7zQPI40DPChwSXUzdQqdIEuZ9kJIomhYQgBXWoI0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1QAUfCtEAu3GOYaJw7LLKPSzRIYj9pFgcgpA0ghV91mg5fpskLvnYbD51Q+EdF1Fi
         4YxIpRX7HQrfI2mY8m/PCl0yELMlmNcpzPV8rF6E0u2ehacqhw8ViYovaYDS9PDoux
         GpEjBhwQYZeenLBBowZZU+nUKDKY1t4jOCx1lz2Y=
Date:   Sun, 12 Jul 2020 22:37:48 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Patrick =?UTF-8?B?U3TDpGhsaW4=?= <me@packi.ch>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Atish Patra <atish.patra@wdc.com>, penberg@kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH v2 6/6] riscv: Add KPROBES_ON_FTRACE supported
Message-Id: <20200712223748.9cb00fdf7938fbf7353c11cc@kernel.org>
In-Reply-To: <CAJF2gTSfFY6qf7gZ9t80P-3cACWi3oEe4X8ek+_1nQZZT3Uk5w@mail.gmail.com>
References: <1594261154-69745-1-git-send-email-guoren@kernel.org>
        <1594261154-69745-7-git-send-email-guoren@kernel.org>
        <20200710225017.5ce329485e911f99e17cd483@kernel.org>
        <CAJF2gTSfFY6qf7gZ9t80P-3cACWi3oEe4X8ek+_1nQZZT3Uk5w@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jul 2020 09:32:01 +0800
Guo Ren <guoren@kernel.org> wrote:

> Thx Masami,
> 
> On Fri, Jul 10, 2020 at 9:50 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi Guo,
> >
> > On Thu,  9 Jul 2020 02:19:14 +0000
> > guoren@kernel.org wrote:
> >
> > > +/* Ftrace callback handler for kprobes -- called under preepmt disabed */
> > > +void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> > > +                        struct ftrace_ops *ops, struct pt_regs *regs)
> > > +{
> > > +     struct kprobe *p;
> > > +     struct kprobe_ctlblk *kcb;
> > > +
> > > +     p = get_kprobe((kprobe_opcode_t *)ip);
> > > +     if (unlikely(!p) || kprobe_disabled(p))
> > > +             return;
> > > +
> > > +     kcb = get_kprobe_ctlblk();
> > > +     if (kprobe_running()) {
> > > +             kprobes_inc_nmissed_count(p);
> > > +     } else {
> > > +             /*
> > > +              * The regs->epc hasn't been saved by SAVE_ALL in mcount-dyn.S
> > > +              * So no need to resume it, just for kprobe handler.
> > > +              */
> > > +             instruction_pointer_set(regs, ip);
> > > +             __this_cpu_write(current_kprobe, p);
> > > +             kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> > > +             if (!p->pre_handler || !p->pre_handler(p, regs)) {
> > > +                     /*
> > > +                      * Emulate singlestep (and also recover regs->pc)
> > > +                      * as if there is a nop
> > > +                      */
> > > +                     instruction_pointer_set(regs,
> > > +                             (unsigned long)p->addr + MCOUNT_INSN_SIZE);
> > > +                     if (unlikely(p->post_handler)) {
> > > +                             kcb->kprobe_status = KPROBE_HIT_SSDONE;
> > > +                             p->post_handler(p, regs, 0);
> > > +                     }
> >
> > Hmm, don't you need restoring the previous instruction pointer here?
> look at  riscv mcount-dyn.S SAVE_ALL function, sp frame lay out like this:
> -----------------------
> | return address |
> -----------------------
> | frame pointer   |
> -----------------------
> | pt_regs x1-x31|
> -----------------------
> It's not a complete pt_regs for the handler, so modifing regs->ip is no use.

Yes, that is same on x86. But ftrace regs_caller on x86-64 modifies the
return address on the stack by regs->ip.

See arch/x86/kernel/ftrace_64.S:

-----
SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
        call ftrace_stub

        /* Copy flags back to SS, to restore them */
        movq EFLAGS(%rsp), %rax
        movq %rax, MCOUNT_REG_SIZE(%rsp)

        /* Handlers can change the RIP */
        movq RIP(%rsp), %rax
        movq %rax, MCOUNT_REG_SIZE+8(%rsp)
-----

The last part update the return address on the stack.

> > If you don't support modifying the instruction pointer in the handler,
> We can modify ip like this if necessary:
> *(unsigned long *)((unsigned long)regs + sizeof(struct pt_regs) + 8) = xxx;
> 
> > it must not be compatible with kprobes.
> Why, can you show related codes? thank you very much.

The "Changing Execution Path" section in the Documentation/kprobes.txt said

-----
Since kprobes can probe into a running kernel code, it can change the
register set, including instruction pointer.
-----

As you can see, this is the expected behavior on kprobes.
Since user will not know the kprobes is working on a breakpoint or
ftrace, we have to support this behavior transparently. So, could you
enable this feature at first on ftrace@RISCV?

> 
> >
> > Now BPF function override and function error injection depends on
> > this behevior, so could you consider to support it in the "ftrace"
> > implementation at first? (And if it is enabled, you can enable the
> > livepatch on RISCV too)
> Great message!
> 
> But can you show me codes that bpf and err-jnject using the behavior? Thx

In kernel/fail_function.c

-----
static int fei_kprobe_handler(struct kprobe *kp, struct pt_regs *regs)
{
        struct fei_attr *attr = container_of(kp, struct fei_attr, kp);

        if (should_fail(&fei_fault_attr, 1)) {
                regs_set_return_value(regs, attr->retval);
                override_function_with_return(regs);
                return 1;
        }

        return 0;
}
-----

And follow the code related to CONFIG_BPF_KPROBE_OVERRIDE in
kernel/trace/bpf_trace.c. (doing similar thing, but fail_function.c
is simpler.)

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
