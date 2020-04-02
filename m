Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596DDC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D48F2078E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ITssYbGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387757AbgDBIUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:20:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37184 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387574AbgDBIUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:20:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0328HY4E077894;
        Thu, 2 Apr 2020 08:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=iba5b3mUkc/14uCaROWcx6FXN+mwbMuYL02AeGh4n2A=;
 b=ITssYbGLrf+bKCmzFl20d3J2ItO3jKAdrG/hkQHsnp/CJHyeBH+29NJDsE62i4tI9K7B
 K50lme4+sr4t8aM3ya1mUnzZZdS6qrrWPY4eCEHWQ4ByRr+AE3L+iU8hBxOmzPWWuOuy
 4yIGRoXpNb+ErhcYaoukM3/UsrQVfUWqh3hoTetNdMQfS+2WYiqHB7XhR15/8O5NFTpf
 mOvK91Y+RugG7JD3vut8xaQ5ELd2QxCRgSoB/2fnSA7pjyvhE1SVcCNGPrVEpGf3iBTw
 7FqxXJ5XQeu5DilmBwxYIX3O32ARyicPhq2VSx+sljpNDQD73/ZEyv7Qot/icRWfLlXl mQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 303cev9uj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 08:20:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0328I9sU135769;
        Thu, 2 Apr 2020 08:18:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 302ga20b3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 08:18:20 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0328IJeT003438;
        Thu, 2 Apr 2020 08:18:19 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 01:18:19 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jthierry@redhat.com, tglx@linutronix.de,
        alexandre.chartre@oracle.com
Subject: [PATCH 5/7] x86/speculation: Annotate intra-function calls
Date:   Thu,  2 Apr 2020 10:22:18 +0200
Message-Id: <20200402082220.808-6-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200402082220.808-1-alexandre.chartre@oracle.com>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=13 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=13 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020075
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
 arch/x86/include/asm/nospec-branch.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 5c24a7b35166..a2885f801e13 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -77,13 +77,27 @@
 	.popsection
 .endm
 
+/*
+ * Intra-function call instruction. This should be used as a substitute
+ * for the call instruction when doing an intra-function call. It is
+ * similar to the call instruction but it tells objtool that this is
+ * an intra-function call.
+ */
+.macro INTRA_FUNCTION_CALL dst:req
+	.Lannotate_\@:
+	.pushsection .discard.intra_function_call
+	_ASM_PTR .Lannotate_\@
+	.popsection
+	call \dst
+.endm
+
 /*
  * These are the bare retpoline primitives for indirect jmp and call.
  * Do not use these directly; they only exist to make the ALTERNATIVE
  * invocation below less ugly.
  */
 .macro RETPOLINE_JMP reg:req
-	call	.Ldo_rop_\@
+	INTRA_FUNCTION_CALL .Ldo_rop_\@
 .Lspec_trap_\@:
 	pause
 	lfence
@@ -102,7 +116,7 @@
 .Ldo_retpoline_jmp_\@:
 	RETPOLINE_JMP \reg
 .Ldo_call_\@:
-	call	.Ldo_retpoline_jmp_\@
+	INTRA_FUNCTION_CALL .Ldo_retpoline_jmp_\@
 .endm
 
 /*
-- 
2.18.2

