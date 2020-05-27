Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E70C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AABB207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3/U9PZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgE0MH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 08:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387608AbgE0MHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:07:43 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4751C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 05:07:42 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z13so18914858ljn.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 05:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eIUXbCZBGd6FQiRTZakvB9gdQEN6hpoj1XakMh1KrtU=;
        b=o3/U9PZBTXf7Ndeovd+y7YJ8bpDhjfqHs+oriS9SzlGXz9mU5FYpSQikl3BqXmfaZC
         CEAlmT+trRrGlRyxZVy8Jkk1pnh0QbrG3CRsDxUISSmkxFvYvECM65DbvkKZsl6R2k4E
         0rbyTLLbaRByqwZLb3VKFQNiRqBccYSirfF0+0iZPqdVAo0mLbwY/64BSc9KkcKIWu2M
         l4fBraDJ0LaNCn9XF+OBro+u2ihZUvkYX79J9Nzzd21cTnWtRNghAmvUKG2pfy5vstAW
         M1iqKSHrEPtFD8PBsl71PaCqd8TtDvGl4tyXpfzF0QVx3/pw2LUsN5VyzxSzQzxqAh9B
         W/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIUXbCZBGd6FQiRTZakvB9gdQEN6hpoj1XakMh1KrtU=;
        b=MeD7ZkTdIefeZQRDBYfNr1RgJ1YnoWZZ+Qsqx/EERldlH21razczjSy0RH3dEIP8WF
         +TywKpSUGnFolDS3nkkPef+ob/9T5YTCFzLZcAOX5nenSU51TvQnktat00xi8TBV49D5
         c3n9HjPxS9C/caTZfJohqK9021xIZaet+vvYdOWDuo+mgqgpgpfvZjKF6P+KFvxGMZkL
         UnndzsQC08SgFrSoThAsRBEtdH2MH7LyldTmGVhfkWMB6fxYhlE+KUNoEbBNl9N8aQ2k
         QHjuJaDU+Cpx4o94rgsn5RZJEnB2EwxUe7kXAAfh2rt8NYmF0fz7zFQnjFMLFqBQV7F0
         iknA==
X-Gm-Message-State: AOAM5308iRxvZDv9wFpzvFhImN+b9TUBLIpY6SjORDsoADS6l6c4SRXq
        Bp9YquSENc5ivfG8Yrdww3+P35qq2Cv13BZ1hYuveg==
X-Google-Smtp-Source: ABdhPJzNzwrVnGNk2QziUrVShAg8LwxDtlUGdC0n+beWmTLFE/5KTWxCVQRO1Yvbll8wnAFqWhOJy2sUhV804ZzRVbE=
X-Received: by 2002:a2e:9510:: with SMTP id f16mr3147832ljh.111.1590581261349;
 Wed, 27 May 2020 05:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200526161057.531933155@infradead.org> <20200526161907.778543557@infradead.org>
 <CAKfTPtA6t5=Gc6cWR3iS9QL+Vy=jhUkP345V9q2xqyhHx=rGNQ@mail.gmail.com> <20200527112815.GB8942@lenoir>
In-Reply-To: <20200527112815.GB8942@lenoir>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 27 May 2020 14:07:28 +0200
Message-ID: <CAKfTPtDHSLHCHsDRMzxPcKzcc=T1g_HZRxgHyAuPQcPN9QYMfA@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/7] sched: Fix smp_call_function_single_async()
 usage for ILB
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 at 13:28, Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Wed, May 27, 2020 at 12:23:23PM +0200, Vincent Guittot wrote:
> > > -static void nohz_csd_func(void *info)
> > > -{
> > > -       struct rq *rq = info;
> > > +       flags = atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(cpu));
> >
> > Why can't this be done in nohz_idle_balance() instead ?
> >
> > you are not using flags in nohz_csd_func() and SCHED_SOFTIRQ which
> > calls nohz_idle_balance(), happens after nohz_csd_func(), isn't it ?
> >
> > In this case, you don't have to use the intermediate variable
> > this_rq->nohz_idle_balance
>
> That's in fact to fix the original issue. The softirq was clearing
> the nohz_flags but the softirq could be issued from two sources:
> the tick and the IPI. And the tick source softirq could then clear
> the flags set from the IPI sender before the IPI itself, resulting
> in races such as described there: https://lore.kernel.org/lkml/20200521004035.GA15455@lenoir/

ah yes, even if the cpu is idle, the tick can fire and clear it.

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> Thanks.
