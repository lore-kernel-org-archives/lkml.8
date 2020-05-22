Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53823C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149462067B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="KYd0PX4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbgEVWBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 18:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731051AbgEVWBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 18:01:00 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31844C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 15:01:00 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i68so9551712qtb.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 15:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=10xIm5fncIXTs+8aKLuQ1M1AKRKIiBtDH2Kwrtxe3vk=;
        b=KYd0PX4BCgPJBoMn5rg6a6JKfTSr5tMioYWB4m+DyUPzsNlwtVBHeTUq+/PnrpNr+H
         hAeMviNhJYleT/l2iVlSNIgDs+NEebH6Jj5Xc5XTHXSCqNcKi1CDIpUzL4XRdZkBBtq3
         Mu1QtgvP87d5nURzQyJzeGFGsR9LWHGRAd4/Y4RwUEszqnvoP6qv26Lb+s023Xit3Du2
         kJtybt81QGK+xBjTaQ1vnfWHX5C/c5Q6B7FIwYZXJAAlUmc+U7qKsbNXk/Ftj2NLl0Sq
         z/aG3s3ibjomOEphQhtLX100S4BxGDSaAT/iuBnSAG8W6SjSxk9/Kb6ZxkftzKttoWa6
         3iKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=10xIm5fncIXTs+8aKLuQ1M1AKRKIiBtDH2Kwrtxe3vk=;
        b=Xd4kMuqc+Aub+k0eL4KLY4JyIyQoo7wmdGD+s8rsnpJ2YF6QOxO61w5YqGLECrO3ds
         qrQZDSioOe9uOg8Onj91RvgQTpM+11uIfxwmtAYM1X6kh5bvsiSAVvR9nbDAOTI2rKyN
         ukVd1lyRCkqzexAHMucWRFgwup/fuHJEHn09IWz8tCwHgl/6PiHPPxlUpuA26j6G1fLr
         8oyUhPial4WvvQWZ+xQIp7lzCv2BK5yXmOKI3/3M7cY+KBc1do4dB5VRqYdYi9RSaWmz
         ImmULwkGpTA4ziirBunh4WK4fD1RA5b87H7kiUClmp6/Gw66kN9a9YNwYHXOs+LG1Gmw
         tFEg==
X-Gm-Message-State: AOAM533HddGLF7HU9Fk8wTXKRK6BZ8IpcyiZ4IQpDHORjr8FaJb+tBpR
        c1yfOyXKSrRTl1eJ0dD03u662w==
X-Google-Smtp-Source: ABdhPJwoaiRms7NFGc/UnbOLVezIN+LVSc/v90svlD+scJT9r+MwzwIx6csJs9jfgAd0mDtjcYgAEw==
X-Received: by 2002:aed:37ca:: with SMTP id j68mr18080791qtb.276.1590184858499;
        Fri, 22 May 2020 15:00:58 -0700 (PDT)
Received: from localhost.localdomain (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x2sm4315313qke.42.2020.05.22.15.00.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 May 2020 15:00:57 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     vitaly.wool@konsulko.com, catalin.marinas@arm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/z3fold: silence kmemleak false positives of slots
Date:   Fri, 22 May 2020 18:00:52 -0400
Message-Id: <20200522220052.2225-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kmemleak reported many leaks while under memory pressue in,

slots = alloc_slots(pool, gfp);

which is referenced by "zhdr" in init_z3fold_page(),

zhdr->slots = slots;

However, "zhdr" could be gone without freeing slots as the later will be
freed separately when the last "handle" off of "handles" array is freed. It
will be within "slots" which is always aligned.

unreferenced object 0xc000000fdadc1040 (size 104):
  comm "oom04", pid 140476, jiffies 4295359280 (age 3454.970s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000d1f0f5eb>] z3fold_zpool_malloc+0x7b0/0xe10
    alloc_slots at mm/z3fold.c:214
    (inlined by) init_z3fold_page at mm/z3fold.c:412
    (inlined by) z3fold_alloc at mm/z3fold.c:1161
    (inlined by) z3fold_zpool_malloc at mm/z3fold.c:1735
    [<0000000064a2e969>] zpool_malloc+0x34/0x50
    [<00000000af63e491>] zswap_frontswap_store+0x60c/0xda0
    zswap_frontswap_store at mm/zswap.c:1093
    [<00000000af5e07e0>] __frontswap_store+0x128/0x330
    [<00000000de2f582b>] swap_writepage+0x58/0x110
    [<000000000120885f>] pageout+0x16c/0xa40
    [<00000000444c1f68>] shrink_page_list+0x1ac8/0x25c0
    [<00000000d19e8610>] shrink_inactive_list+0x270/0x730
    [<00000000e17df726>] shrink_lruvec+0x444/0xf30
    [<000000005f02ab35>] shrink_node+0x2a4/0x9c0
    [<00000000014cabbd>] do_try_to_free_pages+0x158/0x640
    [<00000000dcfaba07>] try_to_free_pages+0x1bc/0x5f0
    [<00000000fa207ab8>] __alloc_pages_slowpath.constprop.60+0x4dc/0x15a0
    [<000000003669f1d2>] __alloc_pages_nodemask+0x520/0x650
    [<0000000011fa4168>] alloc_pages_vma+0xc0/0x420
    [<0000000098b376f2>] handle_mm_fault+0x1174/0x1bf0

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/z3fold.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 8c3bb5e508b8..460b0feced26 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -43,6 +43,7 @@
 #include <linux/spinlock.h>
 #include <linux/zpool.h>
 #include <linux/magic.h>
+#include <linux/kmemleak.h>
 
 /*
  * NCHUNKS_ORDER determines the internal allocation granularity, effectively
@@ -215,6 +216,8 @@ static inline struct z3fold_buddy_slots *alloc_slots(struct z3fold_pool *pool,
 				 (gfp & ~(__GFP_HIGHMEM | __GFP_MOVABLE)));
 
 	if (slots) {
+		/* It will be freed separately in free_handle(). */
+		kmemleak_not_leak(slots);
 		memset(slots->slot, 0, sizeof(slots->slot));
 		slots->pool = (unsigned long)pool;
 		rwlock_init(&slots->lock);
-- 
2.17.2 (Apple Git-113)

