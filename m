Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D6EC2D0EC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0496F20409
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgC3OWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:22:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12150 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727359AbgC3OWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:22:53 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6B56F5D28BC866C93547;
        Mon, 30 Mar 2020 22:22:47 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 22:22:39 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <aneesh.kumar@linux.ibm.com>, <jmoyer@redhat.com>
CC:     <linux-nvdimm@lists.01.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] libnvdimm/region: Fix build error
Date:   Mon, 30 Mar 2020 22:19:43 +0800
Message-ID: <20200330141943.31696-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On CONFIG_PPC32=y build fails:

drivers/nvdimm/region_devs.c:1034:14: note: in expansion of macro ‘do_div’
  remainder = do_div(per_mapping, mappings);
              ^~~~~~
In file included from ./arch/powerpc/include/generated/asm/div64.h:1:0,
                 from ./include/linux/kernel.h:18,
                 from ./include/asm-generic/bug.h:19,
                 from ./arch/powerpc/include/asm/bug.h:109,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/scatterlist.h:7,
                 from drivers/nvdimm/region_devs.c:5:
./include/asm-generic/div64.h:243:22: error: passing argument 1 of ‘__div64_32’ from incompatible pointer type [-Werror=incompatible-pointer-types]
   __rem = __div64_32(&(n), __base); \

Use div_u64 instead of do_div to fix this.

Fixes: 2522afb86a8c ("libnvdimm/region: Introduce an 'align' attribute")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/nvdimm/region_devs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index bf239e783940..2291f0649d27 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -564,7 +564,7 @@ static ssize_t align_store(struct device *dev,
 	 * space for the namespace.
 	 */
 	dpa = val;
-	remainder = do_div(dpa, nd_region->ndr_mappings);
+	remainder = div_u64(dpa, nd_region->ndr_mappings);
 	if (!is_power_of_2(dpa) || dpa < PAGE_SIZE
 			|| val > region_size(nd_region) || remainder)
 		return -EINVAL;
@@ -1031,7 +1031,7 @@ static unsigned long default_align(struct nd_region *nd_region)
 
 	mappings = max_t(u16, 1, nd_region->ndr_mappings);
 	per_mapping = align;
-	remainder = do_div(per_mapping, mappings);
+	remainder = div_u64(per_mapping, mappings);
 	if (remainder)
 		align *= mappings;
 
-- 
2.17.1


