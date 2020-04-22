Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5DEC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F69920661
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ErwwRD2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgDVPx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgDVPx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:53:26 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEEDC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:53:26 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id g6so1407456ybh.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pa5cjUIbb+70qrmhvDatRF7s+1dOLh+sqWJNtlKJ0cY=;
        b=ErwwRD2zEOano4HxaluFQRh3bPHOvL35gRCw+teqYsNajnQ7pG52r6Kfi8r01aLJKP
         NHY3POcF3Mp3o3fjydIuV8V4bUNYRN11GmZEgi2qec8uwMSNQ8nqRs5PnzxBU9rNfKSU
         UIcrsL/cxa5E1GtaruOgJmLtNANwb5PB7p1vVEf1rb2uDUetF/kvTaRLzz7Em32kdB6z
         Pdu29SfD4W2gsj8MyIkcuiZahXhxHsbZ6tSvSxOaaNR/Q1ma9vIiJaqR0EsfRCYFbMKD
         f41tlq2GyDFBCYSNGRZOM5rOVNr5YEnpkd7rFfJfFFqvmRK7F9SZrqRB6XGW2qS4Qp+K
         CsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pa5cjUIbb+70qrmhvDatRF7s+1dOLh+sqWJNtlKJ0cY=;
        b=pcuHKFOAC4Vy3DPkQ6135HPXeapr76rId4RFxpat2rx6zWNAagWvYaU7wH0sQyGhpw
         lNmqXu3TerDlYrF+Tz9hNOj/EG+oUj7sJCYrm9fdURpNjL7Bo07Quw8SST7Gbsztgp7V
         hdLedoxZiNtlErN4yHdYOKcCVFYajuBABH1dPmHVo7dxjGwh/cNxTs33UwV3+gefmUIl
         A8dzz4HTN3jEc2qQCO32o343AD35gDHLsYTIsL363Oz+8wmK3XVXPDhst9zwphKxoEVY
         jMXYcfqRdcVxMz8I3X0I4IM2v+Mop3gOR81o6YsH4al/dH+VDQkA/oRSNW6+RS235tyZ
         ZVoA==
X-Gm-Message-State: AGi0Pua0JfcEO7fMWBmYQeAf8oL5SrmesA43RfgHQxGeFjMmcf0oOUHj
        sHCnNjo42y2MbxZBWsmTSZKCbjsfgsxAINkWtxZXaA==
X-Google-Smtp-Source: APiQypKuciYEhGGm/P3VxxRyWesSBzUvthVc1e5NP4FUesla2ptEsxWwWlwNTpdewwBsDH1wSty4/bzNZFpiUGTpfRI=
X-Received: by 2002:a25:3d86:: with SMTP id k128mr10310578yba.403.1587570805779;
 Wed, 22 Apr 2020 08:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200416001303.96841-1-irogers@google.com> <20200420075919.GA718574@krava>
 <CAP-5=fUsdWOG6Xw_mcTA-HOg81GQxWe56h6dBZ2m7fygVN3W6w@mail.gmail.com> <20200422081448.GD962614@krava>
In-Reply-To: <20200422081448.GD962614@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 22 Apr 2020 08:53:14 -0700
Message-ID: <CAP-5=fUhnn=Shmea6KFeHFjApzZv8VO841=9vkO_f=t7UP7wZA@mail.gmail.com>
Subject: Re: [PATCH] perf/record: add num-synthesize-threads option
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Tony Jones <tonyj@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 1:15 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Apr 20, 2020 at 05:31:41PM -0700, Ian Rogers wrote:
>
> SNIP
>
> > > > +{
> > > > +     static pthread_mutex_t synth_lock = PTHREAD_MUTEX_INITIALIZER;
> > > > +     int ret;
> > > > +
> > > > +     pthread_mutex_lock(&synth_lock);
> > > > +     ret = process_synthesized_event(tool, event, sample, machine);
> > > > +     pthread_mutex_unlock(&synth_lock);
> > >
> > > hum, so how much faster is the synthesizing with threads in record,
> > > given that we serialize it on every event that goes to the file?
> >
> > We see long synthesis times of the order seconds on loaded >100 core
> > servers. I've not been able to create a reproduction on my desktop.
> > You are right that making synthesis multithreaded will suffer from
> > Amdahl's law if the write is a synchronization point. Measuring with
> > the following patch in place:
> > https://lore.kernel.org/lkml/20200415054050.31645-4-irogers@google.com/
> > without threads the portion that needs a lock is less than 1.5% of
> > execution time and so there's plenty to still run in parallel:
> > ...
> >       - 32.59% __perf_event__synthesize_threads
> >          - 32.54% __event__synthesize_thread
> >             + 22.13% perf_event__synthesize_mmap_events
> >             + 6.68% perf_event__get_comm_ids.constprop.0
> >             + 1.49% process_synthesized_event
> >             + 1.29% __GI___readdir64
> >             + 0.60% __opendir
> > ...
> >
> > The multi-threaded benchmark in this patch (pass -t):
> > https://lore.kernel.org/lkml/20200415054050.31645-2-irogers@google.com/
> > shows:
> >
> > Computing performance of multi threaded perf event synthesis by
> > synthesizing events on CPU 0:
> >  Number of synthesis threads: 1
> >    Average synthesis took: 127729.000 usec (+- 3372.880 usec)
> >    Average num. events: 21548.600 (+- 0.306)
> >    Average time per event 5.927 usec
> >  Number of synthesis threads: 2
> >    Average synthesis took: 88863.500 usec (+- 385.168 usec)
> >    Average num. events: 21552.800 (+- 0.327)
> >    Average time per event 4.123 usec
> >  Number of synthesis threads: 3
> >    Average synthesis took: 83257.400 usec (+- 348.617 usec)
> >    Average num. events: 21553.200 (+- 0.327)
> >    Average time per event 3.863 usec
> >  Number of synthesis threads: 4
> >    Average synthesis took: 75093.000 usec (+- 422.978 usec)
> >    Average num. events: 21554.200 (+- 0.200)
> >    Average time per event 3.484 usec
> >  Number of synthesis threads: 5
> >    Average synthesis took: 64896.600 usec (+- 353.348 usec)
> >    Average num. events: 21558.000 (+- 0.000)
> >    Average time per event 3.010 usec
> >  Number of synthesis threads: 6
> >    Average synthesis took: 59210.200 usec (+- 342.890 usec)
> >    Average num. events: 21560.000 (+- 0.000)
> >    Average time per event 2.746 usec
> >  Number of synthesis threads: 7
> >    Average synthesis took: 54093.900 usec (+- 306.247 usec)
> >    Average num. events: 21562.000 (+- 0.000)
> >    Average time per event 2.509 usec
> >  Number of synthesis threads: 8
> >    Average synthesis took: 48938.700 usec (+- 341.732 usec)
> >    Average num. events: 21564.000 (+- 0.000)
> >    Average time per event 2.269 usec
> >
> > The event logic there is using an atomic rather than a lock and the
> > scaling isn't linear as not all the logic is threaded. Still with 8
> > threads we see things going about 2.6 times faster. On a large loaded
> > machine that may bring 10 seconds of event synthesis down to less than
> > 4. On a desktop there's no measurable difference and the
> > --num-thread-synthesize is defaulted to 1.
>
> ok, nice ;) sorry I did not get to this before you posted v2,
> but could you plz send v3 with above in the changelog?

Done.
https://lore.kernel.org/lkml/20200422155038.9380-1-irogers@google.com/T/#u
Not done initially as I wasn't sure the argument was coherent and also
the other two patches haven't landed - it would be nice to avoid
linking to the patches on the mailing list.

Thanks,
Ian

> thanks,
> jirka
>
