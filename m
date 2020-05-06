Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC13C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC6020747
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CPECWvWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbgEFSGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbgEFSGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:06:06 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546BBC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 11:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nZmipUqTbAT07iwnWiy2Asur9dI6LFhP3C0G9MYzGn4=; b=CPECWvWWV/EBkS4ofTu7d67GZH
        MBWDwU1JoLTFyapLNNQEDhnfbtYzj1Jj06i9CojR/us5nD5dA5Qm+doOykaRgn76IPL+r9TFirZOT
        0VQyKePV0BGWjXO3TejCpGOUe2SAYzXASLzRjbo3sRVHgKp0Gn4dZ1FgolceVb9KSw3t2AKjwJqp5
        49BtNL70XRq9PIL9Il0GEOwDN1qSF7y/ZV4CCQVhnbHUfDaTzpyOIrHzUBHJXAN+dw8edJ5VV7z/G
        ItQtHzb6T3ieTzdcinYQfaW1UNWag8rMFFy7RKIj+09hukwkDjRB3y0lGFenlBMrjaDwZ7BS1Lc7M
        ERH2LIXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWOQM-0000dk-9e; Wed, 06 May 2020 18:05:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D1084300238;
        Wed,  6 May 2020 20:05:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B5AAD29DE2DCD; Wed,  6 May 2020 20:05:36 +0200 (CEST)
Date:   Wed, 6 May 2020 20:05:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 00/18] Add static_call()
Message-ID: <20200506180536.GX3762@hirez.programming.kicks-ass.net>
References: <20200501202849.647891881@infradead.org>
 <20200506173229.hjl7s42hnz5bc23s@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506173229.hjl7s42hnz5bc23s@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 12:32:29PM -0500, Josh Poimboeuf wrote:
> On Fri, May 01, 2020 at 10:28:49PM +0200, Peter Zijlstra wrote:
> > static_call(), is the idea of static_branch() applied to indirect function
> > calls. Remove a data load (indirection) by modifying the text.
> > 
> > The inline implementation still relies on objtool to generate the
> > .static_call_sites section, mostly because this is a natural place for x86_64
> > and works for both GCC and LLVM.  Other architectures can pick other means
> > if/when they implement the inline patching. The out-of-line (aka. trampoline)
> > variant doesn't require this.
> > 
> > Patches go on top of tip/objtool/core.
> > 
> > Patches can also be found here:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/static_call
> 
> So this branch has
> 
>   45a5c99a226a ("x86/tlb: Move trace_tlb_flush() declaration")
> 
> but I didn't see it posted here.  I guess you dropped it because it's no
> longer needed b/c we fixed those 'undefined references' a different way.

Correct; still prossibly a sane clean-up, but I got rid of it for now.
