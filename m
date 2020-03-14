Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416E5C5ACBF
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E922051A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="Bo2AxBs6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgCOCD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:03:28 -0400
Received: from st43p00im-ztdg10063201.me.com ([17.58.63.182]:54000 "EHLO
        st43p00im-ztdg10063201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727566AbgCOCDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1584161097; bh=F0ITEm+P4Ct+WXI87vsMYO1oTLy/6jkjYUL2jH5Dtcg=;
        h=From:To:Subject:Date:Message-Id;
        b=Bo2AxBs68Dx/h+9A3vgSBndA7qvhU1dRFiEPU47w23rEXC7IdgbTsREWP5KpDnemT
         ME+XwOz4URRM9fCSy24Oa6bUDJgLdj2AZdjUBUJ6w4ReHbvxF5xBqGKvJpCuXoArjL
         TzIRRbdGTmyd/1rckdjh6PB15XGDiJhciL2S5RJKNNI4dq4WOpKAbhuN+OzUoVFVgh
         RQWukFarmTtjSA74Gi2bCbatsRW220aeKmvsxKT9eGl7RW+WS+i4vfvY4VDX3TFpNY
         XLErdBJtP14hSbUrY4lsqspE7xW+yRTjH7I9ZjjcWyc5UKtfwmfAdb+srcjspJRE0f
         HEb602dSIavxg==
Received: from shwetrath.localdomain (unknown [66.199.8.131])
        by st43p00im-ztdg10063201.me.com (Postfix) with ESMTPSA id F25DF54052D;
        Sat, 14 Mar 2020 04:44:56 +0000 (UTC)
From:   Vijay Thakkar <vijaythakkar@me.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Vijay Thakkar <vijaythakkar@me.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v4 0/3] update to latest PMU events for zen1/zen2
Date:   Sat, 14 Mar 2020 00:44:50 -0400
Message-Id: <20200314044453.82554-1-vijaythakkar@me.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-03-13_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2003140024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change summary:
Patch 1: changes the pmu events mapfile to be more selective for
the model number rather than blanket detecting all f17h processors to
have the same events directory. This is required for the later patch
where we add events for zen2 based processors.

Patch 2: adds the PMU events for zen2.

Patch 3: updates the zen1 PMU events to be in accordance
with the latest PPR version and bumps up the events version to v2,
mainly adding some events that were previously missing, and
cleaning up some fpu counters.

Details of what changed between patch revisions is included within the
commits.

Vijay Thakkar (3):
  perf vendor events amd: restrict model detection for zen1 based
    processors
  perf vendor events amd: add Zen2 events
  perf vendor events amd: update Zen1 events to V2

 .../pmu-events/arch/x86/amdfam17h/branch.json |  12 -
 .../pmu-events/arch/x86/amdfam17h/cache.json  | 329 -----------------
 .../pmu-events/arch/x86/amdfam17h/other.json  |  65 ----
 .../pmu-events/arch/x86/amdzen1/branch.json   |  23 ++
 .../pmu-events/arch/x86/amdzen1/cache.json    | 294 +++++++++++++++
 .../arch/x86/{amdfam17h => amdzen1}/core.json |  15 +-
 .../floating-point.json                       |  64 +++-
 .../x86/{amdfam17h => amdzen1}/memory.json    |  82 +++--
 .../pmu-events/arch/x86/amdzen1/other.json    |  56 +++
 .../pmu-events/arch/x86/amdzen2/branch.json   |  52 +++
 .../pmu-events/arch/x86/amdzen2/cache.json    | 338 +++++++++++++++++
 .../pmu-events/arch/x86/amdzen2/core.json     | 130 +++++++
 .../arch/x86/amdzen2/floating-point.json      | 112 ++++++
 .../pmu-events/arch/x86/amdzen2/memory.json   | 341 ++++++++++++++++++
 .../pmu-events/arch/x86/amdzen2/other.json    | 115 ++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   3 +-
 16 files changed, 1578 insertions(+), 453 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/branch.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/cache.json
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/core.json (87%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/floating-point.json (61%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/memory.json (63%)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/core.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/other.json

-- 
2.25.1

