Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AC2C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 13:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 588E9206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 13:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q9sUDNhq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbgIJNAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 09:00:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730697AbgIJMwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:52:50 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08ACoHZQ155233;
        Thu, 10 Sep 2020 08:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XCGPFdJDRhSD6BYyrO0776MZXu2m1gbIciYT8AhSmc4=;
 b=Q9sUDNhqV4nZ7gpntKdlVg5GlgWK4mZR32AnSSLyNR6E9DhYvfhzh3lEkuc27EZkKf8a
 sBiGOXwTdbs+6VAurJCENMeHbIZbpSepK1KvzMUZ1t8/K6rFChrWbW59/QzDp7yg3E8v
 9rIeqrqj5VynFa7314B9NP3zLuSNsBGq8AJ8l6pP+1QmZr3lG0XFLW5WxJ81l4fYvDYF
 sxdFhgBjRmldDppBRJB6Nk7UafyLNC0dYuMwiYGESZQf90s4R8AGtGWQlnIGzd9DUBAz
 JtOcEzHpT9WERL8/tdD/fAyDtcLBZAVPC45HddCzAblm80efU950D3bGjDApn8Kj1yiA cQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33fkt8h7nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 08:52:06 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08ACknD4018541;
        Thu, 10 Sep 2020 12:52:03 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 33c2a8e25g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 12:52:03 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08ACq0a633358174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 12:52:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CED31A405F;
        Thu, 10 Sep 2020 12:52:00 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B422A4054;
        Thu, 10 Sep 2020 12:52:00 +0000 (GMT)
Received: from [9.145.94.16] (unknown [9.145.94.16])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Sep 2020 12:52:00 +0000 (GMT)
Subject: Re: [PATCH -rc v1] gcov: Disable gcov build with GCC 10
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200904155808.4997-1-leon@kernel.org>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <6fac3754-f8db-85f5-bdb1-b4c8e7ccc046@linux.ibm.com>
Date:   Thu, 10 Sep 2020 14:52:01 +0200
MIME-Version: 1.0
In-Reply-To: <20200904155808.4997-1-leon@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_03:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009100115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.09.2020 17:58, Leon Romanovsky wrote:
> GCOV built with GCC 10 doesn't initialize n_function variable.
> This produces different kernel panics as was seen by Colin in
> Ubuntu [1] and me in FC 32 [2].
> 
> As a workaround, let's disable GCOV build for broken GCC 10 version.
> 
> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1891288
> [2] https://lore.kernel.org/lkml/20200827133932.3338519-1-leon@kernel.org
> Cc: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

The following patch should fix the problem with gcov and GCC 10.
I successfully tested it with kernel 5.9-rc4 on s390 using GCC 10.1.1
and also with GCC 9.1.1 to see that it didn't break support for previous
GCC versions. In both cases there were no kernel panics and gcov worked
fine.

Could you try this patch to see if it also fixes the problem in your
environment?

---8<---
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: [PATCH] gcov: add support for GCC 10.1

Using gcov to collect coverage data for kernels compiled with GCC 10.1
causes random malfunctions and kernel crashes. This is the result of a
changed GCOV_COUNTERS value in GCC 10.1 that causes a mismatch between
the layout of the gcov_info structure created by GCC profiling code and
the related structure used by the kernel.

Fix this by updating the in-kernel GCOV_COUNTERS value. Also re-enable
config GCOV_KERNEL for use with GCC 10.

Reported-by: Colin Ian King <colin.king@canonical.com>
Reported-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 kernel/gcov/Kconfig   | 1 -
 kernel/gcov/gcc_4_7.c | 4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index bb4b680e8455..3110c77230c7 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -4,7 +4,6 @@ menu "GCOV-based kernel profiling"
 config GCOV_KERNEL
 	bool "Enable gcov-based kernel profiling"
 	depends on DEBUG_FS
-	depends on !CC_IS_GCC || GCC_VERSION < 100000
 	select CONSTRUCTORS if !UML
 	default n
 	help
diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
index 908fdf5098c3..53c67c87f141 100644
--- a/kernel/gcov/gcc_4_7.c
+++ b/kernel/gcov/gcc_4_7.c
@@ -19,7 +19,9 @@
 #include <linux/vmalloc.h>
 #include "gcov.h"

-#if (__GNUC__ >= 7)
+#if (__GNUC__ >= 10)
+#define GCOV_COUNTERS			8
+#elif (__GNUC__ >= 7)
 #define GCOV_COUNTERS			9
 #elif (__GNUC__ > 5) || (__GNUC__ == 5 && __GNUC_MINOR__ >= 1)
 #define GCOV_COUNTERS			10
-- 
2.21.0

