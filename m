Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F11C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AB22206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pzj9wFdO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438715AbgDNKz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:55:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41812 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438406AbgDNKeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:34:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EAXIva102548;
        Tue, 14 Apr 2020 10:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=fLLGgDIZYKTl/K7Rv2wzVJUYY95uXKkMAzYoUJKoSr4=;
 b=pzj9wFdO6UuLBRV1gnIhBEnvHJEGC+EW3nNC+U2TYItOi1p7UK1Hbiur6weNi6MQg3Gk
 A3+OWY05X2CUhZ5zQz/z2fSKPnxrKFtWIjlCJK6h2wtVjrGX/W7pA/Hz86XlrjMrrsa5
 5KscoKa4nHcv45mF8RQzK6X/0GgxD6OtQwsnvs2QAwOskOZi0PhAeUb+sTcQoXuO+Ruk
 nlPQlzpN7sh1hfuh0OmU8NJh7LEjZ4fFGgo4gpUHZSbZV3e4crI2MZHQRF9tDoD3gtX3
 /QPyUfQaYd3A/h1XiIa+0AuB9jNePkYXhM4BL+8XQDbJIrJD0rSQPN9JEiVAVccrQBL+ mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30b6hpkms6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 10:34:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EAW0uY123393;
        Tue, 14 Apr 2020 10:32:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30bqpfxns9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 10:32:01 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03EAVuwu013703;
        Tue, 14 Apr 2020 10:31:58 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 03:31:55 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jthierry@redhat.com, tglx@linutronix.de,
        alexandre.chartre@oracle.com
Subject: [PATCH V3 4/9] objtool: Handle return instruction with intra-function call
Date:   Tue, 14 Apr 2020 12:36:13 +0200
Message-Id: <20200414103618.12657-5-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200414103618.12657-1-alexandre.chartre@oracle.com>
References: <20200414103618.12657-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=1 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 phishscore=0 suspectscore=1
 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intra-function calls are implemented in objtool like unconditional
jumps. Keep track of intra-functin calls return addresses so that
objtool can make a return instruction continues the flow at the
right location.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/arch/x86/decode.c |   7 +++
 tools/objtool/check.c           | 104 ++++++++++++++++++++++++++++++--
 tools/objtool/check.h           |   3 +
 3 files changed, 110 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index f4d70b8835c4..76b593bb2e4f 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -427,6 +427,13 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 	case 0xc2:
 	case 0xc3:
 		*type = INSN_RETURN;
+		/*
+		 * For the impact on the stack, a ret behaves like
+		 * a pop of the return address.
+		 */
+		op->src.type = OP_SRC_POP;
+		op->dest.type = OP_DEST_REG;
+		op->dest.reg = CFI_RA;
 		break;
 
 	case 0xca: /* retf */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ad362c5de281..8b1df659cd68 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -26,9 +26,50 @@ struct alternative {
 	bool skip_orig;
 };
 
+/*
+ * List to keep track of intra-function call return addresses.
+ * The list is a simple static array because we don't expect
+ * to have a lot of nested intra-function calls.
+ */
+#define RADDR_COUNT_MAX		32
+#define RADDR_ALTERED		((void *)-1)
+
+static struct instruction *raddr_list[RADDR_COUNT_MAX];
+static int raddr_count;
+
 const char *objname;
 struct cfi_state initial_func_cfi;
 
+static void raddr_clear(void)
+{
+	raddr_count = 0;
+}
+
+static bool raddr_push(struct instruction *insn)
+{
+	if (raddr_count == RADDR_COUNT_MAX) {
+		WARN_FUNC("return address list is full",
+			  insn->sec, insn->offset);
+		return false;
+	}
+
+	raddr_list[raddr_count++] = insn;
+	return true;
+}
+
+static bool raddr_pop(struct instruction **insn)
+{
+	if (raddr_count == 0)
+		return false;
+
+	*insn = raddr_list[--raddr_count];
+	return true;
+}
+
+static int validate_branch(struct objtool_file *file, struct symbol *func,
+			   struct instruction *from,
+			   struct instruction *first, struct insn_state state);
+
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset)
 {
@@ -2039,8 +2080,52 @@ static int validate_sibling_call(struct instruction *insn, struct insn_state *st
 	return validate_call(insn, state);
 }
 
-static int validate_return(struct symbol *func, struct instruction *insn, struct insn_state *state)
+static int validate_return_address(struct objtool_file *file,
+				   struct symbol *func,
+				   struct instruction *insn,
+				   struct insn_state *state)
 {
+	struct instruction *raddr_insn;
+	int ret;
+
+	while (raddr_pop(&raddr_insn)) {
+		/*
+		 * We are branching somewhere and so processing
+		 * a return instruction. So update the stack
+		 * state for this instruction.
+		 */
+		update_insn_state(insn, state);
+
+		/*
+		 * If the return address has no instruction then
+		 * that's the end of the function.
+		 */
+		if (!raddr_insn)
+			break;
+
+		/*
+		 * If we are branching to a defined address then
+		 * just do an unconditional jump there.
+		 */
+		ret = validate_branch(file, func, insn,
+				      raddr_insn, *state);
+		if (ret) {
+			if (backtrace)
+				BT_FUNC("(ret-branch)", insn);
+			return ret;
+		}
+
+		return 0;
+	}
+
+	return -1;
+}
+
+static int validate_return(struct objtool_file *file, struct symbol *func,
+			   struct instruction *insn, struct insn_state *state)
+{
+	int ret;
+
 	if (state->uaccess && !func_uaccess_safe(func)) {
 		WARN_FUNC("return with UACCESS enabled",
 			  insn->sec, insn->offset);
@@ -2059,6 +2144,11 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
 		return 1;
 	}
 
+	/* check if we have return address to branch to */
+	ret = validate_return_address(file, func, insn, state);
+	if (ret >= 0)
+		return ret;
+
 	if (func && has_modified_stack_frame(state)) {
 		WARN_FUNC("return with modified stack frame",
 			  insn->sec, insn->offset);
@@ -2200,7 +2290,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		switch (insn->type) {
 
 		case INSN_RETURN:
-			return validate_return(func, insn, &state);
+			return validate_return(file, func, insn, &state);
 
 		case INSN_CALL:
 		case INSN_CALL_DYNAMIC:
@@ -2223,12 +2313,17 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				/*
 				 * The call instruction can update the stack
 				 * state. Then make the intra-function call
-				 * behaves like and unconditional jump.
+				 * behaves like and unconditional jump. We
+				 * track the return address to handle any
+				 * return instruction.
 				 */
 				ret = update_insn_state(insn, &state);
 				if (ret)
 					return ret;
 
+				if (!raddr_push(next_insn))
+					return 1;
+
 				ret = validate_branch(file, func, insn,
 						      insn->jump_dest, state);
 				if (ret) {
@@ -2383,6 +2478,7 @@ static int validate_unwind_hints(struct objtool_file *file)
 
 	for_each_insn(file, insn) {
 		if (insn->hint && !insn->visited) {
+			raddr_clear();
 			ret = validate_branch(file, insn->func,
 					      NULL, insn, state);
 			if (ret && backtrace)
@@ -2522,7 +2618,7 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 			continue;
 
 		state.uaccess = func->uaccess_safe;
-
+		raddr_clear();
 		ret = validate_branch(file, func, NULL, insn, state);
 		if (ret && backtrace)
 			BT_FUNC("<=== (func)", insn);
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 6a80903fc4aa..f7dbecd46bed 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -23,6 +23,7 @@ struct insn_state {
 	unsigned int uaccess_stack;
 	int drap_reg, drap_offset;
 	struct cfi_reg vals[CFI_NUM_REGS];
+	bool stack_altered;
 };
 
 struct instruction {
@@ -39,6 +40,8 @@ struct instruction {
 	bool intra_function_call;
 	bool retpoline_safe;
 	u8 visited;
+	u8 raddr_delete;
+	u8 raddr_alter;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;
-- 
2.18.2

