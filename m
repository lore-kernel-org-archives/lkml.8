Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4584C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A528F20842
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgCXJTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:19:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43949 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbgCXJQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:45 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGffs-0007zG-FG; Tue, 24 Mar 2020 10:16:40 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6208C1C0475;
        Tue, 24 Mar 2020 10:16:34 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:34 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Summarize summary of build and run results
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504139404.28353.3714499963063430190.tip-bot2@tip-bot2>
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

Commit-ID:     c0b94ffb66845d13f9ec537a28bd1466b4de2e14
Gitweb:        https://git.kernel.org/tip/c0b94ffb66845d13f9ec537a28bd1466b4de2e14
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 16 Dec 2019 12:04:33 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 16:03:30 -08:00

rcutorture: Summarize summary of build and run results

When running the default list of tests, the run summary of a successful
(that is, failed to find any errors) run fits easily on a 24-line screen.
But a run with something like "--configs '5*CFLIST'" will be 80 lines long,
and it is all too easy to miss a failure message when scrolling back.
This commit therefore prints out the number of runs with failing builds
or runtime failures, but only if there are any such failures.

For example, a run with a single build error and a single runtime error
would print two lines like this:

1 runs with build errors.
1 runs with runtime errors.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh | 17 +++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index e5edd51..0326f4a 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -13,6 +13,9 @@
 #
 # Authors: Paul E. McKenney <paulmck@linux.ibm.com>
 
+T=/tmp/kvm-recheck.sh.$$
+trap 'rm -f $T' 0 2
+
 PATH=`pwd`/tools/testing/selftests/rcutorture/bin:$PATH; export PATH
 . functions.sh
 for rd in "$@"
@@ -68,4 +71,16 @@ do
 		fi
 	done
 done
-EDITOR=echo kvm-find-errors.sh "${@: -1}" > /dev/null 2>&1
+EDITOR=echo kvm-find-errors.sh "${@: -1}" > $T 2>&1
+ret=$?
+builderrors="`tr ' ' '\012' < $T | grep -c '/Make.out.diags'`"
+if test "$builderrors" -gt 0
+then
+	echo $builderrors runs with build errors.
+fi
+runerrors="`tr ' ' '\012' < $T | grep -c '/console.log.diags'`"
+if test "$runerrors" -gt 0
+then
+	echo $runerrors runs with runtime errors.
+fi
+exit $ret
