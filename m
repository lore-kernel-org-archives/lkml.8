Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93105C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7619E20771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgFSNed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:34:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732844AbgFSNea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:34:30 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05JDXVxk115048
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:34:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31rwwtrxuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:34:30 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05JDXZsF115408
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:34:29 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31rwwtrxu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 09:34:29 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05JDUVgf010604;
        Fri, 19 Jun 2020 13:34:27 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 31qur633et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 13:34:27 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05JDYP2142926310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jun 2020 13:34:25 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F40814C052;
        Fri, 19 Jun 2020 13:34:24 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 572B14C044;
        Fri, 19 Jun 2020 13:34:23 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.63.130])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Jun 2020 13:34:23 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@redhat.com
Cc:     ravi.bangoria@linux.ibm.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf record: Fix --switch-output=time documentation
Date:   Fri, 19 Jun 2020 19:04:12 +0530
Message-Id: <20200619133412.50705-2-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200619133412.50705-1-ravi.bangoria@linux.ibm.com>
References: <20200619133412.50705-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_14:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=874 cotscore=-2147483648
 clxscore=1015 mlxscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=1 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf record man page uses word 'size' while describing
--switch-output=time option. Fix that.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/Documentation/perf-record.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index fa8a5fcd27ab..5256f5e12dde 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -540,7 +540,7 @@ based on 'mode' value:
   "signal" - when receiving a SIGUSR2 (default value) or
   <size>   - when reaching the size threshold, size is expected to
              be a number with appended unit character - B/K/M/G
-  <time>   - when reaching the time threshold, size is expected to
+  <time>   - when reaching the time threshold, time is expected to
              be a number with appended unit character - s/m/h/d
 
              Note: the precision of  the size  threshold  hugely depends
-- 
2.17.1

