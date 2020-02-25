Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4659EC35DF2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264D424687
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgBYFPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 00:15:13 -0500
Received: from mga12.intel.com ([192.55.52.136]:61438 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgBYFPM (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 00:15:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 21:15:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,482,1574150400"; 
   d="scan'208";a="350074480"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2020 21:15:09 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 1/2] perf util: Print al_addr when symbol is not found
Date:   Tue, 25 Feb 2020 13:14:37 +0800
Message-Id: <20200225051438.16253-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225051438.16253-1-yao.jin@linux.intel.com>
References: <20200225051438.16253-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For branch mode, if the symbol is not found, it prints
the address.

For example, 0x0000555eee0365a0 in below output.

Overhead  Command  Source Shared Object  Source Symbol                            Target Symbol
  17.55%  div      libc-2.27.so          [.] __random                             [.] __random
   6.11%  div      div                   [.] 0x0000555eee0365a0                   [.] rand
   6.10%  div      libc-2.27.so          [.] rand                                 [.] 0x0000555eee036769
   5.80%  div      libc-2.27.so          [.] __random_r                           [.] __random
   5.72%  div      libc-2.27.so          [.] __random                             [.] __random_r
   5.62%  div      libc-2.27.so          [.] __random_r                           [.] __random_r
   5.38%  div      libc-2.27.so          [.] __random                             [.] rand
   4.56%  div      libc-2.27.so          [.] __random                             [.] __random
   4.49%  div      div                   [.] 0x0000555eee036779                   [.] 0x0000555eee0365ff
   4.25%  div      div                   [.] 0x0000555eee0365fa                   [.] 0x0000555eee036760

But it's not very easy to understand what the instructions
are in the binary. So this patch uses the al_addr instead.

With this patch, the output is

Overhead  Command  Source Shared Object  Source Symbol                            Target Symbol
  17.55%  div      libc-2.27.so          [.] __random                             [.] __random
   6.11%  div      div                   [.] 0x00000000000005a0                   [.] rand
   6.10%  div      libc-2.27.so          [.] rand                                 [.] 0x0000000000000769
   5.80%  div      libc-2.27.so          [.] __random_r                           [.] __random
   5.72%  div      libc-2.27.so          [.] __random                             [.] __random_r
   5.62%  div      libc-2.27.so          [.] __random_r                           [.] __random_r
   5.38%  div      libc-2.27.so          [.] __random                             [.] rand
   4.56%  div      libc-2.27.so          [.] __random                             [.] __random
   4.49%  div      div                   [.] 0x0000000000000779                   [.] 0x00000000000005ff
   4.25%  div      div                   [.] 0x00000000000005fa                   [.] 0x0000000000000760

Now we can use objdump to dump the object starting from 0x5a0.

For example,
objdump -d --start-address 0x5a0 div

00000000000005a0 <rand@plt>:
 5a0:   ff 25 2a 0a 20 00       jmpq   *0x200a2a(%rip)        # 200fd0 <__cxa_finalize@plt+0x200a20>
 5a6:   68 02 00 00 00          pushq  $0x2
 5ab:   e9 c0 ff ff ff          jmpq   570 <srand@plt-0x10>
 ...

 v2:
 ---
 No change

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/sort.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index ab0cfd790ad0..e860595576c2 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -869,7 +869,8 @@ static int hist_entry__sym_from_snprintf(struct hist_entry *he, char *bf,
 	if (he->branch_info) {
 		struct addr_map_symbol *from = &he->branch_info->from;
 
-		return _hist_entry__sym_snprintf(&from->ms, from->addr, he->level, bf, size, width);
+		return _hist_entry__sym_snprintf(&from->ms, from->al_addr,
+						 he->level, bf, size, width);
 	}
 
 	return repsep_snprintf(bf, size, "%-*.*s", width, width, "N/A");
@@ -881,7 +882,8 @@ static int hist_entry__sym_to_snprintf(struct hist_entry *he, char *bf,
 	if (he->branch_info) {
 		struct addr_map_symbol *to = &he->branch_info->to;
 
-		return _hist_entry__sym_snprintf(&to->ms, to->addr, he->level, bf, size, width);
+		return _hist_entry__sym_snprintf(&to->ms, to->al_addr,
+						 he->level, bf, size, width);
 	}
 
 	return repsep_snprintf(bf, size, "%-*.*s", width, width, "N/A");
-- 
2.17.1

