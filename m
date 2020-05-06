Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2231C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C189206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zoRnF2zy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgEFQP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729481AbgEFQP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:15:57 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534F1C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 09:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=le1OFYu72/kMH5Lgm/DrtMirSfET+FXsAUvpWVi5058=; b=zoRnF2zyubEwJ1uXDboQzy+lmw
        TeQ0m76xZtlNZL9Nc+Qv608OIhmCYJfsy/mD8VxnTBRUsAWaZ7WFJkvb4MgqK9Q/5uYevKLKGVQRo
        qv0V3grPNpRvWcUxMfREGpbgGkRMM5Ck7eQ8xZnyKnDxjI3ob5XwUOgb+P6Wm6xQMc/hCukFim56v
        QDYYiu8MnJjRhfvPqs0sYTr8mue1VCM/xvVRiQOZX3cUeqWfabin5dXLZUG/3pH/XKeJd4mv5OLqn
        pM6GqQkYo5q4xtCef0Dc7F2FXq5yvyg+71Yau8ZmqWtNQNkgba/3BaKYUxLczqtUSc4BeWfz5118T
        j8IcLuEQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWMhg-00061K-Pq; Wed, 06 May 2020 16:15:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A1B1F30018B;
        Wed,  6 May 2020 18:15:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E9CC203ECDC3; Wed,  6 May 2020 18:15:22 +0200 (CEST)
Date:   Wed, 6 May 2020 18:15:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 07/18] static_call: Add inline static call
 infrastructure
Message-ID: <20200506161522.GT3762@hirez.programming.kicks-ass.net>
References: <20200501202849.647891881@infradead.org>
 <20200501202944.186964469@infradead.org>
 <20200505221051.x6mz33ylqy62m4s4@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505221051.x6mz33ylqy62m4s4@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 05:10:51PM -0500, Josh Poimboeuf wrote:
> On Fri, May 01, 2020 at 10:28:56PM +0200, Peter Zijlstra wrote:
> > +#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
> > +
> > +struct static_call_mod {
> > +	struct static_call_mod *next;
> > +	struct module *mod; /* for vmlinux, mod == NULL */
> > +	struct static_call_site *sites;
> > +};
> > +
> > +struct static_call_key {
> > +	void *func;
> > +	struct static_call_mod *next;
> > +};
> 
> "next" implies it links to another key.  How about "mods" or
> "site_mods"?
> 
> > +++ b/include/linux/static_call_types.h
> > @@ -2,14 +2,27 @@
> >  #ifndef _STATIC_CALL_TYPES_H
> >  #define _STATIC_CALL_TYPES_H
> >  
> > +#include <linux/types.h>
> >  #include <linux/stringify.h>
> >  
> >  #define STATIC_CALL_PREFIX		__SC__
> > +#define STATIC_CALL_PREFIX_STR		__stringify(STATIC_CALL_PREFIX)
> > +#define STATIC_CALL_PREFIX_LEN		(sizeof(STATIC_CALL_PREFIX_STR) - 1)
> 
> STATIC_CALL_KEY_PREFIX_STR
> STATIC_CALL_KEY_PREFIX_LEN
> 

> > +#ifdef CONFIG_MODULES
> > +		if (site_mod->mod) {
> > +			stop = site_mod->mod->static_call_sites +
> > +			       site_mod->mod->num_static_call_sites;
> > +		}
> > +#endif
> 
> Instead of defining 'mod' in the inner loop below, it can be set at the
> top of the outer loop above.  Then the above 'stop' calculation can
> be a little less verbose.

All done!
