Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D31C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E20222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbgBMOVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:21:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45596 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730157AbgBMOVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:21:55 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DEJDbo137542
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 09:21:54 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y4j8bqn17-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 09:21:54 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 13 Feb 2020 14:21:52 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Feb 2020 14:21:49 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01DEKsB640173906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 14:20:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B306DAE055;
        Thu, 13 Feb 2020 14:21:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E73AAE05A;
        Thu, 13 Feb 2020 14:21:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 13 Feb 2020 14:21:48 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
        id 2AF32E03C5; Thu, 13 Feb 2020 15:21:48 +0100 (CET)
From:   Christian Borntraeger <borntraeger@de.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, qemu-devel <qemu-devel@nongnu.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Yury Norov <yury.norov@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH] uapi: fix userspace breakage, use __BITS_PER_LONG for swap
Date:   Thu, 13 Feb 2020 15:21:47 +0100
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021314-0012-0000-0000-000003868148
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021314-0013-0000-0000-000021C304CC
Message-Id: <20200213142147.17604-1-borntraeger@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_04:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=976 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QEMU has a funny new build error message when I use the upstream kernel headers:

  CC      block/file-posix.o
In file included from /home/cborntra/REPOS/qemu/include/qemu/timer.h:4,
                 from /home/cborntra/REPOS/qemu/include/qemu/timed-average.h:29,
                 from /home/cborntra/REPOS/qemu/include/block/accounting.h:28,
                 from /home/cborntra/REPOS/qemu/include/block/block_int.h:27,
                 from /home/cborntra/REPOS/qemu/block/file-posix.c:30:
/usr/include/linux/swab.h: In function ‘__swab’:
/home/cborntra/REPOS/qemu/include/qemu/bitops.h:20:34: error: "sizeof" is not defined, evaluates to 0 [-Werror=undef]
   20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
      |                                  ^~~~~~
/home/cborntra/REPOS/qemu/include/qemu/bitops.h:20:41: error: missing binary operator before token "("
   20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
      |                                         ^
cc1: all warnings being treated as errors
make: *** [/home/cborntra/REPOS/qemu/rules.mak:69: block/file-posix.o] Error 1
rm tests/qemu-iotests/socket_scm_helper.o

This was triggered by commit d5767057c9a ("uapi: rename ext2_swab() to swab() and share globally in swab.h")
This patch is doing
+#include <asm/bitsperlong.h>
but it uses BITS_PER_LONG.

The kernel file asm/bitsperlong.h provide only __BITS_PER_LONG.

Let us use the __ variant in swap.h
Fixes: d5767057c9a ("uapi: rename ext2_swab() to swab() and share globally in swab.h")
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Allison Randal <allison@lohutok.net>
Cc: Joe Perches <joe@perches.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/uapi/linux/swab.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/swab.h b/include/uapi/linux/swab.h
index fa7f97da5b76..7272f85d6d6a 100644
--- a/include/uapi/linux/swab.h
+++ b/include/uapi/linux/swab.h
@@ -135,9 +135,9 @@ static inline __attribute_const__ __u32 __fswahb32(__u32 val)
 
 static __always_inline unsigned long __swab(const unsigned long y)
 {
-#if BITS_PER_LONG == 64
+#if __BITS_PER_LONG == 64
 	return __swab64(y);
-#else /* BITS_PER_LONG == 32 */
+#else /* __BITS_PER_LONG == 32 */
 	return __swab32(y);
 #endif
 }
-- 
2.24.1

