Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8ECC54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B91021D79
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvzqiPWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDTIAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgDTIAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:00:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB87C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:00:44 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t9so2101622pjw.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rjiAZZ5G9Er5K6DiVUvm4RrDcTPBJJbdH0An8HV3WPU=;
        b=gvzqiPWEaA6Fgy60bF41PNiLgy/POLCSDD+oUs6ipMccf/+BYVsPxFo1T9L82vf8Ex
         WiXpeN2aywfKiDT43mgK37lstftSsLOH8MHzRbRcwQPgkiVb7UicVVJuv+WKrhSeQyV8
         xKPDyXR654sP98fA+HCkmgn6A5mjkbKenQwRPTGAWeIc1PU2pqEGFAzCd7Ac1gQHOH0y
         jY5Sehb5Vu5T7mOjkngLPKUm2lJWqEeDuKJIlB0YwFyT+Dth43OileJiiOdAgVsj/2E9
         UTg2O7sq+mxqwEcOurJrKs3XkXDNpcVlAIo9EwTTon0dVbZgTE0BVt4H0dfbh1xqhvNK
         xnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rjiAZZ5G9Er5K6DiVUvm4RrDcTPBJJbdH0An8HV3WPU=;
        b=rXig7hIUKVO3cLA5BepAPs0lpTAuQYJHhPO/S3IQbMSebyo6d3LdOjcAK5BqFmkvFT
         Klup/fxwA41/e6Am96rmrkLgFeQKJA3wz3ltOgwORf6vrz09YMmzinwMfG+Rl7JKV9S9
         T5aH0W3mCPBl+Ec+AFyK5c90upbVHnOJCKQDwuxJ3/jqdJ1Aw1D00ggKRQmGm+2X4boD
         mlJ1imiRXs7XhuG+32Lf8KNetEmfa6K8oefZWpkBH+TBBy9IGAs+Cmf2Az9M7gkgjUu9
         5gLqrn0W7IPISgesmlZb3nAQsBnEPXgc5E1GcfhvKmBTAEydzbT0S+Yno6W6su1GB7jb
         KdiA==
X-Gm-Message-State: AGi0Pubsr0592SAAOkf5jvn9mdq/147mv7EteR7rZvzMriqP60LYeqbZ
        tGDH2XGYCzc0Nn7lv/bw+4Y=
X-Google-Smtp-Source: APiQypIvOwWszR77pALzUGPwEo5gChdgiIboqtUTfCay4xpGZgEOfJFRZ2OBWLI7JL9nqKisiVg0jg==
X-Received: by 2002:a17:902:8697:: with SMTP id g23mr15390776plo.306.1587369644029;
        Mon, 20 Apr 2020 01:00:44 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id n9sm314947pjt.29.2020.04.20.01.00.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 01:00:43 -0700 (PDT)
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
Subject: [PATCH 04/10] kexec: separate PageHighMem() and PageHighMemZone() use case
Date:   Mon, 20 Apr 2020 16:59:36 +0900
Message-Id: <1587369582-3882-5-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587369582-3882-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1587369582-3882-1-git-send-email-iamjoonsoo.kim@lge.com>
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

