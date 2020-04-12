Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85420C2BB55
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 15:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62126206A1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 15:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgDLPE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 11:04:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37942 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgDLPE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 11:04:56 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jNeAI-0002xc-2E
        for linux-kernel@vger.kernel.org; Sun, 12 Apr 2020 15:04:54 +0000
Received: by mail-wr1-f69.google.com with SMTP id v14so5119158wrq.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 08:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=fJjRaEPRrE7fJirNO4lI/3HJIVV/jD3+1wYWzIXtexc=;
        b=i6HN8O7bloBjn74qixiQiMxW+URjdgmrX+D7ZMZc1qps+Mcp5WllmonwyFd06YteIy
         doI4DElmRFR4yPK5Wqld71OJK/hNHj8gYvsiT8UTmLJchQ8mFmDRB28BMOorQrCDUF1L
         eDqgq3aQOiMmn4lZ3UwaTrD9WwjMBdkCRQypcm4wqRNv60tG9RSLsUhxpNvD+fJKok0Y
         mjYzktOMRWC4ddcJzt4KKsmJYfa/3AhhuJJhJmEdFCvRQnKYtkoQHwn3Ky6cbCkDzEhP
         BYMecFXzPQtvACbPOuy4sOYzv7KdyWrqL+FfaHACdSern5UsTjbRLuQ/LUIIp9Ac2bz4
         CEfA==
X-Gm-Message-State: AGi0Pub0W5gNFAx7riMF5nOu9af+lMsAED6hMyWkXaxdqP9LkGktKBUV
        Fsuj+WrANeTUf4IYZKh8rleXrkFru8QdpsihzThXEpw/h70QYlPPJe+kn7DWeQIszQ0UFw4MftJ
        BbUwFRS7DVU4V2mOyNYWX3ftg/G1kojwVH4fO1/8Rqg==
X-Received: by 2002:a7b:cb59:: with SMTP id v25mr15439209wmj.13.1586703892954;
        Sun, 12 Apr 2020 08:04:52 -0700 (PDT)
X-Google-Smtp-Source: APiQypJn43HzYAGi+OOAgQeytkjnsRjwCWR7qWF6O1U3MMr0NRUzsqmBbLRbdblruK0EXV8imemNeQ==
X-Received: by 2002:a7b:cb59:: with SMTP id v25mr15439180wmj.13.1586703892591;
        Sun, 12 Apr 2020 08:04:52 -0700 (PDT)
Received: from localhost (host123-127-dynamic.36-79-r.retail.telecomitalia.it. [79.36.127.123])
        by smtp.gmail.com with ESMTPSA id p5sm12041710wrg.49.2020.04.12.08.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 08:04:52 -0700 (PDT)
Date:   Sun, 12 Apr 2020 17:04:49 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Huang Ying <ying.huang@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Anchal Agarwal <anchalag@amazon.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: swap: introduce fixed-size readahead policy
Message-ID: <20200412150449.GA740985@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new fixed-size swap-in readahead policy that can be selected
at run-time.

The global swap-in readahead policy takes in account the previous access
patterns, using a scaling heuristic to determine the optimal readahead
chunk dynamically.

This works pretty well in most cases, but like any heuristic there are
specific cases when this approach is not ideal, for example the swapoff
scenario.

During swapoff we just want to load back into memory all the swapped-out
pages and for this specific use case a fixed-size readahead is more
efficient.

This patch introduces a new sysfs interface
(/sys/kernel/mm/swap/swap_ra_policy) that can be set as following:

 - 0: current scaling swap-in readahead policy (default)
 - 1: fixed-size readahead policy (size is determined by
      vm.page-cluster)

The specific use case this patch is addressing is to improve swapoff
performance when a VM has been hibernated, resumed and all memory needs
to be forced back to RAM by disabling swap (see the test case below).

But it is not the only case where a fixed-size readahead can show its
benefits. More in general, the fixed-size policy can be beneficial in
all the cases where a large part of swapped out pages need to be loaded
back to memory as fast as possible.

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
                    default   fixed-size
                  readahead    readahead
                    -------   ----------
page-cluster=1       26.77s       21.25s
page-cluster=2       28.29s       12.66s
page-cluster=3       22.09s        8.77s
page-cluster=4       21.50s        7.60s
page-cluster=5       25.35s        7.75s
page-cluster=6       23.19s        8.32s
page-cluster=7       22.25s        9.40s
page-cluster=8       22.09s        8.93s

The fixed-size readahead should not be the default, because in a regular
live system the default scaling readahead policy just works better, but
there are special cases, like the swapoff one, where it would be really
useful to be able to select this other option (and eventually add more
policies in the future).

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 .../ABI/testing/sysfs-kernel-mm-swap          | 13 +++++
 include/linux/mm.h                            |  7 +++
 mm/swap.c                                     |  3 ++
 mm/swap_state.c                               | 49 ++++++++++++++++++-
 4 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-swap b/Documentation/ABI/testing/sysfs-kernel-mm-swap
index 94672016c268..c432f0edb20a 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-swap
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-swap
@@ -14,3 +14,16 @@ Description:	Enable/disable VMA based swap readahead.
 		still used for tmpfs etc. other users.  If set to
 		false, the global swap readahead algorithm will be
 		used for all swappable pages.
+
+What:		/sys/kernel/mm/swap/swap_ra_policy
+Date:		Apr 2020
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Select the global swap readahead policy.
+
+		At the moment the following policies are available:
+		  - 0 (scaling): default kernel heuristic that dynamically
+		    adjusts the swap-in readahead size based on previous hit
+		    ratio and access pattern
+
+		  - 1 (fixed): swap-in readahead is constant and it is
+		    determined only by sysctl's vm.page-cluster
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5a323422d783..1cc1a8ff588a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -74,6 +74,13 @@ static inline void totalram_pages_add(long count)
 extern void * high_memory;
 extern int page_cluster;
 
+/* Supported swap-in readahead policies */
+enum {
+	SWAP_READAHEAD_SCALING = 0,
+	SWAP_READAHEAD_FIXED,
+};
+extern int swap_readahead_policy;
+
 #ifdef CONFIG_SYSCTL
 extern int sysctl_legacy_va_layout;
 #else
diff --git a/mm/swap.c b/mm/swap.c
index bf9a79fed62d..15e02923052d 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -44,6 +44,9 @@
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
 
+/* Select page swap-in readahead policy */
+int swap_readahead_policy __read_mostly;
+
 static DEFINE_PER_CPU(struct pagevec, lru_add_pvec);
 static DEFINE_PER_CPU(struct pagevec, lru_rotate_pvecs);
 static DEFINE_PER_CPU(struct pagevec, lru_deactivate_file_pvecs);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index ebed37bbf7a3..cb6e80a4599a 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -498,7 +498,7 @@ static unsigned int __swapin_nr_pages(unsigned long prev_offset,
 	return pages;
 }
 
-static unsigned long swapin_nr_pages(unsigned long offset)
+static unsigned long swapin_nr_pages_scaling(unsigned long offset)
 {
 	static unsigned long prev_offset;
 	unsigned int hits, pages, max_pages;
@@ -518,6 +518,22 @@ static unsigned long swapin_nr_pages(unsigned long offset)
 	return pages;
 }
 
+static unsigned long swapin_nr_pages(unsigned long offset)
+{
+	unsigned long pages;
+
+	switch (swap_readahead_policy) {
+	case SWAP_READAHEAD_FIXED:
+		pages = 1 << READ_ONCE(page_cluster);
+		break;
+	default:
+		pages = swapin_nr_pages_scaling(offset);
+		break;
+	}
+
+	return pages;
+}
+
 /**
  * swap_cluster_readahead - swap in pages in hope we need them soon
  * @entry: swap entry of this memory
@@ -809,8 +825,39 @@ static struct kobj_attribute vma_ra_enabled_attr =
 	__ATTR(vma_ra_enabled, 0644, vma_ra_enabled_show,
 	       vma_ra_enabled_store);
 
+static ssize_t swap_ra_policy_show(struct kobject *kobj,
+				   struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", swap_readahead_policy);
+}
+
+static ssize_t swap_ra_policy_store(struct kobject *kobj,
+				    struct kobj_attribute *attr,
+				    const char *buf, size_t count)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	switch (val) {
+	case SWAP_READAHEAD_SCALING:
+	case SWAP_READAHEAD_FIXED:
+		swap_readahead_policy = val;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+static struct kobj_attribute swap_ra_policy_attr =
+	__ATTR(swap_ra_policy, 0644, swap_ra_policy_show,
+	       swap_ra_policy_store);
+
 static struct attribute *swap_attrs[] = {
 	&vma_ra_enabled_attr.attr,
+	&swap_ra_policy_attr.attr,
 	NULL,
 };
 
-- 
2.25.1

