Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CB0C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 00:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA8E20714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 00:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TykLrEPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCXABn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 20:01:43 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40430 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbgCXABn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 20:01:43 -0400
Received: by mail-yb1-f196.google.com with SMTP id o1so8167978ybp.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 17:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PpHg6A0qBvHeYAoS3znW8ChdqVWLNG15i4VtkhtKeds=;
        b=TykLrEPC1T/syug6sDXqf2lbmbGt1th+/KLFfGxqBwMcR4R2V0e7tP9XGWAit2YuBn
         CBLFU1tMrIu/0GaUd4RjD+rQR1waeVy0WdkHO9w8EpapngMh6UX7Qlz7qYGq4fJ1ngHJ
         f3xpWt/6PTIFpnzjJkL1cBQ10b+ufOtF7C+MT2J6Ss8lqD6SsgLVyXv1QfVCFlV0aX/w
         b2GJObAIGzoEsr0kUStaDDojVuy4IJ1c86bLnv2pv+XoUs7exxurYL4a6qK0S2kziuVy
         BQsXjcuJKi/xnxtvaW7qkdcrqNFXn6vyQcqov/NsYIWOnZpYYb6ncHv/NraOJuaI9a3I
         iJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PpHg6A0qBvHeYAoS3znW8ChdqVWLNG15i4VtkhtKeds=;
        b=GuUv3m69NcZEVVghnLfPV6sXSB41E2oig5eQ6U8pJJzMUYKkBxUGrJiwPk2KNywuzi
         p/qPbVtZzdbfucde1FTAjIF0o45gMyVG108BnkC43lqV0geRLR8F9ZNBif08CQA/WUBh
         Q6XjgITCwI9xmfvJsXmhy8PHXlEkBak7viUuiO1zZjgYnqHo5TRYt0txoJwf86XXvUbu
         /hJ1MXLxpKP+u/ygT6B4EYYu+r6v943tnXRp1cglBArLMi9WvKL+Hcip1WtnVw2N3KfV
         BVp/rB3Mt6DBrfvTbs9cZecCTCT2DBEFbxLsmwESwZV9wWL1DocjrBxxjBo5OgwTpIzb
         MylA==
X-Gm-Message-State: ANhLgQ0aOyzIzozTofWVSD56CtEQPbKgoAznaF/v09xKPVa52iChgjnP
        woe1dwix/SvqxOX9Muj0vfIMycp3e+yK8fa+PLW8wg==
X-Google-Smtp-Source: ADFU+vtShWGNVSWFCHAoZ4d8nr9jmZfNonZS9rk3oRYaDE1iOzpQ7rHayM9VPy3ueWsY+WNCZ3a5umZVNGKF9kDqLdc=
X-Received: by 2002:a25:b0a1:: with SMTP id f33mr36112602ybj.403.1585008099753;
 Mon, 23 Mar 2020 17:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200319041134.116241-1-irogers@google.com> <20200323105656.GC1534489@krava>
In-Reply-To: <20200323105656.GC1534489@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 23 Mar 2020 17:01:28 -0700
Message-ID: <CAP-5=fXDef4J=mEB1WES7Oc6pvhAjRnHwND0JzAPPYw26Gfx3w@mail.gmail.com>
Subject: Re: [PATCH v4] perf tools: add support for libpfm4
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jiwei Sun <jiwei.sun@windriver.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 3:57 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Mar 18, 2020 at 09:11:34PM -0700, Ian Rogers wrote:
> > This patch links perf with the libpfm4 library if it is available and
> > NO_LIBPFM4 isn't passed to the build. The libpfm4 library contains hardware
> > event tables for all processors supported by perf_events. It is a helper
> > library that helps convert from a symbolic event name to the event
> > encoding required by the underlying kernel interface. This
> > library is open-source and available from: http://perfmon2.sf.net.
> >
> > With this patch, it is possible to specify full hardware events
> > by name. Hardware filters are also supported. Events must be
> > specified via the --pfm-events and not -e option. Both options
> > are active at the same time and it is possible to mix and match:
> >
> > $ perf stat --pfm-events inst_retired:any_p:c=1:i -e cycles ....
> >
> > v4 is a rebase on git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
> >    branch perf/core and re-adds the tools/build/feature/test-libpfm4.c
> >    missed in v3.
>
> ugh.. I might have waited too long, but I can't apply it
> anymore on Arnaldo's perf/core, sorry
>
> jirka

No worries, rebase here:
https://lkml.org/lkml/2020/3/23/1054

Thanks!
Ian
