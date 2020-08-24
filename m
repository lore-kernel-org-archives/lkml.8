Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8885C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8AAE20738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgHXPlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:41:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:35830 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbgHXPj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:39:28 -0400
IronPort-SDR: YRuS+pMq7q+hdfh0EtuDU4Ry7S0BBs7h3hbAEMHW8nYKCNu7DC8b2+k1o6RcZsOiB3gR8GpRzf
 8aMHbaTDh3cw==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="217463244"
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="217463244"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 08:39:06 -0700
IronPort-SDR: cBcXkfl5rSjbjwl9Z3iuDlYmeRSM9vgRVUTvZfLVpK418gpmX+ti9hqC9gM29nTOhqAs5/RY9V
 UjGtMtn/uOJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="338470458"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 24 Aug 2020 08:39:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 96267166; Mon, 24 Aug 2020 18:39:03 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH v1] sched/topology: Make compiler happy about unused constant definitions
Date:   Mon, 24 Aug 2020 18:39:02 +0300
Message-Id: <20200824153902.57875-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compilation of almost each file ends up with

 In file included from .../include/linux/energy_model.h:10,
		  from .../include/linux/device.h:16,
		  from .../drivers/spi/spi.c:8:
 .../include/linux/sched/topology.h:30:27: warning: ‘SD_DEGENERATE_GROUPS_MASK’ defined but not used [-Wunused-const-variable=]
    30 | static const unsigned int SD_DEGENERATE_GROUPS_MASK =
       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~
 ...

Make compiler happy by annotating the static constants with __maybwe_unused.

Fixes: 4ee4ea443a5d ("sched/topology: Introduce SD metaflag for flags needing > 1 groups")
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/sched/topology.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 2d59ca77103e..ec440b67599c 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -27,14 +27,14 @@ enum {
 
 /* Generate a mask of SD flags with the SDF_NEEDS_GROUPS metaflag */
 #define SD_FLAG(name, mflags) (name * !!((mflags) & SDF_NEEDS_GROUPS)) |
-static const unsigned int SD_DEGENERATE_GROUPS_MASK =
+static __maybe_unused const unsigned int SD_DEGENERATE_GROUPS_MASK =
 #include <linux/sched/sd_flags.h>
 0;
 #undef SD_FLAG
 
 #ifdef CONFIG_SCHED_DEBUG
 #define SD_FLAG(_name, mflags) [__##_name] = { .meta_flags = mflags, .name = #_name },
-static const struct {
+static __maybe_unused const struct {
 	unsigned int meta_flags;
 	char *name;
 } sd_flag_debug[] = {
-- 
2.28.0

