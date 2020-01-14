Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4F8C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D6724672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgANMjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 07:39:41 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:37681 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726038AbgANMjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 07:39:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TnjK9OE_1579005577;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TnjK9OE_1579005577)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Jan 2020 20:39:37 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/vmscan: remove unused RECLAIM_OFF/RECLAIM_ZONE
Date:   Tue, 14 Jan 2020 20:39:33 +0800
Message-Id: <1579005573-58923-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 1b2ffb7896ad ("[PATCH] Zone reclaim: Allow modification of zone reclaim behavior")'
defined RECLAIM_OFF/RECLAIM_ZONE, but never use them, so better to remove them.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/vmscan.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 572fb17c6273..4e699ed3501e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4126,8 +4126,6 @@ static int __init kswapd_init(void)
  */
 int node_reclaim_mode __read_mostly;
 
-#define RECLAIM_OFF 0
-#define RECLAIM_ZONE (1<<0)	/* Run shrink_inactive_list on the zone */
 #define RECLAIM_WRITE (1<<1)	/* Writeout pages during reclaim */
 #define RECLAIM_UNMAP (1<<2)	/* Unmap pages during reclaim */
 
-- 
1.8.3.1

