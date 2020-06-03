Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079B7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 16:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D30207DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 16:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591201164;
	bh=Il/dfMErTkgBJ//mL+aSFts5I77rJqeGGDX9gvP1YLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xq3Yv4Z+XmSgJqhkf24KEIPpzGbDZJyEabs0HLmMe8cC1XRafms1bYAshYUti4qkR
	 odjXKrb7yCclh3Y1sKoUNn8PHW1dLxHDIVZfXaFeiOHh95Fw28UYDw3w/wIlCdafQS
	 kjwcM8wbHm7ibrtBJq7nDfatfQ2CqOG7Azdk70is=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgFCQTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 12:19:24 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41582 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgFCQTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 12:19:23 -0400
Received: by mail-io1-f66.google.com with SMTP id o5so2887508iow.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 09:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rC5bE9KFvxDnJlcIiTlWdbXRmbn0P+2nI1r3gG1LMao=;
        b=KWtwKLq5k5yduwYU0+awVZBJ+eRqkZ8R6W23tXhMGaOE249AqVqS3VrYXxAobTuF2R
         On04wu3dN2WOoYn00MFXTfFJ1zYm60+ayjrIzBjlmAxC4+YZlC37pdo6tZ7OAJczFTCc
         w89bi0Ub8Fm3oXgRWrnFswkkdxgenf/fpPB0uYeKRDVykKWKgAiOV91WpiU7wJy0V1kk
         Q/I4pC0i3ORI5zCURJPWpIazXKZR/k2daiq3j2ZS9XsN7KSoegIFdte+RtGqeGakNQwl
         7Mr6ZzvdLGuGURcJ5GfRlwoe7wJkgnk686zWw1WznY/dOatIxZK+xyJXfpRiIIxI9Nle
         f6dA==
X-Gm-Message-State: AOAM531/kFxGxCsCizHcasQGy7J5MBij32vOW8ktW8CAxGkGKnyU45uX
        kET0FUrfqPF14FgFRc/PAA==
X-Google-Smtp-Source: ABdhPJxDBsDsagU3oxTW3qm0z17Idaq7Nb0AnTWkfF+zJ7waFaMp+/uD70MJ/TrnJ77YA1pde9s1WA==
X-Received: by 2002:a5d:8613:: with SMTP id f19mr438310iol.173.1591201162738;
        Wed, 03 Jun 2020 09:19:22 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id i78sm1248407ile.87.2020.06.03.09.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 09:19:22 -0700 (PDT)
Received: (nullmailer pid 1478226 invoked by uid 1000);
        Wed, 03 Jun 2020 16:19:19 -0000
Date:   Wed, 3 Jun 2020 10:19:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Raphael Gault <raphael.gault@arm.com>, mark.rutland@arm.com,
        raph.gault+kdev@gmail.com, peterz@infradead.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, acme@kernel.org, mingo@redhat.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/7] perf: arm64: Add test to check userspace access
 to hardware counters.
Message-ID: <20200603161919.GA1364927@bogus>
References: <20190822144220.27860-1-raphael.gault@arm.com>
 <20190822144220.27860-2-raphael.gault@arm.com>
 <20190827191755.00007a57@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827191755.00007a57@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 07:17:55PM +0800, Jonathan Cameron wrote:
> On Thu, 22 Aug 2019 15:42:14 +0100
> Raphael Gault <raphael.gault@arm.com> wrote:
> 
> > This test relies on the fact that the PMU registers are accessible
> > from userspace. It then uses the perf_event_mmap_page to retrieve
> > the counter index and access the underlying register.
> > 
> > This test uses sched_setaffinity(2) in order to run on all CPU and thus
> > check the behaviour of the PMU of all cpus in a big.LITTLE environment.
> > 
> > Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> 
> Hi Raphael,
> 
> I just tested this on 1620 and it works fairly nicely with one exception...

I'm working on reviving this series.

> The test will run and generate garbage numbers if the rest of the
> series isn't yet applied to the kernel.  Is there anything we can do
> to prevent that?

I've added a check that user access is enabled which should prevent 
that. It also validates pmc_width is set which was missing in this 
series.

> It's a slightly silly complaint, but this also take a while compared to all 
> the other tests if you have lots of cores, so maybe a slightly shorter
> test?

I'm not sure what the value of running on every core was supposed to be. 
If we want to check big.LITTLE, then the test should detect that and 
pass if user access is disabled on all cores. If we're not on 
big.LITTLE, then I don't see the point in this test running on every 
core.

Rob
