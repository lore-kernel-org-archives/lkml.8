Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0DBC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D6724958
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588947830;
	bh=1v3tg/OoW60iRo1fXDuixOh866E07RNVlUrP5qpcGTc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=vI9NfLxnS3jQbO5Qxze0tWwch0/EV6KiNA25OlKMVBYJ8SIfgSOXleClkepjaBs4u
	 5tdQIgr8fLUx8F0uMblupbb18B+yNmHxnTZCeNM8vCg2QHbZypkysZ038vXPMlKJ1V
	 KiihAuJqbH4ijEntZiWTqv4UUZecC77GcPJ8g25U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgEHOXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 10:23:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgEHOXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:23:49 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3EC624954;
        Fri,  8 May 2020 14:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588947828;
        bh=1v3tg/OoW60iRo1fXDuixOh866E07RNVlUrP5qpcGTc=;
        h=From:To:Cc:Subject:Date:From;
        b=m454W3acRf69MxN80Gx4Z/go2wPuF4TOfvjINg4SZE+tP+0AIbLgI/VLojNg+z/EO
         3KacUg1UAbfEL8dIxoFtDa7Div8hOFlCOmumKDMEaZYsispK/ryNZAt8asb7o6A6wT
         yYhJr3bYo+B6gVbldgdLnoxFqugNjtHY4cMAo6UM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2] selftests/ftrace: Use /bin/echo instead of built-in echo
Date:   Fri,  8 May 2020 23:23:43 +0900
Message-Id: <158894782360.14326.6909620051395004844.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the built-in echo has different behavior in POSIX shell
(dash) and bash, we forcibly use /bin/echo -E (not interpret
backslash escapes) by default.

This also fixes some test cases which expects built-in
echo command since the built-in echo command will share
the same pid with the shell.

trigger-trace-marker-hist.tc and trigger-trace-marker-synthetic.tc
write trace_marker several times to make a histogram with the pid
as the key. If we use /bin/echo command, the pid-key is different
each time and failed to make a histogram. This changes those test
to use "ip" (called address) as a key which should be always same
if trace_marker is used.

For trigger-trace-marker-synthetic-kernel.tc, this uses built-in
echo as a special case, because the test case is based on the
wakeup event and the trace_marker event and uses the pid as
common-key for those events. In this case, we must use built-in
echo to make a short "sleep, wakeup and write" program.

Reported-by: Liu Yiding <yidingx.liu@intel.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 Changes in v2:
  - Add descriptions for some test-case fixes.
---
 tools/testing/selftests/ftrace/test.d/functions    |    4 ++++
 .../test.d/trigger/trigger-trace-marker-hist.tc    |    2 +-
 .../trigger-trace-marker-synthetic-kernel.tc       |    4 ++++
 .../trigger/trigger-trace-marker-synthetic.tc      |    4 ++--
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 61a3c7e2634d..0ff92aa12e2a 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -1,3 +1,7 @@
+# Since the built-in echo has different behavior in POSIX shell (dash) and
+# bash, we forcibly use /bin/echo -E (not interpret backslash escapes).
+alias echo="/bin/echo -E"
+
 check_filter_file() { # check filter file introduced by dynamic ftrace
     if [ ! -f "$1" ]; then
         echo "$1 not found? Is dynamic ftrace not set?"
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
index ab6bedb25736..b3f70f53ee69 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-hist.tc
@@ -30,7 +30,7 @@ fi
 
 echo "Test histogram trace_marker tigger"
 
-echo 'hist:keys=common_pid' > events/ftrace/print/trigger
+echo 'hist:keys=ip' > events/ftrace/print/trigger
 for i in `seq 1 10` ; do echo "hello" > trace_marker; done
 grep 'hitcount: *10$' events/ftrace/print/hist > /dev/null || \
     fail "hist trigger did not trigger correct times on trace_marker"
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
index 18b4d1c2807e..c1625d945f4d 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic-kernel.tc
@@ -44,6 +44,10 @@ echo 'latency u64 lat' > synthetic_events
 echo 'hist:keys=pid:ts0=common_timestamp.usecs' > events/sched/sched_waking/trigger
 echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).latency($lat)' > events/ftrace/print/trigger
 echo 'hist:keys=common_pid,lat:sort=lat' > events/synthetic/latency/trigger
+
+# We have to use the built-in echo here because waking up pid must be same
+# as echoing pid.
+alias echo=echo
 sleep 1
 echo "hello" > trace_marker
 
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
index dd262d6d0db6..23e52c8d71de 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-trace-marker-synthetic.tc
@@ -36,8 +36,8 @@ fi
 echo "Test histogram trace_marker to trace_marker latency histogram trigger"
 
 echo 'latency u64 lat' > synthetic_events
-echo 'hist:keys=common_pid:ts0=common_timestamp.usecs if buf == "start"' > events/ftrace/print/trigger
-echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$ts0:onmatch(ftrace.print).latency($lat) if buf == "end"' >> events/ftrace/print/trigger
+echo 'hist:keys=ip:ts0=common_timestamp.usecs if buf == "start"' > events/ftrace/print/trigger
+echo 'hist:keys=ip:lat=common_timestamp.usecs-$ts0:onmatch(ftrace.print).latency($lat) if buf == "end"' >> events/ftrace/print/trigger
 echo 'hist:keys=common_pid,lat:sort=lat' > events/synthetic/latency/trigger
 echo -n "start" > trace_marker
 echo -n "end" > trace_marker

