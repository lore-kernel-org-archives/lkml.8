Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E35DC2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DE6221EA
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgDDImK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:42:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41564 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgDDImE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:04 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNC-00012a-Sm; Sat, 04 Apr 2020 10:41:51 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 07B371C047B;
        Sat,  4 Apr 2020 10:41:49 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:48 -0000
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tools headers UAPI: Update tools's copy of
 linux/perf_event.h
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, http:
        //lore.kernel.org/lkml/20200325124536.2800725-4-namhyung@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, ;
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     ;
                        ^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
MIME-Version: 1.0
Message-ID: <158598970868.28353.2028689385124855746.tip-bot2@tip-bot2>
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

Commit-ID:     03590fb409bce428bce0b4535a488dedfbed0c00
Gitweb:        https://git.kernel.org/tip/03590fb409bce428bce0b4535a488dedfbed0c00
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Fri, 27 Mar 2020 11:07:17 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 02 Apr 2020 12:51:49 -03:00

tools headers UAPI: Update tools's copy of linux/perf_event.h

To get the changes in:

  6546b19f95ac ("perf/core: Add PERF_SAMPLE_CGROUP feature")
  96aaab686505 ("perf/core: Add PERF_RECORD_CGROUP event")

This silences this perf tools build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' differs from latest version at 'include/uapi/linux/perf_event.h'
  diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h

This update is a prerequisite to adding support for the HW index of raw
branch records.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: http://lore.kernel.org/lkml/20200325124536.2800725-4-namhyung@kernel.org
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/perf_event.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 397cfd6..7b2d6fc 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -142,8 +142,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_REGS_INTR			= 1U << 18,
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 	PERF_SAMPLE_AUX				= 1U << 20,
+	PERF_SAMPLE_CGROUP			= 1U << 21,
 
-	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 22,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
@@ -381,7 +382,8 @@ struct perf_event_attr {
 				ksymbol        :  1, /* include ksymbol events */
 				bpf_event      :  1, /* include bpf events */
 				aux_output     :  1, /* generate AUX records instead of events */
-				__reserved_1   : 32;
+				cgroup         :  1, /* include cgroup events */
+				__reserved_1   : 31;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -1012,6 +1014,16 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_BPF_EVENT			= 18,
 
+	/*
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				id;
+	 *	char				path[];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CGROUP			= 19,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
