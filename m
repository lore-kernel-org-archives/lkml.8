Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF224C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CEC620759
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="qoEmy1tK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgETX0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbgETX0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:26:05 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EDAC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:05 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id v15so2245823qvr.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AKHbKCUcHFNLRiN+4/B8hcf+bCyhRn4jQIo/5RZRxow=;
        b=qoEmy1tKSC0xVCapmBoUjzzu0j0Aj1hc9MAHx6UPt552xaOa7/mQRu++KzukzzNZfI
         cbpQWIDPyXI7+NHRVaY407+x+tWNgSW3vroKqtQezT1T1NMV23w7nWrp95GB9j0wemtV
         5b2TEXx1rWN2NAUKHxy3gEEm1DZkJmUEDomarBU/lnllwWeeOXsqvu3SnmAlT7vRsF5u
         VcpvqECxLTn+kF4zAZbQDeANdJzm8nwOKue9fLo+hzoZQV/kKSQ4Prxh0UsIjICys1Hb
         Udy11DHrzA3j0Nw3cr5UJlj9H9X8ZYBYZ0US2EzRxw+sD3LKVmtrSMLqmU4mupf6yTUz
         Bh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AKHbKCUcHFNLRiN+4/B8hcf+bCyhRn4jQIo/5RZRxow=;
        b=Sd0g9OmDLc7NaSDQLbehqOcLGdiNTXtEBX4xnbrGKbt+nrSd23yFvtzUb2xA82ffqp
         ozl4/25kxOjmhcD/gclb9u/Ulqys2Ox5sefvNVqBjFdyHhx5j7/SOEK5Ka6LmqrpgYj8
         BQgPtj1TBIN7gF5b14qQsIx70PlsMczfktjxO/jK2l0W8HHGWHMq3Hp8VyPXkNWtfC2V
         Zohjj0t4ZEjQuQzX3qKu3CTbaxHFvdZ6INWVxssxX3Z6WaMNQbx50Rx+PJ10HLdDKXmm
         FuXTYF9M9wctrNlPlG2Q/Dv7d0vX2D6q53LY3AN+TDsUV+kfnIJKVgld/RJakJS8yYwQ
         yD/Q==
X-Gm-Message-State: AOAM533cRdWyrPnzPBzI4qRb3DEehr4mg4eeh3KvaCPKpXUDbpSTP94m
        Q5utSonlhRbZ7eloikasIhU7sQ==
X-Google-Smtp-Source: ABdhPJwp9ZX1EUTNRzadr7k2Tw2KHmAiDcrX312wi7ypQUlBcRghIKz1r+baKMwt5HCjHNgueyfdGw==
X-Received: by 2002:ad4:4e6f:: with SMTP id ec15mr7582144qvb.88.1590017164865;
        Wed, 20 May 2020 16:26:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4708])
        by smtp.gmail.com with ESMTPSA id h15sm1879288qkh.18.2020.05.20.16.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 16:26:04 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/14] mm: allow swappiness that prefers reclaiming anon over the file workingset
Date:   Wed, 20 May 2020 19:25:14 -0400
Message-Id: <20200520232525.798933-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520232525.798933-1-hannes@cmpxchg.org>
References: <20200520232525.798933-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the advent of fast random IO devices (SSDs, PMEM) and in-memory
swap devices such as zswap, it's possible for swap to be much faster
than filesystems, and for swapping to be preferable over thrashing
filesystem caches.

Allow setting swappiness - which defines the rough relative IO cost of
cache misses between page cache and swap-backed pages - to reflect
such situations by making the swap-preferred range configurable.

v2: clarify how to calculate swappiness (Minchan Kim)

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 Documentation/admin-guide/sysctl/vm.rst | 23 ++++++++++++++++++-----
 kernel/sysctl.c                         |  3 ++-
 mm/vmscan.c                             |  2 +-
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 0329a4d3fa9e..d46d5b7013c6 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -831,14 +831,27 @@ When page allocation performance is not a bottleneck and you want all
 swappiness
 ==========
 
-This control is used to define how aggressive the kernel will swap
-memory pages.  Higher values will increase aggressiveness, lower values
-decrease the amount of swap.  A value of 0 instructs the kernel not to
-initiate swap until the amount of free and file-backed pages is less
-than the high water mark in a zone.
+This control is used to define the rough relative IO cost of swapping
+and filesystem paging, as a value between 0 and 200. At 100, the VM
+assumes equal IO cost and will thus apply memory pressure to the page
+cache and swap-backed pages equally; lower values signify more
+expensive swap IO, higher values indicates cheaper.
+
+Keep in mind that filesystem IO patterns under memory pressure tend to
+be more efficient than swap's random IO. An optimal value will require
+experimentation and will also be workload-dependent.
 
 The default value is 60.
 
+For in-memory swap, like zram or zswap, as well as hybrid setups that
+have swap on faster devices than the filesystem, values beyond 100 can
+be considered. For example, if the random IO against the swap device
+is on average 2x faster than IO from the filesystem, swappiness should
+be 133 (x + 2x = 200, 2x = 133.33).
+
+At 0, the kernel will not initiate swap until the amount of free and
+file-backed pages is less than the high watermark in a zone.
+
 
 unprivileged_userfaultfd
 ========================
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8a176d8727a3..7f15d292e44c 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -131,6 +131,7 @@ static unsigned long zero_ul;
 static unsigned long one_ul = 1;
 static unsigned long long_max = LONG_MAX;
 static int one_hundred = 100;
+static int two_hundred = 200;
 static int one_thousand = 1000;
 #ifdef CONFIG_PRINTK
 static int ten_thousand = 10000;
@@ -1391,7 +1392,7 @@ static struct ctl_table vm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &one_hundred,
+		.extra2		= &two_hundred,
 	},
 #ifdef CONFIG_HUGETLB_PAGE
 	{
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 70b0e2c6a4b9..43f88b1a4f14 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -161,7 +161,7 @@ struct scan_control {
 #endif
 
 /*
- * From 0 .. 100.  Higher means more swappy.
+ * From 0 .. 200.  Higher means more swappy.
  */
 int vm_swappiness = 60;
 /*
-- 
2.26.2

