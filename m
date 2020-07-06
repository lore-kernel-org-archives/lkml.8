Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C932C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B133212CC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gm0J7Utb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgGFU1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:27:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43334 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgGFU1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 16:27:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 066KLpAG016027;
        Mon, 6 Jul 2020 20:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=uKmjFEnaPpukaqN1TXpY12uCe1K0N+AZzcAaOaTUQCQ=;
 b=Gm0J7Utboy6Tt0uuzT9deg35GgNPktmTb+khP7NkhevKYwHl7AX73eQhQnPFyMs95Snv
 DjD3JIi4Wbf/GAvf4NrCLA+dlTgV+GTE+Vll6/GItAZY3vtx/khL8OU712qd19O62a0k
 5RYjEW7PY0HzgU3G8fEppBCq9Y66q+cd9U8jljXy+W2zqeG3pQlyXhRR+68DOGhCqKA+
 S4asQqtW/Mowqg821nrfDxATGd8hr88PkU5Fl7idycavUS/hxLotL1DAeuTGWFbOZxMO
 4JKQ8JD/9t0kH/nsQprPL4LBi/sfxo3SWLBOCiFVrHPUO2ZV8P/zEHX5Zzhtv7gEMnQ0 jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 323waccgdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 06 Jul 2020 20:26:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 066KO9Va126213;
        Mon, 6 Jul 2020 20:26:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3233pvxa6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jul 2020 20:26:22 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 066KQJaj019671;
        Mon, 6 Jul 2020 20:26:19 GMT
Received: from monkey.oracle.com (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Jul 2020 13:26:19 -0700
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 0/3] hugetlbfs: address fault time regression
Date:   Mon,  6 Jul 2020 13:26:12 -0700
Message-Id: <20200706202615.32111-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200622005551.GK5535@shao2-debian>
References: <20200622005551.GK5535@shao2-debian>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9674 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007060138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9674 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0 cotscore=-2147483648
 suspectscore=0 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007060138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commits c0d0381ade79 and 87bf91d39bb5 changed the way huegtlb locking
was performed to address BUGs.  One specific change was to always take
the i_mmap_rwsem in read mode during fault processing.  One result of
this change was a 33% regression for anon non-shared page faults [1].

Technically, i_mmap_rwsem only needs to be taken during page faults
if the pmd can potentially be shared.  pmd sharing is not possible for
anon non-shared mappings (as in the reported regression), therefore the
code can be modified to not acquire the semaphore in this case.

Unfortunately, commit 87bf91d39bb5 depends on i_mmap_rwsem always being
taken in the fault path to prevent fault/truncation races.  So, that
approach is no longer appropriate.  Rather, the code now detects races
and backs out operations.

This code "works" in that it only takes i_mmap_rwsem when necessary and
addresses the original BUGs.  However, I am sending as an RFC because:
- I am unsure if the added complexity is worth performance benefit.
- There needs to be a better way/location to make a decison about taking
  the semaphore.  See FIXME's in the code.

Comments and suggestions would be appreciated.

[1] https://lore.kernel.org/lkml/20200622005551.GK5535@shao2-debian

Mike Kravetz (3):
  Revert: "hugetlbfs: Use i_mmap_rwsem to address page fault/truncate
    race"
  hugetlbfs: Only take i_mmap_rwsem when sharing is possible
  huegtlbfs: handle page fault/truncate races

 fs/hugetlbfs/inode.c |  69 +++++++++-----------
 mm/hugetlb.c         | 150 ++++++++++++++++++++++++++++++-------------
 2 files changed, 137 insertions(+), 82 deletions(-)

-- 
2.25.4

