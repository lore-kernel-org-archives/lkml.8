Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62642C2BA18
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2F1206E9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgDDIod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:44:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41466 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgDDIlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:41:55 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeN4-0000wL-J3; Sat, 04 Apr 2020 10:41:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 396451C047B;
        Sat,  4 Apr 2020 10:41:42 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:41 -0000
From:   "tip-bot2 for Stephane Eranian" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf script: Allow --symbol to accept hexadecimal
 addresses
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200325220802.15039-1-irogers@google.com>
References: <20200325220802.15039-1-irogers@google.com>
MIME-Version: 1.0
Message-ID: <158598970187.28353.359369792033644144.tip-bot2@tip-bot2>
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

Commit-ID:     d2bedb7863e9817f71fe2332a85ecdbd0f264b4b
Gitweb:        https://git.kernel.org/tip/d2bedb7863e9817f71fe2332a85ecdbd0f264b4b
Author:        Stephane Eranian <eranian@google.com>
AuthorDate:    Wed, 25 Mar 2020 15:08:02 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 03 Apr 2020 09:37:56 -03:00

perf script: Allow --symbol to accept hexadecimal addresses

This patch extends the perf script --symbols option to filter on
hexadecimal addresses in addition to symbol names. This makes it easier
to handle cases where symbols are aliased.

With this patch, it is possible to mix and match symbols and hexadecimal
addresses using the --symbols option.

  $ perf script --symbols=noploop,0x4007a0

Signed-off-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200325220802.15039-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 824c038..dc0e112 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -617,10 +617,23 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 		al->sym = map__find_symbol(al->map, al->addr);
 	}
 
-	if (symbol_conf.sym_list &&
-		(!al->sym || !strlist__has_entry(symbol_conf.sym_list,
-						al->sym->name))) {
-		al->filtered |= (1 << HIST_FILTER__SYMBOL);
+	if (symbol_conf.sym_list) {
+		int ret = 0;
+		char al_addr_str[32];
+		size_t sz = sizeof(al_addr_str);
+
+		if (al->sym) {
+			ret = strlist__has_entry(symbol_conf.sym_list,
+						al->sym->name);
+		}
+		if (!(ret && al->sym)) {
+			snprintf(al_addr_str, sz, "0x%"PRIx64,
+				al->map->unmap_ip(al->map, al->sym->start));
+			ret = strlist__has_entry(symbol_conf.sym_list,
+						al_addr_str);
+		}
+		if (!ret)
+			al->filtered |= (1 << HIST_FILTER__SYMBOL);
 	}
 
 	return 0;
