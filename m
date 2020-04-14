Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C3DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB5720732
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404571AbgDNDSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 23:18:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60242 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404573AbgDNDSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 23:18:44 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03E33hYi124655
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 23:18:42 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30bad882e1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 23:18:42 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 14 Apr 2020 04:18:06 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Apr 2020 04:18:01 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03E3IYjU41287980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 03:18:34 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05A3552050;
        Tue, 14 Apr 2020 03:18:34 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.60.157])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 640615204F;
        Tue, 14 Apr 2020 03:18:08 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@c-s.fr, naveen.n.rao@linux.vnet.ibm.com,
        peterz@infradead.org, jolsa@kernel.org, oleg@redhat.com,
        fweisbec@gmail.com, mingo@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com
Subject: [PATCH v3 03/16] powerpc/watchpoint: Introduce function to get nr watchpoints dynamically
Date:   Tue, 14 Apr 2020 08:46:46 +0530
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200414031659.58875-1-ravi.bangoria@linux.ibm.com>
References: <20200414031659.58875-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20041403-0016-0000-0000-000003041960
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041403-0017-0000-0000-000033680D02
Message-Id: <20200414031659.58875-4-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_11:2020-04-13,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=974 adultscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far we had only one watchpoint, so we have hardcoded HBP_NUM to 1.
But future Power architecture is introducing 2nd DAWR and thus kernel
should be able to dynamically find actual number of watchpoints
supported by hw it's running on. Introduce function for the same.
Also convert HBP_NUM macro to HBP_NUM_MAX, which will now represent
maximum number of watchpoints supported by Powerpc.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/include/asm/cputable.h      | 6 +++++-
 arch/powerpc/include/asm/hw_breakpoint.h | 5 +++++
 arch/powerpc/include/asm/processor.h     | 2 +-
 arch/powerpc/kernel/hw_breakpoint.c      | 2 +-
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 40a4d3c6fd99..c67b94f3334c 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -614,7 +614,11 @@ enum {
 };
 #endif /* __powerpc64__ */
 
-#define HBP_NUM 1
+/*
+ * Maximum number of hw breakpoint supported on powerpc. Number of
+ * breakpoints supported by actual hw might be less than this.
+ */
+#define HBP_NUM_MAX	1
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index f2f8d8aa8e3b..518b41eef924 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -43,6 +43,11 @@ struct arch_hw_breakpoint {
 #define DABR_MAX_LEN	8
 #define DAWR_MAX_LEN	512
 
+static inline int nr_wp_slots(void)
+{
+	return HBP_NUM_MAX;
+}
+
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 #include <linux/kdebug.h>
 #include <asm/reg.h>
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index eedcbfb9a6ff..90f6dbc7ff00 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -180,7 +180,7 @@ struct thread_struct {
 	int		fpexc_mode;	/* floating-point exception mode */
 	unsigned int	align_ctl;	/* alignment handling control */
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
-	struct perf_event *ptrace_bps[HBP_NUM];
+	struct perf_event *ptrace_bps[HBP_NUM_MAX];
 	/*
 	 * Helps identify source of single-step exception and subsequent
 	 * hw-breakpoint enablement
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 72f461bd70fb..4120349e2abe 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -38,7 +38,7 @@ static DEFINE_PER_CPU(struct perf_event *, bp_per_reg);
 int hw_breakpoint_slots(int type)
 {
 	if (type == TYPE_DATA)
-		return HBP_NUM;
+		return nr_wp_slots();
 	return 0;		/* no instruction breakpoints available */
 }
 
-- 
2.21.1

