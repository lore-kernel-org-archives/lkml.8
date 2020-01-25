Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4065C35244
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D71218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbgAYKnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:43:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44291 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729612AbgAYKnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:13 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIuE-0000Ba-MP; Sat, 25 Jan 2020 11:43:10 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5CA321C1A7F;
        Sat, 25 Jan 2020 11:42:54 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:54 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Use gawk instead of awk for systime() function
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897417.396.8674695189827096548.tip-bot2@tip-bot2>
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

Commit-ID:     c493f1c9c4094afae7f3a0693ae395f3859022b4
Gitweb:        https://git.kernel.org/tip/c493f1c9c4094afae7f3a0693ae395f3859022b4
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 06 Oct 2019 14:33:22 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 13:00:26 -08:00

torture: Use gawk instead of awk for systime() function

In many environments, gawk provides systime(), but awk doesn't.
This commit therefore changes awk scripts using systime() to instead be
gawk scripts.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/jitter.sh         | 4 ++--
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
index dc49a3b..86a217b 100755
--- a/tools/testing/selftests/rcutorture/bin/jitter.sh
+++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
@@ -23,12 +23,12 @@ spinmax=${4-1000}
 
 n=1
 
-starttime=`awk 'BEGIN { print systime(); }' < /dev/null`
+starttime=`gawk 'BEGIN { print systime(); }' < /dev/null`
 
 while :
 do
 	# Check for done.
-	t=`awk -v s=$starttime 'BEGIN { print systime() - s; }' < /dev/null`
+	t=`gawk -v s=$starttime 'BEGIN { print systime() - s; }' < /dev/null`
 	if test "$t" -gt "$duration"
 	then
 		exit 0;
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 33c6696..1d98992 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -123,7 +123,7 @@ qemu_args=$5
 boot_args=$6
 
 cd $KVM
-kstarttime=`awk 'BEGIN { print systime() }' < /dev/null`
+kstarttime=`gawk 'BEGIN { print systime() }' < /dev/null`
 if test -z "$TORTURE_BUILDONLY"
 then
 	echo ' ---' `date`: Starting kernel
@@ -177,7 +177,7 @@ do
 	then
 		qemu_pid=`cat "$resdir/qemu_pid"`
 	fi
-	kruntime=`awk 'BEGIN { print systime() - '"$kstarttime"' }' < /dev/null`
+	kruntime=`gawk 'BEGIN { print systime() - '"$kstarttime"' }' < /dev/null`
 	if test -z "$qemu_pid" || kill -0 "$qemu_pid" > /dev/null 2>&1
 	then
 		if test $kruntime -ge $seconds
@@ -213,7 +213,7 @@ then
 	oldline="`tail $resdir/console.log`"
 	while :
 	do
-		kruntime=`awk 'BEGIN { print systime() - '"$kstarttime"' }' < /dev/null`
+		kruntime=`gawk 'BEGIN { print systime() - '"$kstarttime"' }' < /dev/null`
 		if kill -0 $qemu_pid > /dev/null 2>&1
 		then
 			:
