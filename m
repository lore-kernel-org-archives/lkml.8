Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F603C2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E654720678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kgXu8Vv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgDGH15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 03:27:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45194 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgDGH14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 03:27:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0377Ra2N026377;
        Tue, 7 Apr 2020 07:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=slDzjJlr8LfYsLe6Y6X31cSMqj13VCofNy5CK2Foxss=;
 b=kgXu8Vv6XTjDoY5iMu4xVMSFI/vBjyAxGMGI/077w6ridv1IsbaCe1dx+Z0+GMBv8iGK
 EOih5hWrcnfsp0UhkkMaEZ8WUerE8u80RvcAtQovbmGThx9BkokfgB6AMLqO4XthoK7p
 zjCEI0myG0qz8vQ2pf09e28VmahNiiZ10kb/12U8Z44zSl1jj5cSSCLmnKKVKb6jleHW
 uk5iBkoXfqEIa8W8c+LagKDXAlTVNjazNPNjR2fSGOqMndoaXZu7YJruOw534aVrLYMU
 5jiv1mPHYqqEVVWdL1VRAt/bb1QwMvZQr0XR9smW1JrpihilTSPHvlorR4HxB+bC+wMC Dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 306j6mb2mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 07:27:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0377RROg151275;
        Tue, 7 Apr 2020 07:27:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 30741d9u7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 07:27:36 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0377RZ4e011250;
        Tue, 7 Apr 2020 07:27:35 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Apr 2020 00:27:35 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jthierry@redhat.com, tglx@linutronix.de,
        alexandre.chartre@oracle.com
Subject: [PATCH V2 4/9] objtool: Allow branches within the same alternative.
Date:   Tue,  7 Apr 2020 09:31:37 +0200
Message-Id: <20200407073142.20659-5-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200407073142.20659-1-alexandre.chartre@oracle.com>
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=1 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently objtool prevents any branch to an alternative. While preventing
branching from the outside to the middle of an alternative makes perfect
sense, branching within the same alternative should be allowed. To do so,
identify each alternative and check that a branch to an alternative comes
from the same alternative.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/check.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c0da033a40c5..ab06e9bdd396 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -712,7 +712,9 @@ static int handle_group_alt(struct objtool_file *file,
 			    struct instruction *orig_insn,
 			    struct instruction **new_insn)
 {
+	static unsigned int alt_group_next_index = 1;
 	struct instruction *last_orig_insn, *last_new_insn, *insn, *fake_jump = NULL;
+	unsigned int alt_group = alt_group_next_index++;
 	unsigned long dest_off;
 
 	last_orig_insn = NULL;
@@ -721,7 +723,7 @@ static int handle_group_alt(struct objtool_file *file,
 		if (insn->offset >= special_alt->orig_off + special_alt->orig_len)
 			break;
 
-		insn->alt_group = true;
+		insn->alt_group = alt_group;
 		last_orig_insn = insn;
 	}
 
@@ -1960,6 +1962,7 @@ static int validate_sibling_call(struct instruction *insn, struct insn_state *st
  * tools/objtool/Documentation/stack-validation.txt.
  */
 static int validate_branch(struct objtool_file *file, struct symbol *func,
+			   struct instruction *from,
 			   struct instruction *first, struct insn_state state)
 {
 	struct alternative *alt;
@@ -1971,7 +1974,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 	insn = first;
 	sec = insn->sec;
 
-	if (insn->alt_group && list_empty(&insn->alts)) {
+	if (insn->alt_group &&
+	    (!from || from->alt_group != insn->alt_group) &&
+	    list_empty(&insn->alts)) {
 		WARN_FUNC("don't know how to handle branch to middle of alternative instruction group",
 			  sec, insn->offset);
 		return 1;
@@ -2053,7 +2058,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				if (alt->skip_orig)
 					skip_orig = true;
 
-				ret = validate_branch(file, func, alt->insn, state);
+				ret = validate_branch(file, func,
+						      NULL, alt->insn, state);
 				if (ret) {
 					if (backtrace)
 						BT_FUNC("(alt)", insn);
@@ -2123,7 +2129,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 					return ret;
 
 			} else if (insn->jump_dest) {
-				ret = validate_branch(file, func,
+				ret = validate_branch(file, func, insn,
 						      insn->jump_dest, state);
 				if (ret) {
 					if (backtrace)
@@ -2254,7 +2260,8 @@ static int validate_unwind_hints(struct objtool_file *file)
 
 	for_each_insn(file, insn) {
 		if (insn->hint && !insn->visited) {
-			ret = validate_branch(file, insn->func, insn, state);
+			ret = validate_branch(file, insn->func,
+					      NULL, insn, state);
 			if (ret && backtrace)
 				BT_FUNC("<=== (hint)", insn);
 			warnings += ret;
@@ -2395,7 +2402,7 @@ static int validate_functions(struct objtool_file *file)
 
 			state.uaccess = func->uaccess_safe;
 
-			ret = validate_branch(file, func, insn, state);
+			ret = validate_branch(file, func, NULL, insn, state);
 			if (ret && backtrace)
 				BT_FUNC("<=== (func)", insn);
 			warnings += ret;
-- 
2.18.2

