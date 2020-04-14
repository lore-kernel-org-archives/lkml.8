Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE56C2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D2B720644
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p1SpySKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438453AbgDNKfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:35:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40214 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438373AbgDNKci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:32:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EATIE1098998;
        Tue, 14 Apr 2020 10:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=MDCxMbwZCIalkERKeoAG/k67T3C98x/pTWapXX1xkMk=;
 b=p1SpySKC/FngDeAc5GiZkWb0Y/SW2geU1EWRcPOB9FLkIhbc6R6AbqTWGcJSFowL8Vca
 Pf9xiQMGBeGey0pFmAsOtJI/yuFLgYwBdEJym1QIcT3Q9FilDHUkuBpT5fqwo6B5Plh4
 RtY8D0Hs/VTlGeGPEeBkxOVHG5ecjpgSRenDVWNiBZ9SExU59jr7Me+KzNcGhwqEF3AM
 NEolvtnVjNq28fGX3my6KzZSAlXY2Q7OqfvwJxWiKVS/mOKsHDvlbIVEijt2P2mxwwrU
 n8HNcgB+/dTRwwtUYVBJYtVhSSl/i4irLqtmOLhYZzkjHB/Un36mSQmMPyk3f05j9YBG tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30b6hpkmeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 10:32:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EAVxaJ123210;
        Tue, 14 Apr 2020 10:32:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30bqpfxnx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 10:32:02 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03EAVwlD013715;
        Tue, 14 Apr 2020 10:31:59 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 03:31:58 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jthierry@redhat.com, tglx@linutronix.de,
        alexandre.chartre@oracle.com
Subject: [PATCH V3 5/9] objtool: Add return address unwind hints
Date:   Tue, 14 Apr 2020 12:36:14 +0200
Message-Id: <20200414103618.12657-6-alexandre.chartre@oracle.com>
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
 engine=8.12.0-2003020000 definitions=main-2004140086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the UNWIND_HINT_RADDR_DELETE and UNWIND_HINT_RADDR_ALTER unwind
hint macros to flag instructions which remove or modify return
addresses.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/orc_types.h       |  2 +
 arch/x86/include/asm/unwind_hints.h    | 23 +++++++++
 tools/arch/x86/include/asm/orc_types.h |  2 +
 tools/objtool/check.c                  | 67 ++++++++++++++++++++++++++
 4 files changed, 94 insertions(+)

diff --git a/arch/x86/include/asm/orc_types.h b/arch/x86/include/asm/orc_types.h
index 6e060907c163..5c1141175d51 100644
--- a/arch/x86/include/asm/orc_types.h
+++ b/arch/x86/include/asm/orc_types.h
@@ -60,6 +60,8 @@
 #define ORC_TYPE_REGS_IRET		2
 #define UNWIND_HINT_TYPE_SAVE		3
 #define UNWIND_HINT_TYPE_RESTORE	4
+#define UNWIND_HINT_TYPE_RADDR_ALTER	6
+#define UNWIND_HINT_TYPE_RADDR_DELETE	7
 
 #ifndef __ASSEMBLY__
 /*
diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
index f5e2eb12cb71..5211d2c5b7a2 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -94,6 +94,23 @@
 	UNWIND_HINT type=UNWIND_HINT_TYPE_RESTORE
 .endm
 
+/*
+ * RADDR_DELETE: Used on instructions (other than ret instruction)
+ * which remove a return address from the stack. count is the number
+ * of return address which are removed.
+ */
+.macro UNWIND_HINT_RADDR_DELETE count=1
+	UNWIND_HINT type=UNWIND_HINT_TYPE_RADDR_DELETE sp_offset=\count
+.endm
+
+/*
+ * RADDR_ALTER: Used on instructions which change a return address on
+ * the stack. count is the number of return address which are changed.
+ */
+.macro UNWIND_HINT_RADDR_ALTER count=1
+	UNWIND_HINT type=UNWIND_HINT_TYPE_RADDR_ALTER sp_offset=\count
+.endm
+
 #else /* !__ASSEMBLY__ */
 
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)		\
@@ -112,6 +129,12 @@
 
 #define UNWIND_HINT_RESTORE UNWIND_HINT(0, 0, UNWIND_HINT_TYPE_RESTORE, 0)
 
+#define UNWIND_HINT_RADDR_ALTER(count)	\
+	UNWIND_HINT(0, count, UNWIND_HINT_TYPE_RADDR_ALTER, 0)
+
+#define UNWIND_HINT_RADDR_DELETE(count)	\
+	UNWIND_HINT(0, count, UNWIND_HINT_TYPE_RADDR_DELETE, 0)
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_UNWIND_HINTS_H */
diff --git a/tools/arch/x86/include/asm/orc_types.h b/tools/arch/x86/include/asm/orc_types.h
index 6e060907c163..5c1141175d51 100644
--- a/tools/arch/x86/include/asm/orc_types.h
+++ b/tools/arch/x86/include/asm/orc_types.h
@@ -60,6 +60,8 @@
 #define ORC_TYPE_REGS_IRET		2
 #define UNWIND_HINT_TYPE_SAVE		3
 #define UNWIND_HINT_TYPE_RESTORE	4
+#define UNWIND_HINT_TYPE_RADDR_ALTER	6
+#define UNWIND_HINT_TYPE_RADDR_DELETE	7
 
 #ifndef __ASSEMBLY__
 /*
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8b1df659cd68..0574ce8e232d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -66,6 +66,28 @@ static bool raddr_pop(struct instruction **insn)
 	return true;
 }
 
+static bool raddr_delete(int count)
+{
+	if (raddr_count < count)
+		return false;
+
+	raddr_count -= count;
+	return true;
+}
+
+static bool raddr_alter(int count)
+{
+	int i;
+
+	if (raddr_count < count)
+		false;
+
+	for (i = 0; i < count; i++)
+		raddr_list[raddr_count - 1 - i] = RADDR_ALTERED;
+
+	return true;
+}
+
 static int validate_branch(struct objtool_file *file, struct symbol *func,
 			   struct instruction *from,
 			   struct instruction *first, struct insn_state state);
@@ -1314,6 +1336,14 @@ static int read_unwind_hints(struct objtool_file *file)
 			insn->restore = true;
 			insn->hint = true;
 			continue;
+
+		} else if (hint->type == UNWIND_HINT_TYPE_RADDR_DELETE) {
+			insn->raddr_delete = hint->sp_offset;
+			continue;
+
+		} else if (hint->type == UNWIND_HINT_TYPE_RADDR_ALTER) {
+			insn->raddr_alter = hint->sp_offset;
+			continue;
 		}
 
 		insn->hint = true;
@@ -1526,6 +1556,13 @@ static bool has_modified_stack_frame(struct insn_state *state)
 	    state->drap)
 		return true;
 
+	/*
+	 * If the stack was altered then don't check registers because
+	 * a callee-saved registers might have been pushed on the stack.
+	 */
+	if (state->stack_altered)
+		return false;
+
 	for (i = 0; i < CFI_NUM_REGS; i++)
 		if (state->regs[i].base != initial_func_cfi.regs[i].base ||
 		    state->regs[i].offset != initial_func_cfi.regs[i].offset)
@@ -2103,6 +2140,15 @@ static int validate_return_address(struct objtool_file *file,
 		if (!raddr_insn)
 			break;
 
+		/*
+		 * If this is a dynamic branch then we expect this
+		 * branch to return or not, depending on the defined
+		 * list of RA we have, so just continue the processing
+		 * of the RA list.
+		 */
+		if (raddr_insn == RADDR_ALTERED)
+			continue;
+
 		/*
 		 * If we are branching to a defined address then
 		 * just do an unconditional jump there.
@@ -2287,6 +2333,27 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				return 0;
 		}
 
+		if (insn->raddr_delete) {
+			/* delete return address */
+			if (!raddr_delete(insn->raddr_delete)) {
+				WARN_FUNC("fail to delete %d return address",
+					  insn->sec, insn->offset,
+					  insn->raddr_delete);
+				return 1;
+			}
+			state.stack_altered = true;
+
+		} else if (insn->raddr_alter) {
+			/* alter return address */
+			if (!raddr_alter(insn->raddr_alter)) {
+				WARN_FUNC("fail to alter %d return address",
+					  insn->sec, insn->offset,
+					  insn->raddr_alter);
+				return 1;
+			}
+			state.stack_altered = true;
+		}
+
 		switch (insn->type) {
 
 		case INSN_RETURN:
-- 
2.18.2

