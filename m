Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136ABC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B58A4223EA
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599829139;
	bh=oGr46qlLv8X6ikVTrbl44cD9Uet5OSlJxQACmUVeejw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DMrqsLeRlIKneki2pFkxLUUkQGnKklhoF6wrt7DOq7jupGewkir7mT7nmS5TDOzmp
	 cK6AjZRiLlY5EHpgoR9ie1OcrJ5Qf7Gde0pbqkiLQUYypskJwB4vWw9z2m3fMGHDQ2
	 tZ2xPZgNZORYK4dz2G7nLmsveup0W7VIF1dsP+24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgIKM6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 08:58:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbgIKMye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:54:34 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1141E2075E;
        Fri, 11 Sep 2020 12:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599828831;
        bh=oGr46qlLv8X6ikVTrbl44cD9Uet5OSlJxQACmUVeejw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F9i4AChHmpor9FFYhbdtZsrYXOTIRQM7rKzrdZbohrEN/NRdO+uXHXff0FPRMvHb0
         YZo033JTkMj7jZ6IyCCSqGUeDL0xBzEdkPOVq8MRYz4wy6r3C3pvsIvWw6JonWcpnr
         FBENyfqAdg8fcKGtGIASBvmur4Y9y3Sc5cvQwEzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 4.4 04/62] mm, page_alloc: remove unnecessary variable from free_pcppages_bulk
Date:   Fri, 11 Sep 2020 14:45:47 +0200
Message-Id: <20200911122502.615839890@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911122502.395450276@linuxfoundation.org>
References: <20200911122502.395450276@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mel Gorman <mgorman@techsingularity.net>

commit e5b31ac2ca2cd0cf6bf2fcbb708ed01466c89aaa upstream.

The original count is never reused so it can be removed.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[dwagner: update context]
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/page_alloc.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -835,7 +835,6 @@ static void free_pcppages_bulk(struct zo
 {
 	int migratetype = 0;
 	int batch_free = 0;
-	int to_free = count;
 	unsigned long nr_scanned;
 
 	spin_lock(&zone->lock);
@@ -848,7 +847,7 @@ static void free_pcppages_bulk(struct zo
 	 * below while (list_empty(list)) loop.
 	 */
 	count = min(pcp->count, count);
-	while (to_free) {
+	while (count) {
 		struct page *page;
 		struct list_head *list;
 
@@ -868,7 +867,7 @@ static void free_pcppages_bulk(struct zo
 
 		/* This is the only non-empty list. Free them all. */
 		if (batch_free == MIGRATE_PCPTYPES)
-			batch_free = to_free;
+			batch_free = count;
 
 		do {
 			int mt;	/* migratetype of the to-be-freed page */
@@ -886,7 +885,7 @@ static void free_pcppages_bulk(struct zo
 
 			__free_one_page(page, page_to_pfn(page), zone, 0, mt);
 			trace_mm_page_pcpu_drain(page, 0, mt);
-		} while (--to_free && --batch_free && !list_empty(list));
+		} while (--count && --batch_free && !list_empty(list));
 	}
 	spin_unlock(&zone->lock);
 }


