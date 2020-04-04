Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA52C2BA18
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A44420752
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDDImQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:42:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41568 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgDDImE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:04 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNF-00014F-A5; Sat, 04 Apr 2020 10:41:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7D00B1C07EC;
        Sat,  4 Apr 2020 10:41:50 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:50 -0000
From:   "tip-bot2 for Hagen Paul Pfeifer" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf script: Introduce --deltatime option
Cc:     Hagen Paul Pfeifer <hagen@jauu.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200204173709.489161-1-hagen@jauu.net>
References: <20200204173709.489161-1-hagen@jauu.net>
MIME-Version: 1.0
Message-ID: <158598971015.28353.16760736954390988398.tip-bot2@tip-bot2>
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

Commit-ID:     26567ed79d13ec54b2c5661ce8a07fd149a23a9b
Gitweb:        https://git.kernel.org/tip/26567ed79d13ec54b2c5661ce8a07fd149a23a9b
Author:        Hagen Paul Pfeifer <hagen@jauu.net>
AuthorDate:    Tue, 04 Feb 2020 18:37:09 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 27 Mar 2020 10:38:47 -03:00

perf script: Introduce --deltatime option

For some kind of analysis a deltatime output is more human friendly and
reduce the cognitive load for further analysis.

The following output demonstrate the new option "deltatime": calculate
the time difference in relation to the previous event.

  $ perf script --deltatime
  test  2525 [001]     0.000000:            sdt_libev:ev_add: (5635e72a5ebd)
  test  2525 [001]     0.000091:  sdt_libev:epoll_wait_enter: (5635e72a76a9)
  test  2525 [001]     1.000051: sdt_libev:epoll_wait_return: (5635e72a772e) arg1=1
  test  2525 [001]     0.000685:            sdt_libev:ev_add: (5635e72a5ebd)
  test  2525 [001]     0.000048:  sdt_libev:epoll_wait_enter: (5635e72a76a9)
  test  2525 [001]     1.000104: sdt_libev:epoll_wait_return: (5635e72a772e) arg1=1
  test  2525 [001]     0.003895:  sdt_libev:epoll_wait_enter: (5635e72a76a9)
  test  2525 [001]     0.996034: sdt_libev:epoll_wait_return: (5635e72a772e) arg1=1
  test  2525 [001]     0.000058:  sdt_libev:epoll_wait_enter: (5635e72a76a9)
  test  2525 [001]     1.000004: sdt_libev:epoll_wait_return: (5635e72a772e) arg1=1
  test  2525 [001]     0.000064:  sdt_libev:epoll_wait_enter: (5635e72a76a9)
  test  2525 [001]     0.999934: sdt_libev:epoll_wait_return: (5635e72a772e) arg1=1
  test  2525 [001]     0.000056:  sdt_libev:epoll_wait_enter: (5635e72a76a9)
  test  2525 [001]     0.999930: sdt_libev:epoll_wait_return: (5635e72a772e) arg1=1

Committer testing:

So go from default output to --reltime and then this new --deltatime, to
contrast the various timestamp presentation modes for a random perf.data file I
had laying around:

  [root@five ~]# perf script --reltime | head
     perf 442394 [000]     0.000000:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [000]     0.000002:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [000]     0.000004:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [000]     0.000006:  128 cycles: ffffffff972415a1 perf_event_update_userpage+0x1 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [000]     0.000009: 2597 cycles: ffffffff97463785 cap_task_setscheduler+0x5 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]     0.000036:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]     0.000038:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]     0.000040:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]     0.000041:  224 cycles: ffffffff9700a53a perf_ibs_handle_irq+0x1da (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]     0.000044: 4439 cycles: ffffffff97120d85 put_prev_entity+0x45 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
  [root@five ~]# perf script --deltatime | head
     perf 442394 [000]     0.000000:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [000]     0.000002:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [000]     0.000001:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [000]     0.000001:  128 cycles: ffffffff972415a1 perf_event_update_userpage+0x1 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [000]     0.000002: 2597 cycles: ffffffff97463785 cap_task_setscheduler+0x5 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]     0.000027:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]     0.000002:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]     0.000001:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]     0.000001:  224 cycles: ffffffff9700a53a perf_ibs_handle_irq+0x1da (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]     0.000002: 4439 cycles: ffffffff97120d85 put_prev_entity+0x45 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
  [root@five ~]# perf script | head
     perf 442394 [000]  7600.157861:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [000]  7600.157864:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [000]  7600.157866:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [000]  7600.157867:  128 cycles: ffffffff972415a1 perf_event_update_userpage+0x1 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [000]  7600.157870: 2597 cycles: ffffffff97463785 cap_task_setscheduler+0x5 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]  7600.157897:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]  7600.157900:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]  7600.157901:   16 cycles: ffffffff9706e544 native_write_msr+0x4 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]  7600.157903:  224 cycles: ffffffff9700a53a perf_ibs_handle_irq+0x1da (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
     perf 442394 [001]  7600.157906: 4439 cycles: ffffffff97120d85 put_prev_entity+0x45 (/usr/lib/debug/lib/modules/5.5.10-200.fc31.x86_64/vmlinux)
  [root@five ~]#

Andi suggested we better implement it as a new field, i.e. -F deltatime, like:

  [root@five ~]# perf script -F deltatime
  Invalid field requested.

   Usage: perf script [<options>]
      or: perf script [<options>] record <script> [<record-options>] <command>
      or: perf script [<options>] report <script> [script-args]
      or: perf script [<options>] <script> [<record-options>] <command>
      or: perf script [<options>] <top-script> [script-args]

      -F, --fields <str>    comma separated output fields prepend with 'type:'. +field to add and -field to remove.Valid types: hw,sw,trace,raw,synth. Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,addr,symoff,srcline,period,iregs,uregs,brstack,brstacksym,flags,bpf-output,brstackinsn,brstackoff,callindent,insn,insnlen,synth,phys_addr,metric,misc,ipc
  [root@five ~]#

I.e. we have -F for maximum flexibility:

  [root@five ~]# perf script -F comm,pid,cpu,time | head
            perf 442394 [000]  7600.157861:
            perf 442394 [000]  7600.157864:
            perf 442394 [000]  7600.157866:
            perf 442394 [000]  7600.157867:
            perf 442394 [000]  7600.157870:
            perf 442394 [001]  7600.157897:
            perf 442394 [001]  7600.157900:
            perf 442394 [001]  7600.157901:
            perf 442394 [001]  7600.157903:
            perf 442394 [001]  7600.157906:
  [root@five ~]#

But since we already have --reltime, having --deltatime, documented one after
the other is sensible.

Signed-off-by: Hagen Paul Pfeifer <hagen@jauu.net>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20200204173709.489161-1-hagen@jauu.net
[ Added 'perf script' man page entry for --deltatime ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt |  3 +++
 tools/perf/builtin-script.c              | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index db6a36a..4af255b 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -390,6 +390,9 @@ include::itrace.txt[]
 --reltime::
 	Print time stamps relative to trace start.
 
+--deltatime::
+	Print time stamps relative to previous event.
+
 --per-event-dump::
 	Create per event files with a "perf.data.EVENT.dump" name instead of
         printing to stdout, useful, for instance, for generating flamegraphs.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 656b347..f63869a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -63,7 +63,9 @@
 static char const		*script_name;
 static char const		*generate_script_lang;
 static bool			reltime;
+static bool			deltatime;
 static u64			initial_time;
+static u64			previous_time;
 static bool			debug_mode;
 static u64			last_timestamp;
 static u64			nr_unordered;
@@ -704,6 +706,13 @@ static int perf_sample__fprintf_start(struct perf_sample *sample,
 			if (!initial_time)
 				initial_time = sample->time;
 			t = sample->time - initial_time;
+		} else if (deltatime) {
+			if (previous_time)
+				t = sample->time - previous_time;
+			else {
+				t = 0;
+			}
+			previous_time = sample->time;
 		}
 		nsecs = t;
 		secs = nsecs / NSEC_PER_SEC;
@@ -3555,6 +3564,7 @@ int cmd_script(int argc, const char **argv)
 		     "anything beyond the specified depth will be ignored. "
 		     "Default: kernel.perf_event_max_stack or " __stringify(PERF_MAX_STACK_DEPTH)),
 	OPT_BOOLEAN(0, "reltime", &reltime, "Show time stamps relative to start"),
+	OPT_BOOLEAN(0, "deltatime", &deltatime, "Show time stamps relative to previous event"),
 	OPT_BOOLEAN('I', "show-info", &show_full_info,
 		    "display extended information from perf.data file"),
 	OPT_BOOLEAN('\0', "show-kernel-path", &symbol_conf.show_kernel_path,
@@ -3651,6 +3661,13 @@ int cmd_script(int argc, const char **argv)
 		}
 	}
 
+	if (reltime && deltatime) {
+		fprintf(stderr,
+			"reltime and deltatime - the two don't get along well. "
+			"Please limit to --reltime or --deltatime.\n");
+		return -1;
+	}
+
 	if (itrace_synth_opts.callchain &&
 	    itrace_synth_opts.callchain_sz > scripting_max_stack)
 		scripting_max_stack = itrace_synth_opts.callchain_sz;
