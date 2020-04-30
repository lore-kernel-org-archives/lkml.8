Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3B9C47253
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 282992070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JUYJmd1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgD3Qcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726545AbgD3Qcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:32:54 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFDBC08E859
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:32:54 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 19so84309oiy.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ZsclabnnR3wKrS78Exn79EM/lt2n7ZZyGteRGUsI8A=;
        b=JUYJmd1MBGqCas674WTA1IWfQlE/kGTREfBIK5mpDA0GKQCWA5TWrInT5xqa+cty1P
         1uf7jMp4ptZNe61WpozNUpn19cau+2xAsPJezxaJ/YkNvLq0Y4Ke8RMtVAAA6GGjYHiE
         gScspZIdHjRYqpJ2Uno+FQWJL/XiblVg/Mi22ewLmBd/WxxJ9smUOoHF9lr4DrqqMmAI
         C9OI28yxF+GzrKoTO+j1owgWEJOGkNwuwuNh8Zj6Tpvn/9KtPJiufeBqwE3ogh5pXqwf
         6/YLrVQoTxsZzAQIfZM8oI6/JkLwFFLp8PmBtms1w/jVWbOij59zxxdfJnRIZKaW6HD3
         p3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ZsclabnnR3wKrS78Exn79EM/lt2n7ZZyGteRGUsI8A=;
        b=f6SyxaCQiAYw+fGCawOgFlNQ7L1IRqib+7EwCfJmKuPWsDJLOqz8luzkqO9Rlnhq/x
         UwklexyCsaeHTyZeSaOXAgtc8zLcVFJc9/jNAbPzPJ7n/vChlMYHTJr1t7bTy3YIeT8A
         e4Lpe9jMCQkWle1iDalTd6U1Hqt6c8l036+ZSyBlAHzVIdlVIYQ/QcIiYSt2jMZ4vUFm
         C3u56aIOxVlKTwxYLw1wFnBGarAomHIgztrgoVdWWPhRaJ5aqwEFRPdEeFCESnkk6D5U
         pWPOjeeBiydxG+knqVu1DnziPihPkITDugw0kosnV/D0sy4vdvWgMq0uI5SrgKmU+TX+
         sJDg==
X-Gm-Message-State: AGi0PuYBHo9mc+uByRJlBuzd2GMDxEgBFDY/tU0Pofk/MaPWbaxh/WFw
        EiNANIyARjF7h47rQaBldBKL4phxWgTXHv078ZNOhA==
X-Google-Smtp-Source: APiQypJprzA/+arNVWPUX0khphDyRoZS8i1qOaFeSW8at+OIuNhknrJDu20eedqo9Mv1KETW0rnGhGJV0oxQ/gnyTBI=
X-Received: by 2002:aca:1c08:: with SMTP id c8mr36776oic.172.1588264373140;
 Thu, 30 Apr 2020 09:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-7-georgi.djakov@linaro.org> <CAGETcx9iAJRW9Y9orHNF-fC53nNob_vZKYUNEpwf_AeAdWCOjw@mail.gmail.com>
 <20200430060901.j7jjw6soo5h5xoul@vireshk-i7> <CAGETcx_zH_KJ7_A7Ofc2M5GfHKX_J__URJB127MSMcTeaqyzjw@mail.gmail.com>
 <20200430075356.rjtctfuenirvhxgn@vireshk-i7>
In-Reply-To: <20200430075356.rjtctfuenirvhxgn@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 30 Apr 2020 09:32:17 -0700
Message-ID: <CAGETcx-W5XjNtgjDz2Ma_miN=cUBb5LFfhzYtKRpf6iAi4bXNw@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] OPP: Update the bandwidth on OPP frequency changes
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 12:54 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 30-04-20, 00:35, Saravana Kannan wrote:
> > On Wed, Apr 29, 2020 at 11:09 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 24-04-20, 14:18, Saravana Kannan wrote:
> > > > My only comment is -- can we drop this patch please? I'd like to use
> > > > devfreq governors for voting on bandwidth and this will effectively
> > > > override whatever bandwidth decisions are made by the devfreq
> > > > governor.
> > >
> > > And why would that be better ? FWIW, that will have the same problem
> > > which cpufreq governors had since ages, i.e. they were not proactive
> > > and were always too late.
> > >
> > > The bw should get updated right with frequency, why shouldn't it ?
> >
> > I didn't say the bw would be voted based on just CPUfreq. It can also
> > be based on CPU busy time and other stats. Having said that, this is
> > not just about CPUfreq. Having the bw be force changed every time a
> > device has it's OPP is changed is very inflexible. Please don't do it.
>
> So, the vote based on the requirements of cpufreq driver should come
> directly from the cpufreq side itself, but no one stops the others
> layers to aggregate the requests and then act on them. This is how it
> is done for other frameworks like clk, regulator, genpd, etc.

You are missing the point. This is not about aggregation. This is
about OPP voting for bandwidth on a path when the vote can/should be
0.

I'll give another example. Say one of the interconnect paths needs to
be voted only when a particular use case is running. Say, the GPU
needs to vote for bandwidth to L3 only when it's running in cache
coherent mode. But it always needs to vote for bandwidth to DDR. With
the way it's written now, OPP is going to force vote a non-zero
bandwidth to L3 even when it can be zero. Wasting power for no good
reason.

Just let the drivers/device get the bandwidth values from OPP without
forcing them to vote for the bandwidth when they don't need to. Just
because they decide to use OPP to set their clock doesn't mean they
should lose to ability to control their bandwidth in a more
intelligent fashion.

-Saravana
