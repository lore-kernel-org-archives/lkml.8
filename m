Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B26C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 22:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C67520720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 22:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ASbWDq92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgBGW2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 17:28:31 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:39030 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgBGW2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 17:28:31 -0500
Received: by mail-qv1-f65.google.com with SMTP id y8so379159qvk.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 14:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OxQxNArYNGHpxlZi9BnAGnVmegvkSAJw3+w836VhUe8=;
        b=ASbWDq926fcNVDgknBiKGTLT42W+QI+Bhd1PCULk+mNsfdo/lBFhXkzzGUSgFBul0l
         SCk7Z1XE0kp7iIqvq795oi6i3XbnxbpY+uRL2kzWMbIR4DPBPDlMG++8MUH1ooCcgQfe
         rNx4yhIqbwaFJXgFai46dnd8JV2YiiATTWKKlA7vKNxLFGoR51A915fQq9pnuOKWXqEn
         L+yS+4Q9SbJ17a+8SUGmObjkiz0y8WXEgkjjlUy2Cacz1TjVghdMXCrZU76qUuxy/0fs
         NKPR6WBxfQlHBEw0VdinYwK474DegWIzNzjRY5vrXSCZ8uVkk3RcwOBywjrvcJyQy6q+
         1mfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OxQxNArYNGHpxlZi9BnAGnVmegvkSAJw3+w836VhUe8=;
        b=sKv2v5i4UgxNgJfZCA4FK8GyJWFCoEhbia+ic7av4cYP1oqrRcgXh5OF7Vd+Z6+03x
         CyCRirvU9EMmJSuYsmNpiaKtIyDdQtMa1So7enX8MApc9WoE921xs2t+YdAMjAYaZ1kF
         B0VZ21n6Ta1xGDLhXu9Ex0UmxDZNfs4c0ZDGboOkfe77sSCdBC8NUtI6/peCsM4Dcni5
         VIiuy0hEKw1EmQugPxkb3Kwe3TsAA9wHyY1XNq1AumvgvcqYigIX1RXwhj/wjFKv517S
         o/U3GdFXcJltyakEDFvRR9iDrgD62DHHmiO+kJIW2s31y56qSE3ZhE6P2/jOkv6IO94o
         3t9Q==
X-Gm-Message-State: APjAAAWjL7o9d0f8kkgRpj6JcQhqZneR+Gpy2uiV/rMMKJ5qqxCExumm
        JI1DXAGDHflE/BL+f58RvQlK2g==
X-Google-Smtp-Source: APXvYqxOpuzZM75vVh/9zkcSZT2/zmScqzOM99CS1VWNVJEmwPbEM+pRONR/TXf05XkUuV5C+eDAEw==
X-Received: by 2002:ad4:50d2:: with SMTP id e18mr581284qvq.9.1581114509926;
        Fri, 07 Feb 2020 14:28:29 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j206sm2001762qke.54.2020.02.07.14.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Feb 2020 14:28:29 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     konrad.wilk@oracle.com, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/frontswap: mark various intentional data races
Date:   Fri,  7 Feb 2020 17:28:19 -0500
Message-Id: <1581114499-5042-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few information counters that are intentionally not
protected against increment races, so just annotate them using the
data_race() macro.

 BUG: KCSAN: data-race in __frontswap_store / __frontswap_store

 write to 0xffffffff8b7174d8 of 8 bytes by task 6396 on cpu 103:
  __frontswap_store+0x2d0/0x344
  inc_frontswap_failed_stores at mm/frontswap.c:70
  (inlined by) __frontswap_store at mm/frontswap.c:280
  swap_writepage+0x83/0xf0
  pageout+0x33e/0xae0
  shrink_page_list+0x1f57/0x2870
  shrink_inactive_list+0x316/0x880
  shrink_lruvec+0x8dc/0x1380
  shrink_node+0x317/0xd80
  do_try_to_free_pages+0x1f7/0xa10
  try_to_free_pages+0x26c/0x5e0
  __alloc_pages_slowpath+0x458/0x1290
  __alloc_pages_nodemask+0x3bb/0x450
  alloc_pages_vma+0x8a/0x2c0
  do_anonymous_page+0x170/0x700
  __handle_mm_fault+0xc9f/0xd00
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

 read to 0xffffffff8b7174d8 of 8 bytes by task 6405 on cpu 47:
  __frontswap_store+0x2b9/0x344
  inc_frontswap_failed_stores at mm/frontswap.c:70
  (inlined by) __frontswap_store at mm/frontswap.c:280
  swap_writepage+0x83/0xf0
  pageout+0x33e/0xae0
  shrink_page_list+0x1f57/0x2870
  shrink_inactive_list+0x316/0x880
  shrink_lruvec+0x8dc/0x1380
  shrink_node+0x317/0xd80
  do_try_to_free_pages+0x1f7/0xa10
  try_to_free_pages+0x26c/0x5e0
  __alloc_pages_slowpath+0x458/0x1290
  __alloc_pages_nodemask+0x3bb/0x450
  alloc_pages_vma+0x8a/0x2c0
  do_anonymous_page+0x170/0x700
  __handle_mm_fault+0xc9f/0xd00
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/frontswap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/frontswap.c b/mm/frontswap.c
index 60bb20e8a951..b8c14f298332 100644
--- a/mm/frontswap.c
+++ b/mm/frontswap.c
@@ -61,16 +61,16 @@
 static u64 frontswap_invalidates;
 
 static inline void inc_frontswap_loads(void) {
-	frontswap_loads++;
+	data_race(frontswap_loads++);
 }
 static inline void inc_frontswap_succ_stores(void) {
-	frontswap_succ_stores++;
+	data_race(frontswap_succ_stores++);
 }
 static inline void inc_frontswap_failed_stores(void) {
-	frontswap_failed_stores++;
+	data_race(frontswap_failed_stores++);
 }
 static inline void inc_frontswap_invalidates(void) {
-	frontswap_invalidates++;
+	data_race(frontswap_invalidates++);
 }
 #else
 static inline void inc_frontswap_loads(void) { }
-- 
1.8.3.1

