Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240BFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E95C220771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QjRRqZCb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bx8MiBTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgGXULn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:11:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40210 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgGXULl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:11:41 -0400
Date:   Fri, 24 Jul 2020 20:11:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595621498;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XtFCHFgAKaj5JdV4fyEA7k9jyYeHwTAiKGd37VnG1Mk=;
        b=QjRRqZCbOKly0YYx6bdAut5VEu1K7fecXd7rnjN7Nmq4p2+8TIDTCaM46ZBpXo2uc4V/TR
        wnNtmXJxb752LGva1p6JM908ZRWjJVSTcSDSwpO8O0uqEKIC4Nj9xJKHy6z5JTL3MAz9ZP
        dCIAJN80VAx7cEFB9G+aoSsjzimClh9H1ElepnHIoSxJX+v4uUDCO7pdS1n2VM+M5sQ/iy
        ISaLktwfhwH0WqOQx8jFYMdI1gy/xJvDnDDG1LMDi00HzcY7mBpO7InEvaXmMddW07bSIh
        yWJNKvjWa4veDGnsiKoftZ01pItWtvXEs2Fk2HZ6E3rNWtJdWB72Cz8REYsFGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595621498;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XtFCHFgAKaj5JdV4fyEA7k9jyYeHwTAiKGd37VnG1Mk=;
        b=bx8MiBTNjA3FGiovNzXK9M4r8KT1EIYl/PYxCPcOIZWHSMqU3OW8WBHBZu+Bc/4QkKz6Er
        1xYvCBbhyhIgvfCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/kvm: Use generic xfer to guest work function
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200722220520.979724969@linutronix.de>
References: <20200722220520.979724969@linutronix.de>
MIME-Version: 1.0
Message-ID: <159562149754.4006.8865086246836564879.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     72c3c0fe54a3f3ddea8f5ca468ddf9deaf2100b7
Gitweb:        https://git.kernel.org/tip/72c3c0fe54a3f3ddea8f5ca468ddf9deaf2100b7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 23 Jul 2020 00:00:09 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Jul 2020 15:05:01 +02:00

x86/kvm: Use generic xfer to guest work function

Use the generic infrastructure to check for and handle pending work before
transitioning into guest mode.

This now handles TIF_NOTIFY_RESUME as well which was ignored so
far. Handling it is important as this covers task work and task work will
be used to offload the heavy lifting of POSIX CPU timers to thread context.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200722220520.979724969@linutronix.de

---
 arch/x86/kvm/Kconfig   |  1 +
 arch/x86/kvm/vmx/vmx.c | 11 +++++------
 arch/x86/kvm/x86.c     | 15 ++++++---------
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index b277a2d..fbd5bd7 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -42,6 +42,7 @@ config KVM
 	select HAVE_KVM_MSI
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select HAVE_KVM_NO_POLL
+	select KVM_XFER_TO_GUEST_WORK
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_VFIO
 	select SRCU
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 13745f2..9909375 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/tboot.h>
 #include <linux/trace_events.h>
+#include <linux/entry-kvm.h>
 
 #include <asm/apic.h>
 #include <asm/asm.h>
@@ -5373,14 +5374,12 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
 		}
 
 		/*
-		 * Note, return 1 and not 0, vcpu_run() is responsible for
-		 * morphing the pending signal into the proper return code.
+		 * Note, return 1 and not 0, vcpu_run() will invoke
+		 * xfer_to_guest_mode() which will create a proper return
+		 * code.
 		 */
-		if (signal_pending(current))
+		if (__xfer_to_guest_mode_work_pending())
 			return 1;
-
-		if (need_resched())
-			schedule();
 	}
 
 	return 1;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 88c593f..82d4a9e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -56,6 +56,7 @@
 #include <linux/sched/stat.h>
 #include <linux/sched/isolation.h>
 #include <linux/mem_encrypt.h>
+#include <linux/entry-kvm.h>
 
 #include <trace/events/kvm.h>
 
@@ -1587,7 +1588,7 @@ EXPORT_SYMBOL_GPL(kvm_emulate_wrmsr);
 bool kvm_vcpu_exit_request(struct kvm_vcpu *vcpu)
 {
 	return vcpu->mode == EXITING_GUEST_MODE || kvm_request_pending(vcpu) ||
-		need_resched() || signal_pending(current);
+		xfer_to_guest_mode_work_pending();
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_exit_request);
 
@@ -8681,15 +8682,11 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
 			break;
 		}
 
-		if (signal_pending(current)) {
-			r = -EINTR;
-			vcpu->run->exit_reason = KVM_EXIT_INTR;
-			++vcpu->stat.signal_exits;
-			break;
-		}
-		if (need_resched()) {
+		if (xfer_to_guest_mode_work_pending()) {
 			srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
-			cond_resched();
+			r = xfer_to_guest_mode_handle_work(vcpu);
+			if (r)
+				return r;
 			vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
 		}
 	}
