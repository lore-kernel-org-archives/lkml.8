Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99246C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CEDE2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hg9ohOO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438763AbgDNK5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:57:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56808 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438371AbgDNKcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:32:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EAScbp068656;
        Tue, 14 Apr 2020 10:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=3p1j6Zpc0T5oSWETKEAt6DX6J3lh6Nx7VnHyJQjN88o=;
 b=hg9ohOO/H2y040DGVoV3f3hZ3F4C5eTBusFLgwwsCa3yQV7EK5g38C7AhA16ctgyTzgi
 2J+F8N7mo34fDsOKmzUYbfqFtApM/40MjKs5chnPT8hHeeOA9/fXBAQfEy7bXTqnUfkQ
 xtAOYgb+ZLz91Ikvg9IWHX3jhWma32r5hNQsU6tC11T/ArsXq+9zgqDOrK/+H0j6LsFK
 MpTKLtsRkHVPbz9Qm1dZZF+AAqMcqiuUB6qcpUptRsbKrXuHGds/kDHeDvtStUCzRzMz
 Q6WZmWZnWTAn/cxMCB95AQNiioj+ANu58StQCkDoRB7DcScW7teT+Xnzk+83cGBHCXaC Rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30b5ar3n0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 10:32:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EAVjEL174157;
        Tue, 14 Apr 2020 10:32:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 30bqch8u98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 10:32:03 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03EAW2bU013728;
        Tue, 14 Apr 2020 10:32:02 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 03:32:02 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jthierry@redhat.com, tglx@linutronix.de,
        alexandre.chartre@oracle.com
Subject: [PATCH V3 7/9] x86/speculation: Change __FILL_RETURN_BUFFER to work with objtool
Date:   Tue, 14 Apr 2020 12:36:16 +0200
Message-Id: <20200414103618.12657-8-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200414103618.12657-1-alexandre.chartre@oracle.com>
References: <20200414103618.12657-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=13 mlxlogscore=897
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 mlxlogscore=957 suspectscore=13 adultscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change __FILL_RETURN_BUFFER so that the stack state is deterministically
defined for each iteration and that objtool can have an accurate view
of the stack.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/nospec-branch.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 07e95dcb40ad..b0db793fd083 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -59,8 +59,8 @@
 	jmp	775b;				\
 774:						\
 	dec	reg;				\
-	jnz	771b;				\
-	add	$(BITS_PER_LONG/8) * nr, sp;
+	add	$(BITS_PER_LONG/8) * 2, sp;	\
+	jnz	771b;
 
 #ifdef __ASSEMBLY__
 
-- 
2.18.2

