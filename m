Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC1CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 11:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12B3E206F7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 11:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592567418;
	bh=Goi121aY1F4zm/pak2cED1OLu8+EAtgdXRzX4571d5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=09II5vcGNztGPC6w6NKC6WNsx0fR9KY9NzB1hnqn5T0ZwYelt57AfNMZC4P+xxHO3
	 rYvVkcGZ4fk2qSRuhVY+OiZijjWZuPIxSWrUn5reCg0skPvhOeHScQFZCmWSMMKid0
	 HUQ8AsgfRID0zz9xz4hJ53dAERP8wyTf6UQaIy/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732756AbgFSLuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 07:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730957AbgFSLuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 07:50:14 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.140.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2A392080C;
        Fri, 19 Jun 2020 11:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592567413;
        bh=Goi121aY1F4zm/pak2cED1OLu8+EAtgdXRzX4571d5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qy82VyxPlMDK86uivpOaP7bLTyXcUh1ZRQhPyOJQi0DduOsitOToxrTWQiUfqXmmz
         emgkgzRJdO0oaNqgohKdArsHBdoVzGM2fIXbcAsWOPUUa5pvH17dmLXrdAlyyq1Pwr
         rMUmsP/bCCuWj+YKu2V91KWbdCsVvw117EcMTHhw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 802E4405FF; Fri, 19 Jun 2020 08:50:11 -0300 (-03)
Date:   Fri, 19 Jun 2020 08:50:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 00/10] perf parse-events: enable more flex/bison
 warnings
Message-ID: <20200619115011.GB12579@kernel.org>
References: <20200619043356.90024-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619043356.90024-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 18, 2020 at 09:33:46PM -0700, Ian Rogers escreveu:
> All C compiler warnings are disabled are disabled by -w. This change
> removes the -w from flex and bison targets. To avoid implicit
> declarations header files are declared as targets and included.
> 
> Tested with GCC 9.3.0 and clang 9.0.1.
> 
> v2. predicates disabling the warnings on more recent bison and flex
>     versions (3.5.3 and 2.6.4 respectively). An alternative would be
>     to disabled a large number of warnings to cover the warnings
>     generated in older distributions:
>   flex_flags := -Wno-switch-enum -Wno-switch-default -Wno-unused-function \
>     -Wno-redundant-decls -Wno-sign-compare -Wno-unused-parameter \
>     -Wno-missing-prototypes -Wno-misleading-indentation
>   bison_flags := -DYYENABLE_NLS=0 -Wno-unused-parameter -Wno-nested-externs \
>     -Wno-implicit-function-declaration -Wno-switch-enum
> 
> Previously posted as a single change:
> https://lore.kernel.org/lkml/20200609234344.3795-2-irogers@google.com/

So for the parts that you kept unchanged since Jiri acked it, please
next time collect that Acked-by, ok?

Going thru this now.

- Arnaldo
 
> Ian Rogers (10):
>   perf parse-events: Use automatic variable for flex input
>   perf parse-events: Use automatic variable for yacc input
>   perf pmu: Add bison debug build flag
>   perf pmu: Add flex debug build flag
>   perf parse-events: Declare flex header file output
>   perf parse-events: Declare bison header file output
>   perf parse-events: Disable a subset of flex warnings
>   perf expr: Avoid implicit lex function declaration
>   perf parse-events: Avoid implicit lex function declaration
>   perf parse-events: Disable a subset of bison warnings
> 
>  tools/perf/util/Build          | 62 +++++++++++++++++++++++-----------
>  tools/perf/util/expr.y         |  2 ++
>  tools/perf/util/parse-events.y |  1 +
>  3 files changed, 46 insertions(+), 19 deletions(-)
> 
> -- 
> 2.27.0.111.gc72c7da667-goog
> 

-- 

- Arnaldo
