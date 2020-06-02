Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA8BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B714A20679
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591134472;
	bh=tPBARK/Qj6TFVwSCYOKgJG9KMyTcN8V+x1x+eP6lxsc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=EirqR3lPI4tQOPf/J2zvBSx1L0zqc2d1pOgO7QAlg71cH1lq1P1fFZ0mTLsjYNTo0
	 Oz7EhFF7t3tetRX1zbRD8Fx23jrnK+h3y7TtYUxxduMnCJQcsXSBPBBqt+jxirFy6X
	 RnLVwBZmmDpCxaCKwFCRL3XeUjcE81gJGfECnj8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgFBVrv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:47:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58532 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726130AbgFBVrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:47:51 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-DRoa9RZpNnWuEJGESM3HpA-1; Tue, 02 Jun 2020 17:47:46 -0400
X-MC-Unique: DRoa9RZpNnWuEJGESM3HpA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF99F835B41;
        Tue,  2 Jun 2020 21:47:44 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 299531BCBE;
        Tue,  2 Jun 2020 21:47:41 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCHv3 00/13] perf tests: Add metrics tests
Date:   Tue,  2 Jun 2020 23:47:28 +0200
Message-Id: <20200602214741.1218986-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
changes for using metric result in another metric seem
to change lot of core metric code, so it's better we
have some more tests before we do that.

v3 changes:
  - few typo fixes [Ian]
  - move struct parse_events_error one level up in check_parse_id [Ian]
  - added Ian's acks

v2 changes:
  - some of the patches got accepted
  - add missing free to patch 1 [Ian]
  - factor pmu-events test functions and reuse it in the new test [Ian]
  - add fake_pmu bool to parse_events interface [Ian]
  - simplify metric tests
  - use proper cover letter subject ;-)

Also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/metric_test

thanks,
jirka


---
Jiri Olsa (13):
      perf tools: Add fake pmu support
      perf tools: Add fake_pmu bool to parse_events interface
      perf tests: Factor check_parse_id function
      perf tests: Add another metric parsing test
      perf tools: Factor out parse_groups function
      perf tools: Add fake_pmu to parse_events function
      perf tools: Add map to parse_events function
      perf tools: Add metricgroup__parse_groups_test function
      perf tools: Factor out prepare_metric function
      perf tools: Release metric_events rblist
      perf tools: Add test_generic_metric function
      perf tests: Add parse metric test for ipc metric
      perf tests: Add parse metric test for frontend metric

 tools/perf/arch/arm/util/cs-etm.c            |   2 +-
 tools/perf/arch/arm64/util/arm-spe.c         |   2 +-
 tools/perf/arch/powerpc/util/kvm-stat.c      |   2 +-
 tools/perf/arch/x86/tests/intel-cqm.c        |   2 +-
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |   2 +-
 tools/perf/arch/x86/util/intel-bts.c         |   2 +-
 tools/perf/arch/x86/util/intel-pt.c          |   6 ++--
 tools/perf/builtin-stat.c                    |   9 +++---
 tools/perf/builtin-trace.c                   |   4 +--
 tools/perf/tests/Build                       |   1 +
 tools/perf/tests/backward-ring-buffer.c      |   3 +-
 tools/perf/tests/builtin-test.c              |   4 +++
 tools/perf/tests/code-reading.c              |   2 +-
 tools/perf/tests/event-times.c               |   2 +-
 tools/perf/tests/evsel-roundtrip-name.c      |   4 +--
 tools/perf/tests/hists_cumulate.c            |   2 +-
 tools/perf/tests/hists_filter.c              |   4 +--
 tools/perf/tests/hists_link.c                |   4 +--
 tools/perf/tests/hists_output.c              |   2 +-
 tools/perf/tests/keep-tracking.c             |   4 +--
 tools/perf/tests/parse-events.c              |   2 +-
 tools/perf/tests/parse-metric.c              | 170 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/tests/pmu-events.c                | 131 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 tools/perf/tests/switch-tracking.c           |   8 ++---
 tools/perf/tests/tests.h                     |   1 +
 tools/perf/util/bpf-loader.c                 |   2 +-
 tools/perf/util/metricgroup.c                |  74 ++++++++++++++++++++++++++++++++++++----------
 tools/perf/util/metricgroup.h                |  10 +++++++
 tools/perf/util/parse-events.c               |  29 +++++++++++-------
 tools/perf/util/parse-events.h               |   5 ++--
 tools/perf/util/parse-events.l               |   8 +++--
 tools/perf/util/parse-events.y               |  41 ++++++++++++++++++++++++--
 tools/perf/util/perf_api_probe.c             |   2 +-
 tools/perf/util/record.c                     |   2 +-
 tools/perf/util/stat-shadow.c                |  67 ++++++++++++++++++++++++++++++------------
 tools/perf/util/stat.h                       |   3 ++
 36 files changed, 526 insertions(+), 92 deletions(-)
 create mode 100644 tools/perf/tests/parse-metric.c

