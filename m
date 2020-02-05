Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FC3C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D73B20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgBEQLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 11:11:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726534AbgBEQLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:11:44 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 015G6xoV036194
        for <linux-kernel@vger.kernel.org>; Wed, 5 Feb 2020 11:11:43 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhpxxmb8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 11:11:43 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Wed, 5 Feb 2020 16:11:40 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Feb 2020 16:11:38 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 015GBbd456819952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Feb 2020 16:11:37 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CF7F11C04C;
        Wed,  5 Feb 2020 16:11:37 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5D0911C052;
        Wed,  5 Feb 2020 16:11:36 +0000 (GMT)
Received: from localhost (unknown [9.152.212.204])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Feb 2020 16:11:36 +0000 (GMT)
Date:   Wed, 5 Feb 2020 17:11:35 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 5.6 merge window #2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
x-cbid: 20020516-0012-0000-0000-00000383F976
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020516-0013-0000-0000-000021C0645C
Message-Id: <your-ad-here.call-01580919095-ext-5211@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_04:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=2 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002050123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull the second round of s390 fixes and features for 5.6.

Thank you,
Vasily

The following changes since commit 740eaf7d4dd255789987a543b0203ca239b37087:

  Merge tag 's390-5.6-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2020-01-28 18:43:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux tags/s390-5.6-2

for you to fetch changes up to 55d0a513a0e202c68af2c8f4b1e923a345227bbb:

  s390/pkey/zcrypt: Support EP11 AES secure keys (2020-01-30 13:07:56 +0100)

----------------------------------------------------------------
s390 updates for the 5.6 merge window #2

- Add KPROBES_ON_FTRACE support.

- Add EP11 AES secure keys support.

- PAES rework and prerequisites for paes-s390 ciphers selftests.

- Fix page table upgrade for hugetlbfs.

----------------------------------------------------------------
Gerald Schaefer (1):
      s390/mm: fix dynamic pagetable upgrade for hugetlbfs

Harald Freudenberger (8):
      s390/crypto: Rework on paes implementation
      s390/pkey: Add support for key blob with clear key value
      s390/crypto: enable clear key values for paes ciphers
      s390/zcrypt: enable card/domain autoselect on ep11 cprbs
      s390/zcrypt: ep11 structs rework, export zcrypt_send_ep11_cprb
      s390/zcrypt: add new low level ep11 functions support file
      s390/zcrypt: extend EP11 card and queue sysfs attributes
      s390/pkey/zcrypt: Support EP11 AES secure keys

Sven Schnelle (1):
      s390: support KPROBES_ON_FTRACE

 .../debug/kprobes-on-ftrace/arch-support.txt       |    2 +-
 arch/s390/Kconfig                                  |    1 +
 arch/s390/crypto/paes_s390.c                       |  230 +++-
 arch/s390/include/asm/kprobes.h                    |    1 -
 arch/s390/include/asm/page.h                       |    2 +
 arch/s390/include/uapi/asm/pkey.h                  |   69 +-
 arch/s390/include/uapi/asm/zcrypt.h                |   32 +-
 arch/s390/kernel/ftrace.c                          |   80 +-
 arch/s390/kernel/kprobes.c                         |   61 +-
 arch/s390/kernel/mcount.S                          |    6 +
 arch/s390/mm/hugetlbpage.c                         |  100 +-
 drivers/s390/crypto/Makefile                       |    3 +-
 drivers/s390/crypto/pkey_api.c                     |  470 ++++++-
 drivers/s390/crypto/zcrypt_api.c                   |   27 +-
 drivers/s390/crypto/zcrypt_api.h                   |    1 +
 drivers/s390/crypto/zcrypt_ccamisc.h               |    1 +
 drivers/s390/crypto/zcrypt_cex4.c                  |  273 ++++-
 drivers/s390/crypto/zcrypt_ep11misc.c              | 1293 ++++++++++++++++++++
 drivers/s390/crypto/zcrypt_ep11misc.h              |  124 ++
 19 files changed, 2494 insertions(+), 282 deletions(-)
 create mode 100644 drivers/s390/crypto/zcrypt_ep11misc.c
 create mode 100644 drivers/s390/crypto/zcrypt_ep11misc.h

