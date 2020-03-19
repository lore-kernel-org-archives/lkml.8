Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFC1C43332
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09D12145D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgCSOFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:05:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60739 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbgCSOE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:04:59 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvmv-0001p5-DP; Thu, 19 Mar 2020 15:04:45 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 017361C22A3;
        Thu, 19 Mar 2020 15:04:45 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:04:44 -0000
From:   "tip-bot2 for disconnect3d" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf map: Fix off by one in strncpy() size argument
Cc:     disconnect3d <dominik.b.czarnota@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, John Keeping <john@metanate.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Lentine <mlentine@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200309104855.3775-1-dominik.b.czarnota@gmail.com>
References: <20200309104855.3775-1-dominik.b.czarnota@gmail.com>
MIME-Version: 1.0
Message-ID: <158462668472.28353.474189407864039668.tip-bot2@tip-bot2>
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

Commit-ID:     db2c549407d4a76563c579e4768f7d6d32afefba
Gitweb:        https://git.kernel.org/tip/db2c549407d4a76563c579e4768f7d6d32afefba
Author:        disconnect3d <dominik.b.czarnota@gmail.com>
AuthorDate:    Mon, 09 Mar 2020 11:48:53 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 09 Mar 2020 09:34:45 -03:00

perf map: Fix off by one in strncpy() size argument

This patch fixes an off-by-one error in strncpy size argument in
tools/perf/util/map.c. The issue is that in:

        strncmp(filename, "/system/lib/", 11)

the passed string literal: "/system/lib/" has 12 bytes (without the NULL
byte) and the passed size argument is 11. As a result, the logic won't
match the ending "/" byte and will pass filepaths that are stored in
other directories e.g. "/system/libmalicious/bin" or just
"/system/libmalicious".

This functionality seems to be present only on Android. I assume the
/system/ directory is only writable by the root user, so I don't think
this bug has much (or any) security impact.

Fixes: eca818369996 ("perf tools: Add automatic remapping of Android libraries")
Signed-off-by: disconnect3d <dominik.b.czarnota@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Changbin Du <changbin.du@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: John Keeping <john@metanate.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Lentine <mlentine@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20200309104855.3775-1-dominik.b.czarnota@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 9542851..b342f74 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -89,7 +89,7 @@ static inline bool replace_android_lib(const char *filename, char *newfilename)
 		return true;
 	}
 
-	if (!strncmp(filename, "/system/lib/", 11)) {
+	if (!strncmp(filename, "/system/lib/", 12)) {
 		char *ndk, *app;
 		const char *arch;
 		size_t ndk_length;
