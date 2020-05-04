Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2333C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 04:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3BA520705
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 04:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mlLHsuMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgEDENy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 00:13:54 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:23055 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgEDENx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 00:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1588565632; x=1620101632;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Yd+10rWQW4FomCOSZo0CIB/1DXTJzRoRxlZdKjs/E8c=;
  b=mlLHsuMppIyV1Q6h0CTBBwRNnMhujtCyUkHX5T6GysCgu+J90DCCy9L/
   q/M1FY/2WAv455nxWCb1AmCw7XLYRurMqA/yLxr4ZSetlcdFyqMTYbkjW
   LZyLx4QH0Qu32G4EuJcbMfzNI2Yyg7B+rOVR/Dd57P9NorZESLBpraM3o
   c=;
IronPort-SDR: 70cVZn55GgC9eivLNLsWmZ0NFCEq7C6mFhqPHlBnYFeEzZcmdq3aJGvmlXleNTYWeyjl/2aYtk
 WwHvRH/tJY5w==
X-IronPort-AV: E=Sophos;i="5.73,350,1583193600"; 
   d="scan'208";a="40970428"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 04 May 2020 04:13:51 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id 83491A18E1;
        Mon,  4 May 2020 04:13:50 +0000 (UTC)
Received: from EX13D01UWA004.ant.amazon.com (10.43.160.99) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 4 May 2020 04:13:50 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13d01UWA004.ant.amazon.com (10.43.160.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 4 May 2020 04:13:50 +0000
Received: from localhost (10.85.6.15) by mail-relay.amazon.com (10.43.62.224)
 with Microsoft SMTP Server id 15.0.1497.2 via Frontend Transport; Mon, 4 May
 2020 04:13:48 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v5 0/6] Optionally flush L1D on context switch
Date:   Mon, 4 May 2020 14:13:37 +1000
Message-ID: <20200504041343.9651-1-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a mechanism to flush the L1D cache on context switch.  The goal
is to allow tasks that are paranoid due to the recent snoop assisted data
sampling vulnerabilites, to flush their L1D on being switched out.
This protects their data from being snooped or leaked via side channels
after the task has context switched out.


Changelog v5:
- Based on Tom's recommendation, restrict the patches to Intel CPUs
  only (thomas.lendacky@amd.com)
- Update reviewed-by tags based on v4.
Changelog v4:
- Refactor the L1D flushing code even further, pages are now allocated
  once and never freed. Simplify the exported functions.
- Change the name prefixs to be more consistent (l1d_flush_*)
- Refactoring of the code done in the spirit of the comments, prctl
  still requires arch bits for get/set L1D flush and ofcourse in
  the arch switch_mm bits flushing the L1D cache.
Changelog v3:
 - Refactor the return value of what flush_l1d_cache_hw() returns
 - Refactor the code, so that the generic setup bits come first
   (patch 3 from previous posting is now patches 3 and 4)
 - Move from arch_prctl() to the prctl() interface as recommend
   in the reviews.
Changelog v2:
 - Fix a miss of mutex_unlock (caught by Borislav Petkov <bp@alien8.de>)
 - Add documentation about the changes (Josh Poimboeuf
   <jpoimboe@redhat.com>)

Changelog:
 - Refactor the code and reuse cond_ibpb() - code bits provided by tglx
 - Merge mm state tracking for ibpb and l1d flush
 - Rename TIF_L1D_FLUSH to TIF_SPEC_FLUSH_L1D

Changelog RFC:
 - Reuse existing code for allocation and flush
 - Simplify the goto logic in the actual l1d_flush function
 - Optimize the code path with jump labels/static functions

The previous version of these patches are posted at:

https://lore.kernel.org/lkml/20200423140125.7332-1-sblbir@amazon.com/


Balbir Singh (6):
  arch/x86/kvm: Refactor l1d flush lifecycle management
  arch/x86/kvm: Refactor tlbflush and l1d flush
  arch/x86/mm: Refactor cond_ibpb() to support other use cases
  arch/x86/kvm: Refactor L1D flushing
  Optionally flush L1D on context switch
  Documentation: Add L1D flushing Documentation

 Documentation/admin-guide/hw-vuln/index.rst   |   1 +
 .../admin-guide/hw-vuln/l1d_flush.rst         |  40 ++++++
 arch/x86/include/asm/cacheflush.h             |   8 ++
 arch/x86/include/asm/thread_info.h            |   7 +-
 arch/x86/include/asm/tlbflush.h               |   2 +-
 arch/x86/kernel/Makefile                      |   1 +
 arch/x86/kernel/l1d_flush.c                   | 120 ++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c                        |  62 +--------
 arch/x86/mm/tlb.c                             |  83 +++++++++---
 include/uapi/linux/prctl.h                    |   4 +
 kernel/sys.c                                  |  20 +++
 11 files changed, 266 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/admin-guide/hw-vuln/l1d_flush.rst
 create mode 100644 arch/x86/kernel/l1d_flush.c

-- 
2.17.1

