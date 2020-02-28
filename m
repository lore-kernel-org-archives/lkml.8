Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ABAC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8947F2469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="FgnAID1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgB1R4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:56:47 -0500
Received: from st43p00im-zteg10061901.me.com ([17.58.63.168]:40691 "EHLO
        st43p00im-zteg10061901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbgB1R4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:56:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1582912606; bh=MVxCUw7j8MWhfoKfmDVoRhU9xWoq4V+zXqm8Ukvy7BY=;
        h=From:To:Subject:Date:Message-Id;
        b=FgnAID1IQ20NLrDxwWASXedKms3LoZZvdMtoHERqbjzoqEjMCgr68dhHadcjd1psG
         65GYTcR9jWkKvSs0lCzdnNdE7OwpBlDciWfYg1WrHzzMKwL4Gs9OnW8SJJj0CLvjyO
         6S3g5ygMCRFNGSdBOjNxaQ7Aid5NwKFLSAYpuqEbSr8JIfQkBsZ0voTNVHty9k89oc
         4IX9ZoZMMk+C/LKcqmTnxgKMzhOh6ka/wj+Mw8IwHr3AgeYykNF8msW6efoVCfQjOO
         I0vKreRHwAyjrqOFtOgeRaDK3VrDNV1to9q2Gz8/ij3FX9X5ZE+JB9yF9mNPBTi7zA
         eDnNpBWydVqaw==
Received: from shwetrath.localdomain (unknown [66.199.8.131])
        by st43p00im-zteg10061901.me.com (Postfix) with ESMTPSA id 8CB8486017E;
        Fri, 28 Feb 2020 17:56:45 +0000 (UTC)
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
Subject: [PATCH v3 0/3] update to latest PMU events for zen1/zen2 
Date:   Fri, 28 Feb 2020 12:56:36 -0500
Message-Id: <20200228175639.39171-1-vijaythakkar@me.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-02-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2002280135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches brings the PMU events for AMD family 17h series
of processors up to date with the latest versions of the AMD processor
programming reference manuals, all of which can be found at:
https://bugzilla.kernel.org/show_bug.cgi?id=206537

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
 .../pmu-events/arch/x86/amdzen1/branch.json   |  23 ++
 .../x86/{amdfam17h => amdzen1}/cache.json     |   0
 .../arch/x86/{amdfam17h => amdzen1}/core.json |   5 -
 .../floating-point.json                       |  60 ++-
 .../x86/{amdfam17h => amdzen1}/memory.json    |  18 +
 .../x86/{amdfam17h => amdzen1}/other.json     |   0
 .../pmu-events/arch/x86/amdzen2/branch.json   |  52 +++
 .../pmu-events/arch/x86/amdzen2/cache.json    | 350 ++++++++++++++++++
 .../pmu-events/arch/x86/amdzen2/core.json     | 135 +++++++
 .../arch/x86/amdzen2/floating-point.json      | 128 +++++++
 .../pmu-events/arch/x86/amdzen2/memory.json   | 343 +++++++++++++++++
 .../pmu-events/arch/x86/amdzen2/other.json    | 129 +++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   3 +-
 14 files changed, 1238 insertions(+), 20 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/branch.json
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/cache.json (100%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/core.json (97%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/floating-point.json (62%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/memory.json (92%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/other.json (100%)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/core.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/other.json

-- 
2.25.1

