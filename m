Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E3BC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBC72080C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n4uNkBHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387830AbgDBISu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:18:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52486 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387705AbgDBISn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:18:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0328D2x7143626;
        Thu, 2 Apr 2020 08:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=eBAkyxE7WQ4KazTzpm0CaHkI0Qkvd/pBQhZJfifufmY=;
 b=n4uNkBHD4aHVGbOzuIHqc0LPMOp8qKElRq1SuxAYd+LDmrixEkv45IU19Yq8f7c7D1uV
 KAWrl4je6j87Coh2edtHUdMnDxGfS3MGPEPgO3QTz5D9U4/+ShcpzdPxhr7ZWg4M8BBn
 Oje21nCRMtS5jYXPpslLSxtoKbGbjHyltgknV5Wowp62CUqemeM6/e22wSik+wYxl3+L
 62nLXlpSQ9aj/GfOOpp1voERPVmNb5qKQtLOBIiLYqSmQxbi8CDVzpH/LD3MFENHOe6h
 HrkRlq+uD0+RRRceE4Us0V5p4/r9hq5i9nbzvFnO8MmywA57GP5UYoN7QgquNelYTy12 2w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 303aqhta8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 08:18:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0328H7KG126324;
        Thu, 2 Apr 2020 08:18:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 304sjnssmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 08:18:15 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0328ID8K006853;
        Thu, 2 Apr 2020 08:18:13 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 01:18:13 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jthierry@redhat.com, tglx@linutronix.de,
        alexandre.chartre@oracle.com
Subject: [PATCH 2/7] objtool: Allow branches within the same alternative.
Date:   Thu,  2 Apr 2020 10:22:15 +0200
Message-Id: <20200402082220.808-3-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200402082220.808-1-alexandre.chartre@oracle.com>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=1 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020074
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
 tools/objtool/check.h |  3 ++-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 708562fb89e1..214809ac2776 100644
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
 
@@ -1942,6 +1944,7 @@ static int validate_sibling_call(struct instruction *insn, struct insn_state *st
  * tools/objtool/Documentation/stack-validation.txt.
  */
 static int validate_branch(struct objtool_file *file, struct symbol *func,
+			   struct instruction *from,
 			   struct instruction *first, struct insn_state state)
 {
 	struct alternative *alt;
@@ -1953,7 +1956,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 	insn = first;
 	sec = insn->sec;
 
-	if (insn->alt_group && list_empty(&insn->alts)) {
+	if (insn->alt_group &&
+	    (!from || from->alt_group != insn->alt_group) &&
+	    list_empty(&insn->alts)) {
 		WARN_FUNC("don't know how to handle branch to middle of alternative instruction group",
 			  sec, insn->offset);
 		return 1;
@@ -2035,7 +2040,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				if (alt->skip_orig)
 					skip_orig = true;
 
-				ret = validate_branch(file, func, alt->insn, state);
+				ret = validate_branch(file, func,
+						      NULL, alt->insn, state);
 				if (ret) {
 					if (backtrace)
 						BT_FUNC("(alt)", insn);
@@ -2105,7 +2111,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 					return ret;
 
 			} else if (insn->jump_dest) {
-				ret = validate_branch(file, func,
+				ret = validate_branch(file, func, insn,
 						      insn->jump_dest, state);
 				if (ret) {
 					if (backtrace)
@@ -2236,7 +2242,8 @@ static int validate_unwind_hints(struct objtool_file *file)
 
 	for_each_insn(file, insn) {
 		if (insn->hint && !insn->visited) {
-			ret = validate_branch(file, insn->func, insn, state);
+			ret = validate_branch(file, insn->func,
+					      NULL, insn, state);
 			if (ret && backtrace)
 				BT_FUNC("<=== (hint)", insn);
 			warnings += ret;
@@ -2377,7 +2384,7 @@ static int validate_functions(struct objtool_file *file)
 
 			state.uaccess = func->uaccess_safe;
 
-			ret = validate_branch(file, func, insn, state);
+			ret = validate_branch(file, func, NULL, insn, state);
 			if (ret && backtrace)
 				BT_FUNC("<=== (func)", insn);
 			warnings += ret;
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 6d875ca6fce0..cffb23d81782 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -33,7 +33,8 @@ struct instruction {
 	unsigned int len;
 	enum insn_type type;
 	unsigned long immediate;
-	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
+	unsigned int alt_group;
+	bool dead_end, ignore, hint, save, restore, ignore_alts;
 	bool retpoline_safe;
 	u8 visited;
 	struct symbol *call_dest;
-- 
2.18.2

