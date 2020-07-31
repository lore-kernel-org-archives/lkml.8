Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E059C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C80022B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S1WwOmV2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AgPVrEo/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732095AbgGaJWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:22:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56350 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732203AbgGaJWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:45 -0400
Date:   Fri, 31 Jul 2020 09:22:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187362;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VeHuDFMynotDWeSNuN4YXwHrCoEpYwVTPw8qWP0mkCs=;
        b=S1WwOmV27+eydDN/IJNJx69oHSBLMZMh0Qj03wsG+Y4NX6MCX++250EJFZ1L9eOES4SZf2
        sxTIVNcVpwDqIi+Jqft1m5BxHps6qD2W2m8kClUHx1oljXu6nCqLLpj6G4Ii8yA0d35gou
        PUE90exyCnLHKIbuemldYFP78MzsQynJTXSeKqx+Vx/ZstlmRaLJQlvcd2T2K1Rt5STZNc
        0vBUtYyhL/U1OSKvOqAvOpgt4RhUxgqgXWyleV5/OBGD5GoWbjLCDVaOJAoPky5gX5zjAz
        47NjC6SjcwJAPa+Q1aBZ+EtqvueOCCxgZ/SAHfn9fkbYoGRfR8PlfXg+BRj/Og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187362;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VeHuDFMynotDWeSNuN4YXwHrCoEpYwVTPw8qWP0mkCs=;
        b=AgPVrEo/ay8xHAi9lAGktnIlyXjP0JbuB2LxIOjCtR7LvhW1gUHlzhH7fn7KOQ+SCRk9oU
        4J26SuKA6y6WzGBQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Add a stop-run capability
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618736213.4006.10051552224753843943.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     6387ecbc94bf5ac07239104b84d2304da6e79b51
Gitweb:        https://git.kernel.org/tip/6387ecbc94bf5ac07239104b84d2304da6e79b51
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 09 Jun 2020 17:58:30 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:44 -07:00

torture: Add a stop-run capability

When bisecting RCU issues, it is often the case that the first error in
an unsuccessful run will happen quickly, but that a successful run must
go on for some time in order to obtain a sufficiently low false-negative
error rate.  In many cases, a bisection requires multiple concurrent
runs, in which case the first failure in any run indicates failure,
pure and simple.  In such cases, it would speed things up greatly if
the first failure terminated all runs.

This commit therefore adds scripting that checks for a file named "STOP"
in the top-level results directory, terminating the run when it appears.
Note that in-progress builds will continue until completion, but future
builds and all runs will be cut short.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/jitter.sh         |  6 +++-
 tools/testing/selftests/rcutorture/bin/kvm-build.sh      |  6 +++-
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 13 +++++--
 tools/testing/selftests/rcutorture/bin/kvm.sh            |  2 +-
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
index 30cb5b2..188b864 100755
--- a/tools/testing/selftests/rcutorture/bin/jitter.sh
+++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
@@ -46,6 +46,12 @@ do
 		exit 0;
 	fi
 
+	# Check for stop request.
+	if test -f "$TORTURE_STOPFILE"
+	then
+		exit 1;
+	fi
+
 	# Set affinity to randomly selected online CPU
 	if cpus=`grep 1 /sys/devices/system/cpu/*/online 2>&1 |
 		 sed -e 's,/[^/]*$,,' -e 's/^[^0-9]*//'`
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-build.sh b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
index 18d6518..115e182 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-build.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
@@ -9,6 +9,12 @@
 #
 # Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
+if test -f "$TORTURE_STOPFILE"
+then
+	echo "kvm-build.sh early exit due to run STOP request"
+	exit 1
+fi
+
 config_template=${1}
 if test -z "$config_template" -o ! -f "$config_template" -o ! -r "$config_template"
 then
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 064dd73..5ec095d 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -182,7 +182,7 @@ do
 	kruntime=`gawk 'BEGIN { print systime() - '"$kstarttime"' }' < /dev/null`
 	if test -z "$qemu_pid" || kill -0 "$qemu_pid" > /dev/null 2>&1
 	then
-		if test $kruntime -ge $seconds
+		if test $kruntime -ge $seconds -o -f "$TORTURE_STOPFILE"
 		then
 			break;
 		fi
@@ -211,10 +211,19 @@ then
 fi
 if test $commandcompleted -eq 0 -a -n "$qemu_pid"
 then
-	echo Grace period for qemu job at pid $qemu_pid
+	if ! test -f "$TORTURE_STOPFILE"
+	then
+		echo Grace period for qemu job at pid $qemu_pid
+	fi
 	oldline="`tail $resdir/console.log`"
 	while :
 	do
+		if test -f "$TORTURE_STOPFILE"
+		then
+			echo "PID $qemu_pid killed due to run STOP request" >> $resdir/Warnings 2>&1
+			kill -KILL $qemu_pid
+			break
+		fi
 		kruntime=`gawk 'BEGIN { print systime() - '"$kstarttime"' }' < /dev/null`
 		if kill -0 $qemu_pid > /dev/null 2>&1
 		then
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 7dbce7a..3578c85 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -337,6 +337,8 @@ then
 	mkdir -p "$resdir" || :
 fi
 mkdir $resdir/$ds
+TORTURE_RESDIR="$resdir/$ds"; export TORTURE_RESDIR
+TORTURE_STOPFILE="$resdir/$ds/STOP"; export TORTURE_STOPFILE
 echo Results directory: $resdir/$ds
 echo $scriptname $args
 touch $resdir/$ds/log
