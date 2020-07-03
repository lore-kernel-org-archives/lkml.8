Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE01C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39573206B6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgGCHma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:42:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:50470 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgGCHm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:42:28 -0400
IronPort-SDR: nO21T2mnvmOsbrghMyAX8kKroA/JG2RivgdXqTfoN0i58EVKAQOEAndxVkrhGZBxUSnBI+wu/Z
 yY2VCGxizoJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="144632551"
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="144632551"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 00:42:28 -0700
IronPort-SDR: 6k6wbxWM8Gt79kK5XHdkrZnjuch3hvq0tBmUka+RQBXiXtJFtAapJdU6y5qCya95NPA4nmbYxI
 0Cd2np4ZUosg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="296142830"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 03 Jul 2020 00:42:28 -0700
Received: from [10.249.231.67] (abudanko-mobl.ccr.corp.intel.com [10.249.231.67])
        by linux.intel.com (Postfix) with ESMTP id 55C5D580784;
        Fri,  3 Jul 2020 00:42:26 -0700 (PDT)
Subject: [PATCH v9 03/15] tools/libperf: don't count nonfilterable fds by
 fdarray__filter()
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <a4d5db4a-f25c-38dc-1c41-321a886cb122@linux.intel.com>
Organization: Intel Corp.
Message-ID: <f3ef026f-a7c9-fec6-a58a-1231e38cfe14@linux.intel.com>
Date:   Fri, 3 Jul 2020 10:42:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a4d5db4a-f25c-38dc-1c41-321a886cb122@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Avoid counting of struct pollfd *entries objects with
fdarray_prop__nonfilterable propery by fdarray__filter().
Non-filterable objects are still processed if monitored
events have been signaled for them.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/lib/api/fd/array.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
index a4223f8cb1ce..e902c0260414 100644
--- a/tools/lib/api/fd/array.c
+++ b/tools/lib/api/fd/array.c
@@ -105,7 +105,8 @@ int fdarray__filter(struct fdarray *fda, short revents,
 			continue;
 		}
 
-		++nr;
+		if (!(fda->prop[fd].bits & fdarray_prop__nonfilterable))
+			++nr;
 	}
 
 	return nr;
-- 
2.24.1


