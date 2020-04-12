Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0BBC2BB86
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 09:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98462070A
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 09:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoeVsy/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgDLJOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 05:14:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44386 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgDLJOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 05:14:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so2334719plr.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 02:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=hUbPx5am7etltmgoue9kYTx6WYTCCq/rXLPPJIBdwBM=;
        b=hoeVsy/PTGVtnZswBoThfSYj3QyaEdgABmWYzdgE9+v4MzxAcHXiHwFyVjvbGuPHDt
         4cn1IWPV/t2tu5UVyplPVhq37lKqT/grtiihag1SZkKY6U+ypcsPgBGDNp1GItKNePFN
         biT7HlJHUef1ciLA/ywlvGGsG3PZkt1qQ5eM1Z21pSkdQ0eO+FhbxJ+7b5BO/VcaTszo
         nCWEKZBYiFBHhu+5SSUOMtOcPnlL7X9WnI4ENXAxSiDPemNEPkXjequM6r3ZVI7K6KRQ
         EkN8IKN5geL2OuSBZFen07/5LuU5FK4oCNY8Ujl1uHhX6mQDEippj0an3EZTa6n7g/rM
         gvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=hUbPx5am7etltmgoue9kYTx6WYTCCq/rXLPPJIBdwBM=;
        b=jYaH4ff5NzG2MD4KD+ywvbFqNFsqk5TUOTFf1eeC2xaWqEGqDtH3ExouKUcFdxECl9
         igUwwIkWg8rFRdoc9wSyYhNeQrAq+gq7xGads8QuvmrhVcs0GsFXfkexGr6LdVoTPnZE
         R9p8kG2R5now4GEtK650aMTFNfwq/rdpaw/5r+EDdZq3zFYeO72eumtUTQlPzBe1XQNf
         n2E0pE29u9g5ShS64w91N38uD4kv7jeOYQmiZjJDJ1pJybfwdXLsyePB2n0dtd4daduc
         AUHnMws+KQ1HTJ5Oul7caTD7qyz/kFd55YI+CXW3mPmnM2/i99Nc1oXyB2q5KT12GyS9
         +LHQ==
X-Gm-Message-State: AGi0PuYnIjPBTUHxE3sxrTDamX0YtwzSH/uxHJCPkq1q4F9MCEYN3S0f
        C3onK53oUypXkcXvc3Eq4aU=
X-Google-Smtp-Source: APiQypIi6PdmqU07abT760TSvrN+rjwg5fAVXPTDAPmm3ult7jHtilBHeAO7O8+uyjKEljrcAf1Bng==
X-Received: by 2002:a17:90a:f00b:: with SMTP id bt11mr15479384pjb.71.1586682863092;
        Sun, 12 Apr 2020 02:14:23 -0700 (PDT)
Received: from open-light-1.localdomain ([66.98.113.28])
        by smtp.gmail.com with ESMTPSA id bt19sm6173756pjb.3.2020.04.12.02.14.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2020 02:14:22 -0700 (PDT)
From:   liliangleo <liliang.opensource@gmail.com>
X-Google-Original-From: liliangleo <liliangleo@didiglobal.com>
Date:   Sun, 12 Apr 2020 05:08:56 -0400
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: [RFC PATCH 2/4] mm: Add batch size for free page reporting
Message-ID: <20200412090853.GA19578@open-light-1.localdomain>
Mail-Followup-To: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the page order as the only threshold for page reporting
is not flexible, add a batch size as another threshold, so
the reporting will be triggered only when the amount of free
page is bigger than the batch size.

Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Williamson <alex.williamson@redhat.com>

Signed-off-by: liliangleo <liliangleo@didiglobal.com>
---
 mm/page_reporting.c |  2 ++
 mm/page_reporting.h | 12 ++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 3a7084e508e1..dc7a22a4b752 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -14,6 +14,8 @@
 #define PAGE_REPORTING_DELAY	(2 * HZ)
 #define MAX_SCAN_NUM 1024
 
+unsigned long page_report_batch_size  __read_mostly = 4 * 1024 * 1024UL;
+
 static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
 
 enum {
diff --git a/mm/page_reporting.h b/mm/page_reporting.h
index aa6d37f4dc22..f18c85ecdfe0 100644
--- a/mm/page_reporting.h
+++ b/mm/page_reporting.h
@@ -12,6 +12,8 @@
 
 #define PAGE_REPORTING_MIN_ORDER	pageblock_order
 
+extern unsigned long page_report_batch_size;
+
 #ifdef CONFIG_PAGE_REPORTING
 DECLARE_STATIC_KEY_FALSE(page_reporting_enabled);
 void __page_reporting_notify(void);
@@ -33,6 +35,8 @@ static inline bool page_reported(struct page *page)
  */
 static inline void page_reporting_notify_free(unsigned int order)
 {
+	static long batch_size;
+
 	/* Called from hot path in __free_one_page() */
 	if (!static_branch_unlikely(&page_reporting_enabled))
 		return;
@@ -41,8 +45,12 @@ static inline void page_reporting_notify_free(unsigned int order)
 	if (order < PAGE_REPORTING_MIN_ORDER)
 		return;
 
-	/* This will add a few cycles, but should be called infrequently */
-	__page_reporting_notify();
+	batch_size += (1 << order) << PAGE_SHIFT;
+	if (batch_size >= page_report_batch_size) {
+		batch_size = 0;
+		/* This add a few cycles, but should be called infrequently */
+		__page_reporting_notify();
+	}
 }
 #else /* CONFIG_PAGE_REPORTING */
 #define page_reported(_page)	false
-- 
2.14.1

