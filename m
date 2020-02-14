Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905FEC3B18F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 11:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E1A24677
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 11:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387441AbgBNLEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 06:04:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387424AbgBNLEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 06:04:05 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01EB0OhG020696
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 06:04:04 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y4j88jtce-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 06:04:04 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kjain@linux.ibm.com>;
        Fri, 14 Feb 2020 11:04:02 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Feb 2020 11:03:57 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01EB3u8I55705718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Feb 2020 11:03:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04404A4060;
        Fri, 14 Feb 2020 11:03:56 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F8C4A4064;
        Fri, 14 Feb 2020 11:03:51 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.37.109])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Feb 2020 11:03:50 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, peterz@infradead.org,
        yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        kjain@linux.ibm.com
Subject: [PATCH 2/8] powerpc/hv-24x7: Add rtas call in hv-24x7 driver to get processor details
Date:   Fri, 14 Feb 2020 16:33:29 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200214110335.31483-1-kjain@linux.ibm.com>
References: <20200214110335.31483-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021411-0008-0000-0000-00000352CBE3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021411-0009-0000-0000-00004A737854
Message-Id: <20200214110335.31483-3-kjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-14_03:2020-02-12,2020-02-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002140090
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
index 6dbbf70232aa..4248a9d1e2ed 100644
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
@@ -1615,6 +1683,10 @@ static int hv_24x7_init(void)
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

