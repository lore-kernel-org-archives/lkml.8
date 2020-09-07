Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88776C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39EBF215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TR4VGJTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgIGGmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 02:42:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726278AbgIGGmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 02:42:11 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0876XE5N196192;
        Mon, 7 Sep 2020 02:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7S8GbWhLsG5kHwEufwhruM95UC6ULYYUQNuwCdWdrxo=;
 b=TR4VGJTAb/GR8cDbpmWgehA4Ra2+NoPB20nlUyZRGPIsiSFOsErnWopGRLa/hX8A5cr6
 kddvUxcNWTLhXrAqp/6GUU41iEu+v9dKLyqZ7/igpDV9uvAIzsfySyunHVDvO7hpEpO0
 k9LZGEM166bMa6r6StstPnwDxVPymiAO6AQzaf96SAJGqhZR3BGywTLozVlsR25LL9SI
 mcjxqzk6JKtWYcRkxCAvgNHVge8mZ6eLmeK4ayZTPi0yfEHnD6anxHpeuwA0gqbydzKr
 514rBV2Zs9/jCSyMyHPOj0F1Kg1OOvagBa0PrvIYcBZVMDu7cFx+QT4weFC9WazlSAWi Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33dct5436d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 02:41:56 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0876XExk196170;
        Mon, 7 Sep 2020 02:41:56 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33dct5435s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 02:41:55 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0876bx7W024494;
        Mon, 7 Sep 2020 06:41:53 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 33cyq50sef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 06:41:53 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0876foWc57868742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Sep 2020 06:41:50 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81B31A4055;
        Mon,  7 Sep 2020 06:41:50 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47939A4040;
        Mon,  7 Sep 2020 06:41:45 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.49.245])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Sep 2020 06:41:45 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com, kjain@linux.ibm.com
Subject: [PATCH v9 1/5] perf/jevents: Remove jevents.h file
Date:   Mon,  7 Sep 2020 12:11:29 +0530
Message-Id: <20200907064133.75090-2-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907064133.75090-1-kjain@linux.ibm.com>
References: <20200907064133.75090-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-07_01:2020-09-07,2020-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=1 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009070064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes jevents.h and makes json_events function static.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Reviewed-by: John Garry <john.garry@huawei.com>
---
 tools/perf/pmu-events/jevents.c |  3 +--
 tools/perf/pmu-events/jevents.h | 23 -----------------------
 2 files changed, 1 insertion(+), 25 deletions(-)
 delete mode 100644 tools/perf/pmu-events/jevents.h

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index fc9c158bfa13..b9b938aaff16 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -48,7 +48,6 @@
 #include <linux/list.h>
 #include "jsmn.h"
 #include "json.h"
-#include "jevents.h"
 
 int verbose;
 char *prog;
@@ -512,7 +511,7 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
 }
 
 /* Call func with each event in the json file */
-int json_events(const char *fn,
+static int json_events(const char *fn,
 	  int (*func)(void *data, char *name, char *event, char *desc,
 		      char *long_desc,
 		      char *pmu, char *unit, char *perpkg,
diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
deleted file mode 100644
index 2afc8304529e..000000000000
--- a/tools/perf/pmu-events/jevents.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef JEVENTS_H
-#define JEVENTS_H 1
-
-int json_events(const char *fn,
-		int (*func)(void *data, char *name, char *event, char *desc,
-				char *long_desc,
-				char *pmu,
-				char *unit, char *perpkg, char *metric_expr,
-				char *metric_name, char *metric_group,
-				char *deprecated, char *metric_constraint),
-		void *data);
-char *get_cpu_str(void);
-
-#ifndef min
-#define min(x, y) ({                            \
-	typeof(x) _min1 = (x);                  \
-	typeof(y) _min2 = (y);                  \
-	(void) (&_min1 == &_min2);              \
-	_min1 < _min2 ? _min1 : _min2; })
-#endif
-
-#endif
-- 
2.26.2

