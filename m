Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FE0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D282076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgHTObi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:31:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58956 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728148AbgHTOba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:31:30 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A0524680DFEFE3E90D12;
        Thu, 20 Aug 2020 22:30:51 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.174.177.253) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Thu, 20 Aug 2020 22:30:43 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Oliver O'Halloran <oohall@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 4/4] libnvdimm: avoid unnecessary judgments in nvdimm_namespace_disk_name()
Date:   Thu, 20 Aug 2020 22:30:27 +0800
Message-ID: <20200820143027.3241-5-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200820143027.3241-1-thunder.leizhen@huawei.com>
References: <20200820143027.3241-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

suffix ? suffix : "" appears three times, it's easy to get rid of it
by initialize the local variable "suffix" to empty string.

To avoid having rows that exceed 80 columns, add a new local variable
"region_id".

No functional change, but it can reduce the code size.
Before:
   text    data     bss     dec     hex filename
  41749    3697      16   45462    b196 drivers/nvdimm/namespace_devs.o

After:
   text    data     bss     dec     hex filename
  41653    3697      16   45366    b136 drivers/nvdimm/namespace_devs.o

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/nvdimm/namespace_devs.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 6da67f4d641a27c..ef2800c5da4c99c 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -157,7 +157,8 @@ const char *nvdimm_namespace_disk_name(struct nd_namespace_common *ndns,
 		char *name)
 {
 	struct nd_region *nd_region = to_nd_region(ndns->dev.parent);
-	const char *suffix = NULL;
+	const char *suffix = "";
+	int region_id = nd_region->id;
 
 	if (ndns->claim && is_nd_btt(ndns->claim))
 		suffix = "s";
@@ -173,17 +174,14 @@ const char *nvdimm_namespace_disk_name(struct nd_namespace_common *ndns,
 		}
 
 		if (nsidx)
-			sprintf(name, "pmem%d.%d%s", nd_region->id, nsidx,
-					suffix ? suffix : "");
+			sprintf(name, "pmem%d.%d%s", region_id, nsidx, suffix);
 		else
-			sprintf(name, "pmem%d%s", nd_region->id,
-					suffix ? suffix : "");
+			sprintf(name, "pmem%d%s", region_id, suffix);
 	} else if (is_namespace_blk(&ndns->dev)) {
 		struct nd_namespace_blk *nsblk;
 
 		nsblk = to_nd_namespace_blk(&ndns->dev);
-		sprintf(name, "ndblk%d.%d%s", nd_region->id, nsblk->id,
-				suffix ? suffix : "");
+		sprintf(name, "ndblk%d.%d%s", region_id, nsblk->id, suffix);
 	} else {
 		return NULL;
 	}
-- 
1.8.3


