Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73455C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50184207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cR6cpj4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgERQ3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 12:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgERQ3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:29:20 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421F3C05BD0A
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:29:19 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id f4so11204247iov.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TmNo324ewiqBrOzyFgGIajOz2Fxu5S4md+RR2eoMBH0=;
        b=cR6cpj4L3VfEX9LUwmpRrf5NaiDdEHQkdowyBqBDeP9M+RN+2PDUK9GqoycTwAHDkz
         v1kLKq+JDAbgGiNdDihildBwccSJeTyzjQl9UKfkXpQ9vNqRRkcWCErz0HmKI4hifSBY
         d+uumoTs1E8WCj8oA4lOOmAv+ZnAizTpJiETY5X+seRwXvJZ00cQWJXbrBIJFcVP7yCj
         gxEc9sgee310IqVllejFcBrMITelb35V5SI6azfkxzd2lv3TBqfKwDRq9Q8XFAJD41bg
         yO3/yfvFY1kq5xP74oW7hSdtWwD1jEBZqJm/mFWU9DOy0ggV+8k8/IdM9hN5lcU7qonu
         v0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TmNo324ewiqBrOzyFgGIajOz2Fxu5S4md+RR2eoMBH0=;
        b=b1/aAj+cIV3OA7zDcCLDJ0eLiqob2jDB8R5qz99UCHFqdCkIAINRaluNg/bRM7mfIE
         TVMvbeze7niLQE1yE1P45SCk1IRLR3Gtp8LA55V0Lt+Cp3vbCGySCXrxgPqQJZuSAg39
         lKNc9zHWv7hn9GDXCFPPAHV6iYrfL6TKYc5xxGunaN5ew0NNoC1rajiUzFxUrgKkvfEv
         wAEkoBivQHstUqrPPr4WPcpRVNW3EQ/vz/gOp6dZtLE1IvBAdBmSNMbiy9etTrbrc3By
         tfw7y1i2CUy13FkDirK6fBbTBNDwmRIzOCDl45J+x9wqzM0bVqpXzXg/u+wvTTydNGs+
         Sp7w==
X-Gm-Message-State: AOAM532/rBHLgv7Ko4EsY7AG+SkLpH99MyKVrjv/1KNNv85tpXsn19fg
        kHatMDZNnj5AzLv6acXJQieTwEEySQaqwB6/BXvzzA==
X-Google-Smtp-Source: ABdhPJwfkal/ogCvbE1YiVUSr2oHNZPX1BV5tAJ5ccooYPRJnI4ec3PTfIwWNWbZ0WgPcK7m/mubWCdkilY0URhDGgE=
X-Received: by 2002:a02:cf17:: with SMTP id q23mr16428337jar.39.1589819358215;
 Mon, 18 May 2020 09:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200515221732.44078-1-irogers@google.com> <20200515221732.44078-8-irogers@google.com>
 <20200518154505.GE24211@kernel.org> <CAP-5=fWZwuSLaFX+-pgeE_H92Mtp7+_NrwBeRFTqyfPjVRkbWg@mail.gmail.com>
 <20200518160648.GI24211@kernel.org> <20200518161137.GK24211@kernel.org>
In-Reply-To: <20200518161137.GK24211@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 18 May 2020 09:29:06 -0700
Message-ID: <CAP-5=fWzb5XxcFishFErRtdc-Gvv-7DkVpd6HSiy2_RswfjeDg@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] perf expr: Migrate expr ids table to a hashmap
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
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
        LKML <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 9:11 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Mon, May 18, 2020 at 01:06:48PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, May 18, 2020 at 09:03:45AM -0700, Ian Rogers escreveu:
> > > On Mon, May 18, 2020 at 8:45 AM Arnaldo Carvalho de Melo wrote:
> > > this build issue sounds like this patch is missing:
> > > https://lore.kernel.org/lkml/20200515221732.44078-3-irogers@google.com/
> > > The commit message there could have explicitly said having this
> > > #include causes the conflicting definitions between perf's debug.h and
> > > libbpf_internal.h's definitions of pr_info, etc.
> >
> > yeah, understood, but I'm not processing patches for tools/lib/bpf/,
> > Daniel is, I'll only get that one later, then we can go back to the way
> > you structured it. Just an extra bit of confusion in this process ;-)
>
> So, thiis is failing on all alpine Linux containers:
>
>   CC       /tmp/build/perf/util/metricgroup.o
>   CC       /tmp/build/perf/util/header.o
> In file included from util/metricgroup.c:25:0:
> /git/linux/tools/lib/api/fs/fs.h:16:0: error: "FS" redefined [-Werror]
>  #define FS(name)    \
>  ^
> In file included from /git/linux/tools/perf/util/hashmap.h:16:0,
>                  from util/expr.h:11,
>                  from util/metricgroup.c:14:
> /usr/include/bits/reg.h:28:0: note: this is the location of the previous definition
>  #define FS     25
>  ^
>   CC       /tmp/build/perf/util/callchain.o
>   CC       /tmp/build/perf/util/values.o
>   CC       /tmp/build/perf/util/debug.o
>   CC       /tmp/build/perf/util/fncache.o
> cc1: all warnings being treated as errors
> mv: can't rename '/tmp/build/perf/util/.metricgroup.o.tmp': No such file or directory
> /git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/util/metricgroup.o' failed
>
>
> I'll check that soon,
>
> - Arnaldo

I had some issues here too:
https://lore.kernel.org/lkml/CAEf4BzYxTTND7T7X0dLr2CbkEvUuKtarOeoJYYROefij+qds0w@mail.gmail.com/
The only reason for the bits/reg.h inclusion is for __WORDSIZE for the
hash_bits operation. As shown below:

#ifdef __GLIBC__
#include <bits/wordsize.h>
#else
#include <bits/reg.h>
#endif
static inline size_t hash_bits(size_t h, int bits)
{
/* shuffle bits and return requested number of upper bits */
return (h * 11400714819323198485llu) >> (__WORDSIZE - bits);
}

It'd be possible to change the definition of hash_bits and remove the
#includes by:

static inline size_t hash_bits(size_t h, int bits)
{
/* shuffle bits and return requested number of upper bits */
#ifdef __LP64__
  int shift = 64 - bits;
#else
  int shift = 32 - bits;
#endif
return (h * 11400714819323198485llu) >> shift;
}

Others may have a prefered more portable solution. A separate issue
with this same function is undefined behavior getting flagged
(unnecessarily) by sanitizers:
https://lore.kernel.org/lkml/20200508063954.256593-1-irogers@google.com/

I was planning to come back to that once we got these changes landed.

Thanks!
Ian
