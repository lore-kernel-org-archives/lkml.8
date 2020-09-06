Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30209C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 11:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3D3320714
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 11:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sldUYTrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgIFLZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 07:25:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728028AbgIFLVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 07:21:21 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 086B29ng092452;
        Sun, 6 Sep 2020 07:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kB5yi03LeL9Hvqd24hOEuzwD4p0PDCpiYqZ6RVgK6VQ=;
 b=sldUYTrl9M/+FbLlVB3+pzGWRPYv4S94qSlEXFUqWmxvkOFrqzsxaLlsKdCsoc+hGd4R
 Y4pvJkYgywT5CI3dErT8Z3aaaYdFC9bbJFX3DmOD442cvon3/tMoFxoKejj8cTdLXmIu
 6Nj6Ver22AnO/yQCp5ydP8BKhj0HVIDvK9gRM4FMF/mQl8HBlN6rfgfzkJxuWH/OOGh6
 bjbwL5PesQ30DcuVcM20swKw0Y68Onx8PLtd4J6PyhuPcUIKcxIYF+wEpQzHdgE7RFpE
 V2m7ofZEFCWktSYor+QmK1LXfouqUcZar4cHMJJXc3bQaBR7Kgy0LR/VjfAhSNZ/dtYk lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33cx9kgg31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Sep 2020 07:21:10 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 086BKdWx125590;
        Sun, 6 Sep 2020 07:21:10 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33cx9kgg2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Sep 2020 07:21:10 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 086BIUKj018601;
        Sun, 6 Sep 2020 11:21:08 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 33c2a88qeu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Sep 2020 11:21:08 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 086BJX0p19071316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Sep 2020 11:19:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60AC8AE045;
        Sun,  6 Sep 2020 11:21:05 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A07BAE055;
        Sun,  6 Sep 2020 11:20:58 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.79.216.239])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  6 Sep 2020 11:20:57 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com, kjain@linux.ibm.com
Subject: [PATCH v8 5/5] perf/tools/pmu_events/powerpc: Add hv_24x7 core level metric events
Date:   Sun,  6 Sep 2020 16:50:04 +0530
Message-Id: <20200906112004.49574-6-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200906112004.49574-1-kjain@linux.ibm.com>
References: <20200906112004.49574-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-06_07:2020-09-04,2020-09-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=1 phishscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009060104
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

