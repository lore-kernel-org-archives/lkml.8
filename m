Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063BBC33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84FD208CD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgATI1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:27:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60806 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgATI1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:27:30 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1itSOy-0002up-QL; Mon, 20 Jan 2020 09:27:16 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 68C631C1A3F;
        Mon, 20 Jan 2020 09:27:15 +0100 (CET)
Date:   Mon, 20 Jan 2020 08:27:15 -0000
From:   "tip-bot2 for Maciej S. Szmigiero" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf clang: Fix build with Clang 9
Cc:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Dennis Schridde <devurandom@gmx.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        clang-built-linux@googlegroups.com,
        Denis Pronin <dannftk@yandex.ru>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Naohiro Aota <naota@elisp.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191228171314.946469-2-mail@maciej.szmigiero.name>
References: <20191228171314.946469-2-mail@maciej.szmigiero.name>
MIME-Version: 1.0
Message-ID: <157950883517.396.18261374196273837423.tip-bot2@tip-bot2>
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

Commit-ID:     411c0ec0b8131457cf52812de29f11dcbf491ce6
Gitweb:        https://git.kernel.org/tip/411c0ec0b8131457cf52812de29f11dcbf491ce6
Author:        Maciej S. Szmigiero <mail@maciej.szmigiero.name>
AuthorDate:    Sat, 28 Dec 2019 18:13:14 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 14 Jan 2020 12:02:19 -03:00

perf clang: Fix build with Clang 9

LLVM D59377 (included in Clang 9) refactored Clang VFS construction a
bit, which broke perf clang build.  Let's fix it.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Dennis Schridde <devurandom@gmx.net>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: clang-built-linux@googlegroups.com
Cc: Denis Pronin <dannftk@yandex.ru>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Naohiro Aota <naota@elisp.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191228171314.946469-2-mail@maciej.szmigiero.name
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/c++/clang.cpp | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
index fc361c3..c8885df 100644
--- a/tools/perf/util/c++/clang.cpp
+++ b/tools/perf/util/c++/clang.cpp
@@ -71,7 +71,11 @@ getModuleFromSource(llvm::opt::ArgStringList CFlags,
 	CompilerInstance Clang;
 	Clang.createDiagnostics();
 
+#if CLANG_VERSION_MAJOR < 9
 	Clang.setVirtualFileSystem(&*VFS);
+#else
+	Clang.createFileManager(&*VFS);
+#endif
 
 #if CLANG_VERSION_MAJOR < 4
 	IntrusiveRefCntPtr<CompilerInvocation> CI =
