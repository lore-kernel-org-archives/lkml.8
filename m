Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C9BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C935A2465B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frFhI/01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgAVRn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 12:43:56 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32935 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgAVRnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:43:55 -0500
Received: by mail-pg1-f193.google.com with SMTP id 6so3911865pgk.0;
        Wed, 22 Jan 2020 09:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=q6OeJXPwWEnUOz8Lo8TsCrdbcxtEJkAXopv2X8QuM5w=;
        b=frFhI/01UG5hBEhRBNTRsQ8gQ7uui7kbxicIpPPmSOJO9jKyybhVB4WGX7s5C+DLHu
         Kj3G/zYYUiY/xG/esphxYWD/NWnswj7tpeIx1vZoaf81IaQJNhAxHfe5J87P15Ym9qJn
         uFoQUNGC5cjE8lxFiDYgyIsRO8LkKbA0ouNEU7cSPcM3gH5TGDCx/vBDPxTcOANC6Pa5
         Z90aLXZh8QXXtojTzimMsh21X7hI1QW2bO8AC1RarzJipn8h+O+JEIDpBdB8vICJQQRf
         KLT5VtRdYJG2pPV2QWIvE6otc+2B9JkLdDnHHC0WajU8i2w2qonU2MCHlxFW6xAPzjhi
         fuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=q6OeJXPwWEnUOz8Lo8TsCrdbcxtEJkAXopv2X8QuM5w=;
        b=LdxUg4AqdIheuAj0A9sjEgU5X518MWj3Znsdz8B8z+k8qolFeGbUQrUt0Lt8PXyxuh
         zrVvueu84NFAb5Z0kVgb46FHzAmakN4KoV7YRwa7HuQ8IedCdVGWJiWrMEp+TYkpQXlB
         OznTBIJAlXQ9velpfwC02nwpMRSvsmeYjjEMNrHAKKsA/6bYXS96p32QoacsZUdSQHTa
         aJIrHmp9dUjNsd6HWF+AJNYR5bdy8dTCXAT5Qfw09uGzvvqNTl2JOSFFba9Zep/NYzs7
         pZi+yvasuXmOBAsL1UeN5W/3M/2jC+THiv8XSLroW9z+6qgI5G33K1Dnfv0hnDBjJMlI
         4Syg==
X-Gm-Message-State: APjAAAVFxBhfgS1neVKSCR8o8gM6YlllnIqwkY5fZyFL+8LqRQc9CZwG
        RxUUeiRitIxqCrzDsiyZrSo=
X-Google-Smtp-Source: APXvYqyH85Ir7jeF2L2PGXga7oXOxOc4t10gnYRlYbAXz1IVn0jy4XgCW6Pn8gVQFzUlBQ4rw/q4Tw==
X-Received: by 2002:a62:33c6:: with SMTP id z189mr3589982pfz.246.1579715034307;
        Wed, 22 Jan 2020 09:43:54 -0800 (PST)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id j125sm47173382pfg.160.2020.01.22.09.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jan 2020 09:43:53 -0800 (PST)
Subject: [PATCH v16.1 7/9] mm/page_reporting: Rotate reported pages to the
 tail of the list
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     kvm@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org,
        willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz
Cc:     yang.zhang.wz@gmail.com, nitesh@redhat.com, konrad.wilk@oracle.com,
        david@redhat.com, pagupta@redhat.com, riel@surriel.com,
        lcapitulino@redhat.com, dave.hansen@intel.com,
        wei.w.wang@intel.com, aarcange@redhat.com, pbonzini@redhat.com,
        dan.j.williams@intel.com, alexander.h.duyck@linux.intel.com,
        osalvador@suse.de
Date:   Wed, 22 Jan 2020 09:43:53 -0800
Message-ID: <20200122174353.6142.56871.stgit@localhost.localdomain>
In-Reply-To: <20200122173040.6142.39116.stgit@localhost.localdomain>
References: <20200122173040.6142.39116.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Rather than walking over the same pages again and again to get to the pages
that have yet to be reported we can save ourselves a significant amount of
time by simply rotating the list so that when we have a full list of
reported pages the head of the list is pointing to the next non-reported
page. Doing this should save us some significant time when processing each
free list.

This doesn't gain us much in the standard case as all of the non-reported
pages should be near the top of the list already. However in the case of
page shuffling this results in a noticeable improvement. Below are the
will-it-scale page_fault1 w/ THP numbers for 16 tasks with and without
this patch.

Without:
tasks   processes       processes_idle  threads         threads_idle
16      8093776.25      0.17            5393242.00      38.20

With:
tasks   processes       processes_idle  threads         threads_idle
16      8283274.75      0.17            5594261.00      38.15

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 mm/page_reporting.c |   30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 1047c6872d4f..6885e74c2367 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -131,17 +131,27 @@ void __page_reporting_notify(void)
 		if (PageReported(page))
 			continue;
 
-		/* Attempt to pull page from list */
-		if (!__isolate_free_page(page, order))
-			break;
+		/* Attempt to pull page from list and place in scatterlist */
+		if (*offset) {
+			if (!__isolate_free_page(page, order)) {
+				next = page;
+				break;
+			}
 
-		/* Add page to scatter list */
-		--(*offset);
-		sg_set_page(&sgl[*offset], page, page_len, 0);
+			/* Add page to scatter list */
+			--(*offset);
+			sg_set_page(&sgl[*offset], page, page_len, 0);
 
-		/* If scatterlist isn't full grab more pages */
-		if (*offset)
 			continue;
+		}
+
+		/*
+		 * Make the first non-processed page in the free list
+		 * the new head of the free list before we release the
+		 * zone lock.
+		 */
+		if (&page->lru != list && !list_is_first(&page->lru, list))
+			list_rotate_to_front(&page->lru, list);
 
 		/* release lock before waiting on report processing */
 		spin_unlock_irq(&zone->lock);
@@ -169,6 +179,10 @@ void __page_reporting_notify(void)
 			break;
 	}
 
+	/* Rotate any leftover pages to the head of the freelist */
+	if (&next->lru != list && !list_is_first(&next->lru, list))
+		list_rotate_to_front(&next->lru, list);
+
 	spin_unlock_irq(&zone->lock);
 
 	return err;

