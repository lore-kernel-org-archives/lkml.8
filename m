Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ED2C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA5F20665
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxMLeiDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCFUHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 15:07:01 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38812 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgCFUHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:07:01 -0500
Received: by mail-qt1-f195.google.com with SMTP id e20so2666235qto.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 12:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tumBKI9yVzN59CwN6KRd5qTkqT9FDeQLZPxMiIooXfw=;
        b=JxMLeiDA+QDFWhiA44Xqh7s/DPLKA+ixgXDAN38CcnbQqRTj9aoqHZQhF4oC+DKYp0
         +xi179fLXwrmfORlNLNLbz1uy4Ob/0XCB2lPDQ7yBPbjY6HU5PUnMwXtDF3qLjn4GPtM
         zKXIVsuc15A8t5djzRDtasWu1nDg0bX7xFbNJ3AMifly0MU9pjADD9OQRB3i/ATRKxo+
         ktAuYMdq6liJdwBc9YJUrwtgOpjCldCU03XSb0l+ZtskruLc5XMGQgn8U1oUJi8zZSCY
         2peLBVdLGR8egcCJ5XikHIRUC57P4ZDF6v5j027yVJDOX1WTHxFqFEu3Ez+Fwx8+kQwE
         ZK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tumBKI9yVzN59CwN6KRd5qTkqT9FDeQLZPxMiIooXfw=;
        b=gvhLJoigNMOX5WnQwf+WSvvthkg+mVXl75D7dQCH9z+GwL/M6WcZtJWUkhyhF5Wlaa
         rB5Oz3E1qtA1QY+W57UEBUl6ESTUwjke5AjxehnNoMb8Qmqb/BDL9CEoILu3FefLFPiu
         II4id2r9+Gnzzi+NspuK3xJm4vzYKWNf3yLJGo7TB8p/24LYvoHoANwH3BFG/Tk1vZhb
         iRAXYhR1X4Vw5pi1pDzIgtorssYXRMQJWexWpb7RP046ITuYWXTfURXWq+dv9RYYPBvx
         SSuxauy+UStB7fIs59a8e3oEACHD5YespNHei9h3qofSmkALq+gebOZ74j/hBGKFINLk
         7Oxw==
X-Gm-Message-State: ANhLgQ0MW4yvrxXzIbv384wjO9/IEtKk8QKRPM+YS1OHqxlsZ7Zy38u5
        LNnpYX5rfSUVlNIX+ZRm+N0=
X-Google-Smtp-Source: ADFU+vvNbi04ZzIcniVGZc8wrcVQFdlk64doUw63GF0PkiF8Mk1KcKWRtp9qZzurT7/RtftgB917fw==
X-Received: by 2002:aed:2202:: with SMTP id n2mr4782327qtc.4.1583525220501;
        Fri, 06 Mar 2020 12:07:00 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id r127sm1012846qkf.90.2020.03.06.12.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 12:06:59 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 85611403AD; Fri,  6 Mar 2020 17:06:57 -0300 (-03)
Date:   Fri, 6 Mar 2020 17:06:57 -0300
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, ravi.bangoria@linux.ibm.com,
        alexey.budankov@linux.intel.com, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, mpe@ellerman.id.au, eranian@google.com,
        ak@linux.intel.com
Subject: Re: [PATCH 00/12] Stitch LBR call stack (Perf Tools)
Message-ID: <20200306200657.GA13774@kernel.org>
References: <20200228163011.19358-1-kan.liang@linux.intel.com>
 <20200306093940.GD281906@krava>
 <243484a9-5d64-707e-4abb-dd8813a8755e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <243484a9-5d64-707e-4abb-dd8813a8755e@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 06, 2020 at 02:13:15PM -0500, Liang, Kan escreveu:
> 
> 
> On 3/6/2020 4:39 AM, Jiri Olsa wrote:
> > On Fri, Feb 28, 2020 at 08:29:59AM -0800, kan.liang@linux.intel.com wrote:
> > 
> > SNIP
> > 
> > > Kan Liang (12):
> > >    perf tools: Add hw_idx in struct branch_stack
> > >    perf tools: Support PERF_SAMPLE_BRANCH_HW_INDEX
> > >    perf header: Add check for event attr
> > >    perf pmu: Add support for PMU capabilities
> > 
> > hi,
> > I'm getting compile error:
> > 
> > 	util/pmu.c: In function ‘perf_pmu__caps_parse’:
> > 	util/pmu.c:1620:32: error: ‘%s’ directive output may be truncated writing up to 255 bytes into a region of size between 0 and 4095 [-Werror=format-truncation=]
> > 	 1620 |   snprintf(path, PATH_MAX, "%s/%s", caps_path, name);
> > 	      |                                ^~
> > 	In file included from /usr/include/stdio.h:867,
> > 			 from util/pmu.c:12:
> > 	/usr/include/bits/stdio2.h:67:10: note: ‘__builtin___snprintf_chk’ output between 2 and 4352 bytes into a destination of size 4096
> > 	   67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
> > 	      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 	   68 |        __bos (__s), __fmt, __va_arg_pack ());
> > 	      |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 	cc1: all warnings being treated as errors
> > 
> > 	[jolsa@krava perf]$ gcc --version
> > 	gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1)
> 
> My GCC version is too old. I will send V2 later to fix the error.

So, Jiri asked me to push my perf/core, which I did, please refresh from
there,

Right now it is at:

[acme@quaco perf]$ git log --oneline -10
c45c91f6161c (HEAD -> perf/core, seventh/perf/core, acme/perf/core, acme.korg/perf/core) perf evsel: Support PERF_SAMPLE_BRANCH_HW_INDEX
1fa65c5092da perf tools: Add hw_idx in struct branch_stack
6339998d22ec tools headers UAPI: Update tools's copy of linux/perf_event.h
401d61cbd4d4 tools lib traceevent: Remove extra '\n' in print_event_time()
76ce02651dab libperf: Add counting example
dabce16bd292 perf annotate: Get rid of annotation->nr_jumps
357a5d24c471 perf llvm: Add debug hint message about missing kernel-devel package
1af62ce61cd8 perf stat: Show percore counts in per CPU output
7982a8985150 tools lib api fs: Move cgroupsfs_find_mountpoint()
d46eec8e975a Merge remote-tracking branch 'acme/perf/urgent' into perf/core
[acme@quaco perf]$

Repository:

git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git

Branch:

perf/core

Thanks,

- Arnaldo
