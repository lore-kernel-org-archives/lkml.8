Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20A7C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1BD52082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyaUIW/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgD2D1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726508AbgD2D1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:27:15 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86E5C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:27:15 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a31so209910pje.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dDZ1MgpmhJ05Zf8jhPCyAD6OUKmqbz/zL2ik7cD9hVA=;
        b=XyaUIW/R1YgoWjppehedCHz7ersMbBGxynOYTQO4mdAbWylRcXcgm9rAc3l8H9jwTt
         Q0ZMYyVifmbLC3MrPLvU+d5sYUwjiOJHmD7InEFGJ3bb52c7d+Sz/vop+GDBx2SYmFcz
         2b5PlQCKHq2H0QrFfDTDp/9IFPb+Vc/3mi3pvZQ1ouZ18g3z2esZ/UMf84WZphqQIIwG
         ujJqUEx2InMv4DESByAlMLJ7LVGRql3PDtdOu7dlIzaX4fjMTU+WQkkMJtyKKDRl7J/3
         N9T1oTPbCGbF3BKNUcRPZR33JCrGfQyUHCB4AUurlaBxiC+ykJxPTyw2RHsrK7NTk+HW
         TH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dDZ1MgpmhJ05Zf8jhPCyAD6OUKmqbz/zL2ik7cD9hVA=;
        b=jQnWzxwnJ7DCpB1kVB+w3YNJ4Vqo2aPRxgemCJ9PldRt5N5E9dp1rR1lqb+KykWYeR
         FBTYVK8sKwTpm+8d2W7N5KouRYMb1vGQMSXP1U0h9orhdzHh9mcVtOzBa5C22N8Mju/D
         Rkm9G8YRhBW7D9bTnlZbyB6aHyxOJvKPOOnSS8I9XONGXbqVbxVhr8BU6adMpmVKuWj4
         5VeaDIkOOASYdGMqR1DpyZdsuUCl2N6FnTWHWSpS11s4UrJt4TJSZZfWr1BR3i0Ja7dg
         FT5nhZ8TpnArn2qfTYb5woCvpVFBhprbT+CVrP+f1A4IW2knXAT9FYjMxpWbAqviEb2O
         mBrQ==
X-Gm-Message-State: AGi0PubucE6sjoINk//9L6ezsjdOLIFnHSL2GzQCao9YmZEqnmEznb3V
        7SYKVKtalcG80ptR4mlb0nU=
X-Google-Smtp-Source: APiQypIRlTvB9SPWsgtNua1iaxMRY446Rpmb6K2vJAYeZWRp53SGoJPF0UpH2ZcmKgC5V5cCmAXFxA==
X-Received: by 2002:a17:90a:cb09:: with SMTP id z9mr754586pjt.120.1588130835256;
        Tue, 28 Apr 2020 20:27:15 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id q11sm9559796pfl.97.2020.04.28.20.27.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 20:27:14 -0700 (PDT)
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
Subject: [PATCH v2 03/10] kexec: separate PageHighMem() and PageHighMemZone() use case
Date:   Wed, 29 Apr 2020 12:26:36 +0900
Message-Id: <1588130803-20527-4-git-send-email-iamjoonsoo.kim@lge.com>
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
 kernel/kexec_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index ba1d91e..33097b7 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -766,7 +766,7 @@ static struct page *kimage_alloc_page(struct kimage *image,
 			 * gfp_flags honor the ones passed in.
 			 */
 			if (!(gfp_mask & __GFP_HIGHMEM) &&
-			    PageHighMem(old_page)) {
+			    PageHighMemZone(old_page)) {
 				kimage_free_pages(old_page);
 				continue;
 			}
-- 
2.7.4

