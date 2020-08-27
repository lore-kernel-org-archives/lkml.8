Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0445C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56F8120707
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qk4puC9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgH0NTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 09:19:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726839AbgH0NMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:12:31 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RD2rGi023185;
        Thu, 27 Aug 2020 09:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kB5yi03LeL9Hvqd24hOEuzwD4p0PDCpiYqZ6RVgK6VQ=;
 b=qk4puC9aesl7/8i64Geew5RiCk64EJ/DsU6GRPDhgwj5HEL18PdApaMse26885Efl4oe
 nJyjtGXtheX7N744wv4KZTTacYxaxo+/jemXL+jq7oW7+4izh07coUbN7wTKgbRXw27J
 qh/RD9qziy/JNserPhtUiztkB//lLpiUSEwRyXGPNRpKiGz6DUiTjYZk89aV9mWXu1MV
 1AYV+eAo6b7Mi8MQ0GWWtg43wi1kQsCYIqti2x7/6EkbdbsjOLeMVZqLqvtRPMmBsXSf
 /zVYl+VoCvLjQ888FSAy98L5FJhFYouQjxcrMxO2BYlpnfG0pwCYkKiehvY4zAWpck7i lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 336bakm90k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:12:20 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07RD3DAX024904;
        Thu, 27 Aug 2020 09:12:19 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 336bakm8yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:12:19 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07RD8SN2006995;
        Thu, 27 Aug 2020 13:12:17 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 336buh03g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 13:12:17 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07RDCEpe32309600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 13:12:14 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7891A405F;
        Thu, 27 Aug 2020 13:12:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10C20A4060;
        Thu, 27 Aug 2020 13:12:07 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.79.210.202])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Aug 2020 13:12:06 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com, kjain@linux.ibm.com
Subject: [PATCH v6 5/5] perf/tools/pmu_events/powerpc: Add hv_24x7 core level metric events
Date:   Thu, 27 Aug 2020 18:39:58 +0530
Message-Id: <20200827130958.189146-6-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827130958.189146-1-kjain@linux.ibm.com>
References: <20200827130958.189146-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_07:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 malwarescore=0
 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270094
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

