Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E82C83002
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16CDE21973
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SicuVYS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgD3Hfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgD3Hfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:35:50 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD478C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:35:49 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id r66so4431238oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qs31g31s4Qup1BiKCc2DuRtqM2XedKFVg5N5v+BZjjw=;
        b=SicuVYS5fp0fa/wzv+q09rX6oQxgNmClx4f49iFcA5bDwQqCogfhamiVVpkdy0QlsF
         ae2KdpL6Mq+vPjWq/ZPYZD0ac60feHz/OOkbVGO55xwzQgCIGJ5rzD7n4sYr5kl4TlEp
         wH2/j7ymvRCJMxLbnipbZWJ8zIBG/Tv/jUppjIaLk03n1xDbd1/77ztyxWdT7eKEPCjx
         dQp1Sgf9DZdRh8mwUC9Bgk3OPPMmpMqiuy6smhEU/FwS1srovO5NAs/NFGak/WaGLQ4a
         envkNnbxsbFhwALdCNKh73IEILCjujXDrRdFoWIqfr0vWIhEddXSJ1Wzw2YR0cO3KLMw
         B0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qs31g31s4Qup1BiKCc2DuRtqM2XedKFVg5N5v+BZjjw=;
        b=rLCD0KVxX4DKrJjmJBuKABgIW5A+xm5E13MI46+nD4KldUEa/xayLiBKmNwNlnQ7kb
         bXSzUy7+7kBn9etvUkCWPqPT56gfuyKB6VDUc8v0Q4NkH1EtPoz4sk7PP9fcCVGDylsr
         fCFQMObmGpQryIHoqraxfdGitMLcLKTytUAGvkU2G02P9eyR89aWwBNsAzQdKhnj2Ynq
         VH4PKxAgZ+E1RksCk7Y5FvGlYCBgJ/X7cI7hjz4INI4mgHMqxA0ItjEJVW66A4QQKUnM
         +97x/xeVZIDmCXwyRczcfZdBvYoZt4HGYVPhjq8npoAN795FvSc1r5ul0efIWtnlOZOH
         0eTQ==
X-Gm-Message-State: AGi0Puav+4Z0QDe6g6e84cHs40BwEkrP27lirU+865z3pj5Yozk7XsJq
        vpV9OpyTjLjP3yho6NOF1+nS28ciP0zF3Y5kQ5q9nQ==
X-Google-Smtp-Source: APiQypJSVbEeLdKvSzeK+HnDLd495hRaTsKPEMdbd300IaB2PC5hErDtAPw/RD9fpBoG5vAHd3mduLUJ3j8aWN9Hbk4=
X-Received: by 2002:aca:1c08:: with SMTP id c8mr827526oic.172.1588232148850;
 Thu, 30 Apr 2020 00:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-7-georgi.djakov@linaro.org> <CAGETcx9iAJRW9Y9orHNF-fC53nNob_vZKYUNEpwf_AeAdWCOjw@mail.gmail.com>
 <20200430060901.j7jjw6soo5h5xoul@vireshk-i7>
In-Reply-To: <20200430060901.j7jjw6soo5h5xoul@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 30 Apr 2020 00:35:12 -0700
Message-ID: <CAGETcx_zH_KJ7_A7Ofc2M5GfHKX_J__URJB127MSMcTeaqyzjw@mail.gmail.com>
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

On Wed, Apr 29, 2020 at 11:09 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 24-04-20, 14:18, Saravana Kannan wrote:
> > My only comment is -- can we drop this patch please? I'd like to use
> > devfreq governors for voting on bandwidth and this will effectively
> > override whatever bandwidth decisions are made by the devfreq
> > governor.
>
> And why would that be better ? FWIW, that will have the same problem
> which cpufreq governors had since ages, i.e. they were not proactive
> and were always too late.
>
> The bw should get updated right with frequency, why shouldn't it ?

I didn't say the bw would be voted based on just CPUfreq. It can also
be based on CPU busy time and other stats. Having said that, this is
not just about CPUfreq. Having the bw be force changed every time a
device has it's OPP is changed is very inflexible. Please don't do it.

-Saravana
