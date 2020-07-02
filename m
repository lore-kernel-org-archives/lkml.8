Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594F6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 327302067D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sj1ZI8qv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgGBIFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgGBIFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 04:05:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A527FC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 01:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1Shbc8XBEGOupz0+BIqRfrqP5vs699lFBc+50af7Ag8=; b=sj1ZI8qvkQGYW1AfsMtwcP8rPq
        HcmQ5l7jhJEw/pMnBEqVmf8VrcNH7YVmQywmr19wk9gXy5ONFRkGfOsHIsBBpI+fddXVcJBraSJhv
        q/sVFchhHcgHNdTmuZSbGTbAhhokf888HFa0zxiAQHdLg0W3MXPC6L9tHYXeLsyFWuL7zkSwTctla
        ItiG6iNtAcnVjMl1WTWzw5GjMYswjw+AtDWVr8qrTI/EmX39L0QIZelk7P0ZWhBqoNXZzhlwHP39i
        sgksfeOHfsWAuKEldkps95B7Y1ON0ewYxaTUfjPHuWe9aWTT0KY8hARZ3zNFKoWLUQ1ApVZPF2+1a
        Si7OiR8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jquDZ-0007Od-34; Thu, 02 Jul 2020 08:05:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0164330015A;
        Thu,  2 Jul 2020 10:05:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E6679264F8CB1; Thu,  2 Jul 2020 10:05:10 +0200 (CEST)
Date:   Thu, 2 Jul 2020 10:05:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool clac/stac handling change..
Message-ID: <20200702080510.GY4781@hirez.programming.kicks-ass.net>
References: <CAHk-=wizu7DA7EDrsHQLmkTFBvCRxNyPMHaeMDYMF_U75s9RvQ@mail.gmail.com>
 <5F1767D0-416A-4BA4-9DFF-E82D1EA3F5EE@amacapital.net>
 <20200701205108.wtgfnijav7lgfiqe@treble>
 <CAHk-=wiY-67yt4kGd2EW-7kChQgnLHZ_2aJ+=ps7i7rCz894PQ@mail.gmail.com>
 <20200702000041.movaiqpyzdmhlu67@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702000041.movaiqpyzdmhlu67@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 07:00:41PM -0500, Josh Poimboeuf wrote:
> On Wed, Jul 01, 2020 at 02:02:42PM -0700, Linus Torvalds wrote:
> > So the objtool rule might be:
> > 
> >  - in a STAC region, no exception handlers at all except for that
> > ex_handler_uaccess case
> > 
> >  - and that case will clear AC if it triggers.
> > 
> > and maybe such an objtool check would show some case where I'm wrong,
> > and we do some MSR read other other fault thing within a STAC region.
> > That _sounds_ wrong to me, but maybe we have reason to do so that I
> > just can't think or right now?
> 
> Here's an attempt at implementing this, in case anybody wants to play
> with it.  Usual disclaimers apply...

Looks about right, two niggles below.

> @@ -2335,6 +2340,35 @@ static void fill_alternative_cfi(struct objtool_file *file, struct instruction *
>  	}
>  }
>  
> +static int handle_stac(struct symbol *func, struct instruction *insn,
> +		       struct insn_state *state)
> +{
> +	if (state->uaccess) {
> +		WARN_FUNC("recursive UACCESS enable", insn->sec, insn->offset);
> +		return -1;
> +	}
> +
> +	state->uaccess = true;
> +	return 0;
> +}
> +
> +static int handle_clac(struct symbol *func, struct instruction *insn,
> +		       struct insn_state *state)
> +{
> +	if (!state->uaccess && func) {
> +		WARN_FUNC("redundant UACCESS disable", insn->sec, insn->offset);
> +		return -1;
> +	}
> +
> +	if (func_uaccess_safe(func) && !state->uaccess_stack) {
> +		WARN_FUNC("UACCESS-safe disables UACCESS", insn->sec, insn->offset);
> +		return -1;
> +	}
> +
> +	state->uaccess = false;
> +	return 0;
> +}

For both these we return -1 on error and then all callers convert it to
1. So why not have this return 1 and pass any !0 value through?

>  /*
>   * Follow the branch starting at the given instruction, and recursively follow
>   * any other branches (jumps).  Meanwhile, track the frame pointer state at
> @@ -2393,6 +2427,17 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>  				if (alt->skip_orig)
>  					skip_orig = true;
>  
> +				if (alt->exception) {
> +					if (!alt->uaccess && state.uaccess) {
> +						WARN_FUNC("non-user-access exception with uaccess enabled",
> +							  sec, insn->offset);
> +						return 1;
> +					}

This is Linus' new rule that AC code should not get any exceptions
except ex_handler_uaccess.

> +
> +					if (alt->uaccess && handle_clac(func, insn, &state))
> +						return 1;

And this is ex_handler_uaccess() mucking with regs->flags, right? Might
want a comment.

> +				}
> +
>  				ret = validate_branch(file, func, alt->insn, state);
>  				if (ret) {
>  					if (backtrace)
