Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9895C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F29320757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T7D56jXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDIKkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 06:40:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47802 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgDIKkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 06:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bx+bEhrOCMKBgN3dLTzVqiIsNYJFlRJP4agNxc0F9uA=; b=T7D56jXvcYhf4/kuIDveNAQvH8
        RF0ZQKWf81/04cgUjG2KgB9q9iUmV+KNWI5jJy8/GAoPjucXkeR91+gwWl5fnsd8Sh71XzFnwIjIQ
        qy2437/dhG/IqBaRH6hPaK8/avIU3KuC9yjcNriuR42fmSOgkS/+lSFIl3uHEtqGKH26l0vyJGe/u
        xY34Lv1w6iIcp5froTdVHwQuHdoZHJUEQBvswUw7mJ5q57m+T052lbIMphWP7rBGdC2dRjhH8gjLl
        dvSn/RLE+BT3G+sP+V+2FsMyxl3IeUqCqOwAaGkjf8A6cMUuYLD5kcOhvx/8O/ucPZb8JiI9PWBOd
        GnwzEwZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMUbU-00072y-Nc; Thu, 09 Apr 2020 10:40:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3329B3012D8;
        Thu,  9 Apr 2020 12:40:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F6392BB332D0; Thu,  9 Apr 2020 12:40:08 +0200 (CEST)
Date:   Thu, 9 Apr 2020 12:40:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de
Subject: Re: [PATCH V2 9/9] x86/speculation: Remove all
 ANNOTATE_NOSPEC_ALTERNATIVE directives
Message-ID: <20200409104008.GO20760@hirez.programming.kicks-ass.net>
References: <20200407073142.20659-10-alexandre.chartre@oracle.com>
 <20200407132837.GA20730@hirez.programming.kicks-ass.net>
 <20200407133454.n55u5nx33ruj73gx@treble>
 <89b10eb8-c030-b954-6be3-8830fc6a8daa@oracle.com>
 <3eb36fd2-9827-4c1b-681c-9c1d65c7582f@oracle.com>
 <20200407162838.5hlh6oom4oa45ugt@treble>
 <20200407172739.GI20730@hirez.programming.kicks-ass.net>
 <20200408213508.GA4496@worktop.programming.kicks-ass.net>
 <da6efbb5-2610-6721-77ca-9833d13b9398@oracle.com>
 <20200409103424.GC20713@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409103424.GC20713@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 12:34:24PM +0200, Peter Zijlstra wrote:
> @@ -111,23 +83,21 @@
>   */
>  .macro JMP_NOSPEC reg:req
>  #ifdef CONFIG_RETPOLINE
> -	ANNOTATE_NOSPEC_ALTERNATIVE
> -	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *\reg),	\
> -		__stringify(RETPOLINE_JMP \reg), X86_FEATURE_RETPOLINE,	\
> -		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *\reg), X86_FEATURE_RETPOLINE_AMD
> +	ALTERNATIVE "", "lfence", X86_FEATURE_RETPOLINE_AMD
> +	ALTERNATIVE __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
> +		    __stringify(jmp __x86_retpoline_\reg), X86_FEATURE_RETPOLINE

Still, I am being an idiot, only the call (below) needs this, this can
stay what it was:

+       ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
+                     __stringify(jmp __x86_retpoline_\()\reg), X86_FEATURE_RETPOLINE, \
+                     __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_AMD

>  #else
> -	jmp	*\reg
> +	jmp	*%\reg
>  #endif
>  .endm
>  
>  .macro CALL_NOSPEC reg:req
>  #ifdef CONFIG_RETPOLINE
> -	ANNOTATE_NOSPEC_ALTERNATIVE
> -	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *\reg),	\
> -		__stringify(RETPOLINE_CALL \reg), X86_FEATURE_RETPOLINE,\
> -		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *\reg), X86_FEATURE_RETPOLINE_AMD

And then this needs a comment on why it is not ALTERNATIVE_2 like above.

> +	ALTERNATIVE "", "lfence", X86_FEATURE_RETPOLINE_AMD
> +	ALTERNATIVE __stringify(ANNOTATE_RETPOLINE_SAFE; call *%\reg), \
> +		    __stringify(call __x86_retpoline_\reg), X86_FEATURE_RETPOLINE
>  #else
> -	call	*\reg
> +	call	*%\reg
>  #endif
>  .endm
