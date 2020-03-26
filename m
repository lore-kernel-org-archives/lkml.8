Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C82DC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1D220737
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IfowJ9sY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgCZNAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:00:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39210 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgCZNAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zX5CImLOooaTxei3K64K8v3txt3+3BDfprveUbW7F2k=; b=IfowJ9sY6dOcIMd6zw4dRGfhH4
        kTQyhH1x0iH0VHGYQW5B+PVuKchcxXl36IoKs7ysYGWe0qEmwxwMf4bciy35LlcgexeiPI15vf0sX
        /58j2MA4yhdT0+bH3vpVXeBbKI/ynR97lRNCm3CCluzWPb57qCiTr6p3mDRFWogupEAttYNM1cxvq
        liTD2tEQmLHLN9zOtZGO8blNZJFoTrLmb/iGRTMdDf3eAI2AtRjU2g3+atDI/AKjtiys7zttdEJch
        tVLBJVoB2En1Z+xdGOwLc/C/TYCetdd/rOkunE0OpbgBmmGNOdnlwPFOlo0YZp85gl/iKAvBAwCuG
        xI7VZ/Ow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHS7A-0001U1-32; Thu, 26 Mar 2020 13:00:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B8E493010C1;
        Thu, 26 Mar 2020 14:00:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A890C20413B69; Thu, 26 Mar 2020 14:00:01 +0100 (CET)
Date:   Thu, 26 Mar 2020 14:00:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz
Subject: Re: [PATCH v4 01/13] objtool: Remove CFI save/restore special case
Message-ID: <20200326130001.GE20760@hirez.programming.kicks-ass.net>
References: <20200325174525.772641599@infradead.org>
 <20200325174605.369570202@infradead.org>
 <20200326113049.GD20696@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326113049.GD20696@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 12:30:50PM +0100, Peter Zijlstra wrote:
> Subject: objtool: Remove CFI save/restore special case
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed Mar 25 12:58:16 CET 2020
> 
> There is a special case in the UNWIND_HINT_RESTORE code. When, upon
> looking for the UNWIND_HINT_SAVE instruction to restore from, it finds
> the instruction hasn't been visited yet, it normally issues a WARN,
> except when this HINT_SAVE instruction is the first instruction of
> this branch.
> 
> The reason for this special case comes apparent when we remove it;
> code like:
> 
> 	if (cond) {
> 		UNWIND_HINT_SAVE
> 		// do stuff
> 		UNWIND_HINT_RESTORE
> 	}
> 	// more stuff
> 
> will now trigger the warning. This is because UNWIND_HINT_RESTORE is
> just a label, and there is nothing keeping it inside the (extended)
> basic block covered by @cond. It will attach itself to the first
> instruction of 'more stuff' and we'll hit it outside of the @cond,
> confusing things.
> 
> I don't much like this special case, it confuses things and will come
> apart horribly if/when the annotation needs to support nesting.
> Instead extend the affected code to at least form an extended basic
> block.

> @@ -727,6 +727,13 @@ static inline void sync_core(void)
>  #else
>  	unsigned int tmp;
>  
> +	/*
> +	 * The trailing NOP is required to make this an extended basic block,
> +	 * such that we can argue about it locally. Specifically this is
> +	 * important for the UNWIND_HINTs, without this the UNWIND_HINT_RESTORE
> +	 * can fall outside our extended basic block and objtool gets
> +	 * (rightfully) confused.
> +	 */
>  	asm volatile (
>  		UNWIND_HINT_SAVE
>  		"mov %%ss, %0\n\t"
> @@ -739,7 +746,7 @@ static inline void sync_core(void)
>  		"pushq $1f\n\t"
>  		"iretq\n\t"
>  		UNWIND_HINT_RESTORE
> -		"1:"
> +		"1: nop\n\t"
>  		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");

Note that the special case very much relies on the HINT_SAVE being the
first instruction of the (extended) basic block, which is only true in
this one usage anyway.
