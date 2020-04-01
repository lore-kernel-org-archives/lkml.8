Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22000C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0283221707
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 06:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731906AbgDAGOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 02:14:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731883AbgDAGOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 02:14:12 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03163RY4018252
        for <linux-kernel@vger.kernel.org>; Wed, 1 Apr 2020 02:14:11 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30227wrkgu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 02:14:10 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 1 Apr 2020 07:13:54 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Apr 2020 07:13:49 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0316E1Mc60489818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Apr 2020 06:14:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D719AA4040;
        Wed,  1 Apr 2020 06:14:01 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BD15A4055;
        Wed,  1 Apr 2020 06:13:58 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.48.114])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Apr 2020 06:13:58 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@c-s.fr, naveen.n.rao@linux.vnet.ibm.com,
        peterz@infradead.org, jolsa@kernel.org, oleg@redhat.com,
        fweisbec@gmail.com, mingo@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com
Subject: [PATCH v2 05/16] powerpc/watchpoint: Provide DAWR number to set_dawr
Date:   Wed,  1 Apr 2020 11:42:58 +0530
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401061309.92442-1-ravi.bangoria@linux.ibm.com>
References: <20200401061309.92442-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20040106-4275-0000-0000-000003B769C1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040106-4276-0000-0000-000038CCBB6F
Message-Id: <20200401061309.92442-6-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 mlxlogscore=848
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004010054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce new parameter 'nr' to set_dawr() which indicates which DAWR
should be programed.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/include/asm/hw_breakpoint.h |  4 ++--
 arch/powerpc/kernel/dawr.c               | 15 ++++++++++-----
 arch/powerpc/kernel/process.c            |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index 518b41eef924..62549007c87a 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -104,10 +104,10 @@ static inline bool dawr_enabled(void)
 {
 	return dawr_force_enable;
 }
-int set_dawr(struct arch_hw_breakpoint *brk);
+int set_dawr(struct arch_hw_breakpoint *brk, int nr);
 #else
 static inline bool dawr_enabled(void) { return false; }
-static inline int set_dawr(struct arch_hw_breakpoint *brk) { return -1; }
+static inline int set_dawr(struct arch_hw_breakpoint *brk, int nr) { return -1; }
 #endif
 
 #endif	/* __KERNEL__ */
diff --git a/arch/powerpc/kernel/dawr.c b/arch/powerpc/kernel/dawr.c
index e91b613bf137..311e51ee09f4 100644
--- a/arch/powerpc/kernel/dawr.c
+++ b/arch/powerpc/kernel/dawr.c
@@ -16,7 +16,7 @@
 bool dawr_force_enable;
 EXPORT_SYMBOL_GPL(dawr_force_enable);
 
-int set_dawr(struct arch_hw_breakpoint *brk)
+int set_dawr(struct arch_hw_breakpoint *brk, int nr)
 {
 	unsigned long dawr, dawrx, mrd;
 
@@ -39,15 +39,20 @@ int set_dawr(struct arch_hw_breakpoint *brk)
 	if (ppc_md.set_dawr)
 		return ppc_md.set_dawr(dawr, dawrx);
 
-	mtspr(SPRN_DAWR0, dawr);
-	mtspr(SPRN_DAWRX0, dawrx);
+	if (nr == 0) {
+		mtspr(SPRN_DAWR0, dawr);
+		mtspr(SPRN_DAWRX0, dawrx);
+	} else {
+		mtspr(SPRN_DAWR1, dawr);
+		mtspr(SPRN_DAWRX1, dawrx);
+	}
 
 	return 0;
 }
 
 static void set_dawr_cb(void *info)
 {
-	set_dawr(info);
+	set_dawr(info, 0);
 }
 
 static ssize_t dawr_write_file_bool(struct file *file,
@@ -60,7 +65,7 @@ static ssize_t dawr_write_file_bool(struct file *file,
 	/* Send error to user if they hypervisor won't allow us to write DAWR */
 	if (!dawr_force_enable &&
 	    firmware_has_feature(FW_FEATURE_LPAR) &&
-	    set_dawr(&null_brk) != H_SUCCESS)
+	    set_dawr(&null_brk, 0) != H_SUCCESS)
 		return -ENODEV;
 
 	rc = debugfs_write_file_bool(file, user_buf, count, ppos);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 110db94cdf3c..b548a584e465 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -799,7 +799,7 @@ void __set_breakpoint(struct arch_hw_breakpoint *brk)
 
 	if (dawr_enabled())
 		// Power8 or later
-		set_dawr(brk);
+		set_dawr(brk, 0);
 	else if (IS_ENABLED(CONFIG_PPC_8xx))
 		set_breakpoint_8xx(brk);
 	else if (!cpu_has_feature(CPU_FTR_ARCH_207S))
-- 
2.21.1

