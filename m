Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11BAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714D124125
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbgAYKpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:45:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44307 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbgAYKnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:15 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIuH-0000AK-BW; Sat, 25 Jan 2020 11:43:13 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7D1FB1C1A7E;
        Sat, 25 Jan 2020 11:42:53 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:53 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Handle systems lacking the mpstat command
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897328.396.5916411351748564697.tip-bot2@tip-bot2>
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

Commit-ID:     b8dfff975c370912c7ac633ca3e4a812dcd38f96
Gitweb:        https://git.kernel.org/tip/b8dfff975c370912c7ac633ca3e4a812dcd38f96
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 21 Oct 2019 08:38:00 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 13:00:27 -08:00

torture: Handle systems lacking the mpstat command

The rcutorture scripting uses the mpstat command to determine how much
the system is being used, and adjusts make's -j argument accordingly.
However, mpstat isn't installed by default, so it would be good if the
scripting does something useful when mpstat isn't present.

This commit therefore makes the scripts assumes that if mpstat is not
present, they are free to use all the CPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/cpus2use.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/cpus2use.sh b/tools/testing/selftests/rcutorture/bin/cpus2use.sh
index 4e94855..1dbfb62 100755
--- a/tools/testing/selftests/rcutorture/bin/cpus2use.sh
+++ b/tools/testing/selftests/rcutorture/bin/cpus2use.sh
@@ -15,8 +15,15 @@ then
 	exit 0
 fi
 ncpus=`grep '^processor' /proc/cpuinfo | wc -l`
-idlecpus=`mpstat | tail -1 | \
-	awk -v ncpus=$ncpus '{ print ncpus * ($7 + $NF) / 100 }'`
+if mpstat -V > /dev/null 2>&1
+then
+	idlecpus=`mpstat | tail -1 | \
+		awk -v ncpus=$ncpus '{ print ncpus * ($7 + $NF) / 100 }'`
+else
+	# No mpstat command, so use all available CPUs.
+	echo The mpstat command is not available, so greedily using all CPUs.
+	idlecpus=$ncpus
+fi
 awk -v ncpus=$ncpus -v idlecpus=$idlecpus < /dev/null '
 BEGIN {
 	cpus2use = idlecpus;
