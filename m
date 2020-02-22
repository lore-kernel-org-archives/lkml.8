Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E0DC35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 13:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB48206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 13:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgBVNEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 08:04:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727046AbgBVNEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 08:04:10 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01MCwwnp047777
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 08:04:09 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yb1b5d8mb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 08:04:08 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Sat, 22 Feb 2020 13:04:06 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 22 Feb 2020 13:04:04 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01MD42oP61341926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Feb 2020 13:04:02 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AD2642042;
        Sat, 22 Feb 2020 13:04:02 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A73B4203F;
        Sat, 22 Feb 2020 13:04:02 +0000 (GMT)
Received: from localhost (unknown [9.145.69.200])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 22 Feb 2020 13:04:02 +0000 (GMT)
Date:   Sat, 22 Feb 2020 14:04:00 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.6-rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
x-cbid: 20022213-0008-0000-0000-0000035569BE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022213-0009-0000-0000-00004A767E6A
Message-Id: <your-ad-here.call-01582376640-ext-7410@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-22_03:2020-02-21,2020-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 phishscore=0 mlxlogscore=869 lowpriorityscore=0 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002220115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.6-rc3. One of the changes touches
kernel/sysctl.c which simply removes s390 specific dead code.

Thank you,
Vasily

The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:

  Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.6-4

for you to fetch changes up to 2db01da8d25f0420c411e788a9e1ba39269ae37b:

  s390/qdio: fill SBALEs with absolute addresses (2020-02-19 17:26:32 +0100)

----------------------------------------------------------------
s390 updates for 5.6-rc3

- Remove ieee_emulation_warnings sysctl which is a dead code.

- Avoid triggering rebuild of the kernel during make install.

- Enable protected virtualization guest support in default configs.

- Fix cio_ignore seq_file .next function to increase position index. And
  use kobj_to_dev instead of container_of in cio code.

- Fix storage block address lists to contain absolute addresses in
  qdio code.

- Few clang warnings and spelling fixes.

----------------------------------------------------------------
Christian Borntraeger (1):
      s390/defconfig: enable CONFIG_PROTECTED_VIRTUALIZATION_GUEST

Geert Uytterhoeven (1):
      s390/pkey/zcrypt: spelling s/crytp/crypt/

Julian Wiedmann (2):
      s390/qdio: fill SL with absolute addresses
      s390/qdio: fill SBALEs with absolute addresses

Masahiro Yamada (1):
      s390: make 'install' not depend on vmlinux

Nathan Chancellor (2):
      s390/mm: Explicitly compare PAGE_DEFAULT_KEY against zero in storage_key_init_range
      s390/kaslr: Fix casts in get_random

Stephen Kitt (1):
      s390: remove obsolete ieee_emulation_warnings

Vasily Averin (1):
      s390/cio: cio_ignore_proc_seq_next should increase position index

chenqiwu (1):
      s390/cio: use kobj_to_dev() API

 arch/s390/Makefile                    |  2 +-
 arch/s390/boot/Makefile               |  2 +-
 arch/s390/boot/kaslr.c                |  2 +-
 arch/s390/configs/debug_defconfig     | 28 ++++++++++-----------
 arch/s390/configs/defconfig           | 11 ++++-----
 arch/s390/include/asm/page.h          |  2 +-
 arch/s390/include/asm/processor.h     |  1 -
 arch/s390/include/asm/qdio.h          |  6 ++---
 drivers/s390/cio/blacklist.c          |  5 ++--
 drivers/s390/cio/chp.c                |  4 +--
 drivers/s390/cio/qdio_setup.c         |  3 ++-
 drivers/s390/crypto/zcrypt_ep11misc.c |  4 +--
 drivers/s390/net/qeth_core_main.c     | 46 +++++++++++++++++------------------
 drivers/s390/scsi/zfcp_fsf.c          |  2 +-
 drivers/s390/scsi/zfcp_qdio.c         |  6 ++---
 drivers/s390/scsi/zfcp_qdio.h         |  6 ++---
 kernel/sysctl.c                       |  9 -------
 17 files changed, 64 insertions(+), 75 deletions(-)

