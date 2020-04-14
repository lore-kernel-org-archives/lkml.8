Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49271C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 217E1206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BuuY1/1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438707AbgDNKzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:55:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41868 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438408AbgDNKeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:34:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EAXtBL102744;
        Tue, 14 Apr 2020 10:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=518JlHYtpnf7S9MSsRcoVNMQyEWg6HGX317JxfiansM=;
 b=BuuY1/1hidRwgD7IWfLiWLBnkwfV71zFECMa2Vutcp9FNOB+1AEn4HeH+uxATSwIfcgO
 68iLRIeGjm+K6Nbcw6XPe9st+/jDbPkCgf3AAhG6MzRV98lKvrqg3v3JbFR4Y7ZA0JsV
 AxCnYYY2Y8yZHrK2C9kudx30oia74p5FcredKujmqw/wMH6wUay8o4c5Npd2SwA+NR5u
 cnO9tjXKM1fON/NiM93xzhvY70W2Tyju/NPru+DzWNjTZVhg6C9D9ydCtDKoVQgU9wcK
 SSZnsIGBglu9DrWMpYkrdvbqktcHvVVxG/7isOD1bTOWFUE+1EgRnoC/vEaQ+6prF5Xd mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30b6hpkmsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 10:34:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EAR7R6034974;
        Tue, 14 Apr 2020 10:32:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 30cta9txxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 10:32:04 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03EAW4Gw010222;
        Tue, 14 Apr 2020 10:32:04 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 03:32:04 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jthierry@redhat.com, tglx@linutronix.de,
        alexandre.chartre@oracle.com
Subject: [PATCH V3 8/9] x86/speculation: Add return address unwind hints to retpoline and RSB stuffing
Date:   Tue, 14 Apr 2020 12:36:17 +0200
Message-Id: <20200414103618.12657-9-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200414103618.12657-1-alexandre.chartre@oracle.com>
References: <20200414103618.12657-1-alexandre.chartre@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
 engine=8.12.0-2003020000 definitions=main-2004140087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The retpoline and RSB stuffing code modify the stack to change return
addresses of intra-function calls. Add return address unwind hints so
that objtool can be aware of these tweaks. This requires a little
refactoring of the __FILL_RETURN_BUFFER macro for adding hints to
assembly and C code.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/nospec-branch.h | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index b0db793fd083..20594ea99c21 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -9,6 +9,7 @@
 #include <asm/alternative-asm.h>
 #include <asm/cpufeatures.h>
 #include <asm/msr-index.h>
+#include <asm/unwind_hints.h>
 
 /*
  * This should be used immediately before a retpoline alternative. It tells
@@ -43,7 +44,7 @@
  * the optimal version — two calls, each with their own speculation
  * trap should their return address end up getting used, in a loop.
  */
-#define __FILL_RETURN_BUFFER(reg, nr, sp)	\
+#define __FILL_RETURN_BUFFER_BEGIN(reg, nr, sp)	\
 	mov	$(nr/2), reg;			\
 771:						\
 	call	772f;				\
@@ -58,12 +59,19 @@
 	lfence;					\
 	jmp	775b;				\
 774:						\
-	dec	reg;				\
+	dec	reg;
+
+#define __FILL_RETURN_BUFFER_END(sp)		\
 	add	$(BITS_PER_LONG/8) * 2, sp;	\
 	jnz	771b;
 
 #ifdef __ASSEMBLY__
 
+#define __FILL_RETURN_BUFFER(reg, nr, sp)	\
+	__FILL_RETURN_BUFFER_BEGIN(reg, nr, sp)	\
+	UNWIND_HINT_RADDR_DELETE 2;		\
+	__FILL_RETURN_BUFFER_END(sp)
+
 /*
  * This should be used immediately before an indirect jump/call. It tells
  * objtool the subsequent indirect jump/call is vouched safe for retpoline
@@ -88,6 +96,7 @@
 	lfence
 	jmp	.Lspec_trap_\@
 .Ldo_rop_\@:
+	UNWIND_HINT_RADDR_ALTER
 	mov	\reg, (%_ASM_SP)
 	ret
 .endm
@@ -237,6 +246,11 @@ enum ssb_mitigation {
 extern char __indirect_thunk_start[];
 extern char __indirect_thunk_end[];
 
+#define __FILL_RETURN_BUFFER(reg, nr, sp)			\
+	__stringify(__FILL_RETURN_BUFFER_BEGIN(reg, nr, sp))	\
+	UNWIND_HINT_RADDR_DELETE(2)				\
+	__stringify(__FILL_RETURN_BUFFER_END(sp))
+
 /*
  * On VMEXIT we must ensure that no RSB predictions learned in the guest
  * can be followed in the host, by overwriting the RSB completely. Both
@@ -250,7 +264,7 @@ static inline void vmexit_fill_RSB(void)
 
 	asm volatile (ANNOTATE_NOSPEC_ALTERNATIVE
 		      ALTERNATIVE("jmp 910f",
-				  __stringify(__FILL_RETURN_BUFFER(%0, RSB_CLEAR_LOOPS, %1)),
+				  __FILL_RETURN_BUFFER(%0, RSB_CLEAR_LOOPS, %1),
 				  X86_FEATURE_RETPOLINE)
 		      "910:"
 		      : "=r" (loops), ASM_CALL_CONSTRAINT
-- 
2.18.2

