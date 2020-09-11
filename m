Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057ADC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 02:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6CE520732
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 02:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599791749;
	bh=eRaV9PXVgSWg936D+HlBMHyeKxSOUrK95mA8lTzRySI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0bW95liDP/mHxjMpNDb6DJmc140n7nI2ru3Z3laLd5pZXHGfDCaRxcCfw6st91aLb
	 Q223g96JCu4SUhFrpK/XlnkEUSQ+WMGXV46/4xBk9jz8VtaGDSTnxTqHJUqTlkS+t+
	 LEsmFSZV+5mQW+Ppdc/QZwnjMs+D+rismV43fpLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgIKCfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 22:35:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40358 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIKCfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 22:35:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id j2so9890228wrx.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 19:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NP+TiSCjTbVjad+6yJemOyFTfTJE1uB03ssAuxqrXIQ=;
        b=G+JRqgXZjY45tUu9anOy5pNx28TEtd8YyDwEAbY56psg/jPDQ37uIig+fncgdzTbRh
         6nBRDE1h8LpQA70inOiPthxJ0p85EYIHRt4U7ulYsT8tlcHrZSLiuXDdMUbclzmX3aih
         34Bd8aEP+0NBYxhAdKcA+QErTv+g1WfRjcvGGZQpW4MZYc1H0IjI7dKCcXAiCrlgKp5t
         iYum1A3JD7aXd2Ltkg/56b5t3wExJSB/4X+q4hOcBjlb9nIbkiO2iLmPd/pezqq4MVPu
         k31DGm0Y/v3PygR2TgaSElNDle4dbHywSkGI708nSI7ddB6H/55SKb/5Zy/N/VHK/WkL
         0B+A==
X-Gm-Message-State: AOAM531eiIKMOcICTyWlzTTga4psof8zH6isXatBz4tuBP9iAx/jJR0k
        9/MP5WnACmf7c8s9pSwYyfAM/ELLf1bHMkSHfKE=
X-Google-Smtp-Source: ABdhPJzzDAfmS0JO3hzrXDI6+NSyzSTjd1jQCmvgP+imy6UUPa/ldAa019RwQOw7tgmRkLETBGJrdWJzq39x2w6sFTg=
X-Received: by 2002:adf:a3c9:: with SMTP id m9mr12039318wrb.80.1599791741741;
 Thu, 10 Sep 2020 19:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200908044228.61197-1-namhyung@kernel.org> <20200910155736.jadhmqvnqquammpn@two.firstfloor.org>
In-Reply-To: <20200910155736.jadhmqvnqquammpn@two.firstfloor.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 11 Sep 2020 11:35:30 +0900
Message-ID: <CAM9d7cjv3nXACmNLGW2kmgwvcWUJJnkaunQamB=J0GoUzwvYfg@mail.gmail.com>
Subject: Re: [PATCHSET 0/4] perf stat: Add --multiply-cgroup option
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Fri, Sep 11, 2020 at 1:05 AM Andi Kleen <andi@firstfloor.org> wrote:
>
> On Tue, Sep 08, 2020 at 01:42:24PM +0900, Namhyung Kim wrote:
> > When we profile cgroup events with perf stat, it's very annoying to
> > specify events and cgroups on the command line as it requires the
> > mapping between events and cgroups.  (Note that perf record can use
> > cgroup sampling but it's not usable for perf stat).
>
> The problem is real, but I don't really like your solution.
> The option is ugly. Should rather be solved with some suitable
> syntax in the expression parser to express: apply to all,
> instead of adding adhoc options like this.

Yeah, I'd admit that I'm terrible at naming. :)
I'm open to any suggestions as I'm also bad at making new syntax..

But as Ian said, my approach takes care of the common case
without dealing with controversial syntax changes.

>
> There are some additional problems that really need to be eventually
> solved too:
>
> - If you use the old syntax and some cgroups are not covered you don't
> get any warning. At least that should be fixed too.

I don't follow.  Do you mean like when -G option and --multiply-cgroup option
is used at the same time?  Or when -G option doesn't match to -e option?

>
> - And of course if everything works it is still very slow for the kernel
> because there are so many perf events to handle. Long term we probably
> need some more flexible way to just specify for given perf events which set of
> cgroups they should apply, so that sharing and low overhead monitoring
> of many cgroups is possible I hate to say it, but maybe some eBPF filter
> is the solution here.

Yes, I'm also interested in improving that too.

Thanks
Namhyung
