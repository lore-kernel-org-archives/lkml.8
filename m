Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CC6C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34B62208C7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bNDjJdCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgIDUf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:35:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43224 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726791AbgIDUfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:35:25 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 084KXh1E103561;
        Fri, 4 Sep 2020 16:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=BVyZ2nAB3v5M7F/19fDZoBq2lGDP29RSzKi61iZ1s98=;
 b=bNDjJdCvxtrYnf0n8XkMlHiIg+ozl6VETISNXNqcl1mOgg0fhz+1W4ggX7CaSEUau5xG
 wIvrJtjf215wQrer5wscs5hBrqKM2ske7uakATAWsDNpEm6kGmSW5woxtRByWz+9Ar7m
 jXJUcDsKKZJbgf4HX1yU3r6fW4ccv4wVHC3tpjQnAJbsc+U8Fa8Pi5c2BhPU8Upr6//6
 Wzd8lsVfvHAd3Q4j7LDCuH7nevtez9vMtZZG5Ku1hSc4t6PDkIqVNz8IrA5saUZryAVC
 TCgxy3SmcWu8JamrviH4aaHvxL9KHd6KPbGXzI9AQ0hSiqmQRCwEuz9ivdQu+t655Rby tw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33bvgdra0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 16:35:22 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 084KWmLm029402;
        Fri, 4 Sep 2020 20:35:19 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 337en7medt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 20:35:19 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 084KZGRx39518520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Sep 2020 20:35:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C213AAE045;
        Fri,  4 Sep 2020 20:35:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 611B9AE053;
        Fri,  4 Sep 2020 20:35:16 +0000 (GMT)
Received: from localhost (unknown [9.145.72.143])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  4 Sep 2020 20:35:16 +0000 (GMT)
Date:   Fri, 4 Sep 2020 22:35:14 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.9-rc4
Message-ID: <your-ad-here.call-01599251714-ext-8456@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-04_15:2020-09-04,2020-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 suspectscore=2 spamscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.9-rc4.

Thank you,
Vasily

The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-5

for you to fetch changes up to 5c60ed283e1d87e161441bb273541a948ee96f6a:

  s390: update defconfigs (2020-09-02 13:17:05 +0200)

----------------------------------------------------------------
s390 fixes for 5.9-rc4

- Fix GENERIC_LOCKBREAK dependency on PREEMPTION in Kconfig broken
  because of a typo.

- Update defconfigs.

----------------------------------------------------------------
Eric Farman (1):
      s390: fix GENERIC_LOCKBREAK dependency typo in Kconfig

Heiko Carstens (1):
      s390: update defconfigs

 arch/s390/Kconfig                    | 2 +-
 arch/s390/configs/debug_defconfig    | 4 ++++
 arch/s390/configs/defconfig          | 3 +++
 arch/s390/configs/zfcpdump_defconfig | 1 +
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 3d86e12e8e3c..b29fcc66ec39 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -30,7 +30,7 @@ config GENERIC_BUG_RELATIVE_POINTERS
 	def_bool y
 
 config GENERIC_LOCKBREAK
-	def_bool y if PREEMPTTION
+	def_bool y if PREEMPTION
 
 config PGSTE
 	def_bool y if KVM
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 0cf9a82326a8..7228aabe9da6 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -626,6 +626,7 @@ CONFIG_NTFS_RW=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_TMPFS_INODE64=y
 CONFIG_HUGETLBFS=y
 CONFIG_CONFIGFS_FS=m
 CONFIG_ECRYPT_FS=m
@@ -807,6 +808,7 @@ CONFIG_DEBUG_NOTIFIERS=y
 CONFIG_BUG_ON_DATA_CORRUPTION=y
 CONFIG_DEBUG_CREDENTIALS=y
 CONFIG_RCU_TORTURE_TEST=m
+CONFIG_RCU_REF_SCALE_TEST=m
 CONFIG_RCU_CPU_STALL_TIMEOUT=300
 # CONFIG_RCU_TRACE is not set
 CONFIG_LATENCYTOP=y
@@ -818,6 +820,7 @@ CONFIG_PREEMPT_TRACER=y
 CONFIG_SCHED_TRACER=y
 CONFIG_FTRACE_SYSCALLS=y
 CONFIG_BLK_DEV_IO_TRACE=y
+CONFIG_BPF_KPROBE_OVERRIDE=y
 CONFIG_HIST_TRIGGERS=y
 CONFIG_S390_PTDUMP=y
 CONFIG_NOTIFIER_ERROR_INJECTION=m
@@ -829,6 +832,7 @@ CONFIG_FAIL_MAKE_REQUEST=y
 CONFIG_FAIL_IO_TIMEOUT=y
 CONFIG_FAIL_FUTEX=y
 CONFIG_FAULT_INJECTION_DEBUG_FS=y
+CONFIG_FAIL_FUNCTION=y
 CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
 CONFIG_LKDTM=m
 CONFIG_TEST_LIST_SORT=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 5df9759e8ff6..fab03b7a6932 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -617,6 +617,7 @@ CONFIG_NTFS_RW=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_TMPFS_INODE64=y
 CONFIG_HUGETLBFS=y
 CONFIG_CONFIGFS_FS=m
 CONFIG_ECRYPT_FS=m
@@ -763,6 +764,7 @@ CONFIG_PANIC_ON_OOPS=y
 CONFIG_TEST_LOCKUP=m
 CONFIG_BUG_ON_DATA_CORRUPTION=y
 CONFIG_RCU_TORTURE_TEST=m
+CONFIG_RCU_REF_SCALE_TEST=m
 CONFIG_RCU_CPU_STALL_TIMEOUT=60
 CONFIG_LATENCYTOP=y
 CONFIG_BOOTTIME_TRACING=y
@@ -771,6 +773,7 @@ CONFIG_STACK_TRACER=y
 CONFIG_SCHED_TRACER=y
 CONFIG_FTRACE_SYSCALLS=y
 CONFIG_BLK_DEV_IO_TRACE=y
+CONFIG_BPF_KPROBE_OVERRIDE=y
 CONFIG_HIST_TRIGGERS=y
 CONFIG_S390_PTDUMP=y
 CONFIG_LKDTM=m
diff --git a/arch/s390/configs/zfcpdump_defconfig b/arch/s390/configs/zfcpdump_defconfig
index 4091c50449cd..8f67c55625f9 100644
--- a/arch/s390/configs/zfcpdump_defconfig
+++ b/arch/s390/configs/zfcpdump_defconfig
@@ -74,5 +74,6 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_PANIC_ON_OOPS=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_RCU_CPU_STALL_TIMEOUT=60
+# CONFIG_RCU_TRACE is not set
 # CONFIG_FTRACE is not set
 # CONFIG_RUNTIME_TESTING_MENU is not set
