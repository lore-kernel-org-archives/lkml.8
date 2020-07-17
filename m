Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8498C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87B492071A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgGQHAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:00:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:32068 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgGQHAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:00:20 -0400
IronPort-SDR: WfG1cA4qz+B4PF/0Db3of46Men9YP2Y4uDl12UculO5woWH1d7DnAtE4KClSkdaHybDdQQtKtJ
 n1DvQNvQJFNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="150926874"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="150926874"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:00:19 -0700
IronPort-SDR: wuSioCnoWCGde7JobIhlkndenf9keMinGmAjhxVQuUbXwcUaFzVikvqIlvRgKwnUNStwFZL4oJ
 tet4gaEeJ8iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="286729909"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 17 Jul 2020 00:00:19 -0700
Received: from [10.249.224.34] (abudanko-mobl.ccr.corp.intel.com [10.249.224.34])
        by linux.intel.com (Postfix) with ESMTP id 050CE58066D;
        Fri, 17 Jul 2020 00:00:16 -0700 (PDT)
Subject: [PATCH v12 03/15] tools/libperf: avoid counting of nonfilterable
 fdarray fds
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <8d91c3a0-3db4-0a7a-ae13-299adb444bd6@linux.intel.com>
Organization: Intel Corp.
Message-ID: <b5ab0d2c-b742-0032-e8d3-c8e2eb423c42@linux.intel.com>
Date:   Fri, 17 Jul 2020 10:00:15 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8d91c3a0-3db4-0a7a-ae13-299adb444bd6@linux.intel.com>
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
revents have been signaled for them.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/api/fd/array.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
index 01b3b89f9797..5e6cb9debe37 100644
--- a/tools/lib/api/fd/array.c
+++ b/tools/lib/api/fd/array.c
@@ -109,7 +109,8 @@ int fdarray__filter(struct fdarray *fda, short revents,
 			continue;
 		}
 
-		++nr;
+		if (!(fda->priv[fd].flags & fdarray_flag__nonfilterable))
+			++nr;
 	}
 
 	return nr;
-- 
2.24.1


