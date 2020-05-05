Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3860AC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 09:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E10B206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 09:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BVqzgdyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgEEJgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 05:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbgEEJgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 05:36:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977B4C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 02:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZM0VHNr+2PqNGH/2fYDW3FKPw90TSuCLdRgYmXwrR+8=; b=BVqzgdygMhhzw0WM6XfsH145Le
        CKEc3vi0uXVFFVR17fAMuEnqJ02B2mP0U05hTLlNki25dEaAWRRCKE1QVJLkVn08/KazJLSMj6jEA
        cLDl0pT26xziJpnXv38unIW1QOqy5I6a5dOOeUxuqhALQn5FLXNKsRMPVWO+9/p1zDUTyMuGIvaNY
        N/5Q27P5NMzgmhR9kH7JhOwv0Gl60V6AFJ5X8s6cyyCzv1AIVhu2mM3EM5bQYcpf7mRL62GFNGGqe
        AojH28dWpSR6r+R6aABsNpz49JcvSmBH2PBWJESURB5lLujhuDYB/Hg7NA6Ko8gRcSmbV4aqP2ZZg
        dDGtTFpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVu04-0006jt-Ms; Tue, 05 May 2020 09:36:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 414C2300238;
        Tue,  5 May 2020 11:36:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 268682B0C5BA7; Tue,  5 May 2020 11:36:25 +0200 (CEST)
Date:   Tue, 5 May 2020 11:36:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        hjl.tools@gmail.com, ndesaulniers@google.com
Subject: Re: [PATCH v4 14/18] static_call: Add static_cond_call()
Message-ID: <20200505093625.GE5298@hirez.programming.kicks-ass.net>
References: <20200501202849.647891881@infradead.org>
 <20200501202944.593400184@infradead.org>
 <1238787e-d97d-f09b-d76d-2df2dc273f4b@rasmusvillemoes.dk>
 <20200503125813.GL3762@hirez.programming.kicks-ass.net>
 <a53369f3-665a-af0e-efad-09ae456af847@rasmusvillemoes.dk>
 <20200504201445.GQ3762@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504201445.GQ3762@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


HJ, Nick,

Any chance any of you can see a way to make your respective compilers
not emit utter junk for this?

On Mon, May 04, 2020 at 10:14:45PM +0200, Peter Zijlstra wrote:

> https://godbolt.org/z/SDRG2q
> 
> ---
> #include <stddef.h>
> 
> 
> #define READ_ONCE(var)		(*((volatile typeof(var) *)&(var)))
> #define WRITE_ONCE(var, val)	(*((volatile typeof(var) *)&(var)) = (val))
> 
> struct static_call_key {
> 	void *func;
> };
> 
> #define DECLARE_STATIC_CALL(name, func)	\
> 	extern struct static_call_key name; \
> 	extern typeof(func) __SCT__##name;
> 
> #define DEFINE_STATIC_COND_CALL(name, _func) \
> 	DECLARE_STATIC_CALL(name, _func) \
> 	struct static_call_key name = { \
> 		.func = NULL, \
> 	}
> 
> static void __static_call_nop(void)
> {
> }
> 
> #define __static_cond_call(name) \
> ({ \
> 	void *func = READ_ONCE(name.func); \
> 	if (!func) \
> 		func = &__static_call_nop; \
> 	(typeof(__SCT__##name)*)func; \
> })
> 
> #define static_cond_call(name) (void)__static_cond_call(name)
> 
> static void inline static_call_update(struct static_call_key *call, void *func)
> {
> 	WRITE_ONCE(call->func, func);
> }
> 
> volatile int _x;
> 
> void bar(int x)
> {
> 	_x = x;
> }
> 
> DEFINE_STATIC_COND_CALL(foo, bar);
> 
> void ponies(int x)
> {
> 	static_cond_call(foo)(x);
> }
