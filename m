Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB550C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA3B2078E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wj0xISE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387806AbgDBIUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:20:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41182 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387574AbgDBIUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:20:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0328HfN3196532;
        Thu, 2 Apr 2020 08:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=EaXZFFeTA8O4D6nJYJebiWR5e5W/VsgY5MuEdEEr1P4=;
 b=Wj0xISE+q64qxa8ro83BtW1HdoFGaxzEvWk32mkVRxai8vcRDcqi9gpv9PC/70o6oawN
 LSypU3xZZ6T8BcI6Ogoh+7muljEbeZ54Dx/Erb6edOeNncZxNjzqKOEXYl6zBtirP46g
 yFZ+ixZttO43wgyycYt5dVHs76sMl7WQxuZuzBEvWpCAQ2+wpHAaeBwFFP+D0Rtua1An
 vvEySFZ/cQpLiAybBhfZXGAK8JS7YzTpCpLtYplmisWXKgv/mW0Cbqjv2iMYn5yHQ20R
 V8pAtP5NhpRJO9mYRIyp1vn4zIhr4pSzOYojdfQedCqVy716s2rKNshvWcoqasaJUzWw Xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 303yuncefc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 08:20:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0328H72f126289;
        Thu, 2 Apr 2020 08:18:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 304sjnssyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 08:18:24 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0328INsu003454;
        Thu, 2 Apr 2020 08:18:23 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 01:18:23 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jthierry@redhat.com, tglx@linutronix.de,
        alexandre.chartre@oracle.com
Subject: [PATCH 7/7] x86/speculation: Remove most ANNOTATE_NOSPEC_ALTERNATIVE
Date:   Thu,  2 Apr 2020 10:22:20 +0200
Message-Id: <20200402082220.808-8-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200402082220.808-1-alexandre.chartre@oracle.com>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=13 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 suspectscore=13 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that intra-function calls and retpoline return instructions have
been annotated and that they are supported by objtool, almost all
ANNOTATE_NOSPEC_ALTERNATIVE can be removed.

ANNOTATE_NOSPEC_ALTERNATIVE is still needed when using the
__FILL_RETURN_BUFFER macro because it loops on intra-function calls
and objtool doesn't handle loops modifying the stack pointer.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/nospec-branch.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 9ae6dde2f10b..70d4444120b1 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -140,7 +140,6 @@
  */
 .macro JMP_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
-	ANNOTATE_NOSPEC_ALTERNATIVE
 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *\reg),	\
 		__stringify(RETPOLINE_JMP \reg), X86_FEATURE_RETPOLINE,	\
 		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *\reg), X86_FEATURE_RETPOLINE_AMD
@@ -151,7 +150,6 @@
 
 .macro CALL_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
-	ANNOTATE_NOSPEC_ALTERNATIVE
 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *\reg),	\
 		__stringify(RETPOLINE_CALL \reg), X86_FEATURE_RETPOLINE,\
 		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *\reg), X86_FEATURE_RETPOLINE_AMD
@@ -190,7 +188,6 @@
  * which is ensured when CONFIG_RETPOLINE is defined.
  */
 # define CALL_NOSPEC						\
-	ANNOTATE_NOSPEC_ALTERNATIVE				\
 	ALTERNATIVE_2(						\
 	ANNOTATE_RETPOLINE_SAFE					\
 	"call *%[thunk_target]\n",				\
@@ -209,7 +206,6 @@
  * here, anyway.
  */
 # define CALL_NOSPEC						\
-	ANNOTATE_NOSPEC_ALTERNATIVE				\
 	ALTERNATIVE_2(						\
 	ANNOTATE_RETPOLINE_SAFE					\
 	"call *%[thunk_target]\n",				\
-- 
2.18.2

