Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CD7C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5DA24677
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgAJRyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:54:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59193 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbgAJRxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:53:30 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyTN-0001m9-8v; Fri, 10 Jan 2020 18:53:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EC8971C2D5E;
        Fri, 10 Jan 2020 18:53:17 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:53:17 -0000
From:   "tip-bot2 for David Ahern" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf sched timehist: Add support for filtering on CPU
Cc:     David Ahern <dsahern@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191204173925.66976-1-dsahern@kernel.org>
References: <20191204173925.66976-1-dsahern@kernel.org>
MIME-Version: 1.0
Message-ID: <157867879783.30329.14601250233681313833.tip-bot2@tip-bot2>
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

Commit-ID:     c30d630d1bcfad8d2f70ff0cbb2a86d5a43bc152
Gitweb:        https://git.kernel.org/tip/c30d630d1bcfad8d2f70ff0cbb2a86d5a43bc152
Author:        David Ahern <dsahern@gmail.com>
AuthorDate:    Wed, 04 Dec 2019 10:39:25 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 06 Jan 2020 11:46:09 -03:00

perf sched timehist: Add support for filtering on CPU

Allow user to limit output to one or more CPUs. Really helpful on
systems with a large number of cpus.

Committer testing:

  # perf sched record -a sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.765 MB perf.data (1412 samples) ]
  [root@quaco ~]# perf sched timehist | head
  Samples do not have callchains.
             time    cpu  task name                       wait time  sch delay   run time
                          [tid/pid]                          (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  ---------  ---------  ---------
     66307.802686 [0000]  perf[13086]                         0.000      0.000      0.000
     66307.802700 [0000]  migration/0[12]                     0.000      0.001      0.014
     66307.802766 [0001]  perf[13086]                         0.000      0.000      0.000
     66307.802774 [0001]  migration/1[15]                     0.000      0.001      0.007
     66307.802841 [0002]  perf[13086]                         0.000      0.000      0.000
     66307.802849 [0002]  migration/2[20]                     0.000      0.001      0.008
     66307.802913 [0003]  perf[13086]                         0.000      0.000      0.000
  #
  # perf sched timehist --cpu 2 | head
  Samples do not have callchains.
             time    cpu  task name                       wait time  sch delay   run time
                          [tid/pid]                          (msec)     (msec)     (msec)
  --------------- ------  ------------------------------  ---------  ---------  ---------
     66307.802841 [0002]  perf[13086]                         0.000      0.000      0.000
     66307.802849 [0002]  migration/2[20]                     0.000      0.001      0.008
     66307.964485 [0002]  <idle>                              0.000      0.000    161.635
     66307.964811 [0002]  CPU 0/KVM[3589/3561]                0.000      0.056      0.325
     66307.965477 [0002]  <idle>                              0.325      0.000      0.666
     66307.965553 [0002]  CPU 0/KVM[3589/3561]                0.666      0.024      0.076
     66307.966456 [0002]  <idle>                              0.076      0.000      0.903
  #

Signed-off-by: David Ahern <dsahern@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20191204173925.66976-1-dsahern@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-sched.txt |  4 ++++
 tools/perf/builtin-sched.c              | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index 63f938b..5fbe42b 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -110,6 +110,10 @@ OPTIONS for 'perf sched timehist'
 --max-stack::
 	Maximum number of functions to display in backtrace, default 5.
 
+-C=::
+--cpu=::
+	Only show events for the given CPU(s) (comma separated list).
+
 -p=::
 --pid=::
 	Only show events for given process ID (comma separated list).
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 8a12d71..82fcc2c 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -51,6 +51,9 @@
 #define SYM_LEN			129
 #define MAX_PID			1024000
 
+static const char *cpu_list;
+static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
+
 struct sched_atom;
 
 struct task_desc {
@@ -2008,6 +2011,9 @@ static void timehist_print_sample(struct perf_sched *sched,
 	char nstr[30];
 	u64 wait_time;
 
+	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
+		return;
+
 	timestamp__scnprintf_usec(t, tstr, sizeof(tstr));
 	printf("%15s [%04d] ", tstr, sample->cpu);
 
@@ -2994,6 +3000,12 @@ static int perf_sched__timehist(struct perf_sched *sched)
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
+	if (cpu_list) {
+		err = perf_session__cpu_bitmap(session, cpu_list, cpu_bitmap);
+		if (err < 0)
+			goto out;
+	}
+
 	evlist = session->evlist;
 
 	symbol__init(&session->header.env);
@@ -3429,6 +3441,7 @@ int cmd_sched(int argc, const char **argv)
 		   "analyze events only for given process id(s)"),
 	OPT_STRING('t', "tid", &symbol_conf.tid_list_str, "tid[,tid...]",
 		   "analyze events only for given thread id(s)"),
+	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
 	OPT_PARENT(sched_options)
 	};
 
