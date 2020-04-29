Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4CFC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B22E221973
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgD2PH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:07:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:30730 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbgD2PHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:07:39 -0400
IronPort-SDR: fQh+JZN38LOVpkprR2XwJ4hSE4kD8JwAKBCLZ5B2ACRPgH1rgrrQU2DzTIMr1AfE8nGy4umuUk
 5xoPXVHSdBmg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 08:07:31 -0700
IronPort-SDR: msxXX+lNXrXRQo/dYFu/SgOAmCEQ6c+6GDcBxSpVVQNVyWSiveXVk4oQPekIMVy46iNvgSuDoK
 ej1FBtHjVpIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,332,1583222400"; 
   d="scan'208";a="293227360"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by fmsmga002.fm.intel.com with ESMTP; 29 Apr 2020 08:07:27 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] perf intel-pt: Add support for synthesizing branch stacks for regular events
Date:   Wed, 29 Apr 2020 18:07:42 +0300
Message-Id: <20200429150751.12570-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This patchset adds Intel PT support for synthesizing branch stacks for
regular events.  This follows on from the patchset that did the same thing
for call chains.

The first 3 patches convert Intel PT to using thread-stack to record branch
stacks, which allows branch stacks to be accumulated separately for each
thread.

The next 3 patches add support for synthesizing branch stacks for regular
events.

The final 2 patches update some documentation.


Adrian Hunter (9):
      perf thread-stack: Add branch stack support
      perf intel-pt: Consolidate thread-stack use condition
      perf intel-pt: Change branch stack support to use thread-stacks
      perf auxtrace: Add option to synthesize branch stack for regular events
      perf evsel: Add support for synthesized branch stack sample type
      perf thread-stack: Add thread_stack__br_sample_late()
      perf intel-pt: Add support for synthesizing branch stacks for regular events
      perf intel-pt: Update documentation about itrace G and L options
      perf intel-pt: Update documentation about using /proc/kcore

 tools/perf/Documentation/itrace.txt        |   5 +
 tools/perf/Documentation/perf-intel-pt.txt |  53 +++++--
 tools/perf/builtin-inject.c                |   3 +-
 tools/perf/builtin-report.c                |   5 +-
 tools/perf/util/auxtrace.c                 |   6 +-
 tools/perf/util/auxtrace.h                 |   2 +
 tools/perf/util/evsel.h                    |  10 ++
 tools/perf/util/intel-bts.c                |   2 +-
 tools/perf/util/intel-pt.c                 | 210 ++++++++++++++--------------
 tools/perf/util/s390-cpumsf.c              |   3 +-
 tools/perf/util/session.c                  |   2 +-
 tools/perf/util/thread-stack.c             | 217 +++++++++++++++++++++++++++--
 tools/perf/util/thread-stack.h             |   8 +-
 13 files changed, 393 insertions(+), 133 deletions(-)


Regards
Adrian
