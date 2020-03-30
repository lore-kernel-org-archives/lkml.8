Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECF1C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020C92072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zwhge/VJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbgC3Pn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 11:43:27 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46670 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728207AbgC3Pn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 11:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585583006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=JSKzIe6iDeO9mCZKo/3slq31feX1Q7KMMBdiVxw/p1g=;
        b=Zwhge/VJ3UtmwMpOtGeg8S5997owI66VyOgm4PySfNKKz2Yg8TOB6391sh08jYsrnUeIlh
        fcmAxI8Mx6HpDLi05lrDgxPQXzMLMPaJxq1KMJtg1NKBfKK0qy/NL3G7C/kvMchVyB6cBM
        xCphehDmH4o5mUvY5yXeHgU9GamtDRU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-ebfQAMnqOb2o8GavhFwh3Q-1; Mon, 30 Mar 2020 11:43:21 -0400
X-MC-Unique: ebfQAMnqOb2o8GavhFwh3Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42F2D800D50;
        Mon, 30 Mar 2020 15:43:20 +0000 (UTC)
Received: from quaco.ghostprotocols.net (unknown [10.3.128.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BDFA96F88;
        Mon, 30 Mar 2020 15:43:19 +0000 (UTC)
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DBFC2409A3; Mon, 30 Mar 2020 12:43:14 -0300 (-03)
Date:   Mon, 30 Mar 2020 12:43:14 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf report/top TUI: Fix title line formatting
Message-ID: <20200330154314.GB4576@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acks? :)

--- 

In d10ec006dcd7 ("perf hists browser: Allow passing an initial hotkey")
the hist_entry__title() call was cut'n'pasted to a function where the
'title' variable is a pointer, not an array, so the sizeof(title)
continues syntactically valid but ends up reducing the real size of the
buffer where to format the first line in the screen to 8 bytes, which
makes the formatting at the title at each refresh to produce just the
string "Samples ", duh, fix it by passing the size of the buffer.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: d10ec006dcd7 ("perf hists browser: Allow passing an initial hotkey")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 95ac5e2ea949..487e54ef56a9 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -677,7 +677,7 @@ static int hist_browser__title(struct hist_browser *browser, char *bf, size_t si
 	return browser->title ? browser->title(browser, bf, size) : 0;
 }
 
-static int hist_browser__handle_hotkey(struct hist_browser *browser, bool warn_lost_event, char *title, int key)
+static int hist_browser__handle_hotkey(struct hist_browser *browser, bool warn_lost_event, char *title, size_t size, int key)
 {
 	switch (key) {
 	case K_TIMER: {
@@ -703,7 +703,7 @@ static int hist_browser__handle_hotkey(struct hist_browser *browser, bool warn_l
 			ui_browser__warn_lost_events(&browser->b);
 		}
 
-		hist_browser__title(browser, title, sizeof(title));
+		hist_browser__title(browser, title, size);
 		ui_browser__show_title(&browser->b, title);
 		break;
 	}
@@ -764,13 +764,13 @@ int hist_browser__run(struct hist_browser *browser, const char *help,
 	if (ui_browser__show(&browser->b, title, "%s", help) < 0)
 		return -1;
 
-	if (key && hist_browser__handle_hotkey(browser, warn_lost_event, title, key))
+	if (key && hist_browser__handle_hotkey(browser, warn_lost_event, title, sizeof(title), key))
 		goto out;
 
 	while (1) {
 		key = ui_browser__run(&browser->b, delay_secs);
 
-		if (hist_browser__handle_hotkey(browser, warn_lost_event, title, key))
+		if (hist_browser__handle_hotkey(browser, warn_lost_event, title, sizeof(title), key))
 			break;
 	}
 out:
-- 
2.25.1

