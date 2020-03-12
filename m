Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE214C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB08A20663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="Haae2SBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgCLSC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:02:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39020 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgCLSC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:02:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id r15so8684281wrx.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 11:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=CRd8IUcL1IWZS04LIYFbzj4WsXVZJS20ANjjPe46vbU=;
        b=Haae2SBurX0dFdW2FA0odm7mGIYVgXxbkX+kRhvt4ySMuKlguBzaUtjNrkfEaiED2N
         mbGRZT1Dix/XuTr0AVw4HxlQ1lhNxqlheMxxT7Vxz3Cz1I+Ulb5n/EARnD4G3g00Lwwn
         6gqr2BrDtb+6qJLFLYJHzj2AY9s6hHt0U7yk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=CRd8IUcL1IWZS04LIYFbzj4WsXVZJS20ANjjPe46vbU=;
        b=luMCTmp6pxsJaXSkLf1CtP0bcDMoJAdZtOGqeHXXL80oVy4/oaE3IKQSo62DDfTdZp
         /PC+EH35OQAcH1Y10qbUClRCgdWE9MTTg+bzlmjwMFXT8aNXCzQ4ElJ/mJfNhlbEf3Rp
         /T43+G5EH8ck9V+g3qMXTTEVNF0L2gAbohpYxvy3gy4KCgomTtPTaJmFusMcbwXYjHVE
         e+1IHkIWc6pWDdPCdAGCqDUgSQAaK3diKnz2RrVSkPXnh30QGCHj/SCWhXdtHZDda36z
         9na/5RwWsPNNnsWvdvNwtriBY4Nba+qezQ3YTZyRKFcL2mQgT3qHxeQ4mc3GNRKQ/sGV
         e6dg==
X-Gm-Message-State: ANhLgQ2cYw33TWDnpmyY2yVsMbddjfZE4Doh2uir0fO63yIv4Rbd54e6
        AoI0dF55umBDzwTsvcdTkvdceQ==
X-Google-Smtp-Source: ADFU+vsZkrnnVJ1X3zqzCkFEciPWmkOFQhOVZNvmD7Ds5YPo0PFp30zOhwIn2DsIoCNmjexoQjXayA==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr12216319wru.100.1584036176193;
        Thu, 12 Mar 2020 11:02:56 -0700 (PDT)
Received: from localhost ([89.32.122.5])
        by smtp.gmail.com with ESMTPSA id i6sm11878144wru.40.2020.03.12.11.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 11:02:55 -0700 (PDT)
Date:   Thu, 12 Mar 2020 18:02:54 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] mm, memcg: Fix corruption on 64-bit divisor in
 memory.high throttling
Message-ID: <80780887060514967d414b3cd91f9a316a16ab98.1584036142.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0e4b01df8659 had a bunch of fixups to use the right division method.
However, it seems that after all that it still wasn't right -- div_u64
takes a 32-bit divisor.

The headroom is still large (2^32 pages), so on mundane systems you
won't hit this, but this should definitely be fixed.

Fixes: 0e4b01df8659 ("mm, memcg: throttle allocators when failing reclaim over memory.high")
Reported-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@fb.com
Cc: stable@vger.kernel.org # 5.4.x
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 63bb6a2aab81..a70206e516fe 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2339,7 +2339,7 @@ void mem_cgroup_handle_over_high(void)
 	 */
 	clamped_high = max(high, 1UL);
 
-	overage = div_u64((u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT,
+	overage = div64_u64((u64)(usage - high) << MEMCG_DELAY_PRECISION_SHIFT,
 			  clamped_high);
 
 	penalty_jiffies = ((u64)overage * overage * HZ)
-- 
2.25.1

