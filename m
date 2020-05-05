Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04591C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C69F7206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHLr6bBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbgEERD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 13:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729553AbgEERDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 13:03:25 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B16AC061A0F;
        Tue,  5 May 2020 10:03:25 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i68so2569274qtb.5;
        Tue, 05 May 2020 10:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=F8F8bzNlpzN6oJWmUcTLbx9MTKOgobYXMqZrgiO3eU8=;
        b=oHLr6bBm4X2Z8gdqb6WxXF30Muajj7pEaD8OdPqSuUU5yNyE2V1n6UcL0r5w4aKa7F
         0S4A4MZxARYWQGLWWJsOflyIZsAzwq5ONnbtdthGMIIj2kCjFP3yid8AbxItzRGSlt4s
         qrjtK+LRIDj91x18EyO7i0cDJmJHNh5riZ+BZbMecgyAoZ8E/VCafbOtzU/ZcZwPqLGo
         P4YCn+L/nUU08I7fZQkssnjKA9hh1xyNuIIm1YnDS0jBXxrPLD9AWupuiXN7nDKOo93k
         Vr6NYKHh8fR7ssasumurUX/bZw7zqhBVZzVDyyJCGrvSETXkxvGIPuM3P9tQgHpeuWTB
         Pp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=F8F8bzNlpzN6oJWmUcTLbx9MTKOgobYXMqZrgiO3eU8=;
        b=TMgwQo/9XGFy8/R2h3CIO5hF8j34WeUgICyiq5fmkJF9u9HYZTwtdQz32l2qBwxmGz
         kW/A2WHPPmqdkCZfDvhEnV53nJFNRJDkDTbj3m9+1tivkUVoeDzFt2uXy0ncKxwYVf/k
         o0hKUXWW7yqIGbFC9ovHCiW8rVf1NW7Uw364Ch7s0jJ3p0MheDirVR82UPR2tVo5Cb/W
         Lsz1dV3+4m8b9K4DOEGPdEcMaMekXf4UWZlIDsu/jlrk5xzdR17ywH6F9k7PuQWcEAwY
         mOz9jImi/KcaOTAtogG5jnKPofjSZ+bsqXloIShhBl8tZ1DVE2xkCNOhKkDX2HubsC+E
         c/Xg==
X-Gm-Message-State: AGi0PuZOflXw6PEkpvAqRRHUYvxZLJDUECSrgYOEvJhrd7T2a2i9iBfJ
        3xn9H1BqIZj2xBf+oHi7E9A=
X-Google-Smtp-Source: APiQypLwgTrB5jePiC42F/GW9HpLWSfHXoh9PMC9244arn/tQP7qgGkR5we094iayNsZldJGFqQXpw==
X-Received: by 2002:ac8:4e86:: with SMTP id 6mr3604724qtp.37.1588698204311;
        Tue, 05 May 2020 10:03:24 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id o33sm2300452qtj.62.2020.05.05.10.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 10:03:23 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D0484409A3; Tue,  5 May 2020 14:03:20 -0300 (-03)
Date:   Tue, 5 May 2020 14:03:20 -0300
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andreas Gerstmayr <agerstmayr@redhat.com>,
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
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20200505170320.GZ30487@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
 <20200422120943.GA110748@gmail.com>
 <CAEUSe7_wmKS361mKLTB1eYbzYXcKkXdU26BX5BojdKRz8MfPCw@mail.gmail.com>
 <20200424130722.GK19437@kernel.org>
 <0f6403ec-36cd-f43f-b3a6-b87e628f3789@redhat.com>
 <CAEUSe7_Ybp=7XC-2xMSEGYmCHvEMff0YbZq1f6akvxLVcS_ePA@mail.gmail.com>
 <20200505163745.GD3777@redhat.com>
 <CAEUSe7-0gXZ4M+dK_ur7J9J01ParcqkkUw=aGE552fDGHcnjUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUSe7-0gXZ4M+dK_ur7J9J01ParcqkkUw=aGE552fDGHcnjUw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 05, 2020 at 11:57:18AM -0500, Daniel Díaz escreveu:
> Hello!
> 
> On Tue, 5 May 2020 at 11:37, Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Mon, May 04, 2020 at 02:07:56PM -0500, Daniel Díaz escreveu:
> > > Hello!
> > >
> > > On Fri, 24 Apr 2020 at 09:10, Andreas Gerstmayr <agerstmayr@redhat.com> wrote:
> > > >
> > > > On 24.04.20 15:07, Arnaldo Carvalho de Melo wrote:
> > > > > Em Thu, Apr 23, 2020 at 04:28:46PM -0500, Daniel Díaz escreveu:
> > > > >> On Wed, 22 Apr 2020 at 07:09, Ingo Molnar <mingo@kernel.org> wrote:
> > > > >>>>   85 files changed, 1851 insertions(+), 513 deletions(-)
> > > > >
> > > > >>> Pulled, thanks a lot Arnaldo!
> > > > >
> > > > >> Our OpenEmbedded builds detected an issue with 5287f9269206 ("perf
> > > > >> script: Add flamegraph.py script"):
> > > > >>    ERROR: perf-1.0-r9 do_package_qa: QA Issue:
> > > > >> /usr/libexec/perf-core/scripts/python/bin/flamegraph-report contained
> > > > >> in package perf-python requires /usr/bin/sh, but no providers found in
> > > > >> RDEPENDS_perf-python? [file-rdeps]
> > > > >
> > > > >
> > > > > yeah, the flamegraph scripts are the outliers, there, everything else is
> > > > > using /bin/bash, so I'll switch to that, ok Andreas?
> > > >
> > > > Sure, no problem. Thanks!
> > >
> > > Just a gentle reminder that this can still be fixed in today's
> > > linux-next tree (next-20200504).
> >
> > Thanks for the reminder, I've just added this to my tree:
> >
> > commit c74ab13a30d3bec443c116e25b611255c58f32c0
> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date:   Tue May 5 13:33:12 2020 -0300
> >
> >     perf flamegraph: Use /bin/bash for report script
> >
> >     As all the other tools/perf/scripts/python/bin/*-report scripts, fixing
> >     the this problem reported by Daniel Diaz:
> >
> >       Our OpenEmbedded builds detected an issue with 5287f9269206 ("perf
> >       script: Add flamegraph.py script"):
> >         ERROR: perf-1.0-r9 do_package_qa: QA Issue:
> >       /usr/libexec/perf-core/scripts/python/bin/flamegraph-report contained
> >       in package perf-python requires /usr/bin/sh, but no providers found in
> >       RDEPENDS_perf-python? [file-rdeps]
> >
> >       This means that there is a new binary pulled in in the shebang line
> >       which was unaccounted for: `/usr/bin/sh`. I don't see any other usage
> >       of /usr/bin/sh in the kernel tree (does not even exist on my Ubuntu
> >       dev machine) but plenty of /bin/sh. This patch is needed:
> >       -----8<----------8<----------8<-----
> >       diff --git a/tools/perf/scripts/python/bin/flamegraph-record
> >       b/tools/perf/scripts/python/bin/flamegraph-record
> >       index 725d66e71570..a2f3fa25ef81 100755
> >       --- a/tools/perf/scripts/python/bin/flamegraph-record
> >       +++ b/tools/perf/scripts/python/bin/flamegraph-record
> >       @@ -1,2 +1,2 @@
> >       -#!/usr/bin/sh
> >       +#!/bin/sh
> >        perf record -g "$@"
> >       diff --git a/tools/perf/scripts/python/bin/flamegraph-report
> >       b/tools/perf/scripts/python/bin/flamegraph-report
> >       index b1a79afd903b..b0177355619b 100755
> >       --- a/tools/perf/scripts/python/bin/flamegraph-report
> >       +++ b/tools/perf/scripts/python/bin/flamegraph-report
> >       @@ -1,3 +1,3 @@
> >       -#!/usr/bin/sh
> >       +#!/bin/sh
> >        # description: create flame graphs
> >        perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
> >       ----->8---------->8---------->8-----
> >
> >     Fixes: 5287f9269206 ("perf script: Add flamegraph.py script")
> >     Reported-by: Daniel Díaz <daniel.diaz@linaro.org>
> >     Cc: Adrian Hunter <adrian.hunter@intel.com>
> >     Cc: Andreas Gerstmayr <agerstmayr@redhat.com>
> >     Cc: Jiri Olsa <jolsa@kernel.org>
> >     Cc: lkft-triage@lists.linaro.org
> >     Cc: Namhyung Kim <namhyung@kernel.org>
> >     Link: http://lore.kernel.org/lkml/CAEUSe7_wmKS361mKLTB1eYbzYXcKkXdU26BX5BojdKRz8MfPCw@mail.gmail.com
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > diff --git a/tools/perf/scripts/python/bin/flamegraph-report b/tools/perf/scripts/python/bin/flamegraph-report
> > index b1a79afd903b..53c5dc90c87e 100755
> > --- a/tools/perf/scripts/python/bin/flamegraph-report
> > +++ b/tools/perf/scripts/python/bin/flamegraph-report
> > @@ -1,3 +1,3 @@
> > -#!/usr/bin/sh
> > +#!/bin/bash
> >  # description: create flame graphs
> >  perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
> 
> What about flamegraph-record?

oops, make that this instead:


commit b3a63d0c17e6e1d23a6b44502b55f066adfd8e6a
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Tue May 5 13:33:12 2020 -0300

    perf flamegraph: Use /bin/bash for report and record scripts
    
    As all the other tools/perf/scripts/python/bin/*-{report,record}
    scripts, fixing the this problem reported by Daniel Diaz:
    
      Our OpenEmbedded builds detected an issue with 5287f9269206 ("perf
      script: Add flamegraph.py script"):
        ERROR: perf-1.0-r9 do_package_qa: QA Issue:
      /usr/libexec/perf-core/scripts/python/bin/flamegraph-report contained
      in package perf-python requires /usr/bin/sh, but no providers found in
      RDEPENDS_perf-python? [file-rdeps]
    
      This means that there is a new binary pulled in in the shebang line
      which was unaccounted for: `/usr/bin/sh`. I don't see any other usage
      of /usr/bin/sh in the kernel tree (does not even exist on my Ubuntu
      dev machine) but plenty of /bin/sh. This patch is needed:
      -----8<----------8<----------8<-----
      diff --git a/tools/perf/scripts/python/bin/flamegraph-record
      b/tools/perf/scripts/python/bin/flamegraph-record
      index 725d66e71570..a2f3fa25ef81 100755
      --- a/tools/perf/scripts/python/bin/flamegraph-record
      +++ b/tools/perf/scripts/python/bin/flamegraph-record
      @@ -1,2 +1,2 @@
      -#!/usr/bin/sh
      +#!/bin/sh
       perf record -g "$@"
      diff --git a/tools/perf/scripts/python/bin/flamegraph-report
      b/tools/perf/scripts/python/bin/flamegraph-report
      index b1a79afd903b..b0177355619b 100755
      --- a/tools/perf/scripts/python/bin/flamegraph-report
      +++ b/tools/perf/scripts/python/bin/flamegraph-report
      @@ -1,3 +1,3 @@
      -#!/usr/bin/sh
      +#!/bin/sh
       # description: create flame graphs
       perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
      ----->8---------->8---------->8-----
    
    Fixes: 5287f9269206 ("perf script: Add flamegraph.py script")
    Reported-by: Daniel Díaz <daniel.diaz@linaro.org>
    Acked-by: Andreas Gerstmayr <agerstmayr@redhat.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: lkft-triage@lists.linaro.org
    Cc: Namhyung Kim <namhyung@kernel.org>
    Link: http://lore.kernel.org/lkml/CAEUSe7_wmKS361mKLTB1eYbzYXcKkXdU26BX5BojdKRz8MfPCw@mail.gmail.com
    Link: http://lore.kernel.org/lkml/20200505163745.GD3777@redhat.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/scripts/python/bin/flamegraph-record b/tools/perf/scripts/python/bin/flamegraph-record
index 725d66e71570..7df5a19c0163 100755
--- a/tools/perf/scripts/python/bin/flamegraph-record
+++ b/tools/perf/scripts/python/bin/flamegraph-record
@@ -1,2 +1,2 @@
-#!/usr/bin/sh
+#!/bin/bash
 perf record -g "$@"
diff --git a/tools/perf/scripts/python/bin/flamegraph-report b/tools/perf/scripts/python/bin/flamegraph-report
index b1a79afd903b..53c5dc90c87e 100755
--- a/tools/perf/scripts/python/bin/flamegraph-report
+++ b/tools/perf/scripts/python/bin/flamegraph-report
@@ -1,3 +1,3 @@
-#!/usr/bin/sh
+#!/bin/bash
 # description: create flame graphs
 perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
