Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4D1C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 14:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665EF22AAC
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 14:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="TcMeF22U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgIHOco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 10:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729719AbgIHO0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 10:26:04 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BA0C08E818
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 07:25:10 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j34so4760616pgi.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 07:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qbyfb7IENIIZnzycuSlXwlchWqptmqZvtFIJsiTST2Q=;
        b=TcMeF22UNZIEg9d0gzz98TwFeIxyqfPvLagxomEInN8Jz1RMp7VDdtXA6EehKzjSG8
         /5SlRkTXBSFEzI7pP7AjUsnj7qEH/1FwaqMYorliQ5tbjGHarxMvO8K2yyl3kx+Odxn2
         3p+pVF9186L5mOvCvvk4+cuQxqF1uHjnnMNSMl/4X7ONNFqdgPB5cc4Rdoy/RJMqBX7L
         bEIWU1IN9uRC1oJ6e3XY9xep4JvDEaHn65KJdAK/LLiIaIQAFmKTXm5LoKEfec4Q8zPo
         Af1hYqV97gBqQ2vTs0XQpUYzWpFqhNlJegb6cSioxGUw8S/cvolkKosVgz5eZAOnnSmN
         NcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qbyfb7IENIIZnzycuSlXwlchWqptmqZvtFIJsiTST2Q=;
        b=VhKgYKcrWlRgwFv7THtlgALXJHdamqslide4B7eVDKyzPpi88cPYg0308F7zIzjJSN
         FqM2XJ29IKD8WRYRdTj9jV5WZUr7tE2BtJaF5lJihUaMohmhP0jR2faJzXgvgSVYPRYN
         zyI8H1awCwD6jlYtayNWhBHvTM3XSo6yOTECmZt6y4Jxdnmk3zb3u5alFh6fMSt4jRaI
         bnaKT0Det1E4BSLg+ymcSLvi+pbRPZnZR5KCCkHuQWBQzXwGHlNd5Ic5uQXWG8hJI4vd
         mg22laKx2LXIdy4N2Wg8SBfjvJ2PJVtUPW6RmyHiQj5LgJPER2u2KUreIn6/9zXsXRhQ
         hCYA==
X-Gm-Message-State: AOAM531RYn9caQfqIAh9t+ukWnJ5hz+4foxwRz1OR9IaxekpfJXv/ZWi
        xyMg/k2hAf6uzkJBkx3YD4oROmnzLvagf9HH
X-Google-Smtp-Source: ABdhPJxgxtlU8ucp+kFiZL0rAJPS9+qutAhqRqo5Pl2vMcjnCNUKCP13XLhDLlCxt6b4VxJLHDqNIQ==
X-Received: by 2002:aa7:8e85:: with SMTP id a5mr23961248pfr.96.1599575109593;
        Tue, 08 Sep 2020 07:25:09 -0700 (PDT)
Received: from localhost.localdomain ([103.136.220.67])
        by smtp.gmail.com with ESMTPSA id v26sm6120436pgo.83.2020.09.08.07.25.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 07:25:08 -0700 (PDT)
From:   zangchunxin@bytedance.com
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chunxin Zang <zangchunxin@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm/vmscan: fix infinite loop in drop_slab_node
Date:   Tue,  8 Sep 2020 22:24:56 +0800
Message-Id: <20200908142456.89626-1-zangchunxin@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunxin Zang <zangchunxin@bytedance.com>

On our server, there are about 10k memcg in one machine. They use memory
very frequently. When I tigger drop caches，the process will infinite loop
in drop_slab_node.
There are two reasons:
1.We have too many memcgs, even though one object freed in one memcg, the
  sum of object is bigger than 10.
2.We spend a lot of time in traverse memcg once. So, the memcg who
  traversed at the first have been freed many objects. Traverse memcg next
  time, the freed count bigger than 10 again.

We can get the following info through 'ps':

  root:~# ps -aux | grep drop
  root  357956 ... R    Aug25 21119854:55 echo 3 > /proc/sys/vm/drop_caches
  root 1771385 ... R    Aug16 21146421:17 echo 3 > /proc/sys/vm/drop_caches
  root 1986319 ... R    18:56 117:27 echo 3 > /proc/sys/vm/drop_caches
  root 2002148 ... R    Aug24 5720:39 echo 3 > /proc/sys/vm/drop_caches
  root 2564666 ... R    18:59 113:58 echo 3 > /proc/sys/vm/drop_caches
  root 2639347 ... R    Sep03 2383:39 echo 3 > /proc/sys/vm/drop_caches
  root 3904747 ... R    03:35 993:31 echo 3 > /proc/sys/vm/drop_caches
  root 4016780 ... R    Aug21 7882:18 echo 3 > /proc/sys/vm/drop_caches

Use bpftrace follow 'freed' value in drop_slab_node:

  root:~# bpftrace -e 'kprobe:drop_slab_node+70 {@ret=hist(reg("bp")); }'
  Attaching 1 probe...
  ^B^C

  @ret:
  [64, 128)        1 |                                                    |
  [128, 256)      28 |                                                    |
  [256, 512)     107 |@                                                   |
  [512, 1K)      298 |@@@                                                 |
  [1K, 2K)       613 |@@@@@@@                                             |
  [2K, 4K)      4435 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
  [4K, 8K)       442 |@@@@@                                               |
  [8K, 16K)      299 |@@@                                                 |
  [16K, 32K)     100 |@                                                   |
  [32K, 64K)     139 |@                                                   |
  [64K, 128K)     56 |                                                    |
  [128K, 256K)    26 |                                                    |
  [256K, 512K)     2 |                                                    |

In one drop caches action, only traverse memcg once maybe is better.
If user need more memory, they can do drop caches again.

Signed-off-by: Chunxin Zang <zangchunxin@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/vmscan.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b6d84326bdf2..9d8ee2ae5824 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -699,17 +699,12 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 
 void drop_slab_node(int nid)
 {
-	unsigned long freed;
+	struct mem_cgroup *memcg = NULL;
 
+	memcg = mem_cgroup_iter(NULL, NULL, NULL);
 	do {
-		struct mem_cgroup *memcg = NULL;
-
-		freed = 0;
-		memcg = mem_cgroup_iter(NULL, NULL, NULL);
-		do {
-			freed += shrink_slab(GFP_KERNEL, nid, memcg, 0);
-		} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
-	} while (freed > 10);
+		shrink_slab(GFP_KERNEL, nid, memcg, 0);
+	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
 }
 
 void drop_slab(void)
-- 
2.11.0

