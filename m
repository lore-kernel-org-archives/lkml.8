Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAE2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 11:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C174206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 11:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EHN6SZoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgFDLJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 07:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbgFDLJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 07:09:48 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5666C03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 04:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YWhHltp0HfbKPBvZhE5nAcBu90lHTux6EoGengUlZUY=; b=EHN6SZoT1AGLXLg6ILzh9fyvWu
        +CCU3esUOwX7At2JOffTBvgl/aMm1ZE/HMlXJEpyR2fLWUqc9xkh38DTb0rQGQqPLmxkFZG3MZu8Z
        S91E+nWHd4zY2/n1Sg0ldzNokSPYHiuoLaO9A2PuammUh4fa+61gCj7CLv3Gm71PMixxyFRj924gm
        cjiUZkg4prc+AYW2pw5di8BMYTp94v2eOfQplC/pJfTDf9Swvq8H5NEXbU/1CrIMkNo6Qmwxbm2Ic
        2UgGBsgZOLTqfvB6K7o6MHwHsIINKTVByuzFjv17cDZuPlv37iHz4PDkplC7ueU4tLUKQR+Y5eZsH
        NC3uPwhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgnkP-00054A-Bw; Thu, 04 Jun 2020 11:09:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A8A1430008D;
        Thu,  4 Jun 2020 13:09:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 81C4A20DF6C6C; Thu,  4 Jun 2020 13:09:18 +0200 (CEST)
Date:   Thu, 4 Jun 2020 13:09:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     bp@alien8.de, tglx@linutronix.de, mingo@kernel.org,
        clang-built-linux@googlegroups.com, paulmck@kernel.org,
        dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -tip] kcov: Make runtime functions noinstr-compatible
Message-ID: <20200604110918.GA2750@hirez.programming.kicks-ass.net>
References: <20200604095057.259452-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604095057.259452-1-elver@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 11:50:57AM +0200, Marco Elver wrote:
> The KCOV runtime is very minimal, only updating a field in 'current',
> and none of __sanitizer_cov-functions generates reports nor calls any
> other external functions.

Not quite true; it writes to t->kcov_area, and we need to make
absolutely sure that doesn't take faults or triggers anything else
untowards.

> Therefore we can make the KCOV runtime noinstr-compatible by:
> 
>   1. always-inlining internal functions and marking
>      __sanitizer_cov-functions noinstr. The function write_comp_data() is
>      now guaranteed to be inlined into __sanitize_cov_trace_*cmp()
>      functions, which saves a call in the fast-path and reduces stack
>      pressure due to the first argument being a constant.
> 
>   2. For Clang, correctly pass -fno-stack-protector via a separate
>      cc-option, as -fno-conserve-stack does not exist on Clang.
> 
> The major benefit compared to adding another attribute to 'noinstr' to
> not collect coverage information, is that we retain coverage visibility
> in noinstr functions. We also currently lack such an attribute in both
> GCC and Clang.
> 

> -static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
> +static __always_inline void write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
>  {
>  	struct task_struct *t;
>  	u64 *area;
> @@ -231,59 +231,59 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
>  	}
>  }

This thing; that appears to be the meat of it, right?

I can't find where t->kcov_area comes from.. is that always
kcov_mmap()'s vmalloc_user() ?

That whole kcov_remote stuff confuses me.

KCOV_ENABLE() has kcov_fault_in_area(), which supposedly takes the
vmalloc faults for the current task, but who does it for the remote?

Now, luckily Joerg went and ripped out the vmalloc faults, let me check
where those patches are... w00t, they're upstream in this merge window.

So no #PF from writing to t->kcov_area then, under the assumption that
the vmalloc_user() is the only allocation site.

But then there's hardware watchpoints, if someone goes and sets a data
watchpoint in the kcov_area we're screwed. Nothing actively prevents
that from happening. Then again, the same is currently true for much of
current :/

Also, I think you need __always_inline on kaslr_offset()


And, unrelated to this patch in specific, I suppose I'm going to have to
extend objtool to look for data that is used from noinstr, to make sure
we exclude it from inspection and stuff, like that kaslr offset crud for
example.

Anyway, yes, it appears you're lucky (for having Joerg remove vmalloc
faults) and this mostly should work as is.
