Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EF0C35244
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B792467B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbgAYKnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:43:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44310 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbgAYKnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:15 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIuH-0000AW-FR; Sat, 25 Jan 2020 11:43:13 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C38921C1A8B;
        Sat, 25 Jan 2020 11:42:53 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:53 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Handle jitter for CPUs that cannot be offlined
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897358.396.12993561123302180210.tip-bot2@tip-bot2>
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

Commit-ID:     517f17aed0ce678dfa82d7dd4e2593fc1bac799c
Gitweb:        https://git.kernel.org/tip/517f17aed0ce678dfa82d7dd4e2593fc1bac799c
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 14 Oct 2019 07:05:38 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 13:00:26 -08:00

torture: Handle jitter for CPUs that cannot be offlined

Currently, jitter.sh assumes that the underlying hypervisor will be
configured with all CPUs hotpluggable, with the possible exception
of CPU 0.  However, there are installations where the hypervisor
prohibits offlining, which breaks jitter.sh.  This commit therefore
lists the CPUs that cannot be offlined up front, and checks for the
case where no CPU can be offlined in the loop.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/jitter.sh | 26 +++++++++++----
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
index 86a217b..30cb5b2 100755
--- a/tools/testing/selftests/rcutorture/bin/jitter.sh
+++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
@@ -25,6 +25,18 @@ n=1
 
 starttime=`gawk 'BEGIN { print systime(); }' < /dev/null`
 
+nohotplugcpus=
+for i in /sys/devices/system/cpu/cpu[0-9]*
+do
+	if test -f $i/online
+	then
+		:
+	else
+		curcpu=`echo $i | sed -e 's/^[^0-9]*//'`
+		nohotplugcpus="$nohotplugcpus $curcpu"
+	fi
+done
+
 while :
 do
 	# Check for done.
@@ -35,13 +47,15 @@ do
 	fi
 
 	# Set affinity to randomly selected online CPU
-	cpus=`grep 1 /sys/devices/system/cpu/*/online |
-		sed -e 's,/[^/]*$,,' -e 's/^[^0-9]*//'`
-
-	# Do not leave out poor old cpu0 which may not be hot-pluggable
-	if [ ! -f "/sys/devices/system/cpu/cpu0/online" ]; then
-		cpus="0 $cpus"
+	if cpus=`grep 1 /sys/devices/system/cpu/*/online 2>&1 |
+		 sed -e 's,/[^/]*$,,' -e 's/^[^0-9]*//'`
+	then
+		:
+	else
+		cpus=
 	fi
+	# Do not leave out non-hot-pluggable CPUs
+	cpus="$cpus $nohotplugcpus"
 
 	cpumask=`awk -v cpus="$cpus" -v me=$me -v n=$n 'BEGIN {
 		srand(n + me + systime());
