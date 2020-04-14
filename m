Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9F6C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FCB820644
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nMxmkxUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438473AbgDNKlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:41:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40234 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438374AbgDNKcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:32:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EATjUu099291;
        Tue, 14 Apr 2020 10:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=gSGUwtyvCAjodF6yycFW4jVDd4XOe3sAR+7aKXD38Yw=;
 b=nMxmkxUTa7mPVml7GAXJR3UUmDvJXah8Ah7T+zNu54SWerisBUWzklwFg7vol111ogrJ
 M6Gbyvo2nzBRcfUKrJXZ2hdD3+Kj86s8zswS8+Doc/t/Y0l7OmrX2nXU5Wf0uxthzdI9
 GSeToA8E2k7omU7Vy89XIpKXhprGg1Ea4jDGFIPYb2VBY+7+vCJ2/0FxPkH0CUyIGJdr
 dN2rYNVkc55LfDZrbtsonUdLs03wYB2NpBESeb7EQETaFQRSsr6OT2mbdH2KhgTtkobp
 ySlaMkR3IPX5pJPvbWPkfkiE5KpckSnCH4XJfk2Tih50+Uu84IMPUNWjsSxrE38cGXYl kA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30b6hpkmf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 10:32:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EAR66d034899;
        Tue, 14 Apr 2020 10:32:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 30cta9ty06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 10:32:06 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03EAW6nf010236;
        Tue, 14 Apr 2020 10:32:06 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 03:32:05 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jthierry@redhat.com, tglx@linutronix.de,
        alexandre.chartre@oracle.com
Subject: [PATCH V3 9/9] x86/speculation: Annotate intra-function calls
Date:   Tue, 14 Apr 2020 12:36:18 +0200
Message-Id: <20200414103618.12657-10-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200414103618.12657-1-alexandre.chartre@oracle.com>
References: <20200414103618.12657-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=13
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 phishscore=0 suspectscore=13
 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140086
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
index 20594ea99c21..89ae2f9cc873 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -3,6 +3,7 @@
 #ifndef _ASM_X86_NOSPEC_BRANCH_H_
 #define _ASM_X86_NOSPEC_BRANCH_H_
 
+#include <linux/frame.h>
 #include <linux/static_key.h>
 
 #include <asm/alternative.h>
@@ -20,6 +21,15 @@
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
 #define __FILL_RETURN_BUFFER_BEGIN(reg, nr, sp)	\
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
@@ -90,7 +100,7 @@
  * invocation below less ugly.
  */
 .macro RETPOLINE_JMP reg:req
-	call	.Ldo_rop_\@
+	INTRA_FUNCTION_CALL .Ldo_rop_\@
 .Lspec_trap_\@:
 	pause
 	lfence
@@ -110,7 +120,7 @@
 .Ldo_retpoline_jmp_\@:
 	RETPOLINE_JMP \reg
 .Ldo_call_\@:
-	call	.Ldo_retpoline_jmp_\@
+	INTRA_FUNCTION_CALL .Ldo_retpoline_jmp_\@
 .endm
 
 /*
-- 
2.18.2

