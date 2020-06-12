Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D57EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 10:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB04C207DD
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 10:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgFMKtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 06:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgFMKtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 06:49:01 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04C3C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 03:49:00 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jk3ia-0007xe-Js; Sat, 13 Jun 2020 12:48:57 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id EFD12100D1F;
        Sat, 13 Jun 2020 12:48:55 +0200 (CEST)
Date:   Fri, 12 Jun 2020 22:05:06 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT pull resend] ras/core for v5.8
References: <159199950433.21782.7922990856385499228.tglx@nanos.tec.linutronix.de>
Message-ID: <159199950675.21782.3785702143162610645.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest ras/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-2020-06-12

up to:  7ccddc4613db: x86/mce/dev-mcelog: Fix -Wstringop-truncation warning about strncpy()

The merge of the entry code has been redone and the last two patches
rebased as requested. This now contains

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2020-06-12

which you got a pull request for in the preceding mail. I'm sending this
due to the merge and rebase inflicted dependencies on behalf of Borislav
who provided the changelog.

RAS updates from Borislav Petkov:

  * Unmap a whole guest page if an MCE is encountered in it to avoid
    follow-on MCEs leading to the guest crashing, by Tony Luck.

    This change collided with the entry changes and the merge resolution
    would have been rather unpleasant. To avoid that the entry branch was
    merged in before applying this. The resulting code did not change
    over the rebase.

  * AMD MCE error thresholding machinery cleanup and hotplug sanitization, by
    Thomas Gleixner.

  * Change the MCE notifiers to denote whether they have handled the error
    and not break the chain early by returning NOTIFY_STOP, thus giving the
    opportunity for the later handlers in the chain to see it. By Tony Luck.

  * Add AMD family 0x17, models 0x60-6f support, by Alexander Monakov.

  * Last but not least, the usual round of fixes and improvements.


Thanks,

	tglx

------------------>
Alexander Monakov (3):
      x86/amd_nb: Add AMD family 17h model 60h PCI IDs
      hwmon: (k10temp) Add AMD family 17h model 60h PCI match
      EDAC/amd64: Add AMD family 17h model 60h PCI IDs

Borislav Petkov (2):
      x86/mce/amd, edac: Remove report_gart_errors
      x86/mce: Fixup exception only for the correct MCEs

He Zhe (1):
      x86/mcelog: Add compat_ioctl for 32-bit mcelog support

Thomas Gleixner (7):
      x86/mce/amd: Do proper cleanup on error paths
      x86/mce/amd: Init thresholding machinery only on relevant vendors
      x86/mce/amd: Protect a not-fully initialized bank from the thresholding interrupt
      x86/mce/amd: Sanitize thresholding device creation hotplug path
      x86/mce/amd: Straighten CPU hotplug path
      x86/mce/amd: Cleanup threshold device remove path
      x86/mce/amd: Make threshold bank setting hotplug robust

Tony Luck (10):
      x86/mce: Rename "first" function as "early"
      x86/mce: Convert the CEC to use the MCE notifier
      x86/mce: Add a struct mce.kflags field
      x86/mce: Fix all mce notifiers to update the mce->kflags bitmask
      x86/mce: Change default MCE logger to check mce->kflags
      x86/mce: Add mce=print_all option
      EDAC: Drop the EDAC report status checks
      x86/mce: Drop bogus comment about mce.kflags
      x86/{mce,mm}: Unmap the entire page if the whole page is affected and poisoned
      x86/mce/dev-mcelog: Fix -Wstringop-truncation warning about strncpy()


 arch/x86/include/asm/amd_nb.h        |   1 +
 arch/x86/include/asm/mce.h           |  28 +++--
 arch/x86/include/asm/set_memory.h    |  19 ++-
 arch/x86/include/uapi/asm/mce.h      |   1 +
 arch/x86/kernel/amd_nb.c             |   5 +
 arch/x86/kernel/cpu/mce/amd.c        | 233 ++++++++++++++++++-----------------
 arch/x86/kernel/cpu/mce/core.c       | 102 ++++++++-------
 arch/x86/kernel/cpu/mce/dev-mcelog.c |   8 +-
 arch/x86/kernel/cpu/mce/internal.h   |  10 +-
 arch/x86/kernel/cpu/mce/severity.c   |   6 +-
 drivers/acpi/acpi_extlog.c           |  19 +--
 drivers/acpi/nfit/mce.c              |   1 +
 drivers/edac/amd64_edac.c            |  22 ++--
 drivers/edac/amd64_edac.h            |   3 +
 drivers/edac/edac_mc.c               |  61 ---------
 drivers/edac/i7core_edac.c           |   5 +-
 drivers/edac/mce_amd.c               |  28 +----
 drivers/edac/mce_amd.h               |   2 -
 drivers/edac/pnd2_edac.c             |   8 +-
 drivers/edac/sb_edac.c               |   7 +-
 drivers/edac/skx_common.c            |   3 +-
 drivers/hwmon/k10temp.c              |   1 +
 drivers/ras/cec.c                    |  33 ++++-
 include/linux/edac.h                 |   8 --
 include/linux/pci_ids.h              |   1 +
 include/linux/ras.h                  |   5 -
 include/linux/sched.h                |   4 +-
 include/linux/set_memory.h           |   2 +-
 28 files changed, 306 insertions(+), 320 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index c7df20e78b09..455066a06f60 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -57,6 +57,7 @@ struct threshold_bank {
 
 	/* initialized to the number of CPUs on the node sharing this bank */
 	refcount_t		cpus;
+	unsigned int		shared;
 };
 
 struct amd_northbridge {
diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index a00130112b02..cf503824529c 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -127,6 +127,17 @@
 #define MSR_AMD64_SMCA_MCx_DEADDR(x)	(MSR_AMD64_SMCA_MC0_DEADDR + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_MISCy(x, y)	((MSR_AMD64_SMCA_MC0_MISC1 + y) + (0x10*(x)))
 
+#define XEC(x, mask)			(((x) >> 16) & mask)
+
+/* mce.kflags flag bits for logging etc. */
+#define	MCE_HANDLED_CEC		BIT_ULL(0)
+#define	MCE_HANDLED_UC		BIT_ULL(1)
+#define	MCE_HANDLED_EXTLOG	BIT_ULL(2)
+#define	MCE_HANDLED_NFIT	BIT_ULL(3)
+#define	MCE_HANDLED_EDAC	BIT_ULL(4)
+#define	MCE_HANDLED_MCELOG	BIT_ULL(5)
+#define MCE_IN_KERNEL_RECOV	BIT_ULL(6)
+
 /*
  * This structure contains all data related to the MCE log.  Also
  * carries a signature to make it easier to find from external
@@ -142,14 +153,16 @@ struct mce_log_buffer {
 	struct mce entry[];
 };
 
+/* Highest last */
 enum mce_notifier_prios {
-	MCE_PRIO_FIRST		= INT_MAX,
-	MCE_PRIO_UC		= INT_MAX - 1,
-	MCE_PRIO_EXTLOG		= INT_MAX - 2,
-	MCE_PRIO_NFIT		= INT_MAX - 3,
-	MCE_PRIO_EDAC		= INT_MAX - 4,
-	MCE_PRIO_MCELOG		= 1,
-	MCE_PRIO_LOWEST		= 0,
+	MCE_PRIO_LOWEST,
+	MCE_PRIO_MCELOG,
+	MCE_PRIO_EDAC,
+	MCE_PRIO_NFIT,
+	MCE_PRIO_EXTLOG,
+	MCE_PRIO_UC,
+	MCE_PRIO_EARLY,
+	MCE_PRIO_CEC
 };
 
 struct notifier_block;
@@ -347,5 +360,4 @@ umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)	{ return
 #endif
 
 static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
-
 #endif /* _ASM_X86_MCE_H */
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index ec2c0a094b5d..5948218f35c5 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -86,28 +86,35 @@ int set_direct_map_default_noflush(struct page *page);
 extern int kernel_set_to_readonly;
 
 #ifdef CONFIG_X86_64
-static inline int set_mce_nospec(unsigned long pfn)
+/*
+ * Prevent speculative access to the page by either unmapping
+ * it (if we do not require access to any part of the page) or
+ * marking it uncacheable (if we want to try to retrieve data
+ * from non-poisoned lines in the page).
+ */
+static inline int set_mce_nospec(unsigned long pfn, bool unmap)
 {
 	unsigned long decoy_addr;
 	int rc;
 
 	/*
-	 * Mark the linear address as UC to make sure we don't log more
-	 * errors because of speculative access to the page.
 	 * We would like to just call:
-	 *      set_memory_uc((unsigned long)pfn_to_kaddr(pfn), 1);
+	 *      set_memory_XX((unsigned long)pfn_to_kaddr(pfn), 1);
 	 * but doing that would radically increase the odds of a
 	 * speculative access to the poison page because we'd have
 	 * the virtual address of the kernel 1:1 mapping sitting
 	 * around in registers.
 	 * Instead we get tricky.  We create a non-canonical address
 	 * that looks just like the one we want, but has bit 63 flipped.
-	 * This relies on set_memory_uc() properly sanitizing any __pa()
+	 * This relies on set_memory_XX() properly sanitizing any __pa()
 	 * results with __PHYSICAL_MASK or PTE_PFN_MASK.
 	 */
 	decoy_addr = (pfn << PAGE_SHIFT) + (PAGE_OFFSET ^ BIT(63));
 
-	rc = set_memory_uc(decoy_addr, 1);
+	if (unmap)
+		rc = set_memory_np(decoy_addr, 1);
+	else
+		rc = set_memory_uc(decoy_addr, 1);
 	if (rc)
 		pr_warn("Could not invalidate pfn=0x%lx from 1:1 map\n", pfn);
 	return rc;
diff --git a/arch/x86/include/uapi/asm/mce.h b/arch/x86/include/uapi/asm/mce.h
index 955c2a2e1cf9..db9adc081c5a 100644
--- a/arch/x86/include/uapi/asm/mce.h
+++ b/arch/x86/include/uapi/asm/mce.h
@@ -35,6 +35,7 @@ struct mce {
 	__u64 ipid;		/* MCA_IPID MSR: only valid on SMCA systems */
 	__u64 ppin;		/* Protected Processor Inventory Number */
 	__u32 microcode;	/* Microcode revision */
+	__u64 kflags;		/* Internal kernel use */
 };
 
 #define MCE_GET_RECORD_LEN   _IOR('M', 1, int)
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index b6b3297851f3..18f6b7c4bd79 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -18,9 +18,11 @@
 #define PCI_DEVICE_ID_AMD_17H_ROOT	0x1450
 #define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
 #define PCI_DEVICE_ID_AMD_17H_M30H_ROOT	0x1480
+#define PCI_DEVICE_ID_AMD_17H_M60H_ROOT	0x1630
 #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
+#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
 #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
 
@@ -33,6 +35,7 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_ROOT) },
 	{}
 };
 
@@ -50,6 +53,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
@@ -65,6 +69,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index a906d68a18a2..99be063fcb1b 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -192,7 +192,12 @@ EXPORT_SYMBOL_GPL(smca_banks);
 static char buf_mcatype[MAX_MCATYPE_NAME_LEN];
 
 static DEFINE_PER_CPU(struct threshold_bank **, threshold_banks);
-static DEFINE_PER_CPU(unsigned int, bank_map);	/* see which banks are on */
+
+/*
+ * A list of the banks enabled on each logical CPU. Controls which respective
+ * descriptors to initialize later in mce_threshold_create_device().
+ */
+static DEFINE_PER_CPU(unsigned int, bank_map);
 
 /* Map of banks that have more than MCA_MISC0 available. */
 static DEFINE_PER_CPU(u32, smca_misc_banks_map);
@@ -381,6 +386,10 @@ static void threshold_restart_bank(void *_tr)
 	struct thresh_restart *tr = _tr;
 	u32 hi, lo;
 
+	/* sysfs write might race against an offline operation */
+	if (this_cpu_read(threshold_banks))
+		return;
+
 	rdmsr(tr->b->address, lo, hi);
 
 	if (tr->b->threshold_limit < (hi & THRESHOLD_MAX))
@@ -568,14 +577,19 @@ bool amd_filter_mce(struct mce *m)
 {
 	enum smca_bank_types bank_type = smca_get_bank_type(m->bank);
 	struct cpuinfo_x86 *c = &boot_cpu_data;
-	u8 xec = (m->status >> 16) & 0x3F;
 
 	/* See Family 17h Models 10h-2Fh Erratum #1114. */
 	if (c->x86 == 0x17 &&
 	    c->x86_model >= 0x10 && c->x86_model <= 0x2F &&
-	    bank_type == SMCA_IF && xec == 10)
+	    bank_type == SMCA_IF && XEC(m->status, 0x3f) == 10)
 		return true;
 
+	/* NB GART TLB error reporting is disabled by default. */
+	if (c->x86 < 0x17) {
+		if (m->bank == 4 && XEC(m->status, 0x1f) == 0x5)
+			return true;
+	}
+
 	return false;
 }
 
@@ -1015,13 +1029,22 @@ static void log_and_reset_block(struct threshold_block *block)
 static void amd_threshold_interrupt(void)
 {
 	struct threshold_block *first_block = NULL, *block = NULL, *tmp = NULL;
+	struct threshold_bank **bp = this_cpu_read(threshold_banks);
 	unsigned int bank, cpu = smp_processor_id();
 
+	/*
+	 * Validate that the threshold bank has been initialized already. The
+	 * handler is installed at boot time, but on a hotplug event the
+	 * interrupt might fire before the data has been initialized.
+	 */
+	if (!bp)
+		return;
+
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
 		if (!(per_cpu(bank_map, cpu) & (1 << bank)))
 			continue;
 
-		first_block = per_cpu(threshold_banks, cpu)[bank]->blocks;
+		first_block = bp[bank]->blocks;
 		if (!first_block)
 			continue;
 
@@ -1070,7 +1093,8 @@ store_interrupt_enable(struct threshold_block *b, const char *buf, size_t size)
 	memset(&tr, 0, sizeof(tr));
 	tr.b		= b;
 
-	smp_call_function_single(b->cpu, threshold_restart_bank, &tr, 1);
+	if (smp_call_function_single(b->cpu, threshold_restart_bank, &tr, 1))
+		return -ENODEV;
 
 	return size;
 }
@@ -1094,7 +1118,8 @@ store_threshold_limit(struct threshold_block *b, const char *buf, size_t size)
 	b->threshold_limit = new;
 	tr.b = b;
 
-	smp_call_function_single(b->cpu, threshold_restart_bank, &tr, 1);
+	if (smp_call_function_single(b->cpu, threshold_restart_bank, &tr, 1))
+		return -ENODEV;
 
 	return size;
 }
@@ -1103,7 +1128,9 @@ static ssize_t show_error_count(struct threshold_block *b, char *buf)
 {
 	u32 lo, hi;
 
-	rdmsr_on_cpu(b->cpu, b->address, &lo, &hi);
+	/* CPU might be offline by now */
+	if (rdmsr_on_cpu(b->cpu, b->address, &lo, &hi))
+		return -ENODEV;
 
 	return sprintf(buf, "%u\n", ((hi & THRESHOLD_MAX) -
 				     (THRESHOLD_MAX - b->threshold_limit)));
@@ -1208,10 +1235,10 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 	u32 low, high;
 	int err;
 
-	if ((bank >= per_cpu(mce_num_banks, cpu)) || (block >= NR_BLOCKS))
+	if ((bank >= this_cpu_read(mce_num_banks)) || (block >= NR_BLOCKS))
 		return 0;
 
-	if (rdmsr_safe_on_cpu(cpu, address, &low, &high))
+	if (rdmsr_safe(address, &low, &high))
 		return 0;
 
 	if (!(high & MASK_VALID_HI)) {
@@ -1246,6 +1273,7 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 
 	INIT_LIST_HEAD(&b->miscj);
 
+	/* This is safe as @tb is not visible yet */
 	if (tb->blocks)
 		list_add(&b->miscj, &tb->blocks->miscj);
 	else
@@ -1266,13 +1294,12 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 	if (b)
 		kobject_uevent(&b->kobj, KOBJ_ADD);
 
-	return err;
+	return 0;
 
 out_free:
 	if (b) {
-		kobject_put(&b->kobj);
 		list_del(&b->miscj);
-		kfree(b);
+		kobject_put(&b->kobj);
 	}
 	return err;
 }
@@ -1301,9 +1328,10 @@ static int __threshold_add_blocks(struct threshold_bank *b)
 	return err;
 }
 
-static int threshold_create_bank(unsigned int cpu, unsigned int bank)
+static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
+				 unsigned int bank)
 {
-	struct device *dev = per_cpu(mce_device, cpu);
+	struct device *dev = this_cpu_read(mce_device);
 	struct amd_northbridge *nb = NULL;
 	struct threshold_bank *b = NULL;
 	const char *name = get_name(bank, NULL);
@@ -1323,7 +1351,7 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
 			if (err)
 				goto out;
 
-			per_cpu(threshold_banks, cpu)[bank] = b;
+			bp[bank] = b;
 			refcount_inc(&b->cpus);
 
 			err = __threshold_add_blocks(b);
@@ -1338,6 +1366,7 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
 		goto out;
 	}
 
+	/* Associate the bank with the per-CPU MCE device */
 	b->kobj = kobject_create_and_add(name, &dev->kobj);
 	if (!b->kobj) {
 		err = -EINVAL;
@@ -1345,6 +1374,7 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
 	}
 
 	if (is_shared_bank(bank)) {
+		b->shared = 1;
 		refcount_set(&b->cpus, 1);
 
 		/* nb is already initialized, see above */
@@ -1356,16 +1386,16 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
 
 	err = allocate_threshold_blocks(cpu, b, bank, 0, msr_ops.misc(bank));
 	if (err)
-		goto out_free;
-
-	per_cpu(threshold_banks, cpu)[bank] = b;
+		goto out_kobj;
 
+	bp[bank] = b;
 	return 0;
 
- out_free:
+out_kobj:
+	kobject_put(b->kobj);
+out_free:
 	kfree(b);
-
- out:
+out:
 	return err;
 }
 
@@ -1374,21 +1404,16 @@ static void threshold_block_release(struct kobject *kobj)
 	kfree(to_block(kobj));
 }
 
-static void deallocate_threshold_block(unsigned int cpu, unsigned int bank)
+static void deallocate_threshold_blocks(struct threshold_bank *bank)
 {
-	struct threshold_block *pos = NULL;
-	struct threshold_block *tmp = NULL;
-	struct threshold_bank *head = per_cpu(threshold_banks, cpu)[bank];
+	struct threshold_block *pos, *tmp;
 
-	if (!head)
-		return;
-
-	list_for_each_entry_safe(pos, tmp, &head->blocks->miscj, miscj) {
+	list_for_each_entry_safe(pos, tmp, &bank->blocks->miscj, miscj) {
 		list_del(&pos->miscj);
 		kobject_put(&pos->kobj);
 	}
 
-	kobject_put(&head->blocks->kobj);
+	kobject_put(&bank->blocks->kobj);
 }
 
 static void __threshold_remove_blocks(struct threshold_bank *b)
@@ -1402,122 +1427,102 @@ static void __threshold_remove_blocks(struct threshold_bank *b)
 		kobject_del(&pos->kobj);
 }
 
-static void threshold_remove_bank(unsigned int cpu, int bank)
+static void threshold_remove_bank(struct threshold_bank *bank)
 {
 	struct amd_northbridge *nb;
-	struct threshold_bank *b;
 
-	b = per_cpu(threshold_banks, cpu)[bank];
-	if (!b)
-		return;
+	if (!bank->blocks)
+		goto out_free;
 
-	if (!b->blocks)
-		goto free_out;
+	if (!bank->shared)
+		goto out_dealloc;
 
-	if (is_shared_bank(bank)) {
-		if (!refcount_dec_and_test(&b->cpus)) {
-			__threshold_remove_blocks(b);
-			per_cpu(threshold_banks, cpu)[bank] = NULL;
-			return;
-		} else {
-			/*
-			 * the last CPU on this node using the shared bank is
-			 * going away, remove that bank now.
-			 */
-			nb = node_to_amd_nb(amd_get_nb_id(cpu));
-			nb->bank4 = NULL;
-		}
+	if (!refcount_dec_and_test(&bank->cpus)) {
+		__threshold_remove_blocks(bank);
+		return;
+	} else {
+		/*
+		 * The last CPU on this node using the shared bank is going
+		 * away, remove that bank now.
+		 */
+		nb = node_to_amd_nb(amd_get_nb_id(smp_processor_id()));
+		nb->bank4 = NULL;
 	}
 
-	deallocate_threshold_block(cpu, bank);
+out_dealloc:
+	deallocate_threshold_blocks(bank);
 
-free_out:
-	kobject_del(b->kobj);
-	kobject_put(b->kobj);
-	kfree(b);
-	per_cpu(threshold_banks, cpu)[bank] = NULL;
+out_free:
+	kobject_put(bank->kobj);
+	kfree(bank);
 }
 
 int mce_threshold_remove_device(unsigned int cpu)
 {
-	unsigned int bank;
+	struct threshold_bank **bp = this_cpu_read(threshold_banks);
+	unsigned int bank, numbanks = this_cpu_read(mce_num_banks);
 
-	for (bank = 0; bank < per_cpu(mce_num_banks, cpu); ++bank) {
-		if (!(per_cpu(bank_map, cpu) & (1 << bank)))
-			continue;
-		threshold_remove_bank(cpu, bank);
+	if (!bp)
+		return 0;
+
+	/*
+	 * Clear the pointer before cleaning up, so that the interrupt won't
+	 * touch anything of this.
+	 */
+	this_cpu_write(threshold_banks, NULL);
+
+	for (bank = 0; bank < numbanks; bank++) {
+		if (bp[bank]) {
+			threshold_remove_bank(bp[bank]);
+			bp[bank] = NULL;
+		}
 	}
-	kfree(per_cpu(threshold_banks, cpu));
-	per_cpu(threshold_banks, cpu) = NULL;
+	kfree(bp);
 	return 0;
 }
 
-/* create dir/files for all valid threshold banks */
+/**
+ * mce_threshold_create_device - Create the per-CPU MCE threshold device
+ * @cpu:	The plugged in CPU
+ *
+ * Create directories and files for all valid threshold banks.
+ *
+ * This is invoked from the CPU hotplug callback which was installed in
+ * mcheck_init_device(). The invocation happens in context of the hotplug
+ * thread running on @cpu.  The callback is invoked on all CPUs which are
+ * online when the callback is installed or during a real hotplug event.
+ */
 int mce_threshold_create_device(unsigned int cpu)
 {
-	unsigned int bank;
+	unsigned int numbanks, bank;
 	struct threshold_bank **bp;
-	int err = 0;
+	int err;
 
-	bp = per_cpu(threshold_banks, cpu);
+	if (!mce_flags.amd_threshold)
+		return 0;
+
+	bp = this_cpu_read(threshold_banks);
 	if (bp)
 		return 0;
 
-	bp = kcalloc(per_cpu(mce_num_banks, cpu), sizeof(struct threshold_bank *),
-		     GFP_KERNEL);
+	numbanks = this_cpu_read(mce_num_banks);
+	bp = kcalloc(numbanks, sizeof(*bp), GFP_KERNEL);
 	if (!bp)
 		return -ENOMEM;
 
-	per_cpu(threshold_banks, cpu) = bp;
-
-	for (bank = 0; bank < per_cpu(mce_num_banks, cpu); ++bank) {
-		if (!(per_cpu(bank_map, cpu) & (1 << bank)))
+	for (bank = 0; bank < numbanks; ++bank) {
+		if (!(this_cpu_read(bank_map) & (1 << bank)))
 			continue;
-		err = threshold_create_bank(cpu, bank);
+		err = threshold_create_bank(bp, cpu, bank);
 		if (err)
-			goto err;
-	}
-	return err;
-err:
-	mce_threshold_remove_device(cpu);
-	return err;
-}
-
-static __init int threshold_init_device(void)
-{
-	unsigned lcpu = 0;
-
-	/* to hit CPUs online before the notifier is up */
-	for_each_online_cpu(lcpu) {
-		int err = mce_threshold_create_device(lcpu);
-
-		if (err)
-			return err;
+			goto out_err;
 	}
+	this_cpu_write(threshold_banks, bp);
 
 	if (thresholding_irq_en)
 		mce_threshold_vector = amd_threshold_interrupt;
-
 	return 0;
+out_err:
+	mce_threshold_remove_device(cpu);
+	return err;
 }
-/*
- * there are 3 funcs which need to be _initcalled in a logic sequence:
- * 1. xen_late_init_mcelog
- * 2. mcheck_init_device
- * 3. threshold_init_device
- *
- * xen_late_init_mcelog must register xen_mce_chrdev_device before
- * native mce_chrdev_device registration if running under xen platform;
- *
- * mcheck_init_device should be inited before threshold_init_device to
- * initialize mce_device, otherwise a NULL ptr dereference will cause panic.
- *
- * so we use following _initcalls
- * 1. device_initcall(xen_late_init_mcelog);
- * 2. device_initcall_sync(mcheck_init_device);
- * 3. late_initcall(threshold_init_device);
- *
- * when running under xen, the initcall order is 1,2,3;
- * on baremetal, we skip 1 and we do only 2 and 3.
- */
-late_initcall(threshold_init_device);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b9cb381b4019..ce9120c4f740 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -160,29 +160,17 @@ void mce_log(struct mce *m)
 }
 EXPORT_SYMBOL_GPL(mce_log);
 
-/*
- * We run the default notifier if we have only the UC, the first and the
- * default notifier registered. I.e., the mandatory NUM_DEFAULT_NOTIFIERS
- * notifiers registered on the chain.
- */
-#define NUM_DEFAULT_NOTIFIERS	3
-static atomic_t num_notifiers;
-
 void mce_register_decode_chain(struct notifier_block *nb)
 {
 	if (WARN_ON(nb->priority > MCE_PRIO_MCELOG && nb->priority < MCE_PRIO_EDAC))
 		return;
 
-	atomic_inc(&num_notifiers);
-
 	blocking_notifier_chain_register(&x86_mce_decoder_chain, nb);
 }
 EXPORT_SYMBOL_GPL(mce_register_decode_chain);
 
 void mce_unregister_decode_chain(struct notifier_block *nb)
 {
-	atomic_dec(&num_notifiers);
-
 	blocking_notifier_chain_unregister(&x86_mce_decoder_chain, nb);
 }
 EXPORT_SYMBOL_GPL(mce_unregister_decode_chain);
@@ -265,6 +253,7 @@ static void __print_mce(struct mce *m)
 	}
 
 	pr_cont("\n");
+
 	/*
 	 * Note this output is parsed by external tools and old fields
 	 * should not be changed.
@@ -531,6 +520,14 @@ bool mce_is_memory_error(struct mce *m)
 }
 EXPORT_SYMBOL_GPL(mce_is_memory_error);
 
+static bool whole_page(struct mce *m)
+{
+	if (!mca_cfg.ser || !(m->status & MCI_STATUS_MISCV))
+		return true;
+
+	return MCI_MISC_ADDR_LSB(m->misc) >= PAGE_SHIFT;
+}
+
 bool mce_is_correctable(struct mce *m)
 {
 	if (m->cpuvendor == X86_VENDOR_AMD && m->status & MCI_STATUS_DEFERRED)
@@ -546,22 +543,7 @@ bool mce_is_correctable(struct mce *m)
 }
 EXPORT_SYMBOL_GPL(mce_is_correctable);
 
-static bool cec_add_mce(struct mce *m)
-{
-	if (!m)
-		return false;
-
-	/* We eat only correctable DRAM errors with usable addresses. */
-	if (mce_is_memory_error(m) &&
-	    mce_is_correctable(m)  &&
-	    mce_usable_address(m))
-		if (!cec_add_elem(m->addr >> PAGE_SHIFT))
-			return true;
-
-	return false;
-}
-
-static int mce_first_notifier(struct notifier_block *nb, unsigned long val,
+static int mce_early_notifier(struct notifier_block *nb, unsigned long val,
 			      void *data)
 {
 	struct mce *m = (struct mce *)data;
@@ -569,9 +551,6 @@ static int mce_first_notifier(struct notifier_block *nb, unsigned long val,
 	if (!m)
 		return NOTIFY_DONE;
 
-	if (cec_add_mce(m))
-		return NOTIFY_STOP;
-
 	/* Emit the trace record: */
 	trace_mce_record(m);
 
@@ -582,9 +561,9 @@ static int mce_first_notifier(struct notifier_block *nb, unsigned long val,
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block first_nb = {
-	.notifier_call	= mce_first_notifier,
-	.priority	= MCE_PRIO_FIRST,
+static struct notifier_block early_nb = {
+	.notifier_call	= mce_early_notifier,
+	.priority	= MCE_PRIO_EARLY,
 };
 
 static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
@@ -601,8 +580,10 @@ static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
 		return NOTIFY_DONE;
 
 	pfn = mce->addr >> PAGE_SHIFT;
-	if (!memory_failure(pfn, 0))
-		set_mce_nospec(pfn);
+	if (!memory_failure(pfn, 0)) {
+		set_mce_nospec(pfn, whole_page(mce));
+		mce->kflags |= MCE_HANDLED_UC;
+	}
 
 	return NOTIFY_OK;
 }
@@ -620,10 +601,8 @@ static int mce_default_notifier(struct notifier_block *nb, unsigned long val,
 	if (!m)
 		return NOTIFY_DONE;
 
-	if (atomic_read(&num_notifiers) > NUM_DEFAULT_NOTIFIERS)
-		return NOTIFY_DONE;
-
-	__print_mce(m);
+	if (mca_cfg.print_all || !m->kflags)
+		__print_mce(m);
 
 	return NOTIFY_DONE;
 }
@@ -1202,11 +1181,12 @@ static void kill_me_maybe(struct callback_head *cb)
 	int flags = MF_ACTION_REQUIRED;
 
 	pr_err("Uncorrected hardware memory error in user-access at %llx", p->mce_addr);
-	if (!(p->mce_status & MCG_STATUS_RIPV))
+
+	if (!p->mce_ripv)
 		flags |= MF_MUST_KILL;
 
 	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags)) {
-		set_mce_nospec(p->mce_addr >> PAGE_SHIFT);
+		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
 		return;
 	}
 
@@ -1360,14 +1340,26 @@ void noinstr do_machine_check(struct pt_regs *regs)
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
 
 		current->mce_addr = m.addr;
-		current->mce_status = m.mcgstatus;
+		current->mce_ripv = !!(m.mcgstatus & MCG_STATUS_RIPV);
+		current->mce_whole_page = whole_page(&m);
 		current->mce_kill_me.func = kill_me_maybe;
 		if (kill_it)
 			current->mce_kill_me.func = kill_me_now;
 		task_work_add(current, &current->mce_kill_me, true);
 	} else {
-		if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
-			mce_panic("Failed kernel mode recovery", &m, msg);
+		/*
+		 * Handle an MCE which has happened in kernel space but from
+		 * which the kernel can recover: ex_has_fault_handler() has
+		 * already verified that the rIP at which the error happened is
+		 * a rIP from which the kernel can recover (by jumping to
+		 * recovery code specified in _ASM_EXTABLE_FAULT()) and the
+		 * corresponding exception handler which would do that is the
+		 * proper one.
+		 */
+		if (m.kflags & MCE_IN_KERNEL_RECOV) {
+			if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
+				mce_panic("Failed kernel mode recovery", &m, msg);
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(do_machine_check);
@@ -1758,6 +1750,7 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 		mce_flags.overflow_recov = !!cpu_has(c, X86_FEATURE_OVERFLOW_RECOV);
 		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
 		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
+		mce_flags.amd_threshold	 = 1;
 
 		if (mce_flags.smca) {
 			msr_ops.ctl	= smca_ctl_reg;
@@ -2055,6 +2048,7 @@ void mce_disable_bank(int bank)
  * mce=no_cmci Disables CMCI
  * mce=no_lmce Disables LMCE
  * mce=dont_log_ce Clears corrected events silently, no log created for CEs.
+ * mce=print_all Print all machine check logs to console
  * mce=ignore_ce Disables polling and CMCI, corrected events are not cleared.
  * mce=TOLERANCELEVEL[,monarchtimeout] (number, see above)
  *	monarchtimeout is how long to wait for other CPUs on machine
@@ -2083,6 +2077,8 @@ static int __init mcheck_enable(char *str)
 		cfg->lmce_disabled = 1;
 	else if (!strcmp(str, "dont_log_ce"))
 		cfg->dont_log_ce = true;
+	else if (!strcmp(str, "print_all"))
+		cfg->print_all = true;
 	else if (!strcmp(str, "ignore_ce"))
 		cfg->ignore_ce = true;
 	else if (!strcmp(str, "bootlog") || !strcmp(str, "nobootlog"))
@@ -2105,7 +2101,7 @@ __setup("mce", mcheck_enable);
 int __init mcheck_init(void)
 {
 	mcheck_intel_therm_init();
-	mce_register_decode_chain(&first_nb);
+	mce_register_decode_chain(&early_nb);
 	mce_register_decode_chain(&mce_uc_nb);
 	mce_register_decode_chain(&mce_default_nb);
 	mcheck_vendor_init_severity();
@@ -2349,6 +2345,7 @@ static ssize_t store_int_with_restart(struct device *s,
 static DEVICE_INT_ATTR(tolerant, 0644, mca_cfg.tolerant);
 static DEVICE_INT_ATTR(monarch_timeout, 0644, mca_cfg.monarch_timeout);
 static DEVICE_BOOL_ATTR(dont_log_ce, 0644, mca_cfg.dont_log_ce);
+static DEVICE_BOOL_ATTR(print_all, 0644, mca_cfg.print_all);
 
 static struct dev_ext_attribute dev_attr_check_interval = {
 	__ATTR(check_interval, 0644, device_show_int, store_int_with_restart),
@@ -2373,6 +2370,7 @@ static struct device_attribute *mce_device_attrs[] = {
 #endif
 	&dev_attr_monarch_timeout.attr,
 	&dev_attr_dont_log_ce.attr,
+	&dev_attr_print_all.attr,
 	&dev_attr_ignore_ce.attr,
 	&dev_attr_cmci_disabled.attr,
 	NULL
@@ -2545,6 +2543,13 @@ static __init void mce_init_banks(void)
 	}
 }
 
+/*
+ * When running on XEN, this initcall is ordered against the XEN mcelog
+ * initcall:
+ *
+ *   device_initcall(xen_late_init_mcelog);
+ *   device_initcall_sync(mcheck_init_device);
+ */
 static __init int mcheck_init_device(void)
 {
 	int err;
@@ -2576,6 +2581,10 @@ static __init int mcheck_init_device(void)
 	if (err)
 		goto err_out_mem;
 
+	/*
+	 * Invokes mce_cpu_online() on all CPUs which are online when
+	 * the state is installed.
+	 */
 	err = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/mce:online",
 				mce_cpu_online, mce_cpu_pre_down);
 	if (err < 0)
@@ -2665,7 +2674,6 @@ static int __init mcheck_late_init(void)
 		static_branch_inc(&mcsafe_key);
 
 	mcheck_debugfs_init();
-	cec_init();
 
 	/*
 	 * Flush out everything that has been logged during early boot, now that
diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index d089567a9ce8..43c466020ed5 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -39,6 +39,9 @@ static int dev_mce_log(struct notifier_block *nb, unsigned long val,
 	struct mce *mce = (struct mce *)data;
 	unsigned int entry;
 
+	if (mce->kflags & MCE_HANDLED_CEC)
+		return NOTIFY_DONE;
+
 	mutex_lock(&mce_chrdev_read_mutex);
 
 	entry = mcelog->next;
@@ -56,6 +59,7 @@ static int dev_mce_log(struct notifier_block *nb, unsigned long val,
 
 	memcpy(mcelog->entry + entry, mce, sizeof(struct mce));
 	mcelog->entry[entry].finished = 1;
+	mcelog->entry[entry].kflags = 0;
 
 	/* wake processes polling /dev/mcelog */
 	wake_up_interruptible(&mce_chrdev_wait);
@@ -63,6 +67,7 @@ static int dev_mce_log(struct notifier_block *nb, unsigned long val,
 unlock:
 	mutex_unlock(&mce_chrdev_read_mutex);
 
+	mce->kflags |= MCE_HANDLED_MCELOG;
 	return NOTIFY_OK;
 }
 
@@ -324,6 +329,7 @@ static const struct file_operations mce_chrdev_ops = {
 	.write			= mce_chrdev_write,
 	.poll			= mce_chrdev_poll,
 	.unlocked_ioctl		= mce_chrdev_ioctl,
+	.compat_ioctl		= compat_ptr_ioctl,
 	.llseek			= no_llseek,
 };
 
@@ -343,7 +349,7 @@ static __init int dev_mcelog_init_device(void)
 	if (!mcelog)
 		return -ENOMEM;
 
-	strncpy(mcelog->signature, MCE_LOG_SIGNATURE, sizeof(mcelog->signature));
+	memcpy(mcelog->signature, MCE_LOG_SIGNATURE, sizeof(mcelog->signature));
 	mcelog->len = mce_log_len;
 	mcelog->recordlen = sizeof(struct mce);
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index b74ca4a28c66..6473070b5da4 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -119,6 +119,7 @@ struct mca_config {
 	bool dont_log_ce;
 	bool cmci_disabled;
 	bool ignore_ce;
+	bool print_all;
 
 	__u64 lmce_disabled		: 1,
 	      disabled			: 1,
@@ -148,7 +149,7 @@ struct mce_vendor_flags {
 	 * Recovery. It indicates support for data poisoning in HW and deferred
 	 * error interrupts.
 	 */
-	      succor		: 1,
+	succor			: 1,
 
 	/*
 	 * (AMD) SMCA: This bit indicates support for Scalable MCA which expands
@@ -156,9 +157,12 @@ struct mce_vendor_flags {
 	 * banks. Also, to accommodate the new banks and registers, the MCA
 	 * register space is moved to a new MSR range.
 	 */
-	      smca		: 1,
+	smca			: 1,
 
-	      __reserved_0	: 61;
+	/* AMD-style error thresholding banks present. */
+	amd_threshold		: 1,
+
+	__reserved_0		: 60;
 };
 
 extern struct mce_vendor_flags mce_flags;
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 87bcdc6dc2f0..e1da619add19 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -213,8 +213,12 @@ static int error_context(struct mce *m)
 {
 	if ((m->cs & 3) == 3)
 		return IN_USER;
-	if (mc_recoverable(m->mcgstatus) && ex_has_fault_handler(m->ip))
+
+	if (mc_recoverable(m->mcgstatus) && ex_has_fault_handler(m->ip)) {
+		m->kflags |= MCE_IN_KERNEL_RECOV;
 		return IN_KERNEL_RECOV;
+	}
+
 	return IN_KERNEL;
 }
 
diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 8596a106a933..f138e12b7b82 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -42,8 +42,6 @@ struct extlog_l1_head {
 	u8  rev1[12];
 };
 
-static int old_edac_report_status;
-
 static u8 extlog_dsm_uuid[] __initdata = "663E35AF-CC10-41A4-88EA-5470AF055295";
 
 /* L1 table related physical address */
@@ -146,7 +144,7 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 	static u32 err_seq;
 
 	estatus = extlog_elog_entry_check(cpu, bank);
-	if (estatus == NULL)
+	if (estatus == NULL || (mce->kflags & MCE_HANDLED_CEC))
 		return NOTIFY_DONE;
 
 	memcpy(elog_buf, (void *)estatus, ELOG_ENTRY_LEN);
@@ -176,7 +174,8 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 	}
 
 out:
-	return NOTIFY_STOP;
+	mce->kflags |= MCE_HANDLED_EXTLOG;
+	return NOTIFY_OK;
 }
 
 static bool __init extlog_get_l1addr(void)
@@ -228,11 +227,6 @@ static int __init extlog_init(void)
 	if (!(cap & MCG_ELOG_P) || !extlog_get_l1addr())
 		return -ENODEV;
 
-	if (edac_get_report_status() == EDAC_REPORTING_FORCE) {
-		pr_warn("Not loading eMCA, error reporting force-enabled through EDAC.\n");
-		return -EPERM;
-	}
-
 	rc = -EINVAL;
 	/* get L1 header to fetch necessary information */
 	l1_hdr_size = sizeof(struct extlog_l1_head);
@@ -280,12 +274,6 @@ static int __init extlog_init(void)
 	if (elog_buf == NULL)
 		goto err_release_elog;
 
-	/*
-	 * eMCA event report method has higher priority than EDAC method,
-	 * unless EDAC event report method is mandatory.
-	 */
-	old_edac_report_status = edac_get_report_status();
-	edac_set_report_status(EDAC_REPORTING_DISABLED);
 	mce_register_decode_chain(&extlog_mce_dec);
 	/* enable OS to be involved to take over management from BIOS */
 	((struct extlog_l1_head *)extlog_l1_addr)->flags |= FLAG_OS_OPTIN;
@@ -307,7 +295,6 @@ static int __init extlog_init(void)
 
 static void __exit extlog_exit(void)
 {
-	edac_set_report_status(old_edac_report_status);
 	mce_unregister_decode_chain(&extlog_mce_dec);
 	((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
 	if (extlog_l1_addr)
diff --git a/drivers/acpi/nfit/mce.c b/drivers/acpi/nfit/mce.c
index f0ae48515b48..ee8d9973f60b 100644
--- a/drivers/acpi/nfit/mce.c
+++ b/drivers/acpi/nfit/mce.c
@@ -76,6 +76,7 @@ static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
 			 */
 			acpi_nfit_ars_rescan(acpi_desc, 0);
 		}
+		mce->kflags |= MCE_HANDLED_NFIT;
 		break;
 	}
 
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 9cf7cc1f3f72..ef90070a9194 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4,9 +4,6 @@
 
 static struct edac_pci_ctl_info *pci_ctl;
 
-static int report_gart_errors;
-module_param(report_gart_errors, int, 0644);
-
 /*
  * Set by command line parameter. If BIOS has enabled the ECC, this override is
  * cleared to prevent re-enabling the hardware by this driver.
@@ -2319,6 +2316,16 @@ static struct amd64_family_type family_types[] = {
 			.dbam_to_cs		= f17_addr_mask_to_cs_size,
 		}
 	},
+	[F17_M60H_CPUS] = {
+		.ctl_name = "F17h_M60h",
+		.f0_id = PCI_DEVICE_ID_AMD_17H_M60H_DF_F0,
+		.f6_id = PCI_DEVICE_ID_AMD_17H_M60H_DF_F6,
+		.max_mcs = 2,
+		.ops = {
+			.early_channel_count	= f17_early_channel_count,
+			.dbam_to_cs		= f17_addr_mask_to_cs_size,
+		}
+	},
 	[F17_M70H_CPUS] = {
 		.ctl_name = "F17h_M70h",
 		.f0_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F0,
@@ -3357,6 +3364,10 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 			fam_type = &family_types[F17_M30H_CPUS];
 			pvt->ops = &family_types[F17_M30H_CPUS].ops;
 			break;
+		} else if (pvt->model >= 0x60 && pvt->model <= 0x6f) {
+			fam_type = &family_types[F17_M60H_CPUS];
+			pvt->ops = &family_types[F17_M60H_CPUS].ops;
+			break;
 		} else if (pvt->model >= 0x70 && pvt->model <= 0x7f) {
 			fam_type = &family_types[F17_M70H_CPUS];
 			pvt->ops = &family_types[F17_M70H_CPUS].ops;
@@ -3681,9 +3692,6 @@ static int __init amd64_edac_init(void)
 	}
 
 	/* register stuff with EDAC MCE */
-	if (report_gart_errors)
-		amd_report_gart_errors(true);
-
 	if (boot_cpu_data.x86 >= 0x17)
 		amd_register_ecc_decoder(decode_umc_error);
 	else
@@ -3718,8 +3726,6 @@ static void __exit amd64_edac_exit(void)
 		edac_pci_release_generic_ctl(pci_ctl);
 
 	/* unregister from EDAC MCE */
-	amd_report_gart_errors(false);
-
 	if (boot_cpu_data.x86 >= 0x17)
 		amd_unregister_ecc_decoder(decode_umc_error);
 	else
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index abbf3c274d74..52b5d03eeba0 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -120,6 +120,8 @@
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F6 0x15ee
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F0 0x1490
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F6 0x1496
+#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F0 0x1448
+#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F6 0x144e
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F0 0x1440
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F6 0x1446
 #define PCI_DEVICE_ID_AMD_19H_DF_F0	0x1650
@@ -293,6 +295,7 @@ enum amd_families {
 	F17_CPUS,
 	F17_M10H_CPUS,
 	F17_M30H_CPUS,
+	F17_M60H_CPUS,
 	F17_M70H_CPUS,
 	F19_CPUS,
 	NUM_FAMILIES,
diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 75ede27bdf6a..5813e931f2f0 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -43,8 +43,6 @@
 int edac_op_state = EDAC_OPSTATE_INVAL;
 EXPORT_SYMBOL_GPL(edac_op_state);
 
-static int edac_report = EDAC_REPORTING_ENABLED;
-
 /* lock to memory controller's control array */
 static DEFINE_MUTEX(mem_ctls_mutex);
 static LIST_HEAD(mc_devices);
@@ -60,65 +58,6 @@ static struct mem_ctl_info *error_desc_to_mci(struct edac_raw_error_desc *e)
 	return container_of(e, struct mem_ctl_info, error_desc);
 }
 
-int edac_get_report_status(void)
-{
-	return edac_report;
-}
-EXPORT_SYMBOL_GPL(edac_get_report_status);
-
-void edac_set_report_status(int new)
-{
-	if (new == EDAC_REPORTING_ENABLED ||
-	    new == EDAC_REPORTING_DISABLED ||
-	    new == EDAC_REPORTING_FORCE)
-		edac_report = new;
-}
-EXPORT_SYMBOL_GPL(edac_set_report_status);
-
-static int edac_report_set(const char *str, const struct kernel_param *kp)
-{
-	if (!str)
-		return -EINVAL;
-
-	if (!strncmp(str, "on", 2))
-		edac_report = EDAC_REPORTING_ENABLED;
-	else if (!strncmp(str, "off", 3))
-		edac_report = EDAC_REPORTING_DISABLED;
-	else if (!strncmp(str, "force", 5))
-		edac_report = EDAC_REPORTING_FORCE;
-
-	return 0;
-}
-
-static int edac_report_get(char *buffer, const struct kernel_param *kp)
-{
-	int ret = 0;
-
-	switch (edac_report) {
-	case EDAC_REPORTING_ENABLED:
-		ret = sprintf(buffer, "on");
-		break;
-	case EDAC_REPORTING_DISABLED:
-		ret = sprintf(buffer, "off");
-		break;
-	case EDAC_REPORTING_FORCE:
-		ret = sprintf(buffer, "force");
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
-static const struct kernel_param_ops edac_report_ops = {
-	.set = edac_report_set,
-	.get = edac_report_get,
-};
-
-module_param_cb(edac_report, &edac_report_ops, &edac_report, 0644);
-
 unsigned int edac_dimm_info_location(struct dimm_info *dimm, char *buf,
 				     unsigned int len)
 {
diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index b3135b208f9a..5860ca41185c 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -1815,7 +1815,7 @@ static int i7core_mce_check_error(struct notifier_block *nb, unsigned long val,
 	struct mem_ctl_info *mci;
 
 	i7_dev = get_i7core_dev(mce->socketid);
-	if (!i7_dev)
+	if (!i7_dev || (mce->kflags & MCE_HANDLED_CEC))
 		return NOTIFY_DONE;
 
 	mci = i7_dev->mci;
@@ -1834,7 +1834,8 @@ static int i7core_mce_check_error(struct notifier_block *nb, unsigned long val,
 	i7core_check_error(mci, mce);
 
 	/* Advise mcelog that the errors were handled */
-	return NOTIFY_STOP;
+	mce->kflags |= MCE_HANDLED_EDAC;
+	return NOTIFY_OK;
 }
 
 static struct notifier_block i7_mce_dec = {
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 8874b7722b2f..2b5401db56ad 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -10,15 +10,8 @@ static struct amd_decoder_ops fam_ops;
 
 static u8 xec_mask	 = 0xf;
 
-static bool report_gart_errors;
 static void (*decode_dram_ecc)(int node_id, struct mce *m);
 
-void amd_report_gart_errors(bool v)
-{
-	report_gart_errors = v;
-}
-EXPORT_SYMBOL_GPL(amd_report_gart_errors);
-
 void amd_register_ecc_decoder(void (*f)(int, struct mce *))
 {
 	decode_dram_ecc = f;
@@ -1030,20 +1023,6 @@ static inline void amd_decode_err_code(u16 ec)
 	pr_cont("\n");
 }
 
-/*
- * Filter out unwanted MCE signatures here.
- */
-static bool ignore_mce(struct mce *m)
-{
-	/*
-	 * NB GART TLB error reporting is disabled by default.
-	 */
-	if (m->bank == 4 && XEC(m->status, 0x1f) == 0x5 && !report_gart_errors)
-		return true;
-
-	return false;
-}
-
 static const char *decode_error_status(struct mce *m)
 {
 	if (m->status & MCI_STATUS_UC) {
@@ -1067,8 +1046,8 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	unsigned int fam = x86_family(m->cpuid);
 	int ecc;
 
-	if (ignore_mce(m))
-		return NOTIFY_STOP;
+	if (m->kflags & MCE_HANDLED_CEC)
+		return NOTIFY_DONE;
 
 	pr_emerg(HW_ERR "%s\n", decode_error_status(m));
 
@@ -1170,7 +1149,8 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
  err_code:
 	amd_decode_err_code(m->status & 0xffff);
 
-	return NOTIFY_STOP;
+	m->kflags |= MCE_HANDLED_EDAC;
+	return NOTIFY_OK;
 }
 
 static struct notifier_block amd_mce_dec_nb = {
diff --git a/drivers/edac/mce_amd.h b/drivers/edac/mce_amd.h
index 4e9c5e596c6c..4811b18d9606 100644
--- a/drivers/edac/mce_amd.h
+++ b/drivers/edac/mce_amd.h
@@ -7,7 +7,6 @@
 #include <asm/mce.h>
 
 #define EC(x)				((x) & 0xffff)
-#define XEC(x, mask)			(((x) >> 16) & mask)
 
 #define LOW_SYNDROME(x)			(((x) >> 15) & 0xff)
 #define HIGH_SYNDROME(x)		(((x) >> 24) & 0xff)
@@ -77,7 +76,6 @@ struct amd_decoder_ops {
 	bool (*mc2_mce)(u16, u8);
 };
 
-void amd_report_gart_errors(bool);
 void amd_register_ecc_decoder(void (*f)(int, struct mce *));
 void amd_unregister_ecc_decoder(void (*f)(int, struct mce *));
 
diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index bc47328eb485..c1f2e6deb021 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1396,11 +1396,8 @@ static int pnd2_mce_check_error(struct notifier_block *nb, unsigned long val, vo
 	struct dram_addr daddr;
 	char *type;
 
-	if (edac_get_report_status() == EDAC_REPORTING_DISABLED)
-		return NOTIFY_DONE;
-
 	mci = pnd2_mci;
-	if (!mci)
+	if (!mci || (mce->kflags & MCE_HANDLED_CEC))
 		return NOTIFY_DONE;
 
 	/*
@@ -1429,7 +1426,8 @@ static int pnd2_mce_check_error(struct notifier_block *nb, unsigned long val, vo
 	pnd2_mce_output_error(mci, mce, &daddr);
 
 	/* Advice mcelog that the error were handled */
-	return NOTIFY_STOP;
+	mce->kflags |= MCE_HANDLED_EDAC;
+	return NOTIFY_OK;
 }
 
 static struct notifier_block pnd2_mce_dec = {
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 7d51c82be62b..d414698ca324 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -3134,7 +3134,7 @@ static int sbridge_mce_check_error(struct notifier_block *nb, unsigned long val,
 	struct mem_ctl_info *mci;
 	char *type;
 
-	if (edac_get_report_status() == EDAC_REPORTING_DISABLED)
+	if (mce->kflags & MCE_HANDLED_CEC)
 		return NOTIFY_DONE;
 
 	/*
@@ -3183,7 +3183,8 @@ static int sbridge_mce_check_error(struct notifier_block *nb, unsigned long val,
 	sbridge_mce_output_error(mci, mce);
 
 	/* Advice mcelog that the error were handled */
-	return NOTIFY_STOP;
+	mce->kflags |= MCE_HANDLED_EDAC;
+	return NOTIFY_OK;
 }
 
 static struct notifier_block sbridge_mce_dec = {
@@ -3523,8 +3524,6 @@ static int __init sbridge_init(void)
 
 	if (rc >= 0) {
 		mce_register_decode_chain(&sbridge_mce_dec);
-		if (edac_get_report_status() == EDAC_REPORTING_DISABLED)
-			sbridge_printk(KERN_WARNING, "Loading driver, error reporting disabled.\n");
 		return 0;
 	}
 
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 46be1a77bd1d..6d8d6dc626bf 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -573,7 +573,7 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 	struct mem_ctl_info *mci;
 	char *type;
 
-	if (edac_get_report_status() == EDAC_REPORTING_DISABLED)
+	if (mce->kflags & MCE_HANDLED_CEC)
 		return NOTIFY_DONE;
 
 	/* ignore unless this is memory related with an address */
@@ -615,6 +615,7 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 
 	skx_mce_output_error(mci, mce, &res);
 
+	mce->kflags |= MCE_HANDLED_EDAC;
 	return NOTIFY_DONE;
 }
 
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 9915578533bb..8f12995ec133 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -632,6 +632,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index c09cf55e2d20..569d9ad2c594 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -309,7 +309,7 @@ static bool sanity_check(struct ce_array *ca)
 	return ret;
 }
 
-int cec_add_elem(u64 pfn)
+static int cec_add_elem(u64 pfn)
 {
 	struct ce_array *ca = &ce_arr;
 	unsigned int to = 0;
@@ -527,7 +527,33 @@ static int __init create_debugfs_nodes(void)
 	return 1;
 }
 
-void __init cec_init(void)
+static int cec_notifier(struct notifier_block *nb, unsigned long val,
+			void *data)
+{
+	struct mce *m = (struct mce *)data;
+
+	if (!m)
+		return NOTIFY_DONE;
+
+	/* We eat only correctable DRAM errors with usable addresses. */
+	if (mce_is_memory_error(m) &&
+	    mce_is_correctable(m)  &&
+	    mce_usable_address(m)) {
+		if (!cec_add_elem(m->addr >> PAGE_SHIFT)) {
+			m->kflags |= MCE_HANDLED_CEC;
+			return NOTIFY_OK;
+		}
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block cec_nb = {
+	.notifier_call	= cec_notifier,
+	.priority	= MCE_PRIO_CEC,
+};
+
+static void __init cec_init(void)
 {
 	if (ce_arr.disabled)
 		return;
@@ -546,8 +572,11 @@ void __init cec_init(void)
 	INIT_DELAYED_WORK(&cec_work, cec_work_fn);
 	schedule_delayed_work(&cec_work, CEC_DECAY_DEFAULT_INTERVAL);
 
+	mce_register_decode_chain(&cec_nb);
+
 	pr_info("Correctable Errors collector initialized.\n");
 }
+late_initcall(cec_init);
 
 int __init parse_cec_param(char *str)
 {
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 0f20b986b0ab..6eb7d55d7c3d 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -31,14 +31,6 @@ struct device;
 extern int edac_op_state;
 
 struct bus_type *edac_get_sysfs_subsys(void);
-int edac_get_report_status(void);
-void edac_set_report_status(int new);
-
-enum {
-	EDAC_REPORTING_ENABLED,
-	EDAC_REPORTING_DISABLED,
-	EDAC_REPORTING_FORCE
-};
 
 static inline void opstate_init(void)
 {
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 9a57e6717e5c..0ad57693f392 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -550,6 +550,7 @@
 #define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
+#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
 #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
diff --git a/include/linux/ras.h b/include/linux/ras.h
index 7c3debb47c87..1f4048bf2674 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -17,12 +17,7 @@ static inline int ras_add_daemon_trace(void) { return 0; }
 #endif
 
 #ifdef CONFIG_RAS_CEC
-void __init cec_init(void);
 int __init parse_cec_param(char *str);
-int cec_add_elem(u64 pfn);
-#else
-static inline void __init cec_init(void)	{ }
-static inline int cec_add_elem(u64 pfn)		{ return -ENODEV; }
 #endif
 
 #ifdef CONFIG_RAS
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c5d96e3e7fff..62c1de522fc5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1304,7 +1304,9 @@ struct task_struct {
 
 #ifdef CONFIG_X86_MCE
 	u64				mce_addr;
-	u64				mce_status;
+	__u64				mce_ripv : 1,
+					mce_whole_page : 1,
+					__mce_reserved : 62;
 	struct callback_head		mce_kill_me;
 #endif
 
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index 86281ac7c305..860e0f843c12 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -26,7 +26,7 @@ static inline int set_direct_map_default_noflush(struct page *page)
 #endif
 
 #ifndef set_mce_nospec
-static inline int set_mce_nospec(unsigned long pfn)
+static inline int set_mce_nospec(unsigned long pfn, bool unmap)
 {
 	return 0;
 }

