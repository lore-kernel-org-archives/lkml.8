Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A77C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A79FD2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596090761;
	bh=gmLQHj64FkaGgheaXBUyCURKlTKz98iDmLTqsyXvdvc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BGz58uOENiTLflTkKLiTUVcMYgNGK42sLJLhCIARRpNrjGkvnY1rtZcFXEf4hkAVY
	 bC4g/budZcNmEZ32amSZ0su2bioX8jXRKu4u4McneJmzgRzsAXc2UFj4VJeNcwJDDP
	 xcWmxMdBHPLT1DBNftbogf3wr68mUaynnbyvVyro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgG3Gck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 02:32:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbgG3Gck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:32:40 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74C162083B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 06:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596090759;
        bh=gmLQHj64FkaGgheaXBUyCURKlTKz98iDmLTqsyXvdvc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pcyKjnxAp1lbX4V/QXWlO9nvvxyG7yNXfzIaTpM5q0sMdTBU9YoCVR+1QVfk1YpxB
         c6nmJpqRkwZOhqrLEj1dD1UnjWbmLaD7KBJ6rMCy8Xu2gMjintotMoT+opqoB4XCz+
         AM2TMwQTd+nncHMa6MlTVcpaA2nM73mjmT14MBAg=
Received: by mail-ua1-f51.google.com with SMTP id x19so2245696uap.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 23:32:39 -0700 (PDT)
X-Gm-Message-State: AOAM5326IMAazmbGVpVPc9VPxOlMu41BooNYudwg1dBTSKFGKLo7Z9YK
        zRusRtc7TaVRA+Nk+1MXSbL3sBnaEDexZuV9HchExQ==
X-Google-Smtp-Source: ABdhPJyAQSKQ9sVCMoAtAugFkA9JAJrq57BPhGMjf0IJnH0c7syklskqTMGNqUyzVuXc04jhyb5yGnoo2ea3s/tHzYA=
X-Received: by 2002:a9f:2742:: with SMTP id a60mr1017353uaa.48.1596090758571;
 Wed, 29 Jul 2020 23:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <d48d824ab3abacb2356878780979d7ed42191eaf.1596080365.git.viresh.kumar@linaro.org>
 <CAHLCerP4YPHc4sKD_RTq=Gxfj+ex4F=J2is1Y-UzGXcOuEOrOQ@mail.gmail.com> <20200730061041.gyprgwfkzfb64t3m@vireshk-mac-ubuntu>
In-Reply-To: <20200730061041.gyprgwfkzfb64t3m@vireshk-mac-ubuntu>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Thu, 30 Jul 2020 12:02:27 +0530
X-Gmail-Original-Message-ID: <CAHLCerMD_spZFHER-y9dOzr7qo9xKXZdqy3cFt+W9QUW4Ng3jw@mail.gmail.com>
Message-ID: <CAHLCerMD_spZFHER-y9dOzr7qo9xKXZdqy3cFt+W9QUW4Ng3jw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: cached_resolved_idx can not be negative
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        ionela.voinescu@arm.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 11:40 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 30-07-20, 11:29, Amit Kucheria wrote:
> > On Thu, Jul 30, 2020 at 9:38 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > It is not possible for cached_resolved_idx to be invalid here as the
> > > cpufreq core always sets index to a positive value.
> > >
> > > Change its type to unsigned int and fix qcom usage a bit.
> >
> > Shouldn't you fix up idx in cpufreq_driver_resolve_freq() to be
> > unsigned int too?
>
> Yes, merged this into the patch.

Looking at this more closely, I found another call site for
cpufreq_frequency_table_target() in cpufreq.c that needs the index to
be unsigned int.

But then cpufreq_frequency_table_target() returns -EINVAL, so we
should be able to handle int values.

I think you will need to fix the unconditional assignment of
    policy->cached_resolved_idx = idx
in cpufreq_driver_resolve_freq(). It doesn't check for -EINVAL, so the
qcom driver is write in checking for a negative value.

>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0128de3603df..053d72e52a31 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -538,7 +538,7 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
>         policy->cached_target_freq = target_freq;
>
>         if (cpufreq_driver->target_index) {
> -               int idx;
> +               unsigned int idx;
>
>                 idx = cpufreq_frequency_table_target(policy, target_freq,
>                                                      CPUFREQ_RELATION_L);
>
> --
> viresh
