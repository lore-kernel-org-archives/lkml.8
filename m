Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E14DC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E21924125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgAUItd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:49:33 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:42064 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728799AbgAUItb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:49:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0ToHXcZl_1579596569;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHXcZl_1579596569)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:49:29 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hfsplus: remove Hangul_LCount
Date:   Tue, 21 Jan 2020 16:49:27 +0800
Message-Id: <1579596567-258038-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro is never used from first git commit Linux-2.6.12-rc2. Maybe
better to remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 fs/hfsplus/unicode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index c8d1b2be7854..969203b61596 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -93,7 +93,6 @@ int hfsplus_strcmp(const struct hfsplus_unistr *s1,
 #define Hangul_VBase	0x1161
 #define Hangul_TBase	0x11a7
 #define Hangul_SCount	11172
-#define Hangul_LCount	19
 #define Hangul_VCount	21
 #define Hangul_TCount	28
 #define Hangul_NCount	(Hangul_VCount * Hangul_TCount)
-- 
1.8.3.1

