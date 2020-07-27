Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411EBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17BBF206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L7vznXBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgG0Mu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbgG0Mu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:50:26 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409E1C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 05:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VE6QmdbdGYrO4mIND/yaE0rHPpa39jKtd1ljEPqsIO8=; b=L7vznXBbVdQ49IqAQur2kg4gd3
        nKvW8dRdRkzOU2aZGdWCTQxMD/l4rr/H8i667DQPhy+PQT85F7UxvMQzjtOb6o5fBx5br0p3TVuRz
        LRV/Mgcpp/Sdb0VnO4xe04EzBQ/1Rq2VYo+WCNm94T0O852XIG0FaFdHiA3uqlKrsGlOysQtoj8MI
        Exsn1pJ8MlKRD0LX6xa2eAR03b578RhFHrV909RIBdbYvMcMi74vqgJDTIWGNDc1/Zj13xLcNm6cd
        2nFZfUVjg9BUuyFN7LPThx+eL/TnSYVWmKkmiT1sCdTx1M2AcKCQzIhGFEBiXC4st5OcQ7Ol8g60w
        qnavhZzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k02aD-00022I-PD; Mon, 27 Jul 2020 12:50:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3DD25301EE3;
        Mon, 27 Jul 2020 14:50:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3086F29DBC081; Mon, 27 Jul 2020 14:50:19 +0200 (CEST)
Date:   Mon, 27 Jul 2020 14:50:19 +0200
From:   peterz@infradead.org
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH] objtool,x86: Verify poke_int3_handler() is self contained
Message-ID: <20200727125019.GL119549@hirez.programming.kicks-ass.net>
References: <20200727104050.GH119549@hirez.programming.kicks-ass.net>
 <20200727112144.GA55660@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727112144.GA55660@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 01:21:44PM +0200, Ingo Molnar wrote:
> 
> * peterz@infradead.org <peterz@infradead.org> wrote:
> 
> > 
> > Abuse the SMAP rules to ensure poke_int3_handler() doesn't call out to
> > anything.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  tools/objtool/check.c |    8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -551,6 +551,14 @@ static const char *uaccess_safe_builtin[
> >  	"__memcpy_mcsafe",
> >  	"mcsafe_handle_tail",
> >  	"ftrace_likely_update", /* CONFIG_TRACE_BRANCH_PROFILING */
> > +	/*
> > +	 * Abuse alert!
> > +	 *
> > +	 * poke_int3_handler() is not in fact related to uaccess at all, we
> > +	 * abuse the uaccess rules to ensure poke_int3_handler() is self
> > +	 * contained and doesn't CALL out to other code.
> > +	 */
> > +	"poke_int3_handler",
> 
> So ->uaccess_safe makes sure that we don't CALL into non-uaccess-safe 
> functions, but it still allows CALLs into *other* uaccess-safe 
> functions, right?
> 
> So unless I missed something in the logic, the comment should say 
> something like "doesn't CALL out to other non-uaccess safe code" or 
> so? Which is, arguably, like 99% of all functions - but still, a whole 
> bunch are allowed, such as low level instrumentation and other utility 
> functions.

Right, so poke_int3_handler() is also noinstr and by that isn't allowed
to call out into !noinstr code. The intersection should be small.

But yeah, perhaps this is a bad idea and I should add another annotation
for this,.. dunno.
