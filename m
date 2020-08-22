Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C65C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 12:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E7EA207DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 12:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JL7FGHTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgHVMhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 08:37:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727113AbgHVMht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 08:37:49 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07MCW8FP099834;
        Sat, 22 Aug 2020 08:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=Kf+oJKJtZRP6iXNUw0jIW+o78x1YYqzPLArTZ2cRwUg=;
 b=JL7FGHTf+MOXbTa/Q3M9jh1DLdlAwbpGQB2wu2zJe2BSuraQxepBUj/n0GNzqCs7ZXma
 KsGJYMtw/v3EqFQ7flA5sEKvUA+EZRXt68EJZosJFkXpo1i4bUjxQjSwAZbp+VXfQjCI
 nq/uzxp8Ou5TWSLfdm9WpAC6FSNT2baOCmGTtFfK+ZPa8IexAEIaI1NoM1BtTnF5j3dx
 uI3m1+xp+0YoB/kOI4KVK0zxGZvDWzt0PrEdyMKPPNKGVk8fXx1higVK3DGpuOuchhrt
 f7nmIgGT1gGOvejBzf7RA7Ov/9Xmf2xKKkIoGGEwNHwlmesqIvoMYRqesMW5+lM8fFaI Iw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3330yg2f84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Aug 2020 08:37:47 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07MCbE4s029382;
        Sat, 22 Aug 2020 12:37:45 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 332ujjr7s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Aug 2020 12:37:45 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07MCbgAK27853302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Aug 2020 12:37:42 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 506144C04E;
        Sat, 22 Aug 2020 12:37:42 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E71494C040;
        Sat, 22 Aug 2020 12:37:41 +0000 (GMT)
Received: from localhost (unknown [9.145.29.186])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 22 Aug 2020 12:37:41 +0000 (GMT)
Date:   Sat, 22 Aug 2020 14:37:40 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.9-rc2
Message-ID: <your-ad-here.call-01598099860-ext-4027@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-22_07:2020-08-21,2020-08-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=2 adultscore=0 clxscore=1011 impostorscore=0 phishscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 mlxlogscore=600 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008220131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.9-rc2.

Thank you,
Vasily

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-3

for you to fetch changes up to b97bf44f99155e57088e16974afb1f2d7b5287aa:

  s390/pci: fix PF/VF linking on hot plug (2020-08-17 13:17:34 +0200)

----------------------------------------------------------------
s390 fixes for 5.9-rc2

- Couple of fixes for storage key handling relevant for debugging.

- Add cond_resched into potentially slow subchannels scanning loop.

- Fixes for PF/VF linking and to ignore stale PCI configuration request
  events.

----------------------------------------------------------------
Heiko Carstens (2):
      s390/runtime_instrumentation: fix storage key handling
      s390/ptrace: fix storage key handling

Niklas Schnelle (4):
      s390/pci: ignore stale configuration request event
      s390/pci: fix zpci_bus_link_virtfn()
      s390/pci: re-introduce zpci_remove_device()
      s390/pci: fix PF/VF linking on hot plug

Vineeth Vijayan (1):
      s390/cio: add cond_resched() in the slow_eval_known_fn() loop

 arch/s390/kernel/ptrace.c          |  7 +++--
 arch/s390/kernel/runtime_instr.c   |  2 +-
 arch/s390/pci/pci.c                | 22 +++++++++++-----
 arch/s390/pci/pci_bus.c            | 52 ++++++++++++++++++++++----------------
 arch/s390/pci/pci_bus.h            | 13 ++++++++++
 arch/s390/pci/pci_event.c          |  7 +++--
 drivers/pci/hotplug/s390_pci_hpc.c | 12 ++++-----
 drivers/s390/cio/css.c             |  5 ++++
 8 files changed, 79 insertions(+), 41 deletions(-)
