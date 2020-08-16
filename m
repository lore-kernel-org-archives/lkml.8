Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92070C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 09:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AC8220674
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 09:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="okcL2Dh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgHPJIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 05:08:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62622 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727913AbgHPJIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 05:08:02 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07G90wr7057133;
        Sun, 16 Aug 2020 05:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kB5yi03LeL9Hvqd24hOEuzwD4p0PDCpiYqZ6RVgK6VQ=;
 b=okcL2Dh7vF/7rer7I+UTpiyPc4iB487EdjpElsaabflMyyfVc0pYpnjSlaPmkrTes5P2
 Bf8bDyiY0fzsV7arHk2lJhoDu/G9nwiMN1Jh6ruwRN3//IaVGLcIpzTEOeb9A2zGtc6j
 ckZDq7CvFCS6wQYB25ZgLZp3oUthROXfIJnlBhuKghg+0hReLbYWy0uP5O/sjygpSLav
 VrxemF6sRqC1uW4+Y1K+Q7Ll0sb6GFc2tQmPQd5Cv/SHaTzUKvxYUTR0l6RTYQw7WE22
 kgtHks6oUE79YE+ViDYdhtFpkXtkY4YSCQ9MU8v7EtX+TwbApvt/RouArDrrTdOijfPC Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32xxghktp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Aug 2020 05:07:53 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07G91OYb058074;
        Sun, 16 Aug 2020 05:07:53 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32xxghktns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Aug 2020 05:07:53 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07G96YOh026732;
        Sun, 16 Aug 2020 09:07:51 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 32x7b80nqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Aug 2020 09:07:51 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07G97ma425493998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Aug 2020 09:07:48 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BE964C052;
        Sun, 16 Aug 2020 09:07:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8410A4C040;
        Sun, 16 Aug 2020 09:07:43 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.90.146])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 16 Aug 2020 09:07:43 +0000 (GMT)
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
Subject: [PATCH v5 3/3] perf/tools/pmu_events/powerpc: Add hv_24x7 core level metric events
Date:   Sun, 16 Aug 2020 14:37:19 +0530
Message-Id: <20200816090719.72018-4-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200816090719.72018-1-kjain@linux.ibm.com>
References: <20200816090719.72018-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-16_02:2020-08-14,2020-08-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 suspectscore=1 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008160069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds hv_24x7 core level events in nest_metric.json file
and also add PerChip/PerCore field in metric events.

Result:

power9 platform:

command:# ./perf stat --metric-only -M PowerBUS_Frequency -C 0 -I 1000
     1.000070601                        1.9                        2.0
     2.000253881                        2.0                        1.9
     3.000364810                        2.0                        2.0

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Acked-by: Ian Rogers <irogers@google.com>
---
 .../arch/powerpc/power9/nest_metrics.json     | 35 ++++++++++++-------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
index 8383a37647ad..7a5d1bf543f8 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
@@ -1,37 +1,46 @@
 [
     {
-        "MetricExpr": "(hv_24x7@PM_MCS01_128B_RD_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS01_128B_RD_DISP_PORT23\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_RD_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_RD_DISP_PORT23\\,chip\\=?@)",
-        "MetricName": "Memory_RD_BW_Chip",
-        "MetricGroup": "Memory_BW",
-        "ScaleUnit": "1.6e-2MB"
+	"MetricExpr": "(hv_24x7@PM_MCS01_128B_RD_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS01_128B_RD_DISP_PORT23\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_RD_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_RD_DISP_PORT23\\,chip\\=?@)",
+	"MetricName": "Memory_RD_BW_Chip",
+	"MetricGroup": "Memory_BW",
+	"ScaleUnit": "1.6e-2MB",
+	"AggregationMode": "PerChip"
     },
     {
 	"MetricExpr": "(hv_24x7@PM_MCS01_128B_WR_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS01_128B_WR_DISP_PORT23\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_WR_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_WR_DISP_PORT23\\,chip\\=?@ )",
-        "MetricName": "Memory_WR_BW_Chip",
-        "MetricGroup": "Memory_BW",
-        "ScaleUnit": "1.6e-2MB"
+	"MetricName": "Memory_WR_BW_Chip",
+	"MetricGroup": "Memory_BW",
+	"ScaleUnit": "1.6e-2MB",
+	"AggregationMode": "PerChip"
     },
     {
 	"MetricExpr": "(hv_24x7@PM_PB_CYC\\,chip\\=?@ )",
-        "MetricName": "PowerBUS_Frequency",
-        "ScaleUnit": "2.5e-7GHz"
+	"MetricName": "PowerBUS_Frequency",
+	"ScaleUnit": "2.5e-7GHz",
+	"AggregationMode": "PerChip"
+    },
+    {
+	"MetricExpr": "(hv_24x7@CPM_CS_32MHZ_CYC\\,domain\\=3\\,core\\=?@ )",
+	"MetricName": "CPM_CS_32MHZ_CYC",
+	"ScaleUnit": "1MHz",
+	"AggregationMode": "PerCore"
     },
     {
 	"MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT23@",
 	"MetricName" : "mcs01-read",
-	"MetricGroup" : "memory_bw",
+	"MetricGroup" : "memory-bandwidth",
 	"ScaleUnit": "6.1e-5MB"
     },
     {
 	"MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT23@",
 	"MetricName" : "mcs23-read",
-	"MetricGroup" : "memory_bw",
+	"MetricGroup" : "memory-bandwidth",
 	"ScaleUnit": "6.1e-5MB"
     },
     {
 	"MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT23@",
 	"MetricName" : "mcs01-write",
-	"MetricGroup" : "memory_bw",
+	"MetricGroup" : "memory-bandwidth",
 	"ScaleUnit": "6.1e-5MB"
     },
     {
@@ -48,7 +57,7 @@
     {
 	"MetricExpr" : "(nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT23@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT23@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT23@ + nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT23@)",
 	"MetricName" : "Memory-bandwidth-MCS",
-	"MetricGroup" : "memory_bw",
+	"MetricGroup" : "memory-bandwidth",
 	"ScaleUnit": "6.1e-5MB"
     }
 ]
-- 
2.26.2

