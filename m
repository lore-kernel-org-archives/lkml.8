Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81112C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 10:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56FA320725
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 10:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bwji0JsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgGKKbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 06:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgGKKbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 06:31:08 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B33C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 03:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KrJ9iLTZQl5NQdWgFA7KQFzGvGlclJ6r/Qp+kyDAyJM=; b=bwji0JsBMFusD4ea7xAhjoxjxX
        KMR0fjNrX41T0UqdHVZ/OI+9vUbwqPOAHCH/xVbmvojqq6Q7tyLEsrbjfNZsn6jgoBCt+Eu0bDtjm
        WE1I+9uxN4b0whgry6mKkvoKS69JtwcsuJ2iD3OJtwYxLUzXM5adXSTj89Mo4yG9icQQxeKrKLV/t
        Lj0/Wgq5Zyee9M83SRWTxxMSDDW9l1+9lEjFOPgEuIzXsa13FB4yXav+GYvrtl4RgrP1Z0Q3Y7A8y
        93/Wjhyo+rRi0+L2nAynWIY6CDLfK2eqzeuif/t1ddre/0JWDUcKZnd+EAC8E2Giys6n1E18cHgDF
        c3oXg1Qg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1juCmV-0000rQ-53; Sat, 11 Jul 2020 10:30:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9C8C5304E03;
        Sat, 11 Jul 2020 12:30:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 873C5203C9766; Sat, 11 Jul 2020 12:30:53 +0200 (CEST)
Date:   Sat, 11 Jul 2020 12:30:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v6 08/17] static_call: Avoid kprobes on inline
 static_call()s
Message-ID: <20200711103053.GD597537@hirez.programming.kicks-ass.net>
References: <20200710133831.943894387@infradead.org>
 <20200710134336.619632370@infradead.org>
 <20200710180014.08803c91@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710180014.08803c91@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 06:00:14PM -0400, Steven Rostedt wrote:

> > +int static_call_text_reserved(void *start, void *end)
> > +{
> > +	int ret = __static_call_text_reserved(__start_static_call_sites,
> > +			__stop_static_call_sites, start, end);
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +#ifdef CONFIG_MODULES
> > +	ret = __static_call_mod_text_reserved(start, end);
> > +#endif
> 
> Nit, but why not have a #else /* !CONFIG_MODULE */ above and just:
> 
> static inline int __static_call_mod_text_reserve(..)
> {
> 	return 0;
> }
> #endif
> 
> ?

Done.
