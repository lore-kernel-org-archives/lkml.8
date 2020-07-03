Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670BBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B3FA20771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgGCG5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 02:57:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18016 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbgGCG5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:57:34 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0636XCU3158021;
        Fri, 3 Jul 2020 02:57:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32041gn4gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jul 2020 02:57:26 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0636XxgO160747;
        Fri, 3 Jul 2020 02:57:25 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32041gn4fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jul 2020 02:57:25 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0636o48L020525;
        Fri, 3 Jul 2020 06:57:23 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 31wwr8b9e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jul 2020 06:57:23 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0636vKUi57737468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jul 2020 06:57:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCBBAAE058;
        Fri,  3 Jul 2020 06:57:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3C74AE045;
        Fri,  3 Jul 2020 06:57:16 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.63.144])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Jul 2020 06:57:16 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        anju@linux.vnet.ibm.com, kan.liang@linux.intel.com,
        nasastry@in.ibm.com, kjain@linux.ibm.com
Subject: [PATCH] perf/tools/pmu-events/powerpc: Added nest imc metric events
Date:   Fri,  3 Jul 2020 12:26:58 +0530
Message-Id: <20200703065658.377467-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-03_02:2020-07-02,2020-07-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 suspectscore=1 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 cotscore=-2147483648 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007030048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added nest imc metric events.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 .../arch/powerpc/power9/nest_metrics.json     | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
index c121e526442a..8383a37647ad 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
@@ -15,5 +15,40 @@
 	"MetricExpr": "(hv_24x7@PM_PB_CYC\\,chip\\=?@ )",
         "MetricName": "PowerBUS_Frequency",
         "ScaleUnit": "2.5e-7GHz"
+    },
+    {
+	"MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT23@",
+	"MetricName" : "mcs01-read",
+	"MetricGroup" : "memory_bw",
+	"ScaleUnit": "6.1e-5MB"
+    },
+    {
+	"MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT23@",
+	"MetricName" : "mcs23-read",
+	"MetricGroup" : "memory_bw",
+	"ScaleUnit": "6.1e-5MB"
+    },
+    {
+	"MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT23@",
+	"MetricName" : "mcs01-write",
+	"MetricGroup" : "memory_bw",
+	"ScaleUnit": "6.1e-5MB"
+    },
+    {
+	"MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT23@",
+	"MetricName" : "mcs23-write",
+	"MetricGroup" : "memory-bandwidth",
+	"ScaleUnit": "6.1e-5MB"
+    },
+    {
+	"MetricExpr" : "nest_powerbus0_imc@PM_PB_CYC@",
+	"MetricName" : "powerbus_freq",
+	"ScaleUnit": "1e-9GHz"
+    },
+    {
+	"MetricExpr" : "(nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT23@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT23@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT23@ + nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT23@)",
+	"MetricName" : "Memory-bandwidth-MCS",
+	"MetricGroup" : "memory_bw",
+	"ScaleUnit": "6.1e-5MB"
     }
 ]
-- 
2.17.1

