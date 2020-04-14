Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78747C2BBC7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C2C20936
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yUG+IZ/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438525AbgDNKnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:43:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58682 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438409AbgDNKe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:34:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EAWY60071824;
        Tue, 14 Apr 2020 10:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=piVHd66tc8hHiVDJyFPCoaAJnZoMzxbUq+RBlGpNc/s=;
 b=yUG+IZ/pR4nbMBij2PHoIJ4e7MNo8cKN3K3MRup6k9+Dp7ymO0ObO0h4WFEHXdmmUgVL
 OxYKZsEHHcbRvS3k3E2EjQDM7r1lnizhhXuWUcY08mTRQ1LwdHs/aWPKHTMAmsgpKMYf
 WNtVJ83wmt01xb9aNXFqlQKQsPOtFgiZn6Zq1KhzsFZBUYrTQSqggzkxCN6va6H/me3b
 4vbGzxqT4/xFzSXKLjuze+LuDbO7rD/4P4PpQOLpaGVIjL4PWqjS+4CD5lIbRDEgiggx
 TiwSZBhEvqnE1jPUVrmu/VtwKvZD1Y/zCI5iQsUwqCAeBJL4u5I1bYp1i+au1VmBk1jm eA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30b5ar3nch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 10:34:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EAW36s123678;
        Tue, 14 Apr 2020 10:32:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30bqpfxnq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 10:32:04 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03EAVqSt013687;
        Tue, 14 Apr 2020 10:31:53 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 03:31:51 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jthierry@redhat.com, tglx@linutronix.de,
        alexandre.chartre@oracle.com
Subject: [PATCH V3 2/9] objtool: Allow branches within the same alternative.
Date:   Tue, 14 Apr 2020 12:36:11 +0200
Message-Id: <20200414103618.12657-3-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200414103618.12657-1-alexandre.chartre@oracle.com>
References: <20200414103618.12657-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=1 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 mlxlogscore=999 suspectscore=1 adultscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140087
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
 tools/objtool/check.c | 28 ++++++++++++++++++++++------
 tools/objtool/check.h |  4 +++-
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index bd25c3ad651a..8f0525d5d895 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -731,7 +731,9 @@ static int handle_group_alt(struct objtool_file *file,
 			    struct instruction *orig_insn,
 			    struct instruction **new_insn)
 {
+	static unsigned int alt_group_next_index = 1;
 	struct instruction *last_orig_insn, *last_new_insn, *insn, *fake_jump = NULL;
+	unsigned int alt_group = alt_group_next_index++;
 	unsigned long dest_off;
 
 	last_orig_insn = NULL;
@@ -740,7 +742,7 @@ static int handle_group_alt(struct objtool_file *file,
 		if (insn->offset >= special_alt->orig_off + special_alt->orig_len)
 			break;
 
-		insn->alt_group = true;
+		insn->alt_group = alt_group;
 		last_orig_insn = insn;
 	}
 
@@ -773,6 +775,7 @@ static int handle_group_alt(struct objtool_file *file,
 	}
 
 	last_new_insn = NULL;
+	alt_group = alt_group_next_index++;
 	insn = *new_insn;
 	sec_for_each_insn_from(file, insn) {
 		if (insn->offset >= special_alt->new_off + special_alt->new_len)
@@ -782,6 +785,7 @@ static int handle_group_alt(struct objtool_file *file,
 
 		insn->ignore = orig_insn->ignore_alts;
 		insn->func = orig_insn->func;
+		insn->alt_group = alt_group;
 
 		/*
 		 * Since alternative replacement code is copy/pasted by the
@@ -2016,6 +2020,15 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
 	return 0;
 }
 
+static bool is_branch_to_alternative(struct instruction *from,
+				     struct instruction *to)
+{
+	if (!from || !to->alt_group || !list_empty(&to->alts))
+		return false;
+
+	return (from->alt_group != to->alt_group);
+}
+
 /*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
@@ -2023,6 +2036,7 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
  * tools/objtool/Documentation/stack-validation.txt.
  */
 static int validate_branch(struct objtool_file *file, struct symbol *func,
+			   struct instruction *from,
 			   struct instruction *first, struct insn_state state)
 {
 	struct alternative *alt;
@@ -2034,7 +2048,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 	insn = first;
 	sec = insn->sec;
 
-	if (insn->alt_group && list_empty(&insn->alts)) {
+	if (is_branch_to_alternative(from, insn)) {
 		WARN_FUNC("don't know how to handle branch to middle of alternative instruction group",
 			  sec, insn->offset);
 		return 1;
@@ -2116,7 +2130,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				if (alt->skip_orig)
 					skip_orig = true;
 
-				ret = validate_branch(file, func, alt->insn, state);
+				ret = validate_branch(file, func,
+						      NULL, alt->insn, state);
 				if (ret) {
 					if (backtrace)
 						BT_FUNC("(alt)", insn);
@@ -2159,7 +2174,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 					return ret;
 
 			} else if (insn->jump_dest) {
-				ret = validate_branch(file, func,
+				ret = validate_branch(file, func, insn,
 						      insn->jump_dest, state);
 				if (ret) {
 					if (backtrace)
@@ -2290,7 +2305,8 @@ static int validate_unwind_hints(struct objtool_file *file)
 
 	for_each_insn(file, insn) {
 		if (insn->hint && !insn->visited) {
-			ret = validate_branch(file, insn->func, insn, state);
+			ret = validate_branch(file, insn->func,
+					      NULL, insn, state);
 			if (ret && backtrace)
 				BT_FUNC("<=== (hint)", insn);
 			warnings += ret;
@@ -2429,7 +2445,7 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 
 		state.uaccess = func->uaccess_safe;
 
-		ret = validate_branch(file, func, insn, state);
+		ret = validate_branch(file, func, NULL, insn, state);
 		if (ret && backtrace)
 			BT_FUNC("<=== (func)", insn);
 		warnings += ret;
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index f0ce8ffe7135..953db38dfc35 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -33,7 +33,9 @@ struct instruction {
 	unsigned int len;
 	enum insn_type type;
 	unsigned long immediate;
-	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
+	int alt_group;
+	bool dead_end, ignore, ignore_alts;
+	bool hint, save, restore;
 	bool retpoline_safe;
 	u8 visited;
 	struct symbol *call_dest;
-- 
2.18.2

