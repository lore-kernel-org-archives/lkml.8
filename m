Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEA1C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 21:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6A1F2083E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 21:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oFyFWS/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgH3VBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 17:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgH3VBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 17:01:34 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16FDC061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 14:01:34 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 109so3765739otv.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 14:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0A0MgBvdZsn83Ew2Ktjq3B8TXEsbXPWHsWkGfR3n5Sk=;
        b=oFyFWS/knp2ok2Qu0qsMN8fKLiiU0kOo/mIL5IkekajG5x9dgm1oAvakoa5SgfZHsu
         1qzYznn+LwXijJPZS5UvQ28q4NzUqmQb5JYoYoaQQusdmgpdVzkKh2AOHSU9euxcpNYl
         omLFmPd1dP35wP+etXy3lmrM1uUlWvqnZPAKCuZ/k8Dno8MbpcvA8qEhhlhnzQXBYM+B
         ux5CuQ7sti0552QPWjIrs+ZMNYXdqpMx98JzBmfA6sPypX7LUj7UIwUjrVLfIvb3FIfd
         T5tlwA6YskZ2woohS40ycZRntDy8zFveF5niV8KmeDlng4hl5LLHWoI5KQ7NQ/26N/xN
         dVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=0A0MgBvdZsn83Ew2Ktjq3B8TXEsbXPWHsWkGfR3n5Sk=;
        b=GSaopekZDmVOIO8pWAfvvT8GbODh18n/WHTo0A/TvUi+eUtInCirSkatM0HYLGSrnL
         AHWf3KPDN2UAovTZYSsrWZKoCeHxd5sK6ScRk60jNod/BWwtn/ICwHi+CiRq7wr/T7pN
         hadZ1z6ojjgkZvpQNVnLkWQCDCo7vrnIJlIaLuhvVap8wuND1RFRieMyVTdPwsUkXHzr
         xbhGxnokfj9f4BaeJyr2qZwZCvtmgTz4uPt3uQ4rFvzmwRNzFYfDsr/zKrCw0CZ0IxKV
         tA55I4K4lDv9rLzVN4NmvNSwE/4vt/XTG2YyOBBqHBt2WaaEStqa0nnwdqO5/gwo/qfd
         B2pQ==
X-Gm-Message-State: AOAM530mJEwwoTC6xE/umRRropFpYdfPLu13UoQjcvoAN5sb0mQ5g11p
        P7yYyeMS1pPwJy2GH3Lojt1xHA==
X-Google-Smtp-Source: ABdhPJyM3ZCANKZOyGmfG66cOB7Sxsfltxqe3tzoqaKIbYnuzUsBOB5hyE7Vr76l2sr1FdMpsJQYTw==
X-Received: by 2002:a9d:24c6:: with SMTP id z64mr2594644ota.97.1598821293211;
        Sun, 30 Aug 2020 14:01:33 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m11sm281916ooe.43.2020.08.30.14.01.31
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 30 Aug 2020 14:01:32 -0700 (PDT)
Date:   Sun, 30 Aug 2020 14:01:30 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/5] mm: migration of hugetlbfs page skip memcg
In-Reply-To: <alpine.LSU.2.11.2008301343270.5954@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2008301359460.5954@eggly.anvils>
References: <alpine.LSU.2.11.2008301343270.5954@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlbfs pages do not participate in memcg: so although they do find
most of migrate_page_states() useful, it would be better if they did
not call into mem_cgroup_migrate() - where Qian Cai reported that LTP's
move_pages12 triggers the warning in Alex Shi's prospective commit
"mm/memcg: warning on !memcg after readahead page charged".

Signed-off-by: Hugh Dickins <hughd@google.com>
---
This fixes a likely future warning, but is just a cleanup right now.

 mm/migrate.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- 5.9-rc2/mm/migrate.c	2020-08-16 17:32:50.665507048 -0700
+++ linux/mm/migrate.c	2020-08-28 17:42:07.967278385 -0700
@@ -668,7 +668,8 @@ void migrate_page_states(struct page *ne
 
 	copy_page_owner(page, newpage);
 
-	mem_cgroup_migrate(page, newpage);
+	if (!PageHuge(page))
+		mem_cgroup_migrate(page, newpage);
 }
 EXPORT_SYMBOL(migrate_page_states);
 
