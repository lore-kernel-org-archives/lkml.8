Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D780FC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C165224969
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbgEHNGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729850AbgEHNFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FCFC05BD43;
        Fri,  8 May 2020 06:05:39 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2h2-0007uz-Ob; Fri, 08 May 2020 15:05:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3AC671C0493;
        Fri,  8 May 2020 15:05:13 +0200 (CEST)
Date:   Fri, 08 May 2020 13:05:13 -0000
From:   "tip-bot2 for Tommi Rantala" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf test session topology: Fix data path
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200423115341.562782-1-tommi.t.rantala@nokia.com>
References: <20200423115341.562782-1-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Message-ID: <158894311318.8414.2157393565908107171.tip-bot2@tip-bot2>
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

Commit-ID:     dbd660e6b2884b864d2642d930a163d3bcebe4be
Gitweb:        https://git.kernel.org/tip/dbd660e6b2884b864d2642d930a163d3bcebe4be
Author:        Tommi Rantala <tommi.t.rantala@nokia.com>
AuthorDate:    Thu, 23 Apr 2020 14:53:40 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 23 Apr 2020 11:08:24 -03:00

perf test session topology: Fix data path

Commit 2d4f27999b88 ("perf data: Add global path holder") missed path
conversion in tests/topology.c, causing the "Session topology" testcase
to "hang" (waits forever for input from stdin) when doing "ssh $VM perf
test".

Can be reproduced by running "cat | perf test topo", and crashed by
replacing cat with true:

  $ true | perf test -v topo
  40: Session topology                                      :
  --- start ---
  test child forked, pid 3638
  templ file: /tmp/perf-test-QPvAch
  incompatible file format
  incompatible file format (rerun with -v to learn more)
  free(): invalid pointer
  test child interrupted
  ---- end ----
  Session topology: FAILED!

Committer testing:

Reproduced the above result before the patch and after it is back
working:

  # true | perf test -v topo
  41: Session topology                                      :
  --- start ---
  test child forked, pid 19374
  templ file: /tmp/perf-test-YOTEQg
  CPU 0, core 0, socket 0
  CPU 1, core 1, socket 0
  CPU 2, core 2, socket 0
  CPU 3, core 3, socket 0
  CPU 4, core 0, socket 0
  CPU 5, core 1, socket 0
  CPU 6, core 2, socket 0
  CPU 7, core 3, socket 0
  test child finished with 0
  ---- end ----
  Session topology: Ok
  #

Fixes: 2d4f27999b88 ("perf data: Add global path holder")
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20200423115341.562782-1-tommi.t.rantala@nokia.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/topology.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 4a80049..22daf2b 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -33,10 +33,8 @@ static int session_write_header(char *path)
 {
 	struct perf_session *session;
 	struct perf_data data = {
-		.file      = {
-			.path = path,
-		},
-		.mode      = PERF_DATA_MODE_WRITE,
+		.path = path,
+		.mode = PERF_DATA_MODE_WRITE,
 	};
 
 	session = perf_session__new(&data, false, NULL);
@@ -63,10 +61,8 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 {
 	struct perf_session *session;
 	struct perf_data data = {
-		.file      = {
-			.path = path,
-		},
-		.mode      = PERF_DATA_MODE_READ,
+		.path = path,
+		.mode = PERF_DATA_MODE_READ,
 	};
 	int i;
 
