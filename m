Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA11C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D5E420836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgFZSXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:23:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:59760 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgFZSX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:23:29 -0400
IronPort-SDR: QTL+hahqgQfsnssYZyMoFGCYy/BZuPShi/JHbMtYK0BZ8uqoMNxDXtzcsg6xSOCInvrNQp5lHT
 BRSYE7ZNGg5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="210512872"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="210512872"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:23:28 -0700
IronPort-SDR: lBbdVeGeJkEp2nERUHJNUTqjwvWPZfZOjN2EUfGWVQFC4Ci1Sr9z2rMW0DyP9EMMHiHfF33vMF
 5jXJ8IrKmFDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="424153793"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2020 11:23:28 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, wei.w.wang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 00/23] Support Architectural LBR
Date:   Fri, 26 Jun 2020 11:19:57 -0700
Message-Id: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V1:
- Move the union for CPUID enumeration bits to asm/perf_event.h
- Union the lbr_ctl_map and lbr_sel_map
- Rename ARCH_LBR_INFO_* to LBR_INFO_*
- Remove the function pointers of lbr_enable/disable. Architectural
  LBR and the model-specific LBR share the same functions for
  lbr_enable/disable now.
- Factor out common codes for lbr_read, lbr_save and lbr_restore to
  reduce the duplicate codes.
- Export copy_fpregs_to_fpstate instead of xfeatures_mask_all
- Add a padding to guarantee the required alignment
- Simplify the intel_pmu_arch_lbr_read_xsave()

LBR (Last Branch Records) enables recording of software path history
by logging taken branches and other control flows within architectural
registers. Intel CPUs have had model-specific LBRs for quite some time
but this evolves them into an architectural feature now.

The main advantages for the users are:
- Faster context switching due to XSAVES support and faster reset of
  LBR MSRs via the new DEPTH MSR
- Faster LBR read for a non-PEBS event due to XSAVES support, which
  lowers the overhead of the NMI handler. (For a PEBS event, the LBR
  information is recorded in the PEBS records. There is no impact on
  the PEBS event.)
- Linux kernel can support the LBR features without knowing the model
  number of the current CPU.
- Clean exposure of LBRs to guests without relying on model-specific
  features. (An improvement for KVM. Not included in this patch series.)
- Supports for running with a smaller number of LBRs than the full 32,
  to lower overhead (currently not exposed, however)

The key improvements for the perf kernel in this patch series include,
- Doesn't require a model check. The capabilities of Architectural LBR
  can be enumerated by CPUID.
- Each LBR record or entry is still comprised of three MSRs,
  IA32_LBR_x_FROM_IP, IA32_LBR_x_TO_IP and IA32_LBR_x_TO_IP, but they
  become architectural MSRs.
- Architectural LBR is stack-like now. Entry 0 is always the youngest
  branch, entry 1 the next youngest... The TOS MSR has been removed.
- A new IA32_LBR_CTL MSR is introduced to enable and configure LBRs,
  which replaces the IA32_DEBUGCTL[bit 0] and the LBR_SELECT MSR.
- The possible LBR depth can be retrieved from CPUID enumeration. The
  max value is written to the new MSR_ARCH_LBR_DEPTH as the number of
  LBR entries.
- Faster LBR MSRs reset via the new DEPTH MSR, which avoids touching
  potentially nearly a hundred MSRs.
- XSAVES and XRSTORS are used to read, save/restore LBR related MSRs
- Faster direct reporting of the branch type with the LBR without needing
  access to the code

The existing LBR capabilities, such as CPL filtering, Branch filtering,
Call stack, Mispredict information, cycles information, Branch Type
information, are still kept for Architectural LBRs.

XSAVES and XRSTORS improvements:

In perf with call stack mode, LBR information is used to reconstruct
a call stack. To get a complete call stack, perf has to save and restore
all LBR registers during a context switch. However, the number of LBR
registers is huge. To reduce the overhead, LBR state component is
introduced with architectural LBR. Perf subsystem will use XSAVES/XRSTORS
to save/restore LBRs during a context switch.

LBR call stack mode is not always enabled. Perf subsystem only needs to
save/restore an LBR state on demand. To avoid unnecessary save/restore of
the LBR state at a context switch, a software concept, dynamic supervisor
state, is introduced, which
- does not allocate a buffer in each task->fpu;
- does not save/restore a state component at each context switch;
- sets the bit corresponding to a dynamic supervisor feature in
  IA32_XSS at boot time, and avoids setting it at run time;
- dynamically allocates a specific buffer for a state component
  on demand, e.g. only allocate a LBR-specific XSAVE buffer when LBR is
  enabled in perf. (Note: The buffer has to include the LBR state
  component, legacy region and XSAVE header.)
- saves/restores a state component on demand, e.g. manually invoke
  the XSAVES/XRSTORS instruction to save/restore the LBR state
  to/from the buffer when perf is active and a call stack is required.

The specification of Architectural LBR can be found in the latest Intel
Architecture Instruction Set Extensions and Future Features Programming
Reference, 319433-038.

Kan Liang (23):
  x86/cpufeatures: Add Architectural LBRs feature bit
  perf/x86/intel/lbr: Add a function pointer for LBR reset
  perf/x86/intel/lbr: Add a function pointer for LBR read
  perf/x86/intel/lbr: Add the function pointers for LBR save and restore
  perf/x86/intel/lbr: Factor out a new struct for generic optimization
  perf/x86/intel/lbr: Use dynamic data structure for task_ctx
  x86/msr-index: Add bunch of MSRs for Arch LBR
  perf/x86: Expose CPUID enumeration bits for arch LBR
  perf/x86/intel: Check Arch LBR MSRs
  perf/x86/intel/lbr: Support LBR_CTL
  perf/x86/intel/lbr: Unify the stored format of LBR information
  perf/x86/intel/lbr: Factor out rdlbr_all() and wrlbr_all()
  perf/x86/intel/lbr: Factor out intel_pmu_store_lbr
  perf/x86/intel/lbr: Support Architectural LBR
  perf/core: Factor out functions to allocate/free the task_ctx_data
  perf/core: Use kmem_cache to allocate the PMU specific data
  perf/x86/intel/lbr: Create kmem_cache for the LBR context data
  perf/x86: Remove task_ctx_size
  x86/fpu: Use proper mask to replace full instruction mask
  x86/fpu/xstate: Support dynamic supervisor feature for LBR
  x86/fpu/xstate: Add helpers for LBR dynamic supervisor feature
  perf/x86/intel/lbr: Support XSAVES/XRSTORS for LBR context switch
  perf/x86/intel/lbr: Support XSAVES for arch LBR read

 arch/x86/events/core.c              |   2 +-
 arch/x86/events/intel/core.c        |  42 ++-
 arch/x86/events/intel/ds.c          |   4 +-
 arch/x86/events/intel/lbr.c         | 656 ++++++++++++++++++++++++++++++------
 arch/x86/events/perf_event.h        | 117 ++++++-
 arch/x86/include/asm/cpufeatures.h  |   1 +
 arch/x86/include/asm/fpu/internal.h |  47 +--
 arch/x86/include/asm/fpu/types.h    |  27 ++
 arch/x86/include/asm/fpu/xstate.h   |  36 ++
 arch/x86/include/asm/msr-index.h    |  16 +
 arch/x86/include/asm/perf_event.h   |  46 ++-
 arch/x86/kernel/fpu/core.c          |  39 +++
 arch/x86/kernel/fpu/xstate.c        |  89 ++++-
 include/linux/perf_event.h          |   5 +-
 kernel/events/core.c                |  25 +-
 15 files changed, 968 insertions(+), 184 deletions(-)

-- 
2.7.4

