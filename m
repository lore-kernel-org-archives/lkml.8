Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F7CC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87EE820728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coyeLHGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgDXNHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgDXNHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:07:30 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFA9C09B045;
        Fri, 24 Apr 2020 06:07:26 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i68so7766084qtb.5;
        Fri, 24 Apr 2020 06:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BACYUJ9Ax+sBOclJuw9FAWOKwxhj77NX+HwVzCYrlHM=;
        b=coyeLHGpucDw6yi+Off2lRApXRS1LjvxqhlYhjZsq6sLUAaRN51RWLqS/FR/OhdbmE
         1b73C8+Awp/J/uj9LneKItox7/SohZdVNhYWUOzvcp/fxyAGUkFZc72GiNvdlT9CUcaI
         xCz2gqtnU+cyjjWj/mDN8J8gqXUao+SojW2iyvuAatrlAfz0r6O8zOIglEk9hO/sRou9
         pWFCdPRMx5HtFyS0wt7MVW5ZndlR2tMUAK8XMi2v3D9WzGaiVvdTtw9tfbZK/F4IEY3U
         P76gS7hi5aPfeaURB71T2Yo+l4dtomBQ80CJnIvNyLfeCh1n0y0tV0TUvQWmP/JKr8LY
         4p9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BACYUJ9Ax+sBOclJuw9FAWOKwxhj77NX+HwVzCYrlHM=;
        b=e0L74BhqPqildaRGGZaxZpNJ0mS3Wv+UkixunThJXIpkph9UFplrVnaib7JrxjLTWA
         7V/+x/Pcd3c1Abw69MfgW/xTVATygqysklnhrNUg0NGeCR20ZgBjrlwe/ER33Jx+eSwX
         S9/1Jh0Lrx72Jo8ZW072MajsiRlMpwK99XhHkAGiibgJuRvF4x7u966V80b3HdvNIetH
         0quORGWiBA6fHOmd3u+CowGDjhlGd+Noin6Bppul+ykbM9GiS3SJa0E5lLRBmLOo7Bsi
         90kyVKGpkEg37Snn1+E5Tedbs/QJFlI15wnIve/wP+b9wv7Vy9NKREfdxj4iRSbQt/0i
         KO7w==
X-Gm-Message-State: AGi0PuY8wcCmbhBj5IhMQcBwKYzBAgD3y81NZX9pvHJ3Kw/PqdDfrmnV
        7rUrVz2d/DlPfA4OB0/6dKc=
X-Google-Smtp-Source: APiQypJ+3c5kEBO5ugffa6QVDGTNi9ZLDOCvhGzzzAOy33soM3OcWCZrZcABYpk4Rtlj+w/RtvmuxA==
X-Received: by 2002:ac8:1090:: with SMTP id a16mr9406411qtj.181.1587733645527;
        Fri, 24 Apr 2020 06:07:25 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id y52sm3804398qth.38.2020.04.24.06.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 06:07:24 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4AF2D409A3; Fri, 24 Apr 2020 10:07:22 -0300 (-03)
Date:   Fri, 24 Apr 2020 10:07:22 -0300
To:     Andreas Gerstmayr <agerstmayr@redhat.com>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
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
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkft-triage@lists.linaro.org
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20200424130722.GK19437@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
 <20200422120943.GA110748@gmail.com>
 <CAEUSe7_wmKS361mKLTB1eYbzYXcKkXdU26BX5BojdKRz8MfPCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUSe7_wmKS361mKLTB1eYbzYXcKkXdU26BX5BojdKRz8MfPCw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 23, 2020 at 04:28:46PM -0500, Daniel Díaz escreveu:
> On Wed, 22 Apr 2020 at 07:09, Ingo Molnar <mingo@kernel.org> wrote:
> > >  85 files changed, 1851 insertions(+), 513 deletions(-)

> > Pulled, thanks a lot Arnaldo!
 
> Our OpenEmbedded builds detected an issue with 5287f9269206 ("perf
> script: Add flamegraph.py script"):
>   ERROR: perf-1.0-r9 do_package_qa: QA Issue:
> /usr/libexec/perf-core/scripts/python/bin/flamegraph-report contained
> in package perf-python requires /usr/bin/sh, but no providers found in
> RDEPENDS_perf-python? [file-rdeps]


yeah, the flamegraph scripts are the outliers, there, everything else is
using /bin/bash, so I'll switch to that, ok Andreas?

[acme@quaco perf]$ vim tools/perf/scripts/python/bin/*
34 files to edit
[acme@quaco perf]$ head -1 tools/perf/scripts/python/bin/*
==> tools/perf/scripts/python/bin/compaction-times-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/compaction-times-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/event_analyzing_sample-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/event_analyzing_sample-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/export-to-postgresql-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/export-to-postgresql-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/export-to-sqlite-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/export-to-sqlite-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/failed-syscalls-by-pid-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/failed-syscalls-by-pid-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/flamegraph-record <==
#!/usr/bin/sh

==> tools/perf/scripts/python/bin/flamegraph-report <==
#!/usr/bin/sh

==> tools/perf/scripts/python/bin/futex-contention-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/futex-contention-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/intel-pt-events-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/intel-pt-events-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/mem-phys-addr-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/mem-phys-addr-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/netdev-times-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/netdev-times-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/net_dropmonitor-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/net_dropmonitor-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/powerpc-hcalls-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/powerpc-hcalls-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/sched-migration-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/sched-migration-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/sctop-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/sctop-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/stackcollapse-record <==
#!/bin/sh

==> tools/perf/scripts/python/bin/stackcollapse-report <==
#!/bin/sh

==> tools/perf/scripts/python/bin/syscall-counts-by-pid-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/syscall-counts-by-pid-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/syscall-counts-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/syscall-counts-report <==
#!/bin/bash
[acme@quaco perf]$
