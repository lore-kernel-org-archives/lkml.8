Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BB0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63C922522
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbgAYKpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:45:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44275 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729543AbgAYKnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:09 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIuB-00006j-H8; Sat, 25 Jan 2020 11:43:07 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 155BA1C1A86;
        Sat, 25 Jan 2020 11:42:51 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:50 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Hoist calls to lscpu to higher-level kvm.sh script
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897084.396.6588052021936782800.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b22eb7cefb9d31cf862542f9cef90f97c0294842
Gitweb:        https://git.kernel.org/tip/b22eb7cefb9d31cf862542f9cef90f97c0294842
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 25 Nov 2019 14:33:28 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 13:00:30 -08:00

torture: Hoist calls to lscpu to higher-level kvm.sh script

On some kernels, concurrent calls to the lscpu command result in severe
slowdowns.  For example, on v4.16, a single lscpu invocation takes about
two milliseconds, four concurrent invocations more than two seconds,
and 16 concurrent invocations more than 20 seconds.  Given that the only
goal is to learn the number of CPUs, invoking lscpu but once suffices.
This commit therefore invokes lscpu early in kvm.sh execution, setting
the initial value of the TORTURE_ALLOTED_CPUS environment variable.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh |  7 +---
 tools/testing/selftests/rcutorture/bin/kvm.sh            | 11 +++++--
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 1d98992..e035230 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -133,11 +133,10 @@ fi
 qemu_args="-enable-kvm -nographic $qemu_args"
 cpu_count=`configNR_CPUS.sh $resdir/ConfigFragment`
 cpu_count=`configfrag_boot_cpus "$boot_args" "$config_template" "$cpu_count"`
-vcpus=`identify_qemu_vcpus`
-if test $cpu_count -gt $vcpus
+if test "$cpu_count" -gt "$TORTURE_ALLOTED_CPUS"
 then
-	echo CPU count limited from $cpu_count to $vcpus | tee -a $resdir/Warnings
-	cpu_count=$vcpus
+	echo CPU count limited from $cpu_count to $TORTURE_ALLOTED_CPUS | tee -a $resdir/Warnings
+	cpu_count=$TORTURE_ALLOTED_CPUS
 fi
 qemu_args="`specify_qemu_cpus "$QEMU" "$qemu_args" "$cpu_count"`"
 
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index e19151c..78d18ab 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -24,7 +24,9 @@ dur=$((30*60))
 dryrun=""
 KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
 PATH=${KVM}/bin:$PATH; export PATH
-TORTURE_ALLOTED_CPUS=""
+. functions.sh
+
+TORTURE_ALLOTED_CPUS="`identify_qemu_vcpus`"
 TORTURE_DEFCONFIG=defconfig
 TORTURE_BOOT_IMAGE=""
 TORTURE_INITRD="$KVM/initrd"; export TORTURE_INITRD
@@ -40,8 +42,6 @@ cpus=0
 ds=`date +%Y.%m.%d-%H:%M:%S`
 jitter="-1"
 
-. functions.sh
-
 usage () {
 	echo "Usage: $scriptname optional arguments:"
 	echo "       --bootargs kernel-boot-arguments"
@@ -93,6 +93,11 @@ do
 		checkarg --cpus "(number)" "$#" "$2" '^[0-9]*$' '^--'
 		cpus=$2
 		TORTURE_ALLOTED_CPUS="$2"
+		max_cpus="`identify_qemu_vcpus`"
+		if test "$TORTURE_ALLOTED_CPUS" -gt "$max_cpus"
+		then
+			TORTURE_ALLOTED_CPUS=$max_cpus
+		fi
 		shift
 		;;
 	--datestamp)
