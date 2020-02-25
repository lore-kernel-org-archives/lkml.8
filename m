Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15836C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB7721556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="byFdGZk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbgBYTdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 14:33:46 -0500
Received: from st43p00im-zteg10071901.me.com ([17.58.63.169]:38815 "EHLO
        st43p00im-zteg10071901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729510AbgBYTdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 14:33:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1582658897; bh=2gnxygFaLZC3Muts4M4PJKqhX4X6IyMHLbDOEyfv6Pc=;
        h=From:To:Subject:Date:Message-Id;
        b=byFdGZk/aHoLsQZgiHd5DrN4M8mhxJGKxETcRREN1qlkahgIS/rarGM8JWwn+2mMs
         fXiIFaBV22ENJx0SFt4mt7uwche857GLGLtcL5E1p8704yoWL300AYaQ2DZIyCgkzY
         olMSZi0lsoNSoD9p8nPtUUE+HKPdqmaT0pqdWvHxYMvyXOPxI8gfuXWzIEODj2ivIn
         P2jxp31CzwBZNCTnuL4BOvhxOO/QIcLtuEl3lRXYCM1O7C/LsExc+j+K580StLTjTN
         xhOj/35vh8hCwARBUdVpkpjk79/fASAIEy3Srp7suteMv+6jYZK392HDdtFAgoo29n
         RfN84iho+wlGw==
Received: from shwetrath.localdomain (unknown [66.199.8.131])
        by st43p00im-zteg10071901.me.com (Postfix) with ESMTPSA id 7952ED810CD;
        Tue, 25 Feb 2020 19:28:17 +0000 (UTC)
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
Subject: [PATCH v2 0/3] latest PMU events for zen1/zen2
Date:   Tue, 25 Feb 2020 14:28:12 -0500
Message-Id: <20200225192815.50388-1-vijaythakkar@me.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-02-25_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2002250137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches brings the PMU events for AMD family 17h series
of processors up to date with the latest versions of the AMD processor
programming reference manuals.

The first patch changes the pmu events mapfile to be more selective for
the model number rather than blanket detecting all f17h processors to
have the same events directory. This is required for the later patch
where we add events for zen2 based processors. In v2 of the patch, the
incorrect regex for model string was correct to include the range 0
through 2f.

The second patch adds the PMU events for zen2. In v2 ls_mab_alloc.loads
umask is corrected. No events from Zen1 have been removed.

Finally the third patch updates the zen1 PMU events to be in accordance
with the latest PPR version and bumps up the events version to v2. In v2
of the patch series, missing events (bp_dyn_ind_pred and bp_de_redirect)
were added and umasks were corrected for fpu_pipe_assignment.dual* and
ls_mab_alloc.loads.

Vijay Thakkar (3):
  perf vendor events amd: restrict model detection for zen1 based
    processors
  perf vendor events amd: add Zen2 events
  perf vendor events amd: update Zen1 events to V2

 .../pmu-events/arch/x86/amdfam17h/branch.json |  12 -
 .../pmu-events/arch/x86/amdzen1/branch.json   |  23 ++
 .../x86/{amdfam17h => amdzen1}/cache.json     |   0
 .../pmu-events/arch/x86/amdzen1/core.json     | 129 ++++++
 .../floating-point.json                       |  56 +++
 .../x86/{amdfam17h => amdzen1}/memory.json    |  18 +
 .../x86/{amdfam17h => amdzen1}/other.json     |   0
 .../pmu-events/arch/x86/amdzen2/branch.json   |  56 +++
 .../pmu-events/arch/x86/amdzen2/cache.json    | 375 ++++++++++++++++++
 .../arch/x86/{amdfam17h => amdzen2}/core.json |   0
 .../arch/x86/amdzen2/floating-point.json      | 128 ++++++
 .../pmu-events/arch/x86/amdzen2/memory.json   | 349 ++++++++++++++++
 .../pmu-events/arch/x86/amdzen2/other.json    | 137 +++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   3 +-
 14 files changed, 1273 insertions(+), 13 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/branch.json
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/cache.json (100%)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/core.json
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/floating-point.json (63%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/memory.json (93%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/other.json (100%)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/cache.json
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen2}/core.json (100%)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/other.json

-- 
2.25.1

