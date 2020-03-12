Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3310C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7350D20716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="up0/TKVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCLRdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:33:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38888 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgCLRdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:33:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id t13so922144wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 10:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XlHPYdHYVGL+ZH9Fy2ExhyAo23ZIkMLKS1ZUcqxxQY0=;
        b=up0/TKVQ7COgyqEd0H7isdZkegQuEbx6al4+9E95wP3QiMQsdxvH9836eQ+LluSIC5
         RrbHhXsGGbJAFQXjNgehCBmeLiF93Sg8ahlpsQiK3ct/C8obWCIZR0CUU9z9GnAc5QUt
         /KMm82i4Ln7WBp4XE3Bm+5wpBL7eIdIAKbhSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XlHPYdHYVGL+ZH9Fy2ExhyAo23ZIkMLKS1ZUcqxxQY0=;
        b=U4KLcdFyT0EzkC75rEgjw9J+yNjNJI/p/wnyzaRNZoGIxo/IB5lxNcsS3wPhdfvLUj
         pdKwhZVf0sUG4LZLRR8luIKXDhs1AlfWVRoHbRRU9D1goPobTc6lERbl76Vl7Bilt7+z
         YYAC4q20OwuAUD3IDMB53PQFJGAuz6hW+126ILGXBFMq54X/eIU/49g+lG2p/MXqcS7s
         w6vVKWJoGQvUfi0bKuSGu/POGi9i1Cb5KGWfe2jt6NiNSsbBLrpdwpIok9VRWWNca4yd
         P41zX2Q8ID5XKK9phObGzTjQuShTNv6qDBP8qwOjdCFLItkQw3uC3zdURk6GRfRlke9u
         uXmg==
X-Gm-Message-State: ANhLgQ06XAnHmSjjBY9EtmV1vYlIgoVUSsXX139d5nZmV9EnAh1xTMhh
        LlHfBzWRLbxXCDuO/tU8DKfW/w==
X-Google-Smtp-Source: ADFU+vvMEQBOPd6Zfe5WzhxMWesz4iewNlgOu1pm6OgWwYpcAaCXRS0o8aM/RRSitF4y+VwXVIB6pw==
X-Received: by 2002:a1c:7d88:: with SMTP id y130mr6104452wmc.5.1584034388539;
        Thu, 12 Mar 2020 10:33:08 -0700 (PDT)
Received: from localhost ([89.32.122.5])
        by smtp.gmail.com with ESMTPSA id l17sm14887319wmg.23.2020.03.12.10.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:33:08 -0700 (PDT)
Date:   Thu, 12 Mar 2020 17:33:07 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 4/6] mm, memcg: Prevent memory.min load/store tearing
Message-ID: <e809b4e6b0c1626dac6945970de06409a180ee65.1584034301.git.chris@chrisdown.name>
References: <cover.1584034301.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584034301.git.chris@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can be set concurrently with reads, which may cause the wrong value
to be propagated.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@fb.com
---
 mm/memcontrol.c   |  4 ++--
 mm/page_counter.c | 10 ++++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c85a304fa4a1..e0ed790a2a8c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6261,7 +6261,7 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 	if (!usage)
 		return MEMCG_PROT_NONE;
 
-	emin = memcg->memory.min;
+	emin = READ_ONCE(memcg->memory.min);
 	elow = READ_ONCE(memcg->memory.low);
 
 	parent = parent_mem_cgroup(memcg);
@@ -6277,7 +6277,7 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 	if (emin && parent_emin) {
 		unsigned long min_usage, siblings_min_usage;
 
-		min_usage = min(usage, memcg->memory.min);
+		min_usage = min(usage, READ_ONCE(memcg->memory.min));
 		siblings_min_usage = atomic_long_read(
 			&parent->memory.children_min_usage);
 
diff --git a/mm/page_counter.c b/mm/page_counter.c
index 18b7f779f2e2..ae471c7d255f 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -17,14 +17,16 @@ static void propagate_protected_usage(struct page_counter *c,
 				      unsigned long usage)
 {
 	unsigned long protected, old_protected;
-	unsigned long low;
+	unsigned long low, min;
 	long delta;
 
 	if (!c->parent)
 		return;
 
-	if (c->min || atomic_long_read(&c->min_usage)) {
-		if (usage <= c->min)
+	min = READ_ONCE(c->min);
+
+	if (min || atomic_long_read(&c->min_usage)) {
+		if (usage <= min)
 			protected = usage;
 		else
 			protected = 0;
@@ -217,7 +219,7 @@ void page_counter_set_min(struct page_counter *counter, unsigned long nr_pages)
 {
 	struct page_counter *c;
 
-	counter->min = nr_pages;
+	WRITE_ONCE(counter->min, nr_pages);
 
 	for (c = counter; c; c = c->parent)
 		propagate_protected_usage(c, atomic_long_read(&c->usage));
-- 
2.25.1

