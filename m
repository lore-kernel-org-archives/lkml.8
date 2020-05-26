Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B0FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 01:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8CB0207CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 01:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388551AbgEZBmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 21:42:49 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:56611 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388515AbgEZBmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 21:42:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Tzg5ulH_1590457362;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tzg5ulH_1590457362)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 May 2020 09:42:42 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [RFC PATCH V2 7/7] x86/entry: remove DB1 stack and DB2 hole from cpu entry area
Date:   Tue, 26 May 2020 01:42:21 +0000
Message-Id: <20200526014221.2119-8-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200526014221.2119-1-laijs@linux.alibaba.com>
References: <20200525152517.GY325280@hirez.programming.kicks-ass.net>
 <20200526014221.2119-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IST-shift code is removed from entry code, #DB will stick to
DB stack only. So we remove the DB1 stack and the DB2 hole.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/cpu_entry_area.h | 12 +++---------
 arch/x86/kernel/asm-offsets_64.c      |  4 ----
 arch/x86/kernel/dumpstack_64.c        | 10 +++-------
 arch/x86/mm/cpu_entry_area.c          |  4 +---
 4 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 02c0078d3787..8902fdb7de13 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -11,15 +11,11 @@
 #ifdef CONFIG_X86_64
 
 /* Macro to enforce the same ordering and stack sizes */
-#define ESTACKS_MEMBERS(guardsize, db2_holesize)\
+#define ESTACKS_MEMBERS(guardsize)		\
 	char	DF_stack_guard[guardsize];	\
 	char	DF_stack[EXCEPTION_STKSZ];	\
 	char	NMI_stack_guard[guardsize];	\
 	char	NMI_stack[EXCEPTION_STKSZ];	\
-	char	DB2_stack_guard[guardsize];	\
-	char	DB2_stack[db2_holesize];	\
-	char	DB1_stack_guard[guardsize];	\
-	char	DB1_stack[EXCEPTION_STKSZ];	\
 	char	DB_stack_guard[guardsize];	\
 	char	DB_stack[EXCEPTION_STKSZ];	\
 	char	MCE_stack_guard[guardsize];	\
@@ -28,12 +24,12 @@
 
 /* The exception stacks' physical storage. No guard pages required */
 struct exception_stacks {
-	ESTACKS_MEMBERS(0, 0)
+	ESTACKS_MEMBERS(0)
 };
 
 /* The effective cpu entry area mapping with guard pages. */
 struct cea_exception_stacks {
-	ESTACKS_MEMBERS(PAGE_SIZE, EXCEPTION_STKSZ)
+	ESTACKS_MEMBERS(PAGE_SIZE)
 };
 
 /*
@@ -42,8 +38,6 @@ struct cea_exception_stacks {
 enum exception_stack_ordering {
 	ESTACK_DF,
 	ESTACK_NMI,
-	ESTACK_DB2,
-	ESTACK_DB1,
 	ESTACK_DB,
 	ESTACK_MCE,
 	N_EXCEPTION_STACKS
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index 472378330169..4b4974d91d90 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -57,10 +57,6 @@ int main(void)
 	BLANK();
 #undef ENTRY
 
-	DEFINE(DB_STACK_OFFSET, offsetof(struct cea_exception_stacks, DB_stack) -
-	       offsetof(struct cea_exception_stacks, DB1_stack));
-	BLANK();
-
 #ifdef CONFIG_STACKPROTECTOR
 	DEFINE(stack_canary_offset, offsetof(struct fixed_percpu_data, stack_canary));
 	BLANK();
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 460ae7f66818..6b7051fa3669 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -22,15 +22,13 @@
 static const char * const exception_stack_names[] = {
 		[ ESTACK_DF	]	= "#DF",
 		[ ESTACK_NMI	]	= "NMI",
-		[ ESTACK_DB2	]	= "#DB2",
-		[ ESTACK_DB1	]	= "#DB1",
 		[ ESTACK_DB	]	= "#DB",
 		[ ESTACK_MCE	]	= "#MC",
 };
 
 const char *stack_type_name(enum stack_type type)
 {
-	BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
+	BUILD_BUG_ON(N_EXCEPTION_STACKS != 4);
 
 	if (type == STACK_TYPE_IRQ)
 		return "IRQ";
@@ -72,14 +70,12 @@ struct estack_pages {
 /*
  * Array of exception stack page descriptors. If the stack is larger than
  * PAGE_SIZE, all pages covering a particular stack will have the same
- * info. The guard pages including the not mapped DB2 stack are zeroed
- * out.
+ * info. The guard pages are zeroed out.
  */
 static const
 struct estack_pages estack_pages[CEA_ESTACK_PAGES] ____cacheline_aligned = {
 	EPAGERANGE(DF),
 	EPAGERANGE(NMI),
-	EPAGERANGE(DB1),
 	EPAGERANGE(DB),
 	EPAGERANGE(MCE),
 };
@@ -91,7 +87,7 @@ static bool in_exception_stack(unsigned long *stack, struct stack_info *info)
 	struct pt_regs *regs;
 	unsigned int k;
 
-	BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
+	BUILD_BUG_ON(N_EXCEPTION_STACKS != 4);
 
 	begin = (unsigned long)__this_cpu_read(cea_exception_stacks);
 	/*
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 5199d8a1daf1..686af163be20 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -102,12 +102,10 @@ static void __init percpu_setup_exception_stacks(unsigned int cpu)
 
 	/*
 	 * The exceptions stack mappings in the per cpu area are protected
-	 * by guard pages so each stack must be mapped separately. DB2 is
-	 * not mapped; it just exists to catch triple nesting of #DB.
+	 * by guard pages so each stack must be mapped separately.
 	 */
 	cea_map_stack(DF);
 	cea_map_stack(NMI);
-	cea_map_stack(DB1);
 	cea_map_stack(DB);
 	cea_map_stack(MCE);
 }
-- 
2.20.1

