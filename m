Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA21C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BFC42080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgAJRyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:54:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59172 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgAJRx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:53:26 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyTK-0001jS-FW; Fri, 10 Jan 2020 18:53:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C9DE61C2D58;
        Fri, 10 Jan 2020 18:53:16 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:53:16 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf hists browser: Restore ESC as "Zoom out" of
 DSO/thread/etc
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-wp1ssoewy6zihwwexqpohv0j@git.kernel.org>
References: <tip-wp1ssoewy6zihwwexqpohv0j@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157867879671.30329.14010505683197561942.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3f7774033e6820d25beee5cf7aefa11d4968b951
Gitweb:        https://git.kernel.org/tip/3f7774033e6820d25beee5cf7aefa11d4968b951
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 16 Dec 2019 13:22:33 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 06 Jan 2020 11:46:09 -03:00

perf hists browser: Restore ESC as "Zoom out" of DSO/thread/etc

We need to set actions->ms.map since 599a2f38a989 ("perf hists browser:
Check sort keys before hot key actions"), as in that patch we bail out
if map is NULL.

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 599a2f38a989 ("perf hists browser: Check sort keys before hot key actions")
Link: https://lkml.kernel.org/n/tip-wp1ssoewy6zihwwexqpohv0j@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index d4d3558..cfc6172 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3062,6 +3062,7 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 
 				continue;
 			}
+			actions->ms.map = map;
 			top = pstack__peek(browser->pstack);
 			if (top == &browser->hists->dso_filter) {
 				/*
