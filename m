Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9FAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0E422063A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgGPPTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:19:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:53787 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbgGPPTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:19:04 -0400
IronPort-SDR: RT6XLp3JvTkKzB+72qPTmV7KFlZuWj+6RMf1SgeV9lLaOW70LDm9CVw5Ogl1UhcOn3b3AAP1M7
 5Kd8c6eCAmaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="136855998"
X-IronPort-AV: E=Sophos;i="5.75,359,1589266800"; 
   d="scan'208";a="136855998"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 08:19:03 -0700
IronPort-SDR: TnQij5CxdQumGdZHESD89KvhAwYbhmMznhYnNlCiElW61sYtvaXtvaT/FTcebNdHO81kfo7rjb
 lusAKllMWiHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,359,1589266800"; 
   d="scan'208";a="486138522"
Received: from thuang6-mobl.ccr.corp.intel.com (HELO rzhang1-mobile.ccr.corp.intel.com) ([10.249.173.59])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jul 2020 08:19:00 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
        len.brown@intel.com
Subject: [PATCH 1/3] perf/x86/rapl: Fix missing psys sysfs attributes
Date:   Thu, 16 Jul 2020 23:18:57 +0800
Message-Id: <20200716151859.6854-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a problem introduced by
commit 5fb5273a905c ("perf/x86/rapl: Use new MSR detection interface")
that perf event sysfs attributes for psys RAPL domain are missing.

Fixes: 5fb5273a905c ("perf/x86/rapl: Use new MSR detection interface")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
---
 arch/x86/events/rapl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 0f2bf59f4354..51ff9a3618c9 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -665,7 +665,7 @@ static const struct attribute_group *rapl_attr_update[] = {
 	&rapl_events_pkg_group,
 	&rapl_events_ram_group,
 	&rapl_events_gpu_group,
-	&rapl_events_gpu_group,
+	&rapl_events_psys_group,
 	NULL,
 };
 
-- 
2.17.1

