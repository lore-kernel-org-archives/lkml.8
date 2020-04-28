Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4616EC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2293E20BED
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="FIUW+caX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgD1S0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728813AbgD1S0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:26:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42727C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 11:26:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k13so25888867wrw.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 11:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8ZdOelXqdALp+t5GpXOOCmyCgx7RbdhWdYql4OpbI1c=;
        b=FIUW+caXr+iJxtL6SRGRKizlkX7XhzWQuOY05F0+5+5/65k+s+9ywMQwaLpbod1SvJ
         FfDh3SAdEhODgckqhW2bHwjVwebnbxOH1HsAcAe4T3Fd/1U0rACWccleZh2AdKLIkD+h
         o/RxBNRzbhY/2DUlNUpR3LbBF56ufvPXeDgfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ZdOelXqdALp+t5GpXOOCmyCgx7RbdhWdYql4OpbI1c=;
        b=l1+K5UXYwCKoFsl0Z0n1PwjYXjARt742lXph6ZVxhP7+s5cgqkZalshjBiQHi/Ty9Z
         f9uuZF1Mo8LzeAp27hjod2TOu1cW11xO9X1P2IisKIv3BK3URQoVAdmjhsQDp9WhQuHH
         6tx9ebXHP6M2gK9l14q2ambjdLnK4z5pNVdNVLpQ00WUompAb/IqRFlfXB4iqoSHY6do
         IjwJT11eMAZC48UpVKtqgALMJIwRAO0EJOvnWSxAttaXlS61JrE7A0Gi5vIT8bOhQDF5
         /W65cHGaHdbcsM7Ac9bfgRd9v0DxrX7oMX+ubE0oQvc759tjrn4rRyBclLdMS4bJ9dVT
         ex5A==
X-Gm-Message-State: AGi0PuY92QqQsFktZrsuXTMZSpZ8u0fX5+sx0Dpn2C1bPGH3yn18UeNR
        StfoOYZcXV8tshUBsVTxGqBLYA==
X-Google-Smtp-Source: APiQypJ2+N7o09gAo7QjMQFnU2CwELzmpsGz8p6QbSTx74nuWdjD7zRh7ERIHa4tuyomWgoTtmqg7Q==
X-Received: by 2002:a5d:490f:: with SMTP id x15mr33086688wrq.37.1588098408915;
        Tue, 28 Apr 2020 11:26:48 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:56e1:adff:fe3f:49ed])
        by smtp.gmail.com with ESMTPSA id r17sm25942192wrn.43.2020.04.28.11.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 11:26:48 -0700 (PDT)
Date:   Tue, 28 Apr 2020 19:26:47 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm, memcg: Avoid stale protection values when cgroup is
 above protection
Message-ID: <d454fca5d6b38b74d8dc35141e8519b02089a698.1588092152.git.chris@chrisdown.name>
References: <cover.1588092152.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588092152.git.chris@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>

A cgroup can have both memory protection and a memory limit to isolate
it from its siblings in both directions - for example, to prevent it
from being shrunk below 2G under high pressure from outside, but also
from growing beyond 4G under low pressure.

Commit 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim")
implemented proportional scan pressure so that multiple siblings in
excess of their protection settings don't get reclaimed equally but
instead in accordance to their unprotected portion.

During limit reclaim, this proportionality shouldn't apply of course:
there is no competition, all pressure is from within the cgroup and
should be applied as such. Reclaim should operate at full efficiency.

However, mem_cgroup_protected() never expected anybody to look at the
effective protection values when it indicated that the cgroup is above
its protection. As a result, a query during limit reclaim may return
stale protection values that were calculated by a previous reclaim cycle
in which the cgroup did have siblings.

When this happens, reclaim is unnecessarily hesitant and potentially
slow to meet the desired limit. In theory this could lead to premature
OOM kills, although it's not obvious this has occurred in practice.

Fixes: 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <guro@fb.com>

[hannes@cmpxchg.org: rework code comment]
[hannes@cmpxchg.org: changelog]
[chris@chrisdown.name: fix store tear]
[chris@chrisdown.name: retitle]
---
 mm/memcontrol.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0be00826b832..b0374be44e9e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6392,8 +6392,19 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 
 	if (!root)
 		root = root_mem_cgroup;
-	if (memcg == root)
+	if (memcg == root) {
+		/*
+		 * The cgroup is the reclaim root in this reclaim
+		 * cycle, and therefore not protected. But it may have
+		 * stale effective protection values from previous
+		 * cycles in which it was not the reclaim root - for
+		 * example, global reclaim followed by limit reclaim.
+		 * Reset these values for mem_cgroup_protection().
+		 */
+		WRITE_ONCE(memcg->memory.emin, 0);
+		WRITE_ONCE(memcg->memory.elow, 0);
 		return MEMCG_PROT_NONE;
+	}
 
 	usage = page_counter_read(&memcg->memory);
 	if (!usage)
-- 
2.26.2

