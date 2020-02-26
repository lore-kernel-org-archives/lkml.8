Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C82C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5F420714
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgBZOUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:20:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57927 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgBZOUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:20:51 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j6xYG-00080k-EN; Wed, 26 Feb 2020 15:20:40 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 12ABF1C2156;
        Wed, 26 Feb 2020 15:20:40 +0100 (CET)
Date:   Wed, 26 Feb 2020 14:20:39 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf bpf: Remove bpf/ subdir from bpf.h headers
 used to build bpf events
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-d9myswhgo8gfi3vmehdqpxa7@git.kernel.org>
References: <tip-d9myswhgo8gfi3vmehdqpxa7@git.kernel.org>
MIME-Version: 1.0
Message-ID: <158272683976.28353.3519947924913490182.tip-bot2@tip-bot2>
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

Commit-ID:     3b573bf318d894b4290e194c4d7dbcba8c1f6ead
Gitweb:        https://git.kernel.org/tip/3b573bf318d894b4290e194c4d7dbcba8c1f6ead
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 14 Feb 2020 16:21:40 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 18 Feb 2020 10:13:28 -03:00

perf bpf: Remove bpf/ subdir from bpf.h headers used to build bpf events

The bpf.h file needed gets installed in /usr/lib/include/perf/bpf/bpf.h,
and /usr/lib/include/perf/ is added to the include path passed to clang
to build the eBPF bytecode, so just remove "bpf/", its directly in the
path passed already. This was working by accident, fix it.

I.e. now this is back working:

  # cat /home/acme/git/perf/tools/perf/examples/bpf/hello.c
  #include <stdio.h>

  int syscall_enter(openat)(void *args)
  {
  	puts("Hello, world\n");
  	return 0;
  }

  license(GPL);
  # perf trace -e /home/acme/git/perf/tools/perf/examples/bpf/hello.c
       0.000 pickup/21493 __bpf_stdout__(Hello, world)
      56.462 sh/13539 __bpf_stdout__(Hello, world)
      56.536 sh/13539 __bpf_stdout__(Hello, world)
      56.673 sh/13539 __bpf_stdout__(Hello, world)
      56.781 sh/13539 __bpf_stdout__(Hello, world)
      56.707 perf/13182 __bpf_stdout__(Hello, world)
      56.849 perf/13182 __bpf_stdout__(Hello, world)
  ^C
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-d9myswhgo8gfi3vmehdqpxa7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/pid_filter.h | 2 +-
 tools/perf/include/bpf/stdio.h      | 2 +-
 tools/perf/include/bpf/unistd.h     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/include/bpf/pid_filter.h b/tools/perf/include/bpf/pid_filter.h
index 607189a..6e61c4b 100644
--- a/tools/perf/include/bpf/pid_filter.h
+++ b/tools/perf/include/bpf/pid_filter.h
@@ -3,7 +3,7 @@
 #ifndef _PERF_BPF_PID_FILTER_
 #define _PERF_BPF_PID_FILTER_
 
-#include <bpf/bpf.h>
+#include <bpf.h>
 
 #define pid_filter(name) pid_map(name, bool)
 
diff --git a/tools/perf/include/bpf/stdio.h b/tools/perf/include/bpf/stdio.h
index 7ca6fa5..316af5b 100644
--- a/tools/perf/include/bpf/stdio.h
+++ b/tools/perf/include/bpf/stdio.h
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <bpf/bpf.h>
+#include <bpf.h>
 
 struct bpf_map SEC("maps") __bpf_stdout__ = {
        .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
diff --git a/tools/perf/include/bpf/unistd.h b/tools/perf/include/bpf/unistd.h
index d1a35b6..ca7877f 100644
--- a/tools/perf/include/bpf/unistd.h
+++ b/tools/perf/include/bpf/unistd.h
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: LGPL-2.1
 
-#include <bpf/bpf.h>
+#include <bpf.h>
 
 static int (*bpf_get_current_pid_tgid)(void) = (void *)BPF_FUNC_get_current_pid_tgid;
 
