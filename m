Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FD6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DBF1207D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgENLSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:18:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61030 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727067AbgENLSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:18:33 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EB4j1D024519;
        Thu, 14 May 2020 07:18:15 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 310syx0688-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 07:18:15 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04EB5Fqi025657;
        Thu, 14 May 2020 07:18:14 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 310syx0677-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 07:18:14 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04EBG1AC019863;
        Thu, 14 May 2020 11:18:12 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3100ub3g7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 11:18:12 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04EBI9s947972522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 May 2020 11:18:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5936D42041;
        Thu, 14 May 2020 11:18:09 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD4464203F;
        Thu, 14 May 2020 11:18:05 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.59.186])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 May 2020 11:18:05 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@c-s.fr, naveen.n.rao@linux.vnet.ibm.com,
        peterz@infradead.org, jolsa@kernel.org, oleg@redhat.com,
        fweisbec@gmail.com, mingo@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com
Subject: [PATCH v6 05/16] powerpc/watchpoint: Provide DAWR number to set_dawr
Date:   Thu, 14 May 2020 16:47:30 +0530
Message-Id: <20200514111741.97993-6-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200514111741.97993-1-ravi.bangoria@linux.ibm.com>
References: <20200514111741.97993-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_02:2020-05-13,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 impostorscore=0 cotscore=-2147483648 phishscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=938 malwarescore=0
 clxscore=1015 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce new parameter 'nr' to set_dawr() which indicates which DAWR
should be programed.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Reviewed-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/hw_breakpoint.h |  4 ++--
 arch/powerpc/kernel/dawr.c               | 15 ++++++++++-----
 arch/powerpc/kernel/process.c            |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index 518b41eef924..5b3b02834e0b 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -104,10 +104,10 @@ static inline bool dawr_enabled(void)
 {
 	return dawr_force_enable;
 }
-int set_dawr(struct arch_hw_breakpoint *brk);
+int set_dawr(int nr, struct arch_hw_breakpoint *brk);
 #else
 static inline bool dawr_enabled(void) { return false; }
-static inline int set_dawr(struct arch_hw_breakpoint *brk) { return -1; }
+static inline int set_dawr(int nr, struct arch_hw_breakpoint *brk) { return -1; }
 #endif
 
 #endif	/* __KERNEL__ */
diff --git a/arch/powerpc/kernel/dawr.c b/arch/powerpc/kernel/dawr.c
index e91b613bf137..8114ad3a8574 100644
--- a/arch/powerpc/kernel/dawr.c
+++ b/arch/powerpc/kernel/dawr.c
@@ -16,7 +16,7 @@
 bool dawr_force_enable;
 EXPORT_SYMBOL_GPL(dawr_force_enable);
 
-int set_dawr(struct arch_hw_breakpoint *brk)
+int set_dawr(int nr, struct arch_hw_breakpoint *brk)
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
+	set_dawr(0, info);
 }
 
 static ssize_t dawr_write_file_bool(struct file *file,
@@ -60,7 +65,7 @@ static ssize_t dawr_write_file_bool(struct file *file,
 	/* Send error to user if they hypervisor won't allow us to write DAWR */
 	if (!dawr_force_enable &&
 	    firmware_has_feature(FW_FEATURE_LPAR) &&
-	    set_dawr(&null_brk) != H_SUCCESS)
+	    set_dawr(0, &null_brk) != H_SUCCESS)
 		return -ENODEV;
 
 	rc = debugfs_write_file_bool(file, user_buf, count, ppos);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index db766252238f..dc161b0adc82 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -806,7 +806,7 @@ void __set_breakpoint(struct arch_hw_breakpoint *brk)
 
 	if (dawr_enabled())
 		// Power8 or later
-		set_dawr(brk);
+		set_dawr(0, brk);
 	else if (IS_ENABLED(CONFIG_PPC_8xx))
 		set_breakpoint_8xx(brk);
 	else if (!cpu_has_feature(CPU_FTR_ARCH_207S))
-- 
2.26.2

