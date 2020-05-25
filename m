Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E720C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 782042073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590416586;
	bh=si05xKx2ayGiuMaa3p/hhp+LjCgDQcldQfzcnOm34uI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JINaNdgZ/l81H+xBOU9tWkRSD9mWCNPZBYMWufp9T40g+BqHFbOV67lKIM2sziekN
	 x70xz8EcJx9hfcv2rHvEbpWU9S4H1saH6p2247XroGPrCWJN7ZXxGMbQ4cUROl7MKJ
	 Jd/+rdEifSZK/p/KrP9CX20aK0TlVSF74JgMdYco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403964AbgEYOXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:23:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388714AbgEYOXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:23:05 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C9092071C;
        Mon, 25 May 2020 14:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590416584;
        bh=si05xKx2ayGiuMaa3p/hhp+LjCgDQcldQfzcnOm34uI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ft8UfmHxwSgWTAU8oeokB5qd9p5bARRU3idPeR75mBXvJoSIwO6kAxQJJK1P4TobB
         fHPFWwx3VFEHE/x784zVWf7FjtpXnN8AhJxdeZ7lsgfn96JIrsRyXKl3/Lr0o16MrJ
         g3EgyGVFpUMXy8rnDCpZUMdVn3B4LaHJK36PlVas=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 72DEA40AFD; Mon, 25 May 2020 11:23:00 -0300 (-03)
Date:   Mon, 25 May 2020 11:23:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC 00/14] perf tests: Check on subtest for user specified test
Message-ID: <20200525142300.GK14034@kernel.org>
References: <20200524224219.234847-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524224219.234847-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 25, 2020 at 12:42:05AM +0200, Jiri Olsa escreveu:
> hi,
> changes for using metric result in another metric seem
> to change lot of core metric code, so it's better we
> have some more tests before we do that.
> 
> Sending as RFC as it's still alive and you guys might
> have some other idea of how to do this.
> 
> Also available in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/fixes

I applied the first three patches, will wait a bit for Ian and others to
have some time to look at it, but one thing I thought was that instead
of having parse_state->fake_pmu as a bool, you could have it as a
pointer to the fake pmu, this way we would do away with that static
thing in the middle of the parsing code.

+static int check_id(const char *id)
+{
+	struct parse_events_error error;
+	struct evlist *evlist;
+	int ret;
+
+	/* Numbers are always valid. */
+	if (is_number(id))
+               return 0;
+
+	evlist = evlist__new();
+	if (!evlist)
+               return -1;
+
+	memset(&error, 0, sizeof(error));
+       ret = parse_events_fake(evlist, id, &error);
+       if (ret) {
+               pr_debug("str        : %s\n", error.str);
+               pr_debug("help       : %s\n", error.help);
+               pr_debug("first_str  : %s\n", error.first_str);
+               pr_debug("first_help : %s\n", error.first_help);
+       }
+
+       evlist__delete(evlist);
+       free(error.str);
+	free(error.help);
+       free(error.first_str);
+       free(error.first_help);
+	return ret;
+}


Would read:

	struct perf_pmu fake = { 0, };
	.
	.
	.
	ret = parse_events_fake_pmu(evlist, id, &fake, &error);
	.
	.
	.


That also renames parse_events_fake() to parse_events_fake_pmu().
 
> jirka
> 
> 
> ---
> Jiri Olsa (14):
>       perf tests: Check on subtest for user specified test
>       perf tools: Do not pass avg to generic_metric
>       perf tools: Add struct parse_events_state pointer to scanner
>       perf tools: Add fake pmu support
>       perf tools: Add parse_events_fake interface
>       perf tests: Add another pmu-events tests
>       perf tools: Factor out parse_groups function
>       perf tools: Add metricgroup__parse_groups_test function
>       perf tools: Add fake_pmu to parse_events function
>       perf tools: Add map to parse_events function
>       perf tools: Factor out prepare_metric function
>       perf tools: Add test_generic_metric function
>       perf tests: Add parse metric test for ipc metric
>       perf tests: Add parse metric test for frontend metric
> 
>  tools/perf/tests/Build          |   1 +
>  tools/perf/tests/builtin-test.c |  38 ++++++++++++++++++++++------
>  tools/perf/tests/parse-metric.c | 163 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/tests/pmu-events.c   | 120 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/tests/tests.h        |   1 +
>  tools/perf/util/metricgroup.c   |  53 ++++++++++++++++++++++++++++++---------
>  tools/perf/util/metricgroup.h   |   9 +++++++
>  tools/perf/util/parse-events.c  |  73 ++++++++++++++++++++++++++++++++++++++---------------
>  tools/perf/util/parse-events.h  |   6 ++++-
>  tools/perf/util/parse-events.l  |  16 +++++++-----
>  tools/perf/util/parse-events.y  |  37 +++++++++++++++++++++++++--
>  tools/perf/util/stat-shadow.c   |  77 ++++++++++++++++++++++++++++++++++++--------------------
>  tools/perf/util/stat.h          |   3 +++
>  13 files changed, 521 insertions(+), 76 deletions(-)
>  create mode 100644 tools/perf/tests/parse-metric.c
> 

-- 

- Arnaldo
