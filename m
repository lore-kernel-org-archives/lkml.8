Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B16C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21D1420663
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgFZNwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:52:36 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:44965 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728936AbgFZNwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:52:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U0lVmOA_1593179549;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U0lVmOA_1593179549)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 26 Jun 2020 21:52:29 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        yang.shi@linux.alibaba.com, vbabka@suse.cz, willy@infradead.org,
        thomas_os@shipmail.org, thellstrom@vmware.com,
        anshuman.khandual@arm.com, sean.j.christopherson@intel.com,
        aneesh.kumar@linux.ibm.com, peterx@redhat.com, walken@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, digetx@gmail.com,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [RESEND Patch v2 0/4] mm/mremap: cleanup move_page_tables() a little
Date:   Fri, 26 Jun 2020 21:52:12 +0800
Message-Id: <20200626135216.24314-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move_page_tables() tries to move page table by PMD or PTE.

The root reason is if it tries to move PMD, both old and new range should be
PMD aligned. But current code calculate old range and new range separately.
This leads to some redundant check and calculation.

This cleanup tries to consolidate the range check in one place to reduce some
extra range handling.

v2:
  * remove 3rd patch which doesn't work on ARM platform. Thanks report and
    test from Dmitry Osipenko

Wei Yang (4):
  mm/mremap: format the check in move_normal_pmd() same as
    move_huge_pmd()
  mm/mremap: it is sure to have enough space when extent meets
    requirement
  mm/mremap: calculate extent in one place
  mm/mremap: start addresses are properly aligned

 include/linux/huge_mm.h |  2 +-
 mm/huge_memory.c        |  8 +-------
 mm/mremap.c             | 17 ++++++-----------
 3 files changed, 8 insertions(+), 19 deletions(-)

-- 
2.20.1 (Apple Git-117)

