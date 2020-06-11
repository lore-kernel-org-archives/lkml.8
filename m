Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48700C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17C4B20801
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591881219;
	bh=LvHxTVUZLcCdTOqD3NyClQZQUnr+LT0UqYRACkbjX0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x18AY7F37Yr9bSw/gVGFExY4xwe93nKX4WeoPKhEEn6Y+ZzxPUlPrd4O+BjoxttlZ
	 BSq1Mk29jZi9AdJcYHkyDErwRsbCgbHYleCJ2dGJNem+MtySiAzD+r+T3SIR8dT8nz
	 fHAF7NBiLOyxqVc8aehGQEesXRLmpj+dlNXFR3Lo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgFKNNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:13:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgFKNNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:13:37 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50A4820691;
        Thu, 11 Jun 2020 13:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591881216;
        bh=LvHxTVUZLcCdTOqD3NyClQZQUnr+LT0UqYRACkbjX0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hj35WvMgwwVQrDc6gxUkhrsZm/+TztaGf7WC4ZrNpWce2tgRLP/av+VMf2CiWLsfP
         TZyQf401G9hCjDD/t/FSST4Ksy2/xL0nJ5jk8w2LJKVf8nwkSBJ1qH3TXDxTZAvyAX
         jnsXZFqXmd/9835jC1ZZ3w0nfC8a+qBTH/u/eB14=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C55E640AFD; Thu, 11 Jun 2020 10:07:58 -0300 (-03)
Date:   Thu, 11 Jun 2020 10:07:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 00/10] perf parse-events: enable more flex/bison warnings
Message-ID: <20200611130758.GA18482@kernel.org>
References: <20200610215100.256599-1-irogers@google.com>
 <20200611090249.GC1786122@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611090249.GC1786122@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 11, 2020 at 11:02:49AM +0200, Jiri Olsa escreveu:
> On Wed, Jun 10, 2020 at 02:50:50PM -0700, Ian Rogers wrote:
> > All C compiler warnings are disabled are disabled by -w. This change
> > removes the -w from flex and bison targets. To avoid implicit
> > declarations header files are declared as targets and included.
> > 
> > Tested with GCC 9.3.0 and clang 9.0.1.
> > 
> > Previously posted as a single change:
> > https://lore.kernel.org/lkml/20200609234344.3795-2-irogers@google.com/
> > 
> > Ian Rogers (10):
> >   perf parse-events: Use automatic variable for flex input
> >   perf parse-events: Use automatic variable for yacc input
> >   perf pmu: Add bison debug build flag
> >   perf pmu: Add flex debug build flag
> >   perf parse-events: Declare flex header file output
> >   perf parse-events: Declare bison header file output
> >   perf parse-events: Disable a subset of flex warnings
> >   perf expr: Avoid implicit lex function declaration
> >   perf parse-events: Avoid implicit lex function declaration
> >   perf parse-events: Disable a subset of bison warnings
> 
> looks great, I wonder what the -w replacement will do in
> Arnaldo's distro test, but it'd be nice to get rid it
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied locally and will submit it to the test build suite.

- Arnaldo
 
> thanks,
> jirka
> 
> > 
> >  tools/perf/util/Build          | 50 +++++++++++++++++++++-------------
> >  tools/perf/util/expr.y         |  2 ++
> >  tools/perf/util/parse-events.y |  1 +
> >  3 files changed, 34 insertions(+), 19 deletions(-)
> > 
> > -- 
> > 2.27.0.278.ge193c7cf3a9-goog
> > 
> 

-- 

- Arnaldo
