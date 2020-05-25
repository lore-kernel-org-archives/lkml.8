Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AACC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 12:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E9B92073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 12:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwEjjhL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390472AbgEYMGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 08:06:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59473 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390228AbgEYMGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 08:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590408358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zI7DMzgAyPm47gxM2waB33iVsf6Q+eglN7ngq4fwosY=;
        b=JwEjjhL6KmdNLcxj/hTYz+tJvsnqcyG0QYZH8Q1ZjWjgUkurt+eq4y8/f9vSkGCmfVCoe9
        qXv8laoc4wA+Xotb4ky2EVcZ28icTkD3fZOzQSExwDActoGw9Sj4M9COiJUOwn1Gt5V8Gs
        UeGz3s3EGiyfCg5U1sYmAcx+oUMJaUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103--CqCFHlYM-2vr7NNxerPFg-1; Mon, 25 May 2020 08:05:55 -0400
X-MC-Unique: -CqCFHlYM-2vr7NNxerPFg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55FAA1937FDD;
        Mon, 25 May 2020 12:05:53 +0000 (UTC)
Received: from Diego (unknown [10.40.208.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BD4560E1C;
        Mon, 25 May 2020 12:05:49 +0000 (UTC)
Date:   Mon, 25 May 2020 14:06:07 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     Jiri Olsa <jolsa@kernel.org>
cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC 00/14] perf tests: Check on subtest for user specified
 test
In-Reply-To: <20200524224219.234847-1-jolsa@kernel.org>
Message-ID: <alpine.LRH.2.20.2005251401230.4075@Diego>
References: <20200524224219.234847-1-jolsa@kernel.org>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 May 2020, Jiri Olsa wrote:
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
> 
> jirka
> 
Hi!
Last commit from perf/fixes branch I see there is:

commit 0445062df28fef1002302aa419af65fa80513dd4 (HEAD -> perf/fixes, origin/perf/fixes)
Author: Jiri Olsa <jolsa@kernel.org>
Date:   Fri Dec 6 00:10:13 2019 +0100

Different branch?

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

