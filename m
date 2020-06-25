Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7DCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E01CB2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404482AbgFYMEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:04:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17036 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404222AbgFYMEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 08:04:14 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05PC2gFG013675;
        Thu, 25 Jun 2020 08:04:12 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31uwynq7y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 08:04:11 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PC1IFS000901;
        Thu, 25 Jun 2020 12:03:32 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 31uusg0upc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 12:03:32 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05PC2AMc64160052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 12:02:10 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4ACA1A4051;
        Thu, 25 Jun 2020 12:03:29 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09C3EA4053;
        Thu, 25 Jun 2020 12:03:29 +0000 (GMT)
Received: from osiris (unknown [9.171.78.96])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 25 Jun 2020 12:03:28 +0000 (GMT)
Date:   Thu, 25 Jun 2020 14:03:27 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.8-rc3
Message-ID: <20200625120327.GA7638@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-25_05:2020-06-25,2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=587
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 cotscore=-2147483648 mlxscore=0 clxscore=1011 lowpriorityscore=0
 suspectscore=2 phishscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006250078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull s390 updates for 5.8-rc3

Thanks,
Heiko

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.8-3

for you to fetch changes up to 827c4913923e0b441ba07ba4cc41e01181102303:

  s390/debug: avoid kernel warning on too large number of pages (2020-06-23 14:05:55 +0200)

----------------------------------------------------------------
s390 fixes for 5.8-rc3

- Fix kernel crash on system call single stepping.

- Make sure early program check handler is executed with DAT on to
  avoid an endless program check loop.

- Add __GFP_NOWARN flag to debug feature to avoid user triggerable
  allocation failure messages.

----------------------------------------------------------------
Christian Borntraeger (1):
      s390/debug: avoid kernel warning on too large number of pages

Sven Schnelle (1):
      s390: fix system call single stepping

Vasily Gorbik (1):
      s390/kasan: fix early pgm check handler execution

 arch/s390/kernel/debug.c | 3 ++-
 arch/s390/kernel/early.c | 2 ++
 arch/s390/kernel/entry.S | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 636446003a06..263075a1af36 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -198,9 +198,10 @@ static debug_entry_t ***debug_areas_alloc(int pages_per_area, int nr_areas)
 	if (!areas)
 		goto fail_malloc_areas;
 	for (i = 0; i < nr_areas; i++) {
+		/* GFP_NOWARN to avoid user triggerable WARN, we handle fails */
 		areas[i] = kmalloc_array(pages_per_area,
 					 sizeof(debug_entry_t *),
-					 GFP_KERNEL);
+					 GFP_KERNEL | __GFP_NOWARN);
 		if (!areas[i])
 			goto fail_malloc_areas2;
 		for (j = 0; j < pages_per_area; j++) {
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index cd241ee66eff..078277231858 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -170,6 +170,8 @@ static noinline __init void setup_lowcore_early(void)
 	psw_t psw;
 
 	psw.mask = PSW_MASK_BASE | PSW_DEFAULT_KEY | PSW_MASK_EA | PSW_MASK_BA;
+	if (IS_ENABLED(CONFIG_KASAN))
+		psw.mask |= PSW_MASK_DAT;
 	psw.addr = (unsigned long) s390_base_ext_handler;
 	S390_lowcore.external_new_psw = psw;
 	psw.addr = (unsigned long) s390_base_pgm_handler;
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 496f74d98473..969b35b177dd 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -378,9 +378,9 @@ ENTRY(system_call)
 	stmg	%r8,%r15,__LC_SAVE_AREA_SYNC
 	BPOFF
 	lg	%r12,__LC_CURRENT
-	lghi	%r13,__TASK_thread
 	lghi	%r14,_PIF_SYSCALL
 .Lsysc_per:
+	lghi	%r13,__TASK_thread
 	lg	%r15,__LC_KERNEL_STACK
 	la	%r11,STACK_FRAME_OVERHEAD(%r15)	# pointer to pt_regs
 	UPDATE_VTIME %r8,%r9,__LC_SYNC_ENTER_TIMER
