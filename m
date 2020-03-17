Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1196DC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9042071C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgCQGY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 02:24:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726597AbgCQGY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 02:24:57 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02H6Juc4053502
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 02:24:56 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yrr5eud3r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 02:24:56 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kjain@linux.ibm.com>;
        Tue, 17 Mar 2020 06:24:54 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Mar 2020 06:24:48 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02H6Nkrg25559366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Mar 2020 06:23:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D5F111C06C;
        Tue, 17 Mar 2020 06:24:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D94D11C05E;
        Tue, 17 Mar 2020 06:24:37 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.63.85])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 Mar 2020 06:24:37 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, peterz@infradead.org,
        yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de, kjain@linux.ibm.com
Subject: [PATCH v5 04/11] powerpc/hv-24x7: Add rtas call in hv-24x7 driver to get processor details
Date:   Tue, 17 Mar 2020 11:53:26 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200317062333.14555-1-kjain@linux.ibm.com>
References: <20200317062333.14555-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031706-0028-0000-0000-000003E613F8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031706-0029-0000-0000-000024AB676C
Message-Id: <20200317062333.14555-5-kjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_01:2020-03-12,2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 spamscore=0
 suspectscore=0 mlxlogscore=371 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003170024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For hv_24x7 socket/chip level events, specific chip-id to which
the data requested should be added as part of pmu events.
But number of chips/socket in the system details are not exposed.

Patch implements read_sys_info_pseries() to get system
parameter values like number of sockets and chips per socket.
Rtas_call with token "PROCESSOR_MODULE_INFO"
is used to get these values.

Sub-sequent patch exports these values via sysfs.

Patch also make these parameters default to 1.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c              | 72 ++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/pseries.h |  3 +
 2 files changed, 75 insertions(+)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 48e8f4b17b91..9ae00f29bd21 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -20,6 +20,11 @@
 #include <asm/io.h>
 #include <linux/byteorder/generic.h>
 
+#ifdef CONFIG_PPC_RTAS
+#include <asm/rtas.h>
+#include <../../platforms/pseries/pseries.h>
+#endif
+
 #include "hv-24x7.h"
 #include "hv-24x7-catalog.h"
 #include "hv-common.h"
@@ -57,6 +62,69 @@ static bool is_physical_domain(unsigned domain)
 	}
 }
 
+#ifdef CONFIG_PPC_RTAS
+#define PROCESSOR_MODULE_INFO   43
+#define PROCESSOR_MAX_LENGTH	(8 * 1024)
+
+static int strbe16toh(const char *buf, int offset)
+{
+	return (buf[offset] << 8) + buf[offset + 1];
+}
+
+static u32		physsockets;	/* Physical sockets */
+static u32		physchips;	/* Physical chips */
+
+/*
+ * Function read_sys_info_pseries() make a rtas_call which require
+ * data buffer of size 8K. As standard 'rtas_data_buf' is of size
+ * 4K, we are adding new local buffer 'rtas_local_data_buf'.
+ */
+char rtas_local_data_buf[PROCESSOR_MAX_LENGTH] __cacheline_aligned;
+
+/*
+ * read_sys_info_pseries()
+ * Retrieve the number of sockets and chips per socket details
+ * through the get-system-parameter rtas call.
+ */
+void read_sys_info_pseries(void)
+{
+	int call_status, len, ntypes;
+
+	/*
+	 * Making system parameter: chips and sockets default to 1.
+	 */
+	physsockets = 1;
+	physchips = 1;
+	memset(rtas_local_data_buf, 0, PROCESSOR_MAX_LENGTH);
+	spin_lock(&rtas_data_buf_lock);
+
+	call_status = rtas_call(rtas_token("ibm,get-system-parameter"), 3, 1,
+				NULL,
+				PROCESSOR_MODULE_INFO,
+				__pa(rtas_local_data_buf),
+				PROCESSOR_MAX_LENGTH);
+
+	spin_unlock(&rtas_data_buf_lock);
+
+	if (call_status != 0) {
+		pr_info("%s %s Error calling get-system-parameter (0x%x)\n",
+			__FILE__, __func__, call_status);
+	} else {
+		rtas_local_data_buf[PROCESSOR_MAX_LENGTH - 1] = '\0';
+		len = strbe16toh(rtas_local_data_buf, 0);
+		if (len < 6)
+			return;
+
+		ntypes = strbe16toh(rtas_local_data_buf, 2);
+
+		if (!ntypes)
+			return;
+		physsockets = strbe16toh(rtas_local_data_buf, 4);
+		physchips = strbe16toh(rtas_local_data_buf, 6);
+	}
+}
+#endif /* CONFIG_PPC_RTAS */
+
 /* Domains for which more than one result element are returned for each event. */
 static bool domain_needs_aggregation(unsigned int domain)
 {
@@ -1605,6 +1673,10 @@ static int hv_24x7_init(void)
 	if (r)
 		return r;
 
+#ifdef CONFIG_PPC_RTAS
+	read_sys_info_pseries();
+#endif
+
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 13fa370a87e4..1727559ce304 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -19,6 +19,9 @@ extern void request_event_sources_irqs(struct device_node *np,
 struct pt_regs;
 
 extern int pSeries_system_reset_exception(struct pt_regs *regs);
+#ifdef CONFIG_PPC_RTAS
+extern void read_sys_info_pseries(void);
+#endif
 extern int pSeries_machine_check_exception(struct pt_regs *regs);
 extern long pseries_machine_check_realmode(struct pt_regs *regs);
 
-- 
2.18.1

