Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E11C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDBAA22BF3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iHv/KHXA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7+UsRiq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732555AbgGaJXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:23:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56434 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732370AbgGaJXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:11 -0400
Date:   Fri, 31 Jul 2020 09:23:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187389;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=du+bjahcCVlxmOV/4dtz5CRu2FCjrvNyujjwtvzvglM=;
        b=iHv/KHXAlBVoMG9v7RKl+danDhJhn79vXYLr43rGG1b1t3r0VU4Nf9JkjXB2TMg9081i1y
        YO3z/ECHGT8D01NtN14stRnG3W3wOUJWXItBiZ330M2uuuabB+guzmvOedPG7Vj8Q068T5
        ztD1lFg6Rxvbp7Gfg0B9ugLV/Kf8IEyxOtVoTAtwv424TTFVs4Sw8JASZ7BT6i9+Hdu0P5
        7bXzSlzI3ZiQm85YWg0Dc+cYmRXklbKdkcq+LXK4tgzrfhhhIE2g5XdoUK8Rwpo/s6dwve
        dw+s8jgCuPhiOzY53Dqn/qukeX2TdTVJ5O/Aw9jeLOOFY0uYXWe/JhF5/GTGNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187389;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=du+bjahcCVlxmOV/4dtz5CRu2FCjrvNyujjwtvzvglM=;
        b=7+UsRiq1P0WchGrv8oA5l0XF7qNDqzyhjIpIEGGusjiHDhr0Cxx8Aga9c9xo7RRKwpMa8p
        vSTnQrcnf90/UmBg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Add refperf to the rcutorture scripting
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618738841.4006.10499662185548018800.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     f8b4bb23ec014a5d16663ad70b45d9f46c456ec4
Gitweb:        https://git.kernel.org/tip/f8b4bb23ec014a5d16663ad70b45d9f46c456ec4
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 25 May 2020 14:07:52 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:44 -07:00

torture: Add refperf to the rcutorture scripting

This commit updates the rcutorture scripting to include the new refperf
torture-test module.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh       | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/rcutorture/bin/kvm.sh                       |  9 +++++----
 tools/testing/selftests/rcutorture/bin/parse-console.sh             |  4 ++--
 tools/testing/selftests/rcutorture/configs/refperf/CFLIST           |  2 ++
 tools/testing/selftests/rcutorture/configs/refperf/CFcommon         |  2 ++
 tools/testing/selftests/rcutorture/configs/refperf/NOPREEMPT        | 18 ++++++++++++++++++
 tools/testing/selftests/rcutorture/configs/refperf/PREEMPT          | 18 ++++++++++++++++++
 tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh | 16 ++++++++++++++++
 8 files changed, 130 insertions(+), 6 deletions(-)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
 create mode 100644 tools/testing/selftests/rcutorture/configs/refperf/CFLIST
 create mode 100644 tools/testing/selftests/rcutorture/configs/refperf/CFcommon
 create mode 100644 tools/testing/selftests/rcutorture/configs/refperf/NOPREEMPT
 create mode 100644 tools/testing/selftests/rcutorture/configs/refperf/PREEMPT
 create mode 100644 tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
new file mode 100755
index 0000000..6fc06cd
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
@@ -0,0 +1,67 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Analyze a given results directory for refperf performance measurements.
+#
+# Usage: kvm-recheck-refperf.sh resdir
+#
+# Copyright (C) IBM Corporation, 2016
+#
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
+
+i="$1"
+if test -d "$i" -a -r "$i"
+then
+	:
+else
+	echo Unreadable results directory: $i
+	exit 1
+fi
+PATH=`pwd`/tools/testing/selftests/rcutorture/bin:$PATH; export PATH
+. functions.sh
+
+configfile=`echo $i | sed -e 's/^.*\///'`
+
+sed -e 's/^\[[^]]*]//' < $i/console.log | tr -d '\015' |
+awk -v configfile="$configfile" '
+/^[ 	]*Threads	Time\(ns\) *$/ {
+	if (dataphase + 0 == 0) {
+		dataphase = 1;
+		# print configfile, $0;
+	}
+	next;
+}
+
+/[^ 	]*[0-9][0-9]*	[0-9][0-9]*\.[0-9][0-9]*$/ {
+	if (dataphase == 1) {
+		# print $0;
+		readertimes[++n] = $2;
+		sum += $2;
+	}
+	next;
+}
+
+{
+	if (dataphase == 1)
+		dataphase == 2;
+	next;
+}
+
+END {
+	print configfile " results:";
+	newNR = asort(readertimes);
+	if (newNR <= 0) {
+		print "No refperf records found???"
+		exit;
+	}
+	medianidx = int(newNR / 2);
+	if (newNR == medianidx * 2)
+		medianvalue = (readertimes[medianidx - 1] + readertimes[medianidx]) / 2;
+	else
+		medianvalue = readertimes[medianidx];
+	print "Average reader duration: " sum / newNR " nanoseconds";
+	print "Minimum reader duration: " readertimes[1];
+	print "Median reader duration: " medianvalue;
+	print "Maximum reader duration: " readertimes[newNR];
+	print "Computed from refperf printk output.";
+}'
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index c279cf9..48b6a72 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -180,13 +180,14 @@ do
 		shift
 		;;
 	--torture)
-		checkarg --torture "(suite name)" "$#" "$2" '^\(lock\|rcu\|rcuperf\)$' '^--'
+		checkarg --torture "(suite name)" "$#" "$2" '^\(lock\|rcu\|rcuperf\|refperf\)$' '^--'
 		TORTURE_SUITE=$2
 		shift
-		if test "$TORTURE_SUITE" = rcuperf
+		if test "$TORTURE_SUITE" = rcuperf || test "$TORTURE_SUITE" = refperf
 		then
-			# If you really want jitter for rcuperf, specify
-			# it after specifying rcuperf.  (But why?)
+			# If you really want jitter for refperf or
+			# rcuperf, specify it after specifying the rcuperf
+			# or the refperf.  (But why jitter in these cases?)
 			jitter=0
 		fi
 		;;
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 4bf62d7..85af11d 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -33,8 +33,8 @@ then
 fi
 cat /dev/null > $file.diags
 
-# Check for proper termination, except that rcuperf runs don't indicate this.
-if test "$TORTURE_SUITE" != rcuperf
+# Check for proper termination, except for rcuperf and refperf.
+if test "$TORTURE_SUITE" != rcuperf && test "$TORTURE_SUITE" != refperf
 then
 	# check for abject failure
 
diff --git a/tools/testing/selftests/rcutorture/configs/refperf/CFLIST b/tools/testing/selftests/rcutorture/configs/refperf/CFLIST
new file mode 100644
index 0000000..4d62eb4
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/refperf/CFLIST
@@ -0,0 +1,2 @@
+NOPREEMPT
+PREEMPT
diff --git a/tools/testing/selftests/rcutorture/configs/refperf/CFcommon b/tools/testing/selftests/rcutorture/configs/refperf/CFcommon
new file mode 100644
index 0000000..8ba5ba2
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/refperf/CFcommon
@@ -0,0 +1,2 @@
+CONFIG_RCU_REF_PERF_TEST=y
+CONFIG_PRINTK_TIME=y
diff --git a/tools/testing/selftests/rcutorture/configs/refperf/NOPREEMPT b/tools/testing/selftests/rcutorture/configs/refperf/NOPREEMPT
new file mode 100644
index 0000000..1cd25b7
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/refperf/NOPREEMPT
@@ -0,0 +1,18 @@
+CONFIG_SMP=y
+CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=n
+#CHECK#CONFIG_PREEMPT_RCU=n
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_RCU_FAST_NO_HZ=n
+CONFIG_HOTPLUG_CPU=n
+CONFIG_SUSPEND=n
+CONFIG_HIBERNATION=n
+CONFIG_RCU_NOCB_CPU=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_RCU_BOOST=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/refperf/PREEMPT b/tools/testing/selftests/rcutorture/configs/refperf/PREEMPT
new file mode 100644
index 0000000..d10bc69
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/refperf/PREEMPT
@@ -0,0 +1,18 @@
+CONFIG_SMP=y
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+#CHECK#CONFIG_PREEMPT_RCU=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_RCU_FAST_NO_HZ=n
+CONFIG_HOTPLUG_CPU=n
+CONFIG_SUSPEND=n
+CONFIG_HIBERNATION=n
+CONFIG_RCU_NOCB_CPU=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_RCU_BOOST=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh
new file mode 100644
index 0000000..489f05d
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh
@@ -0,0 +1,16 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Torture-suite-dependent shell functions for the rest of the scripts.
+#
+# Copyright (C) IBM Corporation, 2015
+#
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
+
+# per_version_boot_params bootparam-string config-file seconds
+#
+# Adds per-version torture-module parameters to kernels supporting them.
+per_version_boot_params () {
+	echo $1 refperf.shutdown=1 \
+		refperf.verbose=1
+}
