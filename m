Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EECC433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF7562074D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgIEIfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 04:35:39 -0400
Received: from smtp.h3c.com ([60.191.123.50]:59841 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgIEIfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:35:38 -0400
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam02-ex.h3c.com with ESMTP id 0857MrRw079323;
        Sat, 5 Sep 2020 15:22:53 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam02-ex.h3c.com with ESMTPS id 0857MkCp079300
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 5 Sep 2020 15:22:46 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 5 Sep 2020 15:22:48 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] fs: use correct parameter in notes of generic_file_llseek_size()
Date:   Sat, 5 Sep 2020 15:15:25 +0800
Message-ID: <20200905071525.12259-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 0857MkCp079300
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning when compiling with W=1:
fs/read_write.c:88: warning: Function parameter or member 'maxsize' not described in 'generic_file_llseek_size'
fs/read_write.c:88: warning: Excess function parameter 'size' description in 'generic_file_llseek_size'

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 fs/read_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 5db58b8c7..058563ee2 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -71,7 +71,7 @@ EXPORT_SYMBOL(vfs_setpos);
  * @file:	file structure to seek on
  * @offset:	file offset to seek to
  * @whence:	type of seek
- * @size:	max size of this file in file system
+ * @maxsize:	max size of this file in file system
  * @eof:	offset used for SEEK_END position
  *
  * This is a variant of generic_file_llseek that allows passing in a custom
-- 
2.17.1

