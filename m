Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CD3C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E232207EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oURQNVOx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HBTIH0Kp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgGQOv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:51:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41198 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgGQOvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:51:15 -0400
Date:   Fri, 17 Jul 2020 14:51:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594997473;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=90H+L1DVSoEMH2lO9cFnEdTeT+n/wa3kBVoP2FSK+Kg=;
        b=oURQNVOx9fHbfqfeoGEwQASR8WALJS3ZRAMSa/ThKohPw0oDILH57kFJNblGP5rXx94jFw
        dFmMrzBmdub3pmpV/VdvXrXBcmCwXCW0aOsNjVBMHzQjDxiAnymoDmWzqHyPde3A4fljV+
        apQ1rqebFseWzmA05qCC2/x8iBuEC9ljiRBJamjC3UbZzZSpDCFr0ZKoIT1UnpVb6zTEco
        XEPeMZbqEHGtOnxyoWH3e2+Y94o6Syxb/uvcSTJRzHsaI3Qmr0PClMslYq7SRReT7MXc0x
        pErK4rSGzMBOD0yxflIGawWt8NeAqNb2YoPawwnnudjYNQxJHuOfPBWZpIsdCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594997473;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=90H+L1DVSoEMH2lO9cFnEdTeT+n/wa3kBVoP2FSK+Kg=;
        b=HBTIH0KpeLhPag32t3VTuWOcNZUtSDSFOHZLyBV00j3XRheN1YkxHRHN5KZ8X0qnaqZ4D2
        dc59OSeiMuS4ZLBQ==
From:   "tip-bot2 for steve.wahl@hpe.com" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Remove support for UV1 platform
 from x2apic_uv_x
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200713212954.846026992@hpe.com>
References: <20200713212954.846026992@hpe.com>
MIME-Version: 1.0
Message-ID: <159499747243.4006.1630748527581304023.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     a6b740f1732c438c177fa33d94407808a0d0aa1d
Gitweb:        https://git.kernel.org/tip/a6b740f1732c438c177fa33d94407808a0d0aa1d
Author:        steve.wahl@hpe.com <steve.wahl@hpe.com>
AuthorDate:    Mon, 13 Jul 2020 16:29:57 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 16:47:44 +02:00

x86/platform/uv: Remove support for UV1 platform from x2apic_uv_x

UV1 is not longer supported.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200713212954.846026992@hpe.com

---
 arch/x86/kernel/apic/x2apic_uv_x.c | 122 +++++-----------------------
 1 file changed, 26 insertions(+), 96 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 69e70ed..0b6eea3 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -24,8 +24,6 @@
 #include <asm/uv/uv.h>
 #include <asm/apic.h>
 
-static DEFINE_PER_CPU(int, x2apic_extra_bits);
-
 static enum uv_system_type	uv_system_type;
 static int			uv_hubbed_system;
 static int			uv_hubless_system;
@@ -40,7 +38,7 @@ static u8 oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
 static struct {
 	unsigned int apicid_shift;
 	unsigned int apicid_mask;
-	unsigned int socketid_shift;	/* aka pnode_shift for UV1/2/3 */
+	unsigned int socketid_shift;	/* aka pnode_shift for UV2/3 */
 	unsigned int pnode_mask;
 	unsigned int gpa_shift;
 	unsigned int gnode_shift;
@@ -48,8 +46,6 @@ static struct {
 
 static int uv_min_hub_revision_id;
 
-unsigned int uv_apicid_hibits;
-
 static struct apic apic_x2apic_uv_x;
 static struct uv_hub_info_s uv_hub_info_node0;
 
@@ -139,12 +135,8 @@ static void __init uv_tsc_check_sync(void)
 	/* Accommodate different UV arch BIOSes */
 	mmr = uv_early_read_mmr(UVH_TSC_SYNC_MMR);
 	mmr_shift =
-		is_uv1_hub() ? 0 :
 		is_uv2_hub() ? UVH_TSC_SYNC_SHIFT_UV2K : UVH_TSC_SYNC_SHIFT;
-	if (mmr_shift)
-		sync_state = (mmr >> mmr_shift) & UVH_TSC_SYNC_MASK;
-	else
-		sync_state = 0;
+	sync_state = (mmr >> mmr_shift) & UVH_TSC_SYNC_MASK;
 
 	switch (sync_state) {
 	case UVH_TSC_SYNC_VALID:
@@ -223,21 +215,6 @@ static void __init early_get_apic_socketid_shift(void)
 	pr_info("UV: socketid_shift:%d pnode_mask:0x%x\n", uv_cpuid.socketid_shift, uv_cpuid.pnode_mask);
 }
 
-/*
- * Add an extra bit as dictated by bios to the destination apicid of
- * interrupts potentially passing through the UV HUB.  This prevents
- * a deadlock between interrupts and IO port operations.
- */
-static void __init uv_set_apicid_hibit(void)
-{
-	union uv1h_lb_target_physical_apic_id_mask_u apicid_mask;
-
-	if (is_uv1_hub()) {
-		apicid_mask.v = uv_early_read_mmr(UV1H_LB_TARGET_PHYSICAL_APIC_ID_MASK);
-		uv_apicid_hibits = apicid_mask.s1.bit_enables & UV_APICID_HIBIT_MASK;
-	}
-}
-
 static void __init uv_stringify(int len, char *to, char *from)
 {
 	/* Relies on 'to' being NULL chars so result will be NULL terminated */
@@ -280,36 +257,25 @@ static int __init uv_acpi_madt_oem_check(char *_oem_id, char *_oem_table_id)
 
 	/*
 	 * Determine UV arch type.
-	 *   SGI:  UV100/1000
 	 *   SGI2: UV2000/3000
 	 *   SGI3: UV300 (truncated to 4 chars because of different varieties)
 	 *   SGI4: UV400 (truncated to 4 chars because of different varieties)
 	 */
-	uv_hub_info->hub_revision =
-		!strncmp(oem_id, "SGI4", 4) ? UV4_HUB_REVISION_BASE :
-		!strncmp(oem_id, "SGI3", 4) ? UV3_HUB_REVISION_BASE :
-		!strcmp(oem_id, "SGI2") ? UV2_HUB_REVISION_BASE :
-		!strcmp(oem_id, "SGI") ? UV1_HUB_REVISION_BASE : 0;
-
-	if (uv_hub_info->hub_revision == 0)
-		goto badbios;
-
-	switch (uv_hub_info->hub_revision) {
-	case UV4_HUB_REVISION_BASE:
+	if (!strncmp(oem_id, "SGI4", 4)) {
+		uv_hub_info->hub_revision = UV4_HUB_REVISION_BASE;
 		uv_hubbed_system = 0x11;
-		break;
 
-	case UV3_HUB_REVISION_BASE:
+	} else if (!strncmp(oem_id, "SGI3", 4)) {
+		uv_hub_info->hub_revision = UV3_HUB_REVISION_BASE;
 		uv_hubbed_system = 0x9;
-		break;
 
-	case UV2_HUB_REVISION_BASE:
+	} else if (!strcmp(oem_id, "SGI2")) {
+		uv_hub_info->hub_revision = UV2_HUB_REVISION_BASE;
 		uv_hubbed_system = 0x5;
-		break;
 
-	case UV1_HUB_REVISION_BASE:
-		uv_hubbed_system = 0x3;
-		break;
+	} else {
+		uv_hub_info->hub_revision = 0;
+		goto badbios;
 	}
 
 	pnodeid = early_get_pnodeid();
@@ -323,14 +289,6 @@ static int __init uv_acpi_madt_oem_check(char *_oem_id, char *_oem_table_id)
 		uv_system_type = UV_X2APIC;
 		uv_apic = 0;
 
-	} else if (!strcmp(oem_table_id, "UVH")) {
-		/* Only UV1 systems: */
-		uv_system_type = UV_NON_UNIQUE_APIC;
-		x86_platform.legacy.warm_reset = 0;
-		__this_cpu_write(x2apic_extra_bits, pnodeid << uvh_apicid.s.pnode_shift);
-		uv_set_apicid_hibit();
-		uv_apic = 1;
-
 	} else if (!strcmp(oem_table_id, "UVL")) {
 		/* Only used for very small systems:  */
 		uv_system_type = UV_LEGACY_APIC;
@@ -347,7 +305,7 @@ static int __init uv_acpi_madt_oem_check(char *_oem_id, char *_oem_table_id)
 
 badbios:
 	pr_err("UV: OEM_ID:%s OEM_TABLE_ID:%s\n", oem_id, oem_table_id);
-	pr_err("Current BIOS not supported, update kernel and/or BIOS\n");
+	pr_err("Current UV Type or BIOS not supported\n");
 	BUG();
 }
 
@@ -545,7 +503,6 @@ static int uv_wakeup_secondary(int phys_apicid, unsigned long start_rip)
 	int pnode;
 
 	pnode = uv_apicid_to_pnode(phys_apicid);
-	phys_apicid |= uv_apicid_hibits;
 
 	val = (1UL << UVH_IPI_INT_SEND_SHFT) |
 	    (phys_apicid << UVH_IPI_INT_APIC_ID_SHFT) |
@@ -576,7 +533,7 @@ static void uv_send_IPI_one(int cpu, int vector)
 		dmode = dest_Fixed;
 
 	val = (1UL << UVH_IPI_INT_SEND_SHFT) |
-		((apicid | uv_apicid_hibits) << UVH_IPI_INT_APIC_ID_SHFT) |
+		(apicid << UVH_IPI_INT_APIC_ID_SHFT) |
 		(dmode << UVH_IPI_INT_DELIVERY_MODE_SHFT) |
 		(vector << UVH_IPI_INT_VECTOR_SHFT);
 
@@ -634,22 +591,16 @@ static void uv_init_apic_ldr(void)
 
 static u32 apic_uv_calc_apicid(unsigned int cpu)
 {
-	return apic_default_calc_apicid(cpu) | uv_apicid_hibits;
+	return apic_default_calc_apicid(cpu);
 }
 
-static unsigned int x2apic_get_apic_id(unsigned long x)
+static unsigned int x2apic_get_apic_id(unsigned long id)
 {
-	unsigned int id;
-
-	WARN_ON(preemptible() && num_online_cpus() > 1);
-	id = x | __this_cpu_read(x2apic_extra_bits);
-
 	return id;
 }
 
 static u32 set_apic_id(unsigned int id)
 {
-	/* CHECKME: Do we need to mask out the xapic extra bits? */
 	return id;
 }
 
@@ -721,11 +672,6 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 	.safe_wait_icr_idle		= native_safe_x2apic_wait_icr_idle,
 };
 
-static void set_x2apic_extra_bits(int pnode)
-{
-	__this_cpu_write(x2apic_extra_bits, pnode << uvh_apicid.s.pnode_shift);
-}
-
 #define	UVH_RH_GAM_ALIAS210_REDIRECT_CONFIG_LENGTH	3
 #define DEST_SHIFT UVH_RH_GAM_ALIAS210_REDIRECT_CONFIG_0_MMR_DEST_BASE_SHFT
 
@@ -920,15 +866,7 @@ static __init void map_mmioh_high(int min_pnode, int max_pnode)
 		return;
 	}
 
-	if (is_uv1_hub()) {
-		mmr	= UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR;
-		shift	= UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR_BASE_SHFT;
-		mmioh.v	= uv_read_local_mmr(mmr);
-		enable	= !!mmioh.s1.enable;
-		base	= mmioh.s1.base;
-		m_io	= mmioh.s1.m_io;
-		n_io	= mmioh.s1.n_io;
-	} else if (is_uv2_hub()) {
+	if (is_uv2_hub()) {
 		mmr	= UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR;
 		shift	= UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG_MMR_BASE_SHFT;
 		mmioh.v	= uv_read_local_mmr(mmr);
@@ -936,16 +874,15 @@ static __init void map_mmioh_high(int min_pnode, int max_pnode)
 		base	= mmioh.s2.base;
 		m_io	= mmioh.s2.m_io;
 		n_io	= mmioh.s2.n_io;
-	} else {
-		return;
-	}
 
-	if (enable) {
-		max_pnode &= (1 << n_io) - 1;
-		pr_info("UV: base:0x%lx shift:%d N_IO:%d M_IO:%d max_pnode:0x%x\n", base, shift, m_io, n_io, max_pnode);
-		map_high("MMIOH", base, shift, m_io, max_pnode, map_uc);
-	} else {
-		pr_info("UV: MMIOH disabled\n");
+		if (enable) {
+			max_pnode &= (1 << n_io) - 1;
+			pr_info("UV: base:0x%lx shift:%d N_IO:%d M_IO:%d max_pnode:0x%x\n",
+				base, shift, m_io, n_io, max_pnode);
+			map_high("MMIOH", base, shift, m_io, max_pnode, map_uc);
+		} else {
+			pr_info("UV: MMIOH disabled\n");
+		}
 	}
 }
 
@@ -1081,9 +1018,6 @@ void uv_cpu_init(void)
 		return;
 
 	uv_hub_info->nr_online_cpus++;
-
-	if (get_uv_system_type() == UV_NON_UNIQUE_APIC)
-		set_x2apic_extra_bits(uv_hub_info->pnode);
 }
 
 struct mn {
@@ -1114,9 +1048,6 @@ static void get_mn(struct mn *mnp)
 	} else if (is_uv2_hub()) {
 		mnp->m_val	= m_n_config.s2.m_skt;
 		mnp->n_lshift	= mnp->m_val == 40 ? 40 : 39;
-	} else if (is_uv1_hub()) {
-		mnp->m_val	= m_n_config.s1.m_skt;
-		mnp->n_lshift	= mnp->m_val;
 	}
 	mnp->m_shift = mnp->m_val ? 64 - mnp->m_val : 0;
 }
@@ -1318,7 +1249,7 @@ static void __init build_socket_tables(void)
 	size_t bytes;
 
 	if (!gre) {
-		if (is_uv1_hub() || is_uv2_hub() || is_uv3_hub()) {
+		if (is_uv2_hub() || is_uv3_hub()) {
 			pr_info("UV: No UVsystab socket table, ignoring\n");
 			return;
 		}
@@ -1500,8 +1431,7 @@ static void __init uv_system_init_hub(void)
 	unsigned short min_pnode = 9999, max_pnode = 0;
 	char *hub = is_uv4_hub() ? "UV400" :
 		    is_uv3_hub() ? "UV300" :
-		    is_uv2_hub() ? "UV2000/3000" :
-		    is_uv1_hub() ? "UV100/1000" : NULL;
+		    is_uv2_hub() ? "UV2000/3000" : NULL;
 
 	if (!hub) {
 		pr_err("UV: Unknown/unsupported UV hub\n");
