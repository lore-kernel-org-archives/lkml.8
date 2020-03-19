Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980E3C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D3D214DB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgCSONH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:13:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60863 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbgCSOKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:10:52 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvsh-00022h-NM; Thu, 19 Mar 2020 15:10:43 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4C9A11C22A3;
        Thu, 19 Mar 2020 15:10:43 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:43 -0000
From:   "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf doc: Set man page date to last git commit
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masanari Iida <standby24x7@gmail.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200311052110.23132-1-irogers@google.com>
References: <20200311052110.23132-1-irogers@google.com>
MIME-Version: 1.0
Message-ID: <158462704302.28353.8961321005350335102.tip-bot2@tip-bot2>
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

Commit-ID:     0c2d041232411c8124136c9497c0e352dcf18baa
Gitweb:        https://git.kernel.org/tip/0c2d041232411c8124136c9497c0e352dcf18baa
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Tue, 10 Mar 2020 22:21:10 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 11 Mar 2020 10:48:44 -03:00

perf doc: Set man page date to last git commit

Currently the man page dates reflect the date the man pages were built.
This patch adjusts the date so that the date is when then man page
last had a commit against it. The date is generated using 'git log'.

Committer testing:

  $ git log -1 --pretty="format:%cd" --date=short tools/perf/Documentation/perf-top.txt
  2020-01-14

Before:

  rm -rf /tmp/build/perf
  mkdir -p /tmp/build/perf
  make -C tools/perf O=/tmp/build/perf/ install
  $ date
  Wed 11 Mar 2020 10:21:19 AM -03
  $ man perf-top | tail -1
  perf                    03/11/2020           PERF-TOP(1)
  $

After:

  rm -rf /tmp/build/perf
  mkdir -p /tmp/build/perf
  make -C tools/perf O=/tmp/build/perf/ install
  $ date
  $ date
  Wed 11 Mar 2020 10:24:06 AM -03
  $ man perf-top | tail -1
  perf                    2020-01-14           PERF-TOP(1)
  $

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Masanari Iida <standby24x7@gmail.com>
Cc: Mukesh Ojha <mojha@codeaurora.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/20200311052110.23132-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index adc5a7e..31824d5 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -295,7 +295,10 @@ $(OUTPUT)%.1 $(OUTPUT)%.5 $(OUTPUT)%.7 : $(OUTPUT)%.xml
 $(OUTPUT)%.xml : %.txt
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(ASCIIDOC) -b docbook -d manpage \
-		$(ASCIIDOC_EXTRA) -aperf_version=$(PERF_VERSION) -o $@+ $< && \
+		$(ASCIIDOC_EXTRA) -aperf_version=$(PERF_VERSION) \
+		-aperf_date=$(shell git log -1 --pretty="format:%cd" \
+				--date=short $<) \
+		-o $@+ $< && \
 	mv $@+ $@
 
 XSLT = docbook.xsl
