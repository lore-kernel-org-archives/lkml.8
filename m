Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EF1C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 953FD2076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586972023;
	bh=NBTRHQwpI7VXKcRnKdEPYNRajSRwZhec2cc7h/2DMFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GxhBDVhBGDEhdMkPq32OiEMdGyXA9Xrv9WyCUjVab1ka9TSwsQiKZeA4BWORimjl2
	 b8uA7IkTCcaK705osRT8Rlg9ewQhD4TF1tzhU8KXayx6i6tF8U8rBQ8bVG1B3RsdZs
	 cY/Gtf8W4RvSqsr5UorzBMyZWayT0YDQtrB7XODc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411327AbgDORdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411129AbgDORbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:31:07 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC7022166E;
        Wed, 15 Apr 2020 17:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971865;
        bh=NBTRHQwpI7VXKcRnKdEPYNRajSRwZhec2cc7h/2DMFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BsOLXdPU4wF6JQAVNEfprum5HraFwCgzukUOc5Rz7U4SaJX162GW8NevpyFH7h96Q
         03+jBryn3rttYxGWeoUDudmKKWeaiFSDnKLH5OoRMNy3ABVOSf2m/FbgtvOsCj0YUo
         CUPXEdQ63c6cuLnnpVA4l36/huZNifR4xw8xXmIA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/18] torture: Make --kcsan argument also create a summary
Date:   Wed, 15 Apr 2020 10:30:52 -0700
Message-Id: <20200415173100.9927-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415173037.GA9768@paulmck-ThinkPad-P72>
References: <20200415173037.GA9768@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

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
 .../selftests/rcutorture/bin/kcsan-collapse.sh     | 22 ++++++++++++++++++++++
 .../selftests/rcutorture/bin/kvm-recheck.sh        |  9 +++++++++
 tools/testing/selftests/rcutorture/bin/kvm.sh      |  1 +
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
 
-- 
2.9.5

