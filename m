Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBACC5ACBF
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 15:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83602074E
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 15:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgCOPQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 11:16:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50148 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbgCOPQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 11:16:14 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jDUzr-0001iW-BA; Sun, 15 Mar 2020 16:16:11 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 7CE87FFB8B;
        Sun, 15 Mar 2020 16:16:09 +0100 (CET)
Date:   Sun, 15 Mar 2020 15:14:38 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for 5.6-rc6
References: <158428527861.14940.12920965330771600615.tglx@nanos.tec.linutronix.de>
Message-ID: <158428527864.14940.16973165028602818491.tglx@nanos.tec.linutronix.de>
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

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-03-15

up to:  469ff207b4c4: x86/vector: Remove warning on managed interrupt migration


Two fixes for x86:

  - Map EFI runtime service data as encrypted when SEV is enabled otherwise
    e.g. SMBIOS data cannot be properly decoded by dmidecode.

  - Remove the warning in the vector management code which triggered when a
    managed interrupt affinity changed outside of a CPU hotplug
    operation. The warning was correct until the recent core code change
    that introduced a CPU isolation feature which needs to migrate managed
    interrupts away from online CPUs under certain conditions to achieve the
    isolation.

Thanks,

	tglx

------------------>
Peter Xu (1):
      x86/vector: Remove warning on managed interrupt migration

Tom Lendacky (1):
      x86/ioremap: Map EFI runtime services data as encrypted for SEV


 arch/x86/kernel/apic/vector.c | 14 ++++++++------
 arch/x86/mm/ioremap.c         | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 2c5676b0a6e7..48293d15f1e1 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -838,13 +838,15 @@ static void free_moved_vector(struct apic_chip_data *apicd)
 	bool managed = apicd->is_managed;
 
 	/*
-	 * This should never happen. Managed interrupts are not
-	 * migrated except on CPU down, which does not involve the
-	 * cleanup vector. But try to keep the accounting correct
-	 * nevertheless.
+	 * Managed interrupts are usually not migrated away
+	 * from an online CPU, but CPU isolation 'managed_irq'
+	 * can make that happen.
+	 * 1) Activation does not take the isolation into account
+	 *    to keep the code simple
+	 * 2) Migration away from an isolated CPU can happen when
+	 *    a non-isolated CPU which is in the calculated
+	 *    affinity mask comes online.
 	 */
-	WARN_ON_ONCE(managed);
-
 	trace_vector_free_moved(apicd->irq, cpu, vector, managed);
 	irq_matrix_free(vector_matrix, cpu, vector, managed);
 	per_cpu(vector_irq, cpu)[vector] = VECTOR_UNUSED;
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 44e4beb4239f..935a91e1fd77 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -106,6 +106,19 @@ static unsigned int __ioremap_check_encrypted(struct resource *res)
 	return 0;
 }
 
+/*
+ * The EFI runtime services data area is not covered by walk_mem_res(), but must
+ * be mapped encrypted when SEV is active.
+ */
+static void __ioremap_check_other(resource_size_t addr, struct ioremap_desc *desc)
+{
+	if (!sev_active())
+		return;
+
+	if (efi_mem_type(addr) == EFI_RUNTIME_SERVICES_DATA)
+		desc->flags |= IORES_MAP_ENCRYPTED;
+}
+
 static int __ioremap_collect_map_flags(struct resource *res, void *arg)
 {
 	struct ioremap_desc *desc = arg;
@@ -124,6 +137,9 @@ static int __ioremap_collect_map_flags(struct resource *res, void *arg)
  * To avoid multiple resource walks, this function walks resources marked as
  * IORESOURCE_MEM and IORESOURCE_BUSY and looking for system RAM and/or a
  * resource described not as IORES_DESC_NONE (e.g. IORES_DESC_ACPI_TABLES).
+ *
+ * After that, deal with misc other ranges in __ioremap_check_other() which do
+ * not fall into the above category.
  */
 static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
 				struct ioremap_desc *desc)
@@ -135,6 +151,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
 	memset(desc, 0, sizeof(struct ioremap_desc));
 
 	walk_mem_res(start, end, desc, __ioremap_collect_map_flags);
+
+	__ioremap_check_other(addr, desc);
 }
 
 /*

