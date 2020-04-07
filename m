Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343C8C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0711620678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vqZgC00F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgDGH2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 03:28:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47102 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbgDGH16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 03:27:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0377RcCM152481;
        Tue, 7 Apr 2020 07:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=Yi+ISfW4XANqf5H7nQYfhfCeBbpWZmxIlhqEHhJfA5w=;
 b=vqZgC00FDwCa74cj7JpjQ6dXHrDGdR3y6qjJS6A4U1ez/K3h43+SVi5mEXmteO7vJolY
 u53oCUNS64LHHGtU2x6IyzFg5dknA34YzdHh2/ZifrW/p2cntM/y+FjwMLL0qQlFPtQ1
 nkUAPCUJUMcv7X3LE8/0hef1MPitiUo+hgdRTaMbVtw0UNoBRmu5J96DENz5Ocz3bocv
 j5AGHrHkGl7J7jYMamMhFYlNvpBbiQeoHLbe+RX8EnTYhmSjtPofc2Ge4OX6Po+hVynD
 O9tC5eMmfedRWb4nhAvG8MpD/8qmdqdrT+kz/s5a+/19kgQtKgMXgrwcT6RtS+jyfAYf QQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 308ffd93jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 07:27:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0377RIZh078195;
        Tue, 7 Apr 2020 07:27:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3073qf781j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 07:27:44 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0377RhGX032020;
        Tue, 7 Apr 2020 07:27:43 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Apr 2020 00:27:43 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jthierry@redhat.com, tglx@linutronix.de,
        alexandre.chartre@oracle.com
Subject: [PATCH V2 8/9] x86/speculation: Add unwind hint to trampoline return
Date:   Tue,  7 Apr 2020 09:31:41 +0200
Message-Id: <20200407073142.20659-9-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200407073142.20659-1-alexandre.chartre@oracle.com>
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=13
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

With retpoline, the address to branch to is pushed on the stack and
the return instruction (ret) is used to jump to that address. Use the
UNWIND_HINT_RET_OFFSET directive to inform objtool that the stack
should be adjusted.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>

replace RETPOLINE_RET with UNWIND_HINT_RET_OFFSET
---
 arch/x86/include/asm/nospec-branch.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index a345c6fa0541..5ce2a40a26da 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -10,6 +10,7 @@
 #include <asm/alternative-asm.h>
 #include <asm/cpufeatures.h>
 #include <asm/msr-index.h>
+#include <asm/unwind_hints.h>
 
 /*
  * This should be used immediately before a retpoline alternative. It tells
@@ -100,6 +101,7 @@
 	jmp	.Lspec_trap_\@
 .Ldo_rop_\@:
 	mov	\reg, (%_ASM_SP)
+	UNWIND_HINT_RET_OFFSET
 	ret
 .endm
 
-- 
2.18.2

