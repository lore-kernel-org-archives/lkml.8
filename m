Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418CEC54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17294207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgELIKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 04:10:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:11423 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgELIKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 04:10:20 -0400
IronPort-SDR: 54xj/BhAJMUvOAfzFZgHyubc2GCiaWNQySoqSXLVerc78ci9Vzm10MQt0XTXjoPAxpnwnjbrr0
 vLB4S+XssYDg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 01:10:19 -0700
IronPort-SDR: OsM4htZREq/fP95+zNDZd4XFKhkyLYJ0oXakQLjEtdRaMbAPluDdUsMy3OLscT0hwaHnxw+6k3
 LDetXrElL1fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,383,1583222400"; 
   d="scan'208";a="371488026"
Received: from liming1-mobl1.ccr.corp.intel.com (HELO yhuang-mobile.ccr.corp.intel.com) ([10.254.212.233])
  by fmsmga001.fm.intel.com with ESMTP; 12 May 2020 01:10:17 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH -V2] mm, swap: Use prandom_u32_max()
Date:   Tue, 12 May 2020 16:10:13 +0800
Message-Id: <20200512081013.520201-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve the code readability and take advantage of the common
implementation.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
---

Changelog:

v2:

- Revise the patch description per Michal's comments.

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

