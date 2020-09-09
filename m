Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D492C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C515206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="cj5wRTpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbgIIROO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730256AbgIIPai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:30:38 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F846C0619C7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 08:20:58 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l191so2302844pgd.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 08:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nRSn5ntJRj7Oony3O2CA+XH1U2imtO9TR4JjB0ilhXo=;
        b=cj5wRTpKPlMV7QtPieSvF+gBLFmGNSf4JanrLhXcm1B5OrnUUj1J+zxeg1fyofhtf2
         3vBYnuNYVg64VaSiT3R4PNhx9T0xwRvhs40W/XjP+BU96SRg2S4JnuWl6lI1+Qdw8iEX
         AUEVbabpxWiwbvu1/lJ0lWGjPFOvXxMMb9/1R+HPWwajs3QCss1MktD4Y9oTy7B8/mpA
         UUq/uKY2NL58Qg9LHJAUgapV3HJnDZw111zdVw8Bzfk1tPbjzlco3BK3i3UtY27Y9qgd
         DU0MtSjR3ygVRfl7kWJ1iFcl9XC+s9WUR8B232PzYVeIlxC1ysT9H7Re6kDlZYSGP61g
         u61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nRSn5ntJRj7Oony3O2CA+XH1U2imtO9TR4JjB0ilhXo=;
        b=hoLa6Y/wXU2bIxeTJCirG4SSoF2cuVlRJPuQGFW8X9M5165xeBqDI5hMfOdZy9OklO
         8hNOPWUACRUcbte+9+2VOF6LZyfhsM7WcCMZepAFZs4p1+3F5qmbn/8QjITANfQZKeX5
         5MlKhL56CgRxUY4LUj0OpNNtV9a3NXY60wYtrUQBrVfBIQ6x5yQjF+lICenNmzfS5x3P
         i52x074p5UZF/ZNhqsxNyu9Dcrp3gVEcTyw5p0q5U+Vo8Z4lkDmGm+fMfI+aLValcDuy
         bkdaHIaj/FRFynVwYpdRKQW6bV7KQNcLL7KwjAqunpIs8sOambzG/l59ykUcMLElr+K5
         yjKg==
X-Gm-Message-State: AOAM531ZCmM7ehmzqv3D4iZ0w0WfbAn+unJwlfKxcLbNlhe+BA3t4h1y
        vcqw0stUSUs77e42DgeB51tjKg==
X-Google-Smtp-Source: ABdhPJwgUlU/RNTULEXezR/V5cY6SyF8WCPd3zyU4+7r+bNYT6rqiVXWT2Yvv4GBBk3ZzuVSYxpw3g==
X-Received: by 2002:a63:af01:: with SMTP id w1mr1012742pge.23.1599664855461;
        Wed, 09 Sep 2020 08:20:55 -0700 (PDT)
Received: from Zs-MacBook-Pro.local.net ([103.136.221.66])
        by smtp.gmail.com with ESMTPSA id kf10sm2160958pjb.2.2020.09.09.08.20.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Sep 2020 08:20:54 -0700 (PDT)
From:   zangchunxin@bytedance.com
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chunxin Zang <zangchunxin@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] mm/vmscan: fix infinite loop in drop_slab_node
Date:   Wed,  9 Sep 2020 23:20:47 +0800
Message-Id: <20200909152047.27905-1-zangchunxin@bytedance.com>
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

In the while loop, we can check whether the TASK_KILLABLE signal is set,
if so, we should break the loop.

Signed-off-by: Chunxin Zang <zangchunxin@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
	changelogs in v2: 
	1) Via check TASK_KILLABLE signal break loop.

 mm/vmscan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b6d84326bdf2..c3ed8b45d264 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -704,6 +704,9 @@ void drop_slab_node(int nid)
 	do {
 		struct mem_cgroup *memcg = NULL;
 
+		if (fatal_signal_pending(current))
+			return;
+
 		freed = 0;
 		memcg = mem_cgroup_iter(NULL, NULL, NULL);
 		do {
-- 
2.11.0

