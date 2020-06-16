Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5F7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A0CD20B80
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgFPWdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 18:33:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6269 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbgFPWdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 18:33:21 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0C1FEA5F092C63276926;
        Wed, 17 Jun 2020 06:33:19 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.10) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Wed, 17 Jun 2020 06:33:10 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v2 0/2] mm: fix the names of general cma and hugetlb cma
Date:   Wed, 17 Jun 2020 10:31:29 +1200
Message-ID: <20200616223131.33828-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.10]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the current code of CMA can only work when users pass a const string as name
parameter. we need to fix the way to handle names in CMA.
On the other hand, to avoid name conflicts after enabling CMA_DEBUGFS, each
hugetlb should get a different CMA name.

-v2:
  add acked-by and reviewed-by
  rebase to 5.8-rc1

Barry Song (2):
  mm: cma: fix the name of CMA areas
  mm: hugetlb: fix the name of hugetlb CMA

 mm/cma.c     | 13 ++++++-------
 mm/cma.h     |  4 +++-
 mm/hugetlb.c |  4 +++-
 3 files changed, 12 insertions(+), 9 deletions(-)

-- 
2.23.0


