Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069CEC352A4
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 08:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB88924680
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 08:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgBOImS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 03:42:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56813 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgBOImE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 03:42:04 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j2t1N-0005I6-KU; Sat, 15 Feb 2020 09:41:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 424561C205E;
        Sat, 15 Feb 2020 09:41:53 +0100 (CET)
Date:   Sat, 15 Feb 2020 08:41:52 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf maps: Mark ksymbol DSOs with kernel type
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200210200847.GA36715@krava>
References: <20200210200847.GA36715@krava>
MIME-Version: 1.0
Message-ID: <158175611298.13786.3290516837550970527.tip-bot2@tip-bot2>
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

Commit-ID:     4a4eb6154d67f7766cc7eb74e9f1db424073e832
Gitweb:        https://git.kernel.org/tip/4a4eb6154d67f7766cc7eb74e9f1db424073e832
Author:        Jiri Olsa <jolsa@redhat.com>
AuthorDate:    Mon, 10 Feb 2020 21:08:47 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 11 Feb 2020 16:41:49 -03:00

perf maps: Mark ksymbol DSOs with kernel type

We add ksymbol map into machine->kmaps, so it needs to be created as
'struct kmap', which is dependent on its dso having kernel type.

Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Tested-by: Kim Phillips <kim.phillips@amd.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200210200847.GA36715@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e3e5490..0ad0265 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -727,9 +727,17 @@ static int machine__process_ksymbol_register(struct machine *machine,
 	struct map *map = maps__find(&machine->kmaps, event->ksymbol.addr);
 
 	if (!map) {
-		map = dso__new_map(event->ksymbol.name);
-		if (!map)
+		struct dso *dso = dso__new(event->ksymbol.name);
+
+		if (dso) {
+			dso->kernel = DSO_TYPE_KERNEL;
+			map = map__new2(0, dso);
+		}
+
+		if (!dso || !map) {
+			dso__put(dso);
 			return -ENOMEM;
+		}
 
 		map->start = event->ksymbol.addr;
 		map->end = map->start + event->ksymbol.len;
