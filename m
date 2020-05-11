Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA9DC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 788392192A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbgEKU7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731885AbgEKU7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F4DC05BD0A;
        Mon, 11 May 2020 13:59:33 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWO-0005ke-07; Mon, 11 May 2020 22:59:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EFD9F1C07F8;
        Mon, 11 May 2020 22:59:22 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:22 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Add TRACE02 scenario enabling RCU Tasks
 Trace IPIs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923076292.390.13705656012616834525.tip-bot2@tip-bot2>
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

Commit-ID:     039f3cc93aa07a90ad5df95d7820b67b0689126d
Gitweb:        https://git.kernel.org/tip/039f3cc93aa07a90ad5df95d7820b67b0689126d
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 24 Mar 2020 08:00:04 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:53 -07:00

rcutorture: Add TRACE02 scenario enabling RCU Tasks Trace IPIs

This commit adds a TRACE02 scenario which enables preemption and RCU
Tasks Trace IPIs, more specifically, disabling heavyweight readers.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/CFLIST       |  1 +-
 tools/testing/selftests/rcutorture/configs/rcu/TRACE01      |  1 +-
 tools/testing/selftests/rcutorture/configs/rcu/TRACE02      | 11 +++++++-
 tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot |  1 +-
 4 files changed, 14 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRACE02
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
index dfb1817..f2b20db 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
@@ -16,3 +16,4 @@ TASKS02
 TASKS03
 RUDE01
 TRACE01
+TRACE02
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
index 078e2c1..12e7661 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
@@ -7,4 +7,5 @@ CONFIG_PREEMPT=n
 CONFIG_DEBUG_LOCK_ALLOC=y
 CONFIG_PROVE_LOCKING=y
 #CHECK#CONFIG_PROVE_RCU=y
+CONFIG_TASKS_TRACE_RCU_READ_MB=y
 CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE02 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
new file mode 100644
index 0000000..b69ed66
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
@@ -0,0 +1,11 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=4
+CONFIG_HOTPLUG_CPU=y
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+#CHECK#CONFIG_PROVE_RCU=n
+CONFIG_TASKS_TRACE_RCU_READ_MB=n
+CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot
new file mode 100644
index 0000000..9675ad6
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02.boot
@@ -0,0 +1 @@
+rcutorture.torture_type=tasks-tracing
