Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8037BC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F2FA21D79
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4H+9z7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgDTIBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgDTIBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:01:06 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7C6C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:01:06 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kb16so4229145pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3sIc/9DDAXKMYRBsv64/To7rDNyZRnaOfPvxZnOJWw0=;
        b=W4H+9z7KpXVaJoSsLGidF0McaGPT/JauXtbjVyABdYzu78ZKOjCTK+mQ6b28MkRA9M
         ZcdVu+Gt+H2BiYtsZ9IbBef+c3FdwRJ/VbeMPC9s62wlMA4oY4S8i5JZrRkBUinh05gY
         kBXBV7FFzDJOPUCTfWbO7D+kuk5t7Ch4XYJsaA2GBu6roPdoGq+doypS+LmDGK7t2tFJ
         sYXjv1BUogESKtLi6d7znXOFetnpn0/V00wIlxhx0ZY3XA2DfQpas0L7IePNeYfnYCaT
         fytNPBIoIhh9L5NIJaB0PCCbQOegkEaTSRFddqLQHKLRtn7KoSPmcnJsjJfa7D172psD
         q7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3sIc/9DDAXKMYRBsv64/To7rDNyZRnaOfPvxZnOJWw0=;
        b=f83i7eJRlA9G4aA3rtbhZ5aYdI8dgkXeuRZCSXhGfc4Bxzkw1mVmI3EKcNdpNgI2D9
         dxk81BP9aQBz11/ALp5xIyBc+ci7dtHXJpogNsTFIoI9emxVBd6UiY0PeaPZg/tf5oAv
         S1bI0sj4kw/cwY+V2cs3Vnq05GjN2S7jEeUbNDkjf0pG5SMXQQZ+YmkGIAwtl4onUB2C
         mQRH+OxjLD4jVfYN4VsUaXmoS1HYpJzpITkfOtgoU0SXNuQ8x6Y6LTv+gUy1MoWzEZKd
         i8dplyOR85uzDJcOKVAdOMnAXPMygsRBxmsgCIipx8wbgjxE5NqfgHP8s+7B8+CDH3Gs
         foKw==
X-Gm-Message-State: AGi0PuYd3Yc8SnYWxdIwtXZYD52a12t1NXuVCILCe5K4FVADZWoOV+xA
        2wCvyn49/n4tVYGu5sS8Sa3w3NWHnJI=
X-Google-Smtp-Source: APiQypI/6Iexa+qCAwULiej30HBrZEEGi/rV7BS4Iy8tksx1e9x7E71opNFYjhiSnCXV0czZ53bGtg==
X-Received: by 2002:a17:902:20b:: with SMTP id 11mr14153835plc.209.1587369665788;
        Mon, 20 Apr 2020 01:01:05 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id n9sm314947pjt.29.2020.04.20.01.01.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 01:01:05 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Laura Abbott <labbott@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH 09/10] mm/page_alloc: correct the use of is_highmem_idx()
Date:   Mon, 20 Apr 2020 16:59:41 +0900
Message-Id: <1587369582-3882-10-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587369582-3882-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1587369582-3882-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

What we'd like to check here is whether page has direct mapping or not.
Use PageHighMem() since it is perfectly matched for this purpose.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9997f87..e07148d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1399,7 +1399,7 @@ static void __meminit __init_single_page(struct page *page, unsigned long pfn,
 	INIT_LIST_HEAD(&page->lru);
 #ifdef WANT_PAGE_VIRTUAL
 	/* The shift won't overflow because ZONE_NORMAL is below 4G. */
-	if (!is_highmem_idx(zone))
+	if (!PageHighMem(page))
 		set_page_address(page, __va(pfn << PAGE_SHIFT));
 #endif
 }
-- 
2.7.4

