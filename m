Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF7AC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC52B21741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e2E/2Tr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgHZOzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:55:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726934AbgHZOzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:55:06 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07QEZ01A178064;
        Wed, 26 Aug 2020 10:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=+vAD9mgWouUbLENGzMvN+3S309Vo6tTngoxoVO8howw=;
 b=e2E/2Tr4m8IfADvUC+FpAdyUoQaN8Yp7PrD7HLZ88VMZBO83j4SkdGcZsNes0/WaAa5H
 CJyRHIznggDg9TEyEOFJ2UPn4kXeRYr9Mrk4sLEl9ntQUdJZA7xDqq+w6y98E2CFwbKY
 mSfxaRoCfDMjSyB2SG6SCyp3LvPLLw07tSSBO9wNWER1lFswn7pChpcNesmrjxm1j+jp
 n7ifXC+DJDslCfLD/m88X2NV8uGZw3ma/7sCDH+AwcA23/ROhWD0yifZofK5sJK2iEXC
 TdzhhN62Cnrx1QgPl1SBbz1ciff6pbo55Oa56Mpbqv5yI/Y1veFLcsoCrGY/wmZMYgnZ ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 335s9x9cma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 10:54:37 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07QEaAkh185748;
        Wed, 26 Aug 2020 10:54:37 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 335s9x9ck0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 10:54:37 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07QErFbs015495;
        Wed, 26 Aug 2020 14:54:35 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 335j270ak1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 14:54:34 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07QEsWes9896430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 14:54:32 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7C25AE04D;
        Wed, 26 Aug 2020 14:54:31 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D48FCAE057;
        Wed, 26 Aug 2020 14:54:27 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.63.208])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Aug 2020 14:54:27 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org, peterz@infradead.org
Cc:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        daniel@iogearbox.net, brho@google.com, srikar@linux.vnet.ibm.com,
        kjain@linux.ibm.com
Subject: [RFC v2] perf/core: Fixes hung issue on perf stat command during cpu hotplug
Date:   Wed, 26 Aug 2020 20:24:11 +0530
Message-Id: <20200826145411.489169-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-26_09:2020-08-26,2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2ed6edd33a21 ("perf: Add cond_resched() to task_function_call()")
added assignment of ret value as -EAGAIN in case function
call to 'smp_call_function_single' fails.
For non-zero ret value, it did
'ret = !ret ? data.ret : -EAGAIN;', which always
assign -EAGAIN to ret and make second if condition useless.

In scenarios like when executing a perf stat with --per-thread option, and
if any of the monitoring cpu goes offline, the 'smp_call_function_single'
function could return -ENXIO, and with the above check,
task_function_call hung and increases CPU
usage (because of repeated 'smp_call_function_single()')

Recration scenario:
	# perf stat -a --per-thread && (offline a CPU )

Patch here removes the tertiary condition added as part of that
commit and added a check for NULL and -EAGAIN.

Fixes: 2ed6edd33a21("perf: Add cond_resched() to task_function_call()")
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Changelog:
- Remove addition of else in the first patch for
  if(ret != -EAGAIN) condition.

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 856d98c36f56..fe104fee097a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -115,8 +115,8 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
 	for (;;) {
 		ret = smp_call_function_single(task_cpu(p), remote_function,
 					       &data, 1);
-		ret = !ret ? data.ret : -EAGAIN;
-
+		if(!ret)
+			ret = data.ret;
 		if (ret != -EAGAIN)
 			break;
 
-- 
2.26.2

