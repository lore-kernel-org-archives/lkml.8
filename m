Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60E6C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C3C2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/QxkLeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgCBTE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 14:04:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26946 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726451AbgCBTE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583175866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=9hZuLREHQ8G6Le7iw0SISe6ZRGHKzqaNqjE72YHdiww=;
        b=W/QxkLeQrM7l4xad3SiUXwabtkBcZYzulXVvz94YFVhQfdsvvFhPM0U6sC7dntUIHX8ne1
        Ovf1g1UOHh0MSF0VQZ+DRZZES86QE+6N4V1plgI78EWAq5JHSLn/RoefamGqMx2RryXAP5
        DcOS0fch5hMpPxUFLU3bloM2sQZ/q1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-mRpqTb8uOhW3vfNKg0gkHA-1; Mon, 02 Mar 2020 14:04:22 -0500
X-MC-Unique: mRpqTb8uOhW3vfNKg0gkHA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B3858014DD;
        Mon,  2 Mar 2020 19:04:20 +0000 (UTC)
Received: from [10.36.116.60] (ovpn-116-60.ams2.redhat.com [10.36.116.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3800A60BF7;
        Mon,  2 Mar 2020 19:04:13 +0000 (UTC)
Subject: Re: [PATCH RESEND v6 03/16] mm: Introduce fault_signal_pending()
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Martin Cracauer <cracauer@cons.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Bobby Powers <bobbypowers@gmail.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mel Gorman <mgorman@suse.de>, Hugh Dickins <hughd@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>
References: <20200220155353.8676-1-peterx@redhat.com>
 <20200220155353.8676-4-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <389cd0bc-c42f-26c5-8402-53270cdb03d5@redhat.com>
Date:   Mon, 2 Mar 2020 20:04:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220155353.8676-4-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.02.20 16:53, Peter Xu wrote:
> For most architectures, we've got a quick path to detect fatal signal
> after a handle_mm_fault().  Introduce a helper for that quick path.
> 
> It cleans the current codes a bit so we don't need to duplicate the
> same check across archs.  More importantly, this will be an unified
> place that we handle the signal immediately right after an interrupted
> page fault, so it'll be much easier for us if we want to change the
> behavior of handling signals later on for all the archs.
> 
> Note that currently only part of the archs are using this new helper,
> because some archs have their own way to handle signals.  In the
> follow up patches, we'll try to apply this helper to all the rest of
> archs.
> 
> Another note is that the "regs" parameter in the new helper is not
> used yet.  It'll be used very soon.  Now we kept it in this patch only
> to avoid touching all the archs again in the follow up patches.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/alpha/mm/fault.c        |  2 +-
>  arch/arm/mm/fault.c          |  2 +-
>  arch/hexagon/mm/vm_fault.c   |  2 +-
>  arch/ia64/mm/fault.c         |  2 +-
>  arch/m68k/mm/fault.c         |  2 +-
>  arch/microblaze/mm/fault.c   |  2 +-
>  arch/mips/mm/fault.c         |  2 +-
>  arch/nds32/mm/fault.c        |  2 +-
>  arch/nios2/mm/fault.c        |  2 +-
>  arch/openrisc/mm/fault.c     |  2 +-
>  arch/parisc/mm/fault.c       |  2 +-
>  arch/riscv/mm/fault.c        |  2 +-
>  arch/s390/mm/fault.c         |  3 +--
>  arch/sparc/mm/fault_32.c     |  2 +-
>  arch/sparc/mm/fault_64.c     |  2 +-
>  arch/unicore32/mm/fault.c    |  2 +-
>  arch/xtensa/mm/fault.c       |  2 +-
>  include/linux/sched/signal.h | 13 +++++++++++++
>  18 files changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
> index 741e61ef9d3f..aea33b599037 100644
> --- a/arch/alpha/mm/fault.c
> +++ b/arch/alpha/mm/fault.c
> @@ -150,7 +150,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
>  	   the fault.  */
>  	fault = handle_mm_fault(vma, address, flags);
>  
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if (fault_signal_pending(fault, regs))
>  		return;
>  
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index bd0f4821f7e1..937b81ff8649 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -295,7 +295,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  	 * signal first. We do not need to release the mmap_sem because
>  	 * it would already be released in __lock_page_or_retry in
>  	 * mm/filemap.c. */
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
> +	if (fault_signal_pending(fault, regs)) {
>  		if (!user_mode(regs))
>  			goto no_context;
>  		return 0;
> diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
> index b3bc71680ae4..d19beaf11b4c 100644
> --- a/arch/hexagon/mm/vm_fault.c
> +++ b/arch/hexagon/mm/vm_fault.c
> @@ -91,7 +91,7 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
>  
>  	fault = handle_mm_fault(vma, address, flags);
>  
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if (fault_signal_pending(fault, regs))
>  		return;
>  
>  	/* The most common case -- we are done. */
> diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
> index c2f299fe9e04..211b4f439384 100644
> --- a/arch/ia64/mm/fault.c
> +++ b/arch/ia64/mm/fault.c
> @@ -141,7 +141,7 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
>  	 */
>  	fault = handle_mm_fault(vma, address, flags);
>  
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if (fault_signal_pending(fault, regs))
>  		return;
>  
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
> diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
> index e9b1d7585b43..a455e202691b 100644
> --- a/arch/m68k/mm/fault.c
> +++ b/arch/m68k/mm/fault.c
> @@ -138,7 +138,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  	fault = handle_mm_fault(vma, address, flags);
>  	pr_debug("handle_mm_fault returns %x\n", fault);
>  
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if (fault_signal_pending(fault, regs))
>  		return 0;
>  
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
> diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
> index e6a810b0c7ad..cdde01dcdfc3 100644
> --- a/arch/microblaze/mm/fault.c
> +++ b/arch/microblaze/mm/fault.c
> @@ -217,7 +217,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
>  	 */
>  	fault = handle_mm_fault(vma, address, flags);
>  
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if (fault_signal_pending(fault, regs))
>  		return;
>  
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
> diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
> index 1e8d00793784..0ee6fafc57bc 100644
> --- a/arch/mips/mm/fault.c
> +++ b/arch/mips/mm/fault.c
> @@ -154,7 +154,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
>  	 */
>  	fault = handle_mm_fault(vma, address, flags);
>  
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if (fault_signal_pending(regs))
>  		return;
>  
>  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
> diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
> index 906dfb25353c..0e63f81eff5b 100644
> --- a/arch/nds32/mm/fault.c
> +++ b/arch/nds32/mm/fault.c
> @@ -214,7 +214,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
>  	 * signal first. We do not need to release the mmap_sem because it
>  	 * would already be released in __lock_page_or_retry in mm/filemap.c.
>  	 */
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
> +	if (fault_signal_pending(fault, regs)) {
>  		if (!user_mode(regs))
>  			goto no_context;
>  		return;
> diff --git a/arch/nios2/mm/fault.c b/arch/nios2/mm/fault.c
> index 6a2e716b959f..704ace8ca0ee 100644
> --- a/arch/nios2/mm/fault.c
> +++ b/arch/nios2/mm/fault.c
> @@ -133,7 +133,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
>  	 */
>  	fault = handle_mm_fault(vma, address, flags);
>  
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if (fault_signal_pending(fault, regs))
>  		return;
>  
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
> diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
> index 5d4d3a9691d0..85c7eb0c0186 100644
> --- a/arch/openrisc/mm/fault.c
> +++ b/arch/openrisc/mm/fault.c
> @@ -161,7 +161,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
>  
>  	fault = handle_mm_fault(vma, address, flags);
>  
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if (fault_signal_pending(fault, regs))
>  		return;
>  
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
> diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
> index adbd5e2144a3..f9be1d1cb43f 100644
> --- a/arch/parisc/mm/fault.c
> +++ b/arch/parisc/mm/fault.c
> @@ -304,7 +304,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
>  
>  	fault = handle_mm_fault(vma, address, flags);
>  
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if (fault_signal_pending(fault, regs))
>  		return;
>  
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index cf7248e07f43..1d3869e9ddef 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -117,7 +117,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>  	 * signal first. We do not need to release the mmap_sem because it
>  	 * would already be released in __lock_page_or_retry in mm/filemap.c.
>  	 */
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(tsk))
> +	if (fault_signal_pending(fault, regs))
>  		return;
>  
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index 7b0bb475c166..179cf92a56e5 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -480,8 +480,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  	 * the fault.
>  	 */
>  	fault = handle_mm_fault(vma, address, flags);
> -	/* No reason to continue if interrupted by SIGKILL. */
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
> +	if (fault_signal_pending(fault, regs)) {
>  		fault = VM_FAULT_SIGNAL;
>  		if (flags & FAULT_FLAG_RETRY_NOWAIT)
>  			goto out_up;
> diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
> index 89976c9b936c..6efbeb227644 100644
> --- a/arch/sparc/mm/fault_32.c
> +++ b/arch/sparc/mm/fault_32.c
> @@ -237,7 +237,7 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
>  	 */
>  	fault = handle_mm_fault(vma, address, flags);
>  
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if (fault_signal_pending(fault, regs))
>  		return;
>  
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
> diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
> index 8b7ddbd14b65..dd1ed6555831 100644
> --- a/arch/sparc/mm/fault_64.c
> +++ b/arch/sparc/mm/fault_64.c
> @@ -425,7 +425,7 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
>  
>  	fault = handle_mm_fault(vma, address, flags);
>  
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if (fault_signal_pending(fault, regs))
>  		goto exit_exception;
>  
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
> diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
> index 76342de9cf8c..59d0e6ec2cfc 100644
> --- a/arch/unicore32/mm/fault.c
> +++ b/arch/unicore32/mm/fault.c
> @@ -250,7 +250,7 @@ static int do_pf(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  	 * signal first. We do not need to release the mmap_sem because
>  	 * it would already be released in __lock_page_or_retry in
>  	 * mm/filemap.c. */
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if (fault_signal_pending(fault, regs))
>  		return 0;
>  
>  	if (!(fault & VM_FAULT_ERROR) && (flags & FAULT_FLAG_ALLOW_RETRY)) {
> diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
> index bee30a77cd70..59515905d4ad 100644
> --- a/arch/xtensa/mm/fault.c
> +++ b/arch/xtensa/mm/fault.c
> @@ -110,7 +110,7 @@ void do_page_fault(struct pt_regs *regs)
>  	 */
>  	fault = handle_mm_fault(vma, address, flags);
>  
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if (fault_signal_pending(fault, regs))
>  		return;
>  
>  	if (unlikely(fault & VM_FAULT_ERROR)) {
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 88050259c466..4c87ffce64d1 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -369,6 +369,19 @@ static inline int signal_pending_state(long state, struct task_struct *p)
>  	return (state & TASK_INTERRUPTIBLE) || __fatal_signal_pending(p);
>  }
>  
> +/*
> + * This should only be used in fault handlers to decide whether we
> + * should stop the current fault routine to handle the signals
> + * instead, especially with the case where we've got interrupted with
> + * a VM_FAULT_RETRY.
> + */
> +static inline bool fault_signal_pending(unsigned int fault_flags,
> +					struct pt_regs *regs)
> +{
> +	return unlikely((fault_flags & VM_FAULT_RETRY) &&
> +			fatal_signal_pending(current));
> +}
> +
>  /*
>   * Reevaluate whether the task has signals pending delivery.
>   * Wake the task if so.
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

