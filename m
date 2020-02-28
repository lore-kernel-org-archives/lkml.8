Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3089C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C07246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582898436;
	bh=1QSXtn9Sc3yVkfywUW9+MplxK3/pr6RXh9U/a//4UR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LJHaa7E+QjGwVu0mSPUnfIRyTkGiy6VMoShgxCxYM0UxVXWab0RGMTIlNmiX+lb1T
	 5rJ+//JP2Rk5KAKXJDg9RH7f2FagJmZjUCxWXp4QQXt5x8uW6TJTLxsPqVIDfQOmi9
	 htQOIRmJM5CI8M+uQDMnGogmJl9vQNePvqk7UO/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgB1OAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:00:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:57666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbgB1OAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:00:34 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D97B246AC;
        Fri, 28 Feb 2020 14:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582898434;
        bh=1QSXtn9Sc3yVkfywUW9+MplxK3/pr6RXh9U/a//4UR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oxgoIrCL5Llw8NcxnRGE+bKAoKYTYyLGx3GDKuFFhb55lwVUxWdtlRUl8ppBlMbEX
         e04kB4mcqXdmRI6Pd8QOLbqM/dICj8U0la8u6UqKTgqzZ+jHjAQAwCgrESjDdX4Oqw
         RNU+DJDM6nrvwOMbye1mAvWa86fzFoqJLPW1+zmg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Song Liu <songliubraving@fb.com>,
        Taeung Song <treeze.taeung@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH 03/15] perf annotate/tui: Re-render title bar after switching back from script browser
Date:   Fri, 28 Feb 2020 11:00:02 -0300
Message-Id: <20200228140014.1236-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228140014.1236-1-acme@kernel.org>
References: <20200228140014.1236-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

The 'perf annotate' TUI browser provides a 'r' hot key to switch to a
script browser. But the annotate browser title bar becomes hidden while
switching back from script browser. Fix it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Changbin Du <changbin.du@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>
Link: http://lore.kernel.org/lkml/20200213064306.160480-2-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index badbddbb30f8..0dbbf35e6ed1 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -754,10 +754,9 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		"?             Search string backwards\n");
 			continue;
 		case 'r':
-			{
-				script_browse(NULL, NULL);
-				continue;
-			}
+			script_browse(NULL, NULL);
+			annotate_browser__show(&browser->b, title, help);
+			continue;
 		case 'k':
 			notes->options->show_linenr = !notes->options->show_linenr;
 			break;
-- 
2.21.1

