Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95939C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BFA320775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xl8bCjfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgFZEPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 00:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbgFZEPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:15:22 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0560FC08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 21:15:21 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l12so7999558ejn.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 21:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5dyXISEFPO4zN8NJzbUQLcaTnJQH628lZUaCtOB5NIs=;
        b=Xl8bCjfJJjilv9lKWhwjcP/+CuLRgyomgZeuj1L9+0F71WtVlIZsKDDYLnnfAIarMr
         q3sw2+60tHQzQSf6tqxEsyV/Pd/bOkOw1SRi2uXmDjiYwz4o4Nf7CqCbjd/WD+r2KRSH
         u0O6wDAKMG/bDNOxopybeMC7eSoFxhfAFLV9Vv7KadH/iYG9jVWjEd/CX/9CIGGMbMqq
         y52eXj8jaAZ18IH4ffNzHyelT3PwwJwKqLRWMtuw2OJ2c9SE6CoFAUDJDkL13xz8C2wD
         I5RKKBwaeedhmeg43keuqZQDlnA6T+aoLzjWeVwlTQ9tcPw7qRfltesEVVvB6LhoBYz6
         TA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5dyXISEFPO4zN8NJzbUQLcaTnJQH628lZUaCtOB5NIs=;
        b=PUhvfXa0+ByVVacYhlU6+B01UiGJqEX9RVq0UZgVCTzZ6WBnasrPLJ+Hgb+M0ihUak
         kcr7U++RB1H26Iw6dRavoASpRbU2a1RUFTCOSPAuqmphcmHHzk3sywhZv/jxuHRFb1Wm
         FLQuWqtaOKg4+HHvRyPI77ZdZxWv8Dnll1AxqxaQm/4llIsZXCScwV8Ca7oMiiOxp87L
         D8YhVXTE6llye4HzuCzEiiNPyTTAfK4iV2ItU42hNHYTy1MB40ZvoS00KMRQp4kTwDIR
         e1sBoUjjXBI6mYR+POeOoPMZM4MsiUuP2H2C/TFJFlqF509UkAH+Bd+jGb2pIbmMbYsS
         Zb7w==
X-Gm-Message-State: AOAM5318ni4VkRUgI0Qt63GwLAUymgyhYsLARtAJ7g6C1lTMfq2Vahy5
        by6sb4TQs8oVdpUtuXfv8Dz9B4xpmoVhsj2EaLKGAA==
X-Google-Smtp-Source: ABdhPJw0Us/srclnotYnN/IE0ZDFwhVMn6cHekEEslbon23FeASyGg8wDxOW25Da/DrocSRcVJ/O1k6YKAzCIz5PbXM=
X-Received: by 2002:a17:906:d204:: with SMTP id w4mr898177ejz.117.1593144920242;
 Thu, 25 Jun 2020 21:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200625064614.101183-1-wvw@google.com> <20200625102305.gu3xo4ovcqyd35vd@vireshk-i7>
 <CAGXk5yrA=oXZs9KAaELsO7+ex7xCggEwdWSC_KXrUWQnvKEpWQ@mail.gmail.com>
 <20200626021428.tnecyy3wt42slvik@vireshk-i7> <20200626023219.wvhzomwzlw24bzrv@vireshk-i7>
In-Reply-To: <20200626023219.wvhzomwzlw24bzrv@vireshk-i7>
From:   Wei Wang <wvw@google.com>
Date:   Thu, 25 Jun 2020 21:15:09 -0700
Message-ID: <CAGXk5yqsj+YTv3=Dj-NZY=sBb=g9DUfVmxcO-CeE3jjipA9Osw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: force frequency update when limits change
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Wei Wang <wei.vince.wang@gmail.com>, dsmythies@telus.net,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 7:32 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 26-06-20, 07:44, Viresh Kumar wrote:
> > On 25-06-20, 13:47, Wei Wang wrote:
> > > On Thu, Jun 25, 2020 at 3:23 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > I am sorry but I am not fully sure of what the problem is. Can you
> > > > describe that by giving an example with some random frequency, and
> > > > tell the expected and actual behavior ?
> > > >
> > > The problem is sugov thought next_freq already updated (but actually
> > > skipped by the rate limit thing) and all following updates will be
> > > skipped.
>
> The rate-limiting thing is specific to android and not present in
> mainline. Even in android I see next_freq getting updated only after
> rate-limiting is verified.
>
> I think you maybe trying to fix an android only problem in mainline,
> which may not be required at all. And I am not sure if Android has a
> problem as well :)
>
Yes, that is Android specific, I added you to the Gerrit already.

Thanks!
-Wei

> > I am sorry, can you please give a detailed example with existing
> > frequency and limits, then the limits changed to new values, then what
> > exactly happens ?
> >
> > > Actually this is specifically for Android common kernel 4.19's issue
> > > which has sugov_up_down_rate_limit in sugov_update_next_freq, let's
> > > continue discussion there.
> >
> > If it is a mainline problem, we will surely get it fixed here. Just
> > that I am not able to understand the problem yet. Sorry about that.
>
> --
> viresh
