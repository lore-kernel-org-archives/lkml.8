Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B68C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191B924125
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbgAYKpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:45:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44239 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729463AbgAYKnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:05 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIu5-00006L-TN; Sat, 25 Jan 2020 11:43:02 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6CCF71C1A7A;
        Sat, 25 Jan 2020 11:42:50 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:50 -0000
From:   "tip-bot2 for Madhuparna Bhowmik" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] doc: Converted NMI-RCU.txt to NMI-RCU.rst.
Cc:     Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        Phong Tran <tranmanphong@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897017.396.17671881349411288806.tip-bot2@tip-bot2>
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

Commit-ID:     6705cae433cffc37b183ded6ca9fe5c6d8ae8a9d
Gitweb:        https://git.kernel.org/tip/6705cae433cffc37b183ded6ca9fe5c6d8ae8a9d
Author:        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
AuthorDate:    Tue, 29 Oct 2019 03:12:52 +05:30
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 10 Dec 2019 18:51:52 -08:00

doc: Converted NMI-RCU.txt to NMI-RCU.rst.

This patch converts NMI-RCU from txt to rst format.
Also adds NMI-RCU in the index.rst file.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
[ paulmck: Apply feedback from Phong Tran. ]
Tested-by: Phong Tran <tranmanphong@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/NMI-RCU.rst | 124 +++++++++++++++++++++++++++++++++-
 Documentation/RCU/NMI-RCU.txt | 121 +--------------------------------
 Documentation/RCU/index.rst   |   1 +-
 3 files changed, 125 insertions(+), 121 deletions(-)
 create mode 100644 Documentation/RCU/NMI-RCU.rst
 delete mode 100644 Documentation/RCU/NMI-RCU.txt

diff --git a/Documentation/RCU/NMI-RCU.rst b/Documentation/RCU/NMI-RCU.rst
new file mode 100644
index 0000000..1809583
--- /dev/null
+++ b/Documentation/RCU/NMI-RCU.rst
@@ -0,0 +1,124 @@
+.. _NMI_rcu_doc:
+
+Using RCU to Protect Dynamic NMI Handlers
+=========================================
+
+
+Although RCU is usually used to protect read-mostly data structures,
+it is possible to use RCU to provide dynamic non-maskable interrupt
+handlers, as well as dynamic irq handlers.  This document describes
+how to do this, drawing loosely from Zwane Mwaikambo's NMI-timer
+work in "arch/x86/oprofile/nmi_timer_int.c" and in
+"arch/x86/kernel/traps.c".
+
+The relevant pieces of code are listed below, each followed by a
+brief explanation::
+
+	static int dummy_nmi_callback(struct pt_regs *regs, int cpu)
+	{
+		return 0;
+	}
+
+The dummy_nmi_callback() function is a "dummy" NMI handler that does
+nothing, but returns zero, thus saying that it did nothing, allowing
+the NMI handler to take the default machine-specific action::
+
+	static nmi_callback_t nmi_callback = dummy_nmi_callback;
+
+This nmi_callback variable is a global function pointer to the current
+NMI handler::
+
+	void do_nmi(struct pt_regs * regs, long error_code)
+	{
+		int cpu;
+
+		nmi_enter();
+
+		cpu = smp_processor_id();
+		++nmi_count(cpu);
+
+		if (!rcu_dereference_sched(nmi_callback)(regs, cpu))
+			default_do_nmi(regs);
+
+		nmi_exit();
+	}
+
+The do_nmi() function processes each NMI.  It first disables preemption
+in the same way that a hardware irq would, then increments the per-CPU
+count of NMIs.  It then invokes the NMI handler stored in the nmi_callback
+function pointer.  If this handler returns zero, do_nmi() invokes the
+default_do_nmi() function to handle a machine-specific NMI.  Finally,
+preemption is restored.
+
+In theory, rcu_dereference_sched() is not needed, since this code runs
+only on i386, which in theory does not need rcu_dereference_sched()
+anyway.  However, in practice it is a good documentation aid, particularly
+for anyone attempting to do something similar on Alpha or on systems
+with aggressive optimizing compilers.
+
+Quick Quiz:
+		Why might the rcu_dereference_sched() be necessary on Alpha, given that the code referenced by the pointer is read-only?
+
+:ref:`Answer to Quick Quiz <answer_quick_quiz_NMI>`
+
+Back to the discussion of NMI and RCU::
+
+	void set_nmi_callback(nmi_callback_t callback)
+	{
+		rcu_assign_pointer(nmi_callback, callback);
+	}
+
+The set_nmi_callback() function registers an NMI handler.  Note that any
+data that is to be used by the callback must be initialized up -before-
+the call to set_nmi_callback().  On architectures that do not order
+writes, the rcu_assign_pointer() ensures that the NMI handler sees the
+initialized values::
+
+	void unset_nmi_callback(void)
+	{
+		rcu_assign_pointer(nmi_callback, dummy_nmi_callback);
+	}
+
+This function unregisters an NMI handler, restoring the original
+dummy_nmi_handler().  However, there may well be an NMI handler
+currently executing on some other CPU.  We therefore cannot free
+up any data structures used by the old NMI handler until execution
+of it completes on all other CPUs.
+
+One way to accomplish this is via synchronize_rcu(), perhaps as
+follows::
+
+	unset_nmi_callback();
+	synchronize_rcu();
+	kfree(my_nmi_data);
+
+This works because (as of v4.20) synchronize_rcu() blocks until all
+CPUs complete any preemption-disabled segments of code that they were
+executing.
+Since NMI handlers disable preemption, synchronize_rcu() is guaranteed
+not to return until all ongoing NMI handlers exit.  It is therefore safe
+to free up the handler's data as soon as synchronize_rcu() returns.
+
+Important note: for this to work, the architecture in question must
+invoke nmi_enter() and nmi_exit() on NMI entry and exit, respectively.
+
+.. _answer_quick_quiz_NMI:
+
+Answer to Quick Quiz:
+	Why might the rcu_dereference_sched() be necessary on Alpha, given that the code referenced by the pointer is read-only?
+
+	The caller to set_nmi_callback() might well have
+	initialized some data that is to be used by the new NMI
+	handler.  In this case, the rcu_dereference_sched() would
+	be needed, because otherwise a CPU that received an NMI
+	just after the new handler was set might see the pointer
+	to the new NMI handler, but the old pre-initialized
+	version of the handler's data.
+
+	This same sad story can happen on other CPUs when using
+	a compiler with aggressive pointer-value speculation
+	optimizations.
+
+	More important, the rcu_dereference_sched() makes it
+	clear to someone reading the code that the pointer is
+	being protected by RCU-sched.
diff --git a/Documentation/RCU/NMI-RCU.txt b/Documentation/RCU/NMI-RCU.txt
deleted file mode 100644
index 881353f..0000000
--- a/Documentation/RCU/NMI-RCU.txt
+++ /dev/null
@@ -1,121 +0,0 @@
-Using RCU to Protect Dynamic NMI Handlers
-
-
-Although RCU is usually used to protect read-mostly data structures,
-it is possible to use RCU to provide dynamic non-maskable interrupt
-handlers, as well as dynamic irq handlers.  This document describes
-how to do this, drawing loosely from Zwane Mwaikambo's NMI-timer
-work in "arch/x86/oprofile/nmi_timer_int.c" and in
-"arch/x86/kernel/traps.c".
-
-The relevant pieces of code are listed below, each followed by a
-brief explanation.
-
-	static int dummy_nmi_callback(struct pt_regs *regs, int cpu)
-	{
-		return 0;
-	}
-
-The dummy_nmi_callback() function is a "dummy" NMI handler that does
-nothing, but returns zero, thus saying that it did nothing, allowing
-the NMI handler to take the default machine-specific action.
-
-	static nmi_callback_t nmi_callback = dummy_nmi_callback;
-
-This nmi_callback variable is a global function pointer to the current
-NMI handler.
-
-	void do_nmi(struct pt_regs * regs, long error_code)
-	{
-		int cpu;
-
-		nmi_enter();
-
-		cpu = smp_processor_id();
-		++nmi_count(cpu);
-
-		if (!rcu_dereference_sched(nmi_callback)(regs, cpu))
-			default_do_nmi(regs);
-
-		nmi_exit();
-	}
-
-The do_nmi() function processes each NMI.  It first disables preemption
-in the same way that a hardware irq would, then increments the per-CPU
-count of NMIs.  It then invokes the NMI handler stored in the nmi_callback
-function pointer.  If this handler returns zero, do_nmi() invokes the
-default_do_nmi() function to handle a machine-specific NMI.  Finally,
-preemption is restored.
-
-In theory, rcu_dereference_sched() is not needed, since this code runs
-only on i386, which in theory does not need rcu_dereference_sched()
-anyway.  However, in practice it is a good documentation aid, particularly
-for anyone attempting to do something similar on Alpha or on systems
-with aggressive optimizing compilers.
-
-Quick Quiz:  Why might the rcu_dereference_sched() be necessary on Alpha,
-	     given that the code referenced by the pointer is read-only?
-
-
-Back to the discussion of NMI and RCU...
-
-	void set_nmi_callback(nmi_callback_t callback)
-	{
-		rcu_assign_pointer(nmi_callback, callback);
-	}
-
-The set_nmi_callback() function registers an NMI handler.  Note that any
-data that is to be used by the callback must be initialized up -before-
-the call to set_nmi_callback().  On architectures that do not order
-writes, the rcu_assign_pointer() ensures that the NMI handler sees the
-initialized values.
-
-	void unset_nmi_callback(void)
-	{
-		rcu_assign_pointer(nmi_callback, dummy_nmi_callback);
-	}
-
-This function unregisters an NMI handler, restoring the original
-dummy_nmi_handler().  However, there may well be an NMI handler
-currently executing on some other CPU.  We therefore cannot free
-up any data structures used by the old NMI handler until execution
-of it completes on all other CPUs.
-
-One way to accomplish this is via synchronize_rcu(), perhaps as
-follows:
-
-	unset_nmi_callback();
-	synchronize_rcu();
-	kfree(my_nmi_data);
-
-This works because (as of v4.20) synchronize_rcu() blocks until all
-CPUs complete any preemption-disabled segments of code that they were
-executing.
-Since NMI handlers disable preemption, synchronize_rcu() is guaranteed
-not to return until all ongoing NMI handlers exit.  It is therefore safe
-to free up the handler's data as soon as synchronize_rcu() returns.
-
-Important note: for this to work, the architecture in question must
-invoke nmi_enter() and nmi_exit() on NMI entry and exit, respectively.
-
-
-Answer to Quick Quiz
-
-	Why might the rcu_dereference_sched() be necessary on Alpha, given
-	that the code referenced by the pointer is read-only?
-
-	Answer: The caller to set_nmi_callback() might well have
-		initialized some data that is to be used by the new NMI
-		handler.  In this case, the rcu_dereference_sched() would
-		be needed, because otherwise a CPU that received an NMI
-		just after the new handler was set might see the pointer
-		to the new NMI handler, but the old pre-initialized
-		version of the handler's data.
-
-		This same sad story can happen on other CPUs when using
-		a compiler with aggressive pointer-value speculation
-		optimizations.
-
-		More important, the rcu_dereference_sched() makes it
-		clear to someone reading the code that the pointer is
-		being protected by RCU-sched.
diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 8d20d44..627128c 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -10,6 +10,7 @@ RCU concepts
    arrayRCU
    rcu
    listRCU
+   NMI-RCU
    UP
 
    Design/Memory-Ordering/Tree-RCU-Memory-Ordering
