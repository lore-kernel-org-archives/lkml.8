Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20CDC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6D5024973
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgEHNF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730517AbgEHNF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A362C05BD43;
        Fri,  8 May 2020 06:05:27 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gn-0007f1-HE; Fri, 08 May 2020 15:05:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D8B701C04DF;
        Fri,  8 May 2020 15:05:03 +0200 (CEST)
Date:   Fri, 08 May 2020 13:05:03 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf record: Introduce --switch-output-event
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200429131106.27974-8-acme@kernel.org>
References: <20200429131106.27974-8-acme@kernel.org>
MIME-Version: 1.0
Message-ID: <158894310379.8414.1005383593774333986.tip-bot2@tip-bot2>
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

Commit-ID:     899e5ffbf246a30986ced9dd48092c408978afc7
Gitweb:        https://git.kernel.org/tip/899e5ffbf246a30986ced9dd48092c408978afc7
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 27 Apr 2020 17:56:37 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:29 -03:00

perf record: Introduce --switch-output-event

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

Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lore.kernel.org/lkml/20200429131106.27974-8-acme@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt | 13 +++++++-
 tools/perf/builtin-record.c              | 41 ++++++++++++++++++++---
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 6e8b464..561ef55 100644
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
index 5b6a1d2..bb5b4d2 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -88,7 +88,9 @@ struct record {
 	struct evlist	*evlist;
 	struct perf_session	*session;
 	struct evlist		*sb_evlist;
+	pthread_t		thread_id;
 	int			realtime_prio;
+	bool			switch_output_event_set;
 	bool			no_buildid;
 	bool			no_buildid_set;
 	bool			no_buildid_cache;
@@ -1437,6 +1439,13 @@ out:
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
@@ -1581,12 +1590,24 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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
@@ -2180,10 +2201,19 @@ static int switch_output_setup(struct record *rec)
 	};
 	unsigned long val;
 
+	/*
+	 * If we're using --switch-output-events, then we imply its 
+	 * --switch-output=signal, as we'll send a SIGUSR2 from the side band
+	 *  thread to its parent.
+	 */
+	if (rec->switch_output_event_set)
+		goto do_signal;
+
 	if (!s->set)
 		return 0;
 
 	if (!strcmp(s->str, "signal")) {
+do_signal:
 		s->signal = true;
 		pr_debug("switch-output with SIGUSR2 signal\n");
 		goto enabled;
@@ -2441,6 +2471,9 @@ static struct option __record_options[] = {
 			  &record.switch_output.set, "signal or size[BKMG] or time[smhd]",
 			  "Switch output when receiving SIGUSR2 (signal) or cross a size or time threshold",
 			  "signal"),
+	OPT_CALLBACK_SET(0, "switch-output-event", &record.sb_evlist, &record.switch_output_event_set, "switch output event",
+			 "switch output event selector. use 'perf list' to list available events",
+			 parse_events_option_new_evlist),
 	OPT_INTEGER(0, "switch-max-files", &record.switch_output.num_files,
 		   "Limit number of switch output generated files"),
 	OPT_BOOLEAN(0, "dry-run", &dry_run,
