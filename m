Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40789C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E71F214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgCSOKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:10:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60785 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgCSOKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:10:46 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvsg-00020I-BR; Thu, 19 Mar 2020 15:10:42 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D3C6A1C22A4;
        Thu, 19 Mar 2020 15:10:41 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:41 -0000
From:   "tip-bot2 for Michael Petlan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf scripting perl: Add common_callchain to fix
 argument order
Cc:     Michael Petlan <mpetlan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Benjamin Salon <bsalon@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158462704159.28353.11813978020343746932.tip-bot2@tip-bot2>
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

Commit-ID:     67439d555f7d46349deef56886129da96bd15744
Gitweb:        https://git.kernel.org/tip/67439d555f7d46349deef56886129da96bd15744
Author:        Michael Petlan <mpetlan@redhat.com>
AuthorDate:    Wed, 11 Mar 2020 14:28:36 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 11 Mar 2020 11:20:24 -03:00

perf scripting perl: Add common_callchain to fix argument order

Since common_callchain has been added to the argument array, we need to
reflect it in perl-based scripts, because otherwise the following args
would be shifted and thus incorrect. E.g. rw-by-pid and calculation of
read and written bytes:

Before:

  read counts by pid:
     pid                  comm     # reads  bytes_requested  bytes_read
  ------  --------------------  -----------  ----------  ----------
   19301  dd                             4  424510450039736           0

After:

  read counts by pid:
     pid                  comm     # reads  bytes_requested  bytes_read
  ------  --------------------  -----------  ----------  ----------
   19301  dd                             4        9536             4341

Committer testing:

To see before after first do:

  # perf script record rw-by-pid
  ^C

Now you'll have a perf.data file to report on, then do before and after
using:

  # perf script report rw-by-pid

Anbd notice the bytes_request/bytes_read, as above.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Benjamin Salon <bsalon@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
LPU-Reference: 20200311132836.12693-1-mpetlan@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/perl/check-perf-trace.pl |  6 +++---
 tools/perf/scripts/perl/failed-syscalls.pl  |  2 +-
 tools/perf/scripts/perl/rw-by-file.pl       |  6 +++---
 tools/perf/scripts/perl/rw-by-pid.pl        | 10 +++++-----
 tools/perf/scripts/perl/rwtop.pl            | 10 +++++-----
 tools/perf/scripts/perl/wakeup-latency.pl   |  6 +++---
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/perf/scripts/perl/check-perf-trace.pl b/tools/perf/scripts/perl/check-perf-trace.pl
index 4e7076c..d307ce8 100644
--- a/tools/perf/scripts/perl/check-perf-trace.pl
+++ b/tools/perf/scripts/perl/check-perf-trace.pl
@@ -28,7 +28,7 @@ sub trace_end
 sub irq::softirq_entry
 {
 	my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	    $common_pid, $common_comm,
+	    $common_pid, $common_comm, $common_callchain,
 	    $vec) = @_;
 
 	print_header($event_name, $common_cpu, $common_secs, $common_nsecs,
@@ -43,7 +43,7 @@ sub irq::softirq_entry
 sub kmem::kmalloc
 {
 	my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	    $common_pid, $common_comm,
+	    $common_pid, $common_comm, $common_callchain,
 	    $call_site, $ptr, $bytes_req, $bytes_alloc,
 	    $gfp_flags) = @_;
 
@@ -92,7 +92,7 @@ sub print_unhandled
 sub trace_unhandled
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm) = @_;
+	$common_pid, $common_comm, $common_callchain) = @_;
 
     $unhandled{$event_name}++;
 }
diff --git a/tools/perf/scripts/perl/failed-syscalls.pl b/tools/perf/scripts/perl/failed-syscalls.pl
index 55e7ae4..05954a8 100644
--- a/tools/perf/scripts/perl/failed-syscalls.pl
+++ b/tools/perf/scripts/perl/failed-syscalls.pl
@@ -18,7 +18,7 @@ my %failed_syscalls;
 sub raw_syscalls::sys_exit
 {
 	my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	    $common_pid, $common_comm,
+	    $common_pid, $common_comm, $common_callchain,
 	    $id, $ret) = @_;
 
 	if ($ret < 0) {
diff --git a/tools/perf/scripts/perl/rw-by-file.pl b/tools/perf/scripts/perl/rw-by-file.pl
index 168fa5e..92a750b 100644
--- a/tools/perf/scripts/perl/rw-by-file.pl
+++ b/tools/perf/scripts/perl/rw-by-file.pl
@@ -28,7 +28,7 @@ my %writes;
 sub syscalls::sys_enter_read
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm, $nr, $fd, $buf, $count) = @_;
+	$common_pid, $common_comm, $common_callchain, $nr, $fd, $buf, $count) = @_;
 
     if ($common_comm eq $for_comm) {
 	$reads{$fd}{bytes_requested} += $count;
@@ -39,7 +39,7 @@ sub syscalls::sys_enter_read
 sub syscalls::sys_enter_write
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm, $nr, $fd, $buf, $count) = @_;
+	$common_pid, $common_comm, $common_callchain, $nr, $fd, $buf, $count) = @_;
 
     if ($common_comm eq $for_comm) {
 	$writes{$fd}{bytes_written} += $count;
@@ -98,7 +98,7 @@ sub print_unhandled
 sub trace_unhandled
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm) = @_;
+	$common_pid, $common_comm, $common_callchain) = @_;
 
     $unhandled{$event_name}++;
 }
diff --git a/tools/perf/scripts/perl/rw-by-pid.pl b/tools/perf/scripts/perl/rw-by-pid.pl
index 4956982..d789fe3 100644
--- a/tools/perf/scripts/perl/rw-by-pid.pl
+++ b/tools/perf/scripts/perl/rw-by-pid.pl
@@ -24,7 +24,7 @@ my %writes;
 sub syscalls::sys_exit_read
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm,
+	$common_pid, $common_comm, $common_callchain,
 	$nr, $ret) = @_;
 
     if ($ret > 0) {
@@ -40,7 +40,7 @@ sub syscalls::sys_exit_read
 sub syscalls::sys_enter_read
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm,
+	$common_pid, $common_comm, $common_callchain,
 	$nr, $fd, $buf, $count) = @_;
 
     $reads{$common_pid}{bytes_requested} += $count;
@@ -51,7 +51,7 @@ sub syscalls::sys_enter_read
 sub syscalls::sys_exit_write
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm,
+	$common_pid, $common_comm, $common_callchain,
 	$nr, $ret) = @_;
 
     if ($ret <= 0) {
@@ -62,7 +62,7 @@ sub syscalls::sys_exit_write
 sub syscalls::sys_enter_write
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm,
+	$common_pid, $common_comm, $common_callchain,
 	$nr, $fd, $buf, $count) = @_;
 
     $writes{$common_pid}{bytes_written} += $count;
@@ -178,7 +178,7 @@ sub print_unhandled
 sub trace_unhandled
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm) = @_;
+	$common_pid, $common_comm, $common_callchain) = @_;
 
     $unhandled{$event_name}++;
 }
diff --git a/tools/perf/scripts/perl/rwtop.pl b/tools/perf/scripts/perl/rwtop.pl
index 6473442..eba4df6 100644
--- a/tools/perf/scripts/perl/rwtop.pl
+++ b/tools/perf/scripts/perl/rwtop.pl
@@ -35,7 +35,7 @@ if (!$interval) {
 sub syscalls::sys_exit_read
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm,
+	$common_pid, $common_comm, $common_callchain,
 	$nr, $ret) = @_;
 
     print_check();
@@ -53,7 +53,7 @@ sub syscalls::sys_exit_read
 sub syscalls::sys_enter_read
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm,
+	$common_pid, $common_comm, $common_callchain,
 	$nr, $fd, $buf, $count) = @_;
 
     print_check();
@@ -66,7 +66,7 @@ sub syscalls::sys_enter_read
 sub syscalls::sys_exit_write
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm,
+	$common_pid, $common_comm, $common_callchain,
 	$nr, $ret) = @_;
 
     print_check();
@@ -79,7 +79,7 @@ sub syscalls::sys_exit_write
 sub syscalls::sys_enter_write
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm,
+	$common_pid, $common_comm, $common_callchain,
 	$nr, $fd, $buf, $count) = @_;
 
     print_check();
@@ -197,7 +197,7 @@ sub print_unhandled
 sub trace_unhandled
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm) = @_;
+	$common_pid, $common_comm, $common_callchain) = @_;
 
     $unhandled{$event_name}++;
 }
diff --git a/tools/perf/scripts/perl/wakeup-latency.pl b/tools/perf/scripts/perl/wakeup-latency.pl
index efcfec5..53444ff 100644
--- a/tools/perf/scripts/perl/wakeup-latency.pl
+++ b/tools/perf/scripts/perl/wakeup-latency.pl
@@ -28,7 +28,7 @@ my $total_wakeups = 0;
 sub sched::sched_switch
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm,
+	$common_pid, $common_comm, $common_callchain,
 	$prev_comm, $prev_pid, $prev_prio, $prev_state, $next_comm, $next_pid,
 	$next_prio) = @_;
 
@@ -51,7 +51,7 @@ sub sched::sched_switch
 sub sched::sched_wakeup
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm,
+	$common_pid, $common_comm, $common_callchain,
 	$comm, $pid, $prio, $success, $target_cpu) = @_;
 
     $last_wakeup{$target_cpu}{ts} = nsecs($common_secs, $common_nsecs);
@@ -101,7 +101,7 @@ sub print_unhandled
 sub trace_unhandled
 {
     my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm) = @_;
+	$common_pid, $common_comm, $common_callchain) = @_;
 
     $unhandled{$event_name}++;
 }
