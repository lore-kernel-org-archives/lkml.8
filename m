Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEDCC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 03:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C08424653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 03:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgAUDh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 22:37:26 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:48754 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728827AbgAUDhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 22:37:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0ToGbVM4_1579577842;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToGbVM4_1579577842)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 11:37:22 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] OCFS2: use OCFS2_SEC_BITS in macro
Date:   Tue, 21 Jan 2020 11:37:20 +0800
Message-Id: <1579577840-251956-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macros should be used as it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com> 
Cc: Joel Becker <jlbec@evilplan.org> 
Cc: Joseph Qi <joseph.qi@linux.alibaba.com> 
Cc: ocfs2-devel@oss.oracle.com 
Cc: linux-kernel@vger.kernel.org 
---
 fs/ocfs2/dlmglue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index cda1027d0819..0d6daf49b72a 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -2133,7 +2133,7 @@ static void ocfs2_downconvert_on_unlock(struct ocfs2_super *osb,
 }
 
 #define OCFS2_SEC_BITS   34
-#define OCFS2_SEC_SHIFT  (64 - 34)
+#define OCFS2_SEC_SHIFT  (64 - OCFS2_SEC_BITS)
 #define OCFS2_NSEC_MASK  ((1ULL << OCFS2_SEC_SHIFT) - 1)
 
 /* LVB only has room for 64 bits of time here so we pack it for
-- 
1.8.3.1

