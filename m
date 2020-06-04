Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986E9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70327207F5
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptx/FA/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgFDNjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgFDNjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:39:47 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293B8C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 06:39:47 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id n9so2208485plk.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xdNQxpJtISS4o6vSnha6RqnWoqxwne3xIxfhUtiWq4E=;
        b=ptx/FA/q9YK7emZal29VXFiq66Cn4ubmP6hwI1j4dhV3pxqqiLfOUbMobRWvthzHZb
         cxRSI1jNNmFd2mZklBhaBtQRD9dRF51IKgNb7cYHHhg/ahGEkSbMZRMMy8eJmPjndFkI
         yqFUTixfSpF4hhHVpdDRJ+J42RKcnJ7L1VDzzvOHN+xb9yDpEqH5Z+KeXGZUXLMY7OfK
         qpffryyj4QpWRsPzhboYUn64kraRv16xhPtE1PGBUKWEsSRxJ9tRN+BsFOqI+u32uR/S
         bOXNCVMBSO7vF7uItTIZit2rpUYVvBWkaAZ2U2rZMN5LcP4gSY34WsMWcOzFTHNMcITU
         umTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xdNQxpJtISS4o6vSnha6RqnWoqxwne3xIxfhUtiWq4E=;
        b=CsNGwHVqvlWu6LM6DHON1nLOTVxmz+gKRBi0jxkvgH8C/bMbJZsrkR5bqU4+M7r9xt
         E3ZPKTF1y3BEzDFFV2+q8xhQo/qsmCP7Sy3F0jMLe3jlPNuGg/xwNIztDkxOX2Pr8Hm2
         WyRkE/oSQ20rVKys7+wqe7+Bjvq3jQECgtxQPEAlyah24Vt/3prnn5zUloi4IhMZU4bi
         +d/T2WJQpwIK9gwhVIE/IYxnPeL6wyk49KHrfr+ceiEFO/K4ZnjVVHOWFUNCwQSFBLbm
         xAjp9Xvbm25hepbK5mPG1VaeRgNc1ozGROV5s3UIo8WLOrpVGhAnGw4OTXkORV808eGC
         VBNQ==
X-Gm-Message-State: AOAM532GZFxXD+CuemQTZzR51IoOatM5Qj/5sdC+9g51jfksMDRrwxtu
        ZFVksRpUr/83K2DE/i/MUJTQkDxJ
X-Google-Smtp-Source: ABdhPJyBfnbbCHIbmuWMniemDoympvaIcAtkiJiRkKf1Fxtt+P7S3ZcDVwGn7XVdmSCe/cyz3YASow==
X-Received: by 2002:a17:902:a714:: with SMTP id w20mr4957921plq.125.1591277986510;
        Thu, 04 Jun 2020 06:39:46 -0700 (PDT)
Received: from cosmos ([122.171.238.207])
        by smtp.gmail.com with ESMTPSA id o25sm4069265pgn.84.2020.06.04.06.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jun 2020 06:39:46 -0700 (PDT)
Date:   Thu, 4 Jun 2020 19:09:42 +0530
From:   Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/memory_hotplug: fix default_zone_for_pfn() to include
 highmem zone range
Message-ID: <20200604133938.GA1513@cosmos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86_32, while onlining highmem sections, the func default_zone_for_pfn()
defaults target zone to ZONE_NORMAL (movable_node_enabled = 0). Onlining of
pages is successful, and these highmem pages are moved into zone_normal.

As a consequence, these pages are treated as low mem, and page addresses
are calculated using lowmem_page_address() which effectively overflows the
32 bit virtual addresses, leading to kernel panics and system becomes
unusable.

Change default_kernel_zone_for_pfn() to intersect highmem pfn range, and
calculate the default zone accordingly.

Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
---
 mm/memory_hotplug.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c4d5c45..30f101a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -725,8 +725,13 @@ static struct zone *default_kernel_zone_for_pfn(int nid, unsigned long start_pfn
 {
 	struct pglist_data *pgdat = NODE_DATA(nid);
 	int zid;
+	int nr_zones = ZONE_NORMAL;
 
-	for (zid = 0; zid <= ZONE_NORMAL; zid++) {
+#ifdef CONFIG_HIGHMEM
+	nr_zones = ZONE_HIGHMEM;
+#endif
+
+	for (zid = 0; zid <= nr_zones; zid++) {
 		struct zone *zone = &pgdat->node_zones[zid];
 
 		if (zone_intersects(zone, start_pfn, nr_pages))
-- 
2.7.4

