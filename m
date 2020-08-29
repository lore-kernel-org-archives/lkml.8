Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1247C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8433A208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fAliKrCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgH2Kzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 06:55:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41602 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728015AbgH2Kv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 06:51:28 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07TAVeL8010478;
        Sat, 29 Aug 2020 06:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=sxYFtV5EAeFme9d2OdOx+kLoXL58n3m1iHdGRZ66dVA=;
 b=fAliKrCi6Yn0TFbiBw3a4+F8QIhMdeoNS7f7DQPZh2Tbl4gFapqSQ0MyvoFpokIFsaRK
 lFICVrre5T2GtFVMjCfs+Pg+iKVIGvce3bgb+2M+/c0k98t/ZV422faj+u0a4tS4+4AS
 90UCtonb20x7m3YB4zkeP500dYhaQ1g0cUXJh6bYw438rj+s6SDj9uiOpgZDE3hdEXDS
 ygXS6sTVXfpZ+2AfrhmwpA66NoFI7eg2cv/xBgUidjuzLpa5Uyc94XIbLVkvnfUoEoyr
 kLz5QFs3EtHWASbYaBUqxppVdxwqgRFHSnP76j/mcE+yt7Ab05PnwISxtpaCdZEvQIqE Lw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 337jwdtjbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Aug 2020 06:51:21 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07TAlMGx028014;
        Sat, 29 Aug 2020 10:51:20 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 337en80976-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Aug 2020 10:51:20 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07TApHCW20382116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Aug 2020 10:51:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B1E6A4060;
        Sat, 29 Aug 2020 10:51:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B82F9A405F;
        Sat, 29 Aug 2020 10:51:16 +0000 (GMT)
Received: from localhost (unknown [9.145.56.232])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 29 Aug 2020 10:51:16 +0000 (GMT)
Date:   Sat, 29 Aug 2020 12:51:15 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.9-rc3
Message-ID: <your-ad-here.call-01598698275-ext-0854@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-29_05:2020-08-28,2020-08-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=2 priorityscore=1501 phishscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008290080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.9-rc3.

Thank you,
Vasily

The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-4

for you to fetch changes up to bffc2f7aa96343f91931272d7a8a2d8d925e1ab2:

  s390/vmem: fix vmem_add_range for 4-level paging (2020-08-26 18:07:05 +0200)

----------------------------------------------------------------
s390 fixes for 5.9-rc3

- Disable preemption trace in percpu macros since the lockdep code itself
  uses percpu variables now and it causes recursions.

- Fix kernel space 4-level paging broken by recent vmem rework.

----------------------------------------------------------------
Sven Schnelle (1):
      s390: don't trace preemption in percpu macros

Vasily Gorbik (1):
      s390/vmem: fix vmem_add_range for 4-level paging

 arch/s390/include/asm/percpu.h | 28 ++++++++++++++--------------
 arch/s390/mm/vmem.c            |  1 +
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 50b4ce8cddfd..918f0ba4f4d2 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -29,7 +29,7 @@
 	typedef typeof(pcp) pcp_op_T__;					\
 	pcp_op_T__ old__, new__, prev__;				\
 	pcp_op_T__ *ptr__;						\
-	preempt_disable();						\
+	preempt_disable_notrace();					\
 	ptr__ = raw_cpu_ptr(&(pcp));					\
 	prev__ = *ptr__;						\
 	do {								\
@@ -37,7 +37,7 @@
 		new__ = old__ op (val);					\
 		prev__ = cmpxchg(ptr__, old__, new__);			\
 	} while (prev__ != old__);					\
-	preempt_enable();						\
+	preempt_enable_notrace();					\
 	new__;								\
 })
 
@@ -68,7 +68,7 @@
 	typedef typeof(pcp) pcp_op_T__; 				\
 	pcp_op_T__ val__ = (val);					\
 	pcp_op_T__ old__, *ptr__;					\
-	preempt_disable();						\
+	preempt_disable_notrace();					\
 	ptr__ = raw_cpu_ptr(&(pcp)); 				\
 	if (__builtin_constant_p(val__) &&				\
 	    ((szcast)val__ > -129) && ((szcast)val__ < 128)) {		\
@@ -84,7 +84,7 @@
 			: [val__] "d" (val__)				\
 			: "cc");					\
 	}								\
-	preempt_enable();						\
+	preempt_enable_notrace();					\
 }
 
 #define this_cpu_add_4(pcp, val) arch_this_cpu_add(pcp, val, "laa", "asi", int)
@@ -95,14 +95,14 @@
 	typedef typeof(pcp) pcp_op_T__; 				\
 	pcp_op_T__ val__ = (val);					\
 	pcp_op_T__ old__, *ptr__;					\
-	preempt_disable();						\
+	preempt_disable_notrace();					\
 	ptr__ = raw_cpu_ptr(&(pcp));	 				\
 	asm volatile(							\
 		op "    %[old__],%[val__],%[ptr__]\n"			\
 		: [old__] "=d" (old__), [ptr__] "+Q" (*ptr__)		\
 		: [val__] "d" (val__)					\
 		: "cc");						\
-	preempt_enable();						\
+	preempt_enable_notrace();						\
 	old__ + val__;							\
 })
 
@@ -114,14 +114,14 @@
 	typedef typeof(pcp) pcp_op_T__; 				\
 	pcp_op_T__ val__ = (val);					\
 	pcp_op_T__ old__, *ptr__;					\
-	preempt_disable();						\
+	preempt_disable_notrace();					\
 	ptr__ = raw_cpu_ptr(&(pcp));	 				\
 	asm volatile(							\
 		op "    %[old__],%[val__],%[ptr__]\n"			\
 		: [old__] "=d" (old__), [ptr__] "+Q" (*ptr__)		\
 		: [val__] "d" (val__)					\
 		: "cc");						\
-	preempt_enable();						\
+	preempt_enable_notrace();					\
 }
 
 #define this_cpu_and_4(pcp, val)	arch_this_cpu_to_op(pcp, val, "lan")
@@ -136,10 +136,10 @@
 	typedef typeof(pcp) pcp_op_T__;					\
 	pcp_op_T__ ret__;						\
 	pcp_op_T__ *ptr__;						\
-	preempt_disable();						\
+	preempt_disable_notrace();					\
 	ptr__ = raw_cpu_ptr(&(pcp));					\
 	ret__ = cmpxchg(ptr__, oval, nval);				\
-	preempt_enable();						\
+	preempt_enable_notrace();					\
 	ret__;								\
 })
 
@@ -152,10 +152,10 @@
 ({									\
 	typeof(pcp) *ptr__;						\
 	typeof(pcp) ret__;						\
-	preempt_disable();						\
+	preempt_disable_notrace();					\
 	ptr__ = raw_cpu_ptr(&(pcp));					\
 	ret__ = xchg(ptr__, nval);					\
-	preempt_enable();						\
+	preempt_enable_notrace();					\
 	ret__;								\
 })
 
@@ -171,11 +171,11 @@
 	typeof(pcp1) *p1__;						\
 	typeof(pcp2) *p2__;						\
 	int ret__;							\
-	preempt_disable();						\
+	preempt_disable_notrace();					\
 	p1__ = raw_cpu_ptr(&(pcp1));					\
 	p2__ = raw_cpu_ptr(&(pcp2));					\
 	ret__ = __cmpxchg_double(p1__, p2__, o1__, o2__, n1__, n2__);	\
-	preempt_enable();						\
+	preempt_enable_notrace();					\
 	ret__;								\
 })
 
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 1aed1a4dfc2d..eddf71c22875 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -402,6 +402,7 @@ static int modify_p4d_table(pgd_t *pgd, unsigned long addr, unsigned long end,
 			pud = vmem_crst_alloc(_REGION3_ENTRY_EMPTY);
 			if (!pud)
 				goto out;
+			p4d_populate(&init_mm, p4d, pud);
 		}
 		ret = modify_pud_table(p4d, addr, next, add, direct);
 		if (ret)
