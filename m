Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E334C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234272064A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G12d6CgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgDGH2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 03:28:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47134 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbgDGH16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 03:27:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0377Rk21152980;
        Tue, 7 Apr 2020 07:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=fmwJ6boFaoMUNdhsXf3ZCRqWn354NQrYvQa/zjOMXIQ=;
 b=G12d6CgWdIgVYv1VREZV+XfW6Zyy1GA4YJX2pT3IgIUqlfYcoH01ckD+R2+BIkTOOAY2
 CM52uW5Yw1fke2WEH6S2ucjeoQryIgDJwhX2KLLV6vvAHhv0SMIbGAefwg0WtVY6ZwdA
 908bk6YNiDT/C/irBa+3MzmAT0ShOarzL7Er2tla4gPkR1VAMdd+MB/3zggSjHpiRNV6
 ciIA5Mgx1Jfj5M5vcRo98UxuGjOWVWKU6T0gPvjQvnOZEze1xYqe0+qftOg8m3U9q3Mq
 0rTMxxUYz0aEgnN+Uy3iTqVLv7lkO6yb1/0uSTZp1iGK1dJ0sFZeCxDRRBwr2nK4jp0e fA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 308ffd93ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 07:27:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0377QdmS191108;
        Tue, 7 Apr 2020 07:27:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 3073srhd7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 07:27:45 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0377Rj2e032029;
        Tue, 7 Apr 2020 07:27:45 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Apr 2020 00:27:45 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jthierry@redhat.com, tglx@linutronix.de,
        alexandre.chartre@oracle.com
Subject: [PATCH V2 9/9] x86/speculation: Remove all ANNOTATE_NOSPEC_ALTERNATIVE directives
Date:   Tue,  7 Apr 2020 09:31:42 +0200
Message-Id: <20200407073142.20659-10-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200407073142.20659-1-alexandre.chartre@oracle.com>
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=13 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=13 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that intra-function calls have been annotated and are supported
by objtool, that retpoline return instructions have been annotated,
and that __FILL_RETURN_BUFFER code is compatible with objtool, then
all ANNOTATE_NOSPEC_ALTERNATIVE directives can be removed.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/nospec-branch.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 5ce2a40a26da..6480db4304a0 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -124,7 +124,6 @@
  */
 .macro JMP_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
-	ANNOTATE_NOSPEC_ALTERNATIVE
 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *\reg),	\
 		__stringify(RETPOLINE_JMP \reg), X86_FEATURE_RETPOLINE,	\
 		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *\reg), X86_FEATURE_RETPOLINE_AMD
@@ -135,7 +134,6 @@
 
 .macro CALL_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
-	ANNOTATE_NOSPEC_ALTERNATIVE
 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *\reg),	\
 		__stringify(RETPOLINE_CALL \reg), X86_FEATURE_RETPOLINE,\
 		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *\reg), X86_FEATURE_RETPOLINE_AMD
@@ -150,7 +148,6 @@
   */
 .macro FILL_RETURN_BUFFER reg:req nr:req ftr:req
 #ifdef CONFIG_RETPOLINE
-	ANNOTATE_NOSPEC_ALTERNATIVE
 	ALTERNATIVE "jmp .Lskip_rsb_\@",				\
 		__stringify(__FILL_RETURN_BUFFER(\reg,\nr,%_ASM_SP))	\
 		\ftr
@@ -174,7 +171,6 @@
  * which is ensured when CONFIG_RETPOLINE is defined.
  */
 # define CALL_NOSPEC						\
-	ANNOTATE_NOSPEC_ALTERNATIVE				\
 	ALTERNATIVE_2(						\
 	ANNOTATE_RETPOLINE_SAFE					\
 	"call *%[thunk_target]\n",				\
@@ -193,7 +189,6 @@
  * here, anyway.
  */
 # define CALL_NOSPEC						\
-	ANNOTATE_NOSPEC_ALTERNATIVE				\
 	ALTERNATIVE_2(						\
 	ANNOTATE_RETPOLINE_SAFE					\
 	"call *%[thunk_target]\n",				\
@@ -261,8 +256,7 @@ static inline void vmexit_fill_RSB(void)
 #ifdef CONFIG_RETPOLINE
 	unsigned long loops;
 
-	asm volatile (ANNOTATE_NOSPEC_ALTERNATIVE
-		      ALTERNATIVE("jmp 910f",
+	asm volatile (ALTERNATIVE("jmp 910f",
 				  __stringify(__FILL_RETURN_BUFFER(%0, RSB_CLEAR_LOOPS, %1)),
 				  X86_FEATURE_RETPOLINE)
 		      "910:"
-- 
2.18.2

