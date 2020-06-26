Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFDEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C0920707
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 19:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593200856;
	bh=kliVqJiO9GtiFU/Ur1y3d+e0LPFMR5lBL5KakLLOWlc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=TCXK72V4GUNq8HCpR+k9dPf5oKkmRI3G0DTMc7nauRfIKO/l0S9KGeJdbmTlHM/6n
	 MIOPS9lNhjszHUwIs/JXD0vRS3t/KJ5S3W8aJZ0LFiFEP6ga4lvl03map8pDLHpMyi
	 V4BnqhFNB16W8PJZkzJ6+zo6mw6jMKDfmdjOwsiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgFZTrf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 15:47:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46661 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725780AbgFZTre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 15:47:34 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-nYgGaCzNO7uQPSaE8dbi6g-1; Fri, 26 Jun 2020 15:47:27 -0400
X-MC-Unique: nYgGaCzNO7uQPSaE8dbi6g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1302107ACCA;
        Fri, 26 Jun 2020 19:47:24 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B17B7FE8B;
        Fri, 26 Jun 2020 19:47:21 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: [RFC 00/10] perf tools: Add support to reuse metric
Date:   Fri, 26 Jun 2020 21:47:10 +0200
Message-Id: <20200626194720.2915044-1-jolsa@kernel.org>
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
this patchset is adding the support to reused metric in another 
metric. The metric needs to be referenced by 'metric:' prefix.

For example, to define IPC by using CPI with change like:

         "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
 -       "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
 +       "MetricExpr": "1/metric:CPI",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"

I won't be able to find all the possible places we could
use this at, so I wonder you guys (who was asking for this)
would try it and come up with comments if there's something
missing or we could already use it at some places.

It's based on Arnaldo's tmp.perf/core.

Also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/metric

thanks,
jirka


---
Jiri Olsa (10):
      perf tools: Rename expr__add_id to expr__add_val
      perf tools: Add struct expr_parse_data to keep expr value
      perf tools: Add expr__add_id function
      perf tools: Change expr__get_id to return struct expr_parse_data
      perf tools: Add expr__del_id function
      perf tools: Collect other metrics in struct egroup
      perf tools: Collect other metrics in struct metric_expr
      perf tools: Add other metrics to hash data
      perf tools: Compute other metrics
      perf tests: Add cache_miss_cycles to metric parse test

 tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json |   2 +-
 tools/perf/tests/expr.c                                 |   7 ++--
 tools/perf/tests/parse-metric.c                         |  33 +++++++++++++++++
 tools/perf/tests/pmu-events.c                           |   4 +--
 tools/perf/util/expr.c                                  | 115 +++++++++++++++++++++++++++++++++++++++++++++-------------
 tools/perf/util/expr.h                                  |  24 +++++++++++--
 tools/perf/util/expr.y                                  |  34 ++++++++++++++----
 tools/perf/util/metricgroup.c                           | 187 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 tools/perf/util/metricgroup.h                           |   6 ++++
 tools/perf/util/stat-shadow.c                           |  23 +++++++-----
 10 files changed, 374 insertions(+), 61 deletions(-)

