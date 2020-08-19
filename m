Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F89DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B560206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eNOHhxxy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgHSHdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgHSHdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:33:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E865EC061389
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kL7Gy3l7twO0D8ptMuadg/doUyMGt2vPrUvqyXCwPw8=; b=eNOHhxxyLZrugshdJbYPUtuTMS
        r0a5RcmYbofB+vlliEEwViJsDb9UzyUMZ2VelSJ5QR/piQexaidM3b7ncK5AgSg8E/VznQaVgELJr
        +ikQpGI71NU9rl2+Awv+HyxOZwxAiTk/CTcsPsub+8ey+fJABxXBCg/vROM43C/XpptlZgh5hRp10
        WVJvm/yOP+ihmjl+RyqmmrGZLMQJE31Sx39iWjCAO1RRXTeryUQgwZl9DPBQySsoIcmSQrg4lUrYV
        PSNGUsN5FMbNmO0rK93pNKRh2HS9mYViccnfX/TPnlLRuuosWzwj6cPC4jXz7aUWac7bCoGZfl73t
        yEXJmyig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8Iaf-0003t3-B2; Wed, 19 Aug 2020 07:32:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 080F3301179;
        Wed, 19 Aug 2020 09:32:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C476821A87267; Wed, 19 Aug 2020 09:32:53 +0200 (CEST)
Date:   Wed, 19 Aug 2020 09:32:53 +0200
From:   peterz@infradead.org
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] sched/cputime: Mark function as __maybe_unused
Message-ID: <20200819073253.GV2674@hirez.programming.kicks-ass.net>
References: <20200818170337.805624-1-alex.dewar90@gmail.com>
 <CAKwvOdk2fynn=-FGUniYLG+hCOkEFppRnAaTYe8DW=YRrT-siQ@mail.gmail.com>
 <20200818195746.scpjm3dlg7cfst53@medion>
 <CAKwvOdn=32A4QumC_-Y8fJ29fqUPzPK0H_7-dn6rcsAT+O1xOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn=32A4QumC_-Y8fJ29fqUPzPK0H_7-dn6rcsAT+O1xOw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 01:02:26PM -0700, Nick Desaulniers wrote:
> On Tue, Aug 18, 2020 at 12:57 PM Alex Dewar <alex.dewar90@gmail.com> wrote:
> >
> > On Tue, Aug 18, 2020 at 11:13:10AM -0700, Nick Desaulniers wrote:
> > > On Tue, Aug 18, 2020 at 10:04 AM Alex Dewar <alex.dewar90@gmail.com> wrote:
> > > >
> > > > Depending on config options, account_other_time() may not be called
> > > > anywhere. Add __maybe_unused flag to fix clang warning.
> > >
> > > Just curious, would moving this definition to be within an existing
> > > preprocessor guard for a particular config also fix the issue? If so,
> > > prefer that. If not, __maybe_unused is the way to go.
> >
> > I don't think that'd work here: it's used within an "#ifdef
> > CONFIG_IRQ_TIME_ACCOUNTING" block and a separate "#ifdef
> > CONFIG_VIRT_CPU_ACCOUNTING_GEN" one. We could do:
> >         #if defined(CONFIG_IRQ_TIME_ACCOUNTING) ||
> >             defined(CONFIG_VIRT_CPU_ACCOUNTING)
> >                 ...
> > ... but that might be a bit ugly.
> 
> Yeah, ok, in that case it's fine.  One issue with __maybe_unused is
> that this function will stick around forever if all call sites get
> removed.  But when the preprocessor checks start getting hairy,
> __maybe_unused is maybe simpler.

Urgh, also, I have vague memories that we made it 'static inline' to
avoid all this. Should we instead mark it __always_inline ?

Also; I detest the placement of __maybe_unused, it is not a return
value, but a git-grep showed me it is wide-spread :/
