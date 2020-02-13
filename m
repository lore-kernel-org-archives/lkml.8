Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E29C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D831F21734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgBMSXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:23:33 -0500
Received: from mail5.windriver.com ([192.103.53.11]:53524 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgBMSXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:23:32 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 01DILNTo025707
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 13 Feb 2020 10:21:33 -0800
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.468.0; Thu, 13 Feb 2020 10:21:12 -0800
From:   <zhe.he@windriver.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <zhe.he@windriver.com>
Subject: [PATCH 2/2] perf: Normalize gcc parameter when generating arch errno table
Date:   Fri, 14 Feb 2020 02:21:06 +0800
Message-ID: <1581618066-187262-2-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581618066-187262-1-git-send-email-zhe.he@windriver.com>
References: <1581618066-187262-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

The $(CC) passed to arch_errno_names.sh may include a series of parameters
along with gcc itself. To avoid overwriting the following parameters of
arch_errno_names.sh and break the build like below, we just pick up the
first word of the $(CC).

find: unknown predicate `-m64/arch'
x86_64-wrs-linux-gcc: warning: '-x c' after last input file has no effect
x86_64-wrs-linux-gcc: error: unrecognized command line option '-m64/include/uapi/asm-generic/errno.h'
x86_64-wrs-linux-gcc: fatal error: no input files

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 3eda9d4..7114c11 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -573,7 +573,7 @@ arch_errno_hdr_dir := $(srctree)/tools
 arch_errno_tbl := $(srctree)/tools/perf/trace/beauty/arch_errno_names.sh
 
 $(arch_errno_name_array): $(arch_errno_tbl)
-	$(Q)$(SHELL) '$(arch_errno_tbl)' $(CC) $(arch_errno_hdr_dir) > $@
+	$(Q)$(SHELL) '$(arch_errno_tbl)' $(firstword $(CC)) $(arch_errno_hdr_dir) > $@
 
 sync_file_range_arrays := $(beauty_outdir)/sync_file_range_arrays.c
 sync_file_range_tbls := $(srctree)/tools/perf/trace/beauty/sync_file_range.sh
-- 
2.7.4

