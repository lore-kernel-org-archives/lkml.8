Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0BBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE95C206A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="ZyLX+Ych"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgFCPvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgFCPvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:51:40 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7B9C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 08:51:40 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q16so961563plr.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 08:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4EZwpgmE4SueL7e7tjK8HJwbAvV8gZoeqD/srGZ37yk=;
        b=ZyLX+YchCvrvF4S+nVRMqtygJMKIGErfDWpiKzoDhP8bOjlMaHxMfNopmfNWUpsJnH
         1SxKh8z3fnAwBXchSotzz7Cdri4LUXklamhV0zEbTNhbmc1voenNMpi2IO1hX2aX9QTo
         2tyEPya5rCe7i+QcHuOzoxfig97Hr76dORbmrVZXyxeTqbpIuPCuqdMbJg3BS1NcSlhu
         ZXgJu5XW3LCB4V5MJxB7m14GnDgc/6jZScAolGB/54a1vkoLXjDYimVOUo733q+zZAa0
         lGW7gfMobnnl9SizU4NI5nWKF4ipByvCnII9rLTsGRMqhO4i2MCfhYjkULrtoUgyPkHk
         fbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4EZwpgmE4SueL7e7tjK8HJwbAvV8gZoeqD/srGZ37yk=;
        b=HDfjC31nGHrg2rSNv0b6SlwdLj7L9W4i2EDzKne2JDlIUqYzqR8EBh1KixIlUKCDs3
         d01w1SsyOCD5Z/JdYosx/eYofTU3I7Ns1SZnlnxC7t/pQ/zRgd7qoSrgXUW4vk7ZOukS
         ncmow1uZWel0Tw4/nUNWwIJoeoK55vg6VJt5MjjfZYKmIlVwRVfOXCVxUFTtT0O3PhRF
         qle1LL7tpDBZwCvTG1PqqF8IVM1iVlKUpYN1FKdp9jHZ/BDWcRoA9Lc90AoyhY/4m7MA
         KUmPFY7NWZRkO6vuPvqxMawtXBpMU1XqKwp1hy1oPOp2uTnriZ1oBZmICFongj8MlYv0
         7+aw==
X-Gm-Message-State: AOAM530MiQ3BrL3WA9kOuoa46ywLUeflmPRzl1X6O3ODDxl6laxNY/Ul
        sfNl723piUUw30MI9CQkN4XIbDl1Hegt/CxQ
X-Google-Smtp-Source: ABdhPJwhCy0NCR2rHQD0wojHcHwNw52mcwGqMJ3XgoD3/b5iqUSSMYoW5hWg74FT61Zd2CagbT1fZg==
X-Received: by 2002:a17:902:6903:: with SMTP id j3mr531245plk.110.1591199499859;
        Wed, 03 Jun 2020 08:51:39 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.220.73])
        by smtp.gmail.com with ESMTPSA id 205sm2283117pfc.206.2020.06.03.08.51.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2020 08:51:39 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm/page_alloc: Skip setting nodemask when we are in interrupt
Date:   Wed,  3 Jun 2020 23:51:24 +0800
Message-Id: <20200603155124.33981-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we are in the interrupt context, it is irrelevant to the
current task context. If we use current task's mems_allowed, we
can fair to alloc pages in the fast path and fall back to slow
path memory allocation when the current node(which is the current
task mems_allowed) does not have enough memory to allocate. In
this case, it slows down the memory allocation speed of interrupt
context. So we can skip setting the nodemask to allow any node
to allocate memory, so that fast path allocation can success.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/page_alloc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b48336e20bdcd..a6c36cd557d1d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4726,10 +4726,12 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 
 	if (cpusets_enabled()) {
 		*alloc_mask |= __GFP_HARDWALL;
-		if (!ac->nodemask)
-			ac->nodemask = &cpuset_current_mems_allowed;
-		else
+		if (!ac->nodemask) {
+			if (!in_interrupt())
+				ac->nodemask = &cpuset_current_mems_allowed;
+		} else {
 			*alloc_flags |= ALLOC_CPUSET;
+		}
 	}
 
 	fs_reclaim_acquire(gfp_mask);
-- 
2.11.0

