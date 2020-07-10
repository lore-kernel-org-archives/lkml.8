Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD5DC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 072A1207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgGJNrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:47:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726840AbgGJNrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:47:48 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06ADW2SU122001;
        Fri, 10 Jul 2020 09:47:47 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326bpkmua6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 09:47:47 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06ADZRr4022647;
        Fri, 10 Jul 2020 13:47:45 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 326bch8nb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 13:47:45 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06ADlgcP65732700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 13:47:42 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82015AE04D;
        Fri, 10 Jul 2020 13:47:42 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B2B6AE056;
        Fri, 10 Jul 2020 13:47:42 +0000 (GMT)
Received: from osiris (unknown [9.171.65.223])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 10 Jul 2020 13:47:42 +0000 (GMT)
Date:   Fri, 10 Jul 2020 15:47:40 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] more s390 updates for 5.8-rc5
Message-ID: <20200710134740.GA14845@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_06:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 suspectscore=7 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007100093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull more small s390 updates for 5.8-rc5.

This request is mainly due to the fact that Gerald Schaefer's and also
my old email addresses currently do not work any longer. Therefore we
decided to switch to new email addresses and reflect that in the
MAINTAINERS file.

Thanks,
Heiko

The following changes since commit dcb7fd82c75ee2d6e6f9d8cc71c52519ed52e258:

  Linux 5.8-rc4 (2020-07-05 16:20:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.8-5

for you to fetch changes up to dd9ce2d6eeaebbdd342cbe095b7a195d569f18d3:

  MAINTAINERS: update email address for Gerald Schaefer (2020-07-10 15:06:49 +0200)

----------------------------------------------------------------
- Update email addresses in MAINTAINERS file and add .mailmap entries
  for Gerald Schaefer and Heiko Carstens.

- Fix huge pte soft dirty copying.

----------------------------------------------------------------
Gerald Schaefer (1):
      MAINTAINERS: update email address for Gerald Schaefer

Heiko Carstens (1):
      MAINTAINERS: update email address for Heiko Carstens

Janosch Frank (1):
      s390/mm: fix huge pte soft dirty copying

 .mailmap                   | 5 +++++
 MAINTAINERS                | 8 ++++----
 arch/s390/mm/hugetlbpage.c | 2 +-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/.mailmap b/.mailmap
index c69d9c734fb5..6da12dfd10dc 100644
--- a/.mailmap
+++ b/.mailmap
@@ -90,11 +90,16 @@ Frank Rowand <frowand.list@gmail.com> <frank.rowand@sonymobile.com>
 Frank Zago <fzago@systemfabricworks.com>
 Gao Xiang <xiang@kernel.org> <gaoxiang25@huawei.com>
 Gao Xiang <xiang@kernel.org> <hsiangkao@aol.com>
+Gerald Schaefer <gerald.schaefer@linux.ibm.com> <gerald.schaefer@de.ibm.com>
+Gerald Schaefer <gerald.schaefer@linux.ibm.com> <geraldsc@de.ibm.com>
+Gerald Schaefer <gerald.schaefer@linux.ibm.com> <geraldsc@linux.vnet.ibm.com>
 Greg Kroah-Hartman <greg@echidna.(none)>
 Greg Kroah-Hartman <gregkh@suse.de>
 Greg Kroah-Hartman <greg@kroah.com>
 Gregory CLEMENT <gregory.clement@bootlin.com> <gregory.clement@free-electrons.com>
 Hanjun Guo <guohanjun@huawei.com> <hanjun.guo@linaro.org>
+Heiko Carstens <hca@linux.ibm.com> <h.carstens@de.ibm.com>
+Heiko Carstens <hca@linux.ibm.com> <heiko.carstens@de.ibm.com>
 Henk Vergonet <Henk.Vergonet@gmail.com>
 Henrik Kretzschmar <henne@nachtwindheim.de>
 Henrik Rydberg <rydberg@bitmath.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 1d4aa7f942de..06f61751353c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3306,7 +3306,7 @@ X:	arch/riscv/net/bpf_jit_comp32.c
 
 BPF JIT for S390
 M:	Ilya Leoshkevich <iii@linux.ibm.com>
-M:	Heiko Carstens <heiko.carstens@de.ibm.com>
+M:	Heiko Carstens <hca@linux.ibm.com>
 M:	Vasily Gorbik <gor@linux.ibm.com>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
@@ -14831,7 +14831,7 @@ S:	Maintained
 F:	drivers/video/fbdev/savage/
 
 S390
-M:	Heiko Carstens <heiko.carstens@de.ibm.com>
+M:	Heiko Carstens <hca@linux.ibm.com>
 M:	Vasily Gorbik <gor@linux.ibm.com>
 M:	Christian Borntraeger <borntraeger@de.ibm.com>
 L:	linux-s390@vger.kernel.org
@@ -14862,7 +14862,7 @@ F:	drivers/s390/block/dasd*
 F:	include/linux/dasd_mod.h
 
 S390 IOMMU (PCI)
-M:	Gerald Schaefer <gerald.schaefer@de.ibm.com>
+M:	Gerald Schaefer <gerald.schaefer@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
 W:	http://www.ibm.com/developerworks/linux/linux390/
@@ -14890,7 +14890,7 @@ F:	drivers/s390/net/
 
 S390 PCI SUBSYSTEM
 M:	Niklas Schnelle <schnelle@linux.ibm.com>
-M:	Gerald Schaefer <gerald.schaefer@de.ibm.com>
+M:	Gerald Schaefer <gerald.schaefer@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
 W:	http://www.ibm.com/developerworks/linux/linux390/
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index 82df06d720e8..3b5a4d25ca9b 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -117,7 +117,7 @@ static inline pte_t __rste_to_pte(unsigned long rste)
 					     _PAGE_YOUNG);
 #ifdef CONFIG_MEM_SOFT_DIRTY
 		pte_val(pte) |= move_set_bit(rste, _SEGMENT_ENTRY_SOFT_DIRTY,
-					     _PAGE_DIRTY);
+					     _PAGE_SOFT_DIRTY);
 #endif
 		pte_val(pte) |= move_set_bit(rste, _SEGMENT_ENTRY_NOEXEC,
 					     _PAGE_NOEXEC);
