Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E201AC35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857D820CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="P184IGeA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbgBYQzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:55:37 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37473 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgBYQzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:55:36 -0500
Received: by mail-qt1-f194.google.com with SMTP id j34so130376qtk.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 08:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=eI480rA4BDfxWyGgJwW8aPuYxCTO0HnuLE75vGul/Xs=;
        b=P184IGeAqAXRM6R0OEhOJISQRtMWwb9pZ+9c1oAjp2YYR6Dp+uD6ARuWbBtHGOZr2J
         vK6M4D6AzZC47x9J9h3G0MuW3tXDh+CWptXiLd+VP81+pxlCGywMqrhqyhm9rPX9LImG
         mNZaRu+T1/sHzEsctNZT4TQZ34JL0gnGDh60xKlsJpFyfyvfVU1n/MqSHFQdDVCOV8lc
         UNFv8f7ymvtvvvb101XFzxusbA2Oed3oEMx+3QjgkoJJeL5yyx7fpX6DCmCoYicsBAEK
         IEjLhNX56qFDHYUOi43NZuecSd1k0uDwfEaebDtDS06hVuWSB66CVTtRZhS/44GYjC9u
         /FcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eI480rA4BDfxWyGgJwW8aPuYxCTO0HnuLE75vGul/Xs=;
        b=HeHIlK4VTJwWlX9VXW2BOcSyZsy2dSdEGFstcjSWUir/6mqK6JvAHlfHdpZBRgcvzF
         sBb/e7MVHeuaoDbU5zD6Q5Wh/xbCiSxJoULAlGTOs1nh3JpQwj+MdmJu4rD7PvMZ2nbi
         FSsZC02iVEHWOEiTw90VkQtLmqT1fwGY5AlanUq+S6zintJGvb+1LzkEK4M3dFWqf+6u
         zuZrzOWekUIwkqcMcn6etH8qJpOIK3OqWr5phDG58SJy45V1u9lYPUHBWhZq2IRqslQc
         4ag7Vf0zOaohljLIKFokEE8A3tNQ5//P8ATedqZco6PugfKLpwGvBK5q0Gg9Kc8YePub
         oTMA==
X-Gm-Message-State: APjAAAWSxh7EXY43WcFx+rN0moaNpbHxEtFftsaH6aNTq9iEaEZE4nll
        xn0R+aUwuCJF2rfcsHTlBY1prA==
X-Google-Smtp-Source: APXvYqy1XlyOCJvt2qv6r7oiMMhi6kuONC5iyE5pEOGafBPuUCN+6TpPX1LQbN0UxPaL4BYZySjpYg==
X-Received: by 2002:ac8:6046:: with SMTP id k6mr56995736qtm.357.1582649735740;
        Tue, 25 Feb 2020 08:55:35 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 131sm2743238qkl.86.2020.02.25.08.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 08:55:35 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     elver@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/vmscan: fix data races at kswapd_classzone_idx
Date:   Tue, 25 Feb 2020 11:55:26 -0500
Message-Id: <1582649726-15474-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pgdat->kswapd_classzone_idx could be accessed concurrently in
wakeup_kswapd(). Plain writes and reads without any lock protection
result in data races. Fix them by adding a pair of READ|WRITE_ONCE() as
well as saving a branch (compilers might well optimize the original code
in an unintentional way anyway). The data races were reported by KCSAN,

 BUG: KCSAN: data-race in wakeup_kswapd / wakeup_kswapd

 write to 0xffff9f427ffff2dc of 4 bytes by task 7454 on cpu 13:
  wakeup_kswapd+0xf1/0x400
  wakeup_kswapd at mm/vmscan.c:3967
  wake_all_kswapds+0x59/0xc0
  wake_all_kswapds at mm/page_alloc.c:4241
  __alloc_pages_slowpath+0xdcc/0x1290
  __alloc_pages_slowpath at mm/page_alloc.c:4512
  __alloc_pages_nodemask+0x3bb/0x450
  alloc_pages_vma+0x8a/0x2c0
  do_anonymous_page+0x16e/0x6f0
  __handle_mm_fault+0xcd5/0xd40
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

 1 lock held by mtest01/7454:
  #0: ffff9f425afe8808 (&mm->mmap_sem#2){++++}, at:
 do_page_fault+0x143/0x6f9
 do_user_addr_fault at arch/x86/mm/fault.c:1405
 (inlined by) do_page_fault at arch/x86/mm/fault.c:1539
 irq event stamp: 6944085
 count_memcg_event_mm+0x1a6/0x270
 count_memcg_event_mm+0x119/0x270
 __do_softirq+0x34c/0x57c
 irq_exit+0xa2/0xc0

 read to 0xffff9f427ffff2dc of 4 bytes by task 7472 on cpu 38:
  wakeup_kswapd+0xc8/0x400
  wake_all_kswapds+0x59/0xc0
  __alloc_pages_slowpath+0xdcc/0x1290
  __alloc_pages_nodemask+0x3bb/0x450
  alloc_pages_vma+0x8a/0x2c0
  do_anonymous_page+0x16e/0x6f0
  __handle_mm_fault+0xcd5/0xd40
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

 1 lock held by mtest01/7472:
  #0: ffff9f425a9ac148 (&mm->mmap_sem#2){++++}, at:
 do_page_fault+0x143/0x6f9
 irq event stamp: 6793561
 count_memcg_event_mm+0x1a6/0x270
 count_memcg_event_mm+0x119/0x270
 __do_softirq+0x34c/0x57c
 irq_exit+0xa2/0xc0

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/vmscan.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 876370565455..400950734e5a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3961,11 +3961,10 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 		return;
 	pgdat = zone->zone_pgdat;
 
-	if (pgdat->kswapd_classzone_idx == MAX_NR_ZONES)
-		pgdat->kswapd_classzone_idx = classzone_idx;
-	else
-		pgdat->kswapd_classzone_idx = max(pgdat->kswapd_classzone_idx,
-						  classzone_idx);
+	if (READ_ONCE(pgdat->kswapd_classzone_idx) == MAX_NR_ZONES ||
+	    READ_ONCE(pgdat->kswapd_classzone_idx) < classzone_idx)
+		WRITE_ONCE(pgdat->kswapd_classzone_idx, classzone_idx);
+
 	pgdat->kswapd_order = max(pgdat->kswapd_order, order);
 	if (!waitqueue_active(&pgdat->kswapd_wait))
 		return;
-- 
1.8.3.1

