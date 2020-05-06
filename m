Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C383CC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F7D32068E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778872;
	bh=cf89RZvLrBJYmS+C3/XVkNdKP8F0lWWscrFG2GOTFnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K/yIIMBNMkwXA7EgtGJp+EfiMwsa8c+mrB6c91Rp48YXz7DmgWc6fgcI/aeFi4VNU
	 kjOvq14CJtINlwXZZiRrl7nKdzmzdIsvNvxr46p7IUU8NYvQcf/CVquI0NlWU4QfGd
	 I1PE862aY5a09JrSCAL0OZ11WPF9Yfi6AFs4XLKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbgEFP1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:27:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730379AbgEFP1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:27:45 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7008B2068E;
        Wed,  6 May 2020 15:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778865;
        bh=cf89RZvLrBJYmS+C3/XVkNdKP8F0lWWscrFG2GOTFnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lfJKvSvsjqdPg9LHyNmrULeTn3I0dLyc1+IrHrCbP1sUiGmCQaJx+z0z80IYvn6yn
         3Pvl4BITkaUjfapbp2utyxmDq7BFeE/srBdYomxJ7qvdVzhdVRjp5uPA6n+ywukoAw
         qDni/oaW6mecpcgjyyt234GYbcIKloMqutiRbZsQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Andreas Gerstmayr <agerstmayr@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        lkft-triage@lists.linaro.org
Subject: [PATCH 91/91] perf flamegraph: Use /bin/bash for report and record scripts
Date:   Wed,  6 May 2020 12:22:34 -0300
Message-Id: <20200506152234.21977-92-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index 725d66e71570..7df5a19c0163 100755
--- a/tools/perf/scripts/python/bin/flamegraph-record
+++ b/tools/perf/scripts/python/bin/flamegraph-record
@@ -1,2 +1,2 @@
-#!/usr/bin/sh
+#!/bin/bash
 perf record -g "$@"
diff --git a/tools/perf/scripts/python/bin/flamegraph-report b/tools/perf/scripts/python/bin/flamegraph-report
index b1a79afd903b..53c5dc90c87e 100755
--- a/tools/perf/scripts/python/bin/flamegraph-report
+++ b/tools/perf/scripts/python/bin/flamegraph-report
@@ -1,3 +1,3 @@
-#!/usr/bin/sh
+#!/bin/bash
 # description: create flame graphs
 perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
-- 
2.21.1

