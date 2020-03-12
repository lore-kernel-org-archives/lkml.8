Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EA2C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E062071C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="t7xkgWzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgCLQlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:41:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39656 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgCLQlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 12:41:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id f7so7102893wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 09:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=N2Uu/Isy7NWEK22NJk3FeLyFIU8DnOEsZiiSW7A75uw=;
        b=t7xkgWzL7lP8/guUn9rLcXqc2L/I8M4mdPLj2rg4UyMUaDhBh7A5BFsyNeuUrfj5Sy
         sZUf9YD87y994A6gKWXRpHFpH80VKHCF7N3X/4Pv5qvlLvmKlvIqQmk2yNsoJjceEcwr
         RTAWrygWaUxgm6QfhsJnWIPCeHwo+bWOupSI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=N2Uu/Isy7NWEK22NJk3FeLyFIU8DnOEsZiiSW7A75uw=;
        b=LW/m+d4mqzQhUQ2/dxFob0fou+FoXe9Aj58jvffIZVNbLFhhxkzFErekIxB/FYWuoj
         nfu6M2a0vWp5F0Mh56NCRiqG/dLCJ7zi3KtXfB9QyoYqobriVQn1jM2fSnCSXwnU8v4g
         1+bH3Hh3bZK5W6H0vA+hPVi8wErozzB6jN3OI/PGC6YuzJVGvSG+9XqYtY5193YKDy6i
         K+U0WS0rc98sk3TWYjBDfRRGnOP7yKyYcdL3nQZafhOqhI3T6PauVpPUjETLUcVXuvdo
         cp+3+joc39niAMJphP+QxT6t8a4qjpy/FBAcwuLWXicur9PhoqLU+NdoNEW5olPeh/ns
         8NCQ==
X-Gm-Message-State: ANhLgQ2IL+jhYEmEjJBZM3/+pwER0viSb2gS6CdpqRb4cbfguUxpPsM6
        aHvcsTFd83poQDd56aZ3X9qo0Q==
X-Google-Smtp-Source: ADFU+vvlNP+sTGWtwglGQNPghD1uV2b6E7MyhcfHEsjAve9zJzNS72Sz6SK5JO+Zicct59iWDQt/KQ==
X-Received: by 2002:a1c:5585:: with SMTP id j127mr5652787wmb.35.1584031298224;
        Thu, 12 Mar 2020 09:41:38 -0700 (PDT)
Received: from localhost ([89.32.122.5])
        by smtp.gmail.com with ESMTPSA id m19sm12906711wmc.34.2020.03.12.09.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 09:41:37 -0700 (PDT)
Date:   Thu, 12 Mar 2020 16:41:37 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] mm, memcg: Bypass high reclaim iteration for cgroup
 hierarchy root
Message-ID: <20200312164137.GA1753625@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The root of the hierarchy cannot have high set, so we will never reclaim
based on it. This makes that clearer and avoids another entry.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@fb.com
---
 mm/memcontrol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 63bb6a2aab81..ab9d24a657b9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2232,7 +2232,8 @@ static void reclaim_high(struct mem_cgroup *memcg,
 			continue;
 		memcg_memory_event(memcg, MEMCG_HIGH);
 		try_to_free_mem_cgroup_pages(memcg, nr_pages, gfp_mask, true);
-	} while ((memcg = parent_mem_cgroup(memcg)));
+	} while ((memcg = parent_mem_cgroup(memcg)) &&
+		 !mem_cgroup_is_root(memcg));
 }
 
 static void high_work_func(struct work_struct *work)
-- 
2.25.1

