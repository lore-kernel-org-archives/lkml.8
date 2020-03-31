Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8962CC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4672078B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="P8qu2lfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbgCaPY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:24:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38381 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgCaPY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:24:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id c7so483175wrx.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 08:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=6PtH4wzWMiH5JmxAt904ilpPuqtvXlZEsu04wa6si/k=;
        b=P8qu2lfTpI9t1V10h5AQtX1pY3rsMg/xWtmYiBZTO8QwsPjlZ48gV9R/FoFJmeJWE0
         6N9UVOHFvpnOaSH+7UMgcWEAHiG7XS3XGxcYf4DGWJ7JjdHdvf5MBmfs7Auv00Bns8rd
         7JaAJ9XeB4dUlJrtAGbvmVJaQ85yG05sxP8nA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6PtH4wzWMiH5JmxAt904ilpPuqtvXlZEsu04wa6si/k=;
        b=cBI7fcR1wtTPLYoWirbJgSZo5MfMO8RrGCLFCThlNeTLXjo0B/J6F2LtX+DowxGqfS
         JDbHjD9RXZfYIyYqMkdmJjtWpwoggkrH6vrtxlCMW9cztWjIeQ1LANero4wI9a3KcOjR
         4F9kwpOD2J3SWiSBJMgxQ9/7PoTmK16hS9a5nMjpMkHxhDWtdAZSHt+Lc/coAt7nrp20
         H/AfEGdmeom4aedAiWRs9Go+5paWVzx3xvsEnbnljDX70tpVU1HMwpX1clzbC12LR55S
         ap081BFrEHWOS6o54cuOCICEd4OLQ4sGa7wqZll8w1WffzNuMxf4fKX7M7edaUIF9aIw
         H4JA==
X-Gm-Message-State: ANhLgQ088tHxjPkAG8wd+vig1wKSep1T+HZQ+x2wqmcNTMyKNwcRkMSd
        BH8bbSXfQ9DiJE9PD9H6P5ho2g==
X-Google-Smtp-Source: ADFU+vtjJzo7Yj3p4RVYdBmh1TnRGKbfJ5JHTuYQ43/PgPGuhocYfvkpQbIjq4OT3R2JrnctZq7ssQ==
X-Received: by 2002:adf:9465:: with SMTP id 92mr21029231wrq.122.1585668265184;
        Tue, 31 Mar 2020 08:24:25 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:27bd])
        by smtp.gmail.com with ESMTPSA id c7sm27386436wrn.49.2020.03.31.08.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 08:24:24 -0700 (PDT)
Date:   Tue, 31 Mar 2020 16:24:24 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] mm, memcg: Do not high throttle allocators based on
 wraparound
Message-ID: <20200331152424.GA1019937@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

If a cgroup violates its memory.high constraints, we may end
up unduly penalising it. For example, for the following hierarchy:

A:   max high, 20 usage
A/B: 9 high, 10 usage
A/C: max high, 10 usage

We would end up doing the following calculation below when calculating
high delay for A/B:

A/B: 10 - 9 = 1...
A:   20 - PAGE_COUNTER_MAX = 21, so set max_overage to 21.

This gets worse with higher disparities in usage in the parent.

I have no idea how this disappeared from the final version of the patch,
but it is certainly Not Good(tm). This wasn't obvious in testing
because, for a simple cgroup hierarchy with only one child, the result
is usually roughly the same. It's only in more complex hierarchies that
things go really awry (although still, the effects are limited to a
maximum of 2 seconds in schedule_timeout_killable at a maximum).

[chris@chrisdown.name: changelog]

Fixes: e26733e0d0ec ("mm, memcg: throttle allocators based on ancestral memory.high")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: stable@vger.kernel.org # 5.4.x
---
 mm/memcontrol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index eecf003b0c56..75a978307863 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2336,6 +2336,9 @@ static unsigned long calculate_high_delay(struct mem_cgroup *memcg,
 		usage = page_counter_read(&memcg->memory);
 		high = READ_ONCE(memcg->high);
 
+		if (usage <= high)
+			continue;
+
 		/*
 		 * Prevent division by 0 in overage calculation by acting as if
 		 * it was a threshold of 1 page
-- 
2.26.0

