Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6742EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A8DD2076A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732003AbgFWC5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:57:21 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:35797 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731557AbgFWC5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:57:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U0SejbM_1592881037;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U0SejbM_1592881037)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Jun 2020 10:57:18 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 1/2] drivers/base/memory: init_memory_block() first parameter is not necessary
Date:   Tue, 23 Jun 2020 10:57:00 +0800
Message-Id: <20200623025701.2016-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first parameter of init_memory_block() is intended to retrieve the
memory_block initiated. But now, we never use it.

Drop it for now.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 drivers/base/memory.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 2b09b68b9f78..35f9a1aa0a2e 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -570,8 +570,7 @@ int register_memory(struct memory_block *memory)
 	return ret;
 }
 
-static int init_memory_block(struct memory_block **memory,
-			     unsigned long block_id, unsigned long state)
+static int init_memory_block(unsigned long block_id, unsigned long state)
 {
 	struct memory_block *mem;
 	unsigned long start_pfn;
@@ -594,14 +593,12 @@ static int init_memory_block(struct memory_block **memory,
 
 	ret = register_memory(mem);
 
-	*memory = mem;
 	return ret;
 }
 
 static int add_memory_block(unsigned long base_section_nr)
 {
 	int section_count = 0;
-	struct memory_block *mem;
 	unsigned long nr;
 
 	for (nr = base_section_nr; nr < base_section_nr + sections_per_block;
@@ -611,7 +608,7 @@ static int add_memory_block(unsigned long base_section_nr)
 
 	if (section_count == 0)
 		return 0;
-	return init_memory_block(&mem, base_memory_block_id(base_section_nr),
+	return init_memory_block(base_memory_block_id(base_section_nr),
 				 MEM_ONLINE);
 }
 
@@ -647,7 +644,7 @@ int create_memory_block_devices(unsigned long start, unsigned long size)
 		return -EINVAL;
 
 	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
-		ret = init_memory_block(&mem, block_id, MEM_OFFLINE);
+		ret = init_memory_block(block_id, MEM_OFFLINE);
 		if (ret)
 			break;
 	}
-- 
2.20.1 (Apple Git-117)

