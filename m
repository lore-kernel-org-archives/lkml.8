Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593A7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A955723119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="J0oSNU5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgHFRIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729587AbgHFRIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:08:06 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DFEC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 10:08:05 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o18so51097432eje.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 10:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f8/nn7ZbDCfrAUl2xyqy7+UpgLeitL0XyOQaDvrk0gg=;
        b=J0oSNU5c9WU8jd827FqViUbaxw7NHF1awlvX2T/tm5YLVqSpmrQLHI1cWovA9K2aNX
         EkfiIzRlW4k7NA5brGbVauGTIRidQB4Pa4EXjUCuqmeA3JTA145PcxNTkcT6vVAYn1Gt
         Y65hCqFpf3KzbLLL2ngYFJqX7c8QuPRGJcixbRyNZqqhXRuvM64nC8ynh75Q8YMMv1k1
         lkjWugxLLu4cCDse8vopnEgWjXRM9/onm2fAFLu0QLbOFzte8sFMzEZb9DfIfbMOfOLD
         oBABcc1f+0wB/c8H6UNr7fty7ujUc8kwJKUW9EUafoKJ5J7E+2r5yZ3WNqQmKC7KWI2Q
         JjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f8/nn7ZbDCfrAUl2xyqy7+UpgLeitL0XyOQaDvrk0gg=;
        b=iWRjlpUrl7dKfEUcDTuRGzmBtZJo8yCmqqAFHgIEbrZ5EagWKXSUAwBJ0dmSt2ME68
         0/TktzXBaxNFthB9hrXOk5L6NY9Fa05qp1cSX0rojW/PzR74+c58Dzn2+jX1aHXgGHIK
         /fFEhv8v9rdN7mts9LveZDoLCAhyGUgVjrwtm10Ig+IWA82uvcpKmZ9M2i/xY+vF4Yj7
         i8xZY0+zYPIXMlfjBHBAaCrbcbeC8dvrm4bQ/a819Lsv55X0xBbtiGK1iZComdwdW+/U
         yL41ji5UqTFPr6/0cHOZfP82KvuN6oyAcs2pEsGCXdHcXo7QWwjdqk7Q8uwhsxKdZFzI
         HhlA==
X-Gm-Message-State: AOAM532+1rdr0qa8vOJGInX6WcYhJnVt7AYRFRp/nD14gTPZ9uTqCSQk
        BsuvVYoYDhrlxscOxB+0KUI5ER5xC400iGPL30Oxws5J
X-Google-Smtp-Source: ABdhPJxi86q1mLGXwMz8ldpkQ6k09WKKnKCUmcGZpvpT96v/iuuruH7DIPliC1+uJAahl+fMsZf0jQ32oxnT7uGlfWU=
X-Received: by 2002:a17:906:2296:: with SMTP id p22mr5238258eja.510.1596733684514;
 Thu, 06 Aug 2020 10:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200806000859.160882-1-posk@google.com> <20200806134828.GA165568@hirez.programming.kicks-ass.net>
In-Reply-To: <20200806134828.GA165568@hirez.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@posk.io>
Date:   Thu, 6 Aug 2020 10:07:53 -0700
Message-ID: <CAFTs51Ufyds5mypiysL=2ZwtyMk9hjLm-9tJbYz=xciY1f2=5g@mail.gmail.com>
Subject: Re: [PATCH 1/2] membarrier: add MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Peter Oskolkov <posk@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 6:48 AM <peterz@infradead.org> wrote:
>
> On Wed, Aug 05, 2020 at 05:08:58PM -0700, Peter Oskolkov wrote:
>
> Thanks for the Cc!

Always a pleasure!

(Sorry, included only membarrier maintainers in v1; in v2 included
both membarrier and rseq maintainers).

>
> > + * @MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU:
> > + *                          If a thread belonging to the current process
> > + *                          is currently in an RSEQ critical section on the
> > + *                          CPU identified by flags parameter, restart it.
> > + *                          @flags: if @flags >= 0, identifies the CPU to
> > + *                                  restart RSEQ CS on; if == -1, restarts
> > + *                                  RSEQ CSs on all CPUs.
>
> > +     } else if (cpu_id == -1) {
> > +             on_each_cpu(membarrier_rseq_ipi,
> > +                         current->group_leader, true);
>
> This is an unpriv IPI the world. That's a big no-no.

removed in v2.

>
> Double so because all you want to target is the current process, which
> you're defining as CLONE_THREAD, where the rest of this file uses
> CLONE_VM to define a process.

Use current->mm in v2 instead of current->group_leader. Is it better this way?
