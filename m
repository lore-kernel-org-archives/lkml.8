Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0090FC47247
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD24A20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="geTYw2Jl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgEDXYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:24:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51062 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbgEDXXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:23:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NN65l100162;
        Mon, 4 May 2020 23:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=ioJJ/81iUbwApHplRqoqwub8QjtULcEC2NNnIr3wcfs=;
 b=geTYw2JlO76JaV/yKsjPgpcOXFfy8EqsCevCnxxPx2h0q8KU0QE0qQw4/PXz/Y49T+QT
 Ad243ikvrwryZcuFmba8pGJPfJyiQXs8CHpXcTCB4FJeUYn0zod2FLA/9qJaou6alWIw
 9MVY9MfaHp+SOftmio7Kp+sRv6vL0/UNG5GkQj//5VHN5OLX2J34hID3hDkjMZewY1Cq
 YnPZEJtNHbA3GoaanxWCxZNW6gT5/n/bQpbnm5poujLtoOpEQBkQDuOrPXLA33KnMMb6
 SMHNZ8k9l4NF5am5fLzA8ouajK0YAVrVlhXqLq5km33rxbHK/Xz8exmMzCa8vtNi04Ry Bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30s0tm9t49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:23:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NMTpK021500;
        Mon, 4 May 2020 23:23:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30sjjx5jau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:23:28 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044NNQYD003911;
        Mon, 4 May 2020 23:23:26 GMT
Received: from tomti.i.net-space.pl (/10.175.189.148)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 16:23:26 -0700
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
Subject: [GRUB PATCH RFC 18/18] i386/slaunch: Add secure launch framework and commands
Date:   Tue,  5 May 2020 01:21:32 +0200
Message-Id: <20200504232132.23570-19-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200504232132.23570-1-daniel.kiper@oracle.com>
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040182
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=2
 phishscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Philipson <ross.philipson@oracle.com>

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 grub-core/Makefile.am            |   3 +
 grub-core/Makefile.core.def      |  15 +++
 grub-core/lib/i386/relocator32.S |   8 ++
 grub-core/loader/i386/bsd.c      |   7 ++
 grub-core/loader/i386/linux.c    | 206 ++++++++++++++++++++++++++++++++++++---
 grub-core/loader/i386/slaunch.c  | 194 ++++++++++++++++++++++++++++++++++++
 grub-core/loader/i386/xnu.c      |   3 +
 grub-core/loader/multiboot.c     |   5 +
 include/grub/file.h              |   3 +
 include/grub/i386/linux.h        |  14 ++-
 include/grub/i386/slaunch.h      |  56 +++++++++++
 11 files changed, 500 insertions(+), 14 deletions(-)
 create mode 100644 grub-core/loader/i386/slaunch.c
 create mode 100644 include/grub/i386/slaunch.h

diff --git a/grub-core/Makefile.am b/grub-core/Makefile.am
index 3ea8e7ff4..ae6676e6f 100644
--- a/grub-core/Makefile.am
+++ b/grub-core/Makefile.am
@@ -99,6 +99,7 @@ KERNEL_HEADER_FILES += $(top_builddir)/include/grub/machine/kernel.h
 KERNEL_HEADER_FILES += $(top_builddir)/include/grub/machine/pxe.h
 KERNEL_HEADER_FILES += $(top_builddir)/include/grub/machine/int.h
 KERNEL_HEADER_FILES += $(top_srcdir)/include/grub/i386/tsc.h
+KERNEL_HEADER_FILES += $(top_srcdir)/include/grub/i386/slaunch.h
 endif
 
 if COND_i386_xen_pvh
@@ -118,6 +119,7 @@ KERNEL_HEADER_FILES += $(top_builddir)/include/grub/machine/kernel.h
 KERNEL_HEADER_FILES += $(top_srcdir)/include/grub/efi/efi.h
 KERNEL_HEADER_FILES += $(top_srcdir)/include/grub/efi/disk.h
 KERNEL_HEADER_FILES += $(top_srcdir)/include/grub/i386/tsc.h
+KERNEL_HEADER_FILES += $(top_srcdir)/include/grub/i386/slaunch.h
 KERNEL_HEADER_FILES += $(top_srcdir)/include/grub/acpi.h
 KERNEL_HEADER_FILES += $(top_srcdir)/include/grub/pci.h
 KERNEL_HEADER_FILES += $(top_srcdir)/include/grub/i386/pmtimer.h
@@ -179,6 +181,7 @@ KERNEL_HEADER_FILES += $(top_builddir)/include/grub/machine/kernel.h
 KERNEL_HEADER_FILES += $(top_srcdir)/include/grub/efi/efi.h
 KERNEL_HEADER_FILES += $(top_srcdir)/include/grub/efi/disk.h
 KERNEL_HEADER_FILES += $(top_srcdir)/include/grub/i386/tsc.h
+KERNEL_HEADER_FILES += $(top_srcdir)/include/grub/i386/slaunch.h
 KERNEL_HEADER_FILES += $(top_srcdir)/include/grub/pci.h
 KERNEL_HEADER_FILES += $(top_srcdir)/include/grub/acpi.h
 KERNEL_HEADER_FILES += $(top_srcdir)/include/grub/i386/pmtimer.h
diff --git a/grub-core/Makefile.core.def b/grub-core/Makefile.core.def
index b74a34f0c..a07811b51 100644
--- a/grub-core/Makefile.core.def
+++ b/grub-core/Makefile.core.def
@@ -1824,6 +1824,15 @@ module = {
 };
 
 module = {
+  name = slaunch;
+  x86 = loader/i386/slaunch.c;
+  x86 = loader/i386/txt/txt.c;
+  x86 = loader/i386/txt/acmod.c;
+  x86 = loader/i386/txt/verify.c;
+  enable = x86;
+};
+
+module = {
   name = fdt;
   efi = loader/efi/fdt.c;
   common = lib/fdt.c;
@@ -2497,6 +2506,12 @@ module = {
 };
 
 module = {
+  name = tpm;
+  x86 = commands/i386/tpm.c;
+  enable = x86;
+};
+
+module = {
   name = tpm_verifier;
   common = commands/tpm_verifier.c;
   efi = commands/efi/tpm.c;
diff --git a/grub-core/lib/i386/relocator32.S b/grub-core/lib/i386/relocator32.S
index 09ce56ad0..a2b377197 100644
--- a/grub-core/lib/i386/relocator32.S
+++ b/grub-core/lib/i386/relocator32.S
@@ -24,6 +24,8 @@
 
 #include "relocator_common.S"
 
+#include <grub/i386/slaunch.h>
+
 	.p2align	4	/* force 16-byte alignment */
 
 VARIABLE(grub_relocator32_start)
@@ -110,11 +112,17 @@ VARIABLE(grub_relocator32_edx)
 	   payload and makes this implementation easier.  */
 	cld
 
+	cmpl	$SLP_INTEL_TXT, %edi
+	je	LOCAL(intel_txt)
+
 	.byte	0xea
 VARIABLE(grub_relocator32_eip)
 	.long	0
 	.word	CODE_SEGMENT
 
+LOCAL(intel_txt):
+	getsec
+
 	/* GDT. Copied from loader/i386/linux.c. */
 	.p2align	4
 LOCAL(gdt):
diff --git a/grub-core/loader/i386/bsd.c b/grub-core/loader/i386/bsd.c
index eb82391db..53bb2af93 100644
--- a/grub-core/loader/i386/bsd.c
+++ b/grub-core/loader/i386/bsd.c
@@ -21,6 +21,10 @@
 #include <grub/i386/cpuid.h>
 #include <grub/memory.h>
 #include <grub/i386/memory.h>
+#if 0
+#include <grub/i386/slaunch.h>
+#endif
+#define SLP_NONE 0
 #include <grub/file.h>
 #include <grub/err.h>
 #include <grub/dl.h>
@@ -791,6 +795,7 @@ grub_freebsd_boot (void)
 #endif
 
       grub_memcpy (&stack[9], &bi, sizeof (bi));
+      state.edi = SLP_NONE;
       state.eip = entry;
       state.esp = stack_target;
       state.ebp = stack_target;
@@ -906,6 +911,7 @@ grub_openbsd_boot (void)
     return err;
 #endif
 
+  state.edi = SLP_NONE;
   state.eip = entry;
   state.ebp = state.esp
     = ((grub_uint8_t *) stack - (grub_uint8_t *) buf0) + buf_target;
@@ -1223,6 +1229,7 @@ grub_netbsd_boot (void)
     return err;
 #endif
 
+  state.edi = SLP_NONE;
   state.eip = entry;
   state.esp = stack_target;
   state.ebp = stack_target;
diff --git a/grub-core/loader/i386/linux.c b/grub-core/loader/i386/linux.c
index 952eb1191..da8be621e 100644
--- a/grub-core/loader/i386/linux.c
+++ b/grub-core/loader/i386/linux.c
@@ -34,6 +34,8 @@
 #include <grub/i386/relocator.h>
 #include <grub/i18n.h>
 #include <grub/lib/cmdline.h>
+#include <grub/i386/slaunch.h>
+#include <grub/i386/txt.h>
 #include <grub/linux.h>
 #include <grub/machine/kernel.h>
 
@@ -61,18 +63,23 @@ GRUB_MOD_LICENSE ("GPLv3+");
 #define ACCEPTS_PURE_TEXT 1
 #endif
 
+#define KERNEL_INFO_HEADER		"LToP"
+#define KERNEL_INFO_MIN_SIZE_TOTAL	12
+
 static grub_dl_t my_mod;
 
 static grub_size_t linux_mem_size;
 static int loaded;
 static void *prot_mode_mem;
 static grub_addr_t prot_mode_target;
+static grub_size_t prot_file_size;
 static void *initrd_mem;
 static grub_addr_t initrd_mem_target;
 static grub_size_t prot_init_space;
 static struct grub_relocator *relocator = NULL;
 static void *efi_mmap_buf;
 static grub_size_t maximal_cmdline_size;
+static struct linux_kernel_info *linux_info;
 static struct linux_kernel_params linux_params;
 static char *linux_cmdline;
 #ifdef GRUB_MACHINE_EFI
@@ -80,6 +87,7 @@ static grub_efi_uintn_t efi_mmap_size;
 #else
 static const grub_size_t efi_mmap_size = 0;
 #endif
+static struct grub_slaunch_params slparams;
 
 /* FIXME */
 #if 0
@@ -96,6 +104,8 @@ static struct idt_descriptor idt_desc =
   };
 #endif
 
+#define OFFSET_OF(x, y) ((grub_size_t)((grub_uint8_t *)(&(y)->x) - (grub_uint8_t *)(y)))
+
 static inline grub_size_t
 page_align (grub_size_t size)
 {
@@ -148,11 +158,35 @@ allocate_pages (grub_size_t prot_size, grub_size_t *align,
 		grub_uint64_t preferred_address)
 {
   grub_err_t err;
+  grub_size_t total_size;
 
   if (prot_size == 0)
     prot_size = 1;
 
-  prot_size = page_align (prot_size);
+  if (grub_slaunch_platform_type () == SLP_INTEL_TXT)
+    {
+      prot_size = ALIGN_UP (prot_size, GRUB_TXT_PMR_ALIGN);
+
+      if (prot_size > GRUB_TXT_MLE_MAX_SIZE)
+	{
+	  err = GRUB_ERR_OUT_OF_RANGE;
+	  goto fail;
+	}
+
+      slparams.mle_ptab_size = grub_txt_get_mle_ptab_size (prot_size);
+      slparams.mle_ptab_size = ALIGN_UP (slparams.mle_ptab_size, GRUB_TXT_PMR_ALIGN);
+      /* Do not go below GRUB_TXT_PMR_ALIGN. */
+      preferred_address = (preferred_address > slparams.mle_ptab_size) ?
+			    (preferred_address - slparams.mle_ptab_size) : GRUB_TXT_PMR_ALIGN;
+      preferred_address = ALIGN_UP (preferred_address, GRUB_TXT_PMR_ALIGN);
+    }
+  else
+    {
+      prot_size = page_align (prot_size);
+      slparams.mle_ptab_size = 0;
+    }
+
+  total_size = prot_size + slparams.mle_ptab_size;
 
   /* Initialize the memory pointers with NULL for convenience.  */
   free_pages ();
@@ -174,7 +208,7 @@ allocate_pages (grub_size_t prot_size, grub_size_t *align,
 	err = grub_relocator_alloc_chunk_align (relocator, &ch,
 						preferred_address,
 						preferred_address,
-						prot_size, 1,
+						total_size, 1,
 						GRUB_RELOCATOR_PREFERENCE_LOW,
 						1);
 	for (; err && *align + 1 > min_align; (*align)--)
@@ -182,8 +216,8 @@ allocate_pages (grub_size_t prot_size, grub_size_t *align,
 	    grub_errno = GRUB_ERR_NONE;
 	    err = grub_relocator_alloc_chunk_align (relocator, &ch,
 						    0x1000000,
-						    0xffffffff & ~prot_size,
-						    prot_size, 1 << *align,
+						    0xffffffff & ~total_size,
+						    total_size, 1 << *align,
 						    GRUB_RELOCATOR_PREFERENCE_LOW,
 						    1);
 	  }
@@ -193,11 +227,42 @@ allocate_pages (grub_size_t prot_size, grub_size_t *align,
     else
       err = grub_relocator_alloc_chunk_addr (relocator, &ch,
 					     preferred_address,
-					     prot_size);
+					     total_size);
     if (err)
       goto fail;
     prot_mode_mem = get_virtual_current_address (ch);
     prot_mode_target = get_physical_target_address (ch);
+
+    if (grub_slaunch_platform_type () == SLP_INTEL_TXT)
+      {
+	slparams.mle_ptab_mem = prot_mode_mem;
+	slparams.mle_ptab_target = prot_mode_target;
+
+	prot_mode_mem = (char *)prot_mode_mem + slparams.mle_ptab_size;
+	prot_mode_target += slparams.mle_ptab_size;
+
+	slparams.mle_start = prot_mode_target;
+	slparams.mle_size = prot_size;
+
+	grub_dprintf ("linux", "mle_ptab_mem = %p, mle_ptab_target = %lx, mle_ptab_size = %x\n",
+		      slparams.mle_ptab_mem, (unsigned long) slparams.mle_ptab_target,
+		      (unsigned) slparams.mle_ptab_size);
+
+	if (grub_relocator_alloc_chunk_align (relocator, &ch, 0x1000000,
+					      0xffffffff - GRUB_SLAUNCH_TPM_EVT_LOG_SIZE,
+					      GRUB_SLAUNCH_TPM_EVT_LOG_SIZE, GRUB_PAGE_SIZE,
+					      GRUB_RELOCATOR_PREFERENCE_NONE, 1))
+	  goto fail;
+
+	slparams.tpm_evt_log_base = get_physical_target_address (ch);
+	slparams.tpm_evt_log_size = GRUB_SLAUNCH_TPM_EVT_LOG_SIZE;
+
+	grub_memset (get_virtual_current_address (ch), 0, slparams.tpm_evt_log_size);
+
+	grub_dprintf ("linux", "tpm_evt_log_base = %lx, tpm_evt_log_size = %x\n",
+		      (unsigned long) slparams.tpm_evt_log_base,
+		      (unsigned) slparams.tpm_evt_log_size);
+      }
   }
 
   grub_dprintf ("linux", "prot_mode_mem = %p, prot_mode_target = %lx, prot_size = %x\n",
@@ -491,6 +556,7 @@ grub_linux_boot (void)
   };
   grub_size_t mmap_size;
   grub_size_t cl_offset;
+  grub_size_t ap_wake_block_size = 0;
 
 #ifdef GRUB_MACHINE_IEEE1275
   {
@@ -623,6 +689,9 @@ grub_linux_boot (void)
 		(unsigned) ctx.real_size,
 		(unsigned) efi_mmap_size);
 
+  if (grub_slaunch_platform_type () == SLP_INTEL_TXT)
+    ap_wake_block_size = GRUB_MLE_AP_WAKE_BLOCK_SIZE;
+
   if (! ctx.real_mode_target)
     return grub_error (GRUB_ERR_OUT_OF_MEMORY, "cannot allocate real mode pages");
 
@@ -630,13 +699,24 @@ grub_linux_boot (void)
     grub_relocator_chunk_t ch;
     err = grub_relocator_alloc_chunk_addr (relocator, &ch,
 					   ctx.real_mode_target,
-					   (ctx.real_size + efi_mmap_size));
+					   (ctx.real_size + efi_mmap_size +
+					    ap_wake_block_size));
     if (err)
      return err;
     real_mode_mem = get_virtual_current_address (ch);
   }
   efi_mmap_buf = (grub_uint8_t *) real_mode_mem + ctx.real_size;
 
+  if (grub_slaunch_platform_type () == SLP_INTEL_TXT)
+    {
+      slparams.ap_wake_block = ctx.real_mode_target + ctx.real_size + efi_mmap_size;
+      grub_memset ((void *) ((grub_addr_t) real_mode_mem + ctx.real_size +
+					   efi_mmap_size), 0, ap_wake_block_size);
+      grub_dprintf ("linux", "ap_wake_block = %lx, ap_wake_block_size = %lx\n",
+		    (unsigned long) slparams.ap_wake_block,
+		    (unsigned long) ap_wake_block_size);
+    }
+
   grub_dprintf ("linux", "real_mode_mem = %p\n",
                 real_mode_mem);
 
@@ -700,12 +780,33 @@ grub_linux_boot (void)
   }
 #endif
 
-  /* FIXME.  */
-  /*  asm volatile ("lidt %0" : : "m" (idt_desc)); */
-  state.ebp = state.edi = state.ebx = 0;
-  state.esi = ctx.real_mode_target;
-  state.esp = ctx.real_mode_target;
-  state.eip = ctx.params->code32_start;
+  state.edi = grub_slaunch_platform_type ();
+
+  if (state.edi == SLP_INTEL_TXT)
+    {
+      slparams.params = ctx.params;
+
+      err = grub_txt_boot_prepare (&slparams);
+
+      if (err != GRUB_ERR_NONE)
+	return err;
+
+      /* Configure relocator GETSEC[SENTER] call. */
+      state.eax = GRUB_SMX_LEAF_SENTER;
+      state.ebx = slparams.sinit_acm_base;
+      state.ecx = slparams.sinit_acm_size;
+      state.edx = 0;
+    }
+  else
+    {
+      /* FIXME.  */
+      /*  asm volatile ("lidt %0" : : "m" (idt_desc)); */
+      state.ebp = state.edi = state.ebx = 0;
+      state.esi = ctx.real_mode_target;
+      state.esp = ctx.real_mode_target;
+      state.eip = ctx.params->code32_start;
+    }
+
   return grub_relocator32_boot (relocator, state, 0);
 }
 
@@ -726,7 +827,7 @@ grub_cmd_linux (grub_command_t cmd __attribute__ ((unused)),
   grub_file_t file = 0;
   struct linux_i386_kernel_header lh;
   grub_uint8_t setup_sects;
-  grub_size_t real_size, prot_size, prot_file_size;
+  grub_size_t real_size, prot_size;
   grub_ssize_t len;
   int i;
   grub_size_t align, min_align;
@@ -839,6 +940,13 @@ grub_cmd_linux (grub_command_t cmd __attribute__ ((unused)),
       prot_init_space = page_align (prot_size) * 3;
     }
 
+  if (grub_slaunch_platform_type () == SLP_INTEL_TXT)
+    {
+      /* PMRs require GRUB_TXT_PMR_ALIGN_SHIFT aligments. */
+      min_align = grub_max (min_align, GRUB_TXT_PMR_ALIGN_SHIFT);
+      align = grub_max (align, GRUB_TXT_PMR_ALIGN_SHIFT);
+    }
+
   if (allocate_pages (prot_size, &align,
 		      min_align, relocatable,
 		      preferred_address))
@@ -846,6 +954,9 @@ grub_cmd_linux (grub_command_t cmd __attribute__ ((unused)),
 
   grub_memset (&linux_params, 0, sizeof (linux_params));
 
+  if (grub_slaunch_platform_type () == SLP_INTEL_TXT)
+    grub_txt_setup_mle_ptab (&slparams);
+
   /*
    * The Linux 32-bit boot protocol defines the setup header end
    * to be at 0x202 + the byte value at 0x201.
@@ -872,6 +983,75 @@ grub_cmd_linux (grub_command_t cmd __attribute__ ((unused)),
       goto fail;
     }
 
+  /* Read the kernel_info struct. */
+  if (grub_le_to_cpu16 (lh.version) >= 0x020f)
+    {
+      if (grub_file_seek (file, grub_le_to_cpu32 (lh.kernel_info_offset) +
+				real_size + GRUB_DISK_SECTOR_SIZE) == ((grub_off_t) -1))
+	goto fail;
+
+      linux_info = grub_malloc (KERNEL_INFO_MIN_SIZE_TOTAL);
+
+      if (!linux_info)
+	{
+	  grub_error (GRUB_ERR_OUT_OF_MEMORY, N_("cannot allocate memory for kernel_info"));
+	  goto fail;
+	}
+
+      /* Load minimal kernel_info struct. */
+      if (grub_file_read (file, linux_info,
+			  KERNEL_INFO_MIN_SIZE_TOTAL) != KERNEL_INFO_MIN_SIZE_TOTAL)
+	{
+	  if (!grub_errno)
+	    grub_error (GRUB_ERR_BAD_OS, N_("premature end of file %s"), argv[0]);
+	  goto fail;
+	}
+
+      if (grub_memcmp (&linux_info->header, KERNEL_INFO_HEADER, sizeof (linux_info->header)))
+	{
+	  grub_error (GRUB_ERR_BAD_OS, N_("incorrect kernel_info header"));
+	  goto fail;
+	}
+
+      linux_info->size_total = grub_le_to_cpu32 (linux_info->size_total);
+
+      linux_info = grub_realloc (linux_info, linux_info->size_total);
+
+      if (!linux_info)
+	{
+	  grub_error (GRUB_ERR_OUT_OF_MEMORY, N_("cannot reallocate memory for kernel_info"));
+	  goto fail;
+	}
+
+      /* Load the rest of kernel_info struct. */
+      if (grub_file_read (file, &linux_info->setup_type_max,
+			  linux_info->size_total - KERNEL_INFO_MIN_SIZE_TOTAL) !=
+				(grub_ssize_t)(linux_info->size_total - KERNEL_INFO_MIN_SIZE_TOTAL))
+	{
+	  if (!grub_errno)
+	    grub_error (GRUB_ERR_BAD_OS, N_("premature end of file %s"), argv[0]);
+	  goto fail;
+	}
+
+      if (grub_slaunch_platform_type () != SLP_NONE)
+	{
+	  if (OFFSET_OF (mle_header_offset, linux_info) >=
+	      grub_le_to_cpu32 (linux_info->size))
+	    {
+	      if (!grub_errno)
+		grub_error (GRUB_ERR_BAD_OS, N_("not slaunch kernel: lack of mle_header_offset"));
+	      goto fail;
+	    }
+
+	  slparams.mle_header_offset = grub_le_to_cpu32 (linux_info->mle_header_offset);
+	}
+    }
+  else if (grub_slaunch_platform_type () != SLP_NONE)
+    {
+      grub_error (GRUB_ERR_BAD_OS, N_("not slaunch kernel: boot protocol too old"));
+      goto fail;
+    }
+
   linux_params.code32_start = prot_mode_target + lh.code32_start - GRUB_LINUX_BZIMAGE_ADDR;
   linux_params.kernel_alignment = (1 << align);
   linux_params.ps_mouse = linux_params.padding11 = 0;
diff --git a/grub-core/loader/i386/slaunch.c b/grub-core/loader/i386/slaunch.c
new file mode 100644
index 000000000..72d09236b
--- /dev/null
+++ b/grub-core/loader/i386/slaunch.c
@@ -0,0 +1,194 @@
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
+ *  along with GRUB.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <grub/loader.h>
+#include <grub/memory.h>
+#include <grub/normal.h>
+#include <grub/err.h>
+#include <grub/misc.h>
+#include <grub/types.h>
+#include <grub/dl.h>
+#include <grub/cpu/relocator.h>
+#include <grub/i386/cpuid.h>
+#include <grub/i386/msr.h>
+#include <grub/i386/mmio.h>
+#include <grub/i386/slaunch.h>
+#include <grub/i386/txt.h>
+
+GRUB_MOD_LICENSE ("GPLv3+");
+
+static grub_uint32_t slp = SLP_NONE;
+
+static void *slaunch_module = NULL;
+
+grub_uint32_t
+grub_slaunch_platform_type (void)
+{
+  return slp;
+}
+
+void *
+grub_slaunch_module (void)
+{
+  return slaunch_module;
+}
+
+static grub_err_t
+grub_cmd_slaunch (grub_command_t cmd __attribute__ ((unused)),
+		  int argc __attribute__ ((unused)),
+		  char *argv[] __attribute__ ((unused)))
+{
+  grub_uint32_t manufacturer[3];
+  grub_uint32_t eax;
+  grub_err_t err;
+
+  if (!grub_cpu_is_cpuid_supported ())
+    return grub_error (GRUB_ERR_BAD_DEVICE, N_("CPUID is unsupported"));
+
+  err = grub_cpu_is_msr_supported ();
+
+  if (err != GRUB_ERR_NONE)
+    return grub_error (err, N_("MSRs are unsupported"));
+
+  grub_cpuid (0, eax, manufacturer[0], manufacturer[2], manufacturer[1]);
+
+  if (!grub_memcmp (manufacturer, "GenuineIntel", 12))
+    {
+      err = grub_txt_init ();
+
+      if (err != GRUB_ERR_NONE)
+	return err;
+
+      slp = SLP_INTEL_TXT;
+    }
+  else
+    return grub_error (GRUB_ERR_UNKNOWN_DEVICE, N_("CPU is unsupported"));
+
+  return GRUB_ERR_NONE;
+}
+
+static grub_err_t
+grub_cmd_slaunch_module (grub_command_t cmd __attribute__ ((unused)),
+			 int argc, char *argv[])
+{
+  grub_file_t file;
+  grub_ssize_t size;
+
+  if (!argc)
+    return grub_error (GRUB_ERR_BAD_ARGUMENT, N_("filename expected"));
+
+  if (slp == SLP_NONE)
+    return grub_error (GRUB_ERR_BAD_ARGUMENT, N_("secure launch not enabled"));
+
+  grub_errno = GRUB_ERR_NONE;
+
+  file = grub_file_open (argv[0], GRUB_FILE_TYPE_SLAUNCH_MODULE);
+
+  if (file == NULL)
+    return grub_errno;
+
+  size = grub_file_size (file);
+
+  if (!size)
+    {
+      grub_error (GRUB_ERR_BAD_ARGUMENT, N_("file size is zero"));
+      goto fail;
+    }
+
+  slaunch_module = grub_malloc (size);
+
+  if (slaunch_module == NULL)
+    goto fail;
+
+  if (grub_file_read (file, slaunch_module, size) != size)
+    {
+      if (grub_errno == GRUB_ERR_NONE)
+	grub_error (GRUB_ERR_FILE_READ_ERROR, N_("premature end of file: %s"),
+		    argv[0]);
+      goto fail;
+    }
+
+  if (slp == SLP_INTEL_TXT)
+    {
+      if (!grub_txt_is_sinit_acmod (slaunch_module, size))
+	{
+	  grub_error (GRUB_ERR_BAD_FILE_TYPE, N_("it does not look like SINIT ACM"));
+	  goto fail;
+	}
+
+      if (!grub_txt_acmod_match_platform (slaunch_module))
+	{
+	  grub_error (GRUB_ERR_BAD_FILE_TYPE, N_("SINIT ACM does not match platform"));
+	  goto fail;
+	}
+    }
+
+  grub_file_close (file);
+
+  return GRUB_ERR_NONE;
+
+ fail:
+  grub_error_push ();
+
+  grub_free (slaunch_module);
+  grub_file_close (file);
+
+  slaunch_module = NULL;
+
+  grub_error_pop ();
+
+  return grub_errno;
+}
+
+static grub_err_t
+grub_cmd_slaunch_state (grub_command_t cmd __attribute__ ((unused)),
+			int argc __attribute__ ((unused)),
+			char *argv[] __attribute__ ((unused)))
+{
+  if (slp == SLP_NONE)
+    grub_printf ("Secure launcher: Disabled\n");
+  else if (slp == SLP_INTEL_TXT)
+    {
+      grub_printf ("Secure launcher: Intel TXT\n");
+      grub_txt_state_show ();
+    }
+
+  return GRUB_ERR_NONE;
+}
+
+static grub_command_t cmd_slaunch, cmd_slaunch_module, cmd_slaunch_state;
+
+GRUB_MOD_INIT (slaunch)
+{
+  cmd_slaunch = grub_register_command ("slaunch", grub_cmd_slaunch,
+				       NULL, N_("Enable secure launcher"));
+  cmd_slaunch_module = grub_register_command ("slaunch_module", grub_cmd_slaunch_module,
+					      NULL, N_("Secure launcher module command"));
+  cmd_slaunch_state = grub_register_command ("slaunch_state", grub_cmd_slaunch_state,
+					     NULL, N_("Display secure launcher state"));
+}
+
+GRUB_MOD_FINI (slaunch)
+{
+  grub_unregister_command (cmd_slaunch_state);
+  grub_unregister_command (cmd_slaunch_module);
+  grub_unregister_command (cmd_slaunch);
+
+  if (slp == SLP_INTEL_TXT)
+    grub_txt_shutdown ();
+}
diff --git a/grub-core/loader/i386/xnu.c b/grub-core/loader/i386/xnu.c
index e64ed08f5..e586967b0 100644
--- a/grub-core/loader/i386/xnu.c
+++ b/grub-core/loader/i386/xnu.c
@@ -28,6 +28,7 @@
 #include <grub/i386/cpuid.h>
 #include <grub/efi/api.h>
 #include <grub/i386/pit.h>
+#include <grub/i386/slaunch.h>
 #include <grub/misc.h>
 #include <grub/charset.h>
 #include <grub/term.h>
@@ -807,6 +808,7 @@ grub_xnu_boot_resume (void)
 {
   struct grub_relocator32_state state;
 
+  state.edi = SLP_NONE;
   state.esp = grub_xnu_stack;
   state.ebp = grub_xnu_stack;
   state.eip = grub_xnu_entry_point;
@@ -1134,6 +1136,7 @@ grub_xnu_boot (void)
   grub_autoefi_set_virtual_address_map (memory_map_size, descriptor_size,
 					descriptor_version, memory_map);
 
+  state.edi = SLP_NONE;
   state.eip = grub_xnu_entry_point;
   state.eax = grub_xnu_arg1;
   state.esp = grub_xnu_stack;
diff --git a/grub-core/loader/multiboot.c b/grub-core/loader/multiboot.c
index 4a98d7082..6efb59e8f 100644
--- a/grub-core/loader/multiboot.c
+++ b/grub-core/loader/multiboot.c
@@ -50,6 +50,9 @@
 #include <grub/video.h>
 #include <grub/memory.h>
 #include <grub/i18n.h>
+#if defined (__i386__) || defined (__x86_64__)
+#include <grub/i386/slaunch.h>
+#endif
 
 GRUB_MOD_LICENSE ("GPLv3+");
 
@@ -161,6 +164,8 @@ efi_boot (struct grub_relocator *rel __attribute__ ((unused)),
 static void
 normal_boot (struct grub_relocator *rel, struct grub_relocator32_state state)
 {
+  state.edi = SLP_NONE;
+
   grub_relocator32_boot (rel, state, 0);
 }
 #else
diff --git a/include/grub/file.h b/include/grub/file.h
index 31567483c..f08fcda74 100644
--- a/include/grub/file.h
+++ b/include/grub/file.h
@@ -128,6 +128,9 @@ enum grub_file_type
 
     GRUB_FILE_TYPE_VERIFY_SIGNATURE,
 
+    /* Secure Launch module.  */
+    GRUB_FILE_TYPE_SLAUNCH_MODULE,
+
     GRUB_FILE_TYPE_MASK = 0xffff,
 
     /* --skip-sig is specified.  */
diff --git a/include/grub/i386/linux.h b/include/grub/i386/linux.h
index 6aea73ddb..fade29fab 100644
--- a/include/grub/i386/linux.h
+++ b/include/grub/i386/linux.h
@@ -152,6 +152,17 @@ struct linux_i386_kernel_header
   grub_uint64_t pref_address;
   grub_uint32_t init_size;
   grub_uint32_t handover_offset;
+  grub_uint32_t kernel_info_offset;
+} GRUB_PACKED;
+
+struct linux_kernel_info
+{
+  grub_uint32_t header;
+  grub_uint32_t size;
+  grub_uint32_t size_total;
+  grub_uint32_t setup_type_max;
+  grub_uint32_t mle_header_offset;
+  grub_uint8_t  var_len_data[0];
 } GRUB_PACKED;
 
 /* Boot parameters for Linux based on 2.6.12. This is used by the setup
@@ -329,9 +340,10 @@ struct linux_kernel_params
   grub_uint64_t pref_address;
   grub_uint32_t init_size;
   grub_uint32_t handover_offset;
+  grub_uint32_t kernel_info_offset;
   /* Linux setup header copy - END. */
 
-  grub_uint8_t _pad7[40];
+  grub_uint8_t _pad7[36];
   grub_uint32_t edd_mbr_sig_buffer[EDD_MBR_SIG_MAX];	/* 290 */
   struct grub_e820_mmap e820_map[(0x400 - 0x2d0) / 20];	/* 2d0 */
 } GRUB_PACKED;
diff --git a/include/grub/i386/slaunch.h b/include/grub/i386/slaunch.h
new file mode 100644
index 000000000..e5eebd58c
--- /dev/null
+++ b/include/grub/i386/slaunch.h
@@ -0,0 +1,56 @@
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
+ *  along with GRUB.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ *  Main secure launch definitions header file.
+ */
+
+#ifndef GRUB_I386_SLAUNCH_H
+#define GRUB_I386_SLAUNCH_H 1
+
+/* Secure launch platform types. */
+#define SLP_NONE	0
+#define SLP_INTEL_TXT	1
+
+#define GRUB_SLAUNCH_TPM_EVT_LOG_SIZE	(8 * GRUB_PAGE_SIZE)
+
+#ifndef ASM_FILE
+
+#include <grub/i386/linux.h>
+#include <grub/types.h>
+
+struct grub_slaunch_params
+{
+  struct linux_kernel_params *params;
+  grub_uint32_t mle_start;
+  grub_uint32_t mle_size;
+  void *mle_ptab_mem;
+  grub_uint64_t mle_ptab_target;
+  grub_uint32_t mle_ptab_size;
+  grub_uint32_t mle_header_offset;
+  grub_uint64_t ap_wake_block;
+  grub_uint32_t sinit_acm_base;
+  grub_uint32_t sinit_acm_size;
+  grub_uint64_t tpm_evt_log_base;
+  grub_uint32_t tpm_evt_log_size;
+};
+
+extern grub_uint32_t grub_slaunch_platform_type (void);
+extern void *grub_slaunch_module (void);
+
+#endif /* ASM_FILE */
+
+#endif /* GRUB_I386_SLAUNCH_H */
-- 
2.11.0

