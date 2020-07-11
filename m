Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDADCC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 01:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BED0B2075F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 01:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594431137;
	bh=JHAq849TrDR2TO0YVgHnBwsgpBJXggDvOdSCDOO9Mhg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Mb1qe4jLCDfjtkn32XWKo80Kv7uzyGqdA0t9y2k8AD8FWeeCZYs3N8foAUSIvpB89
	 YvtIfzSYkGSsARhwkI17bGY+kaRS2juoXX2r7qZ8DnkuQmpnSDQ4dOOCKfpzXS4Nrr
	 UDwvw2tigZ9ykyz289nJ2YMq9u027AsqByOVju/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgGKBcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 21:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgGKBcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 21:32:16 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E30AC2077D;
        Sat, 11 Jul 2020 01:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594431135;
        bh=JHAq849TrDR2TO0YVgHnBwsgpBJXggDvOdSCDOO9Mhg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bMfSdxB7MrcYqYQa7ldPOwQ86Zvf7PpQlWpXfKwWn1cLEuXE64jZUFUYBu6rYOzyI
         iW9WNDqwkrk0sgSJttDTT1OJ/ku53mvBNojP8dEQQR8KaZXPa7y6EUoPqUh/FVz9eG
         YFLH08D+jTSwcQCN2Sb1ues3kIAJ8EMD9qUmzR5A=
Received: by mail-lj1-f182.google.com with SMTP id q4so8455722lji.2;
        Fri, 10 Jul 2020 18:32:14 -0700 (PDT)
X-Gm-Message-State: AOAM533i9RSOURlAFGvve92goWza/FThJwSuHSocrh6mjc95rlGTOZ+4
        3TqNKT67wiC+0SZv7TtaKeQ1BnH3eYxsadrDbL4=
X-Google-Smtp-Source: ABdhPJyp9YYFId4+bHFEau35i4Dd+Jo03McSql50a82wua8FHQxiDnZqzZ8IFMQAFMi/x1kxYJ6SWwlxiHASFRW9a30=
X-Received: by 2002:a2e:b0ed:: with SMTP id h13mr31505047ljl.250.1594431133218;
 Fri, 10 Jul 2020 18:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <1594261154-69745-1-git-send-email-guoren@kernel.org>
 <1594261154-69745-7-git-send-email-guoren@kernel.org> <20200710225017.5ce329485e911f99e17cd483@kernel.org>
In-Reply-To: <20200710225017.5ce329485e911f99e17cd483@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 11 Jul 2020 09:32:01 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSfFY6qf7gZ9t80P-3cACWi3oEe4X8ek+_1nQZZT3Uk5w@mail.gmail.com>
Message-ID: <CAJF2gTSfFY6qf7gZ9t80P-3cACWi3oEe4X8ek+_1nQZZT3Uk5w@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] riscv: Add KPROBES_ON_FTRACE supported
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Atish Patra <atish.patra@wdc.com>, penberg@kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Masami,

On Fri, Jul 10, 2020 at 9:50 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Guo,
>
> On Thu,  9 Jul 2020 02:19:14 +0000
> guoren@kernel.org wrote:
>
> > +/* Ftrace callback handler for kprobes -- called under preepmt disabed */
> > +void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> > +                        struct ftrace_ops *ops, struct pt_regs *regs)
> > +{
> > +     struct kprobe *p;
> > +     struct kprobe_ctlblk *kcb;
> > +
> > +     p = get_kprobe((kprobe_opcode_t *)ip);
> > +     if (unlikely(!p) || kprobe_disabled(p))
> > +             return;
> > +
> > +     kcb = get_kprobe_ctlblk();
> > +     if (kprobe_running()) {
> > +             kprobes_inc_nmissed_count(p);
> > +     } else {
> > +             /*
> > +              * The regs->epc hasn't been saved by SAVE_ALL in mcount-dyn.S
> > +              * So no need to resume it, just for kprobe handler.
> > +              */
> > +             instruction_pointer_set(regs, ip);
> > +             __this_cpu_write(current_kprobe, p);
> > +             kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> > +             if (!p->pre_handler || !p->pre_handler(p, regs)) {
> > +                     /*
> > +                      * Emulate singlestep (and also recover regs->pc)
> > +                      * as if there is a nop
> > +                      */
> > +                     instruction_pointer_set(regs,
> > +                             (unsigned long)p->addr + MCOUNT_INSN_SIZE);
> > +                     if (unlikely(p->post_handler)) {
> > +                             kcb->kprobe_status = KPROBE_HIT_SSDONE;
> > +                             p->post_handler(p, regs, 0);
> > +                     }
>
> Hmm, don't you need restoring the previous instruction pointer here?
look at  riscv mcount-dyn.S SAVE_ALL function, sp frame lay out like this:
-----------------------
| return address |
-----------------------
| frame pointer   |
-----------------------
| pt_regs x1-x31|
-----------------------
It's not a complete pt_regs for the handler, so modifing regs->ip is no use.

> If you don't support modifying the instruction pointer in the handler,
We can modify ip like this if necessary:
*(unsigned long *)((unsigned long)regs + sizeof(struct pt_regs) + 8) = xxx;

> it must not be compatible with kprobes.
Why, can you show related codes? thank you very much.

>
> Now BPF function override and function error injection depends on
> this behevior, so could you consider to support it in the "ftrace"
> implementation at first? (And if it is enabled, you can enable the
> livepatch on RISCV too)
Great message!

But can you show me codes that bpf and err-jnject using the behavior? Thx

I'll try to fix up it :)

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
