Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191FAC47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB7FF2192A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="jiNhQR7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgEHScy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727984AbgEHScr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:32:47 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFDDC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:32:47 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id q13so2135203qtp.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 11:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eum9bjhCQUemh9iSZtdHJuvrUPzxWGTkZ4CcEro9n7E=;
        b=jiNhQR7oDFgCIaeq8w1kb7yBCUxXWI4PGAu8hvAJp/EDuZPdtqs0Kv0eQRCIbghrLr
         plx1VKm4Sw92oc+8T9hBnws9X3YpMutk37X+Z4vvHpsPuGw4ZF1Y2rPRjkD1agBRSLF1
         kS797R/esbPerCLSlEDiYcRzyVwhJ24kA8ALmaEzLu9cjjv83Lmxp6XMkh3hMvNIqVEU
         XEuKmtJ486aKM1U5k7/+R0un2thzz8+m1v19Z7FPHL+BnJkUfBDg73JlyXZZ7nG9aKiE
         94bS/k6zSEgO9ITOLKwSURZnE+flX89sr9YP4oD6ByysAzQdkJOyP+fRM8bipeTGLD/0
         yqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eum9bjhCQUemh9iSZtdHJuvrUPzxWGTkZ4CcEro9n7E=;
        b=BLGC4k0d0lMRBmJTsMh3xjKPUBmkJDVCn6Y17g50gLf+49L5AnDoMF5bLQSgyL4on9
         DVF94jY31oKr3vjEDpvBlea/6SZtpJSHJ16/HDqLVwodeihsHSPhCFxhj2fcqaTOl3lW
         3MtsKloWybmf+fIBmbxuPdVm4i92MpU8+JKA0v9kd18QPZUY9ZZD4GqHEpmIzfQK0jhV
         18cONVZEDN34rEAzou9jgBhlfQZQAmJfDmkqz2S0yVPqQUP+QhIC77iqozCQfaIfnQPd
         YloWpOkl/4FM5FWuzgvUSPK1l5HzgpXO2etHvDPqi5433dPUuxmc65fPeEic8xGOu6d/
         CnwA==
X-Gm-Message-State: AGi0Puad0fv3eNo09zDlt0y8yTl+kYJDSz9ht+JqsbODc5/kmgwtSs2p
        VJGb8kGBcRpBP+kfKDA6bb3iHw==
X-Google-Smtp-Source: APiQypJ0pdn3xZQfxhpj1b1EoTjr0iocaEQ2GoCK8oxJJWIkU3kVnVnuPWxhjkluRfHHIg6t3mG3Kw==
X-Received: by 2002:aed:2442:: with SMTP id s2mr4367165qtc.153.1588962766615;
        Fri, 08 May 2020 11:32:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id 10sm2348766qtp.4.2020.05.08.11.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:32:45 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 19/19] mm: memcontrol: update page->mem_cgroup stability rules
Date:   Fri,  8 May 2020 14:31:06 -0400
Message-Id: <20200508183105.225460-20-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508183105.225460-1-hannes@cmpxchg.org>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patches have simplified the access rules around
page->mem_cgroup somewhat:

1. We never change page->mem_cgroup while the page is isolated by
   somebody else. This was by far the biggest exception to our rules
   and it didn't stop at lock_page() or lock_page_memcg().

2. We charge pages before they get put into page tables now, so the
   somewhat fishy rule about "can be in page table as long as it's
   still locked" is now gone and boiled down to having an exclusive
   reference to the page.

Document the new rules. Any of the following will stabilize the
page->mem_cgroup association:

- the page lock
- LRU isolation
- lock_page_memcg()
- exclusive access to the page

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/memcontrol.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 491fdeec0ce4..865440e8438e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1201,9 +1201,8 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
  * @page: the page
  * @pgdat: pgdat of the page
  *
- * This function is only safe when following the LRU page isolation
- * and putback protocol: the LRU lock must be held, and the page must
- * either be PageLRU() or the caller must have isolated/allocated it.
+ * This function relies on page->mem_cgroup being stable - see the
+ * access rules in commit_charge().
  */
 struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgdat)
 {
@@ -2605,18 +2604,12 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg)
 {
 	VM_BUG_ON_PAGE(page->mem_cgroup, page);
 	/*
-	 * Nobody should be changing or seriously looking at
-	 * page->mem_cgroup at this point:
-	 *
-	 * - the page is uncharged
-	 *
-	 * - the page is off-LRU
-	 *
-	 * - an anonymous fault has exclusive page access, except for
-	 *   a locked page table
+	 * Any of the following ensures page->mem_cgroup stability:
 	 *
-	 * - a page cache insertion, a swapin fault, or a migration
-	 *   have the page locked
+	 * - the page lock
+	 * - LRU isolation
+	 * - lock_page_memcg()
+	 * - exclusive reference
 	 */
 	page->mem_cgroup = memcg;
 }
-- 
2.26.2

