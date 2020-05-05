Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D10FC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47D6F206CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="INzcmJmz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbgEEQ5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 12:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729791AbgEEQ5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:57:32 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D46C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 09:57:31 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id s9so1963983lfp.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 09:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HFM3yAkZb46xEygXrI+s20ep7bX7I+6v6zVkG9cjJ7Q=;
        b=INzcmJmzMSLXCRwm1CmJMtQDnvsBF6s3cj7aoQM6Zv3E5SBH2jFBzw7ry/XrAHey5/
         pVKlz6WC6OLPFIHALOJYelk9ZCdwX77Dd8WMlaaEhzwZfq5PaXKVtkrqgx69qoupxiqh
         DLBP4wVsIKhZoAsFSu16tcChFVYpD1pxUe1OQhtmFxBbfYGMkNyBYPtJXNvfIqOpXKWF
         cPJK9weGQ8alz2msZxseQNiGSZq4q1R9XZroSYO83jVHeFfPy3WQ7jFzQvwKibhemxjJ
         ofgdybr62xu7pcM5O4AkkcY2I3WganfNw63Pcry0mMoMzlrEXunkQT1/Q4Sn/nYPJvHk
         C3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HFM3yAkZb46xEygXrI+s20ep7bX7I+6v6zVkG9cjJ7Q=;
        b=ILPycxUDAZxK8P2LcKMbdjvLOrwe+c6xob5wNLqqCxqijV4jLqmt1C+L3x/KIXmzKi
         fITNVB9Pwkyw+8TrwR6xKY/vicWiwB22fd1+CgJqx3fkDVE0YKrEGN7GRSEHI3U/dzHG
         4nzwmh2bTLhZuL9afWAeo1pC4Q/g5y0jwl/w9UBaCh6fN55t/By4xkjlO782xQL9aOKA
         F+tNdzxPOeEfAI5ewanWfYwcQv1d+5zykFxCYOJ3ob2bx/bVZVFGX5ee/jcsrSGwkiYb
         SvJWXolBbrUJSc/xg+TAcUuq75QNzjtbh8bS0K5JpSPbrcNhujD1OTKg7ej+GRY88QTi
         Q9Fw==
X-Gm-Message-State: AGi0PuaMNlCu/QLHPlCPDFI3gY4OJzglOxb5ZunCKySqyLTBqJkDWpCE
        g+QGAbP/uzpSyDfoJwH/Xst+mLz6/4rbCU6vhN5zoA==
X-Google-Smtp-Source: APiQypIydTqFNd8ijO9FDu1OMphXddqsk686RAVqOaokW0pq/4IyK0aHzzYs+555k3I/Q+rK+dFaerRMeXp2Pzlpupg=
X-Received: by 2002:a19:84b:: with SMTP id 72mr2289067lfi.133.1588697850287;
 Tue, 05 May 2020 09:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200420115316.18781-1-acme@kernel.org> <20200422120943.GA110748@gmail.com>
 <CAEUSe7_wmKS361mKLTB1eYbzYXcKkXdU26BX5BojdKRz8MfPCw@mail.gmail.com>
 <20200424130722.GK19437@kernel.org> <0f6403ec-36cd-f43f-b3a6-b87e628f3789@redhat.com>
 <CAEUSe7_Ybp=7XC-2xMSEGYmCHvEMff0YbZq1f6akvxLVcS_ePA@mail.gmail.com> <20200505163745.GD3777@redhat.com>
In-Reply-To: <20200505163745.GD3777@redhat.com>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Tue, 5 May 2020 11:57:18 -0500
Message-ID: <CAEUSe7-0gXZ4M+dK_ur7J9J01ParcqkkUw=aGE552fDGHcnjUw@mail.gmail.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andreas Gerstmayr <agerstmayr@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        He Zhe <zhe.he@windriver.com>, Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Konstantin Kharlamov <hi-angel@yandex.ru>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, 5 May 2020 at 11:37, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Mon, May 04, 2020 at 02:07:56PM -0500, Daniel D=C3=ADaz escreveu:
> > Hello!
> >
> > On Fri, 24 Apr 2020 at 09:10, Andreas Gerstmayr <agerstmayr@redhat.com>=
 wrote:
> > >
> > > On 24.04.20 15:07, Arnaldo Carvalho de Melo wrote:
> > > > Em Thu, Apr 23, 2020 at 04:28:46PM -0500, Daniel D=C3=ADaz escreveu=
:
> > > >> On Wed, 22 Apr 2020 at 07:09, Ingo Molnar <mingo@kernel.org> wrote=
:
> > > >>>>   85 files changed, 1851 insertions(+), 513 deletions(-)
> > > >
> > > >>> Pulled, thanks a lot Arnaldo!
> > > >
> > > >> Our OpenEmbedded builds detected an issue with 5287f9269206 ("perf
> > > >> script: Add flamegraph.py script"):
> > > >>    ERROR: perf-1.0-r9 do_package_qa: QA Issue:
> > > >> /usr/libexec/perf-core/scripts/python/bin/flamegraph-report contai=
ned
> > > >> in package perf-python requires /usr/bin/sh, but no providers foun=
d in
> > > >> RDEPENDS_perf-python? [file-rdeps]
> > > >
> > > >
> > > > yeah, the flamegraph scripts are the outliers, there, everything el=
se is
> > > > using /bin/bash, so I'll switch to that, ok Andreas?
> > >
> > > Sure, no problem. Thanks!
> >
> > Just a gentle reminder that this can still be fixed in today's
> > linux-next tree (next-20200504).
>
> Thanks for the reminder, I've just added this to my tree:
>
> commit c74ab13a30d3bec443c116e25b611255c58f32c0
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Tue May 5 13:33:12 2020 -0300
>
>     perf flamegraph: Use /bin/bash for report script
>
>     As all the other tools/perf/scripts/python/bin/*-report scripts, fixi=
ng
>     the this problem reported by Daniel Diaz:
>
>       Our OpenEmbedded builds detected an issue with 5287f9269206 ("perf
>       script: Add flamegraph.py script"):
>         ERROR: perf-1.0-r9 do_package_qa: QA Issue:
>       /usr/libexec/perf-core/scripts/python/bin/flamegraph-report contain=
ed
>       in package perf-python requires /usr/bin/sh, but no providers found=
 in
>       RDEPENDS_perf-python? [file-rdeps]
>
>       This means that there is a new binary pulled in in the shebang line
>       which was unaccounted for: `/usr/bin/sh`. I don't see any other usa=
ge
>       of /usr/bin/sh in the kernel tree (does not even exist on my Ubuntu
>       dev machine) but plenty of /bin/sh. This patch is needed:
>       -----8<----------8<----------8<-----
>       diff --git a/tools/perf/scripts/python/bin/flamegraph-record
>       b/tools/perf/scripts/python/bin/flamegraph-record
>       index 725d66e71570..a2f3fa25ef81 100755
>       --- a/tools/perf/scripts/python/bin/flamegraph-record
>       +++ b/tools/perf/scripts/python/bin/flamegraph-record
>       @@ -1,2 +1,2 @@
>       -#!/usr/bin/sh
>       +#!/bin/sh
>        perf record -g "$@"
>       diff --git a/tools/perf/scripts/python/bin/flamegraph-report
>       b/tools/perf/scripts/python/bin/flamegraph-report
>       index b1a79afd903b..b0177355619b 100755
>       --- a/tools/perf/scripts/python/bin/flamegraph-report
>       +++ b/tools/perf/scripts/python/bin/flamegraph-report
>       @@ -1,3 +1,3 @@
>       -#!/usr/bin/sh
>       +#!/bin/sh
>        # description: create flame graphs
>        perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "=
$@"
>       ----->8---------->8---------->8-----
>
>     Fixes: 5287f9269206 ("perf script: Add flamegraph.py script")
>     Reported-by: Daniel D=C3=ADaz <daniel.diaz@linaro.org>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Andreas Gerstmayr <agerstmayr@redhat.com>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: lkft-triage@lists.linaro.org
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Link: http://lore.kernel.org/lkml/CAEUSe7_wmKS361mKLTB1eYbzYXcKkXdU26=
BX5BojdKRz8MfPCw@mail.gmail.com
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> diff --git a/tools/perf/scripts/python/bin/flamegraph-report b/tools/perf=
/scripts/python/bin/flamegraph-report
> index b1a79afd903b..53c5dc90c87e 100755
> --- a/tools/perf/scripts/python/bin/flamegraph-report
> +++ b/tools/perf/scripts/python/bin/flamegraph-report
> @@ -1,3 +1,3 @@
> -#!/usr/bin/sh
> +#!/bin/bash
>  # description: create flame graphs
>  perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"

What about flamegraph-record?

Thanks and greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
