Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32954C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D12B21473
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LPPFLsaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgEGRWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726926AbgEGRWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:22:09 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB7FC05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 10:22:07 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id a8so3322285ybs.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 10:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=phjJTuMDAOlaZCX/Tb2VvH1tmCsl7WLbhvWomYEgIZ0=;
        b=LPPFLsaaMtJEaAHepDL0RFjxM/1vMa3JeM+hYNx8jSfgqog5xlW3x1C4YBdqbmpBJD
         /QtqS8+L1hKvkEepplW0Dl4n7/ZbjQO7xNeRI62yGyOTpyGDhE2ip8BgbxARfIyQJL5v
         rrrzKLt/LIXlf6xBNLPmiY6uX5N9xGY+sn4yBVySu+EvRW1ljz2k7CIUbtKtK8LCXl0R
         w/JqTc1p7oqnQJTh3jC1Sy4ug6VkdadSUsbpuf9oTTg09Wm4elmpM74smHL5MdkVH6dT
         BaQzEOZ43XJetHUZhEcDqLmo+QJX04nHFzD6NcsuiYSGRsYznL7qBK+hFbE6HKLDth6n
         r3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=phjJTuMDAOlaZCX/Tb2VvH1tmCsl7WLbhvWomYEgIZ0=;
        b=b3o3uQ8jTeXCF1PzlkG9wSsV8Dfir9Z8iQanLI+FJMc+Udm4YaMi2DJRhAYUuE7Kl9
         +VXfCZC3Voc34FEQJEAe1GUijja6AouUZUKvkt/RF6kIMoFIml1bvspzYk9cIyJxp8Fn
         giQuvd9sMkjI3sI5/95xOQ664E6BaTrRafrzNzGYUrwQQCfABR8xR88ICnn/pq1bq/A9
         I5MlpGoFOTx85Ga9QyVxf3hcnmCXHMyGg6QTZyeDVb7x+DaANMT3BoKU4Hz1mYpjfPH/
         XYUbLS6H61989jiVIBF6Qh/LoYAG/ydss7h3nrMNalxOpW3nmB8w9X+Rsl2zQzFQlM7A
         iiYQ==
X-Gm-Message-State: AGi0Puayw6VBswvFYxkphHtmma7XZcMyoZym4e/pZDft6bVbva3EZap0
        UgmFb3MZ7t78gTgjJC8w1WGr6kNrdWjgKrmrLpA5Qg==
X-Google-Smtp-Source: APiQypKnW5cztJyd/iXjvjhKCiYTxwVUuwWyZ85q2UaesJTLEYIQVSCCWi3DekKyjjDkwHAaH8jyA+iYsFxou5E7hEA=
X-Received: by 2002:a25:d688:: with SMTP id n130mr23283865ybg.324.1588872126444;
 Thu, 07 May 2020 10:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <1588868938-21933-1-git-send-email-pc@us.ibm.com>
 <1588868938-21933-2-git-send-email-pc@us.ibm.com> <20200507164825.GE31109@kernel.org>
In-Reply-To: <20200507164825.GE31109@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 7 May 2020 10:21:55 -0700
Message-ID: <CAP-5=fXKprz247P8iwH4EwxVarS_j_Y=fNRxBryPAi3N97ksPg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf: Fix POWER9 metric 'lsu_other_stall_cpi'
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     "Paul A. Clarke" <pc@us.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ananth@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        sukadev@linux.ibm.com, mpe@ellerman.id.au
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 9:48 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, May 07, 2020 at 11:28:57AM -0500, Paul A. Clarke escreveu:
> > From: "Paul A. Clarke" <pc@us.ibm.com>
> >
> > The metric definition is too long for the current value of EXPR_MAX_OTHER.
> > Increase the value EXPR_MAX_OTHER sufficiently to allow
> > 'lsu_other_stall_cpi' to build properly.
>
> I already have a patch from Ian that bumps this further:

I sent out:
https://lore.kernel.org/lkml/20200507081436.49071-2-irogers@google.com/
which removes this constant and moves the code to use a hashmap.
Unfortunately, the hashmap comes from libbpf and so there is a
dependency issue to resolve. Perhaps libapi can have a hashmap? I'm
not sure who resolves these issues. A short-term fix is just to make
the constant bigger.

Thanks,
Ian

> [acme@five perf]$ git log -p tools/perf/util/expr.h
> commit 26d3350db3e4668c1b1ff7f81c419afe71a2e8d9
> Author: Ian Rogers <irogers@google.com>
> Date:   Fri May 1 10:33:26 2020 -0700
>
>     perf expr: Increase max other
>
>     Large metrics such as Branch_Misprediction_Cost_SMT on x86 broadwell
>     need more space.
>
>     Signed-off-by: Ian Rogers <irogers@google.com>
>     Acked-by: Jiri Olsa <jolsa@redhat.com>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     Cc: Andi Kleen <ak@linux.intel.com>
>     Cc: Haiyan Song <haiyanx.song@intel.com>
>     Cc: Jin Yao <yao.jin@linux.intel.com>
>     Cc: John Garry <john.garry@huawei.com>
>     Cc: Kajol Jain <kjain@linux.ibm.com>
>     Cc: Kan Liang <kan.liang@linux.intel.com>
>     Cc: Leo Yan <leo.yan@linaro.org>
>     Cc: Mark Rutland <mark.rutland@arm.com>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Paul Clarke <pc@us.ibm.com>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>     Cc: Song Liu <songliubraving@fb.com>
>     Cc: Stephane Eranian <eranian@google.com>
>     Link: http://lore.kernel.org/lkml/20200501173333.227162-6-irogers@google.com
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 87d627bb699b..40fc452b0f2b 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -2,7 +2,7 @@
>  #ifndef PARSE_CTX_H
>  #define PARSE_CTX_H 1
>
> -#define EXPR_MAX_OTHER 20
> +#define EXPR_MAX_OTHER 64
>  #define MAX_PARSE_ID EXPR_MAX_OTHER
>
>  struct expr_parse_id {
>
>
> > Before:
> > --
> > $ perf list | grep lsu_other
> >   lsu_other_stall_cpi
> > # perf stat -a --metrics lsu_other_stall_cpi /bin/sleep 1
> > Cannot find metric or group `lsu_other_stall_cpi'
> >
> >  Usage: perf stat [<options>] [<command>]
> >
> >     -M, --metrics <metric/metric group list>
> >                           monitor specified metrics or metric groups (separated by ,)
> > --
> >
> > After:
> > --
> > # perf stat -a --metrics lsu_other_stall_cpi /bin/sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >        438,086,889      pm_cmplu_stall_lsu        #     1.74 lsu_other_stall_cpi
> > [...]
> > --
> >
> > Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> > ---
> >  tools/perf/util/expr.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> > index 87d627bb699b..a0991959cca4 100644
> > --- a/tools/perf/util/expr.h
> > +++ b/tools/perf/util/expr.h
> > @@ -2,7 +2,7 @@
> >  #ifndef PARSE_CTX_H
> >  #define PARSE_CTX_H 1
> >
> > -#define EXPR_MAX_OTHER 20
> > +#define EXPR_MAX_OTHER 28
> >  #define MAX_PARSE_ID EXPR_MAX_OTHER
> >
> >  struct expr_parse_id {
> > --
> > 2.18.2
> >
>
> --
>
> - Arnaldo
