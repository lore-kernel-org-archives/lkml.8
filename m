Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DE2C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFD4208E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VM0hpYBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387820AbgDBISq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:18:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35644 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387801AbgDBISo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:18:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0328HYgu077899;
        Thu, 2 Apr 2020 08:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=G2EUQCFwJX8XuZno6OD5sAaFtbX5f0F6eswOa4/kh0g=;
 b=VM0hpYBhPhk6BAiUwVAv9RIvkCXW7iuI5T9EBdGrgrDnPgjhoCE0uHef3+vo76qami/+
 wTGFU4UKLHzrVVQJektnQEcEF3wqIoSoOUnGK8HHS5XHXEEZGUGA0Dh86PifuPhSeZjY
 tRJaq1hxYDJI0RcCYmK17XNxIUXLXgGVsfDh8GegCn+ZVNflgzEZw2lMDw0AztBBPGbF
 tKjv8yYmcgMiZFPmn4EdRybJEz3aDGFtqnkomHdRorYxfKW2VymU+pQi72V8UH6rC5jo
 5Gxc9TFpC4i7BI4W8hvGBOK0sD7LDnYi61vPVZpFHhphjCv7AGRY6Ue2BLld7/v0a2Ek SQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 303cev9u7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 08:18:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0328IJeH090968;
        Thu, 2 Apr 2020 08:18:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 302g4v4phu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 08:18:20 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0328IFaS003424;
        Thu, 2 Apr 2020 08:18:15 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 01:18:15 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jthierry@redhat.com, tglx@linutronix.de,
        alexandre.chartre@oracle.com
Subject: [PATCH 3/7] objtool: Add support for intra-function calls
Date:   Thu,  2 Apr 2020 10:22:16 +0200
Message-Id: <20200402082220.808-4-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200402082220.808-1-alexandre.chartre@oracle.com>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=1
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=1 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change objtool to support intra-function calls. An intra-function call
is represented in objtool as a push onto the stack (of the return
address), and a jump to the destination address. That way the stack
information is correctly updated and the call flow is still accurate.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/check.c | 73 ++++++++++++++++++++++++++++++++++++++++++-
 tools/objtool/check.h |  1 +
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 214809ac2776..0cec91291d46 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -657,6 +657,18 @@ static int add_call_destinations(struct objtool_file *file)
 		if (insn->type != INSN_CALL)
 			continue;
 
+		if (insn->intra_function_call) {
+			dest_off = insn->offset + insn->len + insn->immediate;
+			insn->jump_dest = find_insn(file, insn->sec, dest_off);
+			if (insn->jump_dest)
+				continue;
+
+			WARN_FUNC("can't find call dest at %s+0x%lx",
+				  insn->sec, insn->offset,
+				  insn->sec->name, dest_off);
+			return -1;
+		}
+
 		rela = find_rela_by_dest_range(insn->sec, insn->offset,
 					       insn->len);
 		if (!rela) {
@@ -1289,6 +1301,49 @@ static int read_retpoline_hints(struct objtool_file *file)
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
+			WARN_FUNC("intra_function_call not a call",
+				  insn->sec, insn->offset);
+			return -1;
+		}
+
+		insn->intra_function_call = true;
+		/*
+		 * For the impact on the stack, make an intra-function
+		 * call behaves like a push of an immediate value (the
+		 * return address).
+		 */
+		insn->stack_op.src.type = OP_SRC_CONST;
+		insn->stack_op.dest.type = OP_DEST_PUSH;
+	}
+
+	return 0;
+}
+
 static void mark_rodata(struct objtool_file *file)
 {
 	struct section *sec;
@@ -1344,6 +1399,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	ret = read_intra_function_call(file);
+	if (ret)
+		return ret;
+
 	ret = add_call_destinations(file);
 	if (ret)
 		return ret;
@@ -2092,7 +2151,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				return ret;
 
 			if (!no_fp && func && !is_fentry_call(insn) &&
-			    !has_valid_stack_frame(&state)) {
+			    !has_valid_stack_frame(&state) &&
+			    !insn->intra_function_call) {
 				WARN_FUNC("call without frame pointer save/setup",
 					  sec, insn->offset);
 				return 1;
@@ -2101,6 +2161,17 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
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
index cffb23d81782..2bd6d2f46baa 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -35,6 +35,7 @@ struct instruction {
 	unsigned long immediate;
 	unsigned int alt_group;
 	bool dead_end, ignore, hint, save, restore, ignore_alts;
+	bool intra_function_call;
 	bool retpoline_safe;
 	u8 visited;
 	struct symbol *call_dest;
-- 
2.18.2

