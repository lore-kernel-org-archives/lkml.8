Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3A1C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1784220746
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PJ+S5nHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbgEEQiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 12:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbgEEQiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:38:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2173AC061A0F;
        Tue,  5 May 2020 09:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=y7yq0XdDHvHmtj9MaLNUjkmFFQ9+bgFTYTDYA/E7uGw=; b=PJ+S5nHNXYFjBh5XG85gs5Xg5W
        bbI4vxmLMkxJBdXvmEygmrSzaliEsK1es2k/y0l9+u2YMdCjYeHWPcCLxSg7Tii9fePSmYIyww8wm
        rbEvi+XorLY5GHz8uv2/8/krcL3mEj5THMW03gQlfDV6tR2NTWWhyJB6FcLYOC1qU4peqFrSry8gm
        RF9xy5u1RSgxyI7jRl5APpxmR6JdtTVZa+QPT6FJamZsY8OV7zBOfb5/VI+X3cyggAVVps/Q8cPWf
        y6wKzqOAkMbYsfucq8JUrVWjCqrciJcFF5ABvQirYBzeGZbQWTtMXAkyHspTqETkqO9Un4k+BcPj3
        vvGhN+rQ==;
Received: from [179.97.37.151] (helo=sandy.ghostprotocols.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jW0Zp-0006h8-Nd; Tue, 05 May 2020 16:37:50 +0000
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id B04241B0; Tue,  5 May 2020 13:37:45 -0300 (BRT)
Date:   Tue, 5 May 2020 13:37:45 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
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
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20200505163745.GD3777@redhat.com>
References: <20200420115316.18781-1-acme@kernel.org>
 <20200422120943.GA110748@gmail.com>
 <CAEUSe7_wmKS361mKLTB1eYbzYXcKkXdU26BX5BojdKRz8MfPCw@mail.gmail.com>
 <20200424130722.GK19437@kernel.org>
 <0f6403ec-36cd-f43f-b3a6-b87e628f3789@redhat.com>
 <CAEUSe7_Ybp=7XC-2xMSEGYmCHvEMff0YbZq1f6akvxLVcS_ePA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUSe7_Ybp=7XC-2xMSEGYmCHvEMff0YbZq1f6akvxLVcS_ePA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 04, 2020 at 02:07:56PM -0500, Daniel Díaz escreveu:
> Hello!
> 
> On Fri, 24 Apr 2020 at 09:10, Andreas Gerstmayr <agerstmayr@redhat.com> wrote:
> >
> > On 24.04.20 15:07, Arnaldo Carvalho de Melo wrote:
> > > Em Thu, Apr 23, 2020 at 04:28:46PM -0500, Daniel Díaz escreveu:
> > >> On Wed, 22 Apr 2020 at 07:09, Ingo Molnar <mingo@kernel.org> wrote:
> > >>>>   85 files changed, 1851 insertions(+), 513 deletions(-)
> > >
> > >>> Pulled, thanks a lot Arnaldo!
> > >
> > >> Our OpenEmbedded builds detected an issue with 5287f9269206 ("perf
> > >> script: Add flamegraph.py script"):
> > >>    ERROR: perf-1.0-r9 do_package_qa: QA Issue:
> > >> /usr/libexec/perf-core/scripts/python/bin/flamegraph-report contained
> > >> in package perf-python requires /usr/bin/sh, but no providers found in
> > >> RDEPENDS_perf-python? [file-rdeps]
> > >
> > >
> > > yeah, the flamegraph scripts are the outliers, there, everything else is
> > > using /bin/bash, so I'll switch to that, ok Andreas?
> >
> > Sure, no problem. Thanks!
> 
> Just a gentle reminder that this can still be fixed in today's
> linux-next tree (next-20200504).

Thanks for the reminder, I've just added this to my tree:

commit c74ab13a30d3bec443c116e25b611255c58f32c0
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Tue May 5 13:33:12 2020 -0300

    perf flamegraph: Use /bin/bash for report script
    
    As all the other tools/perf/scripts/python/bin/*-report scripts, fixing
    the this problem reported by Daniel Diaz:
    
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
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Andreas Gerstmayr <agerstmayr@redhat.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: lkft-triage@lists.linaro.org
    Cc: Namhyung Kim <namhyung@kernel.org>
    Link: http://lore.kernel.org/lkml/CAEUSe7_wmKS361mKLTB1eYbzYXcKkXdU26BX5BojdKRz8MfPCw@mail.gmail.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/scripts/python/bin/flamegraph-report b/tools/perf/scripts/python/bin/flamegraph-report
index b1a79afd903b..53c5dc90c87e 100755
--- a/tools/perf/scripts/python/bin/flamegraph-report
+++ b/tools/perf/scripts/python/bin/flamegraph-report
@@ -1,3 +1,3 @@
-#!/usr/bin/sh
+#!/bin/bash
 # description: create flame graphs
 perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
