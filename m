Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7698EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D1AA2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgG2DfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 23:35:21 -0400
Received: from foss.arm.com ([217.140.110.172]:44530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgG2DfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 23:35:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 288FB31B;
        Tue, 28 Jul 2020 20:35:20 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.212.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AC23E3F66E;
        Tue, 28 Jul 2020 20:35:12 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        Wei Yang <richardw.yang@linux.intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, Kaly Xin <Kaly.Xin@arm.com>,
        Jia He <justin.he@arm.com>
Subject: [RFC PATCH 1/6] mm/memory_hotplug: remove redundant memory block size alignment check
Date:   Wed, 29 Jul 2020 11:34:19 +0800
Message-Id: <20200729033424.2629-2-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729033424.2629-1-justin.he@arm.com>
References: <20200729033424.2629-1-justin.he@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alignment check has been done by check_hotplug_memory_range(). Hence
the redundant one in create_memory_block_devices() can be removed.

The similar redundant check is removed in remove_memory_block_devices().

Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/base/memory.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 2b09b68b9f78..4a1691664c6c 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -642,10 +642,6 @@ int create_memory_block_devices(unsigned long start, unsigned long size)
 	unsigned long block_id;
 	int ret = 0;
 
-	if (WARN_ON_ONCE(!IS_ALIGNED(start, memory_block_size_bytes()) ||
-			 !IS_ALIGNED(size, memory_block_size_bytes())))
-		return -EINVAL;
-
 	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
 		ret = init_memory_block(&mem, block_id, MEM_OFFLINE);
 		if (ret)
@@ -678,10 +674,6 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
 	struct memory_block *mem;
 	unsigned long block_id;
 
-	if (WARN_ON_ONCE(!IS_ALIGNED(start, memory_block_size_bytes()) ||
-			 !IS_ALIGNED(size, memory_block_size_bytes())))
-		return;
-
 	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
 		mem = find_memory_block_by_id(block_id);
 		if (WARN_ON_ONCE(!mem))
-- 
2.17.1

