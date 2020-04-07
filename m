Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0ECC2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCD720719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oM1IEdbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgDGOAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:00:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54804 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbgDGOAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V0PThIqL+3Tnl8qPdklgGnLMHmlP2oR/nQ9+0x/1Wj4=; b=oM1IEdbcAd483e1c2RJR+ky5cR
        ty7wv+TXVWqYbzZjgar3pbFmVP+f+CecWoHksxAhhAvhP6zPKFySP6rlvYkwa1kSTmGYbOxx4801x
        uWcN/Gl4cp/PNvTMEB50k2BR1H086CRP8e3v0c/urFTUVLlwrnY3904VCGGgQ98ImwvcncdSf2tzK
        ++CqtCZk8WQOMpbnZTmjgly457E4/d+WZAB6iWtp55aqufZcaz5kZ1ks421+VYnqQ9aQaKL3s25y2
        v+OwCoR+1lmh3VwX4sXsAFUY79RtDnZnL7KYiXcPtCCrqQpgk+cIBBRXksvlX3Durga/mpWZTl7y7
        PmeONRyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLolg-0001g4-81; Tue, 07 Apr 2020 13:59:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 41ECF304D58;
        Tue,  7 Apr 2020 15:59:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2BC3C2B953CBE; Tue,  7 Apr 2020 15:59:53 +0200 (CEST)
Date:   Tue, 7 Apr 2020 15:59:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH V2 9/9] x86/speculation: Remove all
 ANNOTATE_NOSPEC_ALTERNATIVE directives
Message-ID: <20200407135953.GC20730@hirez.programming.kicks-ass.net>
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
 <20200407073142.20659-10-alexandre.chartre@oracle.com>
 <20200407135211.GB20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407135211.GB20730@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 03:52:11PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 07, 2020 at 09:31:42AM +0200, Alexandre Chartre wrote:
> 
> > -	ANNOTATE_NOSPEC_ALTERNATIVE
> >  	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *\reg),	\
> >  		__stringify(RETPOLINE_JMP \reg), X86_FEATURE_RETPOLINE,	\
> >  		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *\reg), X86_FEATURE_RETPOLINE_AMD
> 
> Possibly we can write this like:

.macro OOL_RETPOLINE_JMP reg:req
SYM_FUNC_START(__x86_retpoline_jmp_\reg)
	CFI_STARTPROC
	RETPOLINE_JMP \reg
	CFI_ENDPROC
SYM_FUNC_END(__x86_retpoline_jmp_\reg)
.endm

> 	ALTERNATIVE("", "lfence", X86_FEATURE_RETPOLINE_AMD);
> 	ALTERNATIVE("jmp *\reg", "jmp __x86_retpoline_jmp_\reg", X86_FEATURE_RETPOLINE);
> 
> With an out-of-line copy of the retpoline, just like the THUNKs the
> compiler uses, except of course, it can't be those, because we actually
> want to use the alternative to implement those.
> 
> By moving the retpoline magic out-of-line we ensure it has a unique
> address and the ORC stuff should work.
> 
> I'm just not sure what to do about the RETPOLINE_CALL variant.

Duh, something like so:

	ALTERNATIVE("", "lfence", X86_FEATURE_RETPOLINE_AMD);
	ALTERNATIVE("call *\reg", "call __x86_retpoline_jmp_\reg", X86_FEATURE_RETPOLINE);


