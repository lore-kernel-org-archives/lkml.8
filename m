Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50139C43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0072D2083E
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M/d59Iyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgIFTdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 15:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgIFTdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 15:33:39 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F11AC061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 12:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=GbMNrkLBxGmNSVmZdqvsvL+gwMutalvbb1INFje9QKQ=; b=M/d59IytXM0oQwpJsuioibpx+G
        JdOQuOdeWKI1hPzNl2vg7Oo58qEooKKWr3WQAgELONs3Qx6WzqQjS8xPOL71//MmivEsFyQ2Y2UXv
        s+5RPJzgL1tRNM1oaPY7774rTQKly1oKa6jlJ/gpZAf60GRVK/lh1exGG3EEOjTMbHxAfa6oAI8Wb
        619XizF4SdSAuwHwOxuMcVZeHEJdk7o5QeesCCL+MUVx4uUgMmC9f0CgHSOampVtGNE9SkXaqkFFl
        xfs1s2VawYiMpY2p9TbhK/O9nAvLO4ZVmoFR1wiWEKGlk4dI3ilpZS8JSnnYkMIlAVU/dtuCDdj+n
        FIrOMdgQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kF0PZ-0002sU-R6; Sun, 06 Sep 2020 19:33:14 +0000
To:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Nazarewicz <mina86@mina86.com>,
        Wen Congyang <wency@cn.fujitsu.com>,
        Michal Simek <monstr@monstr.eu>,
        Christoph Hellwig <hch@lst.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        kernel test robot <lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] <linux/page-isolation.h>: provide stubs for MEMORY_ISOLATION
 not set (for Microblaze)
Message-ID: <1f6b42e6-b6b5-40e3-92b4-77bd610d3e49@infradead.org>
Date:   Sun, 6 Sep 2020 12:33:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors in Microblaze when CONFIG_MEMORY_ISOLATION is not
set/enabled by adding stubs for 3 missing functions.

Fixes these build errors:

gcc-9.3.0-nolibc/microblaze-linux/bin/microblaze-linux-ld: mm/page_alloc.o: in function `alloc_contig_range':
(.text+0xa0c0): undefined reference to `start_isolate_page_range'
gcc-9.3.0-nolibc/microblaze-linux/bin/microblaze-linux-ld: (.text+0xa2bc): undefined reference to `test_pages_isolated'
gcc-9.3.0-nolibc/microblaze-linux/bin/microblaze-linux-ld: (.text+0xa378): undefined reference to `undo_isolate_page_range'

Fixes: 0815f3d81d76 ("mm: page_isolation: MIGRATE_CMA isolation functions added") # v3.10
Fixes: b023f46813cd ("memory-hotplug: skip HWPoisoned page when offlining pages") # v3.10
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michal Nazarewicz <mina86@mina86.com>
Cc: Wen Congyang <wency@cn.fujitsu.com>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: linux-mm@kvack.org
---
 include/linux/page-isolation.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- linux-next-20200903.orig/include/linux/page-isolation.h
+++ linux-next-20200903/include/linux/page-isolation.h
@@ -28,6 +28,22 @@ static inline bool is_migrate_isolate(in
 {
 	return false;
 }
+static inline int test_pages_isolated(unsigned long start_pfn,
+				      unsigned long end_pfn, int isol_flags)
+{
+	return 0;
+}
+static inline int
+start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
+			 unsigned migratetype, int flags)
+{
+	return 0;
+}
+static inline void
+undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
+			unsigned migratetype)
+{
+}
 #endif
 
 #define MEMORY_OFFLINE	0x1


