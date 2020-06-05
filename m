Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4688AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 11:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CD12206FA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 11:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgFELGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 07:06:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726771AbgFELGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 07:06:13 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 055B25d0075695;
        Fri, 5 Jun 2020 07:05:39 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31fk7dk0n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 07:05:39 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 055At8vj002105;
        Fri, 5 Jun 2020 11:05:36 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 31end6h9vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 11:05:36 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 055B5YPU55378110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Jun 2020 11:05:34 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A8CE52059;
        Fri,  5 Jun 2020 11:05:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 51DFF5205A;
        Fri,  5 Jun 2020 11:05:34 +0000 (GMT)
Date:   Fri, 5 Jun 2020 13:05:34 +0200
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org
Subject: kprobes string reading broken on s390
Message-ID: <20200605110533.GA57038@tuxmaker.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-05_02:2020-06-04,2020-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 priorityscore=1501
 cotscore=-2147483648 phishscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006050081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

with the latest linux-next i noticed that some tests in the
ftrace test suites are failing on s390, namely:

[FAIL] Kprobe event symbol argument
[FAIL] Kprobe event with comm arguments

The following doesn't work anymore:

cd /sys/kernel/tracing
echo 'p:testprobe _do_fork comm=$comm ' >kprobe_events
echo 1 >/sys/kernel/tracing/events/kprobes/testprobe/enable
cat /sys/kernel/tracing/trace

it will just show

test.sh-519   [012] ....    18.580625: testprobe: (_do_fork+0x0/0x3c8) comm=(fault)

Looking at d411a9c4e95a ("tracing/kprobes: handle mixed kernel/userspace probes
better") i see that there are two helpers for reading strings:

fetch_store_string_user() -> read string from user space
fetch_store_string() -> read string from kernel space(?)

but in the end both are using strncpy_from_user_nofault(), but i would
think that fetch_store_string() should use strncpy_from_kernel_nofault().
However, i'm not sure about the exact semantics of fetch_store_string(),
as there where a lot of wrong assumptions in the past, especially since
on x86 you usually don't fail if you use the same function for accessing kernel
and userspace although it's technically wrong.

Regards,
Sven

commit 81408eab8fcc79dc0871a95462b13176d3446f5e
Author: Sven Schnelle <svens@linux.ibm.com>
Date:   Fri Jun 5 13:01:24 2020 +0200

    kprobes: use strncpy_from_kernel_nofault() in fetch_store_string()

    Signed-off-by: Sven Schnelle <svens@linux.ibm.com>

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
 
