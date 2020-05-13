Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD88C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 378AF2065C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589413384;
	bh=3RSx/iEP5nlClH5EvnkR+0EJgWPf1xG9Ahhhm+mrsXE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=WG8r0afRxy0CWvHDbunZqodnuU/bV8NalwBlS/1MRXhSW+XrOyZCNigoOjA+QuYpl
	 i4qlrxFO+7SVQ35upk/aUIyrsf8OlkgAXd7EpXcTUlqsspndTBXO8gptS9qlSK4Dp/
	 097Cehc+V1D7Rk1rUp9enqdpwrk2xgIiJEAhqf/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732805AbgEMXnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 19:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732456AbgEMXnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:43:02 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C62F32054F;
        Wed, 13 May 2020 23:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589413382;
        bh=3RSx/iEP5nlClH5EvnkR+0EJgWPf1xG9Ahhhm+mrsXE=;
        h=Date:From:To:Cc:Subject:From;
        b=zhn7LvLTsOH6TeWToTx2TYe2IiazB+KyNk03xeHcUhWXlc8V1VcDT8Lq45B52xAO0
         TdqWwFNBHEAOqAdGhplPMd9kx0Kvc79CSh02v6bWE+aWrhc/RtiEHUEsSWTrCnJq0E
         8R3yG+MRBuxM600vPiFUSmGlnIB9kFee8iatpvwU=
Date:   Wed, 13 May 2020 18:47:38 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH perf/core] perf intel-pt: Fix clang build failure in
 intel_pt_synth_pebs_sample
Message-ID: <20200513234738.GA21211@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following build failure generated with command 
$ make CC=clang HOSTCC=clang -C tools/ perf:

util/intel-pt.c:1802:24: error: field 'br_stack' with variable sized type 'struct branch_stack' not at the end of a struct or class is a GNU extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
                        struct branch_stack br_stack;
                                            ^
1 error generated.

Fix this by reordering the members of struct br.

Clang version 11.0.0 was used.

Fixes: f283f293a60d ("perf tools: Replace zero-length array with flexible-array")
Reported-by: Ian Rogers <irogers@google.com>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Here to fix what I break. :)

 tools/perf/util/intel-pt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index f17b1e769ae4..b34179e3926f 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1799,8 +1799,8 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
 		struct {
-			struct branch_stack br_stack;
 			struct branch_entry entries[LBRS_MAX];
+			struct branch_stack br_stack;
 		} br;
 
 		if (items->mask[INTEL_PT_LBR_0_POS] ||
-- 
2.26.2

