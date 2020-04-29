Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71F8C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CD9D20775
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7xH1293"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgD2D1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726792AbgD2D1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:27:41 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5149C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:27:40 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n16so364499pgb.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jN6OWGZfzhz5cy8NH2EykEDo9H91RlV0Cb10AXbRh+4=;
        b=X7xH1293dienMFUF4Cx9EMFvcB0WqWvKSdXLSakGPz9VAaJgR5Rp27zddaF/mgBDWJ
         jueccWhjSMYdgmbHtRyzWn7s3QmL+K7gxIsAWZdL/KoIlDZICUr1kKmqxW8pBuvLxo3M
         hMm9lL77QLGsa5xpvuGlaOin3uwvSqolrCIiw4WVLuakiZNZBeg/nQEMNYhlcbw3OJVd
         62Ukj+wbkKaaSNlrnnexEedfYZDoAp5dmdkltB9GFzrEnQiv0H720MbDH2oOUTsX/FIb
         l9EwFJu7W8HYh/UIqUDaR5FvacZnO6I7X5qH7gzSiye3TYD7Jwk+dBBJlk+/rKxG52s3
         NieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jN6OWGZfzhz5cy8NH2EykEDo9H91RlV0Cb10AXbRh+4=;
        b=f3/48OjhIZ9XTAH/8yG+yuwc3LkzdK2CSlM7qMeBpqeRPYYqJQeuUh2sNxJHL8CXpq
         4xxynKcaLTL2MccmerlUUniMJx4KrDHtsMOihQPLhqYpCfaR19vdu0U5lSZDGg6C0Dmk
         0P8wpNG6kgUj3y+ltw1z/J6tKtcg2fdvEyn4HjFNvVxU+8BTnRpY1+nvHfhQy/xhWzhz
         TMpKO5oZf9rgeMTP3kxriehB5UQ8YsdDufc+mf8ly5Siz1rHQCshxjYj+Vt3SJ9Vynxg
         Vqx8ebHeGFkr6IzvrhJf7BZ2deavjGHCdLdQSQT8RAtntdV/ZwUHEIounuYfIFCpntZm
         hnQw==
X-Gm-Message-State: AGi0PuZKg+yI8/U+hobuDSF6tIp74v7Ts1UXzN9PshFGPeCT6lgXSPZW
        SM0kykrNGi9peSlJtdU4jeE=
X-Google-Smtp-Source: APiQypInVbH7ylHMhU07Tfmqu8yaakpX3/HbtkY8RGK6W+4l2MkEeAn29ptQFf/Lvq2iASEnh+35qw==
X-Received: by 2002:a62:e113:: with SMTP id q19mr32206900pfh.107.1588130859931;
        Tue, 28 Apr 2020 20:27:39 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id q11sm9559796pfl.97.2020.04.28.20.27.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 20:27:39 -0700 (PDT)
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
        Pavel Machek <pavel@ucw.cz>, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v2 08/10] mm/page_alloc: correct the use of is_highmem_idx()
Date:   Wed, 29 Apr 2020 12:26:41 +0900
Message-Id: <1588130803-20527-9-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

What we'd like to check here is whether page has direct mapping or not.
Use PageHighMem() since it is perfectly matched for this purpose.

Acked-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7fe5115..da473c7 100644
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

