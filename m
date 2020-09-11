Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98311C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C83B21D40
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgIKMIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 08:08:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:32768 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725831AbgIKMID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:08:03 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 34660C9AB0915342A1BE;
        Fri, 11 Sep 2020 20:07:45 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Fri, 11 Sep 2020
 20:07:40 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] fs_parser: Fix 'name' kernel-doc warning in validate_constant_table()
Date:   Fri, 11 Sep 2020 20:04:54 +0800
Message-ID: <20200911120454.70466-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

fs/fs_parser.c:322: warning: Excess function parameter 'name' description in 'validate_constant_table'

This parameter is not in use. Remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 fs/fs_parser.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index ab53e42a874..a5bd6ea5a03 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -310,7 +310,6 @@ EXPORT_SYMBOL(fs_param_is_path);
 #ifdef CONFIG_VALIDATE_FS_PARSER
 /**
  * validate_constant_table - Validate a constant table
- * @name: Name to use in reporting
  * @tbl: The constant table to validate.
  * @tbl_size: The size of the table.
  * @low: The lowest permissible value.
-- 
2.17.1

