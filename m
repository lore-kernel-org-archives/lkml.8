Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489F0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12102206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j68qL3vm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgCXQzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:55:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42708 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgCXQzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A0ojL14BqOuhudwXrers//6Y4R0jtCChC5fidi/X22w=; b=j68qL3vmM3RwzBBTQ+9Yhd1Wif
        wVcKyM8VC/1JnZ8JktLxZ7gMe+8u0DF51w6z959S65beMOMmux0PgTtp6Da9UG/nSy2J7iQAPRvAr
        XMVyadEkWSB3att8VgPXRwB/3lnUavIb4OGSCRQn9mOZz306rdb3y3vprbti4mmCshhw5yECazS9I
        6BsEOA2MlM/LdDfjHGE6ZRVSHN1KGOzqAfmIdKIJJTyX3lLq5FVigxGXCShY2nGJXDNdpNJCeAuJE
        lKCbaAZh7dnT2aWbE+6e8LApfvPkMEpMp2hJeimHWSL5PsH0om58yBJzULXR+RY5GT9NToLLimqUt
        BjZS7vPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGmpM-0007kH-2r; Tue, 24 Mar 2020 16:54:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5584E300235;
        Tue, 24 Mar 2020 17:54:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D85429942924; Tue, 24 Mar 2020 17:54:54 +0100 (CET)
Date:   Tue, 24 Mar 2020 17:54:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
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
Message-ID: <20200324165454.GT20696@hirez.programming.kicks-ass.net>
References: <20200324135603.483964896@infradead.org>
 <20200324142246.127013582@infradead.org>
 <CAHk-=wiumU4QxAkT+GqhBt5f-iUsoLNC0sqVfRKp0xypA6aNYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiumU4QxAkT+GqhBt5f-iUsoLNC0sqVfRKp0xypA6aNYg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 09:14:03AM -0700, Linus Torvalds wrote:
> On Tue, Mar 24, 2020 at 7:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Extend the static_call infrastructure to optimize the following common
> > pattern:
> >
> >         if (func_ptr)
> >                 func_ptr(args...)
> 
> Is there any reason why this shouldn't be the default static call pattern?
> 
> IOW, do we need the special "cond" versions at all? Couldn't we just
> say that this is how static calls fundamentally work - if the function
> is NULL, they are nops?

That doesn't work for functions that have a return value ...
