Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8A5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 02:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4CBE21775
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 02:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbgGaC5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 22:57:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:49992 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731162AbgGaC5j (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 22:57:39 -0400
IronPort-SDR: ko4lvX06MtdGadiPlhxL+4UDWQSq0mlRzM2H9cRVJZE4+cnkPb78OXpngwEaUVYP1XXjGrDRXd
 XGQxctZ5mGLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="131794857"
X-IronPort-AV: E=Sophos;i="5.75,416,1589266800"; 
   d="scan'208";a="131794857"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 19:57:38 -0700
IronPort-SDR: R5rSCbzYycekZZ4HukUJXuEdWw3IRG+3nauNBPwTSbGgK3VNWZ/mHX0Wcv311vI/HwJIwgZuV8
 uWogfHfxWkIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,416,1589266800"; 
   d="scan'208";a="323103310"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jul 2020 19:57:34 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     peterz@infradead.org, mingo@redhat.com, oleg@redhat.com,
        acme@kernel.org, jolsa@kernel.org
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 1/2] Missing instruction_pointer_set() instances
Date:   Fri, 31 Jul 2020 10:56:16 +0800
Message-Id: <20200731025617.16243-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential security issue that perf kernel samples
may be leaked even though kernel sampling is disabled. For fixing
the potential leakage, the idea is to use instruction_pointer_set
to set invalid ip address in leaked perf samples in some cases.

But instruction_pointer_set is missing on some architectures.
Define instruction_pointer_set for these architectures.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 arch/alpha/include/asm/ptrace.h  | 6 ++++++
 arch/arc/include/asm/ptrace.h    | 6 ++++++
 arch/nds32/include/asm/ptrace.h  | 7 +++++++
 arch/xtensa/include/asm/ptrace.h | 6 ++++++
 4 files changed, 25 insertions(+)

diff --git a/arch/alpha/include/asm/ptrace.h b/arch/alpha/include/asm/ptrace.h
index df5f317ab3fc..c464d525c110 100644
--- a/arch/alpha/include/asm/ptrace.h
+++ b/arch/alpha/include/asm/ptrace.h
@@ -25,4 +25,10 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
 	return regs->r0;
 }
 
+static inline void instruction_pointer_set(struct pt_regs *regs,
+					   unsigned long val)
+{
+	regs->pc = val;
+}
+
 #endif
diff --git a/arch/arc/include/asm/ptrace.h b/arch/arc/include/asm/ptrace.h
index 2fdb87addadc..8869a6c0fe8c 100644
--- a/arch/arc/include/asm/ptrace.h
+++ b/arch/arc/include/asm/ptrace.h
@@ -154,6 +154,12 @@ static inline long regs_return_value(struct pt_regs *regs)
 	return (long)regs->r0;
 }
 
+static inline void instruction_pointer_set(struct pt_regs *regs,
+					   unsigned long val)
+{
+	regs->ret = val;
+}
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PTRACE_H */
diff --git a/arch/nds32/include/asm/ptrace.h b/arch/nds32/include/asm/ptrace.h
index 919ee223620c..19a916bef7f5 100644
--- a/arch/nds32/include/asm/ptrace.h
+++ b/arch/nds32/include/asm/ptrace.h
@@ -62,6 +62,13 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
 {
 	return regs->uregs[0];
 }
+
+static inline void instruction_pointer_set(struct pt_regs *regs,
+					   unsigned long val)
+{
+	regs->ipc = val;
+}
+
 extern void show_regs(struct pt_regs *);
 /* Avoid circular header include via sched.h */
 struct task_struct;
diff --git a/arch/xtensa/include/asm/ptrace.h b/arch/xtensa/include/asm/ptrace.h
index b109416dc07e..82ab1ba99259 100644
--- a/arch/xtensa/include/asm/ptrace.h
+++ b/arch/xtensa/include/asm/ptrace.h
@@ -90,6 +90,12 @@ struct pt_regs {
 # define return_pointer(regs) (MAKE_PC_FROM_RA((regs)->areg[0], \
 					       (regs)->areg[1]))
 
+static inline void instruction_pointer_set(struct pt_regs *regs,
+					   unsigned long val)
+{
+	regs->pc = val;
+}
+
 # ifndef CONFIG_SMP
 #  define profile_pc(regs) instruction_pointer(regs)
 # else
-- 
2.17.1

