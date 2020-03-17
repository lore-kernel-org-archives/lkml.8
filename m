Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E043C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516E020663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="C36HycbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgCQPef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:34:35 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:55610 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726016AbgCQPef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:34:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584459274; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=n0DB5rQk3vxOGb0AlK5NXyNF/JWOE9+RENHn6S1ppc0=; b=C36HycbGOL+yFcNdP+vTp82qfKwLLfV5ytCCRt9kfVOX8U0alPFo1JIvq+fSV5ECmqk3nwxr
 5gX4MO/Q5LvF3/DIoQA1M0NEM+kk77rJxu8wniNbNMjAQXLtpIV9DHSAeUqYHkWti5ZcMoGV
 zuE+e4ri7OUgZOyglGd2AtbwbkE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e70ee03.7f4691655b58-smtp-out-n05;
 Tue, 17 Mar 2020 15:34:27 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2FFE9C44788; Tue, 17 Mar 2020 15:34:26 +0000 (UTC)
Received: from BCAIN (104-54-226-75.lightspeed.austtx.sbcglobal.net [104.54.226.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 344BDC433D2;
        Tue, 17 Mar 2020 15:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 344BDC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Dmitry Safonov'" <dima@arista.com>,
        <linux-kernel@vger.kernel.org>
Cc:     "'Dmitry Safonov'" <0x7f454c46@gmail.com>,
        "'Andrew Morton'" <akpm@linux-foundation.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Ingo Molnar'" <mingo@kernel.org>,
        "'Jiri Slaby'" <jslaby@suse.com>,
        "'Petr Mladek'" <pmladek@suse.com>,
        "'Sergey Senozhatsky'" <sergey.senozhatsky@gmail.com>,
        "'Steven Rostedt'" <rostedt@goodmis.org>,
        "'Tetsuo Handa'" <penguin-kernel@I-love.SAKURA.ne.jp>,
        <linux-hexagon@vger.kernel.org>
References: <20200316143916.195608-1-dima@arista.com> <20200316143916.195608-15-dima@arista.com>
In-Reply-To: <20200316143916.195608-15-dima@arista.com>
Subject: RE: [PATCHv2 14/50] hexagon: Add show_stack_loglvl()
Date:   Tue, 17 Mar 2020 10:34:22 -0500
Message-ID: <016201d5fc71$89c01ab0$9d405010$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQHVQBC9Nz7qrLFcmabjETiJ0mIiewG/9sU+qEBi1pA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Brian Cain <bcain@codeaurora.org>

> Cc: Brian Cain <bcain@codeaurora.org>
> Cc: linux-hexagon@vger.kernel.org
> [1]: https://lore.kernel.org/lkml/20190528002412.1625-1-
> dima@arista.com/T/#u
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  arch/hexagon/kernel/traps.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
> index 69c623b14ddd..a8a3a210d781 100644
> --- a/arch/hexagon/kernel/traps.c
> +++ b/arch/hexagon/kernel/traps.c
> @@ -79,7 +79,7 @@ static const char *ex_name(int ex)  }
> 
>  static void do_show_stack(struct task_struct *task, unsigned long *fp,
> -			  unsigned long ip)
> +			  unsigned long ip, const char *loglvl)
>  {
>  	int kstack_depth_to_print = 24;
>  	unsigned long offset, size;
> @@ -93,9 +93,8 @@ static void do_show_stack(struct task_struct *task,
> unsigned long *fp,
>  	if (task == NULL)
>  		task = current;
> 
> -	printk(KERN_INFO "CPU#%d, %s/%d, Call Trace:\n",
> -	       raw_smp_processor_id(), task->comm,
> -	       task_pid_nr(task));
> +	printk("%sCPU#%d, %s/%d, Call Trace:\n", loglvl,
> raw_smp_processor_id(),
> +		task->comm, task_pid_nr(task));
> 
>  	if (fp == NULL) {
>  		if (task == current) {
> @@ -108,7 +107,7 @@ static void do_show_stack(struct task_struct *task,
> unsigned long *fp,
>  	}
> 
>  	if ((((unsigned long) fp) & 0x3) || ((unsigned long) fp < 0x1000)) {
> -		printk(KERN_INFO "-- Corrupt frame pointer %p\n", fp);
> +		printk("%s-- Corrupt frame pointer %p\n", loglvl, fp);
>  		return;
>  	}
> 
> @@ -125,8 +124,7 @@ static void do_show_stack(struct task_struct *task,
> unsigned long *fp,
> 
>  		name = kallsyms_lookup(ip, &size, &offset, &modname,
> tmpstr);
> 
> -		printk(KERN_INFO "[%p] 0x%lx: %s + 0x%lx", fp, ip, name,
> -			offset);
> +		printk("%s[%p] 0x%lx: %s + 0x%lx", loglvl, fp, ip, name,
> offset);
>  		if (((unsigned long) fp < low) || (high < (unsigned long)
fp))
>  			printk(KERN_CONT " (FP out of bounds!)");
>  		if (modname)
> @@ -136,8 +134,7 @@ static void do_show_stack(struct task_struct *task,
> unsigned long *fp,
>  		newfp = (unsigned long *) *fp;
> 
>  		if (((unsigned long) newfp) & 0x3) {
> -			printk(KERN_INFO "-- Corrupt frame pointer %p\n",
> -				newfp);
> +			printk("%s-- Corrupt frame pointer %p\n", loglvl,
> newfp);
>  			break;
>  		}
> 
> @@ -147,7 +144,7 @@ static void do_show_stack(struct task_struct *task,
> unsigned long *fp,
>  						+ 8);
> 
>  			if (regs->syscall_nr != -1) {
> -				printk(KERN_INFO "-- trap0 -- syscall_nr:
> %ld",
> +				printk("%s-- trap0 -- syscall_nr: %ld",
loglvl,
>  					regs->syscall_nr);
>  				printk(KERN_CONT "  psp: %lx  elr: %lx\n",
>  					 pt_psp(regs), pt_elr(regs));
> @@ -155,7 +152,7 @@ static void do_show_stack(struct task_struct *task,
> unsigned long *fp,
>  			} else {
>  				/* really want to see more ... */
>  				kstack_depth_to_print += 6;
> -				printk(KERN_INFO "-- %s (0x%lx)  badva:
> %lx\n",
> +				printk("%s-- %s (0x%lx)  badva: %lx\n",
loglvl,
>  					ex_name(pt_cause(regs)),
> pt_cause(regs),
>  					pt_badva(regs));
>  			}
> @@ -178,10 +175,16 @@ static void do_show_stack(struct task_struct
> *task, unsigned long *fp,
>  	}
>  }
> 
> -void show_stack(struct task_struct *task, unsigned long *fp)
> +void show_stack_loglvl(struct task_struct *task, unsigned long *fp,
> +		       const char *loglvl)
>  {
>  	/* Saved link reg is one word above FP */
> -	do_show_stack(task, fp, 0);
> +	do_show_stack(task, fp, 0, loglvl);
> +}
> +
> +void show_stack(struct task_struct *task, unsigned long *fp) {
> +	show_stack_loglvl(task, fp, 0, KERN_INFO);
>  }
> 
>  int die(const char *str, struct pt_regs *regs, long err) @@ -207,7 +210,7
> @@ int die(const char *str, struct pt_regs *regs, long err)
> 
>  	print_modules();
>  	show_regs(regs);
> -	do_show_stack(current, &regs->r30, pt_elr(regs));
> +	do_show_stack(current, &regs->r30, pt_elr(regs), KERN_EMERG);
> 
>  	bust_spinlocks(0);
>  	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
> --
> 2.25.1

