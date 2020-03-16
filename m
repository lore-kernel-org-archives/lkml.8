Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F26C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FCE205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="kUcCbpBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732884AbgCPWwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 18:52:44 -0400
Received: from st43p00im-ztbu10073601.me.com ([17.58.63.184]:48971 "EHLO
        st43p00im-ztbu10073601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732843AbgCPWwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 18:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1584399163; bh=PKdVmqE/v3xZkUeAJ1SFSn2zaCwXnW0yWUNvyflV7a0=;
        h=From:To:Subject:Date:Message-Id;
        b=kUcCbpBrgQ7HJzTD9LSby6f9Ha7L1dbxNK3P7i4w06uFwxaNepS96pn+QJZCIxUp8
         BS5mqZIl7eqC7R8FLqby1fbMaupxfmL8PnJy2EoNC/PRhv9LPwHCS+J/8NhPNVVMI6
         9TW+mIb+QkWWEkTfRDwO/0xhiamfl3hHBSAukayhwGELpOYzDYeaUuAYsT356pJPF/
         vJi3A5pjj+chlp6qXLFaeoG68dgPqpYpG+t80iNuf75rjpr0TvglUCiOHTSpRTJ80o
         /j+8lCwkDqpq//tTiSpyFdnamcXwmXhYT829qNOrmlPC8mVzkLSf/djP0ucges1S4H
         nsmuMgztvXyQA==
Received: from shwetrath.localdomain (unknown [66.199.8.131])
        by st43p00im-ztbu10073601.me.com (Postfix) with ESMTPSA id 5BEDB820505;
        Mon, 16 Mar 2020 22:52:42 +0000 (UTC)
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
Subject: [PATCH v5 0/3] 
Date:   Mon, 16 Mar 2020 18:52:35 -0400
Message-Id: <20200316225238.150154-1-vijaythakkar@me.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-03-16_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2003160094
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

