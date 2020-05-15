Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AD8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E617620643
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="et/afkD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgEOVro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 17:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727867AbgEOVrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 17:47:43 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E0CC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 14:47:41 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id m10so1870312ybf.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 14:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tS+3CNMGEUW08GWKVNnTCx8encgyi37BKeJukWELzNc=;
        b=et/afkD6oOQ8yPirs/ovFayPyCKLRWPBJUWQfo6mBaGP/VgeItYGcmmiMuFdkQ6diZ
         lp2UAYZh47m0f2FWyEAfMlk4lqL+Wr0b0qd5sPjrOwqaSqmM0AbXME4ySzcO9tEgap7Y
         xiRN17Nh1zlxP4xm6W9+lMzqt5ruP2vFDCIT8O1B969Sf+eEAjWKn+0e8BMhjNvVimnP
         61i1EQ4/Wp6WC4QfNVm8DxLjYZghfSRzNiY4gQtihWRYH10r0WFXg69IQPatUG9UKUaR
         cagIPuLbrusA2+bourPD0q/2aJK8T8FtidKLadBqUvR6y/kPO08+8NvBAN+sPJnI7KRi
         3fDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tS+3CNMGEUW08GWKVNnTCx8encgyi37BKeJukWELzNc=;
        b=elIbNVR64JLsGIamSE/PQ3IQJmf1IcULlbtiJdiJ1Q1RXmK6dZhetXI28fJCmOlCwI
         J7ysMxMhl8fMA5/QY5ImV1P9qPwRxki8H8J4KCeWFVRFdPq2AVASoKzb3oSd5Hgmpp4X
         oI+CXA0tW/2gbNdYFM2PYOI6JRppu4P4x7B5sFxhY0nzd077L10qIi0CynNTtMpK0+c1
         3R9bLOrvzQTm0sYmrt67Q0osPSCd6cG8fB3b0J3I2KVGbymw0ldBudk6BcV+DHjg8vWY
         bWECh5Uq74Dm7IpgSBfLyCzbtQ9WLWRToH2pCHMvMTpAxyvJzn840jNvOEANojunW8TZ
         NNiA==
X-Gm-Message-State: AOAM531HuTlTlgUHSqrZneBiduLMQvN8i62oTLHgfheErtl1YPM2ySxj
        rhqlGOviPrEoE1LoxmY6hNcs1br/PJD2Y/+38bN9bw==
X-Google-Smtp-Source: ABdhPJyM9orvNlQicAfnrlZkcpeDb6FoYRrmyCqPxtKl7R3aimfxalhbrMVLLt0N1/ukrAhCjRtDKdjh/3N4+YwP+TM=
X-Received: by 2002:a25:c08b:: with SMTP id c133mr8940904ybf.286.1589579260905;
 Fri, 15 May 2020 14:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200515165007.217120-1-irogers@google.com> <20200515170036.GA10230@kernel.org>
 <CAEf4BzZ5=_yu1kL77n+Oc0K9oaDi4J=c+7CV8D0AXs2hBxhNbw@mail.gmail.com> <5ebf0748.1c69fb81.f8310.eef3@mx.google.com>
In-Reply-To: <5ebf0748.1c69fb81.f8310.eef3@mx.google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 15 May 2020 14:47:29 -0700
Message-ID: <CAP-5=fWX6nD72Fn7dBS3Mrd_wy9iqkGKnfhHPxcqC_oNfKPZQA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Copy hashmap to tools/perf/util, use in perf expr
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 2:19 PM <arnaldo.melo@gmail.com> wrote:
>
> <bpf@vger.kernel.org>,Stephane Eranian <eranian@google.com>
> From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> Message-ID: <79BCBAF7-BF5F-4556-A923-56E9D82FB570@gmail.com>
>
>
>
> On May 15, 2020 4:42:46 PM GMT-03:00, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >On Fri, May 15, 2020 at 10:01 AM Arnaldo Carvalho de Melo
> ><arnaldo.melo@gmail.com> wrote:
> >>
> >> Em Fri, May 15, 2020 at 09:50:00AM -0700, Ian Rogers escreveu:
> >> > Perf's expr code currently builds an array of strings then removes
> >> > duplicates. The array is larger than necessary and has recently
> >been
> >> > increased in size. When this was done it was commented that a
> >hashmap
> >> > would be preferable.
> >> >
> >> > libbpf has a hashmap but libbpf isn't currently required to build
> >> > perf. To satisfy various concerns this change copies libbpf's
> >hashmap
> >> > into tools/perf/util, it then adds a check in perf that the two are
> >in
> >> > sync.
> >> >
> >> > Andrii's patch to hashmap from bpf-next is brought into this set to
> >> > fix issues with hashmap__clear.
> >> >
> >> > Two minor changes to libbpf's hashmap are made that remove an
> >unused
> >> > dependency and fix a compiler warning.
> >>
> >> Andrii/Alexei/Daniel, what do you think about me merging these fixes
> >in my
> >> perf-tools-next branch?
> >
> >I'm ok with the idea, but it's up to maintainers to coordinate this :)
>
> Good to know, do I'll take all patches except the ones touching libppf, will just make sure the copy is done with the patches applied.
>
> At some point they'll land in libbpf and the warning from check_headers.sh will be resolved.

So tools/perf/util's hashmap will be ahead of libbpf's, as without the
fixes the perf build is broken by Werror. This will cause
check_headers to warn in perf builds, which would usually mean our
header was older than the source one, but in this case it means the
opposite, we're waiting for the libbpf patches to merge. Aside from
some interim warnings everything will resolve itself and Arnaldo
avoids landing patches in libbpf that can interfere with bpf-next.

It takes some getting your head around but sounds good to me :-) I
think the only workable alternatives would be to explore having a
single version of the code in some kind of shared libhashmap or to
implement another hashmap in libapi. I'd like to get the rest of this
work unblocked and so it'd be nice to land this and we can always
refactor later - I like Arnaldo's plan. Can a bpf maintainer make sure
the hashmap changes get pulled into bpf-next?

Thanks!
Ian

> Thanks,
>
> - Arnaldo
>
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
