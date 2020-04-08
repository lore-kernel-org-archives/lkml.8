Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F1AC2BA1B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCAD920768
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jSI+qRSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgDHJDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:03:01 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:17563 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgDHJC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586336579; x=1617872579;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Yctj+snLI3+lFrXtyXQAbeRqej9FGBlgOHRzr0ajYGA=;
  b=jSI+qRStTw/ViqXdIj7sWIcltyzmb803m6dJd/aECLIqdgLJH1Sk+Ezu
   txWa7//NPLh58p8kN7HNgedAeSlzIHdZgnKP+bndOAKMqWyYwHkr/aTLX
   s+SUvnWThsAQsMBhvpJWLsBruAGAZvi+UQ3+AvKUSc6DaFNbIGskkFkog
   A=;
IronPort-SDR: JwBgGlbZOxEGaB8yZfchS6SiFkoJLUzdB6CZBympaPQ+gRaWcybrHiVDVxGoHKlUXfVYnfrL0M
 n/tnC4GN8h4g==
X-IronPort-AV: E=Sophos;i="5.72,357,1580774400"; 
   d="scan'208";a="24735022"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 08 Apr 2020 09:02:46 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com (Postfix) with ESMTPS id 653C1A0288;
        Wed,  8 Apr 2020 09:02:44 +0000 (UTC)
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Apr 2020 09:02:42 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13d01UWB003.ant.amazon.com (10.43.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 8 Apr 2020 09:02:41 +0000
Received: from localhost (10.85.0.235) by mail-relay.amazon.com (10.43.61.243)
 with Microsoft SMTP Server id 15.0.1497.2 via Frontend Transport; Wed, 8 Apr
 2020 09:02:40 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        "Balbir Singh" <sblbir@amazon.com>
Subject: [PATCH v3 0/5] Optionally flush L1D on context switch
Date:   Wed, 8 Apr 2020 19:02:24 +1000
Message-ID: <20200408090229.16467-1-sblbir@amazon.com>
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

The core of the patches is patch 3, the rest largely refactor the code
so that common bits can be reused.

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

The previous version of this patch posted at:

https://lore.kernel.org/lkml/20200406031946.11815-1-sblbir@amazon.com/

Balbir Singh (5):
  arch/x86/kvm: Refactor l1d flush lifecycle management
  arch/x86: Refactor tlbflush and l1d flush
  arch/x86/mm: Refactor cond_ibpb() to support other use cases
  arch/x86: Optionally flush L1D on context switch
  arch/x86: Add L1D flushing Documentation

 Documentation/admin-guide/hw-vuln/index.rst   |   1 +
 .../admin-guide/hw-vuln/l1d_flush.rst         |  40 +++++++
 arch/x86/include/asm/cacheflush.h             |   6 +
 arch/x86/include/asm/thread_info.h            |   6 +-
 arch/x86/include/asm/tlbflush.h               |   2 +-
 arch/x86/kernel/Makefile                      |   1 +
 arch/x86/kernel/l1d_flush.c                   |  85 ++++++++++++++
 arch/x86/kvm/vmx/vmx.c                        |  56 ++-------
 arch/x86/mm/tlb.c                             | 109 ++++++++++++++----
 include/uapi/linux/prctl.h                    |   4 +
 kernel/sys.c                                  |  20 ++++
 11 files changed, 259 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/admin-guide/hw-vuln/l1d_flush.rst
 create mode 100644 arch/x86/kernel/l1d_flush.c

-- 
2.17.1

