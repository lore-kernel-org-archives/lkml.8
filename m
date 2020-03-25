Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2144C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B002078D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585140127;
	bh=Wli8F+1ksk0TZlAef8OEMZ2saGhWzuPop7nmvJ22bnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AgroER6G7E74HiQ4uDvaO9t2Y4eLFc9sNBuJYCdQy1sVa+q1Q5fTkzjXcobM3cPRQ
	 IHe0ic6lk7fiyZBFCIZDA5BCJwhbaymmlM1IIBg+duxIYQIXMBsJThPmE9vWaDgEoi
	 DWhRck/BVGjPX0duJpmghl8H31/nl2j/oLHTHxqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgCYMmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:42:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbgCYMmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:42:04 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48EAC20836;
        Wed, 25 Mar 2020 12:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585140123;
        bh=Wli8F+1ksk0TZlAef8OEMZ2saGhWzuPop7nmvJ22bnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iglrqHvqGmG3IPCqLYpXl5n0CrPU+/39KwImfQZAVhVxaOODr7QoSOwEaMTZJ+UOx
         mL1sDf5PdCW8jB0z+M5/zRArlj/8YTA0753axDIA2tLR4YmsdLg7u5eH9wWhV5tMAC
         48u0eoH6YMer+PTJXnnGyKY2jYgK3RJqWm2fijBc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 07/24] perf report: Support a new key to reload the browser
Date:   Wed, 25 Mar 2020 09:41:07 -0300
Message-Id: <20200325124124.32648-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Sometimes we may need to reload the browser to update the output since
some options are changed.

This patch creates a new key K_RELOAD. Once the __cmd_report() returns
K_RELOAD, it would repeat the whole process, such as, read samples from
data file, sort the data and display in the browser.

 v5:
 ---
 1. Fix the 'make NO_SLANG=1' error. Define K_RELOAD in util/hist.h.
 2. Skip setup_sorting() in repeat path if last key is K_RELOAD.

 v4:
 ---
 Need to quit in perf_evsel_menu__run if key is K_RELOAD.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200220013616.19916-3-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c    | 6 +++---
 tools/perf/ui/browsers/hists.c | 1 +
 tools/perf/ui/keysyms.h        | 1 +
 tools/perf/util/hist.h         | 1 +
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index fa21c5ae3a51..ea673b7eb3f4 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -635,7 +635,7 @@ static int report__browse_hists(struct report *rep)
 		 * Usually "ret" is the last pressed key, and we only
 		 * care if the key notifies us to switch data file.
 		 */
-		if (ret != K_SWITCH_INPUT_DATA)
+		if (ret != K_SWITCH_INPUT_DATA && ret != K_RELOAD)
 			ret = 0;
 		break;
 	case 2:
@@ -1480,7 +1480,7 @@ int cmd_report(int argc, const char **argv)
 		sort_order = sort_tmp;
 	}
 
-	if ((last_key != K_SWITCH_INPUT_DATA) &&
+	if ((last_key != K_SWITCH_INPUT_DATA && last_key != K_RELOAD) &&
 	    (setup_sorting(session->evlist) < 0)) {
 		if (sort_order)
 			parse_options_usage(report_usage, options, "s", 1);
@@ -1559,7 +1559,7 @@ int cmd_report(int argc, const char **argv)
 	sort__setup_elide(stdout);
 
 	ret = __cmd_report(&report);
-	if (ret == K_SWITCH_INPUT_DATA) {
+	if (ret == K_SWITCH_INPUT_DATA || ret == K_RELOAD) {
 		perf_session__delete(session);
 		last_key = K_SWITCH_INPUT_DATA;
 		goto repeat;
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 1103a019d83f..9f3401fd2cf6 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3495,6 +3495,7 @@ static int perf_evsel_menu__run(struct evsel_menu *menu,
 					pos = perf_evsel__prev(pos);
 				goto browse_hists;
 			case K_SWITCH_INPUT_DATA:
+			case K_RELOAD:
 			case 'q':
 			case CTRL('c'):
 				goto out;
diff --git a/tools/perf/ui/keysyms.h b/tools/perf/ui/keysyms.h
index fbfac29077f2..04cc4e5c031f 100644
--- a/tools/perf/ui/keysyms.h
+++ b/tools/perf/ui/keysyms.h
@@ -25,5 +25,6 @@
 #define K_ERROR	 -2
 #define K_RESIZE -3
 #define K_SWITCH_INPUT_DATA -4
+#define K_RELOAD -5
 
 #endif /* _PERF_KEYSYMS_H_ */
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 0aa63aeb58ec..bb994e030495 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -536,6 +536,7 @@ static inline int block_hists_tui_browse(struct block_hist *bh __maybe_unused,
 #define K_LEFT  -1000
 #define K_RIGHT -2000
 #define K_SWITCH_INPUT_DATA -3000
+#define K_RELOAD -4000
 #endif
 
 unsigned int hists__sort_list_width(struct hists *hists);
-- 
2.21.1

