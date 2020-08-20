Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343D9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 02:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E03F2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 02:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHTCRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 22:17:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9785 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726759AbgHTCR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 22:17:28 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 755E8A4661290D22C777;
        Thu, 20 Aug 2020 10:17:25 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.174.177.253) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 20 Aug 2020 10:17:17 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Oliver O'Halloran <oohall@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v3 4/7] libnvdimm: reduce an unnecessary if branch in nd_region_create()
Date:   Thu, 20 Aug 2020 10:16:38 +0800
Message-ID: <20200820021641.3188-5-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200820021641.3188-1-thunder.leizhen@huawei.com>
References: <20200820021641.3188-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if (ndr_desc->flush)
1)	nd_region->flush = ndr_desc->flush;
else
2)	nd_region->flush = NULL;

When entering the "else" branch, the value of ndr_desc->flush is NULL.
After replaced "NULL" with "ndr_desc->flush" at 2), we will find that
it becomes the same to 1).

So the above code snippet can be reduced to one statement:
nd_region->flush = ndr_desc->flush;

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/nvdimm/region_devs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index ef23119db574663..7cf9c7d857909ce 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1131,10 +1131,7 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 	nd_region->ndr_size = resource_size(ndr_desc->res);
 	nd_region->ndr_start = ndr_desc->res->start;
 	nd_region->align = default_align(nd_region);
-	if (ndr_desc->flush)
-		nd_region->flush = ndr_desc->flush;
-	else
-		nd_region->flush = NULL;
+	nd_region->flush = ndr_desc->flush;
 
 	nd_device_register(dev);
 
-- 
1.8.3


