Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDD4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5089E20759
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2m57u+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgGQWLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 18:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgGQWLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 18:11:24 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31176C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 15:11:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z13so12586414wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 15:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j4Rcza/WtCshpklaOYU1XXSSWM9/PXwLNmLO5rqs6/A=;
        b=l2m57u+TR4yEo/1/8o+mwdtGzk63QHxgIMu87Ezzks74yZ2A92/vqJubckkePUbdhU
         LP/tqlBQJ1R0ia3hcvytWw5WrPv+Twwz7MRAKCogV0qZd4+vYnav+hotGOlSvORagU7o
         eA0ujl8h3zkX30s8RlTxs7RLYMQHqfzRoFE6svuB0ZnWIvz4sXfqpn1RS445ioE7G4Rj
         NKikZ5JzZeIG8gdH70AJZlgOtQ+ffPSXnSBm+L/lLJiZwpG3gyA6ihu8ZNsOOOg2WBTS
         b/Skv5ckjdXWk7bECXgpN4ENRkNE7DJNA/ietcFm0IX9fC1SAihESU0coGWMt5wryWUb
         JwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j4Rcza/WtCshpklaOYU1XXSSWM9/PXwLNmLO5rqs6/A=;
        b=PIBkDdClnWKgsQfd2I7hUigBvavuTjCCT4tBeZ1csnXZ25uWxNcIS951ntnCHTbf/s
         ZhXsYG5frGhOs72cOXSsBPbrXqJ3U9perGQv9IPqCcOt7PPzqXeJjilZu9aEvRPfPWrZ
         ldw7qBd9YMqNagOfDOdnDdII2PY4C0pGQVff11E9GuGKUjVHdl0FXXI65F3VD6Mjsv3S
         4M6+3TA/4fRcNfiVji7BgulFUANYy6JAZNkV/Tb9VevF08caZzHeuGf2S8jhUOIiPhGf
         BI1CZq1ahQ23bMn7UOcQtNuSTSRJ1mAiizDPgtCvdkv7dsDv3GTQEslhoej5s0fH6lX3
         wyBA==
X-Gm-Message-State: AOAM532UuRiv4qcLMEQ5G8Ec6OA4hFfPAOJ4SwkIp2lwH459lr8Jx+SY
        yAxAbyu9NjDJEZ/dy1HGA42oOtJ3Hq4U74IB3XpQGQ==
X-Google-Smtp-Source: ABdhPJxz9pnbJ6uCJ7qOWl9Y2R7L7oyGZdyKyr4ATbEQ0y1SVV3OMBaogGuCNNhk6KpiiH2gAm9Ez4We2qOo4s4NN+g=
X-Received: by 2002:a5d:4bd2:: with SMTP id l18mr11755969wrt.119.1595023882694;
 Fri, 17 Jul 2020 15:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200716094216.1418659-1-kjain@linux.ibm.com> <20200716152237.GC373728@kernel.org>
 <a80eebc2-885c-171d-7c7a-74df727d60b4@linux.ibm.com> <20200717085536.GC528602@krava>
In-Reply-To: <20200717085536.GC528602@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 17 Jul 2020 15:11:11 -0700
Message-ID: <CAP-5=fVu5wcb864RWa8_j8kv3XLU0Cr5nbhvrwBNytfgmuPObg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] powerpc/perf: Add json file support for hv_24x7
 core level events
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     kajoljain <kjain@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Paul Clarke <pc@us.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        maddy@linux.ibm.com, Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>, nasastry@in.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 1:55 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Jul 17, 2020 at 01:41:22PM +0530, kajoljain wrote:
> >
> >
> > On 7/16/20 8:52 PM, Arnaldo Carvalho de Melo wrote:
> > > Em Thu, Jul 16, 2020 at 03:12:11PM +0530, Kajol Jain escreveu:
> > >> Patchset enhance current runtime parameter support. It introduces new
> > >> fields like "PerChip" and "PerCore" similar to the field "PerPkg" which is
> > >> used to specify perpkg events.
> > >>
> > >> The "PerCore" and "PerChip" specifies whether its core or chip events.
> > >> Based on which we can decide which runtime parameter user want to
> > >> access. Now character  '?' can refers different parameter based on user
> > >> requirement.
> > >>
> > >> Initially, every time we want to add new terms like chip, core, thread
> > >> etc, we need to create corrsponding fields in pmu_events and event
> > >> struct.
> > >> This patchset adds an enum called 'aggr_mode_class' which store all these
> > >> aggregation like perpkg/percore. It also adds new field 'AggregationMode'
> > >> to capture these terms.
> > >> Now, if user wants to add any new term, they just need to add it in
> > >> the enum defined. I try to test it with  my current setup.
> > >>
> > >> I also need to replace PerPkg field to AggregationMode in all the
> > >> x86 uncore json files. It will great if Andi and team can test it
> > >> and let me know if they have any concerns.
> > >>
> > >> Changelog:
> > >> v2 -> v3:
> > >> - Did some nits changes suggested by Jiri include correction of
> > >>   indentation, and making PerCore/PerChip values forward after
> > >>   PerPkg as 1 in the enum.
> > >> - Rebase the patchset on Arnaldo's tmp.perf/core branch.
> > >> - Change RFC tag
> > >
> > > Hey, have anybody provided Acked-by/Reviewed-by for previous revisions
> > > of this patchset? If so you could have collected them for patches
> > > without changes, was that the case?
> >
> > Hi Arnaldo,
> >       I did get "Acked-by: Ian Rogers" on my initial prototype which I send in my RFC.
> > Link to the patch: https://lkml.org/lkml/2020/7/5/399
> >
> > After that, I break it down and made some nits changes as suggested by Jiri, that's why I didn't
> > add his Acked-by tag.
> > Ian should I add it, if it seems fine to you.
>
> I posted one more comment and I'd also like to hear from
> guys maintainng json list on intel side that they are ok
> with this, mainly the change introduced in:
>
>   pmu-events/x86/uncore: Replace PerPkg field to AggregationMode in x86 json files
>
> Andi?
>
> thanks,
> jirka

I am happy with this change.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
