Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15D4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BAE6207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594389024;
	bh=In0YOJkA3w7O35oZQkhR6Xs3Z6653LLM+6Ev004T7dg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qxKgKgseNIQABd1GWxgEoD6Beh4bHnbFf/eDSg2Fb9o5+0qoQuya8IctTTSA5BRKp
	 qw/Tmsnps1plM76Yayz4iJVDVx5IM58bwKOXlo+iBD5BUQY7ar6hTwWoyqbJemknmr
	 WbWOqNE/qcmqVUHRgTSMR6cN+kYWMPno8Lmw8nos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgGJNuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726965AbgGJNuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:50:22 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 075632064B;
        Fri, 10 Jul 2020 13:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594389022;
        bh=In0YOJkA3w7O35oZQkhR6Xs3Z6653LLM+6Ev004T7dg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pr0Ks08N4TqEHRkkVNv/YzDtzu1bHPCyMMe1BkNX3T+JxjVueFzwsIadyMRsA8U/d
         sgDd2o4xNZqOv3gYmuYMo4SPJt82ZnVZJ6xXAb7qU0opCl6xhYh0FsRxwQ0hyAtW18
         RljlWhtXhPIjUATorUHl1BRmj0VrBlnSUTJXJicI=
Date:   Fri, 10 Jul 2020 22:50:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     guoren@kernel.org
Cc:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        me@packi.ch, bjorn.topel@gmail.com, atish.patra@wdc.com,
        penberg@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH v2 6/6] riscv: Add KPROBES_ON_FTRACE supported
Message-Id: <20200710225017.5ce329485e911f99e17cd483@kernel.org>
In-Reply-To: <1594261154-69745-7-git-send-email-guoren@kernel.org>
References: <1594261154-69745-1-git-send-email-guoren@kernel.org>
        <1594261154-69745-7-git-send-email-guoren@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo,

On Thu,  9 Jul 2020 02:19:14 +0000
guoren@kernel.org wrote:

> +/* Ftrace callback handler for kprobes -- called under preepmt disabed */
> +void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> +			   struct ftrace_ops *ops, struct pt_regs *regs)
> +{
> +	struct kprobe *p;
> +	struct kprobe_ctlblk *kcb;
> +
> +	p = get_kprobe((kprobe_opcode_t *)ip);
> +	if (unlikely(!p) || kprobe_disabled(p))
> +		return;
> +
> +	kcb = get_kprobe_ctlblk();
> +	if (kprobe_running()) {
> +		kprobes_inc_nmissed_count(p);
> +	} else {
> +		/*
> +		 * The regs->epc hasn't been saved by SAVE_ALL in mcount-dyn.S
> +		 * So no need to resume it, just for kprobe handler.
> +		 */
> +		instruction_pointer_set(regs, ip);
> +		__this_cpu_write(current_kprobe, p);
> +		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> +		if (!p->pre_handler || !p->pre_handler(p, regs)) {
> +			/*
> +			 * Emulate singlestep (and also recover regs->pc)
> +			 * as if there is a nop
> +			 */
> +			instruction_pointer_set(regs,
> +				(unsigned long)p->addr + MCOUNT_INSN_SIZE);
> +			if (unlikely(p->post_handler)) {
> +				kcb->kprobe_status = KPROBE_HIT_SSDONE;
> +				p->post_handler(p, regs, 0);
> +			}

Hmm, don't you need restoring the previous instruction pointer here?
If you don't support modifying the instruction pointer in the handler,
it must not be compatible with kprobes.

Now BPF function override and function error injection depends on
this behevior, so could you consider to support it in the "ftrace"
implementation at first? (And if it is enabled, you can enable the
livepatch on RISCV too)

Thank you,

> +		}
> +
> +		/*
> +		 * If pre_handler returns !0, it changes regs->pc. We have to
> +		 * skip emulating post_handler.
> +		 */
> +		__this_cpu_write(current_kprobe, NULL);
> +	}
> +}
> +NOKPROBE_SYMBOL(kprobe_ftrace_handler);
> +
> +int arch_prepare_kprobe_ftrace(struct kprobe *p)
> +{
> +	p->ainsn.api.insn = NULL;
> +	return 0;
> +}
> -- 
> 2.7.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
