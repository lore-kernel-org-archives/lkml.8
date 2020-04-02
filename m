Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0781EC2BA13
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 06:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D307F2078B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 06:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Df6tQLD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733174AbgDBG0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 02:26:37 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:59802 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729282AbgDBG0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 02:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585808797; x=1617344797;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=INjASc5VYRvoGeBiJ1p7WuJDA8sR20pLeuBfaTLPg1Y=;
  b=Df6tQLD5wtjpoTvoInpwaM4LExd0UoPwGRuflXeC5e5OMgdJ4NElrpWH
   5d7g9FVWOGwbmna1YZHvUD250czcEMqrupIIy/UgwApHBbS5ZekTw1itC
   IsUMYlUf4L1gLKzrV5n9viSwMUaxPMVzfiVJTEYjf7MFwg1QoyeUC0DHr
   A=;
IronPort-SDR: 4RJ3gBK15+qT9PoWc0XeqAuscasQ/jGHssJbdfdRewIbYl2tkpcgkrtkUPDjzYoaqGrZ/0CcI0
 ygl+iMIIUIgg==
X-IronPort-AV: E=Sophos;i="5.72,334,1580774400"; 
   d="scan'208";a="25215332"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 02 Apr 2020 06:26:24 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id 4394EA30D0;
        Thu,  2 Apr 2020 06:26:20 +0000 (UTC)
Received: from EX13D01UWA003.ant.amazon.com (10.43.160.107) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Apr 2020 06:26:20 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13d01UWA003.ant.amazon.com (10.43.160.107) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 2 Apr 2020 06:26:20 +0000
Received: from localhost (10.85.6.202) by mail-relay.amazon.com
 (10.43.162.232) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 2 Apr 2020 06:26:19 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
CC:     <tony.luck@intel.com>, <keescook@chromium.org>, <x86@kernel.org>,
        <benh@kernel.crashing.org>, <dave.hansen@intel.com>,
        Balbir Singh <sblbir@amazon.com>
Subject: [PATCH 0/3] arch/x86: Optionally flush L1D on context switch
Date:   Thu, 2 Apr 2020 17:23:58 +1100
Message-ID: <20200402062401.29856-1-sblbir@amazon.com>
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

Changelog:
 - Refactor the code and reuse cond_ibpb() - code bits provided by tglx
 - Merge mm state tracking for ibpb and l1d flush
 - Rename TIF_L1D_FLUSH to TIF_SPEC_FLUSH_L1D

Changelog RFC:
 - Reuse existing code for allocation and flush
 - Simplify the goto logic in the actual l1d_flush function
 - Optimize the code path with jump labels/static functions

The RFC patch was previously posted at

https://lore.kernel.org/lkml/20200325071101.29556-1-sblbir@amazon.com/

Balbir Singh (3):
  arch/x86/kvm: Refactor l1d flush lifecycle management
  arch/x86: Refactor tlbflush and l1d flush
  arch/x86: Optionally flush L1D on context switch

 arch/x86/include/asm/cacheflush.h  |  6 ++
 arch/x86/include/asm/thread_info.h |  6 +-
 arch/x86/include/asm/tlbflush.h    |  2 +-
 arch/x86/include/uapi/asm/prctl.h  |  3 +
 arch/x86/kernel/Makefile           |  1 +
 arch/x86/kernel/l1d_flush.c        | 85 +++++++++++++++++++++++++++
 arch/x86/kernel/process_64.c       | 10 +++-
 arch/x86/kvm/vmx/vmx.c             | 56 +++---------------
 arch/x86/mm/tlb.c                  | 92 +++++++++++++++++++++++-------
 9 files changed, 189 insertions(+), 72 deletions(-)
 create mode 100644 arch/x86/kernel/l1d_flush.c

-- 
2.17.1

