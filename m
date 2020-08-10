Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A88C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B72020716
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgHJV1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:27:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:25814 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgHJV1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 17:27:39 -0400
IronPort-SDR: xWqzrHjQfyaJ3UQD1STO34T5JyWSmqm4MF799f5u7xlELm4mU497JXVP8NWVBwMxpwSNt09fzU
 m4NBvLYgP+wQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="171665936"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="171665936"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 14:27:38 -0700
IronPort-SDR: GIRAI6kTPcPJZvpa+qKrwI9IqHTjDQbz9ZDNYOXaLEzAsFe96UZRHBJDpiw5KXQ8Xxb4PZFGsA
 zJPmXoPnWVzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="469196745"
Received: from ssp-icl-u-210.jf.intel.com ([10.54.55.52])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2020 14:27:38 -0700
From:   Kan Liang <kan.liang@linux.intel.com>
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 00/16] Add the page size in the perf record
Date:   Mon, 10 Aug 2020 14:24:20 -0700
Message-Id: <20200810212436.8026-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since V5
- Introduce a new universal page walker for the page size in the perf
  subsystem.
- Rebased on Peter's tree.

Current perf can report both virtual addresses and physical addresses,
but not the page size. Without the page size information of the utilized
page, users cannot decide whether to promote/demote large pages to
optimize memory usage.

The patch set was submitted a year ago.
https://lkml.kernel.org/r/1549648509-12704-1-git-send-email-kan.liang@linux.intel.com
It introduced a __weak function, perf_get_page_size(), aim to retrieve
the page size via a given virtual address in the generic code, and
implemented a x86 specific version of perf_get_page_size().
However, the proposal was rejected, because it's a pure x86
implementation.
https://lkml.kernel.org/r/20190208200731.GN32511@hirez.programming.kicks-ass.net

At that time, it's not easy to support perf_get_page_size() universally,
because some key functions, e.g., p?d_large, are not supported by some
architectures.

Now, the generic p?d_leaf() functions are added in the latest kernel.
https://lkml.kernel.org/r/20191218162402.45610-2-steven.price@arm.com
Starts from V6, a new universal perf_get_page_size() function is
implemented based on the generic p?d_leaf() functions.

On some platforms, e.g., X86, the page walker is invoked in an NMI
handler. So the page walker must be IRQ-safe and low overhead. Besides,
the page walker should work for both user and kernel virtual address.
The existing generic page walker, e.g., walk_page_range_novma(), is a
little bit complex and doesn't guarantee the IRQ-safe. The follow_page()
is only for the user-virtual address. So a simpler page walk function is
implemented here.

Kan Liang (11):
  perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
  perf/x86/intel: Support PERF_SAMPLE_DATA_PAGE_SIZE
  tools headers UAPI: Update tools's copy of linux/perf_event.h
  perf record: Support new sample type for data page size
  perf script: Use ULL for enum perf_output_field
  perf script: Support data page size
  perf sort: Add sort option for data page size
  perf mem: Factor out a function to generate sort order
  perf mem: Clean up output format
  perf mem: Support data page size
  perf test: Add test case for PERF_SAMPLE_DATA_PAGE_SIZE

Stephane Eranian (5):
  perf/core: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
  perf tools: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
  perf script: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
  perf report: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
  perf test: Add test case for PERF_SAMPLE_CODE_PAGE_SIZE

 arch/x86/events/intel/ds.c                |  11 +-
 include/linux/perf_event.h                |   2 +
 include/uapi/linux/perf_event.h           |   6 +-
 kernel/events/core.c                      | 132 ++++++++++++++++++-
 tools/include/uapi/linux/perf_event.h     |   6 +-
 tools/perf/Documentation/perf-mem.txt     |   3 +
 tools/perf/Documentation/perf-record.txt  |   6 +
 tools/perf/Documentation/perf-report.txt  |   2 +
 tools/perf/Documentation/perf-script.txt  |   5 +-
 tools/perf/builtin-mem.c                  | 150 ++++++++++++----------
 tools/perf/builtin-record.c               |   4 +
 tools/perf/builtin-script.c               |  90 ++++++++-----
 tools/perf/tests/sample-parsing.c         |  10 +-
 tools/perf/util/event.h                   |   5 +
 tools/perf/util/evsel.c                   |  18 +++
 tools/perf/util/hist.c                    |   5 +
 tools/perf/util/hist.h                    |   2 +
 tools/perf/util/machine.c                 |   7 +-
 tools/perf/util/map_symbol.h              |   1 +
 tools/perf/util/perf_event_attr_fprintf.c |   2 +-
 tools/perf/util/record.h                  |   2 +
 tools/perf/util/session.c                 |  26 ++++
 tools/perf/util/sort.c                    |  56 ++++++++
 tools/perf/util/sort.h                    |   3 +
 tools/perf/util/synthetic-events.c        |  16 +++
 25 files changed, 456 insertions(+), 114 deletions(-)

-- 
2.17.1

