Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FCCC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDAC20BED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ejYdqtCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgDFOed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:34:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34056 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbgDFOec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wr0uZpRzGVA7T8oUC8PL/uBRO2k1Ka9BIzBlz9pMP2A=; b=ejYdqtCAmo0OOTalawEY93to8L
        IkiAEaDmYzOw7FOOD62IgZoVmwZzUI9I8saFArRIZj1erVrWnSbSE5rGnkDhEd0VB60/15oKiernY
        aZ8nO+vaqhJnj18sDAtdGbsxroSP1ugUvL07Des8/PRIXCLs9OaFxviDL2XHPCjUglMkQtIG76teE
        Qp6bekEhqff6215Z5pJ3BpWflGjJ6MUzNVHflFZ1cA0/njJ784WRG430wsr3Jl0SfV6oSqTVfjugt
        16xcTCbe0/UglB5lzfjR69h08yNyJ0Cs4y+b5h5BZ/2WI2F8wEd3+ZM31nl0TwPuzxVmCxnrmsa/m
        Uk3gfoTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLSpF-0006Xq-H7; Mon, 06 Apr 2020 14:34:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5FB9B300478;
        Mon,  6 Apr 2020 16:34:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B3A082BAC74D6; Mon,  6 Apr 2020 16:34:05 +0200 (CEST)
Date:   Mon, 6 Apr 2020 16:34:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        David Laight <David.Laight@aculab.com>,
        Doug Covelli <dcovelli@vmware.com>
Subject: Re: [RFC PATCH] x86/split_lock: Disable SLD if an unaware
 (out-of-tree) module enables VMX
Message-ID: <20200406143405.GM20760@hirez.programming.kicks-ass.net>
References: <20200403163007.6463-1-sean.j.christopherson@intel.com>
 <20200406125010.GA29306@infradead.org>
 <20200406140403.GL20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406140403.GL20730@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 04:04:04PM +0200, Peter Zijlstra wrote:
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index 65c2ecd730c5..0bd5ea46f1d2 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -274,6 +274,11 @@ typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
>  
>  typedef struct { pgdval_t pgd; } pgd_t;
>  

This lost:

#define pgprot_nx pgprot_nx

> +static inline pgprot_t pgprot_nx(pgprot_t prot)
> +{
> +	return __pgprot(pgprot_val(prot) | _PAGE_NX);
> +}
> +
>  #ifdef CONFIG_X86_PAE
>  
>  /*

> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> index e2e2bef07dd2..ee66c1f8b141 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -490,6 +490,10 @@ static inline int arch_unmap_one(struct mm_struct *mm,
>  #define flush_tlb_fix_spurious_fault(vma, address) flush_tlb_page(vma, address)
>  #endif
>  
> +#ifndef pgprot_nx
> +#define pgprot_nx(prot)	(prot)
> +#endif
> +
>  #ifndef pgprot_noncached
>  #define pgprot_noncached(prot)	(prot)
>  #endif
