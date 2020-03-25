Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF54C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20F6215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GWfoIT0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgCYHLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 03:11:30 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:43309 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgCYHL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 03:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585120288; x=1616656288;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=G9rJYQKzg3U2ptZHargVYHRCAVs2Et3zM9ahnClfA+0=;
  b=GWfoIT0ZwjV2iGPtv7RBsrHeDeQx2pKT5vKJnQ+RjHEvJLYjBCPvMeLk
   3+3AagWflmNNSnZFzKUAQXg0gk7rJwnA5EjINNiPsdZx8GzBbJYNxUmmX
   qmUeypHHnfpT0jISUJZixvcTuLTeflhqb6I1YHlSmqA5SQrlMEdum6yVt
   s=;
IronPort-SDR: +7Z1O5fiICnGTpwS1n7M/HtgyQ9xGlJ3wMTwUxAx96FfmmJPXM87ogECg2pSLP5duXLajCQkwW
 +LtaPKnooIFA==
X-IronPort-AV: E=Sophos;i="5.72,303,1580774400"; 
   d="scan'208";a="22635708"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 25 Mar 2020 07:11:14 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id 71366A2396;
        Wed, 25 Mar 2020 07:11:13 +0000 (UTC)
Received: from EX13D01UWA001.ant.amazon.com (10.43.160.60) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 25 Mar 2020 07:11:13 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13d01UWA001.ant.amazon.com (10.43.160.60) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 25 Mar 2020 07:11:12 +0000
Received: from localhost (10.85.0.131) by mail-relay.amazon.com (10.43.61.243)
 with Microsoft SMTP Server id 15.0.1367.3 via Frontend Transport; Wed, 25 Mar
 2020 07:11:11 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
CC:     <tony.luck@intel.com>, <keescook@chromium.org>, <x86@kernel.org>,
        <benh@kernel.crashing.org>, <dave.hansen@intel.com>,
        Balbir Singh <sblbir@amazon.com>
Subject: [RFC PATCH v2 0/4] arch/x86: Optionally flush L1D on context switch
Date:   Wed, 25 Mar 2020 18:10:57 +1100
Message-ID: <20200325071101.29556-1-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a continuation of RFC/PoC to start the discussion on optionally
flushing L1D cache.  The goal is to allow tasks that are paranoid due to the
recent snoop assisted data sampling vulnerabilites, to flush their L1D on being
switched out.  This protects their data from being snooped or leaked via
side channels after the task has context switched out.

The points of discussion/review are (with updates):

1. Discuss the use case and the right approach to address this
A. Generally there seems to be consensus that we need this

2. Does an arch prctl allowing for opt-in flushing make sense, would other
   arches care about something similar?
A. We definitely build this for x86, have not heard from any other arch
   maintainers. There was suggestion to make this a prctl and let each
   arch implement L1D flushing if needed, there is no arch agnostic
   software L1D flush.

3. There is a fallback software L1D load, similar to what L1TF does, but
   we don't prefetch the TLB, is that sufficient?
A. There was no conclusion, I suspect we don't need this

4. Should we consider cleaning up the L1D on arrival of tasks?
A. For now, we think this case is not the priority for this patchset.

In summary, this is an early PoC to start the discussion on the need for
conditional L1D flushing based on the security posture of the
application and the sensitivity of the data it has access to or might
have access to.

Changelog v2:
 - Reuse existing code for allocation and flush
 - Simplify the goto logic in the actual l1d_flush function
 - Optimize the code path with jump labels/static functions

Cc: keescook@chromium.org

Balbir Singh (4):
  arch/x86/kvm: Refactor l1d flush lifecycle management
  arch/x86: Refactor tlbflush and l1d flush
  arch/x86: Optionally flush L1D on context switch
  arch/x86: L1D flush, optimize the context switch

 arch/x86/include/asm/cacheflush.h    |  6 ++
 arch/x86/include/asm/nospec-branch.h |  2 +
 arch/x86/include/asm/thread_info.h   |  4 ++
 arch/x86/include/asm/tlbflush.h      |  6 ++
 arch/x86/include/uapi/asm/prctl.h    |  3 +
 arch/x86/kernel/Makefile             |  1 +
 arch/x86/kernel/l1d_flush.c          | 85 ++++++++++++++++++++++++++++
 arch/x86/kernel/process_64.c         | 10 +++-
 arch/x86/kvm/vmx/vmx.c               | 56 +++---------------
 arch/x86/mm/tlb.c                    | 85 ++++++++++++++++++++++++++++
 10 files changed, 209 insertions(+), 49 deletions(-)
 create mode 100644 arch/x86/kernel/l1d_flush.c

-- 
2.17.1

