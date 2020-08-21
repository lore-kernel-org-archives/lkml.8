Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FA9C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 03:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD21820855
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 03:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgHUDey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 23:34:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45678 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726975AbgHUDex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 23:34:53 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8061D558E3DE7BEE5F2A;
        Fri, 21 Aug 2020 11:28:36 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.191) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 21 Aug 2020 11:28:25 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] mm/gup_benchmark: update the documentation in Kconfig
Date:   Fri, 21 Aug 2020 15:25:46 +1200
Message-ID: <20200821032546.19992-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.202.191]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the beginning, mm/gup_benchmark.c supported get_user_pages_fast()
only, but right now, it supports the benchmarking of a couple of
get_user_pages() related calls like:
* get_user_pages_fast()
* get_user_pages()
* pin_user_pages_fast()
* pin_user_pages()
The documentation is confusing and needs update.

Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 mm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 6c974888f86f..f7c9374da7b3 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -831,10 +831,10 @@ config PERCPU_STATS
 	  be used to help understand percpu memory usage.
 
 config GUP_BENCHMARK
-	bool "Enable infrastructure for get_user_pages_fast() benchmarking"
+	bool "Enable infrastructure for get_user_pages() and related calls benchmarking"
 	help
 	  Provides /sys/kernel/debug/gup_benchmark that helps with testing
-	  performance of get_user_pages_fast().
+	  performance of get_user_pages() and related calls.
 
 	  See tools/testing/selftests/vm/gup_benchmark.c
 
-- 
2.27.0


