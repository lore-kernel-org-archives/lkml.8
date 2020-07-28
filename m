Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E393C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FBC920825
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m4iPL1Hs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbgG1PrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730856AbgG1PrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:47:11 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437EEC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:47:11 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id q75so13079591iod.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4I3KGAjBbuNkAipESKHCfBwEs4nmG6P6Y6y33YY/wo=;
        b=m4iPL1Hsr6xqsjirS8/aAGdmxyw+6w89EglZmlO3ZwO6OyD9Eg/OELmEMfzraXbNvt
         Yj40P69y7OTTC3BN+C51WePHzLYwflXQXpaEc8Jxl0dJMda2KcE+rQBi2gSTMqAA7Q0r
         wG9J2W5I+hQnFMSKs3+7BC/7rWNY6G6ZIn+GsEmAvRrFw/WOfTJq1BSgPbmUwF/mE5yW
         zSzohIqUciCcJP3K8rIuEbgDDOKHgCOYrMo82zawWe3Z5e3TguxpRkyzec+FFtWpNLKV
         nJOBjFal4nenWP/dXXDJ1NxCqt9Y4Zis5diksOu7dJbccKB6BfMMbqNifd0FX7SyRXKJ
         JCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4I3KGAjBbuNkAipESKHCfBwEs4nmG6P6Y6y33YY/wo=;
        b=kX3CjrHa/i0/33aB2UXgNCVicWI/1/iFCcpzjlyizbLb3zTGIT1Bb6ehElEUzd8YDd
         d6X7mwrwgCR/2uZUYjj0Tg6lmkS45Ryi9FhKL2dhRkb+U8f8jAi+KZCDAafhT6qcd+Mv
         9p7qvRj/f39oy9QMcK4piidC2wodncqqC1heskN/I+mtTAcBPfDvTquKCzMa42MhM3kQ
         v6CouxxCs2IXCej9eG2C6oziMvwM8ZPMGixJvChHYtBvmEcyo8zKzwqfYtfu6vvPoWPZ
         M3Nup4/kUiZpOknEAk8GRXv5txajQ7Qr7cLK4WHIGMJgtNTHlIcW8WDLLpi9CnAyV6L9
         fUQg==
X-Gm-Message-State: AOAM533LdLJP/JFOmbaZI6K6dO4Rx9EAvRK/gtoTCCRZIHtcjO3Zi+4y
        opHzi8NwG8ZK1hndzfqg7dgZlNdGE8Jy4r8kS9v33Q==
X-Google-Smtp-Source: ABdhPJz7NhjN8t2MDs3wGkLNp94GlWBCueV6aGaR5VGwit5oGEwRCxPxZG3OH8u425UEGkhCL5+uG1+Kx5hWGs9LvC8=
X-Received: by 2002:a05:6638:138a:: with SMTP id w10mr17170433jad.36.1595951230556;
 Tue, 28 Jul 2020 08:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200724071111.35593-1-liwei391@huawei.com> <20200724071111.35593-3-liwei391@huawei.com>
 <20200727203436.GC2381376@xps15> <20200728120220.GA40195@kernel.org>
In-Reply-To: <20200728120220.GA40195@kernel.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 28 Jul 2020 09:46:59 -0600
Message-ID: <CANLsYkyEYhVvG-z0+EXUSjgsQJ8EZtv7NbC1XRN_NGE8y5P2qQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf tools: ARM SPE code cleanup
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Wei Li <liwei391@huawei.com>, Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 at 06:02, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Mon, Jul 27, 2020 at 02:34:36PM -0600, Mathieu Poirier escreveu:
> > On Fri, Jul 24, 2020 at 03:11:11PM +0800, Wei Li wrote:
> > > - Firstly, the function auxtrace_record__init() will be invoked only
> > >   once, the variable "arm_spe_pmus" will not be used afterwards, thus
> > >   we don't need to check "arm_spe_pmus" is NULL or not;
> > > - Another reason is, even though SPE is micro-architecture dependent,
> > >   but so far it only supports "statistical-profiling-extension-v1" and
> > >   we have no chance to use multiple SPE's PMU events in Perf command.
> >
> > I find the above changelog somewhat out of touch with the patch itself.  The
> > only thing that is happening here is the removal of a useless check and a fix
> > for a memory leak.
>
> Humm, I think the original intent of that code was to cache the results
> of find_all_arm_spe_pmus(), as the variable it is assigned to is static.

Correct, but as you pointed out below the function is called only
once.  And there is still a leak as that memory is never freed.

>
> So not a leak, as there was that static reference to it to reuse it
> later, but that is strange in a function named "__init()" which usually
> is called only once, anyway, so I think that the paragraph with
> "Firstly" is kinda ok, but confusing, I think it should read:
>
> - auxtrace_record__init() is called only once, so there is no point in
>   using a static variable to cache the results of
>   find_all_arm_spe_pmus(), make it local and free the results after use.

This is exactly what this patch does and what the changelog should read.

>
> The second paragraph is SPE specific, so I'm not qualified to judge on
> it.
>
> I'm replacing the first paragraph with the version I wrote and keep it
> in my local branch, please holler if you think I misunderstood.
>

There is no point for the next paragraph, it has no relevance to what
the code is doing.

Thanks for the editing.

> - Arnaldo
>
> > Once again whether Arnaldo wants to make the changes by hand or not you may have
> > to resubmit.
> >
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >
> > >
> > > So remove the useless check code to make it clear.
> > >
> > > Signed-off-by: Wei Li <liwei391@huawei.com>
> > > ---
> > >  tools/perf/arch/arm/util/auxtrace.c | 9 ++++-----
> > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> > > index 28a5d0c18b1d..b187bddbd01a 100644
> > > --- a/tools/perf/arch/arm/util/auxtrace.c
> > > +++ b/tools/perf/arch/arm/util/auxtrace.c
> > > @@ -57,17 +57,15 @@ struct auxtrace_record
> > >     struct evsel *evsel;
> > >     bool found_etm = false;
> > >     struct perf_pmu *found_spe = NULL;
> > > -   static struct perf_pmu **arm_spe_pmus = NULL;
> > > -   static int nr_spes = 0;
> > > +   struct perf_pmu **arm_spe_pmus = NULL;
> > > +   int nr_spes = 0;
> > >     int i = 0;
> > >
> > >     if (!evlist)
> > >             return NULL;
> > >
> > >     cs_etm_pmu = perf_pmu__find(CORESIGHT_ETM_PMU_NAME);
> > > -
> > > -   if (!arm_spe_pmus)
> > > -           arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
> > > +   arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
> > >
> > >     evlist__for_each_entry(evlist, evsel) {
> > >             if (cs_etm_pmu &&
> > > @@ -84,6 +82,7 @@ struct auxtrace_record
> > >                     }
> > >             }
> > >     }
> > > +   free(arm_spe_pmus);
> > >
> > >     if (found_etm && found_spe) {
> > >             pr_err("Concurrent ARM Coresight ETM and SPE operation not currently supported\n");
> > > --
> > > 2.17.1
> > >
>
> --
>
> - Arnaldo
