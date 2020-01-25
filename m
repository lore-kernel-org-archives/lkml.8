Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1ECC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6884E24125
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbgAYKpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:45:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44273 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbgAYKnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:10 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIuA-000070-LZ; Sat, 25 Jan 2020 11:43:06 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 580841C1A87;
        Sat, 25 Jan 2020 11:42:51 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:51 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Allow "CFLIST" to specify default list of scenarios
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897114.396.4771544853246554716.tip-bot2@tip-bot2>
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

Commit-ID:     25b4da74a955bf956428ab29e54aadf4fffab0a3
Gitweb:        https://git.kernel.org/tip/25b4da74a955bf956428ab29e54aadf4fffab0a3
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 22 Nov 2019 06:14:21 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 13:00:29 -08:00

torture: Allow "CFLIST" to specify default list of scenarios

On a large system, it can be convenient to tell rcutorture to run
several instances of the default scenarios.  Currently, this requires
explicitly listing them, for example, "--configs '2*SRCU-N 2*SRCU-P...'".
Although this works, it is rather inconvenient.

This commit therefore allows "CFLIST" to be specified to indicate the
default list of scenarios called out in the relevant CFLIST file, for
example, for RCU, tools/testing/selftests/rcutorture/configs/rcu/CFLIST.
In addition, multipliers may be used to run multiple instances of all
the scenarios.  For example, on a 256-CPU system, "--configs '3*CFLIST'"
would run three instances of each scenario concurrently with one CPU
left over.  Thus "--configs '3*CFLIST TINY01'" would exactly consume all
256 CPUs, which makes rcutorture's jitter feature more effective.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 19 ++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 7251858..e19151c 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -198,9 +198,10 @@ fi
 
 CONFIGFRAG=${KVM}/configs/${TORTURE_SUITE}; export CONFIGFRAG
 
+defaultconfigs="`tr '\012' ' ' < $CONFIGFRAG/CFLIST`"
 if test -z "$configs"
 then
-	configs="`cat $CONFIGFRAG/CFLIST`"
+	configs=$defaultconfigs
 fi
 
 if test -z "$resdir"
@@ -209,7 +210,7 @@ then
 fi
 
 # Create a file of test-name/#cpus pairs, sorted by decreasing #cpus.
-touch $T/cfgcpu
+configs_derep=
 for CF in $configs
 do
 	case $CF in
@@ -222,15 +223,21 @@ do
 		CF1=$CF
 		;;
 	esac
+	for ((cur_rep=0;cur_rep<$config_reps;cur_rep++))
+	do
+		configs_derep="$configs_derep $CF1"
+	done
+done
+touch $T/cfgcpu
+configs_derep="`echo $configs_derep | sed -e "s/\<CFLIST\>/$defaultconfigs/g"`"
+for CF1 in $configs_derep
+do
 	if test -f "$CONFIGFRAG/$CF1"
 	then
 		cpu_count=`configNR_CPUS.sh $CONFIGFRAG/$CF1`
 		cpu_count=`configfrag_boot_cpus "$TORTURE_BOOTARGS" "$CONFIGFRAG/$CF1" "$cpu_count"`
 		cpu_count=`configfrag_boot_maxcpus "$TORTURE_BOOTARGS" "$CONFIGFRAG/$CF1" "$cpu_count"`
-		for ((cur_rep=0;cur_rep<$config_reps;cur_rep++))
-		do
-			echo $CF1 $cpu_count >> $T/cfgcpu
-		done
+		echo $CF1 $cpu_count >> $T/cfgcpu
 	else
 		echo "The --configs file $CF1 does not exist, terminating."
 		exit 1
