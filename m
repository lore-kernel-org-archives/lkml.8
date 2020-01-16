Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D4DC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DD6207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579182510;
	bh=olPfPJbIocssIswghEIWRA+kxMw14PHUGYolIW/ac00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=khr2TBxLFNiqs02dE2WM08puKGgErFmFMi3o/UwKFWAzmsJbCsIHRPZX7ysewVt4J
	 ouDD2hrvAbg5bSrYQ4T4F6fZJo4wz2E0UrChPIwmV4fwKDlc7OxhlWe7k8yAzpgL3W
	 UfE1UDrkgBoQaaWq/J6aBc6YOp9bo5MzIW5fPx3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgAPNs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:48:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:49524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgAPNs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:48:27 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BEAF208C3;
        Thu, 16 Jan 2020 13:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579182507;
        bh=olPfPJbIocssIswghEIWRA+kxMw14PHUGYolIW/ac00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=slYFaJokJIZKufRb1gXIXkuGfQmzx/9MGbp6jRwxIqzzkXMFtnR4nzDp5LKMdIWqx
         lXPKAwnIudVa5Gp9bQYFRE17cg05S42elPq0g990BN1XVXYL5/l2q8W0QgQFMyUZaO
         +RVzs5uoZCI4r/X1428dCA4RHqcgbjpST1uDdiss=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Dennis Schridde <devurandom@gmx.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        clang-built-linux@googlegroups.com,
        Denis Pronin <dannftk@yandex.ru>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Naohiro Aota <naota@elisp.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/12] perf clang: Fix build with Clang 9
Date:   Thu, 16 Jan 2020 10:48:03 -0300
Message-Id: <20200116134814.8811-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200116134814.8811-1-acme@kernel.org>
References: <20200116134814.8811-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>

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
index fc361c3f8570..c8885dfa3667 100644
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
-- 
2.21.1

