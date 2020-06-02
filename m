Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9CBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D12AF208A7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgFBECT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:02:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726204AbgFBECS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 00:02:18 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05241lXO143603;
        Tue, 2 Jun 2020 00:01:50 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31d2u1mr0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 00:01:50 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05241n7T143849;
        Tue, 2 Jun 2020 00:01:49 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31d2u1mqxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 00:01:49 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05240W4U001535;
        Tue, 2 Jun 2020 04:01:39 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 31bf47t4ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 04:01:38 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05241aAE26083434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Jun 2020 04:01:36 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA16152051;
        Tue,  2 Jun 2020 04:01:35 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.55.113])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 82C925204E;
        Tue,  2 Jun 2020 04:01:32 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     ravi.bangoria@linux.ibm.com, apopple@linux.ibm.com,
        paulus@samba.org, npiggin@gmail.com, christophe.leroy@c-s.fr,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] powerpc/watchpoint: Return available watchpoints dynamically
Date:   Tue,  2 Jun 2020 09:31:05 +0530
Message-Id: <20200602040106.127693-7-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602040106.127693-1-ravi.bangoria@linux.ibm.com>
References: <20200602040106.127693-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-02_04:2020-06-01,2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 cotscore=-2147483648 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006020020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far Book3S Powerpc supported only one watchpoint. But Power10 is
introducing 2nd DAWR. Enable 2nd DAWR support for Power10. Availability
of 2nd DAWR will depend on CPU_FTR_DAWR1.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/include/asm/cputable.h      | 4 +++-
 arch/powerpc/include/asm/hw_breakpoint.h | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 3445c86e1f6f..f110f70a11bf 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -633,7 +633,9 @@ enum {
  * Maximum number of hw breakpoint supported on powerpc. Number of
  * breakpoints supported by actual hw might be less than this.
  */
-#define HBP_NUM_MAX	1
+#define HBP_NUM_MAX		2
+#define HBP_NUM_P7_TO_P9	1
+#define HBP_NUM_P10		2
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index f42a55eb77d2..0365a137d6e8 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -5,10 +5,11 @@
  * Copyright 2010, IBM Corporation.
  * Author: K.Prasad <prasad@linux.vnet.ibm.com>
  */
-
 #ifndef _PPC_BOOK3S_64_HW_BREAKPOINT_H
 #define _PPC_BOOK3S_64_HW_BREAKPOINT_H
 
+#include <asm/cpu_has_feature.h>
+
 #ifdef	__KERNEL__
 struct arch_hw_breakpoint {
 	unsigned long	address;
@@ -46,7 +47,7 @@ struct arch_hw_breakpoint {
 
 static inline int nr_wp_slots(void)
 {
-	return HBP_NUM_MAX;
+	return cpu_has_feature(CPU_FTR_DAWR1) ? HBP_NUM_P10 : HBP_NUM_P7_TO_P9;
 }
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
-- 
2.26.2

