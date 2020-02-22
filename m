Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9831C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 08:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACA520707
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 08:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgBVIVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 03:21:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726689AbgBVIVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 03:21:38 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01M8Kf9n103831
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 03:21:37 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yax35ksw0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 03:21:36 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Sat, 22 Feb 2020 08:21:34 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 22 Feb 2020 08:21:31 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01M8LUw244105840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Feb 2020 08:21:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB27911C052;
        Sat, 22 Feb 2020 08:21:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F027C11C04A;
        Sat, 22 Feb 2020 08:21:25 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.56.185])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 22 Feb 2020 08:21:25 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     christophe.leroy@c-s.fr, mikey@neuling.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH] powerpc/watchpoint: Don't call dar_within_range() for Book3S
Date:   Sat, 22 Feb 2020 13:50:49 +0530
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022208-0008-0000-0000-000003555D9E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022208-0009-0000-0000-00004A767210
Message-Id: <20200222082049.330435-1-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-22_02:2020-02-21,2020-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=1 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002220074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAR is set to the first byte of overlap between actual access and
watched range at DSI on Book3S processor. But actual access range
might or might not be within user asked range. So for Book3S, it
must not call dar_within_range().

This revert portion of commit 39413ae00967 ("powerpc/hw_breakpoints:
Rewrite 8xx breakpoints to allow any address range size.").

Before patch:
  # ./tools/testing/selftests/powerpc/ptrace/perf-hwbreak
  ...
  TESTED: No overlap
  FAILED: Partial overlap: 0 != 2
  TESTED: Partial overlap
  TESTED: No overlap
  FAILED: Full overlap: 0 != 2
  failure: perf_hwbreak

After patch:
  TESTED: No overlap
  TESTED: Partial overlap
  TESTED: Partial overlap
  TESTED: No overlap
  TESTED: Full overlap
  success: perf_hwbreak

Fixes: 39413ae00967 ("powerpc/hw_breakpoints: Rewrite 8xx breakpoints to allow any address range size.")
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/kernel/hw_breakpoint.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 2462cd7c565c..d0854320bb50 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -331,11 +331,13 @@ int hw_breakpoint_handler(struct die_args *args)
 	}
 
 	info->type &= ~HW_BRK_TYPE_EXTRANEOUS_IRQ;
-	if (!dar_within_range(regs->dar, info))
-		info->type |= HW_BRK_TYPE_EXTRANEOUS_IRQ;
-
-	if (!IS_ENABLED(CONFIG_PPC_8xx) && !stepping_handler(regs, bp, info))
-		goto out;
+	if (IS_ENABLED(CONFIG_PPC_8xx)) {
+		if (!dar_within_range(regs->dar, info))
+			info->type |= HW_BRK_TYPE_EXTRANEOUS_IRQ;
+	} else {
+		if (!stepping_handler(regs, bp, info))
+			goto out;
+	}
 
 	/*
 	 * As a policy, the callback is invoked in a 'trigger-after-execute'
-- 
2.21.1

