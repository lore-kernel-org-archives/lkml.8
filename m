Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FB5C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 06:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5933207D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 06:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgEPGrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 02:47:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:41251 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbgEPGrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 02:47:51 -0400
IronPort-SDR: Y8UDBmPyOEbLcI9uLnJWN08xJSQqChyKE856BxsH1PW3t95V5MPxrJCulFrUEEdy3l8FV7r2vn
 91MoXqOj4xsw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 23:47:50 -0700
IronPort-SDR: MWwpcoNGIUZHitX854RSvMz2jRCeunv+opN/2PqK1ojEY/UnWuiy9zY2VIJndjE/D9Ao/7P6Kf
 GpYVqLS88WKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,398,1583222400"; 
   d="scan'208";a="464984933"
Received: from shbuild999.sh.intel.com ([10.239.146.107])
  by fmsmga005.fm.intel.com with ESMTP; 15 May 2020 23:47:47 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [PATCH v3 2/3] mm/util.c: make vm_memory_committed() more accurate
Date:   Sat, 16 May 2020 14:47:39 +0800
Message-Id: <1589611660-89854-3-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589611660-89854-1-git-send-email-feng.tang@intel.com>
References: <1589611660-89854-1-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

percpu_counter_sum_positive() will provide more accurate info.

As with percpu_counter_read_positive(), in worst case the deviation
could be 'batch * nr_cpus', which is totalram_pages/256 for now,
and will be more when the batch gets enlarged.

Its time cost is about 800 nanoseconds on a 2C/4T platform and
2~3 microseconds on a 2S/36C/72T server in normal case, and in
worst case where vm_committed_as's spinlock is under severe
contention, it costs 30~40 microseconds for the 2S/36C/72T sever,
which should be fine for its only two users: /proc/meminfo and
HyperV balloon driver's status trace per second.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 988d11e..3de78e9 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -774,7 +774,7 @@ struct percpu_counter vm_committed_as ____cacheline_aligned_in_smp;
  */
 unsigned long vm_memory_committed(void)
 {
-	return percpu_counter_read_positive(&vm_committed_as);
+	return percpu_counter_sum_positive(&vm_committed_as);
 }
 EXPORT_SYMBOL_GPL(vm_memory_committed);
 
-- 
2.7.4

