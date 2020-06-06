Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A87C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 18:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE3820760
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 18:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgFFST2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 14:19:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728812AbgFFST2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 14:19:28 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 056I1ZOp063374;
        Sat, 6 Jun 2020 14:19:22 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31g59q3rqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 06 Jun 2020 14:19:22 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 056IG2Hn006593;
        Sat, 6 Jun 2020 18:19:20 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 31g2s7rdaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 06 Jun 2020 18:19:20 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 056IJIUK36110520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 6 Jun 2020 18:19:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AD8BA4057;
        Sat,  6 Jun 2020 18:19:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08054A4053;
        Sat,  6 Jun 2020 18:19:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  6 Jun 2020 18:19:17 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id AAA26E0278; Sat,  6 Jun 2020 20:19:17 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH] kprobes: use strncpy_from_kernel_nofault() in fetch_store_string()
Date:   Sat,  6 Jun 2020 20:19:03 +0200
Message-Id: <20200606181903.49384-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-06_15:2020-06-04,2020-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 clxscore=1011 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 cotscore=-2147483648 bulkscore=0
 suspectscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006060140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the latest linux-next i noticed that some tests in the
ftrace test suites are failing on s390, namely:

[FAIL] Kprobe event symbol argument
[FAIL] Kprobe event with comm arguments

The following doesn't work anymore:

cd /sys/kernel/tracing
echo 'p:testprobe _do_fork comm=$comm ' >kprobe_events
echo 1 >events/kprobes/testprobe/enable
cat trace

it will just show

test.sh-519   [012] ....    18.580625: testprobe: (_do_fork+0x0/0x3c8) comm=(fault)

Looking at the source i see that there are two helpers for reading strings:

fetch_store_string_user() -> read string from user space
fetch_store_string() -> read string from kernel space(?)

but in the end both are using strncpy_from_user_nofault(), but
fetch_store_string() should use strncpy_from_kernel_nofault().

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Christoph Hellwig <hch@lst.de>
---
 kernel/trace/trace_kprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index b1f21d558e45..ea8d0b094f1b 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1278,7 +1278,7 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 	 * Try to get string again, since the string can be changed while
 	 * probing.
 	 */
-	ret = strncpy_from_user_nofault(__dest, (void *)addr, maxlen);
+	ret = strncpy_from_kernel_nofault(__dest, (void *)addr, maxlen);
 	if (ret >= 0)
 		*(u32 *)dest = make_data_loc(ret, __dest - base);
 
-- 
2.17.1

