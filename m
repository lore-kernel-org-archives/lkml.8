Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BECC2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B6B20747
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wZCYSNEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgDGH2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 03:28:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47120 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgDGH17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 03:27:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0377Ra31152454;
        Tue, 7 Apr 2020 07:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=oi4MXjr6M18OyzeSSbbCVeHeM327zwlAeXbvcI1g+qo=;
 b=wZCYSNEywQ+0xv+j4iNdL7VMqWF93k/j27gwL6xPwoZJ/xWcFnRExxPTolk/eZfiT9Q0
 XtR27b5yV2C/Ck8qqEIsUAIHt8L2wSkC4ViBIYFbMKMG3TPUyz+SyVUv83MRlVaKBHfx
 8rNZC4eANl2JUljnHIMdLBa7gEPV+UQGwmff+XNiXIeqJuUkNAnlfgWrk3NIy/n6OB8a
 FctZC7MmsM/GBfjeMRjQ+w3b9BMsyQI1N+Sa11zjqhkuB8dj5okaq23L89q/A+C+jhNo
 5+yhcUsqvyq69o5D9DRlsc9sDq3PTZDeG4or9kf4IdePNq3Tir+w8lTfDlor90UkKS81 0w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 308ffd93hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 07:27:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0377RSOq151362;
        Tue, 7 Apr 2020 07:27:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30741d9tyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 07:27:30 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0377RSjQ008146;
        Tue, 7 Apr 2020 07:27:28 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Apr 2020 00:27:27 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jthierry@redhat.com, tglx@linutronix.de,
        alexandre.chartre@oracle.com
Subject: [PATCH V2 1/9] objtool: Introduce HINT_RET_OFFSET
Date:   Tue,  7 Apr 2020 09:31:34 +0200
Message-Id: <20200407073142.20659-2-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200407073142.20659-1-alexandre.chartre@oracle.com>
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

Normally objtool ensures a function keeps the stack layout invariant.
But there is a useful exception, it is possible to stuff the return
stack in order to 'inject' a 'call':

        push $fun
        ret

In this case the invariant mentioned above is violated.

Add an objtool HINT to annotate this and allow a function exit with a
modified stack frame.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/orc_types.h       |  1 +
 arch/x86/include/asm/unwind_hints.h    | 10 ++++++++++
 tools/arch/x86/include/asm/orc_types.h |  1 +
 tools/objtool/check.c                  | 26 ++++++++++++++++++--------
 tools/objtool/check.h                  |  5 ++++-
 5 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/orc_types.h b/arch/x86/include/asm/orc_types.h
index 6e060907c163..5f18ca7ac51a 100644
--- a/arch/x86/include/asm/orc_types.h
+++ b/arch/x86/include/asm/orc_types.h
@@ -60,6 +60,7 @@
 #define ORC_TYPE_REGS_IRET		2
 #define UNWIND_HINT_TYPE_SAVE		3
 #define UNWIND_HINT_TYPE_RESTORE	4
+#define UNWIND_HINT_TYPE_RET_OFFSET	5
 
 #ifndef __ASSEMBLY__
 /*
diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
index f5e2eb12cb71..aabf7ace0476 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -94,6 +94,16 @@
 	UNWIND_HINT type=UNWIND_HINT_TYPE_RESTORE
 .endm
 
+
+/*
+ * RET_OFFSET: Used on instructions that terminate a function; mostly RETURN
+ * and sibling calls. On these, sp_offset denotes the expected offset from
+ * initial_func_cfi.
+ */
+.macro UNWIND_HINT_RET_OFFSET sp_offset=8
+	UNWIND_HINT type=UNWIND_HINT_TYPE_RET_OFFSET sp_offset=\sp_offset
+.endm
+
 #else /* !__ASSEMBLY__ */
 
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)		\
diff --git a/tools/arch/x86/include/asm/orc_types.h b/tools/arch/x86/include/asm/orc_types.h
index 6e060907c163..5f18ca7ac51a 100644
--- a/tools/arch/x86/include/asm/orc_types.h
+++ b/tools/arch/x86/include/asm/orc_types.h
@@ -60,6 +60,7 @@
 #define ORC_TYPE_REGS_IRET		2
 #define UNWIND_HINT_TYPE_SAVE		3
 #define UNWIND_HINT_TYPE_RESTORE	4
+#define UNWIND_HINT_TYPE_RET_OFFSET	5
 
 #ifndef __ASSEMBLY__
 /*
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4768d91c6d68..bbee26de92ec 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1209,6 +1209,10 @@ static int read_unwind_hints(struct objtool_file *file)
 			insn->restore = true;
 			insn->hint = true;
 			continue;
+
+		} else if (hint->type == UNWIND_HINT_TYPE_RET_OFFSET) {
+			insn->ret_offset = hint->sp_offset;
+			continue;
 		}
 
 		insn->hint = true;
@@ -1371,20 +1375,26 @@ static bool is_fentry_call(struct instruction *insn)
 	return false;
 }
 
-static bool has_modified_stack_frame(struct insn_state *state)
+static bool has_modified_stack_frame(struct instruction *insn,
+				     struct insn_state *state)
 {
+	u8 ret_offset = insn->ret_offset;
 	int i;
 
-	if (state->cfa.base != initial_func_cfi.cfa.base ||
-	    state->cfa.offset != initial_func_cfi.cfa.offset ||
-	    state->stack_size != initial_func_cfi.cfa.offset ||
-	    state->drap)
+	if (state->cfa.base != initial_func_cfi.cfa.base || state->drap)
+		return true;
+
+	if (state->cfa.offset != initial_func_cfi.cfa.offset + ret_offset)
 		return true;
 
-	for (i = 0; i < CFI_NUM_REGS; i++)
+	if (state->stack_size != initial_func_cfi.cfa.offset + ret_offset)
+		return true;
+
+	for (i = 0; i < CFI_NUM_REGS; i++) {
 		if (state->regs[i].base != initial_func_cfi.regs[i].base ||
 		    state->regs[i].offset != initial_func_cfi.regs[i].offset)
 			return true;
+	}
 
 	return false;
 }
@@ -1926,7 +1936,7 @@ static int validate_call(struct instruction *insn, struct insn_state *state)
 
 static int validate_sibling_call(struct instruction *insn, struct insn_state *state)
 {
-	if (has_modified_stack_frame(state)) {
+	if (has_modified_stack_frame(insn, state)) {
 		WARN_FUNC("sibling call from callable instruction with modified stack frame",
 				insn->sec, insn->offset);
 		return 1;
@@ -2065,7 +2075,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				return 1;
 			}
 
-			if (func && has_modified_stack_frame(&state)) {
+			if (func && has_modified_stack_frame(insn, &state)) {
 				WARN_FUNC("return with modified stack frame",
 					  sec, insn->offset);
 				return 1;
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 6d875ca6fce0..7a91497fee7e 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -33,9 +33,12 @@ struct instruction {
 	unsigned int len;
 	enum insn_type type;
 	unsigned long immediate;
-	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
+	unsigned int alt_group;
+	bool dead_end, ignore, ignore_alts;
+	bool hint, save, restore;
 	bool retpoline_safe;
 	u8 visited;
+	u8 ret_offset;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;
-- 
2.18.2

