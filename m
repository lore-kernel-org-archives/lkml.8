Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0F9C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72B962072D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588022416;
	bh=riRwBx+YZTQDXxiljbZJX3t+l7MWCNpich6K1bc/paw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CcFQanx0FMCOt3iohwrF9rENUlmNZaniGejSh2+stvSxd6FTpSNPVnMDaQ9JSqMbb
	 ZRR2bdrC+DkL8JWwf/WsZ0nhFzwjq7uOuZYBgYMsf9cHSVsu4eH4z8PUixDI2fYSgk
	 fNAmEyh1tEGAPq31woErNfYoAFDv2QS2NcLnLEoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgD0VUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgD0VUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:20:13 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FE522078C;
        Mon, 27 Apr 2020 21:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588022412;
        bh=riRwBx+YZTQDXxiljbZJX3t+l7MWCNpich6K1bc/paw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tLUyfNF0pxd/Txkpj2VOtna/yuapQYtL69oy0gsvhcO4hHtEcUrMGDSHfWs5/T3D3
         uJsqazuGOrgsdfbUWRq0rlrhZ4CVLQWWmpSZ7/su4Bb10qAbziUZ02VogfPqd5oBQG
         ybo6XffdgIQhnW3G764fkEMWIpaxUAsSRibICH2w=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 7/7] perf record: Introduce --switch-output-event
Date:   Mon, 27 Apr 2020 18:19:35 -0300
Message-Id: <20200427211935.25789-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427211935.25789-1-acme@kernel.org>
References: <20200427211935.25789-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now we can use it with --overwrite to have a flight recorder mode that
gets snapshot requests from arbitrary events that are processed in the
side band thread together with the PERF_RECORD_BPF_EVENT processing.

Example:

To collect scheduler events until a recvmmsg syscall happens, system
wide:

  [root@five a]# rm -f perf.data.2020042717*
  [root@five a]# perf record --overwrite -e sched:*switch,syscalls:*recvmmsg --switch-output-event syscalls:sys_enter_recvmmsg
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2020042717585458 ]
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2020042717590235 ]
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2020042717590398 ]
  ^C[ perf record: Woken up 1 times to write data ]
  [ perf record: Dump perf.data.2020042717590511 ]
  [ perf record: Captured and wrote 7.244 MB perf.data.<timestamp> ]

So in the above case we had 3 snapshots, the fourth was forced by
control+C:

  [root@five a]# ls -la
  total 20440
  drwxr-xr-x.  2 root root    4096 Apr 27 17:59 .
  dr-xr-x---. 12 root root    4096 Apr 27 17:46 ..
  -rw-------.  1 root root 3936125 Apr 27 17:58 perf.data.2020042717585458
  -rw-------.  1 root root 5074869 Apr 27 17:59 perf.data.2020042717590235
  -rw-------.  1 root root 4291037 Apr 27 17:59 perf.data.2020042717590398
  -rw-------.  1 root root 7617037 Apr 27 17:59 perf.data.2020042717590511
  [root@five a]#

One can make this more precise by adding the switch output event to the
main -e events list, as since this is done asynchronously, a few events
after the signal event will appear in the snapshots, as can be seen
with:

  [root@five a]# rm -f perf.data.20200427175*
  [root@five a]# perf record --overwrite -e sched:*switch,syscalls:*recvmmsg --switch-output-event syscalls:sys_enter_recvmmsg
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2020042718024203 ]
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2020042718024301 ]
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2020042718024484 ]
  ^C[ perf record: Woken up 1 times to write data ]
  [ perf record: Dump perf.data.2020042718024562 ]
  [ perf record: Captured and wrote 7.337 MB perf.data.<timestamp> ]
  [root@five a]# perf script -i perf.data.2020042718024203 | tail -15
       PacerThread 148586 [005] 122.830729: sched:sched_switch: prev_comm=PacerThread prev_pid=148586...
           swapper      0 [000] 122.833588: sched:sched_switch: prev_comm=swapper/0 prev_pid=...
    NetworkManager   1251 [000] 122.833619: syscalls:sys_enter_recvmmsg: fd: 0x0000001c, mmsg: 0x7ffe83054a1...
           swapper      0 [002] 122.833624: sched:sched_switch: prev_comm=swapper/2 prev_pid=...
           swapper      0 [003] 122.833624: sched:sched_switch: prev_comm=swapper/3 prev_pid=...
    NetworkManager   1251 [000] 122.833626: syscalls:sys_exit_recvmmsg: 0x1
   kworker/3:3-eve 158946 [003] 122.833628: sched:sched_switch: prev_comm=kworker/3:3 prev_pid=15894...
           swapper      0 [004] 122.833641: sched:sched_switch: prev_comm=swapper/4 prev_pid=...
    NetworkManager   1251 [000] 122.833642: sched:sched_switch: prev_comm=NetworkManage...
              perf 228273 [002] 122.833645: sched:sched_switch: prev_comm=perf prev_pid=22827...
           swapper      0 [011] 122.833646: sched:sched_switch: prev_comm=swapper/1...
           swapper      0 [002] 122.833648: sched:sched_switch: prev_comm=swapper/...
   kworker/0:2-eve 207387 [000] 122.833648: sched:sched_switch: prev_comm=kworker/0:2 prev_pid=20738...
   kworker/2:3-eve 232038 [002] 122.833652: sched:sched_switch: prev_comm=kworker/2:3 prev_pid=23203...
              perf 235825 [003] 122.833653: sched:sched_switch: prev_comm=perf prev_pid=23582...
  [root@five a]#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Wang Nan <wangnan0@huawei.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt | 13 ++++++++
 tools/perf/builtin-record.c              | 40 +++++++++++++++++++++---
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 6e8b4649307c..561ef55743e2 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -556,6 +556,19 @@ overhead. You can still switch them on with:
 
   --switch-output --no-no-buildid  --no-no-buildid-cache
 
+--switch-output-event::
+Events that will cause the switch of the perf.data file, auto-selecting
+--switch-output=signal, the results are similar as internally the side band
+thread will also send a SIGUSR2 to the main one.
+
+Uses the same syntax as --event, it will just not be recorded, serving only to
+switch the perf.data file as soon as the --switch-output event is processed by
+a separate sideband thread.
+
+This sideband thread is also used to other purposes, like processing the
+PERF_RECORD_BPF_EVENT records as they happen, asking the kernel for extra BPF
+information, etc.
+
 --switch-max-files=N::
 
 When rotating perf.data with --switch-output, only keep N files.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ed2244847400..8ff5eaec26e9 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -87,6 +87,7 @@ struct record {
 	struct evlist	*evlist;
 	struct perf_session	*session;
 	struct evlist		*sb_evlist;
+	pthread_t		thread_id;
 	int			realtime_prio;
 	bool			no_buildid;
 	bool			no_buildid_set;
@@ -1436,6 +1437,13 @@ static int record__synthesize(struct record *rec, bool tail)
 	return err;
 }
 
+static int record__process_signal_event(union perf_event *event __maybe_unused, void *data)
+{
+	struct record *rec = data;
+	pthread_kill(rec->thread_id, SIGUSR2);
+	return 0;
+}
+
 static int __cmd_record(struct record *rec, int argc, const char **argv)
 {
 	int err;
@@ -1580,12 +1588,24 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		goto out_child;
 	}
 
-	if (!opts->no_bpf_event) {
-		rec->sb_evlist = evlist__new();
+	if (rec->sb_evlist != NULL) {
+		/*
+		 * We get here if --switch-output-event populated the
+		 * sb_evlist, so associate a callback that will send a SIGUSR2
+		 * to the main thread.
+		 */
+		evlist__set_cb(rec->sb_evlist, record__process_signal_event, rec);
+		rec->thread_id = pthread_self();
+	}
 
+	if (!opts->no_bpf_event) {
 		if (rec->sb_evlist == NULL) {
-			pr_err("Couldn't create side band evlist.\n.");
-			goto out_child;
+			rec->sb_evlist = evlist__new();
+
+			if (rec->sb_evlist == NULL) {
+				pr_err("Couldn't create side band evlist.\n.");
+				goto out_child;
+			}
 		}
 
 		if (evlist__add_bpf_sb_event(rec->sb_evlist, &session->header.env)) {
@@ -2179,10 +2199,19 @@ static int switch_output_setup(struct record *rec)
 	};
 	unsigned long val;
 
+	/*
+	 * If we're using --switch-output-events, then we imply its 
+	 * --switch-output=signal, as we'll send a SIGUSR2 from the side band
+	 *  thread to its parent.
+	 */
+	if (rec->sb_evlist != NULL)
+		goto do_signal;
+
 	if (!s->set)
 		return 0;
 
 	if (!strcmp(s->str, "signal")) {
+do_signal:
 		s->signal = true;
 		pr_debug("switch-output with SIGUSR2 signal\n");
 		goto enabled;
@@ -2440,6 +2469,9 @@ static struct option __record_options[] = {
 			  &record.switch_output.set, "signal or size[BKMG] or time[smhd]",
 			  "Switch output when receiving SIGUSR2 (signal) or cross a size or time threshold",
 			  "signal"),
+	OPT_CALLBACK(0, "switch-output-event", &record.sb_evlist, "switch output event",
+		     "switch output event selector. use 'perf list' to list available events",
+		     parse_events_option_new_evlist),
 	OPT_INTEGER(0, "switch-max-files", &record.switch_output.num_files,
 		   "Limit number of switch output generated files"),
 	OPT_BOOLEAN(0, "dry-run", &dry_run,
-- 
2.21.1

