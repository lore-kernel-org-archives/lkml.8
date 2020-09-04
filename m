Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EA0C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8250A2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="VHJ5Cez3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbgIDPPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730815AbgIDPOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:14:53 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EDEC061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:14:53 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w16so6587575qkj.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JZfJMp3zvHnMX4z50lv6bmh7AfNeSTMMAnF/ge8iWQ4=;
        b=VHJ5Cez3Zh2443E1mfYsjZ+8MpLSXNAKfoc4e2M5DNliw2MC18n71/lyCPHipV0WMD
         Ju0AhOf++WJ/c2/0sL1Wyk1NFOL8JLg2iC4XAc7y/+D0WKJSG5KubnRTJUm/RZZ4jKhg
         hmKyq4iVz9XzMzOCqYwZV0qaKNryVhmI5C0XfDZciaeHEFcDEG8Phnu285EfE5Yga+IU
         +jOgKaJgUKiokKz1AWf60SWM+7A0rWYlbP7qzVvCfe6FGhl1P5L4lcmsjnRuujazrRF2
         1b3O9908i0yMQVL6vQPX1kyHjrNdp5iy/TFE7u7jMOFq48ulwI/JQH7xh9BJqj3RnFtV
         NqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JZfJMp3zvHnMX4z50lv6bmh7AfNeSTMMAnF/ge8iWQ4=;
        b=SS0OFwadLATofdluVNlg5UWpARKeQTvJTQDpI2oiLlqB+9kCK67g0UIl8j3XTPnV1t
         98HM8Qv/O3e5IDFqStHCLtr9tT20c2cFgW/l6MxhG22GY9wdjpzBl6VyRGpxHNb6xg4y
         aGSsldkuNFjqPOe4ops6llIcMaVbiZtMNfXg4Wpsb1MxPSNOfcSIp3JcKQJ6s8foady1
         CskiD2OfzWeQQYgNo/wnKsYiVCPXsWtXe+itP7W5FmFD5MSH4eRPEqRoDAxfFKKTXKYR
         seP8O3bGITmXvhcvwfCWXKakA1yYT2HHOcNr6LvJL8Tzx1jtAuysC6Kz1aM2ruoEkLqk
         Xp9A==
X-Gm-Message-State: AOAM533gqqp+kRdmrtayjFaY8RVIEWA009ReBZV79u6wezJRFQ6OhRRP
        VqaJ8y/IWPICcgANojiC5q6n7bYkyIyaIA==
X-Google-Smtp-Source: ABdhPJw7MDic8qSUBtr4IY+EdB+g1H8j4jBm7crUPhFYDelqxCCMjuL6rAaxQt68VIsp9qLj91vyRw==
X-Received: by 2002:a05:620a:145:: with SMTP id e5mr8215251qkn.479.1599232491857;
        Fri, 04 Sep 2020 08:14:51 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id r21sm4802727qtj.80.2020.09.04.08.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:14:51 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, linux-mm@kvack.org, pasha.tatashin@soleen.com,
        osalvador@suse.de, richard.weiyang@gmail.com, david@redhat.com,
        vbabka@suse.cz, rientjes@google.com
Subject: [PATCH v3 1/2] mm/memory_hotplug: drain per-cpu pages again during memory offline
Date:   Fri,  4 Sep 2020 11:14:47 -0400
Message-Id: <20200904151448.100489-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904151448.100489-1-pasha.tatashin@soleen.com>
References: <20200904151448.100489-1-pasha.tatashin@soleen.com>
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

Fixes: c52e75935f8d ("mm: remove extra drain pages on pcp list")

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: stable@vger.kernel.org
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memory_hotplug.c | 14 ++++++++++++++
 mm/page_isolation.c |  8 ++++++++
 2 files changed, 22 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index e9d5ab5d3ca0..b11a269e2356 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1575,6 +1575,20 @@ static int __ref __offline_pages(unsigned long start_pfn,
 		/* check again */
 		ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
 					    NULL, check_pages_isolated_cb);
+		/*
+		 * per-cpu pages are drained in start_isolate_page_range, but if
+		 * there are still pages that are not free, make sure that we
+		 * drain again, because when we isolated range we might
+		 * have raced with another thread that was adding pages to pcp
+		 * list.
+		 *
+		 * Forward progress should be still guaranteed because
+		 * pages on the pcp list can only belong to MOVABLE_ZONE
+		 * because has_unmovable_pages explicitly checks for
+		 * PageBuddy on freed pages on other zones.
+		 */
+		if (ret)
+			drain_all_pages(zone);
 	} while (ret);
 
 	/* Ok, all of our target is isolated.
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 242c03121d73..63a3db10a8c0 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -170,6 +170,14 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * pageblocks we may have modified and return -EBUSY to caller. This
  * prevents two threads from simultaneously working on overlapping ranges.
  *
+ * Please note that there is no strong synchronization with the page allocator
+ * either. Pages might be freed while their page blocks are marked ISOLATED.
+ * In some cases pages might still end up on pcp lists and that would allow
+ * for their allocation even when they are in fact isolated already. Depending
+ * on how strong of a guarantee the caller needs drain_all_pages might be needed
+ * (e.g. __offline_pages will need to call it after check for isolated range for
+ * a next retry).
+ *
  * Return: the number of isolated pageblocks on success and -EBUSY if any part
  * of range cannot be isolated.
  */
-- 
2.25.1

