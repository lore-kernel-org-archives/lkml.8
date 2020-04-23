Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B8DC55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73FAA21D79
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SL9CDGuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgDWOBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:01:44 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:6920 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgDWOBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587650500; x=1619186500;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=GlXA8QYdbNJSlsP6IcydE++snKBjUDYw7I1a/xcR9BQ=;
  b=SL9CDGuhnkgfmezzVe1AzbI0SEkVp6TddNtqYvrBEwnc6tu1Ot/umMOE
   OZ4o4bPdAZ4BQCLqjmCZ33J6op7tGNNm0cJITVyuUpw3DdRpuClCRWNvx
   t++YBGmhrZLzV5apWS6BcIdTPss4z1/+ath7BIfIkNf2o0DRW+OddE5Gq
   k=;
IronPort-SDR: Y2sPg+P8vTtT9NeP9g7kZM5zdL5sDKBNZw8fmnrzK0ZYUGM7Zi9GMEC4CuIiN8nDEo+Dcff9HW
 qo4BpHsi4MwQ==
X-IronPort-AV: E=Sophos;i="5.73,307,1583193600"; 
   d="scan'208";a="40451004"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 23 Apr 2020 14:01:37 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id 1055DA23D7;
        Thu, 23 Apr 2020 14:01:33 +0000 (UTC)
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 23 Apr 2020 14:01:33 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13d01UWB003.ant.amazon.com (10.43.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 23 Apr 2020 14:01:33 +0000
Received: from localhost (10.143.207.46) by mail-relay.amazon.com
 (10.43.62.224) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Apr 2020 14:01:31 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        "Balbir Singh" <sblbir@amazon.com>
Subject: [PATCH v4 0/6] Optionally flush L1D on context switch
Date:   Fri, 24 Apr 2020 00:01:19 +1000
Message-ID: <20200423140125.7332-1-sblbir@amazon.com>
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

https://lore.kernel.org/lkml/20200408090229.16467-1-sblbir@amazon.com/

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
 arch/x86/kernel/l1d_flush.c                   | 117 ++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c                        |  62 +---------
 arch/x86/mm/tlb.c                             |  83 +++++++++----
 include/uapi/linux/prctl.h                    |   4 +
 kernel/sys.c                                  |  20 +++
 11 files changed, 263 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/admin-guide/hw-vuln/l1d_flush.rst
 create mode 100644 arch/x86/kernel/l1d_flush.c

-- 
2.17.1

