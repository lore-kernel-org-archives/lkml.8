Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864E0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D0AE22D00
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="gb9t2ERu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgHGRsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgHGRsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:48:42 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FD2C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 10:48:41 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id m20so1860028eds.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 10:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1jD6vSBcep9pVCJ88Buz+hBFmqHCHo08h2XlXM8iY4=;
        b=gb9t2ERu8IGQ6tNi0ZxR5nubtWLAqXc/EC2R0cU+LNABC6fdMKUqGGuhMQP0aWtcCr
         NOKutwU0d8AkYJXjJXuM2W9PFhd13h+jbpI3nfdH9TokAxxU9XfeWLSfLxOCo4OqveqB
         H710NTxC1CkGCJ7VnCqPMxWgyNlwqr0P23OuSyBHGHR6la4eWqMXbepAyn76UVVZy7A5
         iiXoP/bDwyn+c6oNCs8wE8nWf9+LFHaD2tlHh8/DgD2FigydwUAcj/SCw5vL4xPPCMRa
         PITZdOXFlNEWqRPX2QlV3kMoGtUvWw/H5YMCdi4FG1Y6E6ON3sRSByJclSbKmu2ZkvW5
         Rblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1jD6vSBcep9pVCJ88Buz+hBFmqHCHo08h2XlXM8iY4=;
        b=r2wOmoQqZp95UiRSEU7r5IhU3dyTe6fln+r4ijRLoizPi9hMISOFSTa49eGRg0CYo5
         SyGhOEsk25hMvx5Bd1Sw9H2enP9BrSjGrFeVaycRKJyqSrlYPoxkmWegFKHLGWXHQMYL
         3hP2bnFxZ8rTzUY2NfmjkwMst+LNpKt156FEMpV5plFJDaNz3t++MZ8hV1RMK3OK/iQA
         TmmBrez/H8Zuk6AdrMytB6czTzIBon6l3vH/oMyNQmK3ewHjG67AyuTp784XeXPN25Yb
         wJD5ZCGCogfrEVCA5lLKesMmAjNea8RZzqqBhLWtX342ypoExKT27EZES7ZIvTZs4Sbf
         2YOA==
X-Gm-Message-State: AOAM531uFpksFXhFbFvoCOxVouCD/QE9k3wh+TVW3KNUgYf1r7+hA+Q+
        C6tMlL0jDhD0Kc+JnAAZaqNNgSynXqv0MUmh11YZAg==
X-Google-Smtp-Source: ABdhPJzGpjUDE2F7v4zvcrJj8Q9OnVtBAm/vW0S9za2zCKoK+R7ysCXYPqmqE/h/Cap747aZc90Hkhjn1QjcylQwHB4=
X-Received: by 2002:a50:93a2:: with SMTP id o31mr10054666eda.203.1596822520037;
 Fri, 07 Aug 2020 10:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200806000859.160882-1-posk@google.com> <20200806134828.GA165568@hirez.programming.kicks-ass.net>
 <CAFTs51Ufyds5mypiysL=2ZwtyMk9hjLm-9tJbYz=xciY1f2=5g@mail.gmail.com> <1668913120.1621.1596735425601.JavaMail.zimbra@efficios.com>
In-Reply-To: <1668913120.1621.1596735425601.JavaMail.zimbra@efficios.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Fri, 7 Aug 2020 10:48:29 -0700
Message-ID: <CAFTs51VabphnoXOxLgUqDL288zfLpEugC-H5jxg=JGhTHB7QDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] membarrier: add MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Peter Oskolkov <posk@google.com>, paulmck <paulmck@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 10:37 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>

> >>
> >> This is an unpriv IPI the world. That's a big no-no.
> >
> > removed in v2.
>
> I don't think the feature must be removed, but its implementation needs adjustment.
>
> How about we simply piggy-back on the membarrier schemes we already have, and
> implement:
>
> membarrier_register_private_expedited(MEMBARRIER_FLAG_RSEQ)
> membarrier_private_expedited(MEMBARRIER_FLAG_RSEQ)
>
> All the logic is there to prevent sending IPIs to runqueues which are not running
> threads associated with the same mm. Considering that preemption does an rseq abort,
> running a thread belonging to a different mm should mean that this CPU is not
> currently executing an rseq critical section, or if it was, it has already been
> aborted, so it is quiescent.
>
> Then you'll probably want to change membarrier_private_expedited so it takes an
> extra "cpu" argument. If cpu=-1, iterate on all runqueues like we currently do.
> If cpu >= 0, only IPI that CPU if the thread currently running has the same mm.
>

Thanks, Mathieu! I'll prepare something based on your and Peter's feedback.

> Also, should this belong to the membarrier or the rseq system call ? It just
> looks like the membarrier happens to implement very similar things for barriers,
> but arguably this is really about rseq. I wonder if we should expose this through
> rseq instead, even if we end up using membarrier code.

Yes, this is more about rseq; on the other hand, the high-level API/behavior
looks closer to that membarrier, and a lot of code will be shared.

As you are the maintainer for both rseq and membarrier, this is for
you to decide, I guess... :)
