Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995AFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78CDB207F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPVmiXy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgERBVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 21:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgERBVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 21:21:44 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAECFC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:21:43 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f23so4074433pgj.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0sx8M+kAOaC1XfEd2srVxr37pMoaqzTLihZ3PqNhqQM=;
        b=aPVmiXy9N/XcoqFsJHLAt2SwQL/pBirwX94V5a2nMS1b3ZJqxUPKB9docoAInlS/rw
         3xcHPVgfYLaaUkIgHN2BIE3cV4dbH6NGqjPxpSk6q8lIij9kN8tepoOnXXGP77SPjq0W
         L+v9NXDm80eeU7WDkvQF00GKY5SuclyY7w0xlOzVQRawNY0oTgtBLxdkaZLc5ilsxlMc
         8VgS6RAEpWx1o1fWZ5UYo6jCH6vLtma4zirE8vRS0grexENaT7Alf6XZSGlAl4lE2ngM
         eJ9qpK0+AZw+PF0htXl5cz8WtuvqD6/mYiuoyaDyaRvj6WW++k0/PGysm/upgXcZVxgx
         pYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0sx8M+kAOaC1XfEd2srVxr37pMoaqzTLihZ3PqNhqQM=;
        b=RXlSsWiYuC2G5cT4EsUZ68U8DMuapwLO49GseXQiucsBmyH7j4D/uydcoq3UVupT2U
         fs6h/sWIfQcrc3Es5HpU4pBHIOpuhbEKATmUV5WG1svEjCswniUsJfiFHRceobrTLHaK
         MeIQHvlo6FSGpt+X9tmYkm5zHe9G8QmAvVg6lNLhN/fUtHYgmW3dRFY+xTYAf8MP8P0T
         sV76oX73jTqtSFYPhbtOmxQzXa8F3F1F/kePhad9cMVT3jSlNkipJUtrFPwj9y0jQ2vi
         F0ZMTlkjbQcxtEk8LRpCquwaMilklTPqYzaf3SU3K9tRvTtqtEf+fQzar13wLJsHkKjJ
         ISaQ==
X-Gm-Message-State: AOAM531fVzDzWsngh2o7qDzqurYqnT+ymgItAcF/yRzUu0DqaCsYiqim
        xHS3FgskjL2d+DAgkHf5Pi4=
X-Google-Smtp-Source: ABdhPJzXznuKGiK7xC4AyF4N3k3zf1+Wz9osR7hGqd/f+etgdFkqkuu06dwSJEiO4y+xYVkvOB44FA==
X-Received: by 2002:a63:4926:: with SMTP id w38mr13342473pga.222.1589764903304;
        Sun, 17 May 2020 18:21:43 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id fw4sm1544376pjb.31.2020.05.17.18.21.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 May 2020 18:21:42 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH 01/11] mm/page_isolation: prefer the node of the source page
Date:   Mon, 18 May 2020 10:20:47 +0900
Message-Id: <1589764857-6800-2-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

For locality, it's better to migrate the page to the same node
rather than the node of the current caller's cpu.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/page_isolation.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 2c11a38..7df89bd 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -300,5 +300,7 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 
 struct page *alloc_migrate_target(struct page *page, unsigned long private)
 {
-	return new_page_nodemask(page, numa_node_id(), &node_states[N_MEMORY]);
+	int nid = page_to_nid(page);
+
+	return new_page_nodemask(page, nid, &node_states[N_MEMORY]);
 }
-- 
2.7.4

