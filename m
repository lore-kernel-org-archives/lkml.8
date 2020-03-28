Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280A0C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0996220578
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgC1QoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:44:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:39977 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbgC1Qn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:58 -0400
IronPort-SDR: Umlb5Mo5tafBaAep/jADZsGVkosj4+JmrbtQUl6M4ejw6kkozPeSrzQMjQZnw631Vn/d9Ts6A4
 PHRZgT92UVvg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 09:43:58 -0700
IronPort-SDR: +1aHGlUfJgAFkHc0hVjy/33yDp4jl3Q36pK4k3GL/NtbMpDqNIX2OD1KRkGcGHSLyfBiusDoOz
 u1VgL+AzU0Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,317,1580803200"; 
   d="scan'208";a="447771156"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga005.fm.intel.com with ESMTP; 28 Mar 2020 09:43:57 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v3 00/10] Support XSAVES supervisor states
Date:   Sat, 28 Mar 2020 09:42:57 -0700
Message-Id: <20200328164307.17497-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:

This version addresses the overhead of an extra XSAVES in
__fpu__restore_sig() with additional patches:

    Patch #8: Introduce copy_supervisor_to_kernel(), which does a
              supervisor-state-only XSAVES and then relocates the contents
              to the standard location.
    Patch #9: Preserve supervisor states for __fpu__restore_sig() slow path.

Other small changes are noted in each patch's commit log.

----

Changes in v2:

- Split out small changes to:
    https://lkml.kernel.org/r/20191212210855.19260-1-yu-cheng.yu@intel.com/

- Fix an issue in patch #4, where fpu__clear_user_states() drops
  supervisor xstates.

- Add three patches:
    Patch #6: Update sanitize_restored_xstate() for supervisor xstates.
    Patch #7: Update copy_kernel_to_xregs_err() to use XRSTORS when
              supervisor xstates are present.
    Patch #8: Update __fpu__restore_sig() to preserve supervisor xstates.

Also make some small changes in response to comments.  More details are in
each patch's commit log.

----

There are two types of XSAVE-managed states (xstates): user and supervisor.
This series introduces the supervisor xstate support in preparation for new
features that will make use of supervisor xstates.

This series has been separated for ease of review from the series that add
supervisor xstate features [3].

In current and near future generations of Intel processors there are three
classes of objects that can be managed as supervisor xstates:

- Processor Trace (PT):
    Linux already supports PT, but PT xstates are not saved to the FPU
    context and not context-switched by the kernel.  There are no plans to
    integrate PT into XSAVES supervisor states.

- ENQCMD Process Address Space ID (MSR_IA32_PASID):
    ENQCMD is a new instruction and will be introduced shortly in a
    separate series [2].

- Control-flow Enforcement Technology (CET):
    CET is being reviewed on the LKML [1] [3].

Supervisor xstates can be accessed only from the kernel (PL-0) with XSAVES/
XRSTORS instructions.  They cannot be accessed with other XSAVE*/XRSTOR*
instructions.  MSR_IA32_XSS sets enabled supervisor xstates, while XCR0
sets enabled user xstates.

This series separates the two xstate types by declaring new macros for each
type.  The kernel finds all available features during system initialization
and stores them in xfeatures_mask_all.  It then retrieves perspective
xstate type with xfeatures_mask_supervisor()/xfeatures_mask_user() for
handling signals and PTRACE.

[1] Detailed information on supervisor xstates can be found in "Intel 64
    and IA-32 Architectures Software Developer's Manual":

    https://software.intel.com/en-us/download/intel-64-and-ia-32-
    architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4

[2] Detailed information on the ENQCMD instruction and MSR_IA32_PASID can
    be found in "Intel Architecture Instruction Set Extensions and Future
    Features Programming Reference":

    https://software.intel.com/sites/default/files/managed/c5/15/
    architecture-instruction-set-extensions-programming-reference.pdf

[3] CET patches:

    https://lkml.kernel.org/r/20200205181935.3712-1-yu-cheng.yu@intel.com/
    https://lkml.kernel.org/r/20200205182308.4028-1-yu-cheng.yu@intel.com/

Fenghua Yu (3):
  x86/fpu/xstate: Rename validate_xstate_header() to
    validate_user_xstate_header()
  x86/fpu/xstate: Define new macros for supervisor and user xstates
  x86/fpu/xstate: Define new functions for clearing fpregs and xstates

Yu-cheng Yu (7):
  x86/fpu/xstate: Separate user and supervisor xfeatures mask
  x86/fpu/xstate: Introduce XSAVES supervisor states
  x86/fpu/xstate: Update sanitize_restored_xstate() for supervisor
    xstates
  x86/fpu/xstate: Update copy_kernel_to_xregs_err() for XSAVES
    supervisor states
  x86/fpu: Introduce copy_supervisor_to_kernel()
  x86/fpu/xstate: Preserve supervisor states for slow path of
    __fpu__restore_sig()
  x86/fpu/xstate: Restore supervisor states for signal return

 arch/x86/include/asm/fpu/internal.h |  10 +-
 arch/x86/include/asm/fpu/xstate.h   |  52 +++++---
 arch/x86/kernel/fpu/core.c          |  49 ++++---
 arch/x86/kernel/fpu/init.c          |   3 +-
 arch/x86/kernel/fpu/regset.c        |   2 +-
 arch/x86/kernel/fpu/signal.c        | 127 +++++++++++-------
 arch/x86/kernel/fpu/xstate.c        | 199 +++++++++++++++++++++-------
 arch/x86/kernel/process.c           |   2 +-
 arch/x86/kernel/signal.c            |   2 +-
 9 files changed, 317 insertions(+), 129 deletions(-)

-- 
2.21.0

