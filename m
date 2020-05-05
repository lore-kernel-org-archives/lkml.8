Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72B3C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 09:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B541120675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 09:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="izGtgSFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgEEJjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 05:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728180AbgEEJjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 05:39:22 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19221C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 02:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6q5CF8k/c5Te8PjjSS4lxwcfRCCIHzQQTe6jpMzty/4=; b=izGtgSFn7YQL+Oi3BDbyeUY0XE
        0Q9Zqt4VSF1NCChV2EeNKF5UL6YLT4rkDAPwag6wo/9NwFSWWI7VW2bhI2M6iyNzIn2hOjJ75g4wg
        P7Kjatzq75SeOB7oUok+74YGgBP6rkT8UlDRIyZFSyPLfhAxsSDetekIGX9qgcNJ2p2MYBcWNRuft
        okp/977Il75XhjRMpd2zcWuDwbW7urmrBVpms2KoKnnApBv5N+GjIPwjsynLx1dp3Q9otA0uT34Ds
        TxtK3cuxgtzy6MSJQ/RnVxmnDEhgNyfdEP7uiBsH/83tCYYLbvkEBdWyzwXA7K/GHna0Ivd/kFnPr
        L/4X3BTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVu2G-0007rK-BH; Tue, 05 May 2020 09:38:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 35A34300238;
        Tue,  5 May 2020 11:38:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 170162B62ED99; Tue,  5 May 2020 11:38:40 +0200 (CEST)
Date:   Tue, 5 May 2020 11:38:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 14/18] static_call: Add static_cond_call()
Message-ID: <20200505093840.GF5298@hirez.programming.kicks-ass.net>
References: <20200501202849.647891881@infradead.org>
 <20200501202944.593400184@infradead.org>
 <1238787e-d97d-f09b-d76d-2df2dc273f4b@rasmusvillemoes.dk>
 <20200503125813.GL3762@hirez.programming.kicks-ass.net>
 <a53369f3-665a-af0e-efad-09ae456af847@rasmusvillemoes.dk>
 <20200504201445.GQ3762@hirez.programming.kicks-ass.net>
 <6cb31c72-ce0e-7923-daca-ce5ef414940b@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cb31c72-ce0e-7923-daca-ce5ef414940b@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 09:50:26AM +0200, Rasmus Villemoes wrote:
> On 04/05/2020 22.14, Peter Zijlstra wrote:

> Anyway, it's hard to judge what version of the !HAVE_STATIC_CALL
> implementation is best when there's no !HAVE_STATIC_CALL use cases to
> look at. I just want to ensure that whatever limitations or gotchas
> (e.g., "arguments are evaluated regardless of NULLness of func", or
> alternatively "arguments must not have side effects") it ends up with
> get documented.

I can certainly try and write a better comment for it.

> > #define __static_cond_call(name) \
> > ({ \
> > 	void *func = READ_ONCE(name.func); \
> > 	if (!func) \
> > 		func = &__static_call_nop; \
> > 	(typeof(__SCT__##name)*)func; \
> > })
> 
> I think you can just make it
> 
> #define __static_cond_call(name) \
> ( \
> (typeof(__SCT__##name)*) ((void *)name.func ? : (void *)__static_call_nop) \
> )

I _think_ the compiler sees the two as exactly the same, but then, I've
not seen the inside of a modern compiler.

> but that simplification is not enough to make gcc change its mind about
> how to compile it :( But I'm guessing that various sanitizers or static
> checkers might complain about the UB.

Yeah, we'll see.
