Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F6BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 474D02074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgG2Df3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 23:35:29 -0400
Received: from foss.arm.com ([217.140.110.172]:44566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgG2Df2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 23:35:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22CD631B;
        Tue, 28 Jul 2020 20:35:28 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.212.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A76983F66E;
        Tue, 28 Jul 2020 20:35:20 -0700 (PDT)
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
Subject: [RFC PATCH 2/6] resource: export find_next_iomem_res() helper
Date:   Wed, 29 Jul 2020 11:34:20 +0800
Message-Id: <20200729033424.2629-3-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729033424.2629-1-justin.he@arm.com>
References: <20200729033424.2629-1-justin.he@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper is to find the lowest iomem resource that covers part of
[@start..@end]

It is useful when relaxing the alignment check for dax pmem kmem.

Signed-off-by: Jia He <justin.he@arm.com>
---
 include/linux/ioport.h | 3 +++
 kernel/resource.c      | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 6c2b06fe8beb..203fd16c9f45 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -247,6 +247,9 @@ extern struct resource * __request_region(struct resource *,
 
 extern void __release_region(struct resource *, resource_size_t,
 				resource_size_t);
+extern int find_next_iomem_res(resource_size_t start, resource_size_t end,
+			       unsigned long flags, unsigned long desc,
+			       bool first_lvl, struct resource *res);
 #ifdef CONFIG_MEMORY_HOTREMOVE
 extern int release_mem_region_adjustable(struct resource *, resource_size_t,
 				resource_size_t);
diff --git a/kernel/resource.c b/kernel/resource.c
index 841737bbda9e..57e6a6802a3d 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -338,7 +338,7 @@ EXPORT_SYMBOL(release_resource);
  * @first_lvl:	walk only the first level children, if set
  * @res:	return ptr, if resource found
  */
-static int find_next_iomem_res(resource_size_t start, resource_size_t end,
+int find_next_iomem_res(resource_size_t start, resource_size_t end,
 			       unsigned long flags, unsigned long desc,
 			       bool first_lvl, struct resource *res)
 {
@@ -391,6 +391,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 	read_unlock(&resource_lock);
 	return p ? 0 : -ENODEV;
 }
+EXPORT_SYMBOL(find_next_iomem_res);
 
 static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
 				 unsigned long flags, unsigned long desc,
-- 
2.17.1

