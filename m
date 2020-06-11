Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E51C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B222074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C9efrmYg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgFKW3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 18:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgFKW3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 18:29:00 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72FFC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 15:28:58 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 69so5865922otv.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 15:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=yQuXdwOztfCCh1OM0Y/znnoWVtA42w245nppjLu++SM=;
        b=C9efrmYgO5lfHiPabO9leNQkZRsdhlwEQGAWMA52SmmHSpafgnK+/l847DiwWOyBpj
         BAeGvslbj7wElzHda4DwvXS0ku8R79Ov2+bHCOh/Wc5QGdmv0su6wFBq2OfvGk2eaTGq
         u9MFt68ahkxY0WjRh3nuhhBOlrOW1MnYy8G6VghffVY4IdRBNay/7mj7FCjMHKTJv2ht
         GYwLGmvsv2JG78AtNqL4aAn4TX+q6VYmWxN1EECEZxgW8vMb3YpE6BvTsBs1SmWoAXbN
         k7edAcL63vK2Ld9noBiS6oSmq4WzbzSYWD0olZCdndrD21tLhFkspBj4YJEgjnw+feF7
         tXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=yQuXdwOztfCCh1OM0Y/znnoWVtA42w245nppjLu++SM=;
        b=XLcmGzQx3CL/42mhtV77HVGyoYNr0KoxHD2UgqzltaTtmn9HYJbL5J/HgX0zbo5U+S
         0zbhzdZGNJoBS9cskD/kLmsCVEHd03MyM0trOparA9Wu1lqjWVuOJe1xpMNk5eR2pqVG
         oTJDbANlBTijETPCgJVfQJnDKNOR5wXQtElpgIrNmL/qvrld6/K5Asptzwv1I3GM99YA
         kKnFdeMqmSxjLOGs66XDjhUIf7yS04yIfkaBsqFUUgONK8NFsS5YPQvOwYKB8YxnkB6Q
         3Ry5gz6rAZ1IcinYj1K5AnwclbtNZGlfrDfjoe+3vy6nvcJDrZijvl0dlyeRgrmPApL/
         bFXQ==
X-Gm-Message-State: AOAM530Nqk1LcFKWP57nZCOREoankKDaGr2h2IhLZfonVlyqmtkNEibe
        nk56XAGfGoaojr6nHkMRfU3hiA==
X-Google-Smtp-Source: ABdhPJwC0cSrxAVd/oScf78OXudE/J7qH0OBFpxhpmCCenQEqZL2QUwwdccMsG0/Q/aHQLe+aN7Mmg==
X-Received: by 2002:a9d:1c9b:: with SMTP id l27mr9063837ota.22.1591914537191;
        Thu, 11 Jun 2020 15:28:57 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 126sm974999oii.39.2020.06.11.15.28.54
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2020 15:28:56 -0700 (PDT)
Date:   Thu, 11 Jun 2020 15:28:54 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Subject: [PATCH alexv12 1/2] mm/compaction: fix isolate_migratepages_block()
 fails
Message-ID: <alpine.LSU.2.11.2006111526290.10801@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix lots of crashes under compaction load: isolate_migratepages_block()
must clean up appropriately when rejecting a page, setting PageLRU again
if it had been cleared; and a put_page() after get_page_unless_zero()
cannot safely be done while holding locked_lruvec - it may turn out to
be the final put_page(), which will take an lruvec lock when PageLRU.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
These fixes should be folded into 10/16 and 12/16,
I have not tried to figure out what belongs in which.

 mm/compaction.c |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

--- alexv12/mm/compaction.c	2020-06-11 13:24:52.037154793 -0700
+++ hughd/mm/compaction.c	2020-06-11 13:48:10.437046025 -0700
@@ -879,6 +879,7 @@ isolate_migratepages_block(struct compac
 		if (!valid_page && IS_ALIGNED(low_pfn, pageblock_nr_pages)) {
 			if (!cc->ignore_skip_hint && get_pageblock_skip(page)) {
 				low_pfn = end_pfn;
+				page = NULL;
 				goto isolate_abort;
 			}
 			valid_page = page;
@@ -971,10 +972,8 @@ isolate_migratepages_block(struct compac
 			goto isolate_fail;
 
 		/* Try isolate the page */
-		if (!TestClearPageLRU(page)) {
-			put_page(page);
-			goto isolate_fail;
-		}
+		if (!TestClearPageLRU(page))
+			goto isolate_fail_put;
 
 		rcu_read_lock();
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
@@ -1005,7 +1004,8 @@ isolate_migratepages_block(struct compac
 			 */
 			if (unlikely(PageCompound(page) && !cc->alloc_contig)) {
 				low_pfn += compound_nr(page) - 1;
-				goto isolate_fail;
+				SetPageLRU(page);
+				goto isolate_fail_put;
 			}
 		} else
 			rcu_read_unlock();
@@ -1038,6 +1038,15 @@ isolate_success:
 		}
 
 		continue;
+
+isolate_fail_put:
+		/* Avoid potential deadlock in freeing page under lru_lock */
+		if (locked_lruvec) {
+			unlock_page_lruvec_irqrestore(locked_lruvec, flags);
+			locked_lruvec = NULL;
+		}
+		put_page(page);
+
 isolate_fail:
 		if (!skip_on_failure)
 			continue;
@@ -1074,10 +1083,15 @@ isolate_fail:
 	 */
 	if (unlikely(low_pfn > end_pfn))
 		low_pfn = end_pfn;
+	page = NULL;
 
 isolate_abort:
 	if (locked_lruvec)
 		unlock_page_lruvec_irqrestore(locked_lruvec, flags);
+	if (page) {
+		SetPageLRU(page);
+		put_page(page);
+	}
 
 	/*
 	 * Updated the cached scanner pfn once the pageblock has been scanned
