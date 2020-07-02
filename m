Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2A8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FEE0207CD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgGBLAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:00:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40738 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726475AbgGBLAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:00:51 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8C983AB14A354227C8D6;
        Thu,  2 Jul 2020 19:00:48 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 2 Jul 2020 19:00:37 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <jpoimboe@redhat.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <chenwandun@huawei.com>
Subject: [PATCH] objtool: fix potential memory leak special_get_alts()
Date:   Thu, 2 Jul 2020 19:00:25 +0800
Message-ID: <20200702110025.16883-1-chenwandun@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If get_alt_entry() return error, struct special_alt will leak.

Fixes: 442f04c34a1a ("objtool: Add tool to perform compile-time stack metadata validation")
Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 tools/objtool/special.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index e893f1e48e44..90a6ba2d5895 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -188,8 +188,10 @@ int special_get_alts(struct elf *elf, struct list_head *alts)
 			memset(alt, 0, sizeof(*alt));
 
 			ret = get_alt_entry(elf, entry, sec, idx, alt);
-			if (ret)
+			if (ret) {
+				free(alt);
 				return ret;
+			}
 
 			list_add_tail(&alt->list, alts);
 		}
-- 
2.17.1

