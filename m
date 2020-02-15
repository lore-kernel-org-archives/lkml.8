Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C344EC2BA83
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 12:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF362073A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 12:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgBOM1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 07:27:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725937AbgBOM1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 07:27:38 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01FCNZ3V090181
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2020 07:27:37 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6dp6c8ej-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2020 07:27:37 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Sat, 15 Feb 2020 12:27:33 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 15 Feb 2020 12:27:30 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01FCRSNA49676364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Feb 2020 12:27:28 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4B1BA4040;
        Sat, 15 Feb 2020 12:27:28 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AC7DA404D;
        Sat, 15 Feb 2020 12:27:28 +0000 (GMT)
Received: from localhost (unknown [9.145.76.102])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 15 Feb 2020 12:27:28 +0000 (GMT)
Date:   Sat, 15 Feb 2020 13:27:27 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.6-rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
x-cbid: 20021512-0028-0000-0000-000003DB3701
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021512-0029-0000-0000-000024A0389D
Message-Id: <your-ad-here.call-01581769647-ext-0154@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-15_03:2020-02-14,2020-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002150110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.6-rc2. One of the changes touches
crypto/testmgr.c which has been acked-by Herbert Xu.

Thank you,
Vasily

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.6-3

for you to fetch changes up to c7ff8573ad21dcdcbcffd66fbfca3b53cd67d2b1:

  crypto/testmgr: enable selftests for paes-s390 ciphers (2020-02-13 17:53:24 +0100)

----------------------------------------------------------------
s390 updates for 5.6-rc2

- Enable paes-s390 cipher selftests in testmgr (acked-by Herbert Xu).

- Fix protected key length update in PKEY_SEC2PROTK ioctl and increase
  card/queue requests counter to 64-bit in crypto code.

- Fix clang warning in get_tod_clock.

- Fix ultravisor info length extensions handling.

- Fix style of SPDX License Identifier in vfio-ccw.

- Avoid unnecessary GFP_ATOMIC and simplify ACK tracking in qdio.

----------------------------------------------------------------
Christian Borntraeger (1):
      s390/uv: Fix handling of length extensions

Harald Freudenberger (3):
      s390/pkey: fix missing length of protected key on return
      s390/zcrypt: fix card and queue total counter wrap
      crypto/testmgr: enable selftests for paes-s390 ciphers

Julian Wiedmann (2):
      s390/qdio: simplify ACK tracking
      s390/qdio: don't allocate *aob array with GFP_ATOMIC

Nathan Chancellor (1):
      s390/time: Fix clk type in get_tod_clock

Nishad Kamdar (1):
      vfio-ccw: Use the correct style for SPDX License Identifier

Vasily Gorbik (1):
      Merge tag 'vfio-ccw-20200206' of https://git.kernel.org/.../kvms390/vfio-ccw into HEAD

 arch/s390/boot/uv.c               |  3 ++-
 arch/s390/include/asm/timex.h     |  2 +-
 crypto/testmgr.c                  | 36 ++++++++++++++++++++++++++++++++++++
 drivers/s390/cio/qdio.h           |  4 +---
 drivers/s390/cio/qdio_debug.c     |  5 ++---
 drivers/s390/cio/qdio_main.c      | 29 +++++++++++------------------
 drivers/s390/cio/qdio_setup.c     |  2 +-
 drivers/s390/cio/vfio_ccw_trace.h |  4 ++--
 drivers/s390/crypto/ap_bus.h      |  4 ++--
 drivers/s390/crypto/ap_card.c     |  8 ++++----
 drivers/s390/crypto/ap_queue.c    |  6 +++---
 drivers/s390/crypto/pkey_api.c    |  2 +-
 drivers/s390/crypto/zcrypt_api.c  | 16 +++++++++-------
 13 files changed, 75 insertions(+), 46 deletions(-)

