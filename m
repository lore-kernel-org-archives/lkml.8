Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE21C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68E4E22D72
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZsqKQCwC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8b6NaSTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbgGaJXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:23:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56390 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732248AbgGaJWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:52 -0400
Date:   Fri, 31 Jul 2020 09:22:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6wVn6Fx971em4nYfkz+RfazeJN6npvESKsBOPxOg0GM=;
        b=ZsqKQCwC8Um6+14DP0kdEtcgS+PT/HvOI6djURHqTDnlHv762Yl+47flERnAcla5jWYkPo
        RS7cgd3wj5GsTbT6BDIXyAZmTNd4xeuCZ/wgxBV2RgAIAHhk2FxA+bIW1Ujno8TDjl8eSt
        j3t6Tx0BaCxd7nal7RtXhfaPxX3fWkGmyfJBszpuwINOE4UeE4CGCU6I6LTxWbUl3H/9jk
        Pn58Wns4XahBBwAbt8hjAjJ3X2pRKpTtND/7JSswxEwTxmtVkg7LrlVqqZSCQ7ml+RZZht
        zk/LGP3A4ZSm3+4aooX/3Z+7A1zTcjxTMFg6CyPNSeTW3GJjf+PDMrQuDqyUbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6wVn6Fx971em4nYfkz+RfazeJN6npvESKsBOPxOg0GM=;
        b=8b6NaSTp3V3vLXjY+fsF5vQhcijQdAOIuQU6ZpRKwkAYBIRVeYA9hkCYAyv2AwgnT9BRop
        vPpWuG+DyMQtGkCQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Add script to smoke-test commits in a branch
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618736862.4006.14202618761532645344.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     6582e7f184e49a754ee09c996a886b89113d7354
Gitweb:        https://git.kernel.org/tip/6582e7f184e49a754ee09c996a886b89113d7354
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 04 May 2020 15:55:47 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:43 -07:00

torture: Add script to smoke-test commits in a branch

This commit adds a kvm-check-branches.sh script that takes a list
of commits and commit ranges and runs a short rcutorture test on all
scenarios on each specified commit.  A summary is printed at the end, and
the script returns success if all rcutorture runs completed without error.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh | 108 +++++++-
 1 file changed, 108 insertions(+)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh b/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
new file mode 100755
index 0000000..6e65c13
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
@@ -0,0 +1,108 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Run a group of kvm.sh tests on the specified commits.  This currently
+# unconditionally does three-minute runs on each scenario in CFLIST,
+# taking advantage of all available CPUs and trusting the "make" utility.
+# In the short term, adjustments can be made by editing this script and
+# CFLIST.  If some adjustments appear to have ongoing value, this script
+# might grow some command-line arguments.
+#
+# Usage: kvm-check-branches.sh commit1 commit2..commit3 commit4 ...
+#
+# This script considers its arguments one at a time.  If more elaborate
+# specification of commits is needed, please use "git rev-list" to
+# produce something that this simple script can understand.  The reason
+# for retaining the simplicity is that it allows the user to more easily
+# see which commit came from which branch.
+#
+# This script creates a yyyy.mm.dd-hh.mm.ss-group entry in the "res"
+# directory.  The calls to kvm.sh create the usual entries, but this script
+# moves them under the yyyy.mm.dd-hh.mm.ss-group entry, each in its own
+# directory numbered in run order, that is, "0001", "0002", and so on.
+# For successful runs, the large build artifacts are removed.  Doing this
+# reduces the disk space required by about two orders of magnitude for
+# successful runs.
+#
+# Copyright (C) Facebook, 2020
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+if ! git status > /dev/null 2>&1
+then
+	echo '!!!' This script needs to run in a git archive. 1>&2
+	echo '!!!' Giving up. 1>&2
+	exit 1
+fi
+
+# Remember where we started so that we can get back and the end.
+curcommit="`git status | head -1 | awk '{ print $NF }'`"
+
+nfail=0
+ntry=0
+resdir="tools/testing/selftests/rcutorture/res"
+ds="`date +%Y.%m.%d-%H.%M.%S`-group"
+if ! test -e $resdir
+then
+	mkdir $resdir || :
+fi
+mkdir $resdir/$ds
+echo Results directory: $resdir/$ds
+
+KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
+PATH=${KVM}/bin:$PATH; export PATH
+. functions.sh
+cpus="`identify_qemu_vcpus`"
+echo Using up to $cpus CPUs.
+
+# Each pass through this loop does one command-line argument.
+for gitbr in $@
+do
+	echo ' --- git branch ' $gitbr
+
+	# Each pass through this loop tests one commit.
+	for i in `git rev-list "$gitbr"`
+	do
+		ntry=`expr $ntry + 1`
+		idir=`awk -v ntry="$ntry" 'END { printf "%04d", ntry; }' < /dev/null`
+		echo ' --- commit ' $i from branch $gitbr
+		date
+		mkdir $resdir/$ds/$idir
+		echo $gitbr > $resdir/$ds/$idir/gitbr
+		echo $i >> $resdir/$ds/$idir/gitbr
+
+		# Test the specified commit.
+		git checkout $i > $resdir/$ds/$idir/git-checkout.out 2>&1
+		echo git checkout return code: $? "(Commit $ntry: $i)"
+		kvm.sh --cpus $cpus --duration 3 --trust-make > $resdir/$ds/$idir/kvm.sh.out 2>&1
+		ret=$?
+		echo kvm.sh return code $ret for commit $i from branch $gitbr
+
+		# Move the build products to their resting place.
+		runresdir="`grep -m 1 '^Results directory:' < $resdir/$ds/$idir/kvm.sh.out | sed -e 's/^Results directory://'`"
+		mv $runresdir $resdir/$ds/$idir
+		rrd="`echo $runresdir | sed -e 's,^.*/,,'`"
+		echo Run results: $resdir/$ds/$idir/$rrd
+		if test "$ret" -ne 0
+		then
+			# Failure, so leave all evidence intact.
+			nfail=`expr $nfail + 1`
+		else
+			# Success, so remove large files to save about 1GB.
+			( cd $resdir/$ds/$idir/$rrd; rm -f */vmlinux */bzImage */System.map */Module.symvers )
+		fi
+	done
+done
+date
+
+# Go back to the original commit.
+git checkout "$curcommit"
+
+if test $nfail -ne 0
+then
+	echo '!!! ' $nfail failures in $ntry 'runs!!!'
+	exit 1
+else
+	echo No failures in $ntry runs.
+	exit 0
+fi
