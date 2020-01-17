Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7338BC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED0B20728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgAQHpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 02:45:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:64334 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbgAQHpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 02:45:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 23:45:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,329,1574150400"; 
   d="scan'208";a="219957119"
Received: from unknown (HELO localhost) ([10.239.159.54])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jan 2020 23:45:26 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH] mm/migrate.c: also overwrite error when it is bigger than zero
Date:   Fri, 17 Jan 2020 15:45:34 +0800
Message-Id: <20200117074534.25324-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we get here after successfully adding page to list, err would be
the number of pages in the list.

Current code has two problems:

  * on success, 0 is not returned
  * on error, the real error code is not returned

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 557da996b936..c3ef70de5876 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1677,7 +1677,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 	err1 = do_move_pages_to_node(mm, &pagelist, current_node);
 	if (!err1)
 		err1 = store_status(status, start, current_node, i - start);
-	if (!err)
+	if (err >= 0)
 		err = err1;
 out:
 	return err;
-- 
2.17.1

