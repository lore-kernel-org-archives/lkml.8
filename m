Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5401CC2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185062072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pya5BwJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgDGH3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 03:29:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34716 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgDGH3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 03:29:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0377TI9T103768;
        Tue, 7 Apr 2020 07:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=lE22GdUshQ3Ze3XJznMeE6T73lAnTWduKtvsvrBKTYM=;
 b=pya5BwJi3jRkKThPJF/14ORhItS2/Le6uUa6vD+8uCdgFu65fNIdOapiS7Ye26GOx+ON
 8g4UexFVQvGDaiUkSwPnMVlQ4sehz+N6xxrB2EoW3Lg1c4OWDLBy2EOPGsi6mRPuGQyR
 ipBDTYAMGbvCY9ES0InhF1+2Umo2XkikXd3oRpyMxGaUw578HTx79bsRHpZ9xBPfsM7D
 tyC8V/Hgjpey3quqHcMdXvhOjk34IUt30/7ppDVepnr0KG5IfiOULgVF1G08pcckeOhw
 g7egkUPdVERVCEI4QAdqlNSPum/nADHCQ2v6mM2qEeChsZ6ADhCEQUDn7lNfqr5j/ahV HQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 306jvn317v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 07:29:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0377RHPK078143;
        Tue, 7 Apr 2020 07:27:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 3073qf77u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 07:27:38 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0377Rbuk008198;
        Tue, 7 Apr 2020 07:27:37 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Apr 2020 00:27:37 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jthierry@redhat.com, tglx@linutronix.de,
        alexandre.chartre@oracle.com
Subject: [PATCH V2 5/9] objtool: Add support for intra-function calls
Date:   Tue,  7 Apr 2020 09:31:38 +0200
Message-Id: <20200407073142.20659-6-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200407073142.20659-1-alexandre.chartre@oracle.com>
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change objtool to support intra-function calls. On x86, an intra-function
call is represented in objtool as a push onto the stack (of the return
address), and a jump to the destination address. That way the stack
information is correctly updated and the call flow is still accurate.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 include/linux/frame.h                         | 11 +++
 .../Documentation/stack-validation.txt        |  8 ++
 tools/objtool/arch.h                          |  2 +
 tools/objtool/arch/x86/decode.c               | 12 +++
 tools/objtool/check.c                         | 97 ++++++++++++++++---
 tools/objtool/check.h                         |  1 +
 6 files changed, 117 insertions(+), 14 deletions(-)

diff --git a/include/linux/frame.h b/include/linux/frame.h
index 02d3ca2d9598..c7178e6c9d48 100644
--- a/include/linux/frame.h
+++ b/include/linux/frame.h
@@ -15,9 +15,20 @@
 	static void __used __section(.discard.func_stack_frame_non_standard) \
 		*__func_stack_frame_non_standard_##func = func
 
+/*
+ * This macro indicates that the following intra-function call is valid.
+ * Any non-annotated intra-function call will cause objtool to issue warning.
+ */
+#define ANNOTATE_INTRA_FUNCTION_CALL				\
+	999:							\
+	.pushsection .discard.intra_function_call;		\
+	.long 999b;						\
+	.popsection;
+
 #else /* !CONFIG_STACK_VALIDATION */
 
 #define STACK_FRAME_NON_STANDARD(func)
+#define ANNOTATE_INTRA_FUNCTION_CALL
 
 #endif /* CONFIG_STACK_VALIDATION */
 
diff --git a/tools/objtool/Documentation/stack-validation.txt b/tools/objtool/Documentation/stack-validation.txt
index de094670050b..09f863fd32d2 100644
--- a/tools/objtool/Documentation/stack-validation.txt
+++ b/tools/objtool/Documentation/stack-validation.txt
@@ -290,6 +290,14 @@ they mean, and suggestions for how to fix them.
       https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70646
 
 
+9. file.o: warning: unsupported intra-function call
+
+   This warning means that a direct call is done to a destination which
+   is not at the beginning of a function. If this is a legit call, you
+   can remove this warning by putting the ANNOTATE_INTRA_FUNCTION_CALL
+   directive right before the call.
+
+
 If the error doesn't seem to make sense, it could be a bug in objtool.
 Feel free to ask the objtool maintainer for help.
 
diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index ced3765c4f44..4d42c12d9957 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -75,4 +75,6 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 
 bool arch_callee_saved_reg(unsigned char reg);
 
+void arch_configure_intra_function_call(struct stack_op *op);
+
 #endif /* _ARCH_H */
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index a62e032863a8..7ee1561bf7ad 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -497,3 +497,15 @@ void arch_initial_func_cfi_state(struct cfi_state *state)
 	state->regs[16].base = CFI_CFA;
 	state->regs[16].offset = -8;
 }
+
+
+void arch_configure_intra_function_call(struct stack_op *op)
+{
+	/*
+	 * For the impact on the stack, make an intra-function
+	 * call behaves like a push of an immediate value (the
+	 * return address).
+	 */
+	op->src.type = OP_SRC_CONST;
+	op->dest.type = OP_DEST_PUSH;
+}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ab06e9bdd396..bf1e4e94d686 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -644,34 +644,50 @@ static int add_jump_destinations(struct objtool_file *file)
 	return 0;
 }
 
+static int configure_call(struct objtool_file *file, struct instruction *insn)
+{
+	unsigned long dest_off;
+
+	dest_off = insn->offset + insn->len + insn->immediate;
+	insn->call_dest = find_symbol_by_offset(insn->sec, dest_off);
+	if (insn->call_dest) {
+		/* regular call */
+		return 0;
+	}
+
+	/* intra-function call */
+	if (!insn->intra_function_call)
+		WARN_FUNC("intra-function call", insn->sec, insn->offset);
+
+	dest_off = insn->offset + insn->len + insn->immediate;
+	insn->jump_dest = find_insn(file, insn->sec, dest_off);
+	if (!insn->jump_dest) {
+		WARN_FUNC("can't find call dest at %s+0x%lx",
+			  insn->sec, insn->offset,
+			  insn->sec->name, dest_off);
+		return -1;
+	}
+
+	return 0;
+}
+
 /*
  * Find the destination instructions for all calls.
  */
 static int add_call_destinations(struct objtool_file *file)
 {
 	struct instruction *insn;
-	unsigned long dest_off;
 	struct rela *rela;
 
 	for_each_insn(file, insn) {
-		if (insn->type != INSN_CALL)
+		if (insn->type != INSN_CALL || insn->ignore)
 			continue;
 
 		rela = find_rela_by_dest_range(insn->sec, insn->offset,
 					       insn->len);
 		if (!rela) {
-			dest_off = insn->offset + insn->len + insn->immediate;
-			insn->call_dest = find_symbol_by_offset(insn->sec,
-								dest_off);
-
-			if (!insn->call_dest && !insn->ignore) {
-				WARN_FUNC("unsupported intra-function call",
-					  insn->sec, insn->offset);
-				if (retpoline)
-					WARN("If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.");
+			if (configure_call(file, insn))
 				return -1;
-			}
-
 		} else if (rela->sym->type == STT_SECTION) {
 			insn->call_dest = find_symbol_by_offset(rela->sym->sec,
 								rela->addend+4);
@@ -1293,6 +1309,43 @@ static int read_retpoline_hints(struct objtool_file *file)
 	return 0;
 }
 
+static int read_intra_function_call(struct objtool_file *file)
+{
+	struct section *sec;
+	struct instruction *insn;
+	struct rela *rela;
+
+	sec = find_section_by_name(file->elf,
+				   ".rela.discard.intra_function_call");
+	if (!sec)
+		return 0;
+
+	list_for_each_entry(rela, &sec->rela_list, list) {
+		if (rela->sym->type != STT_SECTION) {
+			WARN("unexpected relocation symbol type in %s",
+			     sec->name);
+			return -1;
+		}
+
+		insn = find_insn(file, rela->sym->sec, rela->addend);
+		if (!insn) {
+			WARN("bad .discard.intra_function_call entry");
+			return -1;
+		}
+
+		if (insn->type != INSN_CALL) {
+			WARN_FUNC("intra_function_call not a direct call",
+				  insn->sec, insn->offset);
+			return -1;
+		}
+
+		arch_configure_intra_function_call(&insn->stack_op);
+		insn->intra_function_call = true;
+	}
+
+	return 0;
+}
+
 static void mark_rodata(struct objtool_file *file)
 {
 	struct section *sec;
@@ -1348,6 +1401,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	ret = read_intra_function_call(file);
+	if (ret)
+		return ret;
+
 	ret = add_call_destinations(file);
 	if (ret)
 		return ret;
@@ -2110,7 +2167,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				return ret;
 
 			if (!no_fp && func && !is_fentry_call(insn) &&
-			    !has_valid_stack_frame(&state)) {
+			    !has_valid_stack_frame(&state) &&
+			    !insn->intra_function_call) {
 				WARN_FUNC("call without frame pointer save/setup",
 					  sec, insn->offset);
 				return 1;
@@ -2119,6 +2177,17 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			if (dead_end_function(file, insn->call_dest))
 				return 0;
 
+			if (insn->intra_function_call) {
+				update_insn_state(insn, &state);
+				ret = validate_branch(file, func, insn,
+						      insn->jump_dest, state);
+				if (ret) {
+					if (backtrace)
+						BT_FUNC("(intra-call)", insn);
+					return ret;
+				}
+			}
+
 			break;
 
 		case INSN_JUMP_CONDITIONAL:
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 7a91497fee7e..7c7ec3d8fb00 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -36,6 +36,7 @@ struct instruction {
 	unsigned int alt_group;
 	bool dead_end, ignore, ignore_alts;
 	bool hint, save, restore;
+	bool intra_function_call;
 	bool retpoline_safe;
 	u8 visited;
 	u8 ret_offset;
-- 
2.18.2

