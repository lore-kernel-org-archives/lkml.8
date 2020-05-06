Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E255C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B7620936
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778593;
	bh=Hb64Q63oMZlKV2BsNDJujDgEug1FiI9q3SPI+/21yS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G99/8MMkNx6AkQN0ZiWoNtXauNSnBxjRqLBBDWdcRyMQedCgnjjdkliq5KMvPNrV3
	 fo1dzCMRhCE+iKKLEkbr+B6c8Ex+lS0IIj7i0wD+4OjVEucGu9h20siyKl0p6IhK6U
	 TBS+JOKVSZoNPgFLDOokh0Yz3asiCN5Rua+e9ndA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbgEFPXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:23:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729066AbgEFPXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:23:09 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3732421775;
        Wed,  6 May 2020 15:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778588;
        bh=Hb64Q63oMZlKV2BsNDJujDgEug1FiI9q3SPI+/21yS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OXfLXR6P0ym/eI3JPv5doXglG0tKccS2piQ1zgxXGX67+tHF6SonJ4GwEyeBPENU4
         YvGX8IJLsM3wyZs2EM+oZZGu45IZ4QHeXTtoGz2Vhnk4MC8aV4Gw1pyBqRvL4Oe6Ol
         aT6iP9BzI30deC9RsjQ9OfGEgNpBPY6UvJq7Gsk0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 07/91] perf test session topology: Fix data path
Date:   Wed,  6 May 2020 12:21:10 -0300
Message-Id: <20200506152234.21977-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tommi Rantala <tommi.t.rantala@nokia.com>

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
index 4a800499d7c3..22daf2bdf5fa 100644
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
 
-- 
2.21.1

