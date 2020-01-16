Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2DAC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978E7208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgAPP7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:59:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:61560 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgAPP7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:59:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 07:59:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,326,1574150400"; 
   d="scan'208";a="248853704"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.45])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jan 2020 07:59:09 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, eranian@google.com, acme@redhat.com,
        mingo@kernel.org, mpe@ellerman.id.au, linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RESEND PATCH V5 0/2] Stitch LBR call stack (kernel)
Date:   Thu, 16 Jan 2020 07:57:55 -0800
Message-Id: <20200116155757.19624-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V4
- Only include the kernel patches
- Abstract TOS to HW index, which can be used across hw platforms.
  If we don't know the order of raw branch records, the hw_idx should be
  -1ULL. Set hw_idx to -1ULL for IBM Power for now.
- Move the new branch sample type back to bit 17

Changes since V3
- Add the new branch sample type at the end of enum
  perf_branch_sample_type.
- Rebase the user space patch on top of acme's perf/core branch

Changes since V2
- Move tos into struct perf_branch_stack

Changes since V1
- Add a new branch sample type for LBR TOS. Drop the sample type in V1.
- Add check in perf header to detect unknown input bits in event attr
- Save and use the LBR cursor nodes from previous sample to avoid
  duplicate calculation of cursor nodes.
- Add fast path for duplicate entries check. It benefits all call stack
  parsing, not just for stitch LBR call stack. It can be merged
  independetely.

Start from Haswell, Linux perf can utilize the existing Last Branch
Record (LBR) facility to record call stack. However, the depth of the
reconstructed LBR call stack limits to the number of LBR registers.
E.g. on skylake, the depth of reconstructed LBR call stack is <= 32
That's because HW will overwrite the oldest LBR registers when it's
full.

However, the overwritten LBRs may still be retrieved from previous
sample. At that moment, HW hasn't overwritten the LBR registers yet.
Perf tools can stitch those overwritten LBRs on current call stacks to
get a more complete call stack.

To determine if LBRs can be stitched, the physical index of LBR
registers is required. A new branch sample type is introduced to
dump the LBR Top-of-Stack (TOS) information for perf tools.

The stitching approach base on LBR call stack technology. The known
limitations of LBR call stack technology still apply to the approach,
e.g. Exception handing such as setjmp/longjmp will have calls/returns
not match.
This approach is not full proof. There can be cases where it creates
incorrect call stacks from incorrect matches. There is no attempt
to validate any matches in another way. So it is not enabled by default.
However in many common cases with call stack overflows it can recreate
better call stacks than the default lbr call stack output. So if there
are problems with LBR overflows this is a possible workaround.

Regression:
Users may collect LBR call stack on a machine with new perf tool and
new kernel (support LBR TOS). However, they may parse the perf.data with
old perf tool (not support LBR TOS). The old tool doesn't check
attr.branch_sample_type. Users probably get incorrect information
without any warning.

Kan Liang (2):
  perf/core: Add new branch sample type for HW index of raw branch
    records
  perf/x86/intel: Output LBR TOS information

 arch/powerpc/perf/core-book3s.c |  1 +
 arch/x86/events/intel/lbr.c     |  9 +++++++++
 include/linux/perf_event.h      | 12 ++++++++++++
 include/uapi/linux/perf_event.h | 10 +++++++++-
 kernel/events/core.c            | 11 +++++++++++
 5 files changed, 42 insertions(+), 1 deletion(-)

-- 
2.17.1

