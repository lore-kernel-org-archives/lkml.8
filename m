Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B0AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C590E22B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fq97IBlp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j+R29vx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732714AbgGaJ2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:28:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56410 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732262AbgGaJWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:55 -0400
Date:   Fri, 31 Jul 2020 09:22:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=v7t0fZT0iuN0CFdTQZpNQBEVtCRjoZ6zAarLM+r58I0=;
        b=Fq97IBlpuAZDufvc+9oqhHVuRr/mCIPWF4nnnljDPJ5AH895ecQDHfffPG8P9x6W3vrydK
        fcEk+/zwk+qFTi3d65UMh0VldqLbzyKhumnriFpcL4C0GZFCgS/2I0n8EGRPlMJ5uBUehB
        Ze4SGXvtyWqIBjymu0S0ZnG72Ke8VT/3B0I4IEJ51D/zQxJPR2FTVFm1RSoGmWAjgrkSqo
        ynckEaYlrw5ZdFGvax+ZKlCzlsONKV7CDcM438xbE2Vc125DzrkvocLuaOmsiV5Qf8odau
        YtEKPXQu7Wr+Z+txDaMaVOjUAjrZoxo6yDsBFNnNXtPH3HuKLOnhsGhYPIvIrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187371;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=v7t0fZT0iuN0CFdTQZpNQBEVtCRjoZ6zAarLM+r58I0=;
        b=j+R29vx98InaI4by+TPJGw8fppJYno+xqHZw08OUQbo2jvV/MoVklDUFegrDJLHspQjHSB
        SwhaBIU6RjOWd/Cw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refscale: Change --torture type from refperf to refscale
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618737129.4006.16497864188667916235.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     f71d8311ec278525508dac211de700b2b682a15f
Gitweb:        https://git.kernel.org/tip/f71d8311ec278525508dac211de700b2b682a15f
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 17 Jun 2020 12:06:47 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:46 -07:00

refscale: Change --torture type from refperf to refscale

This commit renames the rcutorture config/refperf to config/refscale to
further avoid conflation with the Linux kernel's perf feature.

Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh        | 71 +----------------------------------------------------------------------
 tools/testing/selftests/rcutorture/bin/kvm-recheck-refscale.sh       | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 tools/testing/selftests/rcutorture/bin/kvm.sh                        |  8 ++++----
 tools/testing/selftests/rcutorture/bin/parse-console.sh              |  4 ++--
 tools/testing/selftests/rcutorture/configs/refperf/CFLIST            |  2 +--
 tools/testing/selftests/rcutorture/configs/refperf/CFcommon          |  2 +--
 tools/testing/selftests/rcutorture/configs/refperf/NOPREEMPT         | 18 +------------------
 tools/testing/selftests/rcutorture/configs/refperf/PREEMPT           | 18 +------------------
 tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh  | 16 +----------------
 tools/testing/selftests/rcutorture/configs/refscale/CFLIST           |  2 ++-
 tools/testing/selftests/rcutorture/configs/refscale/CFcommon         |  2 ++-
 tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT        | 18 ++++++++++++++++++-
 tools/testing/selftests/rcutorture/configs/refscale/PREEMPT          | 18 ++++++++++++++++++-
 tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh | 16 ++++++++++++++++-
 14 files changed, 133 insertions(+), 133 deletions(-)
 delete mode 100755 tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-recheck-refscale.sh
 delete mode 100644 tools/testing/selftests/rcutorture/configs/refperf/CFLIST
 delete mode 100644 tools/testing/selftests/rcutorture/configs/refperf/CFcommon
 delete mode 100644 tools/testing/selftests/rcutorture/configs/refperf/NOPREEMPT
 delete mode 100644 tools/testing/selftests/rcutorture/configs/refperf/PREEMPT
 delete mode 100644 tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh
 create mode 100644 tools/testing/selftests/rcutorture/configs/refscale/CFLIST
 create mode 100644 tools/testing/selftests/rcutorture/configs/refscale/CFcommon
 create mode 100644 tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
 create mode 100644 tools/testing/selftests/rcutorture/configs/refscale/PREEMPT
 create mode 100644 tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
deleted file mode 100755
index 0e29cfd..0000000
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
+++ /dev/null
@@ -1,71 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Analyze a given results directory for refperf performance measurements.
-#
-# Usage: kvm-recheck-refperf.sh resdir
-#
-# Copyright (C) IBM Corporation, 2016
-#
-# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
-
-i="$1"
-if test -d "$i" -a -r "$i"
-then
-	:
-else
-	echo Unreadable results directory: $i
-	exit 1
-fi
-PATH=`pwd`/tools/testing/selftests/rcutorture/bin:$PATH; export PATH
-. functions.sh
-
-configfile=`echo $i | sed -e 's/^.*\///'`
-
-sed -e 's/^\[[^]]*]//' < $i/console.log | tr -d '\015' |
-awk -v configfile="$configfile" '
-/^[ 	]*Runs	Time\(ns\) *$/ {
-	if (dataphase + 0 == 0) {
-		dataphase = 1;
-		# print configfile, $0;
-	}
-	next;
-}
-
-/[^ 	]*[0-9][0-9]*	[0-9][0-9]*\.[0-9][0-9]*$/ {
-	if (dataphase == 1) {
-		# print $0;
-		readertimes[++n] = $2;
-		sum += $2;
-	}
-	next;
-}
-
-{
-	if (dataphase == 1)
-		dataphase == 2;
-	next;
-}
-
-END {
-	print configfile " results:";
-	newNR = asort(readertimes);
-	if (newNR <= 0) {
-		print "No refperf records found???"
-		exit;
-	}
-	medianidx = int(newNR / 2);
-	if (newNR == medianidx * 2)
-		medianvalue = (readertimes[medianidx - 1] + readertimes[medianidx]) / 2;
-	else
-		medianvalue = readertimes[medianidx];
-	points = "Points:";
-	for (i = 1; i <= newNR; i++)
-		points = points " " readertimes[i];
-	print points;
-	print "Average reader duration: " sum / newNR " nanoseconds";
-	print "Minimum reader duration: " readertimes[1];
-	print "Median reader duration: " medianvalue;
-	print "Maximum reader duration: " readertimes[newNR];
-	print "Computed from refperf printk output.";
-}'
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-refscale.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-refscale.sh
new file mode 100755
index 0000000..35a463d
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-refscale.sh
@@ -0,0 +1,71 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Analyze a given results directory for refscale performance measurements.
+#
+# Usage: kvm-recheck-refscale.sh resdir
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
+/^[ 	]*Runs	Time\(ns\) *$/ {
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
+		print "No refscale records found???"
+		exit;
+	}
+	medianidx = int(newNR / 2);
+	if (newNR == medianidx * 2)
+		medianvalue = (readertimes[medianidx - 1] + readertimes[medianidx]) / 2;
+	else
+		medianvalue = readertimes[medianidx];
+	points = "Points:";
+	for (i = 1; i <= newNR; i++)
+		points = points " " readertimes[i];
+	print points;
+	print "Average reader duration: " sum / newNR " nanoseconds";
+	print "Minimum reader duration: " readertimes[1];
+	print "Median reader duration: " medianvalue;
+	print "Maximum reader duration: " readertimes[newNR];
+	print "Computed from refscale printk output.";
+}'
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 48b6a72..ce05db3 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -180,14 +180,14 @@ do
 		shift
 		;;
 	--torture)
-		checkarg --torture "(suite name)" "$#" "$2" '^\(lock\|rcu\|rcuperf\|refperf\)$' '^--'
+		checkarg --torture "(suite name)" "$#" "$2" '^\(lock\|rcu\|rcuperf\|refscale\)$' '^--'
 		TORTURE_SUITE=$2
 		shift
-		if test "$TORTURE_SUITE" = rcuperf || test "$TORTURE_SUITE" = refperf
+		if test "$TORTURE_SUITE" = rcuperf || test "$TORTURE_SUITE" = refscale
 		then
-			# If you really want jitter for refperf or
+			# If you really want jitter for refscale or
 			# rcuperf, specify it after specifying the rcuperf
-			# or the refperf.  (But why jitter in these cases?)
+			# or the refscale.  (But why jitter in these cases?)
 			jitter=0
 		fi
 		;;
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 85af11d..8cb908f 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -33,8 +33,8 @@ then
 fi
 cat /dev/null > $file.diags
 
-# Check for proper termination, except for rcuperf and refperf.
-if test "$TORTURE_SUITE" != rcuperf && test "$TORTURE_SUITE" != refperf
+# Check for proper termination, except for rcuperf and refscale.
+if test "$TORTURE_SUITE" != rcuperf && test "$TORTURE_SUITE" != refscale
 then
 	# check for abject failure
 
diff --git a/tools/testing/selftests/rcutorture/configs/refperf/CFLIST b/tools/testing/selftests/rcutorture/configs/refperf/CFLIST
deleted file mode 100644
index 4d62eb4..0000000
--- a/tools/testing/selftests/rcutorture/configs/refperf/CFLIST
+++ /dev/null
@@ -1,2 +0,0 @@
-NOPREEMPT
-PREEMPT
diff --git a/tools/testing/selftests/rcutorture/configs/refperf/CFcommon b/tools/testing/selftests/rcutorture/configs/refperf/CFcommon
deleted file mode 100644
index a98b58b..0000000
--- a/tools/testing/selftests/rcutorture/configs/refperf/CFcommon
+++ /dev/null
@@ -1,2 +0,0 @@
-CONFIG_RCU_REF_SCALE_TEST=y
-CONFIG_PRINTK_TIME=y
diff --git a/tools/testing/selftests/rcutorture/configs/refperf/NOPREEMPT b/tools/testing/selftests/rcutorture/configs/refperf/NOPREEMPT
deleted file mode 100644
index 1cd25b7..0000000
--- a/tools/testing/selftests/rcutorture/configs/refperf/NOPREEMPT
+++ /dev/null
@@ -1,18 +0,0 @@
-CONFIG_SMP=y
-CONFIG_PREEMPT_NONE=y
-CONFIG_PREEMPT_VOLUNTARY=n
-CONFIG_PREEMPT=n
-#CHECK#CONFIG_PREEMPT_RCU=n
-CONFIG_HZ_PERIODIC=n
-CONFIG_NO_HZ_IDLE=y
-CONFIG_NO_HZ_FULL=n
-CONFIG_RCU_FAST_NO_HZ=n
-CONFIG_HOTPLUG_CPU=n
-CONFIG_SUSPEND=n
-CONFIG_HIBERNATION=n
-CONFIG_RCU_NOCB_CPU=n
-CONFIG_DEBUG_LOCK_ALLOC=n
-CONFIG_PROVE_LOCKING=n
-CONFIG_RCU_BOOST=n
-CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
-CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/refperf/PREEMPT b/tools/testing/selftests/rcutorture/configs/refperf/PREEMPT
deleted file mode 100644
index d10bc69..0000000
--- a/tools/testing/selftests/rcutorture/configs/refperf/PREEMPT
+++ /dev/null
@@ -1,18 +0,0 @@
-CONFIG_SMP=y
-CONFIG_PREEMPT_NONE=n
-CONFIG_PREEMPT_VOLUNTARY=n
-CONFIG_PREEMPT=y
-#CHECK#CONFIG_PREEMPT_RCU=y
-CONFIG_HZ_PERIODIC=n
-CONFIG_NO_HZ_IDLE=y
-CONFIG_NO_HZ_FULL=n
-CONFIG_RCU_FAST_NO_HZ=n
-CONFIG_HOTPLUG_CPU=n
-CONFIG_SUSPEND=n
-CONFIG_HIBERNATION=n
-CONFIG_RCU_NOCB_CPU=n
-CONFIG_DEBUG_LOCK_ALLOC=n
-CONFIG_PROVE_LOCKING=n
-CONFIG_RCU_BOOST=n
-CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
-CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh
deleted file mode 100644
index 321e826..0000000
--- a/tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh
+++ /dev/null
@@ -1,16 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Torture-suite-dependent shell functions for the rest of the scripts.
-#
-# Copyright (C) IBM Corporation, 2015
-#
-# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
-
-# per_version_boot_params bootparam-string config-file seconds
-#
-# Adds per-version torture-module parameters to kernels supporting them.
-per_version_boot_params () {
-	echo $1 refscale.shutdown=1 \
-		refscale.verbose=1
-}
diff --git a/tools/testing/selftests/rcutorture/configs/refscale/CFLIST b/tools/testing/selftests/rcutorture/configs/refscale/CFLIST
new file mode 100644
index 0000000..4d62eb4
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/refscale/CFLIST
@@ -0,0 +1,2 @@
+NOPREEMPT
+PREEMPT
diff --git a/tools/testing/selftests/rcutorture/configs/refscale/CFcommon b/tools/testing/selftests/rcutorture/configs/refscale/CFcommon
new file mode 100644
index 0000000..a98b58b
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/refscale/CFcommon
@@ -0,0 +1,2 @@
+CONFIG_RCU_REF_SCALE_TEST=y
+CONFIG_PRINTK_TIME=y
diff --git a/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
new file mode 100644
index 0000000..1cd25b7
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
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
diff --git a/tools/testing/selftests/rcutorture/configs/refscale/PREEMPT b/tools/testing/selftests/rcutorture/configs/refscale/PREEMPT
new file mode 100644
index 0000000..d10bc69
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/refscale/PREEMPT
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
diff --git a/tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh
new file mode 100644
index 0000000..321e826
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh
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
+	echo $1 refscale.shutdown=1 \
+		refscale.verbose=1
+}
