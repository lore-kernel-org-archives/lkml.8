Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48726C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27A362076A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732050AbgFWC5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:57:22 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:57457 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731690AbgFWC5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:57:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U0T0eAi_1592881038;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U0T0eAi_1592881038)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Jun 2020 10:57:18 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 2/2] drivers/base/memory: rename base_memory_block_id to memory_block_id
Date:   Tue, 23 Jun 2020 10:57:01 +0800
Message-Id: <20200623025701.2016-2-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200623025701.2016-1-richard.weiyang@linux.alibaba.com>
References: <20200623025701.2016-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memory_block may have a larger granularity than section, this is why we
have base_section_nr. But base_memory_block_id seems a little
misleading, since there is no larger granularity concept which groups
several memory_block.

What we need here is the exact memory_block_id to a section_nr. Let's
rename it to make it more precise.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 drivers/base/memory.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 35f9a1aa0a2e..4db3c660de83 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -50,14 +50,14 @@ int memhp_online_type_from_str(const char *str)
 
 static int sections_per_block;
 
-static inline unsigned long base_memory_block_id(unsigned long section_nr)
+static inline unsigned long memory_block_id(unsigned long section_nr)
 {
 	return section_nr / sections_per_block;
 }
 
 static inline unsigned long pfn_to_block_id(unsigned long pfn)
 {
-	return base_memory_block_id(pfn_to_section_nr(pfn));
+	return memory_block_id(pfn_to_section_nr(pfn));
 }
 
 static inline unsigned long phys_to_block_id(unsigned long phys)
@@ -517,7 +517,7 @@ static struct memory_block *find_memory_block_by_id(unsigned long block_id)
  */
 struct memory_block *find_memory_block(struct mem_section *section)
 {
-	unsigned long block_id = base_memory_block_id(__section_nr(section));
+	unsigned long block_id = memory_block_id(__section_nr(section));
 
 	return find_memory_block_by_id(block_id);
 }
@@ -608,7 +608,7 @@ static int add_memory_block(unsigned long base_section_nr)
 
 	if (section_count == 0)
 		return 0;
-	return init_memory_block(base_memory_block_id(base_section_nr),
+	return init_memory_block(memory_block_id(base_section_nr),
 				 MEM_ONLINE);
 }
 
-- 
2.20.1 (Apple Git-117)

