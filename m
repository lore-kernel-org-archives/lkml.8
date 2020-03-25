Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F625C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130AC21582
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZSOy8kaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgCYHL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 03:11:57 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:63936 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbgCYHL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 03:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585120317; x=1616656317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=FJ/bBO7Tit5p8Cbs7vLj98vSyfkhlUtRHZbkrSpVras=;
  b=ZSOy8kaF3INALoPlOtwsvdwpXLKnIdlN++wAxUT/3fYfVXXxVwQBEaTV
   IsZ8bjGTk2g4TpU4ijQSInSBh95OSSQz6looDruAtj+rNsZUw8vsKKb1A
   9iQi2xos8qqpOLpwjOAqV5sdlmDHmu+jyLPjB+0NB3itlozk2G4fQ2vJo
   Y=;
IronPort-SDR: gOlWDsdotdKo5K8JAcNJyD0h0DaqcvDoGvWd3nGLK2CMbScoaW/Ei3iKyHsHjxfhY3CH7t9mCT
 2p/VSdvEoVfQ==
X-IronPort-AV: E=Sophos;i="5.72,303,1580774400"; 
   d="scan'208";a="23059979"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 25 Mar 2020 07:11:45 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id 279D0A04AB;
        Wed, 25 Mar 2020 07:11:41 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 25 Mar 2020 07:11:24 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 25 Mar 2020 07:11:24 +0000
Received: from localhost (10.85.0.131) by mail-relay.amazon.com (10.43.62.224)
 with Microsoft SMTP Server id 15.0.1367.3 via Frontend Transport; Wed, 25 Mar
 2020 07:11:22 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
CC:     <tony.luck@intel.com>, <keescook@chromium.org>, <x86@kernel.org>,
        <benh@kernel.crashing.org>, <dave.hansen@intel.com>,
        Balbir Singh <sblbir@amazon.com>
Subject: [RFC PATCH v2 4/4] arch/x86: L1D flush, optimize the context switch
Date:   Wed, 25 Mar 2020 18:11:01 +1100
Message-ID: <20200325071101.29556-5-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200325071101.29556-1-sblbir@amazon.com>
References: <20200325071101.29556-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a static branch/jump label to optimize the code. Right now
we don't ref count the users, but that could be done if needed
in the future.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 arch/x86/include/asm/nospec-branch.h |  2 ++
 arch/x86/mm/tlb.c                    | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 07e95dcb40ad..371e28cea1f4 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -310,6 +310,8 @@ DECLARE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 DECLARE_STATIC_KEY_FALSE(mds_user_clear);
 DECLARE_STATIC_KEY_FALSE(mds_idle_clear);
 
+DECLARE_STATIC_KEY_FALSE(switch_mm_l1d_flush);
+
 #include <asm/segment.h>
 
 /**
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 22f96c5f74f0..bed2b6a5490d 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -155,6 +155,11 @@ EXPORT_SYMBOL_GPL(leave_mm);
 static void *l1d_flush_pages;
 static DEFINE_MUTEX(l1d_flush_mutex);
 
+/* Flush L1D on switch_mm() */
+DEFINE_STATIC_KEY_FALSE(switch_mm_l1d_flush);
+EXPORT_SYMBOL_GPL(switch_mm_l1d_flush);
+
+
 int enable_l1d_flush_for_task(struct task_struct *tsk)
 {
 	struct page *page;
@@ -170,6 +175,11 @@ int enable_l1d_flush_for_task(struct task_struct *tsk)
 			l1d_flush_pages = alloc_l1d_flush_pages();
 			if (!l1d_flush_pages)
 				return -ENOMEM;
+			/*
+			 * We could do more accurate ref counting
+			 * if needed
+			 */
+			static_branch_enable(&switch_mm_l1d_flush);
 		}
 		mutex_unlock(&l1d_flush_mutex);
 	}
@@ -195,6 +205,9 @@ static void l1d_flush(struct mm_struct *next, struct task_struct *tsk)
 {
 	struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
 
+	if (static_branch_unlikely(&switch_mm_l1d_flush))
+		return;
+
 	/*
 	 * If we are not really switching mm's, we can just return
 	 */
-- 
2.17.1

