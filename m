Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DDBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9BA621D79
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgGNJEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:04:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:47839 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbgGNJEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:04:38 -0400
IronPort-SDR: TiZdxSlaRL5Qi/iOnWV4fz/fp+QKSvdk0URFJKrgB+DPaABXNvPul89CaOoAKeTbWhc2BklC5t
 KQ+MLniIR61A==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="213655114"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="213655114"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 02:04:38 -0700
IronPort-SDR: BD4dmx4DWuCA2manCzPyNhWs0KHP96TE+GGFMnX6kAoTOpErQ3Xi+zlrR/GXyePQArceBvpUjD
 MFZx6UGCyFSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="299469547"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 14 Jul 2020 02:04:38 -0700
Received: from [10.249.230.149] (abudanko-mobl.ccr.corp.intel.com [10.249.230.149])
        by linux.intel.com (Postfix) with ESMTP id D8155580814;
        Tue, 14 Jul 2020 02:04:33 -0700 (PDT)
Subject: [PATCH v11 03/15] tools/libperf: avoid counting of nonfilterable
 fdarray fds
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <037d737f-0ada-a9f0-9686-f7521ca6fbc3@linux.intel.com>
Organization: Intel Corp.
Message-ID: <7123e415-4b42-1884-18d9-a0e9e150470b@linux.intel.com>
Date:   Tue, 14 Jul 2020 12:04:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <037d737f-0ada-a9f0-9686-f7521ca6fbc3@linux.intel.com>
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


