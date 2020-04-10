Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3F2C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 10:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CF420673
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 10:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgDJKkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 06:40:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57606 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725913AbgDJKkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 06:40:45 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03AAZobH049638
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 06:40:44 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30920tds14-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 06:40:44 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Fri, 10 Apr 2020 11:40:21 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 10 Apr 2020 11:40:18 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03AAecj261014046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Apr 2020 10:40:38 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9673AA405B;
        Fri, 10 Apr 2020 10:40:38 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 444E4A4066;
        Fri, 10 Apr 2020 10:40:38 +0000 (GMT)
Received: from localhost (unknown [9.145.46.100])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 10 Apr 2020 10:40:38 +0000 (GMT)
Date:   Fri, 10 Apr 2020 12:40:36 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 5.7 merge window #2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
x-cbid: 20041010-0008-0000-0000-0000036E1BB8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041010-0009-0000-0000-00004A8FC112
Message-Id: <your-ad-here.call-01586515236-ext-7662@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-10_03:2020-04-09,2020-04-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 mlxlogscore=779 adultscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004100088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull the second round of s390 fixes and features for 5.7.

Thank you,
Vasily

The following changes since commit ad0bf4eb91c2f9b93479b679e5472094ddb76da8:

  Merge tag 's390-5.7-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2020-04-04 09:45:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux tags/s390-5.7-2

for you to fetch changes up to 2bc55eaeb88d30accfc1b6ac2708d4e4b81ca260:

  s390/cio: generate delayed uevent for vfio-ccw subchannels (2020-04-06 14:02:28 +0200)

----------------------------------------------------------------
s390 updates for the 5.7 merge window #2

- The rest of fallthrough; annotations conversion.

- Couple of fixes for ADD uevents in the common I/O layer.

- Minor refactoring of the queued direct I/O code.

----------------------------------------------------------------
Cornelia Huck (2):
      s390/cio: avoid duplicated 'ADD' uevents
      s390/cio: generate delayed uevent for vfio-ccw subchannels

Joe Perches (1):
      s390/mm: use fallthrough;

Julian Wiedmann (6):
      s390/qdio: cleanly split alloc and establish
      zfcp: inline zfcp_qdio_setup_init_data()
      s390/qdio: allow for non-contiguous SBAL array in init_data
      s390/qdio: remove cdev from init_data
      s390/qdio: inline shared_ind()
      s390/qdio: clear DSCI early for polling drivers

 arch/s390/include/asm/qdio.h      | 16 +++++-----
 arch/s390/mm/fault.c              |  2 --
 drivers/s390/cio/device.c         | 13 +++++---
 drivers/s390/cio/qdio.h           |  1 -
 drivers/s390/cio/qdio_debug.c     | 16 +---------
 drivers/s390/cio/qdio_debug.h     |  3 +-
 drivers/s390/cio/qdio_main.c      | 63 +++++++++++++++++++++++++------------
 drivers/s390/cio/qdio_setup.c     | 10 +++---
 drivers/s390/cio/qdio_thinint.c   | 28 ++---------------
 drivers/s390/cio/vfio_ccw_drv.c   |  5 +++
 drivers/s390/net/qeth_core.h      |  5 +--
 drivers/s390/net/qeth_core_main.c | 65 ++++++++-------------------------------
 drivers/s390/scsi/zfcp_qdio.c     | 51 +++++++++++++-----------------
 13 files changed, 110 insertions(+), 168 deletions(-)

