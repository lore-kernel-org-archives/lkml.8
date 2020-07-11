Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84892C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 05:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 602902076A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 05:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VUyiP2OM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgGKFIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 01:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbgGKFIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 01:08:35 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF56C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 22:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v/yBN8QELEeZJAZYyas5qw0LvOk7p1in6KpapI+Bes4=; b=VUyiP2OMyTXVa2UFWBaPqg3fuX
        bDmTYbU6ncd8qalrJ3TDWtQPQsQnTQnZIRFxfeiDGpW6w7BmGI/YrO6RyO+p1ENwNe0WZyhkuf4WN
        UUv1n/wqU6Kp/uOxvuaorLLTRVLTRZtw5dWmxLlIZ+LYGWZqjqV1szoLLZNsVOAsxAqNqm9W509cM
        DLd44YrwTLYJ515xDGVoWZ5W2dih37U/Hg0J7aKH7g0SsQ8+Ltz5gmBnbKW06pqGqZFjeOMPu3Yr4
        c2Uf7k+WchECR6MoFQ68ODZdn9AelEkup4c2NHVBoA7wEcWJWJImKyOkGVSPFA6XhiFB4JuYhGewK
        iDJkepOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ju7k3-0005sn-Db; Sat, 11 Jul 2020 05:08:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D17D1304E03;
        Sat, 11 Jul 2020 07:08:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BFA932B85DD2B; Sat, 11 Jul 2020 07:08:00 +0200 (CEST)
Date:   Sat, 11 Jul 2020 07:08:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v6 14/17] static_call: Handle tail-calls
Message-ID: <20200711050800.GX597537@hirez.programming.kicks-ass.net>
References: <20200710133831.943894387@infradead.org>
 <20200710134336.977578032@infradead.org>
 <20200710202319.3c3eec12@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710202319.3c3eec12@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 08:23:19PM -0400, Steven Rostedt wrote:
> On Fri, 10 Jul 2020 15:38:45 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> > @@ -1639,6 +1647,10 @@ static int decode_sections(struct objtoo
> >  	if (ret)
> >  		return ret;
> >  
> > +	ret = read_static_call_tramps(file);
> > +	if (ret)
> > +		return ret;
> > +
> >  	ret = add_jump_destinations(file);
> >  	if (ret)
> >  		return ret;
> > @@ -1671,10 +1683,6 @@ static int decode_sections(struct objtoo
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = read_static_call_tramps(file);
> > -	if (ret)
> > -		return ret;
> 
> Hmm, what's the reason for moving this above? Should we have a comment
> here if there's importance that read_static_call_trampoline() is done
> earlier?

I suppose comments is something objtool lacks more of.

The reason is that add_jump_destination() is the thing that does
tail-call detection, and if it wants to add static-call sites, it needs
to know about the trampolines.
