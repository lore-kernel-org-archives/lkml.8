Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC58C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0855F2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbgEKU7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728046AbgEKU7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:19 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE8AC061A0C;
        Mon, 11 May 2020 13:59:19 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFW9-0005g4-JY; Mon, 11 May 2020 22:59:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3ACB31C001F;
        Mon, 11 May 2020 22:59:17 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:17 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make --kcsan argument also create a summary
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923075718.390.14594827028058025641.tip-bot2@tip-bot2>
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

Commit-ID:     10cec0de11ab585e9a4f08357be4b5bf56bfc3a9
Gitweb:        https://git.kernel.org/tip/10cec0de11ab585e9a4f08357be4b5bf56bfc3a9
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 09 Apr 2020 10:29:32 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 07 May 2020 10:15:29 -07:00

torture: Make --kcsan argument also create a summary

The KCSAN tool emits a great many warnings for current kernels, for
example, a one-hour run of the full set of rcutorture scenarios results
in no fewer than 3252 such warnings, many of which are duplicates
or are otherwise closely related.  This commit therefore introduces
a kcsan-collapse.sh script that maps these warnings down to a set of
function pairs (22 of them given the 3252 individual warnings), placing
the resulting list in decreasing order of frequency of occurrence into
a kcsan.sum file.  If any KCSAN warnings were produced, the pathname of
this file is emitted at the end of the summary of the rcutorture runs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kcsan-collapse.sh | 22 +++++++-
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh    |  9 +++-
 tools/testing/selftests/rcutorture/bin/kvm.sh            |  1 +-
 3 files changed, 32 insertions(+)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kcsan-collapse.sh

diff --git a/tools/testing/selftests/rcutorture/bin/kcsan-collapse.sh b/tools/testing/selftests/rcutorture/bin/kcsan-collapse.sh
new file mode 100755
index 0000000..e5cc6b2
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kcsan-collapse.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# If this was a KCSAN run, collapse the reports in the various console.log
+# files onto pairs of functions.
+#
+# Usage: kcsan-collapse.sh resultsdir
+#
+# Copyright (C) 2020 Facebook, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+if test -z "$TORTURE_KCONFIG_KCSAN_ARG"
+then
+	exit 0
+fi
+cat $1/*/console.log |
+	grep "BUG: KCSAN: " |
+	sed -e 's/^\[[^]]*] //' |
+	sort |
+	uniq -c |
+	sort -k1nr > $1/kcsan.sum
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index 0326f4a..736f047 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -70,6 +70,15 @@ do
 			fi
 		fi
 	done
+	if test -f "$rd/kcsan.sum"
+	then
+		if test -s "$rd/kcsan.sum"
+		then
+			echo KCSAN summary in $rd/kcsan.sum
+		else
+			echo Clean KCSAN run in $rd
+		fi
+	fi
 done
 EDITOR=echo kvm-find-errors.sh "${@: -1}" > $T 2>&1
 ret=$?
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 34b368d..75ae8e3 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -472,6 +472,7 @@ echo
 echo
 echo " --- `date` Test summary:"
 echo Results directory: $resdir/$ds
+kcsan-collapse.sh $resdir/$ds
 kvm-recheck.sh $resdir/$ds
 ___EOF___
 
