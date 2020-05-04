Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B695C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFAFF2068E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rs9/26B4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgEDXYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:24:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39356 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgEDXXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:23:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NKvDI189045;
        Mon, 4 May 2020 23:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=025THODSAUORN0KKxcGMO0F7lBMceQh7+vvoiAV8J5A=;
 b=Rs9/26B4gNxBfWStl5uLBsxpqlUrjqZF858zTW2b6FIWtGtzAY/AK0JBbkmfbDDUgzsR
 r/Ja28g9Xq91erwMGSy03vzTN9FrMNaguY0Z+Vk6upqsnTGl7TQ3eN/yWeWJIbKEOODa
 4umdC3mTq2I6bUf/HHQxedfPIl+hFZ5w3+ufsOTkYh0sFpFGCRIjhAmTWUMcHK5eqVWl
 Cx3beG0ijQl7v2OU32bHEk75wR2qBWFno6OyW9maRIH5RKvznqibcwdFvRTTF7MhCF73
 0Or2jAFt1Mw9DBjlHJiwDXFmZgZrUA7eeoWm8fs8Xy2J/kcVOZzeXeyBshMENTdUCNKa kQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30s09r1v0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:23:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NMTaR021575;
        Mon, 4 May 2020 23:23:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30sjjx5hyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:23:03 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044NN2jk010758;
        Mon, 4 May 2020 23:23:02 GMT
Received: from tomti.i.net-space.pl (/10.175.189.148)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 16:23:01 -0700
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     grub-devel@gnu.org, linux-kernel@vger.kernel.org,
        trenchboot-devel@googlegroups.com, x86@kernel.org
Cc:     alexander.burmashev@oracle.com, andrew.cooper3@citrix.com,
        ard.biesheuvel@linaro.org, dpsmith@apertussolutions.com,
        eric.snowberg@oracle.com, javierm@redhat.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        krystian.hebel@3mdeb.com, lukasz.hawrylko@linux.intel.com,
        michal.zygowski@3mdeb.com, mjg59@google.com, phcoder@gmail.com,
        pirot.krol@3mdeb.com, pjones@redhat.com, ross.philipson@oracle.com
Subject: [GRUB PATCH RFC 13/18] i386/slaunch: Add basic platform support for secure launch
Date:   Tue,  5 May 2020 01:21:27 +0200
Message-Id: <20200504232132.23570-14-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200504232132.23570-1-daniel.kiper@oracle.com>
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040182
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Philipson <ross.philipson@oracle.com>

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 include/grub/i386/cpuid.h |  13 ++++
 include/grub/i386/crfr.h  | 186 ++++++++++++++++++++++++++++++++++++++++++++++
 include/grub/i386/mmio.h  |  90 ++++++++++++++++++++++
 include/grub/i386/msr.h   |  61 +++++++++++++++
 4 files changed, 350 insertions(+)
 create mode 100644 include/grub/i386/crfr.h
 create mode 100644 include/grub/i386/mmio.h

diff --git a/include/grub/i386/cpuid.h b/include/grub/i386/cpuid.h
index f7ae4b0a4..8176e5d11 100644
--- a/include/grub/i386/cpuid.h
+++ b/include/grub/i386/cpuid.h
@@ -19,6 +19,19 @@
 #ifndef GRUB_CPU_CPUID_HEADER
 #define GRUB_CPU_CPUID_HEADER 1
 
+/* General  */
+#define GRUB_X86_CPUID_VENDOR	0x00000000
+#define GRUB_X86_CPUID_FEATURES	0x00000001
+
+/* Intel  */
+#define GRUB_VMX_CPUID_FEATURE	(1<<5)
+#define GRUB_SMX_CPUID_FEATURE	(1<<6)
+
+/* AMD  */
+#define GRUB_AMD_CPUID_FEATURES	0x80000001
+#define GRUB_SVM_CPUID_FEATURE	(1<<2)
+#define GRUB_AMD_CPUID_FUNC	0x8000000a
+
 extern unsigned char grub_cpuid_has_longmode;
 extern unsigned char grub_cpuid_has_pae;
 
diff --git a/include/grub/i386/crfr.h b/include/grub/i386/crfr.h
new file mode 100644
index 000000000..284d6967b
--- /dev/null
+++ b/include/grub/i386/crfr.h
@@ -0,0 +1,186 @@
+/*
+ *  GRUB  --  GRand Unified Bootloader
+ *  Copyright (C) 2020  Oracle and/or its affiliates.
+ *
+ *  GRUB is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 3 of the License, or
+ *  (at your option) any later version.
+ *
+ *  GRUB is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with GRUB.  If not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifndef GRUB_CRFR_H
+#define GRUB_CRFR_H 1
+
+#include <grub/types.h>
+
+/* Routines for R/W of control and flags registers */
+
+#define GRUB_CR0_X86_PE		0x00000001 /* Enable Protected Mode */
+#define GRUB_CR0_X86_MP		0x00000002 /* "Math" (FPU) Present */
+#define GRUB_CR0_X86_EM		0x00000004 /* EMulate FPU */
+#define GRUB_CR0_X86_TS		0x00000008 /* Task Switched */
+#define GRUB_CR0_X86_PG		0x80000000 /* Enable PaGing */
+
+#define GRUB_CR0_X86_NE		0x00000020 /* Numeric Error enable (EX16 vs IRQ13) */
+#define GRUB_CR0_X86_WP		0x00010000 /* Write Protect */
+#define GRUB_CR0_X86_AM		0x00040000 /* Alignment Mask */
+#define GRUB_CR0_X86_NW		0x20000000 /* Not Write-through */
+#define GRUB_CR0_X86_CD		0x40000000 /* Cache Disable */
+
+#define GRUB_CR4_X86_VME	0x00000001 /* Virtual 8086 mode extensions */
+#define GRUB_CR4_X86_PVI	0x00000002 /* Protected-mode virtual interrupts */
+#define GRUB_CR4_X86_TSD	0x00000004 /* Time stamp disable */
+#define GRUB_CR4_X86_DE		0x00000008 /* Debugging extensions */
+#define GRUB_CR4_X86_PSE	0x00000010 /* Page size extensions */
+#define GRUB_CR4_X86_PAE	0x00000020 /* Physical address extension */
+#define GRUB_CR4_X86_MCE	0x00000040 /* Enable Machine check enable */
+#define GRUB_CR4_X86_PGE	0x00000080 /* Enable Page global */
+#define GRUB_CR4_X86_PCE	0x00000100 /* Enable Performance monitoring counter */
+#define GRUB_CR4_X86_FXSR	0x00000200 /* Fast FPU save/restore */
+#define GRUB_CR4_X86_XMM	0x00000400 /* Enable SIMD/MMX2 to use except 16 */
+#define GRUB_CR4_X86_VMXE	0x00002000 /* Enable VMX */
+#define GRUB_CR4_X86_SMXE	0x00004000 /* Enable SMX */
+#define GRUB_CR4_X86_PCIDE	0x00020000 /* Enable PCID */
+
+static inline unsigned long
+grub_read_cr4 (void)
+{
+  unsigned long val;
+
+  asm volatile ("mov %%cr4, %0" : "=r" (val) : : "memory");
+
+  return val;
+}
+
+static inline void
+grub_write_cr4 (unsigned long val)
+{
+  asm volatile ("mov %0, %%cr4" : : "r" (val) : "memory");
+}
+
+#define GRUB_CR0	0
+#define GRUB_CR1	1
+#define GRUB_CR2	2
+#define GRUB_CR3	3
+#define GRUB_CR4	4
+
+#ifdef __x86_64__
+#define read_cr(r, d) asm volatile ("movq %%cr" r ", %0" : "=r" (d))
+#else
+#define read_cr(r, d) asm volatile ("movl %%cr" r ", %0" : "=r" (d))
+#endif
+
+static inline unsigned long
+grub_read_control_register(grub_uint8_t reg)
+{
+  unsigned long data;
+
+  switch (reg)
+  {
+  case GRUB_CR0:
+    read_cr("0", data);
+    break;
+  case GRUB_CR1:
+    read_cr("1", data);
+    break;
+  case GRUB_CR2:
+    read_cr("2", data);
+    break;
+  case GRUB_CR3:
+    read_cr("3", data);
+    break;
+  case GRUB_CR4:
+    read_cr("4", data);
+    break;
+  default:
+    /* TODO: Loudly complain if this is called. Even some kind of BUG() */
+    data = ~0UL;
+    break;
+  }
+
+  return data;
+}
+
+#ifdef __x86_64__
+#define write_cr(r, d) asm volatile ("movq %0, %%cr" r : : "r" (d))
+#else
+#define write_cr(r, d) asm volatile ("movl %0, %%cr" r : : "r" (d))
+#endif
+
+static inline void
+grub_write_control_register(grub_uint8_t reg, unsigned long data)
+{
+  switch (reg)
+  {
+  case GRUB_CR0:
+    write_cr("0", data);
+    break;
+  case GRUB_CR1:
+    write_cr("1", data);
+    break;
+  case GRUB_CR2:
+    write_cr("2", data);
+    break;
+  case GRUB_CR3:
+    write_cr("3", data);
+    break;
+  case GRUB_CR4:
+    write_cr("4", data);
+    break;
+  default:
+    /* TODO: Loudly complain if this is called. Even some kind of BUG() */
+    ;
+  }
+}
+
+#define GRUB_EFLAGS_X86_CF	0x00000001 /* Carry Flag */
+#define GRUB_EFLAGS_X86_PF	0x00000004 /* Parity Flag */
+#define GRUB_EFLAGS_X86_AF	0x00000010 /* Auxillary carry Flag */
+#define GRUB_EFLAGS_X86_ZF	0x00000040 /* Zero Flag */
+#define GRUB_EFLAGS_X86_SF	0x00000080 /* Sign Flag */
+#define GRUB_EFLAGS_X86_TF	0x00000100 /* Trap Flag */
+#define GRUB_EFLAGS_X86_IF	0x00000200 /* Interrupt Flag */
+#define GRUB_EFLAGS_X86_DF	0x00000400 /* Direction Flag */
+#define GRUB_EFLAGS_X86_OF	0x00000800 /* Overflow Flag */
+#define GRUB_EFLAGS_X86_IOPL	0x00003000 /* IOPL mask */
+#define GRUB_EFLAGS_X86_NT	0x00004000 /* Nested Task */
+#define GRUB_EFLAGS_X86_RF	0x00010000 /* Resume Flag */
+#define GRUB_EFLAGS_X86_VM	0x00020000 /* Virtual Mode */
+#define GRUB_EFLAGS_X86_AC	0x00040000 /* Alignment Check */
+#define GRUB_EFLAGS_X86_VIF	0x00080000 /* Virtual Interrupt Flag */
+#define GRUB_EFLAGS_X86_VIP	0x00100000 /* Virtual Interrupt Pending */
+#define GRUB_EFLAGS_X86_ID	0x00200000 /* CPUID detection flag */
+
+static inline unsigned long
+grub_read_flags_register(void)
+{
+  unsigned long flags;
+
+#ifdef __x86_64__
+  asm volatile ("pushfq; popq %0" : "=r" (flags));
+#else
+  asm volatile ("pushfl; popl %0" : "=r" (flags));
+#endif
+
+  return flags;
+}
+
+static inline void
+grub_write_flags_register(unsigned long flags)
+{
+#ifdef __x86_64__
+  asm volatile ("pushq %0; popfq" : : "r" (flags));
+#else
+  asm volatile ("pushl %0; popfl" : : "r" (flags));
+#endif
+}
+
+#endif
diff --git a/include/grub/i386/mmio.h b/include/grub/i386/mmio.h
new file mode 100644
index 000000000..6f5bf18ce
--- /dev/null
+++ b/include/grub/i386/mmio.h
@@ -0,0 +1,90 @@
+/*
+ *  GRUB  --  GRand Unified Bootloader
+ *  Copyright (C) 2020  Oracle and/or its affiliates.
+ *
+ *  GRUB is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 3 of the License, or
+ *  (at your option) any later version.
+ *
+ *  GRUB is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with GRUB.  If not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifndef GRUB_I386_MMIO_H
+#define GRUB_I386_MMIO_H 1
+
+#include <grub/types.h>
+
+/* TODO: Are these barirers really needed??? */
+#define grub_mb()	asm volatile ("mfence" : : : "memory")
+#define grub_rmb()	asm volatile ("lfence" : : : "memory")
+#define grub_wmb()	asm volatile ("sfence" : : : "memory")
+#define grub_barrier()	asm volatile ("" : : : "memory")
+
+static inline grub_uint8_t
+grub_readb (const volatile void *addr)
+{
+  grub_uint8_t val;
+
+  grub_barrier ();
+  val = (*(volatile grub_uint8_t *) (addr));
+  grub_rmb ();
+
+  return val;
+}
+
+static inline grub_uint32_t
+grub_readl (const volatile void *addr)
+{
+  grub_uint32_t val;
+
+  grub_barrier ();
+  val = (*(volatile grub_uint32_t *) (addr));
+  grub_rmb ();
+
+  return val;
+}
+
+static inline grub_uint64_t
+grub_readq (const volatile void *addr)
+{
+  grub_uint64_t val;
+
+  grub_barrier ();
+  val = (*(volatile grub_uint64_t *) (addr));
+  grub_rmb ();
+
+  return val;
+}
+
+static inline void
+grub_writeb (grub_uint8_t val, volatile void *addr)
+{
+  grub_wmb ();
+  (*(volatile grub_uint8_t *) (addr)) = val;
+  grub_barrier ();
+}
+
+static inline void
+grub_writel (grub_uint32_t val, volatile void *addr)
+{
+  grub_wmb ();
+  (*(volatile grub_uint32_t *) (addr)) = val;
+  grub_barrier ();
+}
+
+static inline void
+grub_writeq (grub_uint64_t val, volatile void *addr)
+{
+  grub_wmb ();
+  (*(volatile grub_uint64_t *) (addr)) = val;
+  grub_barrier ();
+}
+
+#endif /* GRUB_I386_MMIO_H */
diff --git a/include/grub/i386/msr.h b/include/grub/i386/msr.h
index 1e838c022..f2552ecbc 100644
--- a/include/grub/i386/msr.h
+++ b/include/grub/i386/msr.h
@@ -2,6 +2,9 @@
  *  GRUB  --  GRand Unified Bootloader
  *  Copyright (C) 2019  Free Software Foundation, Inc.
  *
+ *  Some definitions in this header are extracted from the Trusted Computing
+ *  Group's "TPM Main Specification", Parts 1-3.
+ *
  *  GRUB is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
  *  the Free Software Foundation, either version 3 of the License, or
@@ -19,6 +22,62 @@
 #ifndef GRUB_I386_MSR_H
 #define GRUB_I386_MSR_H 1
 
+/* General */
+#define GRUB_MSR_X86_PLATFORM_ID	0x00000017
+
+#define GRUB_MSR_X86_APICBASE		0x0000001b
+#define GRUB_MSR_X86_APICBASE_BSP	(1<<8)
+#define GRUB_MSR_X86_APICBASE_ENABLE	(1<<11)
+#define GRUB_MSR_X86_APICBASE_BASE	(0xfffff<<12)
+
+#define GRUB_MSR_X86_FEATURE_CONTROL	0x0000003a
+#define GRUB_MSR_X86_ENABLE_VMX_IN_SMX	(1<<1)
+#define GRUB_MSR_X86_SENTER_FUNCTIONS	(0x7f<<8)
+#define GRUB_MSR_X86_SENTER_ENABLE	(1<<15)
+
+#define GRUB_MSR_X86_MTRRCAP		0x000000fe
+#define GRUB_MSR_X86_VCNT_MASK		0xff
+
+#define GRUB_MSR_X86_MCG_CAP		0x00000179
+#define GRUB_MSR_MCG_BANKCNT_MASK	0xff      /* Number of banks  */
+#define GRUB_MSR_X86_MCG_STATUS		0x0000017a
+#define GRUB_MSR_MCG_STATUS_MCIP	(1ULL<<2) /* MC in progress  */
+
+#define GRUB_MSR_X86_MISC_ENABLE	0x000001a0
+#define GRUB_MSR_X86_ENABLE_MONITOR_FSM	(1<<18)
+
+#define GRUB_MSR_X86_MTRR_PHYSBASE0	0x00000200
+#define GRUB_MSR_X86_MTRR_PHYSMASK0	0x00000201
+#define GRUB_MSR_X86_BASE_DEF_TYPE_MASK	0xff
+#define GRUB_MSR_X86_MASK_VALID		(1<<11)
+
+#define GRUB_MSR_X86_MTRR_DEF_TYPE	0x000002ff
+#define GRUB_MSR_X86_DEF_TYPE_MASK	0xff
+#define GRUB_MSR_X86_MTRR_ENABLE_FIXED	(1<<10)
+#define GRUB_MSR_X86_MTRR_ENABLE	(1<<11)
+
+#define GRUB_MSR_X86_MC0_STATUS		0x00000401
+
+#define GRUB_MSR_X86_EFER		0xc0000080 /* Extended features  */
+#define GRUB_MSR_EFER_LME		(1<<8)     /* Enable Long Mode/IA-32e  */
+#define GRUB_MSR_EFER_LMA		(1<<10)    /* Long Mode/IA-32e Actuve  */
+#define GRUB_MSR_EFER_SVME		(1<<12)    /* Enable virtualization  */
+
+/* AMD Specific */
+#define GRUB_MSR_AMD64_PATCH_LEVEL	0x0000008b
+#define GRUB_MSR_AMD64_PATCH_CLEAR	0xc0010021 /* AMD-specific microcode patch clear  */
+#define GRUB_MSR_AMD64_VM_CR		0xc0010114
+#define GRUB_MSR_SVM_VM_CR_SVM_DISABLE	4
+
+/* MTRR Specific */
+#define GRUB_MTRR_MEMORY_TYPE_UC	0
+#define GRUB_MTRR_MEMORY_TYPE_WC	1
+#define GRUB_MTRR_MEMORY_TYPE_WT	4
+#define GRUB_MTRR_MEMORY_TYPE_WP	5
+#define GRUB_MTRR_MEMORY_TYPE_WB	6
+
+#ifndef ASM_FILE
+
 #include <grub/err.h>
 #include <grub/i386/cpuid.h>
 #include <grub/types.h>
@@ -71,4 +130,6 @@ grub_wrmsr (grub_uint32_t msr_id, grub_uint64_t msr_value)
   asm volatile ("wrmsr" : : "c" (msr_id), "a" (low), "d" (high));
 }
 
+#endif /* ASM_FILE */
+
 #endif /* GRUB_I386_MSR_H */
-- 
2.11.0

