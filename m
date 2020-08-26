Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C49FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC4212087D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oXu9uOqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgHZJgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:36:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9428 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728414AbgHZJfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:35:31 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07Q93fqv062189;
        Wed, 26 Aug 2020 05:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=f6n5hA9DQ+0MPkLhlYXYoSErJsIfh7/Cf8XqwUfu8TU=;
 b=oXu9uOqcDBZ3rzFg2UKvVK0x0FIYDygwK4Lhd4yAF+Xoht64BCyEKZCyM2VDCye2lpqv
 UDYSMhAo2TYgmmyHS81nqfaw9Y4+2dsOzIq0x68gUtd6+LXu+qGJALsiRe2LkOd6OXHy
 QlZyQulJmhqe8OgK/S6Ur+xJC6ilqWMb8VMgvKrakypAsctk/CyNszQlw2s8Uwwu4WWm
 ujhqLScihwxyDNqKC2nnFeC17BEyvmQIZXJ8ncCv87LoWwOnS7FoJPlI5jbMXiOp2ui1
 PXlCEzdOEoPSWSzP2ASxnNarFgc0wtbn1dfldFWZ3kvZZAGHUbhEVSd+i+NYBRU0KtQh Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 335kkv369t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 05:33:07 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07Q9NEGF126698;
        Wed, 26 Aug 2020 05:33:07 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 335kkv3661-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 05:33:05 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07Q9X1M9010480;
        Wed, 26 Aug 2020 09:33:01 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 332utq2nma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 09:33:01 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07Q9WwTs29622674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 09:32:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8651D4C044;
        Wed, 26 Aug 2020 09:32:58 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1738A4C040;
        Wed, 26 Aug 2020 09:32:55 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.77.206.242])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Aug 2020 09:32:54 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        daniel@iogearbox.net, brho@google.com, srikar@linux.vnet.ibm.com,
        kjain@linux.ibm.com
Subject: [RFC] perf/core: Fixes hung issue on perf stat command during cpu hotplug
Date:   Wed, 26 Aug 2020 15:02:36 +0530
Message-Id: <20200826093236.446024-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-26_06:2020-08-25,2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1
 mlxlogscore=999 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1011 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008260072
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
 kernel/events/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5bfe8e3c6e44..330c53f7df9c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -115,9 +115,9 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
 	for (;;) {
 		ret = smp_call_function_single(task_cpu(p), remote_function,
 					       &data, 1);
-		ret = !ret ? data.ret : -EAGAIN;
-
-		if (ret != -EAGAIN)
+		if (!ret)
+			ret = data.ret;
+		else if (ret != -EAGAIN)
 			break;
 
 		cond_resched();
-- 
2.26.2

