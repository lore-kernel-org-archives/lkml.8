Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1E8C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3AB222D9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgBEPpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:45:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35852 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgBEPpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:45:14 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1izMrR-0004Qd-EA; Wed, 05 Feb 2020 16:45:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 15E561C1EC4;
        Wed,  5 Feb 2020 16:45:05 +0100 (CET)
Date:   Wed, 05 Feb 2020 15:45:04 -0000
From:   "tip-bot2 for Cengiz Can" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf maps: Add missing unlock to maps__insert() error case
Cc:     Cengiz Can <cengiz@kernel.wtf>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200120141553.23934-1-cengiz@kernel.wtf>
References: <20200120141553.23934-1-cengiz@kernel.wtf>
MIME-Version: 1.0
Message-ID: <158091750477.411.16676804316136284961.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     85fc95d75970ee7dd8e01904e7fb1197c275ba6b
Gitweb:        https://git.kernel.org/tip/85fc95d75970ee7dd8e01904e7fb1197c275ba6b
Author:        Cengiz Can <cengiz@kernel.wtf>
AuthorDate:    Mon, 20 Jan 2020 17:15:54 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 31 Jan 2020 09:40:50 +01:00

perf maps: Add missing unlock to maps__insert() error case

`tools/perf/util/map.c` has a function named `maps__insert` that
acquires a write lock if its in multithread context.

Even though this lock is released when function successfully completes,
there's a branch that is executed when `maps_by_name == NULL` that
returns from this function without releasing the write lock.

Added an `up_write` to release the lock when this happens.

Fixes: a7c2b572e217 ("perf map_groups: Auto sort maps by name, if needed")
Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20200120141553.23934-1-cengiz@kernel.wtf
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index fdd5bdd..f67960b 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -549,6 +549,7 @@ void maps__insert(struct maps *maps, struct map *map)
 
 			if (maps_by_name == NULL) {
 				__maps__free_maps_by_name(maps);
+				up_write(&maps->lock);
 				return;
 			}
 
