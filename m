Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429CEC433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 00:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F4E02071B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 00:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgGOAZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 20:25:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33492 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728076AbgGOAZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 20:25:30 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A6F8B76DDE269CBDAEE3;
        Wed, 15 Jul 2020 08:25:27 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.238) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Jul 2020
 08:25:20 +0800
Subject: [PATCH v3] mm/percpu: fix 'defined but not used' warning
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-next@vger.kernel.org>,
        <john.wanghui@huawei.com>, Roman Gushchin <guro@fb.com>
References: <20200714134101.80534-1-cuibixuan@huawei.com>
 <20200714225311.7aeffffd@canb.auug.org.au>
 <6f1a8c76-d6d7-1a2c-8b0b-26a4a31f1a19@huawei.com>
 <20200715062229.78591ff9@canb.auug.org.au>
From:   Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <6d41b939-a741-b521-a7a2-e7296ec16219@huawei.com>
Date:   Wed, 15 Jul 2020 08:25:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200715062229.78591ff9@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gcc report the following warning without CONFIG_MEMCG_KMEM:

mm/percpu-internal.h:145:29: warning: 'pcpu_chunk_type' defined
but not used [-Wunused-function]
 static enum pcpu_chunk_type pcpu_chunk_type(struct pcpu_chunk *chunk)
                             ^~~~~~~~~~~~~~~

Add 'inline' to pcpu_chunk_type(),pcpu_is_memcg_chunk() and
pcpu_chunk_list() to clear warning.

Acked-by: Roman Gushchin <guro@fb.com>
Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 mm/percpu-internal.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index 7983455842ff..18b768ac7dca 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -129,31 +129,31 @@ static inline int pcpu_chunk_map_bits(struct pcpu_chunk *chunk)
 }

 #ifdef CONFIG_MEMCG_KMEM
-static enum pcpu_chunk_type pcpu_chunk_type(struct pcpu_chunk *chunk)
+static inline enum pcpu_chunk_type pcpu_chunk_type(struct pcpu_chunk *chunk)
 {
 	if (chunk->obj_cgroups)
 		return PCPU_CHUNK_MEMCG;
 	return PCPU_CHUNK_ROOT;
 }

-static bool pcpu_is_memcg_chunk(enum pcpu_chunk_type chunk_type)
+static inline bool pcpu_is_memcg_chunk(enum pcpu_chunk_type chunk_type)
 {
 	return chunk_type == PCPU_CHUNK_MEMCG;
 }

 #else
-static enum pcpu_chunk_type pcpu_chunk_type(struct pcpu_chunk *chunk)
+static inline enum pcpu_chunk_type pcpu_chunk_type(struct pcpu_chunk *chunk)
 {
 	return PCPU_CHUNK_ROOT;
 }

-static bool pcpu_is_memcg_chunk(enum pcpu_chunk_type chunk_type)
+static inline bool pcpu_is_memcg_chunk(enum pcpu_chunk_type chunk_type)
 {
 	return false;
 }
 #endif

-static struct list_head *pcpu_chunk_list(enum pcpu_chunk_type chunk_type)
+static inline struct list_head *pcpu_chunk_list(enum pcpu_chunk_type chunk_type)
 {
 	return &pcpu_chunk_lists[pcpu_nr_slots *
 				 pcpu_is_memcg_chunk(chunk_type)];
-- 
2.17.1


.


