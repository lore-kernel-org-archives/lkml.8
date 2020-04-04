Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C03C2BA18
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F5220CC7
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgDDIoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:44:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41581 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgDDImE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:04 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNH-00016A-QV; Sat, 04 Apr 2020 10:41:56 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0C42C1C0493;
        Sat,  4 Apr 2020 10:41:52 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:51 -0000
From:   "tip-bot2 for He Zhe" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Normalize gcc parameter when generating arch
 errno table
Cc:     He Zhe <zhe.he@windriver.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1581618066-187262-2-git-send-email-zhe.he@windriver.com>
References: <1581618066-187262-2-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Message-ID: <158598971157.28353.2501769243855333551.tip-bot2@tip-bot2>
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

Commit-ID:     e4ffd066ff440a57097e9140fa9e16ceef905de8
Gitweb:        https://git.kernel.org/tip/e4ffd066ff440a57097e9140fa9e16ceef905de8
Author:        He Zhe <zhe.he@windriver.com>
AuthorDate:    Fri, 14 Feb 2020 02:21:06 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 26 Mar 2020 11:04:01 -03:00

perf: Normalize gcc parameter when generating arch errno table

The $(CC) passed to arch_errno_names.sh may include a series of parameters
along with gcc itself. To avoid overwriting the following parameters of
arch_errno_names.sh and break the build like below, we just pick up the
first word of the $(CC).

  find: unknown predicate `-m64/arch'
  x86_64-wrs-linux-gcc: warning: '-x c' after last input file has no effect
  x86_64-wrs-linux-gcc: error: unrecognized command line option '-m64/include/uapi/asm-generic/errno.h'
  x86_64-wrs-linux-gcc: fatal error: no input files

Signed-off-by: He Zhe <zhe.he@windriver.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/1581618066-187262-2-git-send-email-zhe.he@windriver.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a02aca9..d15a311 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -574,7 +574,7 @@ arch_errno_hdr_dir := $(srctree)/tools
 arch_errno_tbl := $(srctree)/tools/perf/trace/beauty/arch_errno_names.sh
 
 $(arch_errno_name_array): $(arch_errno_tbl)
-	$(Q)$(SHELL) '$(arch_errno_tbl)' $(CC) $(arch_errno_hdr_dir) > $@
+	$(Q)$(SHELL) '$(arch_errno_tbl)' $(firstword $(CC)) $(arch_errno_hdr_dir) > $@
 
 sync_file_range_arrays := $(beauty_outdir)/sync_file_range_arrays.c
 sync_file_range_tbls := $(srctree)/tools/perf/trace/beauty/sync_file_range.sh
