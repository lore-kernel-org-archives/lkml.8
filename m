Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5447C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 02:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F56B2071B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 02:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgHaCYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 22:24:01 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:33853 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726573AbgHaCYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 22:24:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U7J4DAK_1598840637;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U7J4DAK_1598840637)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 31 Aug 2020 10:23:57 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, bhe@redhat.com,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [Patch v3 0/7] mm/hugetlb: code refine and simplification
Date:   Mon, 31 Aug 2020 10:23:44 +0800
Message-Id: <20200831022351.20916-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following are some cleanup for hugetlb.

Simple test with tools/testing/selftests/vm/map_hugetlb pass.

v3:
  * rebase on v5.9-rc2 which adjust the last patch a little
v2:
  * drop 5/6/10 since similar patches are merged or under review.
  * adjust 2 based on comment from Mike Kravetz

Wei Yang (7):
  mm/hugetlb: not necessary to coalesce regions recursively
  mm/hugetlb: remove VM_BUG_ON(!nrg) in
    get_file_region_entry_from_cache()
  mm/hugetlb: use list_splice to merge two list at once
  mm/hugetlb: count file_region to be added when regions_needed != NULL
  mm/hugetlb: a page from buddy is not on any list
  mm/hugetlb: narrow the hugetlb_lock protection area during preparing
    huge page
  mm/hugetlb: take the free hpage during the iteration directly

 mm/hugetlb.c | 71 ++++++++++++++++++++++------------------------------
 1 file changed, 30 insertions(+), 41 deletions(-)

-- 
2.20.1 (Apple Git-117)

