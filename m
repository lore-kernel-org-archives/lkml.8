Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E484C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC188208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbgEHNM2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730022AbgEHNEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:04:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C52C05BD0B;
        Fri,  8 May 2020 06:04:49 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gB-00073n-Cl; Fri, 08 May 2020 15:04:39 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EF32D1C0080;
        Fri,  8 May 2020 15:04:38 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:38 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf flamegraph: Use /bin/bash for report and record scripts
Cc:     daniel.diaz@linaro.org, Andreas Gerstmayr <agerstmayr@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, lkft-triage@lists.linaro.org,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <CAEUSe7_wmKS361mKLTB1eYbzYXcKkXdU26BX5BojdKRz8MfPCw@mail.gmail.com>
References: <CAEUSe7_wmKS361mKLTB1eYbzYXcKkXdU26BX5BojdKRz8MfPCw@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <158894307885.8414.8667037968260608820.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     19ce2321739da5fc27f6a5ed1e1cb15e384ad030
Gitweb:        https://git.kernel.org/tip/19ce2321739da5fc27f6a5ed1e1cb15e384ad030
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 05 May 2020 13:33:12 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:32 -03:00

perf flamegraph: Use /bin/bash for report and record scripts

As all the other tools/perf/scripts/python/bin/*-{report,record}
scripts, fixing the this problem reported by Daniel Diaz:

  Our OpenEmbedded builds detected an issue with 5287f9269206 ("perf
  script: Add flamegraph.py script"):
    ERROR: perf-1.0-r9 do_package_qa: QA Issue:
  /usr/libexec/perf-core/scripts/python/bin/flamegraph-report contained
  in package perf-python requires /usr/bin/sh, but no providers found in
  RDEPENDS_perf-python? [file-rdeps]

  This means that there is a new binary pulled in in the shebang line
  which was unaccounted for: `/usr/bin/sh`. I don't see any other usage
  of /usr/bin/sh in the kernel tree (does not even exist on my Ubuntu
  dev machine) but plenty of /bin/sh. This patch is needed:
  -----8<----------8<----------8<-----
  diff --git a/tools/perf/scripts/python/bin/flamegraph-record
  b/tools/perf/scripts/python/bin/flamegraph-record
  index 725d66e71570..a2f3fa25ef81 100755
  --- a/tools/perf/scripts/python/bin/flamegraph-record
  +++ b/tools/perf/scripts/python/bin/flamegraph-record
  @@ -1,2 +1,2 @@
  -#!/usr/bin/sh
  +#!/bin/sh
   perf record -g "$@"
  diff --git a/tools/perf/scripts/python/bin/flamegraph-report
  b/tools/perf/scripts/python/bin/flamegraph-report
  index b1a79afd903b..b0177355619b 100755
  --- a/tools/perf/scripts/python/bin/flamegraph-report
  +++ b/tools/perf/scripts/python/bin/flamegraph-report
  @@ -1,3 +1,3 @@
  -#!/usr/bin/sh
  +#!/bin/sh
   # description: create flame graphs
   perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
  ----->8---------->8---------->8-----

Fixes: 5287f9269206 ("perf script: Add flamegraph.py script")
Reported-by: Daniel Díaz <daniel.diaz@linaro.org>
Acked-by: Andreas Gerstmayr <agerstmayr@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: lkft-triage@lists.linaro.org
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/CAEUSe7_wmKS361mKLTB1eYbzYXcKkXdU26BX5BojdKRz8MfPCw@mail.gmail.com
Link: http://lore.kernel.org/lkml/20200505170320.GZ30487@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/bin/flamegraph-record | 2 +-
 tools/perf/scripts/python/bin/flamegraph-report | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/python/bin/flamegraph-record b/tools/perf/scripts/python/bin/flamegraph-record
index 725d66e..7df5a19 100755
--- a/tools/perf/scripts/python/bin/flamegraph-record
+++ b/tools/perf/scripts/python/bin/flamegraph-record
@@ -1,2 +1,2 @@
-#!/usr/bin/sh
+#!/bin/bash
 perf record -g "$@"
diff --git a/tools/perf/scripts/python/bin/flamegraph-report b/tools/perf/scripts/python/bin/flamegraph-report
index b1a79af..53c5dc9 100755
--- a/tools/perf/scripts/python/bin/flamegraph-report
+++ b/tools/perf/scripts/python/bin/flamegraph-report
@@ -1,3 +1,3 @@
-#!/usr/bin/sh
+#!/bin/bash
 # description: create flame graphs
 perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
