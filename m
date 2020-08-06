Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002D2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D77221744
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xYAaedoX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Rf8XwE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgHFXil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:38:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60830 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgHFXik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:38:40 -0400
Date:   Thu, 06 Aug 2020 23:38:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757117;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=aIhO7iqEyt7r4ToNH6DksDy+HikhpXQIKVl5XcqQM4s=;
        b=xYAaedoXTtDHD0EbBDgpYJrWnfC3MYbf3TjuuObc9FROcbZZL4FKzesl47vwfC8PYNhp6o
        WeJ6H3eYnIWB1Ho4pW7uVGtkUfM3/g0DBYbd3lxa8SKlOZ5M4H88ozBK5O9VBl0Vo80v+x
        JZ++5rayMUPTLSVa9JZ10oYqKG51PPo7iPAGW52RVuKmhnvcpEQLFLvUfiJ3g7RQa55TY/
        9BNMZOss+whjPSE0m62ZBMugENstq0oancWIOcZ/utsXprLpFz/9scNavCuAr8TFHGHMXk
        8X60cIUNqfBUE+QUIfHH/9UoMb2StwJVxjCzsg22NVry4IM4jUjWADmAvUDDaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757117;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=aIhO7iqEyt7r4ToNH6DksDy+HikhpXQIKVl5XcqQM4s=;
        b=0Rf8XwE9CxUlNiunfL5RdIybwtMzCSPqAfmt83jcOAUJEifO5U+j+CKS1Xsp0RoYQmjPvd
        i/wwbB4HFkBobNCw==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] x86/headers: Remove APIC headers from <asm/smp.h>
Cc:     Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159675711659.3192.7638293771756718702.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     13c01139b17163c9b2aa543a9c39f8bbc875b625
Gitweb:        https://git.kernel.org/tip/13c01139b17163c9b2aa543a9c39f8bbc875b625
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 06 Aug 2020 14:34:32 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Aug 2020 16:13:09 +02:00

x86/headers: Remove APIC headers from <asm/smp.h>

The APIC headers are relatively complex and bring in additional
header dependencies - while smp.h is a relatively simple header
included from high level headers.

Remove the dependency and add in the missing #include's in .c
files where they gained it indirectly before.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/smp.h          | 10 ----------
 arch/x86/include/asm/tsc.h          |  1 +
 arch/x86/kernel/apic/apic.c         |  1 +
 arch/x86/kernel/apic/bigsmp_32.c    |  1 +
 arch/x86/kernel/apic/ipi.c          |  1 +
 arch/x86/kernel/apic/local.h        |  1 +
 arch/x86/kernel/apic/probe_32.c     |  1 +
 arch/x86/kernel/devicetree.c        |  1 +
 arch/x86/kernel/irqinit.c           |  2 ++
 arch/x86/kernel/jailhouse.c         |  1 +
 arch/x86/kernel/mpparse.c           |  2 ++
 arch/x86/kernel/setup.c             |  1 +
 arch/x86/kernel/topology.c          |  1 +
 arch/x86/xen/apic.c                 |  1 +
 arch/x86/xen/enlighten_hvm.c        |  1 +
 arch/x86/xen/smp_pv.c               |  1 +
 drivers/iommu/intel/irq_remapping.c |  1 +
 17 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index e15f364..c0538f8 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -5,16 +5,6 @@
 #include <linux/cpumask.h>
 #include <asm/percpu.h>
 
-/*
- * We need the APIC definitions automatically as part of 'smp.h'
- */
-#ifdef CONFIG_X86_LOCAL_APIC
-# include <asm/mpspec.h>
-# include <asm/apic.h>
-# ifdef CONFIG_X86_IO_APIC
-#  include <asm/io_apic.h>
-# endif
-#endif
 #include <asm/thread_info.h>
 #include <asm/cpumask.h>
 
diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 8a0c25c..db59771 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -6,6 +6,7 @@
 #define _ASM_X86_TSC_H
 
 #include <asm/processor.h>
+#include <asm/cpufeature.h>
 
 #define NS_SCALE	10 /* 2^10, carefully chosen */
 #define US_SCALE	32 /* 2^32, arbitralrily chosen */
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index e0e2f02..0c89003 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -47,6 +47,7 @@
 #include <asm/proto.h>
 #include <asm/traps.h>
 #include <asm/apic.h>
+#include <asm/acpi.h>
 #include <asm/io_apic.h>
 #include <asm/desc.h>
 #include <asm/hpet.h>
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 38b5b51..98d015a 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -9,6 +9,7 @@
 #include <linux/smp.h>
 
 #include <asm/apic.h>
+#include <asm/io_apic.h>
 
 #include "local.h"
 
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 6ca0f91..387154e 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -2,6 +2,7 @@
 
 #include <linux/cpumask.h>
 #include <linux/smp.h>
+#include <asm/io_apic.h>
 
 #include "local.h"
 
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index 04797f0..a997d84 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -10,6 +10,7 @@
 
 #include <linux/jump_label.h>
 
+#include <asm/irq_vectors.h>
 #include <asm/apic.h>
 
 /* APIC flat 64 */
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 67b33d6..7bda71d 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 #include <linux/smp.h>
 
+#include <asm/io_apic.h>
 #include <asm/apic.h>
 #include <asm/acpi.h>
 
diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 8d85e00..a0e8fc7 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -20,6 +20,7 @@
 #include <asm/irqdomain.h>
 #include <asm/hpet.h>
 #include <asm/apic.h>
+#include <asm/io_apic.h>
 #include <asm/pci_x86.h>
 #include <asm/setup.h>
 #include <asm/i8259.h>
diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
index dd73135..beb1bad 100644
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -22,6 +22,8 @@
 #include <asm/timer.h>
 #include <asm/hw_irq.h>
 #include <asm/desc.h>
+#include <asm/io_apic.h>
+#include <asm/acpi.h>
 #include <asm/apic.h>
 #include <asm/setup.h>
 #include <asm/i8259.h>
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index 6eb8b50..2caf5b9 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -13,6 +13,7 @@
 #include <linux/reboot.h>
 #include <linux/serial_8250.h>
 #include <asm/apic.h>
+#include <asm/io_apic.h>
 #include <asm/cpu.h>
 #include <asm/hypervisor.h>
 #include <asm/i8259.h>
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index afac7cc..db509e1 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -19,6 +19,8 @@
 #include <linux/smp.h>
 #include <linux/pci.h>
 
+#include <asm/io_apic.h>
+#include <asm/acpi.h>
 #include <asm/irqdomain.h>
 #include <asm/mtrr.h>
 #include <asm/mpspec.h>
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index a3767e7..f767198 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -25,6 +25,7 @@
 #include <xen/xen.h>
 
 #include <asm/apic.h>
+#include <asm/numa.h>
 #include <asm/bios_ebda.h>
 #include <asm/bugs.h>
 #include <asm/cpu.h>
diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index b8810eb..0a2ec80 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -31,6 +31,7 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/irq.h>
+#include <asm/io_apic.h>
 #include <asm/cpu.h>
 
 static DEFINE_PER_CPU(struct x86_cpu, cpu_devices);
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index 5e53bfb..2df7d08 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -3,6 +3,7 @@
 
 #include <asm/x86_init.h>
 #include <asm/apic.h>
+#include <asm/io_apic.h>
 #include <asm/xen/hypercall.h>
 
 #include <xen/xen.h>
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 3e89b00..9e87ab0 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -11,6 +11,7 @@
 
 #include <asm/cpu.h>
 #include <asm/smp.h>
+#include <asm/io_apic.h>
 #include <asm/reboot.h>
 #include <asm/setup.h>
 #include <asm/idtentry.h>
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 171aff1..8b04c0d 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -29,6 +29,7 @@
 #include <asm/idtentry.h>
 #include <asm/desc.h>
 #include <asm/cpu.h>
+#include <asm/io_apic.h>
 
 #include <xen/interface/xen.h>
 #include <xen/interface/vcpu.h>
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 9564d23..3cf9d57 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -15,6 +15,7 @@
 #include <linux/irqdomain.h>
 #include <linux/crash_dump.h>
 #include <asm/io_apic.h>
+#include <asm/apic.h>
 #include <asm/smp.h>
 #include <asm/cpu.h>
 #include <asm/irq_remapping.h>
