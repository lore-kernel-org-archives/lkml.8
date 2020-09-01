Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAE3C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DC0B206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="SMKY9Vrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgIAMrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgIAMqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 08:46:25 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861F5C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 05:46:18 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id di5so404718qvb.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 05:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0EbJzeQX4jAOlaQv090h8txgX83njocsNSsm4gpQ07M=;
        b=SMKY9VrrqKbwRQ0E+ot5l7RltqosCCRkRECjN3d2NrsZRpvpNpcjobwDjf2wt4PpGe
         SbyhYFaiZs12gjEMRtRugWt5x1X7rl8f7Z478CRZhmId+Es1H+eERYn25MLlPfOnup54
         jk+ttq/l9yb0tYI9uag64iEDPmQSxYwdJW/W5bs8OR/OfPWDTaJc4qUihUxjpCIWk240
         SFLki13Wt3I5UuhaxHHEbwWFKqAnbPXgb5jqr2iNO+hIltZC0fTDQRpo4X7mMiQ54JNX
         v/hk+J6jVL9tx+bSV1YOAJZ7G0Kld0MCofBHLhbSuVvxZNFGj11e6KGm8ccVQ4Qp2e+K
         i+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0EbJzeQX4jAOlaQv090h8txgX83njocsNSsm4gpQ07M=;
        b=HZ9VS0xhL+z3viaQL2x7rMzGM+Fu7aq5Xe1NbbO6pwJ5Y+eP5RItTdQ5cDRsxlMSVE
         lkkiXc2sa/2FBOIf9iv+2GWvv0X2WFocqg/XOG2AXfUtzM+WIDWKzgM6MxcgBv71/1yp
         7J9R1Wmg6WdXFuIufgeEeFAX79c6SHi+PtgNVz9RR5R6U1ThBEY0M/U4T9z0vPnRNMZ6
         lGLrLbXMJbtmid9BPOBG+QkyC1+gIcFSwHrj3YbUhoGJkaTioyizkt24EjO1/qz8G7TV
         xQD689kfBysDImY1c/IqeOmgPx7cBCp2ZVcAoe7gdtVrJDrYl+bQWfQoEH2bh+5eksEE
         OWZw==
X-Gm-Message-State: AOAM530oXHLK/yO2dY90R5N125jmqoEwYiNcTRFCy9TMTuDqfbj7H+W8
        z36/Nuepog7P+K4/tY9KGkfiUOjFI72zPw==
X-Google-Smtp-Source: ABdhPJzI6VbDC4fq5pUk5Y0mvd9RYe8P9jfixUEyckDCLJXrCHMcKaIXzo96VnnXI5FL5iJI6WpL1g==
X-Received: by 2002:ad4:524e:: with SMTP id s14mr1683355qvq.36.1598964377184;
        Tue, 01 Sep 2020 05:46:17 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id l95sm1275537qte.36.2020.09.01.05.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 05:46:16 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, linux-mm@kvack.org, pasha.tatashin@soleen.com
Subject: [PATCH] mm/memory_hotplug: drain per-cpu pages again during memory offline
Date:   Tue,  1 Sep 2020 08:46:15 -0400
Message-Id: <20200901124615.137200-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race during page offline that can lead to infinite loop:
a page never ends up on a buddy list and __offline_pages() keeps
retrying infinitely or until a termination signal is received.

Thread#1 - a new process:

load_elf_binary
 begin_new_exec
  exec_mmap
   mmput
    exit_mmap
     tlb_finish_mmu
      tlb_flush_mmu
       release_pages
        free_unref_page_list
         free_unref_page_prepare
          set_pcppage_migratetype(page, migratetype);
             // Set page->index migration type below  MIGRATE_PCPTYPES

Thread#2 - hot-removes memory
__offline_pages
  start_isolate_page_range
    set_migratetype_isolate
      set_pageblock_migratetype(page, MIGRATE_ISOLATE);
        Set migration type to MIGRATE_ISOLATE-> set
        drain_all_pages(zone);
             // drain per-cpu page lists to buddy allocator.

Thread#1 - continue
         free_unref_page_commit
           migratetype = get_pcppage_migratetype(page);
              // get old migration type
           list_add(&page->lru, &pcp->lists[migratetype]);
              // add new page to already drained pcp list

Thread#2
Never drains pcp again, and therefore gets stuck in the loop.

The fix is to try to drain per-cpu lists again after
check_pages_isolated_cb() fails.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: stable@vger.kernel.org
---
 mm/memory_hotplug.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index e9d5ab5d3ca0..d6d54922bfce 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1575,6 +1575,15 @@ static int __ref __offline_pages(unsigned long start_pfn,
 		/* check again */
 		ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
 					    NULL, check_pages_isolated_cb);
+		/*
+		 * per-cpu pages are drained in start_isolate_page_range, but if
+		 * there are still pages that are not free, make sure that we
+		 * drain again, because when we isolated range we might
+		 * have raced with another thread that was adding pages to
+		 * pcp list.
+		 */
+		if (ret)
+			drain_all_pages(zone);
 	} while (ret);
 
 	/* Ok, all of our target is isolated.
-- 
2.25.1

