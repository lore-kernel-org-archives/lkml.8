Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7ECC83001
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C772082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSiiNusd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgD2D10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726508AbgD2D10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:27:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E38C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:27:25 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a7so210131pju.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I0oqOMj56XIKW63HotLmokAMCg2A69VeVE+VeYYlJqg=;
        b=sSiiNusdHjtGcx9VfYZIVguqdiKCZ0+BasEaW5yOJTOTyDh4u8YL1ORr4G9qIJUxbo
         nSvYaxGLxDFyxIH53CVrltoeGcYiiFhjaLdfXIVeGSwZQWdfZLfS0j+gwW+wpaInAorF
         ngzmAjj764tUNH68D5quXiqyAfW6Ynny7Y1Y+IpzwokcK10DYqu/bqupN5W17IDaTwbt
         sHdGr70UYcd0PEeTiS0B6SotKHEBWri6+HImnnFZCjEOeqR6w7E06axV4L4kg7GSfdac
         NQcuOGfEm2VmhkaOhhvyc4qmJe89cDPAli+T56cJQ/YL5ODp4K4MePS+6DTZ1jWmfRje
         Z5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I0oqOMj56XIKW63HotLmokAMCg2A69VeVE+VeYYlJqg=;
        b=G5slBkC3oUiRjM5jFGdtL5isrJmm9kIrOc66yTxjn+lBQQvxlWOGl1B5tcG+x50xTy
         kid9Yys2fy74kV2zLXjLHutaKqKS3e3u0kyDPZeW111J/I8A1V935gmcgAEEyrdJk95u
         lsl4MfBGv98ST+uvWnTKZYQy5z3ipH7zLHdK6ibqn9zZS5LjUoK0oe283+pxENMH4xMD
         5Ckezgr9Ca5YCl74BcfVIVwYIwX6VwAknZIjR2ptYpqe7kFyov/ou4Ws2OAvolvpGdmg
         axMYn5+MkiNVmWzhJZZcj8br5T952B43SlAw12OkMTCDSVRHHXY2gFSpE8UNqAQAWbgG
         y4ww==
X-Gm-Message-State: AGi0PuZkFyH+spoeZsCqcU/c1MeiTcXoxzkq5ucroh+YmTCJ+WnhHmbt
        y5UK5lh1hNLPo0BVJwt+Vsw=
X-Google-Smtp-Source: APiQypJ4M3fjAxtASvxWVCQ/MQVKg3iL+P6Y3uu3OuaLllA7y3piEPYMI/B3S1mfESsnTnFFOXzVUg==
X-Received: by 2002:a17:902:bc86:: with SMTP id bb6mr17376253plb.243.1588130845146;
        Tue, 28 Apr 2020 20:27:25 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id q11sm9559796pfl.97.2020.04.28.20.27.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 20:27:24 -0700 (PDT)
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
Subject: [PATCH v2 05/10] mm/gup: separate PageHighMem() and PageHighMemZone() use case
Date:   Wed, 29 Apr 2020 12:26:38 +0900
Message-Id: <1588130803-20527-6-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Until now, PageHighMem() is used for two different cases. One is to check
if there is a direct mapping for this page or not. The other is to check
the zone of this page, that is, weather it is the highmem type zone or not.

Now, we have separate functions, PageHighMem() and PageHighMemZone() for
each cases. Use appropriate one.

Note that there are some rules to determine the proper macro.

1. If PageHighMem() is called for checking if the direct mapping exists
or not, use PageHighMem().
2. If PageHighMem() is used to predict the previous gfp_flags for
this page, use PageHighMemZone(). The zone of the page is related to
the gfp_flags.
3. If purpose of calling PageHighMem() is to count highmem page and
to interact with the system by using this count, use PageHighMemZone().
This counter is usually used to calculate the available memory for an
kernel allocation and pages on the highmem zone cannot be available
for an kernel allocation.
4. Otherwise, use PageHighMemZone(). It's safe since it's implementation
is just copy of the previous PageHighMem() implementation and won't
be changed.

I apply the rule #2 for this patch.

Acked-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 11fda53..9652eed 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1608,7 +1608,7 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
 	 */
 	gfp_t gfp_mask = GFP_USER | __GFP_NOWARN;
 
-	if (PageHighMem(page))
+	if (PageHighMemZone(page))
 		gfp_mask |= __GFP_HIGHMEM;
 
 #ifdef CONFIG_HUGETLB_PAGE
-- 
2.7.4

