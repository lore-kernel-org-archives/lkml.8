Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2569C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 07:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997BA206D5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 07:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgCGHhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 02:37:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55226 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgCGHhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 02:37:01 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAU0u-0004Hj-SV; Sat, 07 Mar 2020 08:36:49 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 836ED1C21F3;
        Sat,  7 Mar 2020 08:36:48 +0100 (CET)
Date:   Sat, 07 Mar 2020 07:36:48 -0000
From:   "tip-bot2 for Tommi Rantala" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf top: Fix stdio interface input handling with
 glibc 2.28+
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200305083714.9381-2-tommi.t.rantala@nokia.com>
References: <20200305083714.9381-2-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Message-ID: <158356660826.28353.13798195042914131443.tip-bot2@tip-bot2>
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

Commit-ID:     29b4f5f188571c112713c35cc87eefb46efee612
Gitweb:        https://git.kernel.org/tip/29b4f5f188571c112713c35cc87eefb46efee612
Author:        Tommi Rantala <tommi.t.rantala@nokia.com>
AuthorDate:    Thu, 05 Mar 2020 10:37:12 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 06 Mar 2020 08:30:47 -03:00

perf top: Fix stdio interface input handling with glibc 2.28+

Since glibc 2.28 when running 'perf top --stdio', input handling no
longer works, but hitting any key always just prints the "Mapped keys"
help text.

To fix it, call clearerr() in the display_thread() loop to clear any EOF
sticky errors, as instructed in the glibc NEWS file
(https://sourceware.org/git/?p=glibc.git;a=blob;f=NEWS):

 * All stdio functions now treat end-of-file as a sticky condition.  If you
   read from a file until EOF, and then the file is enlarged by another
   process, you must call clearerr or another function with the same effect
   (e.g. fseek, rewind) before you can read the additional data.  This
   corrects a longstanding C99 conformance bug.  It is most likely to affect
   programs that use stdio to read interactive input from a terminal.
   (Bug #1190.)

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200305083714.9381-2-tommi.t.rantala@nokia.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index f6dd1a6..d2539b7 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -684,7 +684,9 @@ repeat:
 	delay_msecs = top->delay_secs * MSEC_PER_SEC;
 	set_term_quiet_input(&save);
 	/* trash return*/
-	getc(stdin);
+	clearerr(stdin);
+	if (poll(&stdin_poll, 1, 0) > 0)
+		getc(stdin);
 
 	while (!done) {
 		perf_top__print_sym_table(top);
