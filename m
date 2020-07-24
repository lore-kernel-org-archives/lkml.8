Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E836C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CDD5206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yvqkxOjs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ilOWMxXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgGXTJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:09:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39880 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXTI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:08:58 -0400
Date:   Fri, 24 Jul 2020 19:08:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595617735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xb7gkOw79hTP+VUseD+J3vUtjmg9zwEsI6NtW/Q9tlM=;
        b=yvqkxOjsvYzog+g5FrZ3olWQ4k9WjhMi/Jgz82wfNmaw5oGtxqesJWB1DHHKTmQwjObNc4
        v03BZn92cYqPz9Y7NflwA1ZCNCDgklxpUBuUnuQQ92QdYw3SU5lYwFfXM0M0gAblXHAclW
        YJjumJ0wluqg0UdME05DetWdbQ6CIuDePxdumJW4uGj9UdUpvIwD8sYn1jvPiFL2T15eUR
        6W6t4YWiADQq5Z7FceOOW/flnhcEda7BMYdR+6M67lID/M5yyaJ+7/0efI0Ox1xd0+KVfU
        Tjde7NEKt0S/kDDlyXwsNJ3Tq5iSN3TsHnSF4uc+NXBSCIqj07v8P62H9DkVlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595617735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xb7gkOw79hTP+VUseD+J3vUtjmg9zwEsI6NtW/Q9tlM=;
        b=ilOWMxXdQG44kkEnfHIrpfCdLbxFjFZk4cdSBVIVpkgc2KLnaTdB8+M+J0suwium1Ut0Bh
        2cyywGX2p5IEuMBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Provide infrastructure for work before
 transitioning to guest mode
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200722220519.833296398@linutronix.de>
References: <20200722220519.833296398@linutronix.de>
MIME-Version: 1.0
Message-ID: <159561773439.4006.6664021782988649777.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     935ace2fb5cc49ae88bd1f1735ddc51cdc2ebfb3
Gitweb:        https://git.kernel.org/tip/935ace2fb5cc49ae88bd1f1735ddc51cdc2ebfb3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 22 Jul 2020 23:59:59 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Jul 2020 15:03:42 +02:00

entry: Provide infrastructure for work before transitioning to guest mode

Entering a guest is similar to exiting to user space. Pending work like
handling signals, rescheduling, task work etc. needs to be handled before
that.

Provide generic infrastructure to avoid duplication of the same handling
code all over the place.

The transfer to guest mode handling is different from the exit to usermode
handling, e.g. vs. rseq and live patching, so a separate function is used.

The initial list of work items handled is:

    TIF_SIGPENDING, TIF_NEED_RESCHED, TIF_NOTIFY_RESUME

Architecture specific TIF flags can be added via defines in the
architecture specific include files.

The calling convention is also different from the syscall/interrupt entry
functions as KVM invokes this from the outer vcpu_run() loop with
interrupts and preemption enabled. To prevent missing a pending work item
it invokes a check for pending TIF work from interrupt disabled code right
before transitioning to guest mode. The lockdep, RCU and tracing state
handling is also done directly around the switch to and from guest mode.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200722220519.833296398@linutronix.de
---
 include/linux/entry-kvm.h | 80 ++++++++++++++++++++++++++++++++++++++-
 include/linux/kvm_host.h  |  8 ++++-
 kernel/entry/Makefile     |  3 +-
 kernel/entry/kvm.c        | 51 ++++++++++++++++++++++++-
 virt/kvm/Kconfig          |  3 +-
 5 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/entry-kvm.h
 create mode 100644 kernel/entry/kvm.c

diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
new file mode 100644
index 0000000..0cef17a
--- /dev/null
+++ b/include/linux/entry-kvm.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_ENTRYKVM_H
+#define __LINUX_ENTRYKVM_H
+
+#include <linux/entry-common.h>
+
+/* Transfer to guest mode work */
+#ifdef CONFIG_KVM_XFER_TO_GUEST_WORK
+
+#ifndef ARCH_XFER_TO_GUEST_MODE_WORK
+# define ARCH_XFER_TO_GUEST_MODE_WORK	(0)
+#endif
+
+#define XFER_TO_GUEST_MODE_WORK					\
+	(_TIF_NEED_RESCHED | _TIF_SIGPENDING |			\
+	 _TIF_NOTIFY_RESUME | ARCH_XFER_TO_GUEST_MODE_WORK)
+
+struct kvm_vcpu;
+
+/**
+ * arch_xfer_to_guest_mode_handle_work - Architecture specific xfer to guest
+ *					 mode work handling function.
+ * @vcpu:	Pointer to current's VCPU data
+ * @ti_work:	Cached TIF flags gathered in xfer_to_guest_mode_handle_work()
+ *
+ * Invoked from xfer_to_guest_mode_handle_work(). Defaults to NOOP. Can be
+ * replaced by architecture specific code.
+ */
+static inline int arch_xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu,
+						      unsigned long ti_work);
+
+#ifndef arch_xfer_to_guest_mode_work
+static inline int arch_xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu,
+						      unsigned long ti_work)
+{
+	return 0;
+}
+#endif
+
+/**
+ * xfer_to_guest_mode_handle_work - Check and handle pending work which needs
+ *				    to be handled before going to guest mode
+ * @vcpu:	Pointer to current's VCPU data
+ *
+ * Returns: 0 or an error code
+ */
+int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu);
+
+/**
+ * __xfer_to_guest_mode_work_pending - Check if work is pending
+ *
+ * Returns: True if work pending, False otherwise.
+ *
+ * Bare variant of xfer_to_guest_mode_work_pending(). Can be called from
+ * interrupt enabled code for racy quick checks with care.
+ */
+static inline bool __xfer_to_guest_mode_work_pending(void)
+{
+	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
+
+	return !!(ti_work & XFER_TO_GUEST_MODE_WORK);
+}
+
+/**
+ * xfer_to_guest_mode_work_pending - Check if work is pending which needs to be
+ *				     handled before returning to guest mode
+ *
+ * Returns: True if work pending, False otherwise.
+ *
+ * Has to be invoked with interrupts disabled before the transition to
+ * guest mode.
+ */
+static inline bool xfer_to_guest_mode_work_pending(void)
+{
+	lockdep_assert_irqs_disabled();
+	return __xfer_to_guest_mode_work_pending();
+}
+#endif /* CONFIG_KVM_XFER_TO_GUEST_WORK */
+
+#endif
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index d564855..ac83e9c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1439,4 +1439,12 @@ int kvm_vm_create_worker_thread(struct kvm *kvm, kvm_vm_thread_fn_t thread_fn,
 				uintptr_t data, const char *name,
 				struct task_struct **thread_ptr);
 
+#ifdef CONFIG_KVM_XFER_TO_GUEST_WORK
+static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
+{
+	vcpu->run->exit_reason = KVM_EXIT_INTR;
+	vcpu->stat.signal_exits++;
+}
+#endif /* CONFIG_KVM_XFER_TO_GUEST_WORK */
+
 #endif
diff --git a/kernel/entry/Makefile b/kernel/entry/Makefile
index c207d20..34c8a3f 100644
--- a/kernel/entry/Makefile
+++ b/kernel/entry/Makefile
@@ -9,4 +9,5 @@ KCOV_INSTRUMENT := n
 CFLAGS_REMOVE_common.o	 = -fstack-protector -fstack-protector-strong
 CFLAGS_common.o		+= -fno-stack-protector
 
-obj-$(CONFIG_GENERIC_ENTRY) += common.o
+obj-$(CONFIG_GENERIC_ENTRY) 		+= common.o
+obj-$(CONFIG_KVM_XFER_TO_GUEST_WORK)	+= kvm.o
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
new file mode 100644
index 0000000..eb1a8a4
--- /dev/null
+++ b/kernel/entry/kvm.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/entry-kvm.h>
+#include <linux/kvm_host.h>
+
+static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
+{
+	do {
+		int ret;
+
+		if (ti_work & _TIF_SIGPENDING) {
+			kvm_handle_signal_exit(vcpu);
+			return -EINTR;
+		}
+
+		if (ti_work & _TIF_NEED_RESCHED)
+			schedule();
+
+		if (ti_work & _TIF_NOTIFY_RESUME) {
+			clear_thread_flag(TIF_NOTIFY_RESUME);
+			tracehook_notify_resume(NULL);
+		}
+
+		ret = arch_xfer_to_guest_mode_handle_work(vcpu, ti_work);
+		if (ret)
+			return ret;
+
+		ti_work = READ_ONCE(current_thread_info()->flags);
+	} while (ti_work & XFER_TO_GUEST_MODE_WORK || need_resched());
+	return 0;
+}
+
+int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu)
+{
+	unsigned long ti_work;
+
+	/*
+	 * This is invoked from the outer guest loop with interrupts and
+	 * preemption enabled.
+	 *
+	 * KVM invokes xfer_to_guest_mode_work_pending() with interrupts
+	 * disabled in the inner loop before going into guest mode. No need
+	 * to disable interrupts here.
+	 */
+	ti_work = READ_ONCE(current_thread_info()->flags);
+	if (!(ti_work & XFER_TO_GUEST_MODE_WORK))
+		return 0;
+
+	return xfer_to_guest_mode_work(vcpu, ti_work);
+}
+EXPORT_SYMBOL_GPL(xfer_to_guest_mode_handle_work);
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index aad9284..1c37ccd 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -60,3 +60,6 @@ config HAVE_KVM_VCPU_RUN_PID_CHANGE
 
 config HAVE_KVM_NO_POLL
        bool
+
+config KVM_XFER_TO_GUEST_WORK
+       bool
