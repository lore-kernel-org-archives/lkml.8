Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF57C47255
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 01:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F39920801
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 01:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NHL9fG7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgEJBsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 21:48:17 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:61591 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgEJBsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 21:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589075296; x=1620611296;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=gfYFbOc+P+0dhlDBew6Xq8gMqB1dbCq2uZX/1pgAvH0=;
  b=NHL9fG7J3WfxP2UW42p5oMVWtsmXa7e1i/P0LLwi9qAgo8iYgsNy8xsU
   6/J4E0XtExJdjDO9dkVILVG2L/6VQUkupgLaEh6a/SlhBCKc7xlfWEv+X
   ouHf7DBppcIDh1EuYwmE8lZYdHfkfOCiduXjCn3/hoCsgvWPBcut5+nOV
   I=;
IronPort-SDR: oXmFeTFiuRa0Hl8A/4nkJay+4qZS2e3FsxwZmg9H5NfH0suNgatoAGWcN4uGvccXT6QbJk4r+x
 IihQ+wVnP7WQ==
X-IronPort-AV: E=Sophos;i="5.73,373,1583193600"; 
   d="scan'208";a="42304099"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 10 May 2020 01:48:14 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id 542E0A207C;
        Sun, 10 May 2020 01:48:09 +0000 (UTC)
Received: from EX13D01UWA002.ant.amazon.com (10.43.160.74) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 10 May 2020 01:48:09 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13d01UWA002.ant.amazon.com (10.43.160.74) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 10 May 2020 01:48:09 +0000
Received: from localhost (10.85.6.121) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 10 May 2020 01:48:08 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v6 0/6] Optionally flush L1D on context switch
Date:   Sun, 10 May 2020 11:47:57 +1000
Message-ID: <20200510014803.12190-1-sblbir@amazon.com>
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


Changelog v6:
- Fix the complaint about variable shadowing (Reported-by: kbuild test
  robot <lkp@intel.com>)
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

https://lore.kernel.org/lkml/20200504041343.9651-1-sblbir@amazon.com/

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

