Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3526AC2BBC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 11:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CB2020753
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 11:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgDMLSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 07:18:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60584 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbgDMLSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 07:18:16 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jNx6T-0002TR-51
        for linux-kernel@vger.kernel.org; Mon, 13 Apr 2020 11:18:13 +0000
Received: by mail-wr1-f69.google.com with SMTP id o12so3464722wra.14
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 04:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4Wgt9hYhRWXTtBSGQfGcckzQoy8qEw0JqLqmDtAt4rw=;
        b=oK0w3O/gvu2EePXE9XeoLIjDHCrMxcnOSKvtu0uTjTBE1fWSctE/KFw3hMp60YCU1x
         tg+P5lDNXcF2w2XNeRCj+6PyKRNaqEmVJkkidKdz/WsEw00h9X1010poLiFs6d5nxTwk
         oKQda7yufJN9CxlUePEW8HOINZTtYOAwGBZl9L1pNH4/hbfSrGqOLmy3jRDK9OGH/79q
         u8/iqYBTrPVKFlLlxCEBL4GjRpdDwib2cua0ceCfgbGGuONZXVtJbQc8dnuDzpFSf/3C
         CsP6dNkIDzX88zbO/47ebpK/yAL0FCPxrsz351HotCmiKN2RKzSEjpDELK4QHSN2O2QO
         EiqQ==
X-Gm-Message-State: AGi0Pubx8+4kyjgI4htrtsfYNYZ2vS+IJs2wD/Tvzs8WeuMYhnM5j9Hg
        1147ChFK3XbNfZF3KjykYafRH729u4oek1V3FLCev0DpecmApYSGd78tmTvx1LBaqAH9zLq7ZTl
        oqlwYa0eIpI+s7cw2rgi1QA6CSCiXNw0joNrVHf/U1g==
X-Received: by 2002:a1c:bd8b:: with SMTP id n133mr19275854wmf.175.1586776692666;
        Mon, 13 Apr 2020 04:18:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypKTNVrn76PNgX0RFMmFWzCcdcHufYo8SC1yL2UcDpaAG9qMAr8lhPd+RZcdsOiYVmIDPFnW7g==
X-Received: by 2002:a1c:bd8b:: with SMTP id n133mr19275822wmf.175.1586776692276;
        Mon, 13 Apr 2020 04:18:12 -0700 (PDT)
Received: from localhost (host123-127-dynamic.36-79-r.retail.telecomitalia.it. [79.36.127.123])
        by smtp.gmail.com with ESMTPSA id a1sm5377747wrn.80.2020.04.13.04.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 04:18:11 -0700 (PDT)
Date:   Mon, 13 Apr 2020 13:18:10 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Huang Ying <ying.huang@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Anchal Agarwal <anchalag@amazon.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: swap: use fixed-size readahead during swapoff
Message-ID: <20200413111810.GA801367@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The global swap-in readahead policy takes in account the previous access
patterns, using a scaling heuristic to determine the optimal readahead
chunk dynamically.

This works pretty well in most cases, but like any heuristic there are
specific cases when this approach is not ideal, for example the swapoff
scenario.

During swapoff we just want to load back into memory all the swapped-out
pages and for this specific use case a fixed-size readahead is more
efficient.

The specific use case this patch is addressing is to improve swapoff
performance when a VM has been hibernated, resumed and all memory needs
to be forced back to RAM by disabling swap (see the test case below).

But it is not the only case where a fixed-size readahead can show its
benefits. More in general, the fixed-size approach can be beneficial in
all the cases when a task that is using a large part of swapped out
pages needs to load them back to memory as fast as possible.

Testing environment
===================

 - Host:
   CPU: 1.8GHz Intel Core i7-8565U (quad-core, 8MB cache)
   HDD: PC401 NVMe SK hynix 512GB
   MEM: 16GB

 - Guest (kvm):
   8GB of RAM
   virtio block driver
   16GB swap file on ext4 (/swapfile)

Test case
=========
 - allocate 85% of memory
 - `systemctl hibernate` to force all the pages to be swapped-out to the
   swap file
 - resume the system
 - measure the time that swapoff takes to complete:
   # /usr/bin/time swapoff /swapfile

Result
======
                5.6 vanilla   5.6 w/ this patch
                -----------   -----------------
page-cluster=1       26.77s              21.25s
page-cluster=2       28.29s              12.66s
page-cluster=3       22.09s               8.77s
page-cluster=4       21.50s               7.60s
page-cluster=5       25.35s               7.75s
page-cluster=6       23.19s               8.32s
page-cluster=7       22.25s               9.40s
page-cluster=8       22.09s               8.93s

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
Changes in v2:
 - avoid introducing a new ABI to select the fixed-size readahead

NOTE: after running some tests with this new patch I don't see any
difference in terms of performance, so I'm reporting the same test
result of the previous version.

 mm/swap_state.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index ebed37bbf7a3..c71abc8df304 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -20,6 +20,7 @@
 #include <linux/migrate.h>
 #include <linux/vmalloc.h>
 #include <linux/swap_slots.h>
+#include <linux/oom.h>
 #include <linux/huge_mm.h>
 
 #include <asm/pgtable.h>
@@ -507,6 +508,14 @@ static unsigned long swapin_nr_pages(unsigned long offset)
 	max_pages = 1 << READ_ONCE(page_cluster);
 	if (max_pages <= 1)
 		return 1;
+	/*
+	 * If current task is using too much memory or swapoff is running
+	 * simply use the max readahead size. Since we likely want to load a
+	 * lot of pages back into memory, using a fixed-size max readhaead can
+	 * give better performance in this case.
+	 */
+	if (oom_task_origin(current))
+		return max_pages;
 
 	hits = atomic_xchg(&swapin_readahead_hits, 0);
 	pages = __swapin_nr_pages(prev_offset, offset, hits, max_pages,
-- 
2.25.1

