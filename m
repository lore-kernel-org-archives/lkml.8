Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068D7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E1D2070E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Set/N9OL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgGIJCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgGIJCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:02:35 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADAEC061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 02:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cm9KCdhqtY0plTNNXOWSI3dzdvOBgIrJHTqq7tzO9Eg=; b=Set/N9OLAj14YM+FF0WBkYD9cH
        TwUaPwRHCJyAGI6ieMtWbgRM67I9Kw41JUEsSAouNxoLs2QfdMa1Ju8nUNr8RDOxMPe36n6bIRI8d
        WlROXFl/yjX3KBYjrvPa8ZWcaw66BIRdLH1vXa1M4RWQ54dmKjxusBCy6uUQKlfTHjHMlNBC7diUv
        ov+T0yHHlF1laYoOf+AB6pC1f2EPNAgugfBvjxTwEXx/Ng/xh5ucBvsFh91stZ0S8zQ0Qy7Uzf+s4
        eUw83Np/bGSqXClyPj/IZgsaPP2gxUuZ0mwsyWBkICoOcYCMUUwsJWlwt9ma23N7PX3nMMBYAylT0
        v2sBxfeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtSRY-0001BE-Ak; Thu, 09 Jul 2020 09:02:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7785A3059C6;
        Thu,  9 Jul 2020 11:02:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 63D3B285718F1; Thu,  9 Jul 2020 11:02:10 +0200 (CEST)
Date:   Thu, 9 Jul 2020 11:02:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v5 00/17] Add static_call()
Message-ID: <20200709090210.GL597537@hirez.programming.kicks-ass.net>
References: <20200624153024.794671356@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624153024.794671356@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 05:30:24PM +0200, Peter Zijlstra wrote:
> Hi all,
> 
> Hopefully for the last time...
> 
> static_call(), is the idea of static_branch() applied to indirect function
> calls. Remove a data load (indirection) by modifying the text.
> 
> The inline implementation still relies on objtool to generate the
> .static_call_sites section, mostly because this is a natural place for x86_64
> and works for both GCC and LLVM.  Other architectures can pick other means
> if/when they implement the inline patching. The out-of-line (aka. trampoline)
> variant doesn't require this.
> 
> Patches go on top of tip/objtool/core + tip/perf/core
> 
> Patches can also be found here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/static_call
> 
> Changes since the last time:
> 
>  - Better documentation
>  - More consistent macro names
>  - Changed key prefix
>  - Folded trampoline definitions
>  - Renamed DEFINE_STATIC_COND_CALL / DEFINE_STATIC_CALL_NULL

v5.1 (patch 16) has a crash fix found by 0day, synthetic tracepoints
don't have static call sites.

Given the overwhelming feedback on this series, I'm thinking everybody
is in violent agreement with the code this time around (or just really
busy, in which case, consider this a gentle prod to send out your ACK
:-).


