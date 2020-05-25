Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2A4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 22:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BDBD2075F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 22:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3y125lY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389305AbgEYWQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 18:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgEYWQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 18:16:16 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123DEC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 15:16:16 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so7865750plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 15:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eSpEFVbG8JUdSrBIflNKicdqqYEQz8d5l9KuD7qZZcM=;
        b=O3y125lYcfZznF8AdnHsBuu/pezAvAh4K/OW3m8ETYoqnVQqxBeNIYO5FvhJmamZKE
         483QrLedr8lgEJr5C7+miL2JM8u5iyi1FB6qb949HD5ZZM5yF+Um7SkUE+82nlHfkRR0
         4R+vASNN8jyTIZGeNmSy+nIz8otmu1TA7pMCiRRUglkZJoSfNSUKcrgZRVZbrPZPq0tZ
         V1KjfzJDc0CmyQ1NyoNwuDTJZXWZwSWKdEoYu6eSRwaqnO7EJwLtzyUH7jCMNvFzjGj1
         AU7RIOb1zFoRY4h2IygAuvvQQkEilsyBHcQrCd2JhGh9Gl6m19tw96kHWe2KJtMR6zJq
         +eNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eSpEFVbG8JUdSrBIflNKicdqqYEQz8d5l9KuD7qZZcM=;
        b=gTKHechZy4jco5wMHCXi4G+/VFW5LEyIG3O7FUmRvIQ0B1UTFJTdQWBlfYjWlYxlEq
         PMmDk965/U1ivHmTVTc7sqEA42ayDxvpj/FResNoU/gNEmTjXdVPF+TPDHWwsuEbKsPh
         cZKOBJaXyJg+SW9NGnEyzf7cqmystadz3L0TBMEu9FXOMRZlv7jTI7NezZkl7fcxbQv5
         A86yT5/PLhBeznKBbf46YsnekAs5lIlP8pVA+OyHFIlmPBYulhg1KabsrxxpT8/Yv6Yk
         QPFgemHCvhxb8DGcYE4Nq31lG/G8Pw7ZUnd15ppK6/52caljPGGX+rwoCC5qFTrv3sfu
         0PTg==
X-Gm-Message-State: AOAM530OcfnZoTHd/2j0qsrMUTFCKfkFalVQxs9qrbfKY2PxBrr8rXDI
        2Brfr7s10bUCvyKYsLqVSqE=
X-Google-Smtp-Source: ABdhPJzQ3P0vqWJRY6AQI6xSDmGSBZjsIw41fa3CVPrEXXshOerRfEW4ULTGkJlQo+SAqILMhumhhA==
X-Received: by 2002:a17:90a:bf92:: with SMTP id d18mr9741928pjs.120.1590444975572;
        Mon, 25 May 2020 15:16:15 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:400:e00:7571:e536:944d:12bc])
        by smtp.gmail.com with ESMTPSA id z13sm14160865pfj.153.2020.05.25.15.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 15:16:15 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: fix flush_icache_user_range in noMMU configs
Date:   Mon, 25 May 2020 15:15:56 -0700
Message-Id: <20200525221556.4270-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flush_icache_user_range definition for xtensa is placed under
preprocessor condition that is not processed in noMMU configurations,
resulting in the following build errors:

  fs/exec.c:1065:3: error: implicit declaration of function
  ‘flush_icache_user_range’
  fs/binfmt_flat.c:857:2: error: implicit declaration of function
  ‘flush_icache_user_range’

Move definition outside conditional compilation block.

Fixes: 134d96d05d30 ("xtensa: implement flush_icache_user_range")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/cacheflush.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/include/asm/cacheflush.h b/arch/xtensa/include/asm/cacheflush.h
index 460e666ad076..cf907e5bf2f2 100644
--- a/arch/xtensa/include/asm/cacheflush.h
+++ b/arch/xtensa/include/asm/cacheflush.h
@@ -107,8 +107,6 @@ void flush_cache_page(struct vm_area_struct*,
 #define flush_cache_page  local_flush_cache_page
 #endif
 
-#define flush_icache_user_range flush_icache_range
-
 #define local_flush_cache_all()						\
 	do {								\
 		__flush_invalidate_dcache_all();			\
@@ -147,6 +145,8 @@ void local_flush_cache_page(struct vm_area_struct *vma,
 
 #endif
 
+#define flush_icache_user_range flush_icache_range
+
 /* Ensure consistency between data and instruction cache. */
 #define local_flush_icache_range(start, end)				\
 	do {								\
-- 
2.20.1

