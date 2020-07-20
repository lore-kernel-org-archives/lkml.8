Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2464C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90AE22080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgGTVZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:25:26 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:34406 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgGTVZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:25:25 -0400
Date:   Mon, 20 Jul 2020 17:25:24 -0400
From:   Rich Felker <dalias@libc.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Subject: Re: [PATCH 20/25] mm/sh: Use mm_fault_accounting()
Message-ID: <20200720212524.GL14669@brightrain.aerifal.cx>
References: <20200615221607.7764-1-peterx@redhat.com>
 <20200615222306.8502-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615222306.8502-1-peterx@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 06:23:06PM -0400, Peter Xu wrote:
> Use the new mm_fault_accounting() helper for page fault accounting.
> 
> Avoid doing page fault accounting multiple times if the page fault is retried.
> 
> CC: Yoshinori Sato <ysato@users.sourceforge.jp>
> CC: Rich Felker <dalias@libc.org>
> CC: linux-sh@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/sh/mm/fault.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
> index 5f23d7907597..06b232973488 100644
> --- a/arch/sh/mm/fault.c
> +++ b/arch/sh/mm/fault.c
> @@ -379,7 +379,7 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
>  	struct task_struct *tsk;
>  	struct mm_struct *mm;
>  	struct vm_area_struct * vma;
> -	vm_fault_t fault;
> +	vm_fault_t fault, major = 0;
>  	unsigned int flags = FAULT_FLAG_DEFAULT;
>  
>  	tsk = current;
> @@ -412,8 +412,6 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
>  	if ((regs->sr & SR_IMASK) != SR_IMASK)
>  		local_irq_enable();
>  
> -	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
> -
>  	/*
>  	 * If we're in an interrupt, have no user context or are running
>  	 * with pagefaults disabled then we must not take the fault:
> @@ -465,21 +463,13 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
>  	 * the fault.
>  	 */
>  	fault = handle_mm_fault(vma, address, flags);
> +	major |= fault & VM_FAULT_MAJOR;
>  
>  	if (unlikely(fault & (VM_FAULT_RETRY | VM_FAULT_ERROR)))
>  		if (mm_fault_error(regs, error_code, address, fault))
>  			return;
>  
>  	if (flags & FAULT_FLAG_ALLOW_RETRY) {
> -		if (fault & VM_FAULT_MAJOR) {
> -			tsk->maj_flt++;
> -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
> -				      regs, address);
> -		} else {
> -			tsk->min_flt++;
> -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
> -				      regs, address);
> -		}
>  		if (fault & VM_FAULT_RETRY) {
>  			flags |= FAULT_FLAG_TRIED;
>  
> @@ -493,4 +483,5 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
>  	}
>  
>  	up_read(&mm->mmap_sem);
> +	mm_fault_accounting(tsk, regs, address, major);
>  }
> -- 
> 2.26.2

What's the status on the rest of this series? Do you need any action
from my side (arch/sh) at this time?

Rich
