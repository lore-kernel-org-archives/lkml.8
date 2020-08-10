Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BFAC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 02:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3882F206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 02:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0Sj61ny2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgHJCtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 22:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgHJCtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 22:49:55 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DF3C061756;
        Sun,  9 Aug 2020 19:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=aalCIQcxb0l/94tEa2Mot8Ybhlq+bKvjYa8fZ9Dk3vc=; b=0Sj61ny23pRUqQR03QWp2txqtK
        D3qdrTjwqysMrCE/9bCxPqFBgVo01qiWE019J8GC50jijmaqgdIWbBo3JPc3AV4hIveRksX+hcxzd
        ZP1T+ytufo8uFBcRb82HphrptZjMc1NslOpB5kZ8XspxB5eKh+nNOnzLwqOdfYQa8fT1c7CulgKV4
        olofirzDYVrE7YmtyFmJSkDt3Esv013X4qTVejvZScDNXjFaTYWXTDSgJmNdVkGazHdUOJaeqwbqo
        DIAM9YsRLlgKpWetjlO0GQn0BgrP0+Wm1QXieZawLM61jzUSzi4gpX916V0qBwcZWTm0kfkmnEeY6
        lloFt0MA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k4xsi-00080j-N0; Mon, 10 Aug 2020 02:49:49 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: [PATCH] Doc: admin-guide: use correct legends in kernel-parameters.txt
Date:   Sun,  9 Aug 2020 19:49:41 -0700
Message-Id: <20200810024941.30231-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/admin-guide/kernel-parameters.rst includes a legend
telling us what configurations or hardware platforms are relevant
for certain boot options.  For X86, it is spelled "X86" and for
x86_64, it is spelled "X86-64", so make corrections for those.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt |   36 +++++++-------
 1 file changed, 18 insertions(+), 18 deletions(-)

--- linux-next-20200807.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-next-20200807/Documentation/admin-guide/kernel-parameters.txt
@@ -724,7 +724,7 @@
 			memory region [offset, offset + size] for that kernel
 			image. If '@offset' is omitted, then a suitable offset
 			is selected automatically.
-			[KNL, x86_64] select a region under 4G first, and
+			[KNL, X86-64] Select a region under 4G first, and
 			fall back to reserve region above 4G when '@offset'
 			hasn't been specified.
 			See Documentation/admin-guide/kdump/kdump.rst for further details.
@@ -737,14 +737,14 @@
 			Documentation/admin-guide/kdump/kdump.rst for an example.
 
 	crashkernel=size[KMG],high
-			[KNL, x86_64] range could be above 4G. Allow kernel
+			[KNL, X86-64] range could be above 4G. Allow kernel
 			to allocate physical memory region from top, so could
 			be above 4G if system have more than 4G ram installed.
 			Otherwise memory region will be allocated below 4G, if
 			available.
 			It will be ignored if crashkernel=X is specified.
 	crashkernel=size[KMG],low
-			[KNL, x86_64] range under 4G. When crashkernel=X,high
+			[KNL, X86-64] range under 4G. When crashkernel=X,high
 			is passed, kernel could allocate physical memory region
 			above 4G, that cause second kernel crash on system
 			that require some amount of low memory, e.g. swiotlb
@@ -1427,7 +1427,7 @@
 
 	gamma=		[HW,DRM]
 
-	gart_fix_e820=	[X86_64] disable the fix e820 for K8 GART
+	gart_fix_e820=	[X86-64] disable the fix e820 for K8 GART
 			Format: off | on
 			default: on
 
@@ -1814,7 +1814,7 @@
 			Format: 0 | 1
 			Default set by CONFIG_INIT_ON_FREE_DEFAULT_ON.
 
-	init_pkru=	[x86] Specify the default memory protection keys rights
+	init_pkru=	[X86] Specify the default memory protection keys rights
 			register contents for all processes.  0x55555554 by
 			default (disallow access to all but pkey 0).  Can
 			override in debugfs after boot.
@@ -1822,7 +1822,7 @@
 	inport.irq=	[HW] Inport (ATI XL and Microsoft) busmouse driver
 			Format: <irq>
 
-	int_pln_enable	[x86] Enable power limit notification interrupt
+	int_pln_enable	[X86] Enable power limit notification interrupt
 
 	integrity_audit=[IMA]
 			Format: { "0" | "1" }
@@ -1840,7 +1840,7 @@
 			bypassed by not enabling DMAR with this option. In
 			this case, gfx device will use physical address for
 			DMA.
-		forcedac [x86_64]
+		forcedac [X86-64]
 			With this option iommu will not optimize to look
 			for io virtual address below 32-bit forcing dual
 			address cycle on pci bus for cards supporting greater
@@ -1925,7 +1925,7 @@
 		strict	regions from userspace.
 		relaxed
 
-	iommu=		[x86]
+	iommu=		[X86]
 		off
 		force
 		noforce
@@ -1935,8 +1935,8 @@
 		merge
 		nomerge
 		soft
-		pt		[x86]
-		nopt		[x86]
+		pt		[X86]
+		nopt		[X86]
 		nobypass	[PPC/POWERNV]
 			Disable IOMMU bypass, using IOMMU for PCI devices.
 
@@ -2079,21 +2079,21 @@
 
 	iucv=		[HW,NET]
 
-	ivrs_ioapic	[HW,X86_64]
+	ivrs_ioapic	[HW,X86-64]
 			Provide an override to the IOAPIC-ID<->DEVICE-ID
 			mapping provided in the IVRS ACPI table. For
 			example, to map IOAPIC-ID decimal 10 to
 			PCI device 00:14.0 write the parameter as:
 				ivrs_ioapic[10]=00:14.0
 
-	ivrs_hpet	[HW,X86_64]
+	ivrs_hpet	[HW,X86-64]
 			Provide an override to the HPET-ID<->DEVICE-ID
 			mapping provided in the IVRS ACPI table. For
 			example, to map HPET-ID decimal 0 to
 			PCI device 00:14.0 write the parameter as:
 				ivrs_hpet[0]=00:14.0
 
-	ivrs_acpihid	[HW,X86_64]
+	ivrs_acpihid	[HW,X86-64]
 			Provide an override to the ACPI-HID:UID<->DEVICE-ID
 			mapping provided in the IVRS ACPI table. For
 			example, to map UART-HID:UID AMD0020:0 to
@@ -2370,7 +2370,7 @@
 	lapic		[X86-32,APIC] Enable the local APIC even if BIOS
 			disabled it.
 
-	lapic=		[x86,APIC] "notscdeadline" Do not use TSC deadline
+	lapic=		[X86,APIC] "notscdeadline" Do not use TSC deadline
 			value for LAPIC timer one-shot implementation. Default
 			back to the programmable timer unit in the LAPIC.
 
@@ -3188,12 +3188,12 @@
 			register save and restore. The kernel will only save
 			legacy floating-point registers on task switch.
 
-	nohugeiomap	[KNL,x86,PPC] Disable kernel huge I/O mappings.
+	nohugeiomap	[KNL,X86,PPC] Disable kernel huge I/O mappings.
 
 	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
 			Equivalent to smt=1.
 
-			[KNL,x86] Disable symmetric multithreading (SMT).
+			[KNL,X86] Disable symmetric multithreading (SMT).
 			nosmt=force: Force disable SMT, cannot be undone
 				     via the sysfs control file.
 
@@ -3955,7 +3955,7 @@
 	pt.		[PARIDE]
 			See Documentation/admin-guide/blockdev/paride.rst.
 
-	pti=		[X86_64] Control Page Table Isolation of user and
+	pti=		[X86-64] Control Page Table Isolation of user and
 			kernel address spaces.  Disabling this feature
 			removes hardening, but improves performance of
 			system calls and interrupts.
@@ -3967,7 +3967,7 @@
 
 			Not specifying this option is equivalent to pti=auto.
 
-	nopti		[X86_64]
+	nopti		[X86-64]
 			Equivalent to pti=off
 
 	pty.legacy_count=
