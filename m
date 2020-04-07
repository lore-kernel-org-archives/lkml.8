Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4224C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4CB2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ONX5G3AI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgDGH2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 03:28:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47110 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbgDGH16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 03:27:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0377Ra32152454;
        Tue, 7 Apr 2020 07:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=HXu0krWaJVrdRIcRgZBH9F6CYP3RcFfwJPOybRCJ39Y=;
 b=ONX5G3AI0CoSrUNm/PFAvGheIvZ1unOwxsus5/5AynhWjOsDAwp1dvEq4l0AzRKciRJq
 3hbpbp/z/QUSHREsVQvMAmwgP3a43+4jxkg3lxbxPmO/4HiDGKT8F124K0TCbgZUy4dL
 XD4rxiI/l4lpYykRYjJSgYRm9dI9rXDkgYmS4Kz5WOWOSolbMaXozXm53D4VckdRI7my
 Bc0a3Kx1DjY+efhJasTibe6vclbZ4ndAmCpke5kNt6TcXkMv0VuBRwoDfvhdIDD8XzF1
 GQ1ISLuM1dcwpezzJjECxZtAe+Tz/+LoKkHbfuRob4tQgtDsXr0vykvghYWVYHF2jUD9 sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 308ffd93jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 07:27:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0377RSiU151366;
        Tue, 7 Apr 2020 07:27:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 30741d9uew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 07:27:42 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0377RfZA011289;
        Tue, 7 Apr 2020 07:27:41 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Apr 2020 00:27:41 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jthierry@redhat.com, tglx@linutronix.de,
        alexandre.chartre@oracle.com
Subject: [PATCH V2 7/9] x86/speculation: Annotate intra-function calls
Date:   Tue,  7 Apr 2020 09:31:40 +0200
Message-Id: <20200407073142.20659-8-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200407073142.20659-1-alexandre.chartre@oracle.com>
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=13 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070062
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

Some speculative execution mitigations (like retpoline) use intra-
function calls. Provide a macro to annotate such intra-function calls
so they can be properly handled by objtool, and use this macro to
annotate intra-function calls.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/nospec-branch.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 9a946fd5e824..a345c6fa0541 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -3,6 +3,7 @@
 #ifndef _ASM_X86_NOSPEC_BRANCH_H_
 #define _ASM_X86_NOSPEC_BRANCH_H_
 
+#include <linux/frame.h>
 #include <linux/static_key.h>
 
 #include <asm/alternative.h>
@@ -19,6 +20,15 @@
 #define ANNOTATE_NOSPEC_ALTERNATIVE \
 	ANNOTATE_IGNORE_ALTERNATIVE
 
+/*
+ * Intra-function call instruction. This should be used as a substitute
+ * for the call instruction when doing an intra-function call. It is
+ * similar to the call instruction but it tells objtool that this is
+ * an intra-function call.
+ */
+#define INTRA_FUNCTION_CALL \
+	ANNOTATE_INTRA_FUNCTION_CALL call
+
 /*
  * Fill the CPU return stack buffer.
  *
@@ -47,13 +57,13 @@
 #define __FILL_RETURN_BUFFER(reg, nr, sp)	\
 	mov	$(nr/2), reg;			\
 771:						\
-	call	772f;				\
+	INTRA_FUNCTION_CALL 772f;		\
 773:	/* speculation trap */			\
 	pause;					\
 	lfence;					\
 	jmp	773b;				\
 772:						\
-	call	774f;				\
+	INTRA_FUNCTION_CALL 774f;		\
 775:	/* speculation trap */			\
 	pause;					\
 	lfence;					\
@@ -83,7 +93,7 @@
  * invocation below less ugly.
  */
 .macro RETPOLINE_JMP reg:req
-	call	.Ldo_rop_\@
+	INTRA_FUNCTION_CALL .Ldo_rop_\@
 .Lspec_trap_\@:
 	pause
 	lfence
@@ -102,7 +112,7 @@
 .Ldo_retpoline_jmp_\@:
 	RETPOLINE_JMP \reg
 .Ldo_call_\@:
-	call	.Ldo_retpoline_jmp_\@
+	INTRA_FUNCTION_CALL .Ldo_retpoline_jmp_\@
 .endm
 
 /*
-- 
2.18.2

