Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06859C2D0F4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 03:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5CE20644
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 03:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="v1cnT5gu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgDFDUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 23:20:11 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:25919 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDFDUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 23:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586143211; x=1617679211;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=FfIfYWIhceD/21M4mLWk/IqLp1GW2LZcXuOV3mWhUjU=;
  b=v1cnT5gu7hJ8r4WDWvWEwbPvLO0wVZl3t7qc/KO0hs+OOJoVU0nb3aAf
   QYkRXQqebEEUYbQk19XO1Kl8kLUjGsKmWxjEGwMunj5yFcDYdMboDxDhw
   nmTHzfPdUZAv56yx7j7SbpQ9V94iXAu1XoP6Fr+PuZJBPArXYe/gVD154
   U=;
IronPort-SDR: EDlsPlc6l6z3vKSLilWAWcBbCZsA2nujYCGM85ePjC7qhRmcWz9U0pF1UN4rBlTralKDLsX6P1
 ljbbPrkWI2kQ==
X-IronPort-AV: E=Sophos;i="5.72,349,1580774400"; 
   d="scan'208";a="25641356"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 06 Apr 2020 03:19:58 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id 35BFAA17C0;
        Mon,  6 Apr 2020 03:19:57 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Apr 2020 03:19:56 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Apr 2020 03:19:56 +0000
Received: from localhost (10.85.6.171) by mail-relay.amazon.com (10.43.62.224)
 with Microsoft SMTP Server id 15.0.1497.2 via Frontend Transport; Mon, 6 Apr
 2020 03:19:54 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        "Balbir Singh" <sblbir@amazon.com>
Subject: [PATCH v2 0/4] arch/x86: Optionally flush L1D on context switch
Date:   Mon, 6 Apr 2020 13:19:42 +1000
Message-ID: <20200406031946.11815-1-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a mechanisn to flush the L1D cache on context switch.  The goal
is to allow tasks that are paranoid due to the recent snoop assisted data
sampling vulnerabilites, to flush their L1D on being switched out.
This protects their data from being snooped or leaked via side channels
after the task has context switched out.

The core of the patches is patch 3, the first two refactor the code so
that common bits can be reused.

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

The previous version of this patch posted at:

https://lore.kernel.org/lkml/20200402062401.29856-1-sblbir@amazon.com/

Balbir Singh (4):
  arch/x86/kvm: Refactor l1d flush lifecycle management
  arch/x86: Refactor tlbflush and l1d flush
  arch/x86: Optionally flush L1D on context switch
  arch/x86: Add L1D flushing Documentation

 Documentation/admin-guide/hw-vuln/index.rst   |  1 +
 .../admin-guide/hw-vuln/l1d_flush.rst         | 40 ++++++++
 arch/x86/include/asm/cacheflush.h             |  6 ++
 arch/x86/include/asm/thread_info.h            |  6 +-
 arch/x86/include/asm/tlbflush.h               |  2 +-
 arch/x86/include/uapi/asm/prctl.h             |  3 +
 arch/x86/kernel/Makefile                      |  1 +
 arch/x86/kernel/l1d_flush.c                   | 85 +++++++++++++++++
 arch/x86/kernel/process_64.c                  | 10 +-
 arch/x86/kvm/vmx/vmx.c                        | 56 ++---------
 arch/x86/mm/tlb.c                             | 94 ++++++++++++++-----
 11 files changed, 232 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/admin-guide/hw-vuln/l1d_flush.rst
 create mode 100644 arch/x86/kernel/l1d_flush.c

-- 
2.17.1

