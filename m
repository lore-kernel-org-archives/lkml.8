Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566ADC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2958420719
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AhIdllQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbgCPNY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 09:24:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50018 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731225AbgCPNYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 09:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=miWZdFA8eife04K5yFasK7sbVqVT4Ev83spzMuIXQoM=; b=AhIdllQRNdoUWvXZ4w8f10gkWX
        YhG19R77uRp0ItaHDcKekOZMqNAt7YDKluoBURSs710M+2o/FoC/STAMoboCImn/K8ey59376P5V4
        Xq7cf++ZRWJt65HVoTTS3hhm4MUwHXelBWPXaYMSbBCvgqP9T3RHw+UBKBYns5uUYx6+vbjzgJ+n5
        K/18H8EfNGmzUiV/CJoHG99APlq3csTIuy1YVwCsBYoOfntqYBuDpDNkB+h6I72oHbGQLIykjOIdV
        1wmFlrotn1y1Go383HQdKrYpaid+8FK6Q0T0tltACuIA+CM5AOI+a7E/VlKA4r/VV7JDJJ1Tjw2V/
        fV+4iMUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDpjC-0006Pi-28; Mon, 16 Mar 2020 13:24:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CE8233012C3;
        Mon, 16 Mar 2020 14:24:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B6FB920B16460; Mon, 16 Mar 2020 14:24:19 +0100 (CET)
Date:   Mon, 16 Mar 2020 14:24:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 15/16] objtool: Implement noinstr validation
Message-ID: <20200316132419.GF12521@hirez.programming.kicks-ass.net>
References: <20200312134107.700205216@infradead.org>
 <20200312135042.288201372@infradead.org>
 <20200315180320.cgy2ealklbjlx4g7@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315180320.cgy2ealklbjlx4g7@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 15, 2020 at 01:03:20PM -0500, Josh Poimboeuf wrote:
> On Thu, Mar 12, 2020 at 02:41:22PM +0100, Peter Zijlstra wrote:
> > Validate that any call out of .noinstr.text is in between
> > instr_begin() and instr_end() annotations.
> > 
> > This annotation is useful to ensure correct behaviour wrt tracing
> > sensitive code like entry/exit and idle code. When we run code in a
> > sensitive context we want a guarantee no unknown code is ran.
> > 
> > Since this validation relies on knowing the section of call
> > destination symbols, we must run it on vmlinux.o instead of on
> > individual object files.
> > 
> > Add the -i "noinstr validation only" option because:
> > 
> >  - vmlinux.o isn't 'clean' vs the existing validations
> >  - skipping the other validations (which have already been done
> >    earlier in the build) saves around a second of runtime.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> I find the phrase "noinstr" to be WAY too ambiguous.  To my brain it
> clearly stands for "no instructions" and I have to do a double take
> every time I read it.

Thing is, we use insn for instruction all over both arch/x86/ and
objtool.

My personal naming preference didn't make it due to CoC reasons :-/

> And "read_instr_hints" reads as "read_instruction_hints()".
> 
> Can we come up with a more readable name?  Why not just "notrace"?
> 
> The trace begin/end annotations could be
> 
>   trace_allow_begin()
>   trace_allow_end()

notrace already exists and we didn't want to confuse things further.

> Also -- what happens when a function belongs in both .notrace.text and
> in one of the other special-purpose sections like .sched.text,
> .meminit.text or .entry.text?

Hasn't happened yet, initially we were thinking of using .entry.text for
this as a whole, but decided against that due to how .entry.text is
special for PTI (although exposing most of this code really wouldn't
matter).

The thing with .sched.text is that we really should never call into
scheduling from these contexts anyway. We've not ran into meminit yet.
(all this finicky entry code is ran with IRQs disabled).

The one that could potentially interfere is .cpuidle.text.

> Maybe storing pointers to the functions, like NOKPROBE_SYMBOL does,
> would be better than putting the functions in a separate section.

Thing is, I really _hate_ that annotation style.

> > ---
> >  tools/objtool/builtin-check.c |    4 -
> >  tools/objtool/builtin.h       |    2 
> >  tools/objtool/check.c         |  155 ++++++++++++++++++++++++++++++++++++------
> >  tools/objtool/check.h         |    3 
> >  4 files changed, 140 insertions(+), 24 deletions(-)
> > 
> > --- a/tools/objtool/builtin-check.c
> > +++ b/tools/objtool/builtin-check.c
> > @@ -17,7 +17,7 @@
> >  #include "builtin.h"
> >  #include "check.h"
> >  
> > -bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats;
> > +bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, noinstr, vmlinux;
> >  
> >  static const char * const check_usage[] = {
> >  	"objtool check [<options>] file.o",
> > @@ -32,6 +32,8 @@ const struct option check_options[] = {
> >  	OPT_BOOLEAN('b', "backtrace", &backtrace, "unwind on error"),
> >  	OPT_BOOLEAN('a', "uaccess", &uaccess, "enable uaccess checking"),
> >  	OPT_BOOLEAN('s', "stats", &stats, "print statistics"),
> > +	OPT_BOOLEAN('i', "noinstr", &noinstr, "noinstr validation only"),
> > +	OPT_BOOLEAN('l', "vmlinux", &vmlinux, "vmlinux.o validation"),
> >  	OPT_END(),
> >  };
> 
> It seems like there should be an easy way to auto-detect vmlinux.o,
> without needing a cmdline option.
> 
> For example, if the file name is "vmlinux.o" :-)

Fair enough I suppose...

> Also, maybe we can just hard-code the fact that vmlinux.o is always
> noinstr-only.  Over time we'll probably need to move more per-.o
> functionalities to vmlinux.o and I think we should avoid creating a
> bunch of cmdline options.

but you're ruining things here, see, for a regular x86_64 config, we'd
run this with:

	objtool check -fail vmlinux.o

And I was hoping to get vmlinux.o objtool clean, surprisingly there
really aren't that many complaints. But the -i thing makes it run
significantly faster without duplicating all the bits we've already
checked.

Anyway, let me address and refresh the series while we bicket about
naming later. I'm thikning Thomas would much prefer to get his first
round of patches out first.
