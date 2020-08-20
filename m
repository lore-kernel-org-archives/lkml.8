Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19372C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E139F2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgHTObB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:31:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58976 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727881AbgHTOay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:30:54 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C998F799B7358370849E;
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
Subject: [PATCH 3/4] libnvdimm: eliminate two unnecessary zero initializations in badrange.c
Date:   Thu, 20 Aug 2020 22:30:26 +0800
Message-ID: <20200820143027.3241-4-thunder.leizhen@huawei.com>
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

Currently, the "struct badrange_entry" has three members: start, length,
list. In append_badrange_entry(), "start" and "length" will be assigned
later, and "list" does not need to be initialized before calling
list_add_tail(). That means, the kzalloc() in badrange_add() or
alloc_and_append_badrange_entry() can be replaced with kmalloc(), because
the zero initialization is not required.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/nvdimm/badrange.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/badrange.c b/drivers/nvdimm/badrange.c
index 7f78b659057902d..13145001c52ff39 100644
--- a/drivers/nvdimm/badrange.c
+++ b/drivers/nvdimm/badrange.c
@@ -37,7 +37,7 @@ static int alloc_and_append_badrange_entry(struct badrange *badrange,
 {
 	struct badrange_entry *bre;
 
-	bre = kzalloc(sizeof(*bre), flags);
+	bre = kmalloc(sizeof(*bre), flags);
 	if (!bre)
 		return -ENOMEM;
 
@@ -49,7 +49,7 @@ int badrange_add(struct badrange *badrange, u64 addr, u64 length)
 {
 	struct badrange_entry *bre, *bre_new;
 
-	bre_new = kzalloc(sizeof(*bre_new), GFP_KERNEL);
+	bre_new = kmalloc(sizeof(*bre_new), GFP_KERNEL);
 
 	spin_lock(&badrange->lock);
 
-- 
1.8.3


