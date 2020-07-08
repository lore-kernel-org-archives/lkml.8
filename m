Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB52C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5453D20739
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgGHHrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:47:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:6899 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgGHHrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:47:06 -0400
IronPort-SDR: PjpILuwgewSWZvroym3fYlfHk+ZqrbB4kES/dfthvYztOu6otM2+GaQhzobK/FLhWVTNOw7AsB
 /MU2rtOWXCkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="146824280"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="146824280"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 00:47:06 -0700
IronPort-SDR: DrQx0h5p6dIrRtmZiS/xZOu/bp1cXTGX951ma0Q/qpQ0qRebZxnQhftCxVIhIbTD56ePKgFOoh
 Th3AwOkTDqCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="388748492"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jul 2020 00:47:05 -0700
Received: from [10.249.226.44] (abudanko-mobl.ccr.corp.intel.com [10.249.226.44])
        by linux.intel.com (Postfix) with ESMTP id DE3715807FC;
        Wed,  8 Jul 2020 00:47:03 -0700 (PDT)
Subject: [PATCH v10 03/15] tools/libperf: avoid counting of nonfilterable
 fdarray fds
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4af50c95-36f6-7a61-5a22-2949970fe7a5@linux.intel.com>
Organization: Intel Corp.
Message-ID: <f7eedac1-fb94-c203-e1a8-fd399451b534@linux.intel.com>
Date:   Wed, 8 Jul 2020 10:47:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4af50c95-36f6-7a61-5a22-2949970fe7a5@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Avoid counting of struct pollfd *entries objects with
fdarray_flag__nonfilterable flag by fdarray__filter().
Nonfilterable objects are still processed if requested
events have been signaled for them.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/lib/api/fd/array.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
index 37f291e6fc21..d638484c4bbd 100644
--- a/tools/lib/api/fd/array.c
+++ b/tools/lib/api/fd/array.c
@@ -105,7 +105,8 @@ int fdarray__filter(struct fdarray *fda, short revents,
 			continue;
 		}
 
-		++nr;
+		if (!(fda->priv[fd].flags & fdarray_flag__nonfilterable))
+			++nr;
 	}
 
 	return nr;
-- 
2.24.1

