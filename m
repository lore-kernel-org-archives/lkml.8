Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6D7C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C8C9205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EwF/zsrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgGORAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 13:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgGORAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 13:00:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6958AC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 10:00:22 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l2so6536154wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2eBn3+EVfj8N4psyRPlN3zHm1Nlg+2LJ1kPRxLMMbY=;
        b=EwF/zsrYrLoNZL+1mhpkV26aToBaZ70ZYFZgmoEIxoLMHKf9jrheCesgW5aCeCl2ZH
         x2Bki76zqs/Vwha9F1oU+5K5yOTdqQUe3cW3kGaAjkb0TsRZ277DFapOwgwf7fRFve6u
         uwEpsCKJcEOpKcR+/SgJbG8BptO/dN5tzfXrgF4lwQ+b4RS4YeAU2Tkqpk2ykDhS1NZE
         Kf1toOB8Gfe0QtzZ8ljeIb9b1EtdJN1BWhVFPDUN3Lz4Q0dIwAr8q6gbxEFd4Yxf65hH
         beIfVfFn0aVTjBR8sMmjvmsGTd7iD93KdrpYo0X683xK91TJIKmKXvBBsUWfMaArcKDg
         rUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2eBn3+EVfj8N4psyRPlN3zHm1Nlg+2LJ1kPRxLMMbY=;
        b=Y9f9CmlV6QMGYZcr8gAUrUbPQx7Z/8q6KYW6p6lxgrR0ZlDKEkcMna+lJjGowCTVfJ
         hPMudXrKKGU8VZ79TEqyZGZDLEUm+WpLKQEjADEAv45Iwu+Hms2cVf7NeG5z7FhTjCRi
         hRspnBbLF8Zx529EgTUGSrhUQnRtnrJkBUI4Xzuph9dVgWRPcFkcLaRwb7e2vndeRhxx
         /UnongVfTC0tfXnJT0kTs22fIEkaN1eyr2UV0uFpwUTv589S6XonWjFP5TR/y9/jlU9P
         8yEu6K40ci67UxY4rMyCHVdj/F33dFV+gHq30uXGetXkrglVx7IjwLfqyb99cO5oVb+s
         RxHg==
X-Gm-Message-State: AOAM532ps5+aMbKdOSEQbxJY3eVb8eLCoe1FuP2G15W2y9OFV+x9Yl5o
        SLUYrkCYD9NT31ZHQwlE/GVBOFSBx3TOiJSmIzamiw==
X-Google-Smtp-Source: ABdhPJxosDB/zioPQt8T+6l2O+rJviFlggpvtgZU3QKstoN0n1OLAPCh+AA+ZnNjTLtI48gKbH3/Q/c6vN+V4ipdt30=
X-Received: by 2002:a1c:19c5:: with SMTP id 188mr378094wmz.124.1594832420926;
 Wed, 15 Jul 2020 10:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200712132634.138901-1-jolsa@kernel.org> <20200712132634.138901-14-jolsa@kernel.org>
In-Reply-To: <20200712132634.138901-14-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 15 Jul 2020 10:00:09 -0700
Message-ID: <CAP-5=fXHGGCFw_5zcXboFUYeNMMC5K0fbAXwPn0HRw91pt6A0A@mail.gmail.com>
Subject: Re: [PATCH 13/18] perf metric: Add events for the current group
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 6:27 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> There's no need to iterate the whole list of groups,
> when adding new events. The currently created group
> is the one we want to add.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/metricgroup.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 8cbcc5e05fef..66f25362702d 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -811,17 +811,19 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,

Could we add a function comment to describe the arguments here?
Currently events is an empty list out argument that is built up by
this code, now it will be incrementally updated. Except I don't think
I'm capturing the current state correctly, it is confusing that there
is the loop in the current code. It looks like events will be added
multiple times redundantly.

>         if (ret)
>                 return ret;
>
> -       list_for_each_entry(eg, group_list, nd) {
> -               if (events->len > 0)
> -                       strbuf_addf(events, ",");
> +       if (events->len > 0)
> +               strbuf_addf(events, ",");
>
> -               if (eg->has_constraint) {
> -                       metricgroup__add_metric_non_group(events,
> -                                                         &eg->pctx);
> -               } else {
> -                       metricgroup__add_metric_weak_group(events,
> -                                                          &eg->pctx);
> -               }
> +       /*
> +        * Even if we add multiple groups through the runtime
> +        * param, they share same events.
> +        */

I'm not clear what runtime param is here. Is it the \? arch runtime parameter?

Thanks,
Ian

> +       if (eg->has_constraint) {
> +               metricgroup__add_metric_non_group(events,
> +                                                 &eg->pctx);
> +       } else {
> +               metricgroup__add_metric_weak_group(events,
> +                                                  &eg->pctx);
>         }
>         return 0;
>  }
> --
> 2.25.4
>
