Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61205C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3625722BEA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgH0HtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:49:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:17866 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728063AbgH0HtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:49:06 -0400
IronPort-SDR: a7MZjKZvk5AlPJ+lgrTsTRuhk4mXTUoTB55QcmuxPGwplvmwNQ8yaFxW/2t+stnobIZvvAb/fl
 +cyG7P3Np8IQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="153859543"
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="153859543"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 00:49:06 -0700
IronPort-SDR: Mj1HXbmPH55Pn9bV7puuEqqBCydBbY2najXAiXggf498NNCe5USJvwbY86lIwzqlyDsEs1wue1
 cB+1ghqMNQbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="403327647"
Received: from shbuild999.sh.intel.com ([10.239.146.107])
  by fmsmga001.fm.intel.com with ESMTP; 27 Aug 2020 00:49:04 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [RFC PATCH] tools/x86: add kcpuid tool to show raw CPU features
Date:   Thu, 27 Aug 2020 15:49:03 +0800
Message-Id: <1598514543-90152-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

End users frequently want to know what features their processor
supports, independent of what the kernel supports.

/proc/cpuinfo is great. It is omnipresent and since it is provided by
the kernel it is always as up to date as the kernel. But, it can be
ambiguous about processor features which can be disabled by the kernel
at boot-time or compile-time.

There are some user space tools showing more raw features, but they are
not bound with kernel, and go with distros. Many end users are still
using old distros with new kernels (upgraded by themselves), and may
not upgrade the distros only to get a newer tool.

So here arise the need for a new tool, which
  1. Can make up for the ambiguity of cpuinfo
  2. Be easier to obtain updates for compared to existing userspace
     tooling (perhaps distributed like perf)
  3. Inherits "modern" kernel development process, in contrast to some
     of the existing userspace cpuid tools which are still being developed
     without git and distributed in tarballs from non-https sites.
  4. Can produce output consistent with /proc/cpuinfo to make comparison
     easier
  5. Being in-kernel, could leverage kernel enabling, and even
     theoretically consume arch/x86/boot/cpustr.h so it could pick up
     new features directly from one-line X86_FEATURE_* definitions.

This RFC is an early prototype, and would get community's opinion on
whether it's the right thing to do, and what functions it should also
support.

Current version only shows limited number of cpu features, and can
also dump all raw cpuid leaf data. Some todos are:
  1. Parse all cpu raw features
  2. Run cpuid with specific parameters from user input

This is based on the prototype code from Borislav Petkov [1]

output of the tool
------------------

	CPUID leafs total: 28

	cpu family	: 6
	model		: 13
	stepping	: 7

	CPU features
	------------
	 sse3
	 pclmlqdq
	 dtes64
	 mwait
	 ds_cpl
	 vmx
	 smx
	 eist
	 tm2
	 ssse3
	 cx16
	 pctxid
	 dca
	 sse4_1
	 sse4_2
	 x2apic
	 tsc_deadline_timer
	 aes
	 xsave
	 osxsave
	 avx
	 fpu
	 ...

[1] http://sr71.net/~dave/intel/stupid-cpuid.c

Originally-by: Borislav Petkov <bp@alien8.de>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 tools/arch/x86/tools/kcpuid/Makefile |  21 ++
 tools/arch/x86/tools/kcpuid/kcpuid.c | 422 +++++++++++++++++++++++++++++++++++
 2 files changed, 443 insertions(+)
 create mode 100644 tools/arch/x86/tools/kcpuid/Makefile
 create mode 100644 tools/arch/x86/tools/kcpuid/kcpuid.c

diff --git a/tools/arch/x86/tools/kcpuid/Makefile b/tools/arch/x86/tools/kcpuid/Makefile
new file mode 100644
index 0000000..21453e5
--- /dev/null
+++ b/tools/arch/x86/tools/kcpuid/Makefile
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for x86/kcpuid tool
+
+kcpuid : kcpuid.c
+
+CFLAGS =  -Wextra
+
+BINDIR ?= /usr/sbin
+
+override CFLAGS += -O2 -Wall -I../../../include
+
+%: %.c
+	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)
+
+.PHONY : clean
+clean :
+	@rm -f kcpuid
+
+install : kcpuid
+	install -d  $(DESTDIR)$(BINDIR)
+	install -m 755 -p kcpuid $(DESTDIR)$(BINDIR)/kcpuid
diff --git a/tools/arch/x86/tools/kcpuid/kcpuid.c b/tools/arch/x86/tools/kcpuid/kcpuid.c
new file mode 100644
index 0000000..305c3d6
--- /dev/null
+++ b/tools/arch/x86/tools/kcpuid/kcpuid.c
@@ -0,0 +1,422 @@
+#include <stdio.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+typedef unsigned int u32;
+
+struct cpuid_parser {
+	u32 func;
+	u32 subleaf;
+	void (*parse)(u32 eax, u32 ebx, u32 ecx, u32 edx);
+};
+
+struct subleaf {
+	u32 index;
+	u32 sub;
+	u32 eax, ebx, ecx, edx;
+};
+
+/* Array of subleafs for this func: */
+struct cpuid_func {
+	struct subleaf *leafs;
+	int n;
+};
+
+struct cpuid_range {
+	/* Array of functions in this range */
+	struct cpuid_func *funcs;
+
+	/* n == 0 means there is no valid entry here */
+	int n;
+};
+
+struct cpuid {
+	struct cpuid_range *base, *ext;
+} leafs;
+
+static int num_leafs = 0;
+static bool is_amd = false;
+
+struct reg_01_a {
+	u32 stepping: 4;	/* bit 0 */
+	u32 model: 4;
+	u32 family: 4;
+	u32 type: 2;
+	u32 pad1: 2;
+	u32 model_ext: 4;	/* bit 16 */
+	u32 family_ext: 8;
+};
+
+struct reg_01_b {
+	u32 brand: 8;		/* bit 0 */
+	u32 clflush_size: 8;
+	u32 max_id: 8;		/* bit 16 */
+	u32 apic_id: 8;
+};
+
+/*
+ * Set not-so-important bit to NULL, just re-enable it
+ * if you think the feature should be reported
+ */
+const char *reg_01_c_strings[] = {
+	"sse3",
+	"pclmlqdq",	/* Carryless Multiplication */
+	"dtes64",
+	"mwait",
+	"ds_cpl",	/* CPL Debug Store */
+	"vmx",
+	"smx",
+	"eist",
+	"tm2",		/* Thermal Monitor 2 */
+	"ssse3",
+	"l1_ctx_id",
+	NULL,		/* SDBG */
+	NULL,		/* FMA - Fused Multiply Add */
+	"cx16",
+	NULL,		/* xTPR */
+	NULL,		/* PDCM */
+	NULL,		/* pad0 - bit 16 */
+	"pctxid",	/* Process CTX ID */
+	"dca",
+	"sse4_1",
+	"sse4_2",
+	"x2apic",
+	NULL,		/* MOVBE */
+	NULL,		/* POPCNT */
+	"tsc_deadline_timer",
+	"aes",
+	"xsave",
+	"osxsave",
+	"avx",
+	NULL,		/* F16C */
+	"rdrand",
+	NULL		/* pad1 - bit 31 */
+};
+
+const char *reg_01_d_strings[] = {
+	"fpu",
+	"vme",
+	"de",		/* Debugging Extension */
+	"pse",
+	"tsc",
+	"msr",
+	"pae",
+	"mce",
+	"cx8",
+	"apic",
+	NULL,		/* pad0 - bit 10 */
+	"sep",
+	"mtrr",
+	"pge",		/* PGE - PTE global bit */
+	"mca",
+	"cmov",
+	"pat",
+	"pse-36",
+	"psn",
+	"clflush",
+	NULL,		/* pad1 - bit 20 */
+	NULL,		/* Debug Store */
+	"acpi",
+	"mmx",
+	"fxsave",	/* FXSAVE/FXRSTOR */
+	"sse",
+	"sse2",
+	"ss",		/* Self Snoop */
+	"multi-threading",
+	"tm",
+	NULL,		/* pad2 - bit 30 */
+	"pbe",		/* PBE - Pend Brk En */
+};
+
+
+static void print_bit_strings(u32 reg, const char *strs[])
+{
+	int i;
+
+	for (i = 0; i < 32; i++) {
+		if ( (reg & (1 << i)) && strs[i])
+			printf(" %s\n", strs[i]);
+	}
+}
+
+static void parse_base_01(u32 eax, u32 ebx, u32 ecx, u32 edx)
+{
+	struct reg_01_a *a;
+	struct reg_01_b *b;
+
+	a = (struct reg_01_a *)&eax;
+	b = (struct reg_01_b *)&ebx;
+
+	printf(
+		"cpu family\t: %u\n"
+		"model\t\t: %u\n"
+		"stepping\t: %u\n"
+		,
+		a->family,
+		a->model,
+		a->stepping
+		);
+
+	/* print CPU feature flags */
+	printf("\nCPU features\n------------\n");
+	print_bit_strings(ecx, reg_01_c_strings);
+	print_bit_strings(edx, reg_01_d_strings);
+}
+
+static struct cpuid_parser parsers[] = {
+
+	{0x1, 0, parse_base_01},
+
+	#if 0
+	{0x2, 0, parse_base_02},
+	/* {0x3, 0, parse_base_03}, NULL info in SDM */
+	{0x4, 0x0, parse_base_04_00},
+	{0x4, 0x1, parse_base_04_01},
+	{0x4, 0x2, parse_base_04_02},
+	{0x4, 0x3, parse_base_04_03},
+	#endif
+};
+
+static inline void cpuid(u32 *eax, u32 *ebx, u32 *ecx, u32 *edx)
+{
+	/* ecx is often an input as well as an output. */
+	asm volatile("cpuid"
+	    : "=a" (*eax),
+	      "=b" (*ebx),
+	      "=c" (*ecx),
+	      "=d" (*edx)
+	    : "0" (*eax), "2" (*ecx));
+}
+
+static inline bool has_subleafs(u32 f)
+{
+	if (f == 0x7 || f == 0xd)
+		return true;
+
+	if (is_amd) {
+		if (f == 0x8000001d)
+			return true;
+		return false;
+	}
+
+	if (f == 0x4 || f == 0xf || f == 0x10 || f == 0x14)
+		return true;
+
+	return false;
+}
+
+static void cpuid_print(u32 f, int subleaf, u32 a, u32 b, u32 c, u32 d)
+{
+	if (has_subleafs(f)) {
+		if (subleaf == 0)
+			printf("0x%08x: subleafs:\n", f);
+
+		printf(" %2d: EAX=0x%08x, EBX=0x%08x, ECX=0x%08x, EDX=0x%08x\n",
+			subleaf, a, b, c, d);
+	} else {
+		printf("0x%08x: EAX=0x%08x, EBX=0x%08x, ECX=0x%08x, EDX=0x%08x\n",
+			f, a, b, c, d);
+	}
+}
+
+static void cpuid_store(struct cpuid_range *r, u32 f, int subleaf,
+			u32 a, u32 b, u32 c, u32 d)
+{
+	struct cpuid_func *func;
+	int s = 0;
+
+	if (a == 0 && b == 0 && c == 0 && d == 0)
+		return;
+
+	/*
+	 * Cut off vendor-prefix from CPUID function as we're using it as an
+	 * index into ->funcs.
+	 */
+	func = &r->funcs[f & 0xffff];
+
+	if (!func->leafs) {
+		func->leafs = malloc(sizeof(struct subleaf));
+		if (!func->leafs)
+			perror("malloc func leaf");
+
+		func->n = 1;
+	} else {
+		s = func->n;
+		func->leafs = realloc(func->leafs, (s + 1) * sizeof(struct subleaf));
+		if (!func->leafs)
+			perror("realloc f->leafs");
+
+		func->n++;
+	}
+
+	func->leafs[s].index = f;
+	func->leafs[s].sub = subleaf;
+	func->leafs[s].eax = a;
+	func->leafs[s].ebx = b;
+	func->leafs[s].ecx = c;
+	func->leafs[s].edx = d;
+}
+
+static void dump_all_leafs(void)
+{
+	struct cpuid_range *r;
+	u32 f = 0;
+
+	printf("Saved leafs:\n");
+
+	printf("\nBasic Leafs:\n");
+	r = leafs.base;
+	for (f = 0; (int)f < r->n; f++) {
+		struct cpuid_func *func = &r->funcs[f];
+
+		if (!func->n)
+			printf("0x%08x: ...\n", f);
+		else {
+			int l;
+
+			for (l = 0; l < func->n; l++) {
+				struct subleaf *slf = &func->leafs[l];
+				cpuid_print(f, slf->sub, slf->eax, slf->ebx, slf->ecx, slf->edx);
+			}
+		}
+	}
+
+	printf("\nExtended Leafs :\n");
+	r = leafs.ext;
+	for (f = 0; (int)f < r->n; f++) {
+		struct cpuid_func *func = &r->funcs[f];
+
+		if (!func->n)
+			printf("0x%08x: ...\n", f + 0x80000000);
+		else {
+			int l;
+
+			for (l = 0; l < func->n; l++) {
+				struct subleaf *slf = &func->leafs[l];
+
+				cpuid_print(f + 0x80000000, slf->sub, slf->eax, slf->ebx, slf->ecx, slf->edx);
+			}
+		}
+	}
+}
+
+struct cpuid_range *setup_cpuid_range(u32 input_eax)
+{
+	u32 max_func, idx_func;
+	int subleaf, highest_sub;
+	struct cpuid_range *r;
+	u32 eax, ebx, ecx, edx;
+	u32 f = input_eax;
+
+	eax = input_eax;
+	ebx = ecx = edx = 0;
+
+	cpuid(&eax, &ebx, &ecx, &edx);
+	max_func = eax;
+	idx_func = (max_func & 0xffff) + 1;
+
+	r = malloc(sizeof(struct cpuid_range));
+	if (!r)
+		perror("malloc range");
+
+	r->funcs = malloc(sizeof(struct cpuid_func) * idx_func);
+	if (!r->funcs)
+		perror("malloc r->funcs");
+
+	r->n = idx_func;
+	memset(r->funcs, 0, sizeof(struct cpuid_func) * idx_func);
+
+	for (; f <= max_func; f++) {
+		eax = f;
+		subleaf = ecx = 0;
+
+		cpuid(&eax, &ebx, &ecx, &edx);
+		cpuid_store(r, f, subleaf, eax, ebx, ecx, edx);
+		num_leafs++;
+
+		if (!has_subleafs(f))
+			continue;
+
+		for (subleaf = highest_sub = 1; subleaf < 64; subleaf++) {
+			eax = f;
+			ecx = subleaf;
+
+			cpuid(&eax, &ebx, &ecx, &edx);
+
+			/* is subleaf valid? */
+			if (eax == 0 && ebx == 0 && ecx == 0 && edx == 0)
+				continue;
+
+			cpuid_store(r, f, subleaf, eax, ebx, ecx, edx);
+			num_leafs++;
+		}
+	}
+
+	return r;
+}
+
+static void parse_one_leaf(u32 index, u32 subleaf, u32 a, u32 b, u32 c, u32 d)
+{
+	int nr_parser = ARRAY_SIZE(parsers);
+	struct cpuid_parser *parser;
+	int i;
+
+	for (i = 0; i < nr_parser; i++) {
+		parser = &parsers[i];
+		if (index == parser->func && subleaf == parser->subleaf) {
+			parser->parse(a, b, c, d);
+			break;
+		}
+	}
+}
+
+static void parse_cpuid_range(struct cpuid_range *r)
+{
+	struct cpuid_func *func;
+	struct subleaf *leaf;
+	int i, j;
+
+	for (i = 0; i < r->n; i++) {
+		func = &r->funcs[i];
+
+		for (j = 0; j < func->n; j++) {
+			leaf = &func->leafs[j];
+			parse_one_leaf(leaf->index, leaf->sub, leaf->eax,
+					leaf->ebx, leaf->ecx, leaf->edx);
+		}
+	}
+}
+
+static void parse_leafs(void)
+{
+	parse_cpuid_range(leafs.base);
+	parse_cpuid_range(leafs.ext);
+	printf("\n");
+}
+
+int main(void)
+{
+	u32 eax, ebx, ecx, edx;
+
+	/* check vendor */
+	eax = ebx = ecx = edx = 0;
+	cpuid(&eax, &ebx, &ecx, &edx);
+	/* "htuA" */
+	if (ebx == 0x68747541)
+		is_amd = true;
+
+	/* setup leafs by getting the base and extended range */
+	leafs.base = setup_cpuid_range(0x0);
+	leafs.ext = setup_cpuid_range(0x80000000);
+	printf("CPUID leafs total: %d\n\n", num_leafs);
+
+	//dump_all_leafs();
+
+	/* parse leafs and print features out */
+	parse_leafs();
+
+	return 0;
+}
-- 
2.7.4

