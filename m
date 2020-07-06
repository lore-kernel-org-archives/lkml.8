Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6A1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 00:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F04620759
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 00:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hYPsVPNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgGFAr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 20:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgGFAr4 (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 20:47:56 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F42C061794
        for <Linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 17:47:56 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 22so37526964wmg.1
        for <Linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 17:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=goHlgbvpDIuR7E3z6NGEZAskx5ZrdgD3sWmyQqLPgdE=;
        b=hYPsVPNBDPR0kEiQdqHh4bAp4LC1E52HtgKWKVwwbe/S3Q3y162XYqBUfvDQzH6XKb
         ImH+tARQiCApb5aiiRnNAS7D0U64+rYzhHGPJPLuSwD6az/C+jfdIiQN+wtS+04RA+c6
         mTJ0ZkDQMsCNf4TdWIfMZdvxZ+KpuPkVrw63N6UpMRvL2LT3eHjN1wbcrY2vFGXCADCB
         1aQpcZL6M9mAGWRbzmqyJAlTJlsvKX1cL0b/JrvLQh6F/XIO4SDUCQtk2jsH2utTF3ul
         GucC9k/HDR2sj/18bfkUwrBqwmfWdGatDsGWkg9VcCF4bQuHaF1uHzEx8x6LtgxsEL+o
         lsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=goHlgbvpDIuR7E3z6NGEZAskx5ZrdgD3sWmyQqLPgdE=;
        b=qJKWxNfWE085MLsR60uFEakG3n+TFnjec6qW+flT5PHMmR6KEWFLGPj9fSMhBv3mYc
         wn7kbzqKT1EUPTIzvdpDe0DXAPY8KHnxgDmq0Fb5FB96XfUWZLWIWr90tOW5YgGznNUg
         2KDk++CT1RQ47S2wOAToioOyQz+rZ+vBzxwGa+8jLeITqVxd2votGu19tTU9zSfq94T4
         /TofJzHox3KxtReK37CZvbxvE+IAnWqSPlDgcwy6NBRkLJIBAMhhyeMhKO4luZgSEY9L
         yBRBjfhtfyf8Ez9YTtGj5s3xq/VQRcQC7VAZnIUZcaddtPBunCDFQ+wdIjNIhzVF/FZj
         P+aQ==
X-Gm-Message-State: AOAM5335fSDNa0J35qGGslAoZBQd6A67Rq3YNzOY6prWBt10l0g3dbLr
        Le9B5gmvz5bOjyXdBHeFyJdoTa3SyDcE7D4VhmNkWw==
X-Google-Smtp-Source: ABdhPJwKPGP8Yq5yzVTxxH1FkcQvyCUjCwriGHfBLS328Di+8oJ26KScDJ8HfJ50mP/YS93kJnvNOdGuar9e7lUdTu0=
X-Received: by 2002:a1c:398b:: with SMTP id g133mr45278087wma.76.1593996473791;
 Sun, 05 Jul 2020 17:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200703004215.24418-1-yao.jin@linux.intel.com>
 <20200703110042.GA3282312@krava> <9fa0bd83-b21e-7bc2-af81-799f8e99f73b@linux.intel.com>
In-Reply-To: <9fa0bd83-b21e-7bc2-af81-799f8e99f73b@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 5 Jul 2020 17:47:42 -0700
Message-ID: <CAP-5=fUjUc7yAA2wyes+DhMkwP9Mw0Lu5gy=XOnugy=vW1jwoQ@mail.gmail.com>
Subject: Re: [PATCH] perf evsel: Don't set sample_regs_intr/sample_regs_user
 for dummy event
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, kan.liang@intel.com,
        "Jin, Yao" <yao.jin@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 5:31 PM Jin, Yao <yao.jin@linux.intel.com> wrote:
>
> Hi Jiri,
>
> On 7/3/2020 7:00 PM, Jiri Olsa wrote:
> > On Fri, Jul 03, 2020 at 08:42:15AM +0800, Jin Yao wrote:
> >> Since commit 0a892c1c9472 ("perf record: Add dummy event during system wide synthesis"),
> >> a dummy event is added to capture mmaps.
> >>
> >> But if we run perf-record as,
> >>
> >>   # perf record -e cycles:p -IXMM0 -a -- sleep 1
> >>   Error:
> >>   dummy:HG: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'
> >>

Sorry for the breakage caused by modifying the dummy event. Could we
add a test to cover the issue? Perhaps in tools/perf/tests/shell/.
Trying to reproduce with a register on my skylakex on a 5.6.14 kernel
with:

$ perf record -e cycles:p -IAX -a -- sleep 1

succeeds.

Thanks,
Ian

> >> The issue is, if we enable the extended regs (-IXMM0), but the
> >> pmu->capabilities is not set with PERF_PMU_CAP_EXTENDED_REGS, the kernel
> >> will return -EOPNOTSUPP error.
> >>
> >> See following code pieces.
> >>
> >> /* in kernel/events/core.c */
> >> static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
> >>
> >> {
> >>      ....
> >>      if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
> >>          has_extended_regs(event))
> >>              ret = -EOPNOTSUPP;
> >>      ....
> >> }
> >>
> >> For software dummy event, the PMU should be not set with
> >> PERF_PMU_CAP_EXTENDED_REGS. But unfortunately in current code, the dummy
> >> event has possibility to be set with PERF_REG_EXTENDED_MASK bit.
> >>
> >> In evsel__config, /* tools/perf/util/evsel.c */
> >>
> >> if (opts->sample_intr_regs) {
> >>      attr->sample_regs_intr = opts->sample_intr_regs;
> >> }
> >>
> >> If we use -IXMM0, the attr>sample_regs_intr will be set with
> >> PERF_REG_EXTENDED_MASK bit.
> >>
> >> It doesn't make sense to set attr->sample_regs_intr for a
> >> software dummy event.
> >>
> >> This patch adds dummy event checking before setting
> >> attr->sample_regs_intr.
> >>
> >> After:
> >>    # ./perf record -e cycles:p -IXMM0 -a -- sleep 1
> >>    [ perf record: Woken up 1 times to write data ]
> >>    [ perf record: Captured and wrote 0.413 MB perf.data (45 samples) ]
> >
> > LGTM, Adrian (cc-ed) just added another check to the same place,
> > but it looks like both of them should be there:
> >
> >    https://lore.kernel.org/lkml/20200630133935.11150-2-adrian.hunter@intel.com/
> >
> > jirka
> >
>
> Thanks Jiri! Yes, it looks like both of checks should be added here.
>
> So do I post v2 (just rebase) once Adrian's patch gets merged?
>
> Thanks
> Jin Yao
>
> >>
> >> Fixes: 0a892c1c9472 ("perf record: Add dummy event during system wide synthesis")
> >> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> >> ---
> >>   tools/perf/util/evsel.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >> index 96e5171dce41..df3315543e86 100644
> >> --- a/tools/perf/util/evsel.c
> >> +++ b/tools/perf/util/evsel.c
> >> @@ -1020,12 +1020,12 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
> >>      if (callchain && callchain->enabled && !evsel->no_aux_samples)
> >>              evsel__config_callchain(evsel, opts, callchain);
> >>
> >> -    if (opts->sample_intr_regs) {
> >> +    if (opts->sample_intr_regs && !is_dummy_event(evsel)) {
> >>              attr->sample_regs_intr = opts->sample_intr_regs;
> >>              evsel__set_sample_bit(evsel, REGS_INTR);
> >>      }
> >>
> >> -    if (opts->sample_user_regs) {
> >> +    if (opts->sample_user_regs && !is_dummy_event(evsel)) {
> >>              attr->sample_regs_user |= opts->sample_user_regs;
> >>              evsel__set_sample_bit(evsel, REGS_USER);
> >>      }
> >> --
> >> 2.17.1
> >>
> >
