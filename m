Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707DFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB972076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgHTOa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:30:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58978 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727911AbgHTOay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:30:54 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CD1104045911F351B0E0;
        Thu, 20 Aug 2020 22:30:51 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.174.177.253) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Thu, 20 Aug 2020 22:30:41 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Oliver O'Halloran <oohall@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/4] libnvdimm: remove redundant list_empty() check in badrange.c
Date:   Thu, 20 Aug 2020 22:30:24 +0800
Message-ID: <20200820143027.3241-2-thunder.leizhen@huawei.com>
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

In add_badrange() or badblocks_populate(), the list_empty() branch does
the same things as the code after list_for_each_entry(). And the
list_for_each_entry() will do noting when list_empty().

So the list_empty() branch can be removed without functional change, let
the code after list_for_each_entry() to do it.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/nvdimm/badrange.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/nvdimm/badrange.c b/drivers/nvdimm/badrange.c
index b9eeefa27e3a507..9fdba8c43e8605e 100644
--- a/drivers/nvdimm/badrange.c
+++ b/drivers/nvdimm/badrange.c
@@ -53,13 +53,6 @@ static int add_badrange(struct badrange *badrange, u64 addr, u64 length)
 	bre_new = kzalloc(sizeof(*bre_new), GFP_KERNEL);
 	spin_lock(&badrange->lock);
 
-	if (list_empty(&badrange->list)) {
-		if (!bre_new)
-			return -ENOMEM;
-		append_badrange_entry(badrange, bre_new, addr, length);
-		return 0;
-	}
-
 	/*
 	 * There is a chance this is a duplicate, check for those first.
 	 * This will be the common case as ARS_STATUS returns all known
@@ -215,9 +208,6 @@ static void badblocks_populate(struct badrange *badrange,
 {
 	struct badrange_entry *bre;
 
-	if (list_empty(&badrange->list))
-		return;
-
 	list_for_each_entry(bre, &badrange->list, list) {
 		u64 bre_end = bre->start + bre->length - 1;
 
-- 
1.8.3


