Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E25FC33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6EB208CD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgATI1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:27:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60803 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbgATI12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:27:28 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1itSOx-0002uo-Db; Mon, 20 Jan 2020 09:27:15 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 135B91C1A3E;
        Mon, 20 Jan 2020 09:27:15 +0100 (CET)
Date:   Mon, 20 Jan 2020 08:27:14 -0000
From:   "tip-bot2 for Maciej S. Szmigiero" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] tools build: Fix test-clang.cpp with Clang 8+
Cc:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Denis Pronin <dannftk@yandex.ru>,
        Dennis Schridde <devurandom@gmx.net>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Naohiro Aota <naota@elisp.net>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux@googlegroups.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191228171314.946469-1-mail@maciej.szmigiero.name>
References: <20191228171314.946469-1-mail@maciej.szmigiero.name>
MIME-Version: 1.0
Message-ID: <157950883490.396.9434688341680423539.tip-bot2@tip-bot2>
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

Commit-ID:     d8007772a5541b4711d1286b788ad4295b2c7eaa
Gitweb:        https://git.kernel.org/tip/d8007772a5541b4711d1286b788ad4295b2c7eaa
Author:        Maciej S. Szmigiero <mail@maciej.szmigiero.name>
AuthorDate:    Sat, 28 Dec 2019 18:13:13 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 14 Jan 2020 12:02:19 -03:00

tools build: Fix test-clang.cpp with Clang 8+

LLVM rL344140 (included in Clang 8+) moved VFS from Clang to LLVM, so
paths to its include files have changed.

This broke the Clang test in tools/build - let's fix it.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Denis Pronin <dannftk@yandex.ru>
Cc: Dennis Schridde <devurandom@gmx.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Naohiro Aota <naota@elisp.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: clang-built-linux@googlegroups.com
Link: http://lore.kernel.org/lkml/20191228171314.946469-1-mail@maciej.szmigiero.name
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-clang.cpp | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/build/feature/test-clang.cpp b/tools/build/feature/test-clang.cpp
index a2b3f09..7d87075 100644
--- a/tools/build/feature/test-clang.cpp
+++ b/tools/build/feature/test-clang.cpp
@@ -1,9 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "clang/Basic/Version.h"
+#if CLANG_VERSION_MAJOR < 8
 #include "clang/Basic/VirtualFileSystem.h"
+#endif
 #include "clang/Driver/Driver.h"
 #include "clang/Frontend/TextDiagnosticPrinter.h"
 #include "llvm/ADT/IntrusiveRefCntPtr.h"
 #include "llvm/Support/ManagedStatic.h"
+#if CLANG_VERSION_MAJOR >= 8
+#include "llvm/Support/VirtualFileSystem.h"
+#endif
 #include "llvm/Support/raw_ostream.h"
 
 using namespace clang;
