Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80997C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9BF20787
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbgDAKRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:17:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:34142 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgDAKRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:17:33 -0400
IronPort-SDR: yTYzyF+dGYD6rRcI/8gf01PGgcLLjm6f8gM2dGjhUHhOGM+JnncNU4j8RoKO+hfKsaUxkKnErf
 ArRy/72NJnZg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 03:17:31 -0700
IronPort-SDR: MbmP2s2t4a2a/ElccBqSIdGlVafEm4qRUUWGetqaqSfo0ZWCUfWd8CJHbPHpnKHJANSbZ5bm+6
 vtypDT1PygUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,331,1580803200"; 
   d="scan'208";a="395925464"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2020 03:17:30 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 00/16] perf intel-pt: Sampling improvements
Date:   Wed,  1 Apr 2020 13:15:57 +0300
Message-Id: <20200401101613.6201-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are 3 sampling improvements for Intel PT:

1. Patches 1 to 7
   For reporting purposes, un-group AUX area event
   Please example in patch 7

2. Patches 8 to 11
   Add support for synthesizing callchains for regular events
   Please see example in patch 11

3. Patches 12 to 16
   Add support for leader-sampling with AUX area event
   Please see example in patch 16

Patches also found here:

   git.infradead.org:/srv/git/users/ahunter/linux-perf.git callchain


Adrian Hunter (16):
      perf auxtrace: Add ->evsel_is_auxtrace() callback
      perf intel-pt: Implement ->evsel_is_auxtrace() callback
      perf intel-bts: Implement ->evsel_is_auxtrace() callback
      perf arm-spe: Implement ->evsel_is_auxtrace() callback
      perf cs-etm: Implement ->evsel_is_auxtrace() callback
      perf s390-cpumsf: Implement ->evsel_is_auxtrace() callback
      perf auxtrace: For reporting purposes, un-group AUX area event
      perf auxtrace: Add an option to synthesize callchains for regular events
      perf thread-stack: Add thread_stack__sample_late()
      perf tools: Add support for synthesized sample type
      perf intel-pt: Add support for synthesizing callchains for regular events
      perf tools: Move and globalize perf_evsel__find_pmu() and perf_evsel__is_aux_event()
      perf tools: Move leader-sampling configuration
      perf tools: Rearrange perf_evsel__config_leader_sampling()
      perf tools: Allow multiple read formats
      perf tools: Add support for leader-sampling with AUX area events

 tools/perf/Documentation/itrace.txt    |  1 +
 tools/perf/Documentation/perf-list.txt |  3 ++
 tools/perf/builtin-report.c            |  3 +-
 tools/perf/builtin-script.c            |  2 +-
 tools/perf/util/arm-spe.c              | 10 ++++
 tools/perf/util/auxtrace.c             | 94 +++++++++++++++++++++++++---------
 tools/perf/util/auxtrace.h             | 14 +++++
 tools/perf/util/cs-etm.c               | 11 ++++
 tools/perf/util/evlist.c               |  6 ++-
 tools/perf/util/evsel.c                | 41 +++++++--------
 tools/perf/util/evsel.h                | 18 ++++++-
 tools/perf/util/intel-bts.c            | 10 ++++
 tools/perf/util/intel-pt.c             | 78 +++++++++++++++++++++++++---
 tools/perf/util/record.c               | 62 ++++++++++++++++++++++
 tools/perf/util/s390-cpumcf-kernel.h   |  1 +
 tools/perf/util/s390-cpumsf.c          | 11 +++-
 tools/perf/util/thread-stack.c         | 57 +++++++++++++++++++++
 tools/perf/util/thread-stack.h         |  3 ++
 18 files changed, 367 insertions(+), 58 deletions(-)



Regards
Adrian
