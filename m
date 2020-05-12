Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FE2C54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 191D120575
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgELGmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 02:42:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:40946 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgELGmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:42:44 -0400
IronPort-SDR: UCfaLSUeia/RFp2I8nygP95OmvnPplJjDIHsT2TegA/p3wy8cy8jFsVelvntbtiEyYAeQJ6yvl
 hoA9ytvJPHzA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 23:42:44 -0700
IronPort-SDR: 1tiEiWhxupsymV5zFEjn4Lx/KOB/N5fKsP5Dv6VPZaVYK01KcefeemHtX/AAofvKteE/wX5Igv
 fGBE7U9tTxrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,382,1583222400"; 
   d="scan'208";a="371468310"
Received: from liming1-mobl1.ccr.corp.intel.com (HELO yhuang-mobile.ccr.corp.intel.com) ([10.254.212.233])
  by fmsmga001.fm.intel.com with ESMTP; 11 May 2020 23:42:42 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH] mm, swap: Use prandom_u32_max()
Date:   Tue, 12 May 2020 14:41:46 +0800
Message-Id: <20200512064147.514493-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve the code readability and get random number with higher
quality.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
---
 mm/swapfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index a0a123e59ce6..2ec8b21201d6 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3220,7 +3220,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		 * select a random position to start with to help wear leveling
 		 * SSD
 		 */
-		p->cluster_next = 1 + (prandom_u32() % p->highest_bit);
+		p->cluster_next = 1 + prandom_u32_max(p->highest_bit);
 		nr_cluster = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
 
 		cluster_info = kvcalloc(nr_cluster, sizeof(*cluster_info),
-- 
2.26.2

