Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8886BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 644A62075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592870375;
	bh=2OwgDfY9J2es0wq3aPDxl3nxMrgbdyAY0myLa2Sqmog=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=WzMPJXIQxsq39NT1040IFmwZaHloRaVOzH5i3iyzGkC1rGa0S0h59myO+JT65J/F3
	 7qwBCZl7wstQXQejDhOuTIcEl7wsw5LdzyooCpN4k80fxgjVsLqnLJshNVcDmTfBlQ
	 2ppgfTgZmSNFs414kDHWPSfyXpbovK3/KrczAsrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbgFVX7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:59:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728636AbgFVX7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:59:33 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88F9620727;
        Mon, 22 Jun 2020 23:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592870373;
        bh=2OwgDfY9J2es0wq3aPDxl3nxMrgbdyAY0myLa2Sqmog=;
        h=Date:From:To:Cc:Subject:From;
        b=C3Dct/bBNvay6NeT7uLjs5uFJABFs0MoIj4gqLRcTlzmZFF7H0FtOomU716ywWOFR
         yY0yUdHPNIU4hPoqCLRs3Oy1NN64l5h4CRVHPXe3U9fzoHm4YZL5cmu5xX2Fid1vgP
         XEfz40gQzipHJX3AbrBHnefhg8Si7vsTa9zCLMDU=
Date:   Mon, 22 Jun 2020 19:05:02 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] perf annotate: Use struct_size() helper
Message-ID: <20200623000502.GA18040@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes. Also, remove unnecessary
function disasm_line_size().

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 tools/perf/util/annotate.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 76bfb4a9d94e..9330520c34a0 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -43,6 +43,7 @@
 #include <linux/string.h>
 #include <subcmd/parse-options.h>
 #include <subcmd/run-command.h>
+#include <linux/overflow.h>
 
 /* FIXME: For the HE_COLORSET */
 #include "ui/browser.h"
@@ -775,7 +776,7 @@ static int annotated_source__alloc_histograms(struct annotated_source *src,
 	if (size > (SIZE_MAX - sizeof(struct sym_hist)) / sizeof(struct sym_hist_entry))
 		return -1;
 
-	sizeof_sym_hist = (sizeof(struct sym_hist) + size * sizeof(struct sym_hist_entry));
+	sizeof_sym_hist = struct_size(src->histograms, addr, size);
 
 	/* Check for overflow in zalloc argument */
 	if (sizeof_sym_hist > SIZE_MAX / nr_hists)
@@ -1167,13 +1168,6 @@ static void annotation_line__exit(struct annotation_line *al)
 	zfree(&al->line);
 }
 
-static size_t disasm_line_size(int nr)
-{
-	struct annotation_line *al;
-
-	return (sizeof(struct disasm_line) + (sizeof(al->data[0]) * nr));
-}
-
 /*
  * Allocating the disasm annotation line data with
  * following structure:
@@ -1193,7 +1187,7 @@ static struct disasm_line *disasm_line__new(struct annotate_args *args)
 	if (evsel__is_group_event(args->evsel))
 		nr = args->evsel->core.nr_members;
 
-	dl = zalloc(disasm_line_size(nr));
+	dl = zalloc(struct_size(dl, al.data, nr));
 	if (!dl)
 		return NULL;
 
-- 
2.27.0

