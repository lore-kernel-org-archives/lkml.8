Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6244BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320D5206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lgSLFqsR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgCXRDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:03:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44590 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgCXRDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ybvI/xXoN4Xj7bvZ9uQSzuDEPSFb7l3L7fcwrqWVV2g=; b=lgSLFqsRWZVdBbzsaO30TNcs/0
        UZaYmu7cYUUgMBX6fqCyPCfHUFjFBpwoWBS7RNR0j9FBvytqWxnUYgtxVWVbtPBC/IfGEb2DwEUo/
        D4snUAWzPj98lTz7GCKDPE1mUy5PYOtvnUBB0z2I4Eqv1nqS/ttE46sfjJgkXk47IauxQab04ZfVd
        duAY2hIKcDvtCbs3+AGz+z0vfofJnnTnGYCLcxzwVECMF5N4djGFY0WzyPlSOkzwu+83vhQxrlfI5
        6bjjqDAv0DprUIn8s6aCeV6N2VEzEqO99nV2jIAIr24qqy+HM4IhftA5rR+B7cU6s3wZDcVxIfs16
        mhm4x9yA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGmxJ-0004Ig-4d; Tue, 24 Mar 2020 17:03:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 918FC300096;
        Tue, 24 Mar 2020 18:03:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 714E120413B7D; Tue, 24 Mar 2020 18:03:06 +0100 (CET)
Date:   Tue, 24 Mar 2020 18:03:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RESEND][PATCH v3 14/17] static_call: Add static_cond_call()
Message-ID: <20200324170306.GU20696@hirez.programming.kicks-ass.net>
References: <CAHk-=wiumU4QxAkT+GqhBt5f-iUsoLNC0sqVfRKp0xypA6aNYg@mail.gmail.com>
 <86D80EA7-9087-4042-8119-12DD5FCEAA87@amacapital.net>
 <CAHk-=wim-2aaFi_GNs5KmX4ykkgQjnRo5D4B9ZK+1Oz=kpp_2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wim-2aaFi_GNs5KmX4ykkgQjnRo5D4B9ZK+1Oz=kpp_2A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 09:33:21AM -0700, Linus Torvalds wrote:
> On Tue, Mar 24, 2020 at 9:22 AM Andy Lutomirski <luto@amacapital.net> wrote:
> >
> > I haven’t checked if static calls currently support return values, but
> > the conditional case only makes sense for functions that return void.
> >
> > Aside from that, it might be nice for passing NULL in to warn or bug
> > when the NULL pointer is stored instead of silently NOPping out the
> > call in cases where having a real implementation isn’t optional.
> 
> Both good points. I take back my question.
> 
> And it aside from warning about passing in NULL then it doesn't work,
> I wonder if we could warn - at build time - when then using the COND
> version with a function that doesn't return void?

I actually (abuse) do that in the last patch... the reason being that
DEFINE_STATIC_COND_CALL() ends up only needing a type expression for the
second argument, while DEFINE_STATIC_CALL() needs an actual function.

> Of course, one alternative is to just say "instead of using NOP, use
> 'xorl %eax,%eax'", and then we'd have the rule that a NULL conditional
> function returns zero (or NULL).
> 
> I _think_ a "xorl %eax,%eax ; retq" is just three bytes and would fit
> in the tailcall slot too.

Correct. The only problem is that our text patching machinery can't
replace multiple instructions :/
