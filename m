Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E5BC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3647421D79
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgIIJrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:47:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:26311 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgIIJry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:47:54 -0400
IronPort-SDR: RO/bgEntUDYW5lkxOuWxu1wb8+SLTCBoFoDw0RYNEzeawNi5bJEMhRVRqGK995dEOyqGASvRCb
 DGZDyAZw83Bg==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="222504574"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="222504574"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 02:47:51 -0700
IronPort-SDR: K9Fcsi9tYeitJtcKN/OY3XAgAK6EsL4Nm4EaFACBJ0KxYfVDXRnfO+3OVAgt3pvncWYXpD36m0
 9Dodejd00VIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="300098165"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 09 Sep 2020 02:47:49 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        adrian.hunter@intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH] perf: Turn kernel address filters into linear address filters
Date:   Wed,  9 Sep 2020 12:47:43 +0300
Message-Id: <20200909094743.24698-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One thing that the address filters can't do at the moment is cover
anonymous mappings. Apparently, there is code out there that generates
executable code in anonymous mappings and executes it in place. And at
the moment we only allow file-based address filters for userspace.

The easiest way to do this is to repurpose the kernel filters and allow
those to be used on userspace addresses. The Intel PT driver at the moment
does enforce that non-file-based filters are only used with kernel
addresses, so that needs to be corrected. The Coresight ETM driver doesn't
enforce that, so no changes needed there.

No tooling changes required, either.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/events/intel/pt.c | 13 -------------
 kernel/events/core.c       | 22 ++++++++++------------
 2 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index e94af4a54d0d..2d981dbaac1b 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1347,11 +1347,6 @@ static void pt_addr_filters_fini(struct perf_event *event)
 	event->hw.addr_filters = NULL;
 }
 
-static inline bool valid_kernel_ip(unsigned long ip)
-{
-	return virt_addr_valid(ip) && kernel_ip(ip);
-}
-
 static int pt_event_addr_filters_validate(struct list_head *filters)
 {
 	struct perf_addr_filter *filter;
@@ -1366,14 +1361,6 @@ static int pt_event_addr_filters_validate(struct list_head *filters)
 		    filter->action == PERF_ADDR_FILTER_ACTION_START)
 			return -EOPNOTSUPP;
 
-		if (!filter->path.dentry) {
-			if (!valid_kernel_ip(filter->offset))
-				return -EINVAL;
-
-			if (!valid_kernel_ip(filter->offset + filter->size))
-				return -EINVAL;
-		}
-
 		if (++range > intel_pt_validate_hw_cap(PT_CAP_num_address_ranges))
 			return -EOPNOTSUPP;
 	}
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 57efe3b21e29..8579654d3fc7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9989,9 +9989,9 @@ enum {
 	IF_ACT_START,
 	IF_ACT_STOP,
 	IF_SRC_FILE,
-	IF_SRC_KERNEL,
+	IF_SRC_LINEAR,
 	IF_SRC_FILEADDR,
-	IF_SRC_KERNELADDR,
+	IF_SRC_LINEARADDR,
 };
 
 enum {
@@ -10005,9 +10005,9 @@ static const match_table_t if_tokens = {
 	{ IF_ACT_START,		"start" },
 	{ IF_ACT_STOP,		"stop" },
 	{ IF_SRC_FILE,		"%u/%u@%s" },
-	{ IF_SRC_KERNEL,	"%u/%u" },
+	{ IF_SRC_LINEAR,	"%u/%u" },
 	{ IF_SRC_FILEADDR,	"%u@%s" },
-	{ IF_SRC_KERNELADDR,	"%u" },
+	{ IF_SRC_LINEARADDR,	"%u" },
 	{ IF_ACT_NONE,		NULL },
 };
 
@@ -10022,7 +10022,7 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 	char *start, *orig, *filename = NULL;
 	substring_t args[MAX_OPT_ARGS];
 	int state = IF_STATE_ACTION, token;
-	unsigned int kernel = 0;
+	unsigned int linear = 0;
 	int ret = -EINVAL;
 
 	orig = fstr = kstrdup(fstr, GFP_KERNEL);
@@ -10059,9 +10059,9 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 			state = IF_STATE_SOURCE;
 			break;
 
-		case IF_SRC_KERNELADDR:
-		case IF_SRC_KERNEL:
-			kernel = 1;
+		case IF_SRC_LINEARADDR:
+		case IF_SRC_LINEAR:
+			linear = 1;
 			/* fall through */
 
 		case IF_SRC_FILEADDR:
@@ -10074,7 +10074,7 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 			if (ret)
 				goto fail;
 
-			if (token == IF_SRC_KERNEL || token == IF_SRC_FILE) {
+			if (token == IF_SRC_LINEAR || token == IF_SRC_FILE) {
 				*args[1].to = 0;
 				ret = kstrtoul(args[1].from, 0, &filter->size);
 				if (ret)
@@ -10105,8 +10105,6 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 		 */
 		if (state == IF_STATE_END) {
 			ret = -EINVAL;
-			if (kernel && event->attr.exclude_kernel)
-				goto fail;
 
 			/*
 			 * ACTION "filter" must have a non-zero length region
@@ -10116,7 +10114,7 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 			    !filter->size)
 				goto fail;
 
-			if (!kernel) {
+			if (!linear) {
 				if (!filename)
 					goto fail;
 
-- 
2.28.0

