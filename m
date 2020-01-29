Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C34CC33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 03:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552C7214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 03:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580267684;
	bh=gO8ClaRaVELAIYqKwVZFzCc/EI8+9TorTmOyvmi3qlk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=Zw356NkajuYqAjobS4WbOIIJTaGNt6vIamitI/9WMaw4njwu9aS3FRR0LiVeZwUCV
	 88hlzTz8tNHLDHyOAs3xttD2Neo/YAh/NUZ8/ntZCa6+faDWHsikNgBRIhyHS8R45p
	 UOlsynAE4iRBsAcxhtDI+Jm/EllmR0TTuXld1Adw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgA2DOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 22:14:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:44846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgA2DOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 22:14:43 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAB8D207FF;
        Wed, 29 Jan 2020 03:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580267682;
        bh=gO8ClaRaVELAIYqKwVZFzCc/EI8+9TorTmOyvmi3qlk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=dTuV5Y1jrOs/k0XNTGdhsWKKFMeu3GlTr6IA6lAElOsQW9oHFOYLV20b8BkyHQGd6
         wnB4H2SGhH13dJ7Y1ZLMiQtCRroySDr2dZ8FcUIyZgbObnpd/LiLju3BsQjUmmGesy
         Gwk6N8Be2JrjqU4iwOuFoIGNSef5WngP0OMI3Dmg=
Date:   Wed, 29 Jan 2020 04:14:36 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Petr Mladek <pmladek@suse.com>, Miroslav Benes <mbenes@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jessica Yu <jeyu@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, live-patching@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
In-Reply-To: <20200129021619.cvbsvmag2v4tyjek@treble>
Message-ID: <nycvar.YFH.7.76.2001290404240.31058@cbobk.fhfr.pm>
References: <20200120165039.6hohicj5o52gdghu@treble> <alpine.LSU.2.21.2001210922060.6036@pobox.suse.cz> <20200121161045.dhihqibnpyrk2lsu@treble> <alpine.LSU.2.21.2001221052331.15957@pobox.suse.cz> <20200122214239.ivnebi7hiabi5tbs@treble>
 <alpine.LSU.2.21.2001281014280.14030@pobox.suse.cz> <20200128150014.juaxfgivneiv6lje@treble> <20200128154046.trkpkdaz7qeovhii@pathway.suse.cz> <20200128170254.igb72ib5n7lvn3ds@treble> <nycvar.YFH.7.76.2001290141140.31058@cbobk.fhfr.pm>
 <20200129021619.cvbsvmag2v4tyjek@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2020, Josh Poimboeuf wrote:

> > For the cases I've seen so far, it has always been gcc deciding under 
> > certain circumstances not to propagate __attribute__((__noreturn__)) from 
> > callee to caller even in the cases when caller unconditionally called 
> > callee.
> > 
> > AFAIU, the behavior is (and always will) be dependent on the state of gcc 
> > optimizations, and therefore I don't see any other way than adding 
> > __noreturn anotation transitively everywhere in order to silence objtool.
> > 
> > So those cases have to be fixed anyway.
> > 
> > What are the other cases please? Either I have completely missed those, or 
> > they haven't been mentioned in this thread.
> 
> For example, see:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?h=objtool-fixes&id=6265238af90b395a1e5e5032a41f012a552d8a9e
> 
> Many of those callees are static noreturns, for which we've *never*
> needed annotations.  Disabling -fipa-pure-const has apparently changed
> that.

For some reason I thought you were talking about static inlines, sorry for 
the noise.

Yeah, so I agree with you -- whether we need those anotations depends on 
compiler implementation of optimizations, and most importantly on (the 
current state of) internal implementation of specific optimizations in 
gcc.

Leaving live patching completely aside for the sake of this discussion for 
now -- I believe we either fully rely on gcc to propagate the 'noreturn' 
propery throughout the callstack upward, or we don't.

If we don't, then we do need the anotations (both the global and static 
ones), and problem solved.

If we do, well, where is the 'this is *the* behavior of any current/future 
clang^Wcompiler' invariant guarantee?

Thanks,

-- 
Jiri Kosina
SUSE Labs

