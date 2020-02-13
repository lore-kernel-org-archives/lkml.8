Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D992C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8055C217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgBMSVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:21:32 -0500
Received: from mail.windriver.com ([147.11.1.11]:44839 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgBMSVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:21:32 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 01DIL9fM002236
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 13 Feb 2020 10:21:10 -0800 (PST)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.468.0; Thu, 13 Feb 2020 10:21:09 -0800
From:   <zhe.he@windriver.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <zhe.he@windriver.com>
Subject: [PATCH 1/2] perf: Be compatible with all python versions when fetching ldflags
Date:   Fri, 14 Feb 2020 02:21:05 +0800
Message-ID: <1581618066-187262-1-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

Since Python v3.8.0, with the following commit
0a8e57248b91 ("bpo-36721: Add --embed option to python-config (GH-13500)"),
--embed option must be passed to "python3-config --ldflags --embed" or
"python3-config --libs --embed" to get "-lpython3.8".

To make it compatible with all Python versons, according to the suggestion
in the commit log, we try with --embed first and then witout it if fails.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 80e55e7..b2eabcf 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -229,7 +229,7 @@ strip-libs  = $(filter-out -l%,$(1))
 PYTHON_CONFIG_SQ := $(call shell-sq,$(PYTHON_CONFIG))
 
 ifdef PYTHON_CONFIG
-  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) --ldflags 2>/dev/null)
+  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) --ldflags --embed 2>/dev/null || $(PYTHON_CONFIG_SQ) --ldflags 2>/dev/null)
   PYTHON_EMBED_LDFLAGS := $(call strip-libs,$(PYTHON_EMBED_LDOPTS))
   PYTHON_EMBED_LIBADD := $(call grep-libs,$(PYTHON_EMBED_LDOPTS)) -lutil
   PYTHON_EMBED_CCOPTS := $(shell $(PYTHON_CONFIG_SQ) --includes 2>/dev/null)
-- 
2.7.4

