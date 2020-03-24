Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2580C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EC520870
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgCXJQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:16:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43859 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgCXJQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:31 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfff-0007uS-V7; Tue, 24 Mar 2020 10:16:28 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7076F1C0451;
        Tue, 24 Mar 2020 10:16:27 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:27 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] doc: Add rcutorture scripting to torture.txt
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504138713.28353.12849320366120413884.tip-bot2@tip-bot2>
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

Commit-ID:     9671f30ee25151f680d2f4345b4e4c67bed6559c
Gitweb:        https://git.kernel.org/tip/9671f30ee25151f680d2f4345b4e4c67bed6559c
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 21 Jan 2020 11:50:05 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 27 Feb 2020 07:03:14 -08:00

doc: Add rcutorture scripting to torture.txt

For testing mainline, the kvm.sh rcutorture script is the preferred
approach to testing.  This commit therefore adds it to the torture.txt
documentation.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/torture.txt | 147 +++++++++++++++++++++++++++++++--
 1 file changed, 140 insertions(+), 7 deletions(-)

diff --git a/Documentation/RCU/torture.txt b/Documentation/RCU/torture.txt
index a41a038..af712a3 100644
--- a/Documentation/RCU/torture.txt
+++ b/Documentation/RCU/torture.txt
@@ -124,9 +124,14 @@ using a dynamically allocated srcu_struct (hence "srcud-" rather than
 debugging.  The final "T" entry contains the totals of the counters.
 
 
-USAGE
+USAGE ON SPECIFIC KERNEL BUILDS
 
-The following script may be used to torture RCU:
+It is sometimes desirable to torture RCU on a specific kernel build,
+for example, when preparing to put that kernel build into production.
+In that case, the kernel should be built with CONFIG_RCU_TORTURE_TEST=m
+so that the test can be started using modprobe and terminated using rmmod.
+
+For example, the following script may be used to torture RCU:
 
 	#!/bin/sh
 
@@ -142,8 +147,136 @@ checked for such errors.  The "rmmod" command forces a "SUCCESS",
 two are self-explanatory, while the last indicates that while there
 were no RCU failures, CPU-hotplug problems were detected.
 
-However, the tools/testing/selftests/rcutorture/bin/kvm.sh script
-provides better automation, including automatic failure analysis.
-It assumes a qemu/kvm-enabled platform, and runs guest OSes out of initrd.
-See tools/testing/selftests/rcutorture/doc/initrd.txt for instructions
-on setting up such an initrd.
+
+USAGE ON MAINLINE KERNELS
+
+When using rcutorture to test changes to RCU itself, it is often
+necessary to build a number of kernels in order to test that change
+across a broad range of combinations of the relevant Kconfig options
+and of the relevant kernel boot parameters.  In this situation, use
+of modprobe and rmmod can be quite time-consuming and error-prone.
+
+Therefore, the tools/testing/selftests/rcutorture/bin/kvm.sh
+script is available for mainline testing for x86, arm64, and
+powerpc.  By default, it will run the series of tests specified by
+tools/testing/selftests/rcutorture/configs/rcu/CFLIST, with each test
+running for 30 minutes within a guest OS using a minimal userspace
+supplied by an automatically generated initrd.  After the tests are
+complete, the resulting build products and console output are analyzed
+for errors and the results of the runs are summarized.
+
+On larger systems, rcutorture testing can be accelerated by passing the
+--cpus argument to kvm.sh.  For example, on a 64-CPU system, "--cpus 43"
+would use up to 43 CPUs to run tests concurrently, which as of v5.4 would
+complete all the scenarios in two batches, reducing the time to complete
+from about eight hours to about one hour (not counting the time to build
+the sixteen kernels).  The "--dryrun sched" argument will not run tests,
+but rather tell you how the tests would be scheduled into batches.  This
+can be useful when working out how many CPUs to specify in the --cpus
+argument.
+
+Not all changes require that all scenarios be run.  For example, a change
+to Tree SRCU might run only the SRCU-N and SRCU-P scenarios using the
+--configs argument to kvm.sh as follows:  "--configs 'SRCU-N SRCU-P'".
+Large systems can run multiple copies of of the full set of scenarios,
+for example, a system with 448 hardware threads can run five instances
+of the full set concurrently.  To make this happen:
+
+	kvm.sh --cpus 448 --configs '5*CFLIST'
+
+Alternatively, such a system can run 56 concurrent instances of a single
+eight-CPU scenario:
+
+	kvm.sh --cpus 448 --configs '56*TREE04'
+
+Or 28 concurrent instances of each of two eight-CPU scenarios:
+
+	kvm.sh --cpus 448 --configs '28*TREE03 28*TREE04'
+
+Of course, each concurrent instance will use memory, which can be
+limited using the --memory argument, which defaults to 512M.  Small
+values for memory may require disabling the callback-flooding tests
+using the --bootargs parameter discussed below.
+
+Sometimes additional debugging is useful, and in such cases the --kconfig
+parameter to kvm.sh may be used, for example, "--kconfig 'CONFIG_KASAN=y'".
+
+Kernel boot arguments can also be supplied, for example, to control
+rcutorture's module parameters.  For example, to test a change to RCU's
+CPU stall-warning code, use "--bootargs 'rcutorture.stall_cpu=30'".
+This will of course result in the scripting reporting a failure, namely
+the resuling RCU CPU stall warning.  As noted above, reducing memory may
+require disabling rcutorture's callback-flooding tests:
+
+	kvm.sh --cpus 448 --configs '56*TREE04' --memory 128M \
+		--bootargs 'rcutorture.fwd_progress=0'
+
+Sometimes all that is needed is a full set of kernel builds.  This is
+what the --buildonly argument does.
+
+Finally, the --trust-make argument allows each kernel build to reuse what
+it can from the previous kernel build.
+
+There are additional more arcane arguments that are documented in the
+source code of the kvm.sh script.
+
+If a run contains failures, the number of buildtime and runtime failures
+is listed at the end of the kvm.sh output, which you really should redirect
+to a file.  The build products and console output of each run is kept in
+tools/testing/selftests/rcutorture/res in timestamped directories.  A
+given directory can be supplied to kvm-find-errors.sh in order to have
+it cycle you through summaries of errors and full error logs.  For example:
+
+	tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh \
+		tools/testing/selftests/rcutorture/res/2020.01.20-15.54.23
+
+However, it is often more convenient to access the files directly.
+Files pertaining to all scenarios in a run reside in the top-level
+directory (2020.01.20-15.54.23 in the example above), while per-scenario
+files reside in a subdirectory named after the scenario (for example,
+"TREE04").  If a given scenario ran more than once (as in "--configs
+'56*TREE04'" above), the directories corresponding to the second and
+subsequent runs of that scenario include a sequence number, for example,
+"TREE04.2", "TREE04.3", and so on.
+
+The most frequently used file in the top-level directory is testid.txt.
+If the test ran in a git repository, then this file contains the commit
+that was tested and any uncommitted changes in diff format.
+
+The most frequently used files in each per-scenario-run directory are:
+
+.config: This file contains the Kconfig options.
+
+Make.out: This contains build output for a specific scenario.
+
+console.log: This contains the console output for a specific scenario.
+	This file may be examined once the kernel has booted, but
+	it might not exist if the build failed.
+
+vmlinux: This contains the kernel, which can be useful with tools like
+	objdump and gdb.
+
+A number of additional files are available, but are less frequently used.
+Many are intended for debugging of rcutorture itself or of its scripting.
+
+As of v5.4, a successful run with the default set of scenarios produces
+the following summary at the end of the run on a 12-CPU system:
+
+SRCU-N ------- 804233 GPs (148.932/s) [srcu: g10008272 f0x0 ]
+SRCU-P ------- 202320 GPs (37.4667/s) [srcud: g1809476 f0x0 ]
+SRCU-t ------- 1122086 GPs (207.794/s) [srcu: g0 f0x0 ]
+SRCU-u ------- 1111285 GPs (205.794/s) [srcud: g1 f0x0 ]
+TASKS01 ------- 19666 GPs (3.64185/s) [tasks: g0 f0x0 ]
+TASKS02 ------- 20541 GPs (3.80389/s) [tasks: g0 f0x0 ]
+TASKS03 ------- 19416 GPs (3.59556/s) [tasks: g0 f0x0 ]
+TINY01 ------- 836134 GPs (154.84/s) [rcu: g0 f0x0 ] n_max_cbs: 34198
+TINY02 ------- 850371 GPs (157.476/s) [rcu: g0 f0x0 ] n_max_cbs: 2631
+TREE01 ------- 162625 GPs (30.1157/s) [rcu: g1124169 f0x0 ]
+TREE02 ------- 333003 GPs (61.6672/s) [rcu: g2647753 f0x0 ] n_max_cbs: 35844
+TREE03 ------- 306623 GPs (56.782/s) [rcu: g2975325 f0x0 ] n_max_cbs: 1496497
+CPU count limited from 16 to 12
+TREE04 ------- 246149 GPs (45.5831/s) [rcu: g1695737 f0x0 ] n_max_cbs: 434961
+TREE05 ------- 314603 GPs (58.2598/s) [rcu: g2257741 f0x2 ] n_max_cbs: 193997
+TREE07 ------- 167347 GPs (30.9902/s) [rcu: g1079021 f0x0 ] n_max_cbs: 478732
+CPU count limited from 16 to 12
+TREE09 ------- 752238 GPs (139.303/s) [rcu: g13075057 f0x0 ] n_max_cbs: 99011
