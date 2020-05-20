Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C06C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B356207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KsJp4HgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgETH2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 03:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETH2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 03:28:23 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B560BC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:28:21 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id a7so2756816qvl.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cdxaRZ8/bLJ0hiCQFa/mZ4i8RBkML1CDuxtDfYtoS7E=;
        b=KsJp4HgOm1YR3buC+GlraWqwPMQb539hDABZ/Nfwz8yv31xFdfQjzzivTD6XDX3Vmt
         nAwono7Ocu56A8vywCzt3qTioDy//Obgjs3oSL5JKWQyyBZ1NMsc/sJCUbBhqMSGBkaA
         +lvXpxMzJzxZXBpgmoRcCBw/oAeoRASXh9/owLwtjugNYiOoeTy9lBzPQwtR4zHWKIiw
         6PWF4iGlsRE8VlP32j2e/eTWxbSg8/9TMNfR9Eih0SgThNOkk8t4iSABgQXLDNnkV4cg
         GEaQqeA7jAlgBLpZ+r0NTJhBJFgjeBJAJYXKb8PQZp2qbVSpaV7VUBV+jN0IFbxq88ro
         uzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cdxaRZ8/bLJ0hiCQFa/mZ4i8RBkML1CDuxtDfYtoS7E=;
        b=pXHBvP5RRqk6f6czuRwQF3QpzkuMatKPd/GvO5kC4Y0MKiKxdB6qbOp0j3kdYthtIJ
         61lHwi4D9dOUUX9tOwk86tb1h2vD2AM3gyBxAWE6pTAkirQpxXj/pHeT52xLpxm0qvWp
         ReG4LabZ5iqBb6oMvaTR2Wjf2rxarJzSEU3UVsLDMs1FQ7l69XqWJZrvjbgPRbbIoWO+
         G6DtQAOk/6oHAIwIVk3aGP4GLawjkahQKHnTSEPSN4/ZnTow0O4kHQ6RiTIhvCwPy5sT
         y5esyYj7iDfZPVI8/1slwRxFRI7avB7s2y4X6DsjVoNwtuts6QAPivo0Wq5w1yZ2P6/H
         6kWg==
X-Gm-Message-State: AOAM532WBxwVEX3RKDpiuoaoMD0v5It8LHxAOOyHrs6D+6WlxI1OBZUg
        nEPG0xcPwCItY6y7usCupm1DkNyPRXuH
X-Google-Smtp-Source: ABdhPJznDrW41cQ4bY7/vsXD+gG1rnELqi+iRCkeb8YVsQEpxgZJCekqGg1Xr6ttcOHRCfkIYgKOEPoI27co
X-Received: by 2002:a0c:e806:: with SMTP id y6mr3647862qvn.177.1589959700511;
 Wed, 20 May 2020 00:28:20 -0700 (PDT)
Date:   Wed, 20 May 2020 00:28:07 -0700
Message-Id: <20200520072814.128267-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH 0/7] Share events between metrics
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Paul Clarke <pc@us.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Vince Weaver <vincent.weaver@maine.edu>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Metric groups contain metrics. Metrics create groups of events to
ideally be scheduled together. Often metrics refer to the same events,
for example, a cache hit and cache miss rate. Using separate event
groups means these metrics are multiplexed at different times and the
counts don't sum to 100%. More multiplexing also decreases the
accuracy of the measurement.

This change orders metrics from groups or the command line, so that
the ones with the most events are set up first. Later metrics see if
groups already provide their events, and reuse them if
possible. Unnecessary events and groups are eliminated.

The option --metric-no-group is added so that metrics aren't placed in
groups. This affects multiplexing and may increase sharing.

The option --metric-mo-merge is added and with this option the
existing grouping behavior is preserved.

Using skylakex metrics I ran the following shell code to count the
number of events for each metric group (this ignores metric groups
with a single metric, and one of the duplicated TopdownL1 and
TopDownL1 groups):

for i in all Branches BrMispredicts Cache_Misses FLOPS Instruction_Type Memory_BW Pipeline Power SMT Summary TopdownL1 TopdownL1_SMT
do
  echo Metric group: $i
  echo -n " - No merging (old default, now --metric-no-merge): "
  /tmp/perf/perf stat -a --metric-no-merge -M $i sleep 1 2>&1 | grep -v "^ *#" | egrep " +[0-9,.]+ [^s]" | wc -l
  echo -n " - Merging over metrics (new default)             : "
  /tmp/perf/perf stat -a -M $i sleep 1 2>&1 | grep -v "^ *#" | egrep " +[0-9,.]+ [^s]"|wc -l
  echo -n " - No event groups and merging (--metric-no-group): "
  /tmp/perf/perf stat -a --metric-no-group -M $i sleep 1 2>&1 | grep -v "^ *#" | egrep " +[0-9,.]+ [^s]"|wc -l
done

Metric group: all
 - No merging (old default, now --metric-no-merge): 193
 - Merging over metrics (new default)             : 142
 - No event groups and merging (--metric-no-group): 84
Metric group: Branches
 - No merging (old default, now --metric-no-merge): 8
 - Merging over metrics (new default)             : 8
 - No event groups and merging (--metric-no-group): 4
Metric group: BrMispredicts
 - No merging (old default, now --metric-no-merge): 11
 - Merging over metrics (new default)             : 11
 - No event groups and merging (--metric-no-group): 10
Metric group: Cache_Misses
 - No merging (old default, now --metric-no-merge): 11
 - Merging over metrics (new default)             : 9
 - No event groups and merging (--metric-no-group): 6
Metric group: FLOPS
 - No merging (old default, now --metric-no-merge): 18
 - Merging over metrics (new default)             : 10
 - No event groups and merging (--metric-no-group): 10
Metric group: Instruction_Type
 - No merging (old default, now --metric-no-merge): 6
 - Merging over metrics (new default)             : 6
 - No event groups and merging (--metric-no-group): 4
Metric group: Pipeline
 - No merging (old default, now --metric-no-merge): 6
 - Merging over metrics (new default)             : 6
 - No event groups and merging (--metric-no-group): 5
Metric group: Power
 - No merging (old default, now --metric-no-merge): 16
 - Merging over metrics (new default)             : 16
 - No event groups and merging (--metric-no-group): 10
Metric group: SMT
 - No merging (old default, now --metric-no-merge): 11
 - Merging over metrics (new default)             : 8
 - No event groups and merging (--metric-no-group): 7
Metric group: Summary
 - No merging (old default, now --metric-no-merge): 19
 - Merging over metrics (new default)             : 17
 - No event groups and merging (--metric-no-group): 17
Metric group: TopdownL1
 - No merging (old default, now --metric-no-merge): 16
 - Merging over metrics (new default)             : 7
 - No event groups and merging (--metric-no-group): 7
Metric group: TopdownL1_SMT
 - No merging (old default, now --metric-no-merge): 24
 - Merging over metrics (new default)             : 7
 - No event groups and merging (--metric-no-group): 7

There are 5 out of 12 metric groups where no events are shared, such
as Power, however, disabling grouping of events always reduces the
number of events.

The result for Memory_BW needs explanation:

Metric group: Memory_BW
 - No merging (old default, now --metric-no-merge): 9
 - Merging over metrics (new default)             : 5
 - No event groups and merging (--metric-no-group): 11

Both with and without merging the groups fail to be set up and so the
event counts here are for broken metrics. The --metric-no-group number
is accurate as all the events are scheduled. Ideally a constraint
would be added for these metrics in the json code to avoid grouping.

v1. was prepared on kernel/git/acme/linux.git branch tmp.perf/core

Compared to RFC v3: fix a bug where unnecessary commas were passed to
parse-events and were echoed. Fix a bug where the same event could be
matched more than once with --metric-no-group, causing there to be
events missing.
https://lore.kernel.org/lkml/20200508053629.210324-1-irogers@google.com/

Ian Rogers (7):
  perf metricgroup: Change evlist_used to a bitmap
  perf metricgroup: Always place duration_time last
  perf metricgroup: Delay events string creation
  perf metricgroup: Order event groups by size
  perf metricgroup: Remove duped metric group events
  perf metricgroup: Add options to not group or merge
  perf metricgroup: Remove unnecessary ',' from events

 tools/perf/Documentation/perf-stat.txt |  19 ++
 tools/perf/builtin-stat.c              |  11 +-
 tools/perf/util/metricgroup.c          | 241 ++++++++++++++++++-------
 tools/perf/util/metricgroup.h          |   6 +-
 tools/perf/util/stat.h                 |   2 +
 5 files changed, 206 insertions(+), 73 deletions(-)

-- 
2.26.2.761.g0e0b3e54be-goog

