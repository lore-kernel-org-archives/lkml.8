Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550F0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F825206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593588852;
	bh=uRnmlykEHcH2t5rCDGTbzG8t+NbTQ+0N1Dd0E2sEE5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T4z1E/yNvVJUwTw6A+i4C1bksAhdLBlJuKVbqB+9AeXhG1cjXKqyEVBqSfKKMSDvh
	 /YSfD8SDZhXimFvRDzsUqRI5QRFj+Hmcd/tnKzQrJuwMI9c+uUFfbVrZLYcpkjKYMk
	 hvGFpPrtYYFJ2c1rWMKkCetSC3thdplK/9YMuQEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgGAHeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:34:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728142AbgGAHeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:34:10 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8363E206A1;
        Wed,  1 Jul 2020 07:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593588849;
        bh=uRnmlykEHcH2t5rCDGTbzG8t+NbTQ+0N1Dd0E2sEE5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dOJcp6W5oab01R+28pyX7UOisa3FhewGv5f4Q6ltH+NdMAeyod3bMwtOnhq/GXqoh
         7WBol6lrv0gcD4Yraz7UFK6emx/OAM/0hMxpxYFw4zr3rTv8BsNnXZ2BYoMhjGKtDy
         pqDURz90nQQ9sPwuS7I86QCy9RR+fVSGZoel/6VM=
Date:   Wed, 1 Jul 2020 08:34:04 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 05/26] mm/arm64: Use general page fault accounting
Message-ID: <20200701073403.GA14692@willie-the-truck>
References: <20200630204514.38711-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630204514.38711-1-peterx@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 04:45:14PM -0400, Peter Xu wrote:
> Use the general page fault accounting by passing regs into handle_mm_fault().
> It naturally solve the issue of multiple page fault accounting when page fault
> retry happened.  To do this, we pass pt_regs pointer into __do_page_fault().
> 
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will@kernel.org>
> CC: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/arm64/mm/fault.c | 29 ++++++-----------------------
>  1 file changed, 6 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index be29f4076fe3..f07333e86c2f 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -404,7 +404,8 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
>  #define VM_FAULT_BADACCESS	0x020000
>  
>  static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
> -			   unsigned int mm_flags, unsigned long vm_flags)
> +				  unsigned int mm_flags, unsigned long vm_flags,
> +				  struct pt_regs *regs)
>  {
>  	struct vm_area_struct *vma = find_vma(mm, addr);
>  
> @@ -428,7 +429,7 @@ static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
>  	 */
>  	if (!(vma->vm_flags & vm_flags))
>  		return VM_FAULT_BADACCESS;
> -	return handle_mm_fault(vma, addr & PAGE_MASK, mm_flags, NULL);
> +	return handle_mm_fault(vma, addr & PAGE_MASK, mm_flags, regs);
>  }
>  
>  static bool is_el0_instruction_abort(unsigned int esr)
> @@ -450,7 +451,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  {
>  	const struct fault_info *inf;
>  	struct mm_struct *mm = current->mm;
> -	vm_fault_t fault, major = 0;
> +	vm_fault_t fault;
>  	unsigned long vm_flags = VM_ACCESS_FLAGS;
>  	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
>  
> @@ -516,8 +517,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  #endif
>  	}
>  
> -	fault = __do_page_fault(mm, addr, mm_flags, vm_flags);
> -	major |= fault & VM_FAULT_MAJOR;
> +	fault = __do_page_fault(mm, addr, mm_flags, vm_flags, regs);
>  
>  	/* Quick path to respond to signals */
>  	if (fault_signal_pending(fault, regs)) {
> @@ -538,25 +538,8 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  	 * Handle the "normal" (no error) case first.
>  	 */
>  	if (likely(!(fault & (VM_FAULT_ERROR | VM_FAULT_BADMAP |
> -			      VM_FAULT_BADACCESS)))) {
> -		/*
> -		 * Major/minor page fault accounting is only done
> -		 * once. If we go through a retry, it is extremely
> -		 * likely that the page will be found in page cache at
> -		 * that point.
> -		 */
> -		if (major) {
> -			current->maj_flt++;
> -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs,
> -				      addr);
> -		} else {
> -			current->min_flt++;
> -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs,
> -				      addr);
> -		}
> -
> +			      VM_FAULT_BADACCESS))))
>  		return 0;
> -	}

Thanks, looks good to me:

Acked-by: Will Deacon <will@kernel.org>

Will
