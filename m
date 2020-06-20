Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF25FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 15:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC4F23D4E
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 15:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgFTPWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 11:22:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725777AbgFTPWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 11:22:05 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05KF3OLH082737;
        Sat, 20 Jun 2020 11:22:03 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31seke6pvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Jun 2020 11:22:03 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05KFKuhL013165;
        Sat, 20 Jun 2020 15:22:01 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 31sa38099s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Jun 2020 15:22:01 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05KFLwHR46923800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Jun 2020 15:21:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B46124C044;
        Sat, 20 Jun 2020 15:21:58 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 567D54C040;
        Sat, 20 Jun 2020 15:21:58 +0000 (GMT)
Received: from localhost (unknown [9.145.157.233])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 20 Jun 2020 15:21:58 +0000 (GMT)
Date:   Sat, 20 Jun 2020 17:21:56 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.8-rc2
Message-ID: <your-ad-here.call-01592666516-ext-8102@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-20_08:2020-06-19,2020-06-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=2
 mlxscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006200113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.8-rc2.

Thank you,
Vasily

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.8-2

for you to fetch changes up to b3583fca5fb654af2cfc1c08259abb9728272538:

  s390: fix syscall_get_error for compat processes (2020-06-17 23:05:05 +0200)

----------------------------------------------------------------
s390 fixes for 5.8-rc2

- Few ptrace fixes mostly for strace and seccomp_bpf kernel tests
  findings.

- Cleanup unused pm callbacks in virtio ccw.

- Replace kmalloc + memset with kzalloc in crypto.

- Use $(LD) for vDSO linkage to make clang happy.

- Fix vDSO clock_getres() to preserve the same behaviour as
  posix_get_hrtimer_res().

- Fix workqueue cpumask warning when NUMA=n and nr_node_ids=2.

- Reduce SLSB writes during input processing, improve warnings and
  cleanup qdio_data usage in qdio.

- Few fixes to use scnprintf() instead of snprintf().

----------------------------------------------------------------
Chen Zhou (3):
      s390/crypto: use scnprintf() instead of snprintf()
      s390: use scnprintf() in sys_##_prefix##_##_name##_show
      s390/protvirt: use scnprintf() instead of snprintf()

Cornelia Huck (1):
      s390/virtio: remove unused pm callbacks

Dmitry V. Levin (1):
      s390: fix syscall_get_error for compat processes

Heiko Carstens (1):
      s390/numa: let NODES_SHIFT depend on NEED_MULTIPLE_NODES

Julian Wiedmann (4):
      s390/qdio: fine-tune SLSB update
      s390/qdio: reduce SLSB writes during Input Queue processing
      s390/qdio: clean up usage of qdio_data
      s390/qdio: warn about unexpected SLSB states

Nathan Chancellor (1):
      s390/vdso: Use $(LD) instead of $(CC) to link vDSO

Sven Schnelle (5):
      s390/seccomp: pass syscall arguments via seccomp_data
      s390/ptrace: return -ENOSYS when invalid syscall is supplied
      s390/ptrace: pass invalid syscall numbers to tracing
      s390/ptrace: fix setting syscall number
      selftests/seccomp: s390 shares the syscall and return value register

Vincenzo Frascino (1):
      s390/vdso: fix vDSO clock_getres()

Zou Wei (1):
      s390/zcrypt: use kzalloc

 arch/s390/Kconfig                             |   1 +
 arch/s390/crypto/prng.c                       |  14 ++--
 arch/s390/include/asm/syscall.h               |  12 ++-
 arch/s390/include/asm/vdso.h                  |   1 +
 arch/s390/kernel/asm-offsets.c                |   2 +-
 arch/s390/kernel/entry.S                      |   2 +-
 arch/s390/kernel/ipl.c                        |   2 +-
 arch/s390/kernel/ptrace.c                     |  83 +++++++++++++++++----
 arch/s390/kernel/time.c                       |   1 +
 arch/s390/kernel/uv.c                         |   8 +-
 arch/s390/kernel/vdso64/Makefile              |  10 +--
 arch/s390/kernel/vdso64/clock_getres.S        |  10 +--
 drivers/s390/cio/qdio.h                       |   7 +-
 drivers/s390/cio/qdio_debug.c                 |   4 +-
 drivers/s390/cio/qdio_main.c                  | 101 +++++++++++---------------
 drivers/s390/crypto/zcrypt_ep11misc.c         |   3 +-
 drivers/s390/virtio/virtio_ccw.c              |  26 -------
 tools/testing/selftests/seccomp/seccomp_bpf.c |   1 +
 18 files changed, 154 insertions(+), 134 deletions(-)
