Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA1DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 106B521582
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbgFSOHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:07:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:54724 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgFSOHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:07:45 -0400
IronPort-SDR: mElC6bW1dTEelNrDRqtzqJH8n+PJtqTP4P+PB80DbJV5qx8XmVNGnWaaG/0EV+lldRbpus+W7j
 9WJD5EH/DVNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="204452794"
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="204452794"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 07:07:41 -0700
IronPort-SDR: +vQFXuJzIGV53zy6T2aJIOSVbKFBecqWzIaKOBKcqZNCm5rikq2SqqUgaaTcn3wmT/bpatn3c4
 O4UCl3Nji02A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="383837383"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jun 2020 07:07:40 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 00/21] Support Architectural LBR
Date:   Fri, 19 Jun 2020 07:03:48 -0700
Message-Id: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

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

Kan Liang (21):
  x86/cpufeatures: Add Architectural LBRs feature bit
  perf/x86/intel/lbr: Add pointers for LBR enable and disable
  perf/x86/intel/lbr: Add pointer for LBR reset
  perf/x86/intel/lbr: Add pointer for LBR read
  perf/x86/intel/lbr: Add pointers for LBR save and restore
  perf/x86/intel/lbr: Factor out a new struct for generic optimization
  perf/x86/intel/lbr: Use dynamic data structure for task_ctx
  x86/msr-index: Add bunch of MSRs for Arch LBR
  perf/x86: Expose CPUID enumeration bits for arch LBR
  perf/x86/intel: Check Arch LBR MSRs
  perf/x86/intel/lbr: Support LBR_CTL
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
 arch/x86/events/intel/core.c        |  50 ++-
 arch/x86/events/intel/lbr.c         | 633 +++++++++++++++++++++++++++++++-----
 arch/x86/events/perf_event.h        | 159 ++++++++-
 arch/x86/include/asm/cpufeatures.h  |   1 +
 arch/x86/include/asm/fpu/internal.h |   9 +-
 arch/x86/include/asm/fpu/types.h    |  26 ++
 arch/x86/include/asm/fpu/xstate.h   |  36 ++
 arch/x86/include/asm/msr-index.h    |  20 ++
 arch/x86/kernel/fpu/xstate.c        |  90 ++++-
 include/linux/perf_event.h          |   5 +-
 kernel/events/core.c                |  25 +-
 12 files changed, 951 insertions(+), 105 deletions(-)

-- 
2.7.4

