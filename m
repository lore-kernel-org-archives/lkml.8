Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA67C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E04020679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vqHl/Ae6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732628AbgCPU6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 16:58:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49342 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732591AbgCPU6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 16:58:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02GKrC6p132467;
        Mon, 16 Mar 2020 20:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=l3Njn0pKDKSPlwzoyxhch719HDQHMS55c8rsnHebCzA=;
 b=vqHl/Ae6I0EEecqgXXfxfZmAjUkKiHSCziPCdx8TvwjcnsQiVAxbBstlJ+Mn8j11IbF4
 E+R9FyEdbIjOxFbqpNZtHQsRpktaFS42awAU3C4phbMPzTw6cjTnwz+PnLFmkdK9r0lb
 R2AApgrPGxdr5VRW5NAJl/c77DL9DgExG0rEtM9NGEw9LGuwgUVK00+TEUoQmz0Ox+IW
 FCrYGQ2/IiTQseYy34Yhl9xJ9QjJIxGZVfJiRTi3yZctbTRginYNuu/Mc75xXYREFuiM
 kR+RQhMb1MIx2mmIyuc2+bmGG6B1X1esktHj7QETf7A+SKTJUnsgfoQqPCJfGWO20UNa xQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2yrq7ks8xu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Mar 2020 20:58:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02GKriGT136395;
        Mon, 16 Mar 2020 20:58:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2ys92aqbc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Mar 2020 20:58:04 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02GKw1Xx027835;
        Mon, 16 Mar 2020 20:58:01 GMT
Received: from monkey.oracle.com (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Mar 2020 13:58:01 -0700
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
Subject: [PATCH v2 0/2] hugetlbfs: use i_mmap_rwsem for more synchronization
Date:   Mon, 16 Mar 2020 13:57:54 -0700
Message-Id: <20200316205756.146666-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9562 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=585
 mlxscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003160087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9562 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=627 priorityscore=1501 clxscore=1015
 malwarescore=0 mlxscore=0 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003160087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2
- Fixed a hang that could be reproduced via a ltp test [4].
  Note that the issue was in one of the return paths of one of the
  callers of hugetlb_page_mapping_lock_write which left a huge page
  locked.  The routine hugetlb_page_mapping_lock_write was not modified
  in v2, and is still in need of review/comments.
- Cleaned up warnings produced on powerpc builds [5].

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
[4] https://lore.kernel.org/linux-mm/1584028670.7365.182.camel@lca.pw/
[5] https://lore.kernel.org/lkml/20200312183142.108df9ac@canb.auug.org.au/

Mike Kravetz (2):
  hugetlbfs: use i_mmap_rwsem for more pmd sharing synchronization
  hugetlbfs: Use i_mmap_rwsem to address page fault/truncate race

 fs/hugetlbfs/inode.c    |  30 +++++--
 include/linux/fs.h      |   5 ++
 include/linux/hugetlb.h |   8 ++
 mm/hugetlb.c            | 175 +++++++++++++++++++++++++++++++++++-----
 mm/memory-failure.c     |  29 ++++++-
 mm/migrate.c            |  25 +++++-
 mm/rmap.c               |  17 +++-
 mm/userfaultfd.c        |  11 ++-
 8 files changed, 263 insertions(+), 37 deletions(-)

-- 
2.24.1

