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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF9AC83001
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6029F2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfE/iAfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgD2D1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726792AbgD2D1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:27:50 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2321C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:27:50 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u22so317970plq.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OoRI+cRunKH9WBjhUvLx6xEiTkTtLL8jDLPBXfzqLhY=;
        b=WfE/iAfJRj709WUE/DqCp3kQvZLDfPqz0Y+GFAuwA7l8LKNp0oWG35rkAoNlwpvZJ3
         k4TnWr107Ixi9fhqz1qOaWTc50GGhV/Fx0Wsu3LTmy2DCVroGocU3ISWgKjr25sgMO0L
         t4OHwf3wKPVybUAboOEHTr9bObXq45dZjQ83L/voxeG8iKFVCFSfejvPKa7H/HtBB4dB
         mGAPVOBDNUSvC/SS1aLvmeYHQwMFXfancyfK0Q0lR2CzezZeTlrwqJjY0Gy7MWdiGyeg
         dUbpAxMCl55cyGRTrCHFbfjOtm9eBvlI9upgNDVsTJBQoAC9aqP7F9qcQ3QHtax4NECs
         Yecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OoRI+cRunKH9WBjhUvLx6xEiTkTtLL8jDLPBXfzqLhY=;
        b=cijZorZdIL2ZItJe3PwY5zQ9UDMT4LAnXKgZXU6uqvLnHY91rXOumUFn4QMslqmH+p
         onuzFGwWcnckrRx5qNiO37hYY8fL9FNC8uHf/xq+IKltE4HZIbbSU1rxtJDovxpmdrin
         yHAcr2umGvJYoinVCaqMycu1p5F26pZdNSzhtPFu7A1+rTdiYyBKpHF6L0L7/Qz/VyyQ
         HHwGM3YXRW/LC/kgLND+xWQ5a1bUMiUtoLYv4iYvSi//HL8/YFNM7C5bc5mweBwcOQho
         is79stAtQrx26uMl/Vj3h0C/T8xDL+igMd/sKfA80zqmNXsa817XdeX9f6aeKTHRxj7B
         WeGg==
X-Gm-Message-State: AGi0PuahKiAU3w7CXuJosdk2a8I11YJQxoEW1SctQxCSjsi+kYkEZWTH
        FUk5g4Bp7BcEHyrAAZGownE=
X-Google-Smtp-Source: APiQypJw1FCB1XxqXtN6Ir3II1PN4ozwDO72vOVsNUoYWwEuA3b0siqTDlaFqUHECfk4fYh3xh8fog==
X-Received: by 2002:a17:90a:648d:: with SMTP id h13mr778148pjj.12.1588130870123;
        Tue, 28 Apr 2020 20:27:50 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id q11sm9559796pfl.97.2020.04.28.20.27.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 20:27:49 -0700 (PDT)
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
Subject: [PATCH v2 10/10] mm/page-flags: change the implementation of the PageHighMem()
Date:   Wed, 29 Apr 2020 12:26:43 +0900
Message-Id: <1588130803-20527-11-git-send-email-iamjoonsoo.kim@lge.com>
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

Previous patches introduce PageHighMemZone() macro and separates both
cases strictly. So, now, PageHighMem() is used just for checking if
there is a direct mapping for this page or not.

In the following patchset, ZONE_MOVABLE which could be considered as
the highmem type zone in some configuration could have both types of
pages, direct mapped pages and unmapped pages. So, current implementation
of PageHighMem() that checks the zone rather than checks the page in order
to check if a direct mapping exists will be invalid. This patch prepares
that case by implementing PageHighMem() with the max_low_pfn.

Acked-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/page-flags.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index fca0cce..7ac5fc8 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -375,6 +375,8 @@ PAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
 	TESTCLEARFLAG(Readahead, reclaim, PF_NO_COMPOUND)
 
 #ifdef CONFIG_HIGHMEM
+extern unsigned long max_low_pfn;
+
 /*
  * Must use a macro here due to header dependency issues. page_zone() is not
  * available at this point.
@@ -383,7 +385,7 @@ PAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
  * in order to predict previous gfp_flags or to count something for system
  * memory management.
  */
-#define PageHighMem(__p) is_highmem_idx(page_zonenum(__p))
+#define PageHighMem(__p) (page_to_pfn(__p) >= max_low_pfn)
 #define PageHighMemZone(__p) is_highmem_idx(page_zonenum(__p))
 #else
 PAGEFLAG_FALSE(HighMem)
-- 
2.7.4

