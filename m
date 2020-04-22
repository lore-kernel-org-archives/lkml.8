Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C7FC5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D26F920CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgDVMTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728903AbgDVMR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105B2C08C5F2;
        Wed, 22 Apr 2020 05:17:56 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREK5-0008D2-02; Wed, 22 Apr 2020 14:17:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 171401C0837;
        Wed, 22 Apr 2020 14:17:40 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:39 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf stat: Honour --timeout for forked workloads
Cc:     Konstantin Kharlamov <hi-angel@yandex.ru>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200415153803.GB20324@kernel.org>
References: <20200415153803.GB20324@kernel.org>
MIME-Version: 1.0
Message-ID: <158755785969.28353.16538005607334965556.tip-bot2@tip-bot2>
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

Commit-ID:     cfbd41b786519d4a15e1c15181556689bcf6635a
Gitweb:        https://git.kernel.org/tip/cfbd41b786519d4a15e1c15181556689bcf6635a
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 15 Apr 2020 12:31:26 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 16 Apr 2020 12:17:41 -03:00

perf stat: Honour --timeout for forked workloads

When --timeout is used and a workload is specified to be started by
'perf stat', i.e.

  $ perf stat --timeout 1000 sleep 1h

The --timeout wasn't being honoured, i.e. the workload, 'sleep 1h' in
the above example, should be terminated after 1000ms, but it wasn't,
'perf stat' was waiting for it to finish.

Fix it by sending a SIGTERM when the timeout expires.

Now it works:

  # perf stat -e cycles --timeout 1234 sleep 1h
  sleep: Terminated

   Performance counter stats for 'sleep 1h':

           1,066,692      cycles

         1.234314838 seconds time elapsed

         0.000750000 seconds user
         0.000000000 seconds sys

  #

Fixes: f1f8ad52f8bf ("perf stat: Add support to print counts after a period of time")
Reported-by: Konstantin Kharlamov <hi-angel@yandex.ru>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207243
Tested-by: Konstantin Kharlamov <hi-angel@yandex.ru>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Tested-by: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: yuzhoujian <yuzhoujian@didichuxing.com>
Link: https://lore.kernel.org/lkml/20200415153803.GB20324@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index ec053dc..9207b6c 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -686,8 +686,11 @@ try_again_reset:
 					break;
 			}
 		}
-		if (child_pid != -1)
+		if (child_pid != -1) {
+			if (timeout)
+				kill(child_pid, SIGTERM);
 			wait4(child_pid, &status, 0, &stat_config.ru_data);
+		}
 
 		if (workload_exec_errno) {
 			const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
