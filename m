Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF917C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF3920873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgBLOnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:43:23 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9725 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727092AbgBLOnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:43:23 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1F0034A4288EE7177A00;
        Wed, 12 Feb 2020 22:43:14 +0800 (CST)
Received: from euler.huawei.com (10.175.104.193) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Wed, 12 Feb 2020 22:43:07 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <chenwandun@huawei.com>
Subject: [PATCH] mm/swapfile.c: fix comments for swapcache_prepare
Date:   Wed, 12 Feb 2020 22:57:54 +0800
Message-ID: <20200212145754.27123-1-chenwandun@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.193]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the -EEXIST returned by __swap_duplicate means there is a swap
cache instead -EBUSY

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 mm/swapfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2c33ff456ed5..0e23c123a545 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3476,7 +3476,7 @@ int swap_duplicate(swp_entry_t entry)
  *
  * Called when allocating swap cache for existing swap entry,
  * This can return error codes. Returns 0 at success.
- * -EBUSY means there is a swap cache.
+ * -EEXIST means there is a swap cache.
  * Note: return code is different from swap_duplicate().
  */
 int swapcache_prepare(swp_entry_t entry)
-- 
2.17.1

