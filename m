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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F941C83001
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 653B62068E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNtHgy3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgD2D1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726508AbgD2D1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:27:06 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26187C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:27:06 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h11so319710plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Unb6vzKYfZVHOut29YQ6Kvm+UYMfQLEK+TJmxHNNGJY=;
        b=bNtHgy3NUjLmwef1ZHhK57fe3JiO55VlxYKnn5RshIkUTMNjEQ8/R2+4Hox/hDl4Sw
         BlrWHCBt89hiCS7EtfeMIJiLpnazYudS4VtnG2Mqlac5rz0sN2koMm6vnH8ZahohhMiH
         IkZCYgsdeC593M0bWx+yBa3myqFB+cwngBfY4Na2par4h98l19BJA4+eOH+ZjIljPwAI
         5YpcX6cyBHaFOTv//9m+ziunxBzEQPAY/VfUmaubLTeZZalHI/eNAoOF8DezNFMZstKq
         MT4r2GgN4BjWDpk/E8qYPoMa3rqYBxXBn+T8G1Gf07YQ9/eztqfXUOpBY7VeJKg47laa
         ozNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Unb6vzKYfZVHOut29YQ6Kvm+UYMfQLEK+TJmxHNNGJY=;
        b=Ca75bC8QilI49/pYSdkPIbOPsHWRN1oDwxxfn/H4ZWs0T19qGVggmcdosWjNB559fy
         KIdlSmTFHreoyD+uyKNwDg6adl0rOcMEpnwO8HEloN1YRjvy8IzK+6BLy7pnuJe0Qwdf
         ox1gnhlXYF/UrpS7cAOdF08m4zBA94gtCWvyMYKk1/OqSGCoOzf0y4WKOS6uEqm6LPcu
         5MfCcWdOqPmQqA8CWL7lDfrPv4clX3BLUd6Dcf4xP9DRizni3SS+xQ43BmpUMoMTC2o/
         ok1bHVEI6U/8I8qAqanotSOv1J13JxaL7nT+8eFlzQHrNU8fFeRkF+aUsB0xzpbMw/Sq
         A8eA==
X-Gm-Message-State: AGi0Pub1danwV6IMsozSwUdzd5qhTfqMH07eZ7FHWTmwgVA00bykwhRo
        vEyM1uerpUaXfDCAegPiACg=
X-Google-Smtp-Source: APiQypLJDJ3XJJjcn6kAUugNzwdYBhQTpB+OKL/tKKH2CCSDLf6KN4mrZ6Rb5Skm00Ui641/P4TW2w==
X-Received: by 2002:a17:902:d30a:: with SMTP id b10mr18608241plc.3.1588130825605;
        Tue, 28 Apr 2020 20:27:05 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id q11sm9559796pfl.97.2020.04.28.20.27.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 20:27:05 -0700 (PDT)
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
Subject: [PATCH v2 01/10] mm/page-flags: introduce PageHighMemZone()
Date:   Wed, 29 Apr 2020 12:26:34 +0900
Message-Id: <1588130803-20527-2-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

PageHighMem() is used for two different cases. One is to check if there
is a direct mapping for this page or not. The other is to check the
zone of this page, that is, weather it is the highmem type zone or not.

Until now, both the cases are the perfectly same thing. So, implementation
of the PageHighMem() uses the one case that checks if the zone of the page
is the highmem type zone or not.

"#define PageHighMem(__p) is_highmem_idx(page_zonenum(__p))"

ZONE_MOVABLE is special. It is considered as normal type zone on
!CONFIG_HIGHMEM, but, it is considered as highmem type zone
on CONFIG_HIGHMEM. Let's focus on later case. In later case, all pages
on the ZONE_MOVABLE has no direct mapping until now.

However, following patchset
"mm/cma: manage the memory of the CMA area by using the ZONE_MOVABLE"
, which is once merged and reverted, will be tried again and will break
this assumption that all pages on the ZONE_MOVABLE has no direct mapping.
Hence, the ZONE_MOVABLE which is considered as highmem type zone could
have the both types of pages, direct mapped and not. Since
the ZONE_MOVABLE could have both type of pages, __GFP_HIGHMEM is still
required to allocate the memory from it. And, we conservatively need to
consider the ZONE_MOVABLE as highmem type zone.

Even in this situation, PageHighMem() for the pages on the ZONE_MOVABLE
when it is called for checking the direct mapping should return correct
result. Current implementation of PageHighMem() just returns TRUE
if the zone of the page is on a highmem type zone. So, it could be wrong
if the page on the MOVABLE_ZONE is actually direct mapped.

To solve this potential problem, this patch introduces a new
PageHighMemZone() macro. In following patches, two use cases of
PageHighMem() are separated by calling proper macro, PageHighMem() and
PageHighMemZone(). Then, implementation of PageHighMem() will be changed
as just checking if the direct mapping exists or not, regardless of
the zone of the page.

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

My final plan is to change the name, PageHighMem() to PageNoDirectMapped()
or something else in order to represent proper meaning.

Acked-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/page-flags.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 222f6f7..fca0cce 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -378,10 +378,16 @@ PAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
 /*
  * Must use a macro here due to header dependency issues. page_zone() is not
  * available at this point.
+ * PageHighMem() is for checking if the direct mapping exists or not.
+ * PageHighMemZone() is for checking the zone, where the page is belong to,
+ * in order to predict previous gfp_flags or to count something for system
+ * memory management.
  */
 #define PageHighMem(__p) is_highmem_idx(page_zonenum(__p))
+#define PageHighMemZone(__p) is_highmem_idx(page_zonenum(__p))
 #else
 PAGEFLAG_FALSE(HighMem)
+PAGEFLAG_FALSE(HighMemZone)
 #endif
 
 #ifdef CONFIG_SWAP
-- 
2.7.4

