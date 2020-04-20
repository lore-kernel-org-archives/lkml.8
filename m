Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A2CC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F0962071C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383615;
	bh=C+Ht8Ig+oP2aA02sPboO4LzooPFGVAHYU6P5xjE7qKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ckyj6ZVCPBZS2AtX2VFIs7sDWkDQsylIL/C5QFQvIAGvJHzh090N9fyczEhH8IiMC
	 p0afClOdr50T2hc0MjjSQ1kUwB32pDfZ3WmzHqK2byvPhvU6Xy9Ub4asCeuEHOHzLd
	 H+BNDmHyQ1i+I/47SlZn+P/E47ywCCuMlvZ46Qhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgDTLxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:53:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbgDTLx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:53:28 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F55F218AC;
        Mon, 20 Apr 2020 11:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383608;
        bh=C+Ht8Ig+oP2aA02sPboO4LzooPFGVAHYU6P5xjE7qKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W1YRr5UXXWfmtLZPsTTbU3OfaUo6ENOnte7wSj9AnS02mLkw99tln7evXeP5d16q7
         7qOQaLVFNvucyEoTZ/YDkgb8so5inE82oTDoQioBFZtWv9iTnJqFllHknC8c89mjYF
         2U7WfMPgCNSIqQPk3NG+JVKrIhIj3gDq77dtsxlw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Konstantin Kharlamov <hi-angel@yandex.ru>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>
Subject: [PATCH 01/60] perf stat: Honour --timeout for forked workloads
Date:   Mon, 20 Apr 2020 08:52:17 -0300
Message-Id: <20200420115316.18781-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index ec053dc1e35c..9207b6c45475 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -686,8 +686,11 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
-- 
2.21.1

