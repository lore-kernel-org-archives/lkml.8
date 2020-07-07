Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7A9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6918620708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCudhXV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgGGHp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgGGHp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:45:27 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260F3C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 00:45:27 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w2so18815932pgg.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 00:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ktEVs8Hqf991Zw2ArJoEaKXQpHVgkoYtcCgWjEGUnPA=;
        b=bCudhXV2TzMRpdKEib0op4Bt1pN4XyWefDsWoE0tYUAf4gkc81psR8GAUTwgJJRAJv
         thHfe6n8q2aCG+nNXI2nzD7uRDNnN/OA8SOvjSeQj+iL94vLPSZk4ONTQTFMzp+k1biU
         /t3G2ZqdZhhE3VAKwLBBGhv7YRqJMdDo7UOKJQVBDYUoCW4YvjpDsovPbpcAa8hFUuC3
         /0Z6/m68F6DqhNf5tZuJ6GIuFeqg9lFHLMTnxVGqJl4dVRhoID6u34VcGT/ZzlB8fFsa
         Vpz9G0PMMSH7a7enbL0XdW14UF28HegZGy7SYA0A5hJS9VizcDYiNGvaM0gBHN+FMDZA
         aiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ktEVs8Hqf991Zw2ArJoEaKXQpHVgkoYtcCgWjEGUnPA=;
        b=Lb+Su1Dbk+cUKHYxS3knwhHgAIMMNqE/LJYjviz6Kx7VMLRw4jL7X2Fvh+Z5Fqp/fX
         hIaD5jOtHnR8uq1nG4b8HPqz2QnbTnFhhtubKO2LfpIw8O18vfH+af/PtenPGvDGAdmN
         NWVTx15g5Uteo/GS7RPoox97tOj0vtW1VqyVMmMm/E8G2vPxa9tmvj4ics3JM01dmelK
         TR8JUoEQCkZaMtZSEcj8dFRedz4ilUAfqZKx8tiq5ZH9qu33k1hRcMrHLaPZzqKK/2Gn
         ovBuRaWZcNjekjPE8rJrfIxZsc6g7XoRG3xRNs0JR14O6Bj7GNiN5TWDoR7doEmT+YIQ
         vh4g==
X-Gm-Message-State: AOAM531PoXx7NujgYgrFFjV4ssoceNCq+ezefHpOhM/DV5yvIbNbu9Sp
        DPCrVxYBfcZk1G1dlOdYcSQ=
X-Google-Smtp-Source: ABdhPJyeoOTD1Nw+9ZWQrMNZq3+EUZHWgPrHfwthTufo+Dtl4PXEZE+ujykdKKimw15qkv8P1+4o3Q==
X-Received: by 2002:a65:6150:: with SMTP id o16mr28727781pgv.237.1594107926731;
        Tue, 07 Jul 2020 00:45:26 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id 191sm21330151pfw.150.2020.07.07.00.45.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 00:45:26 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v4 05/11] mm/migrate: clear __GFP_RECLAIM for THP allocation for migration
Date:   Tue,  7 Jul 2020 16:44:43 +0900
Message-Id: <1594107889-32228-6-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

In mm/migrate.c, THP allocation for migration is called with the provided
gfp_mask | GFP_TRANSHUGE. This gfp_mask contains __GFP_RECLAIM and it
would be conflict with the intention of the GFP_TRANSHUGE.

GFP_TRANSHUGE/GFP_TRANSHUGE_LIGHT is introduced to control the reclaim
behaviour by well defined manner since overhead of THP allocation is
quite large and the whole system could suffer from it. So, they deals
with __GFP_RECLAIM mask deliberately. If gfp_mask contains __GFP_RECLAIM
and uses gfp_mask | GFP_TRANSHUGE(_LIGHT) for THP allocation, it means
that it breaks the purpose of the GFP_TRANSHUGE(_LIGHT).

This patch fixes this situation by clearing __GFP_RECLAIM in provided
gfp_mask. Note that there are some other THP allocations for migration
and they just uses GFP_TRANSHUGE(_LIGHT) directly. This patch would make
all THP allocation for migration consistent.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/migrate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 02b31fe..ecd7615 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1547,6 +1547,11 @@ struct page *new_page_nodemask(struct page *page,
 	}
 
 	if (PageTransHuge(page)) {
+		/*
+		 * clear __GFP_RECALIM since GFP_TRANSHUGE is the gfp_mask
+		 * that chooses the reclaim masks deliberately.
+		 */
+		gfp_mask &= ~__GFP_RECLAIM;
 		gfp_mask |= GFP_TRANSHUGE;
 		order = HPAGE_PMD_ORDER;
 	}
-- 
2.7.4

