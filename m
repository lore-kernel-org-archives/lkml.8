Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C036C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 00:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6211A214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 00:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d1bUy29c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388564AbgCEA1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 19:27:46 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33646 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388468AbgCEA1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 19:27:45 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0250NVsI111069;
        Thu, 5 Mar 2020 00:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=J0cB+5uaIKU59IltR6LnNDAssuAfjcBm0kwfXlCbFlE=;
 b=d1bUy29c3itgpVq08n4CkzgUcO8B0y2HjmCSDJYebHNo2rvmNrm1dJHuv39nycYU7skw
 Wi1cmFotYKfPFGHwj/uRrgPmzlnFpWlXQBotYUjT7ALUU0Y247Wv070Cazfmh1MCAFzR
 GaN57ulOwsFMINBcWhOtDkCe33lcKz9BfmUljZkEDhnkHKOxf7WG79heqvX84dltethj
 S6h4rK/dA9wvaFTGNLZQmCGPQYHAA8visJf1SIp2y22w+4QRAC9+v8d/BR7JGAFYKO/L
 QSiWciwE11u6G4XUlOBam9YIDsHNjBZW2rmPXh4clA7S8zISPXou1o9pWzJFQFREHwg5 mw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2yghn3dk67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Mar 2020 00:27:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0250GY9T062838;
        Thu, 5 Mar 2020 00:27:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2yg1p8wer4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Mar 2020 00:27:33 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0250RVuE017682;
        Thu, 5 Mar 2020 00:27:31 GMT
Received: from monkey.oracle.com (/71.63.128.209) by default (Oracle Beehive
 Gateway v4.0) with ESMTP ; Wed, 04 Mar 2020 16:26:56 -0800
MIME-Version: 1.0
Message-ID: <20200305002650.160855-1-mike.kravetz@oracle.com>
Date:   Wed, 4 Mar 2020 16:26:48 -0800 (PST)
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>, Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 0/2] hugetlbfs: use i_mmap_rwsem for more synchronization
X-Mailer: git-send-email 2.24.1
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=487 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=522 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003050000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While discussing the issue with huge_pte_offset [1], I remembered that
there were more outstanding hugetlb races.  These issues are:

1) For shared pmds, huge PTE pointers returned by huge_pte_alloc can become
   invalid via a call to huge_pmd_unshare by another thread.
2) hugetlbfs page faults can race with truncation causing invalid global
   reserve counts and state.

A previous attempt was made to use i_mmap_rwsem in this manner as described
at [2].  However, those patches were reverted starting with [3] due to
locking issues.

To effectively use i_mmap_rwsem to address the above issues it needs to
be held (in read mode) during page fault processing.  However, during
fault processing we need to lock the page we will be adding.  Lock
ordering requires we take page lock before i_mmap_rwsem.  Waiting until
after taking the page lock is too late in the fault process for the
synchronization we want to do.

To address this lock ordering issue, the following patches change the
lock ordering for hugetlb pages.  This is not too invasive as hugetlbfs
processing is done separate from core mm in many places.  However, I
don't really like this idea.  Much ugliness is contained in the new
routine hugetlb_page_mapping_lock_write() of patch 1.

The only other way I can think of to address these issues is by catching
all the races.  After catching a race, cleanup, backout, retry ... etc,
as needed.  This can get really ugly, especially for huge page reservations.
At one time, I started writing some of the reservation backout code for
page faults and it got so ugly and complicated I went down the path of
adding synchronization to avoid the races.  Any other suggestions would
be welcome.

[1] https://lore.kernel.org/linux-mm/1582342427-230392-1-git-send-email-longpeng2@huawei.com/
[2] https://lore.kernel.org/linux-mm/20181222223013.22193-1-mike.kravetz@oracle.com/
[3] https://lore.kernel.org/linux-mm/20190103235452.29335-1-mike.kravetz@oracle.com

Mike Kravetz (2):
  hugetlbfs: use i_mmap_rwsem for more pmd sharing synchronization
  hugetlbfs: Use i_mmap_rwsem to address page fault/truncate race

 fs/hugetlbfs/inode.c    |  34 +++++---
 include/linux/fs.h      |   5 ++
 include/linux/hugetlb.h |   8 ++
 mm/hugetlb.c            | 175 +++++++++++++++++++++++++++++++++++-----
 mm/memory-failure.c     |  29 ++++++-
 mm/migrate.c            |  24 +++++-
 mm/rmap.c               |  17 +++-
 mm/userfaultfd.c        |  11 ++-
 8 files changed, 264 insertions(+), 39 deletions(-)

-- 
2.24.1

