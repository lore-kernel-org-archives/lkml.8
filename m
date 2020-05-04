Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612B1C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A184206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nklJoaws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgEDUPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 16:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgEDUPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:15:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACD3C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 13:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2TcUtaWp3wFabHdWXfNuBqhbDKwLRDZ1qlu164S8104=; b=nklJoawsAZGZx7AdRPkW4ueTHX
        YctFzrXdBB0Hcnir3g6OcptY66IYheo/JYaGIZSbz6sNHq2SDXvYyPPsrLSyFbj9dt2V6IMVIN6C8
        uzg2C67WR09xrlifdkI1Jm+EatwEsKj/jeaIj9CPHiWE+MVHOy7Jf+3HZ2kLiXMpgCeYwUxcn+cFZ
        66W9orhlUxciSU/2swWNjPVDod1PzEK1U1CdhaTozZwiaYH4g9gUgT1s2p2Luqf3AuCYzjB8ItjPa
        lkSgOK4upLABVZlbJ7bzus64M6JZ1oz/YiHRfk/Js+iGi5Z/IeFOTUCO4AU3FshLpIjSPAP6KuEyt
        h1vlTO4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVhUG-0004Uy-Sh; Mon, 04 May 2020 20:14:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 955D2304B7F;
        Mon,  4 May 2020 22:14:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 61D882B135165; Mon,  4 May 2020 22:14:45 +0200 (CEST)
Date:   Mon, 4 May 2020 22:14:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 14/18] static_call: Add static_cond_call()
Message-ID: <20200504201445.GQ3762@hirez.programming.kicks-ass.net>
References: <20200501202849.647891881@infradead.org>
 <20200501202944.593400184@infradead.org>
 <1238787e-d97d-f09b-d76d-2df2dc273f4b@rasmusvillemoes.dk>
 <20200503125813.GL3762@hirez.programming.kicks-ass.net>
 <a53369f3-665a-af0e-efad-09ae456af847@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a53369f3-665a-af0e-efad-09ae456af847@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 09:20:03AM +0200, Rasmus Villemoes wrote:

> > So there is something utterly terrible we can do to address both:
> > 
> > void __static_call_nop(void)
> > {
> > }
> > 
> > #define __static_cond_call(name) \
> > ({ \
> > 	void *func = READ_ONCE(STATIC_CALL_KEY(name).func); \
> > 	if (!func) \
> > 		func = &__static_call_nop; \
> > 	(typeof(STATIC_CALL_TRAMP(name))*)func; \
> > })
> > 
> > #define static_cond_call(name) (void)__static_cond_call(name)
> > 
> > This gets us into Undefined Behaviour territory, but it ought to work.
> > 
> > It adds the READ_ONCE(), and it cures the argument evaluation issue.
> 
> Indeed, that is horrible. And it "fixes" the argument evaluation by
> changing the !HAVE_STATIC_CALL case to match the HAVE_STATIC_CALL, not
> the other way around,

Correct; making it the other way is far more 'interesting'. It would
basically mean combining the static_branch and static_call, but that
would also make it less optimal for simple forwarding cases.

> which means that it is not a direct equivalent to the
> 
>   if (foo)
>      foo(a, b, c)
> 
> [which pattern of course has the READ_ONCE issue, but each individual
> existing site with that may be ok for various reasons].
> 
> Is gcc smart enough to change the if (!func) to a jump across the
> function call (but still evaluting side effects in args), or is
> __static_call_nop actually emitted and called?

I was hoping it would be clever, but I just tried (find below) and it is
not -- although there's always hoping a newer version / clang might be
smarter.

It does indeed emit the nop function :/

> If the latter, then one
> might as well patch the write-side to do "WRITE_ONCE(foo, func ? :
> __static_call_nop)" and elide the test from __static_cond_call() - in
> fact, that just becomes a single READ_ONCE. [There's probably some
> annoying issue with making sure static initialization of foo points at
> __static_call_nop].

But that would not give a more clever compiler the ability to do the
'right' thing here..

> And that brings me to the other issue I raised - do you have a few
> examples of call sites that could use this, so we can see disassembly
> before/after?

Patch 17 has a few -- which is why I wrote the support in the first
place. Obviously those will never ever hit the !HAVE_STATIC_BRANCH case.

> I'm still concerned that, even if there are no
> side-effects in the arguments, you still force the compiler to
> spill/shuffle registers for call/restore unconditionally, whereas with a
> good'ol if(), all that work is guarded by the load+test.

https://godbolt.org/z/SDRG2q

---
#include <stddef.h>


#define READ_ONCE(var)		(*((volatile typeof(var) *)&(var)))
#define WRITE_ONCE(var, val)	(*((volatile typeof(var) *)&(var)) = (val))

struct static_call_key {
	void *func;
};

#define DECLARE_STATIC_CALL(name, func)	\
	extern struct static_call_key name; \
	extern typeof(func) __SCT__##name;

#define DEFINE_STATIC_COND_CALL(name, _func) \
	DECLARE_STATIC_CALL(name, _func) \
	struct static_call_key name = { \
		.func = NULL, \
	}

static void __static_call_nop(void)
{
}

#define __static_cond_call(name) \
({ \
	void *func = READ_ONCE(name.func); \
	if (!func) \
		func = &__static_call_nop; \
	(typeof(__SCT__##name)*)func; \
})

#define static_cond_call(name) (void)__static_cond_call(name)

static void inline static_call_update(struct static_call_key *call, void *func)
{
	WRITE_ONCE(call->func, func);
}

volatile int _x;

void bar(int x)
{
	_x = x;
}

DEFINE_STATIC_COND_CALL(foo, bar);

void ponies(int x)
{
	static_cond_call(foo)(x);
}
