Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FF7C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52A18207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="f126Ewz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbgG2ALd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:11:33 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:15422 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730219AbgG2ALb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 20:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595981492; x=1627517492;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=7Oc9V4RDTZk1Ywvt8FSw4+O3aSjH/U/7af3EsamIx2s=;
  b=f126Ewz6V+cdHRw6YVBLEixyLvMhcZ/iG08Td079TVY6cW+hJqwo6kHt
   ZJjGloLOH82p0klj09VUszcLu/l6Ng8aqJAaAlDW2ZdXVg21Yg0/ttY0z
   cJF1eeCdHbbXx697nVkYOl4FgN17g2w0cd3J9fYvzOkCjBuWcMa/58U87
   I=;
IronPort-SDR: R4s/W+lI+qLH6v8AQ2ALqLBSxrRPGfst6OQ+40LaapuKloQQeDjvsuDIWAN77NAn4XI+ymDYOF
 Y9BaKGJr/ArA==
X-IronPort-AV: E=Sophos;i="5.75,408,1589241600"; 
   d="scan'208";a="62520189"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 29 Jul 2020 00:11:27 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id 0BC2228644C;
        Wed, 29 Jul 2020 00:11:23 +0000 (UTC)
Received: from EX13D01UWA003.ant.amazon.com (10.43.160.107) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 29 Jul 2020 00:11:23 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13d01UWA003.ant.amazon.com (10.43.160.107) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 29 Jul 2020 00:11:23 +0000
Received: from localhost (10.143.192.232) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Jul 2020 00:11:21 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, <torvalds@linux-foundation.org>,
        <mingo@kernel.org>, Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v2 0/5] Implement optional L1D flushing for
Date:   Wed, 29 Jul 2020 10:10:58 +1000
Message-ID: <20200729001103.6450-1-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a mechanism that allows tasks to conditionally flush
their L1D cache (mitigation mechanism suggested in 2). The previous
posts of these patches were sent for inclusion (see 3) and were not
included due to the concern for the need for additional checks,
those checks were:

1. Implement this mechanism only for CPUs affected by the L1TF bug
2. Disable the software fallback
3. Provide an override to disable this mechanism completely

The patches support a use case where the entire system is not in
non SMT mode, but rather a few CPUs can have their SMT turned off
and processes that want to opt-in are expected to run on non SMT
cores. This gives the administrator complete control over setting
up the mitigation for the issue. In addition, the administrator
has a boot time override (l1d_flush_out=off) to turn of the mechanism
completely.

To implement these efficiently, a new per cpu view of whether the core
is in SMT mode or not is implemented in patch 1. The code is refactored
in patch 2 so that the existing code can allow for other speculation
related checks when switching mm between tasks, this mechanism has not
changed since the last post. The ability to flush L1D for tasks if the
TIF_SPEC_L1D_FLUSH bit is set and the task has context switched out of a
non SMT core is provided by patch 3. Hooks for the user space API, for
this feature to be invoked via prctl are provided in patch 4, along with
the checks described above (1, 2, and 3).

The checks are:
	a. If the CPU is affected by L1TF
        b. Hardware L1D flush mechanism is available
	c. The task opting in has it's affinity set to only non SMT cores. 

Documentation updates are in patch 5, with updates on l1d_flush, the
prctl changes and updates to the kernel-parameters (l1d_flush_out).

Balbir Singh (5):
  Add a per-cpu view of SMT state
  x86/mm: Refactor cond_ibpb() to support other use cases
  x86/mm: Optionally flush L1D on context switch
  prctl: Hook L1D flushing in via prctl
  Documentation: Add L1D flushing Documentation

References:
[1] https://software.intel.com/security-software-guidance/software-guidance/snoop-assisted-l1-data-sampling
[2] https://software.intel.com/security-software-guidance/insights/deep-dive-snoop-assisted-l1-data-sampling
[3] https://lkml.org/lkml/2020/6/2/1150

 Documentation/admin-guide/hw-vuln/index.rst   |   1 +
 .../admin-guide/hw-vuln/l1d_flush.rst         |  70 ++++++++++++
 .../admin-guide/kernel-parameters.txt         |  17 +++
 Documentation/userspace-api/spec_ctrl.rst     |   8 ++
 arch/x86/include/asm/cacheflush.h             |   8 ++
 arch/x86/include/asm/processor.h              |   2 +
 arch/x86/include/asm/thread_info.h            |   9 +-
 arch/x86/include/asm/tlbflush.h               |   2 +-
 arch/x86/kernel/cpu/bugs.c                    |  54 +++++++++
 arch/x86/kernel/smpboot.c                     |  11 +-
 arch/x86/mm/tlb.c                             | 104 +++++++++++++-----
 include/uapi/linux/prctl.h                    |   1 +
 12 files changed, 258 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/admin-guide/hw-vuln/l1d_flush.rst

-- 
2.17.1

