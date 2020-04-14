Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6367AC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C6D820678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJwBplRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440831AbgDNPnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440812AbgDNPnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:43:47 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5509C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 08:43:46 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y4so271282ljn.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 08:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HX5KTGsae8v7drEiGKng7b+OXMi1rCkdRouOYjUbZIk=;
        b=MJwBplRIjpLs45jKUc+59I60QA8e7sPiLQYPfYXBhzkW3JFAYf9GwG1EIzUx7IgBxv
         oA1MrdFyz6kgKX40Ivj+rbSQIbi7pCaRQqNGhw7OP90F70vOGvPxoJnWACzewhxci0sH
         UAA35+vjvakxCZ+Iv1ZiDO/Ri3RtlzR361nG+NEdJqVbTvH9xAP7QZNW06InQNyUth/n
         yTgNImHxnUiwmj2QCm+wuXEpllIEsQXkZB1HVEL9EpMELDG299iX0tAEeW2+ZVw8Nj3c
         mJF3GD1pCt0bodvRJS5tLFBxZCtWZtFLhcw+UhrElzhssMHl2vNAujjflAHKyeQ4CNJN
         twhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HX5KTGsae8v7drEiGKng7b+OXMi1rCkdRouOYjUbZIk=;
        b=gIbrjLUrah5f9KCnggUdfYgbRwfoNL9awSWaVWF92tC4BAKpTd1sOxWcJViclWvAUv
         TLxv6sFSoi8LuR3tJJHGDo6cqnr98jcVtj0fLhLSKZxYwMUfA6/YJdHG56cZwTt4ifmk
         9qHv/qvli2gd2lYnAkWsZWhaequ+fgNcb3rK+S+xCGkJ+oALpJhltFicj9tXe6Pcf+MM
         T2zwHXGLDXtVd7llaKYOHJq5ox6OCvsR/r2EIFeV79QCNdRQq7U4OOsl4iPL3H/qyboS
         eSUOCVNG/50NvX+gDchHytqnskb84/hiJQS1Ua0Z+CYB42viu9i6zRpZJYTD+LMBcrj6
         yVEw==
X-Gm-Message-State: AGi0PuZM39bdroaeyfSh8zXgAYq+cQlHaCoTN+8Oqe8Cu2YD/tHh41uP
        XlpXb2htUvH/Ky8c3UOMZtytfHuoOgHfB+Grtt3Fwg==
X-Google-Smtp-Source: APiQypJPgNZd/t3T4ywpsLPDkTvA9ixBNHedqH3qbGClUTEbosU5WuNiRdb0JGAZAzKRn5b0BP/8o1a2cKoivyfNFIo=
X-Received: by 2002:a2e:800a:: with SMTP id j10mr473793ljg.65.1586879025108;
 Tue, 14 Apr 2020 08:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
 <20200408095012.3819-2-dietmar.eggemann@arm.com> <CAKfTPtC4_+dTddLdoFMdzUvsXwWyi3bUOXcg9kstC8RzZS_a+A@mail.gmail.com>
 <42cc3878-4c57-96ba-3ebd-1b4d4ef87fae@arm.com> <CAKfTPtDS_qwPH+TwoFWPz6QRzG1N=t46ZvGN=w6zbOtnGAdOeQ@mail.gmail.com>
 <20200414124503.GA236568@google.com> <7adf893b-769d-ffa4-71da-d9a93646a88c@arm.com>
In-Reply-To: <7adf893b-769d-ffa4-71da-d9a93646a88c@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 14 Apr 2020 17:43:33 +0200
Message-ID: <CAKfTPtAG8SsraBhuhBT0=aw7PpL+TEZw2qyeo=+ogRP+7+MhdA@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched/topology: Store root domain CPU capacity sum
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Quentin Perret <qperret@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 at 17:27, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 14.04.20 14:45, Quentin Perret wrote:
> > On Wednesday 08 Apr 2020 at 19:03:57 (+0200), Vincent Guittot wrote:
> >> Or we can do the opposite and only use capacity_orig_of()/rq->cpu_capacity_orig.
> >>
> >> Is there a case where the max cpu capacity changes over time ? So I
> >> would prefer to use cpu_capacity_orig which is a field of scheduler
> >> instead of always calling an external arch specific function
> >
> > Note however that using arch_scale_cpu_capacity() would be more
> > efficient, especially on non-arm/arm64 systems where it is a
> > compile-time constant.
>
> or essentially all ARCHs not defining it.
>
> >
> > It's probably a matter of personal taste, but I find rq->cpu_capacity_orig
> > superfluous. It wastes space without actually giving you anything no?
> > Anybody remembers why it was introduced in the first place?
>
> v3.18 arm providing arch_scale_cpu_capacity()
> v4.1  introduction of rq->cpu_capacity_orig
> v4.10 arm64 providing arch_scale_cpu_capacity()
> ...
>
> So it's down to the question of 'minimizing the scheduler calls to an
> external arch function' vs 'efficiency'.

Using cpu_capacity_orig will provide more consistency because it will
be set while setting the sched_domain topology
