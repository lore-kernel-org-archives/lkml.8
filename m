Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E53C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97CF720801
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591882844;
	bh=v4wmRhrIbViBXuqcYFEF2MAIeMfjgQ45EmzglK/iPn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=huYQaC/DhCCTGvSFeZVWD83S0wOE5TFgvxHIdHN4QIGS2c8AiJcBWeLF/kPQHSWZm
	 LW0XeulKNz92sAaOIoDi22t/tVCNdWuJBk8yctAv3GEBue78+R7blDHLQDgcM1qNoe
	 AMjQ8rvLycoWgF2ElIiqZqa7Ecu4SRWkOEVo/hG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgFKNkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:40:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgFKNkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:40:42 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49CEB207ED;
        Thu, 11 Jun 2020 13:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591882841;
        bh=v4wmRhrIbViBXuqcYFEF2MAIeMfjgQ45EmzglK/iPn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zDlgGzrIe7YcheaU7lKoEKNdJ7/Nkp56VYHG4aBybcfbLgBoClkZCwmj+UaWC4Htu
         dWP/bJL425a+ZckWosw+0a2uq4ZNaJigRtgeybwj9Ehst+awHiz1rczc3y61PCkj+1
         TghDD3rk+YN5q6oZTBtmNi3Yqzc+ehHYNltcJetY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E361140AFD; Thu, 11 Jun 2020 10:40:38 -0300 (-03)
Date:   Thu, 11 Jun 2020 10:40:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20200611134038.GE18482@kernel.org>
References: <20200610215100.256599-1-irogers@google.com>
 <20200611090249.GC1786122@krava>
 <20200611130758.GA18482@kernel.org>
 <20200611133854.GD18482@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611133854.GD18482@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 11, 2020 at 10:38:54AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Jun 11, 2020 at 10:07:58AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Jun 11, 2020 at 11:02:49AM +0200, Jiri Olsa escreveu:
> > > On Wed, Jun 10, 2020 at 02:50:50PM -0700, Ian Rogers wrote:
> > > > All C compiler warnings are disabled are disabled by -w. This change
> > > > removes the -w from flex and bison targets. To avoid implicit
> > > > declarations header files are declared as targets and included.
> > > > 
> > > > Tested with GCC 9.3.0 and clang 9.0.1.
> > > > 
> > > > Previously posted as a single change:
> > > > https://lore.kernel.org/lkml/20200609234344.3795-2-irogers@google.com/
> > > > 
> > > > Ian Rogers (10):
> > > >   perf parse-events: Use automatic variable for flex input
> > > >   perf parse-events: Use automatic variable for yacc input
> > > >   perf pmu: Add bison debug build flag
> > > >   perf pmu: Add flex debug build flag
> > > >   perf parse-events: Declare flex header file output
> > > >   perf parse-events: Declare bison header file output
> > > >   perf parse-events: Disable a subset of flex warnings
> > > >   perf expr: Avoid implicit lex function declaration
> > > >   perf parse-events: Avoid implicit lex function declaration
> > > >   perf parse-events: Disable a subset of bison warnings
> > > 
> > > looks great, I wonder what the -w replacement will do in
> > > Arnaldo's distro test, but it'd be nice to get rid it
> > > 
> > > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > 
> > Thanks, applied locally and will submit it to the test build suite.
> 
> Failed so far for, I'll leave it running, its a holiday here today, so
> I'll be on this occasionally, please look until the end of the (long)
> message, there are errors for more distros, some are, as expected the
> same, but should give a good idea of some extra fixes needed.
> 


  24  debian:9                      : FAIL gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516, clang version 3.8.1-24 (tags/RELEASE_381/final)

  FLEX     /tmp/build/perf/util/pmu-flex.c
  CC       /tmp/build/perf/util/pmu-bison.o
  FLEX     /tmp/build/perf/util/expr-flex.c
  FLEX     /tmp/build/perf/util/expr-flex.h
  CC       /tmp/build/perf/util/parse-events.o
  CC       /tmp/build/perf/util/parse-events-flex.o
  CC       /tmp/build/perf/util/pmu.o
  CC       /tmp/build/perf/util/pmu-flex.o
/tmp/build/perf/util/parse-events-flex.c: In function 'yy_get_next_buffer':
/tmp/build/perf/util/parse-events-flex.c:4717:18: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
   for ( n = 0; n < max_size && \
                  ^
/tmp/build/perf/util/parse-events-flex.c:5656:3: note: in expansion of macro 'YY_INPUT'
   YY_INPUT( (&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[number_to_move]),
   ^~~~~~~~
/tmp/build/perf/util/pmu-flex.c: In function 'yy_get_next_buffer':
/tmp/build/perf/util/pmu-flex.c:608:18: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
   for ( n = 0; n < max_size && \
                  ^
/tmp/build/perf/util/pmu-flex.c:1058:3: note: in expansion of macro 'YY_INPUT'
   YY_INPUT( (&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[number_to_move]),
   ^~~~~~~~
  CC       /tmp/build/perf/util/expr-flex.o
/tmp/build/perf/util/expr-flex.c: In function 'yy_get_next_buffer':
/tmp/build/perf/util/expr-flex.c:711:18: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
   for ( n = 0; n < max_size && \
                  ^
/tmp/build/perf/util/expr-flex.c:1241:3: note: in expansion of macro 'YY_INPUT'
   YY_INPUT( (&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[number_to_move]),
   ^~~~~~~~
  CC       /tmp/build/perf/util/expr-bison.o
  CC       /tmp/build/perf/util/expr.o
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/util/.pmu-flex.o.tmp': No such file or directory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/util/pmu-flex.o' failed
make[4]: *** [/tmp/build/perf/util/pmu-flex.o] Error 1
make[4]: *** Waiting for unfinished jobs...


debian:10 is going well so far, some of the builds passed

