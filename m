Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15FFC10F26
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A96208E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rjLtWSeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387848AbgDBIS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:18:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35612 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387673AbgDBISm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:18:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0328HYrj077923;
        Thu, 2 Apr 2020 08:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=Ef2pa02927Qld1ZvOk2wHvDroH04VM3OeZDhChTD2m0=;
 b=rjLtWSeYMZ5vG4Ek+ypOoKDSntC96AKgXao7d65X8LOn9DMZRcD1sQlE9inqbDBAdL2Z
 iYIjiDk+HRzUOMgH5TcsEivU1dlryNs00E5ZUC1aQIntIhXgDGvCaXchdI5B1unrAZHv
 nLZFrGYGxt/z3iT5UlpGgZLTXrHYkRk8NUd91Qaax2sNopDyfrOCsZ/IQG2lJDdY7yCP
 LaCyxFPTY03HOmaSa3JfqSxOPVusyxVDTPmAFGyIgZYvW8AVzcrmsTVJK4Il+Nc9GWvW
 lHIKV89QrWYCLawSJRQbvJq58ofv+ueluCq2dROp7IfoT0AbRjZauZAkTpk8BX3YPo5Q hA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 303cev9u7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 08:18:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0328Gxfm022036;
        Thu, 2 Apr 2020 08:18:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 302g2j3pwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 08:18:22 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0328ILTA020637;
        Thu, 2 Apr 2020 08:18:21 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 01:18:21 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jthierry@redhat.com, tglx@linutronix.de,
        alexandre.chartre@oracle.com
Subject: [PATCH 6/7] x86/speculation: Annotate retpoline return instructions
Date:   Thu,  2 Apr 2020 10:22:19 +0200
Message-Id: <20200402082220.808-7-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200402082220.808-1-alexandre.chartre@oracle.com>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=918 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=13 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=13 mlxscore=0 impostorscore=0 mlxlogscore=979 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With retpoline, the return instruction (ret) is used to branch to an
address stored on the stack. Provide a macro to annotate such trampoline
returns so they can be properly handled by objtool, and use this macro
to annotate retpoline return instructions.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/nospec-branch.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index a2885f801e13..9ae6dde2f10b 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -91,6 +91,20 @@
 	call \dst
 .endm
 
+/*
+ * Retpoline return instruction. This should be used as a substitute
+ * for the ret instruction when doing a trampoline return. It is
+ * similar to the ret instruction but it tells objtool this is a
+ * trampoline return.
+ */
+.macro RETPOLINE_RET
+	.Lannotate_\@:
+	.pushsection .discard.retpoline_ret
+	_ASM_PTR .Lannotate_\@
+	.popsection
+	ret
+.endm
+
 /*
  * These are the bare retpoline primitives for indirect jmp and call.
  * Do not use these directly; they only exist to make the ALTERNATIVE
@@ -104,7 +118,7 @@
 	jmp	.Lspec_trap_\@
 .Ldo_rop_\@:
 	mov	\reg, (%_ASM_SP)
-	ret
+	RETPOLINE_RET
 .endm
 
 /*
-- 
2.18.2

