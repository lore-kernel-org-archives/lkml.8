Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F4AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 807F62078D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dl+SLCO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgHUIJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:09:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38342 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726239AbgHUIJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:09:48 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07L843Yv002860;
        Fri, 21 Aug 2020 04:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Pm8s+o6jRPa9NYp7ijwD+XJfdsiqQJcILTOc0JqbjwU=;
 b=Dl+SLCO2Jsh7mZvYnxr5726XZRHrgd2c5boW0GoBO/O+M7BRO6tNU4sCvAqtJRSqTVKH
 vFZywkAm3u0JQ5P86K/jjTyhwgNRh+d5RmyVTslIh7FySp1HOogkVgoz0lQCzZ5Qw9sC
 cC5AurYVi7TZm0o52VUx4rXrDnLHOZd8cA+YmhSd9WvL69iTUVRiKnwKOHztZ5DKoYt6
 P5OEsznkzEOZLY2/0nd0y7FfWRHsCApBHZWXECbbB6nh5JU3380Y7C3MK0C/Hm48nxph
 AA8Y1uT6RA6LxD11k1Fz92t8BzdaPMT0AtIKA4Iv7/5iDSS515sU27qBHPTU5B3I3lMP fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 331an7jvbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 04:09:46 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07L84N62004336;
        Fri, 21 Aug 2020 04:09:46 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 331an7jvar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 04:09:46 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07L82PDq016627;
        Fri, 21 Aug 2020 08:09:44 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 330tbvttda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 08:09:44 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07L89fse29753624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 08:09:42 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA3E411C050;
        Fri, 21 Aug 2020 08:09:41 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C146711C05B;
        Fri, 21 Aug 2020 08:09:39 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.47.231])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Aug 2020 08:09:39 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, kjain@linux.ibm.com
Subject: [PATCH] perf/tools/pmu-events/powerpc: update nest metric event to utilize other metrics
Date:   Fri, 21 Aug 2020 13:39:23 +0530
Message-Id: <20200821080923.126522-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_05:2020-08-19,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 mlxscore=0
 suspectscore=1 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch take advantage of the new capability added to use
computed metrics in calculating other metrics. It also update
metric group for nest events to make it consistent for all nest
memory events.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 .../arch/powerpc/power9/nest_metrics.json      | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
index 8383a37647ad..a21e179edaf9 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
@@ -18,25 +18,25 @@
     },
     {
 	"MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT23@",
-	"MetricName" : "mcs01-read",
-	"MetricGroup" : "memory_bw",
+	"MetricName" : "mcs01_read",
+	"MetricGroup" : "memory-bandwidth",
 	"ScaleUnit": "6.1e-5MB"
     },
     {
 	"MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT23@",
-	"MetricName" : "mcs23-read",
-	"MetricGroup" : "memory_bw",
+	"MetricName" : "mcs23_read",
+	"MetricGroup" : "memory-bandwidth",
 	"ScaleUnit": "6.1e-5MB"
     },
     {
 	"MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT23@",
-	"MetricName" : "mcs01-write",
-	"MetricGroup" : "memory_bw",
+	"MetricName" : "mcs01_write",
+	"MetricGroup" : "memory-bandwidth",
 	"ScaleUnit": "6.1e-5MB"
     },
     {
 	"MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT23@",
-	"MetricName" : "mcs23-write",
+	"MetricName" : "mcs23_write",
 	"MetricGroup" : "memory-bandwidth",
 	"ScaleUnit": "6.1e-5MB"
     },
@@ -46,9 +46,9 @@
 	"ScaleUnit": "1e-9GHz"
     },
     {
-	"MetricExpr" : "(nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT23@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT23@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT23@ + nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT23@)",
+	"MetricExpr" : "mcs01_read + mcs23_read + mcs01_write + mcs23_write",
 	"MetricName" : "Memory-bandwidth-MCS",
-	"MetricGroup" : "memory_bw",
+	"MetricGroup" : "memory-bandwidth",
 	"ScaleUnit": "6.1e-5MB"
     }
 ]
-- 
2.17.1

