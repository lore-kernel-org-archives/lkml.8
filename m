Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD6BC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE0720CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="eSg4nykT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgCaR6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:58:17 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:51667 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgCaR6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1585677496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ugN/+rcpfhTRDqqHKAZjxpSJT2vgLfeYiI3IivYQo/Q=;
  b=eSg4nykTcSzNwa8iiRvFGI+c+h89qCiQeObhzepPCY3vdcNTXFKIXbXB
   Y3/kbizih/kWgkPrHzebdDqdTwvfpDoYnAnVMOHk+CBHyTyUaszO/msqo
   NmHNle6xjWWRZHUMviVwT9PMuruG1s6X21JcJ/ggzLp/V4ZatVcGBDJRO
   Y=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=andrew.cooper3@citrix.com; spf=Pass smtp.mailfrom=Andrew.Cooper3@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  andrew.cooper3@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="andrew.cooper3@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
  Andrew.Cooper3@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="Andrew.Cooper3@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: RGw3vXfJvPLWGYll59FYuAuA6EAKCWzeIq5Fl0HkNa2ni94sQboesVM0BU188NTLSn7DbvQ+3O
 w46cW+o3PzyEWAR2tzKHSx9Rrpw65z+eMqTsCeu8F6QUGeLl6CVQG7LOiyLupPZhDHYJ+pkDxT
 ak1rYwwMa2PcclAmNWf/yPHxQb8lCtg8VO4Lyf/vw1rCjmZ5WzBrKlpNlbhz7cTY0s8UBSt9ad
 8Z8a7WnGrB4qkWsqDl+uOgikBbugwxAU8TeT0t3/yB7Bb6d2wYeQq/a2O3/gnbTK239PS51e6/
 oag=
X-SBRS: 2.7
X-MesageID: 15275649
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,328,1580792400"; 
   d="scan'208";a="15275649"
From:   Andrew Cooper <andrew.cooper3@citrix.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        "Jan Kiszka" <jan.kiszka@siemens.com>,
        James Morris <jmorris@namei.org>,
        "David Howells" <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Josh Boyer <jwboyer@redhat.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        <jailhouse-dev@googlegroups.com>
Subject: [PATCH v2] x86/smpboot: Remove 486-isms from the modern AP boot path
Date:   Tue, 31 Mar 2020 18:58:10 +0100
Message-ID: <20200331175810.30204-1-andrew.cooper3@citrix.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200325101431.12341-1-andrew.cooper3@citrix.com>
References: <20200325101431.12341-1-andrew.cooper3@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux has an implementation of the Universal Start-up Algorithm (MP spec,
Appendix B.4, Application Processor Startup), which includes unconditionally
writing to the Bios Data Area and CMOS registers.

The warm reset vector is only necessary in the non-integrated Local APIC case.
UV and Jailhouse already have an opt-out for this behaviour, but blindly using
the BDA and CMOS on a UEFI or other reduced hardware system isn't clever.

We could make this conditional on the integrated-ness of the Local APIC, but
486-era SMP isn't supported.  Drop the logic completely, tidying up the includ
list and header files as appropriate.

CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: x86@kernel.org
CC: Jan Kiszka <jan.kiszka@siemens.com>
CC: James Morris <jmorris@namei.org>
CC: David Howells <dhowells@redhat.com>
CC: Andrew Cooper <andrew.cooper3@citrix.com>
CC: Matthew Garrett <mjg59@google.com>
CC: Josh Boyer <jwboyer@redhat.com>
CC: Steve Wahl <steve.wahl@hpe.com>
CC: Mike Travis <mike.travis@hpe.com>
CC: Dimitri Sivanich <dimitri.sivanich@hpe.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: "Peter Zijlstra (Intel)" <peterz@infradead.org>
CC: Giovanni Gherdovich <ggherdovich@suse.cz>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC: Len Brown <len.brown@intel.com>
CC: Kees Cook <keescook@chromium.org>
CC: Martin Molnar <martin.molnar.programming@gmail.com>
CC: Pingfan Liu <kernelfans@gmail.com>
CC: linux-kernel@vger.kernel.org
CC: jailhouse-dev@googlegroups.com
Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
v2:
 * Drop logic entirely, rather than retaining support in 32bit builds.
---
 arch/x86/include/asm/apic.h        |  6 -----
 arch/x86/include/asm/x86_init.h    |  1 -
 arch/x86/kernel/apic/x2apic_uv_x.c |  1 -
 arch/x86/kernel/jailhouse.c        |  1 -
 arch/x86/kernel/platform-quirks.c  |  1 -
 arch/x86/kernel/smpboot.c          | 50 --------------------------------------
 6 files changed, 60 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 19e94af9cc5d..5c33f9374b28 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -472,12 +472,6 @@ static inline unsigned default_get_apic_id(unsigned long x)
 		return (x >> 24) & 0x0F;
 }
 
-/*
- * Warm reset vector position:
- */
-#define TRAMPOLINE_PHYS_LOW		0x467
-#define TRAMPOLINE_PHYS_HIGH		0x469
-
 extern void generic_bigsmp_probe(void);
 
 #ifdef CONFIG_X86_LOCAL_APIC
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 96d9cd208610..006a5d7fd7eb 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -229,7 +229,6 @@ enum x86_legacy_i8042_state {
 struct x86_legacy_features {
 	enum x86_legacy_i8042_state i8042;
 	int rtc;
-	int warm_reset;
 	int no_vga;
 	int reserve_bios_regions;
 	struct x86_legacy_devices devices;
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index ad53b2abc859..5afcfd193592 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -343,7 +343,6 @@ static int __init uv_acpi_madt_oem_check(char *_oem_id, char *_oem_table_id)
 	} else if (!strcmp(oem_table_id, "UVH")) {
 		/* Only UV1 systems: */
 		uv_system_type = UV_NON_UNIQUE_APIC;
-		x86_platform.legacy.warm_reset = 0;
 		__this_cpu_write(x2apic_extra_bits, pnodeid << uvh_apicid.s.pnode_shift);
 		uv_set_apicid_hibit();
 		uv_apic = 1;
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index 6eb8b50ea07e..d628fe92d6af 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -210,7 +210,6 @@ static void __init jailhouse_init_platform(void)
 	x86_platform.calibrate_tsc	= jailhouse_get_tsc;
 	x86_platform.get_wallclock	= jailhouse_get_wallclock;
 	x86_platform.legacy.rtc		= 0;
-	x86_platform.legacy.warm_reset	= 0;
 	x86_platform.legacy.i8042	= X86_LEGACY_I8042_PLATFORM_ABSENT;
 
 	legacy_pic			= &null_legacy_pic;
diff --git a/arch/x86/kernel/platform-quirks.c b/arch/x86/kernel/platform-quirks.c
index b348a672f71d..d922c5e0c678 100644
--- a/arch/x86/kernel/platform-quirks.c
+++ b/arch/x86/kernel/platform-quirks.c
@@ -9,7 +9,6 @@ void __init x86_early_init_platform_quirks(void)
 {
 	x86_platform.legacy.i8042 = X86_LEGACY_I8042_EXPECTED_PRESENT;
 	x86_platform.legacy.rtc = 1;
-	x86_platform.legacy.warm_reset = 1;
 	x86_platform.legacy.reserve_bios_regions = 0;
 	x86_platform.legacy.devices.pnpbios = 1;
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fe3ab9632f3b..a9f5b511d0b4 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -72,7 +72,6 @@
 #include <asm/fpu/internal.h>
 #include <asm/setup.h>
 #include <asm/uv/uv.h>
-#include <linux/mc146818rtc.h>
 #include <asm/i8259.h>
 #include <asm/misc.h>
 #include <asm/qspinlock.h>
@@ -119,34 +118,6 @@ int arch_update_cpu_topology(void)
 	return retval;
 }
 
-static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&rtc_lock, flags);
-	CMOS_WRITE(0xa, 0xf);
-	spin_unlock_irqrestore(&rtc_lock, flags);
-	*((volatile unsigned short *)phys_to_virt(TRAMPOLINE_PHYS_HIGH)) =
-							start_eip >> 4;
-	*((volatile unsigned short *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) =
-							start_eip & 0xf;
-}
-
-static inline void smpboot_restore_warm_reset_vector(void)
-{
-	unsigned long flags;
-
-	/*
-	 * Paranoid:  Set warm reset code and vector here back
-	 * to default values.
-	 */
-	spin_lock_irqsave(&rtc_lock, flags);
-	CMOS_WRITE(0, 0xf);
-	spin_unlock_irqrestore(&rtc_lock, flags);
-
-	*((volatile u32 *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) = 0;
-}
-
 static void init_freq_invariance(void);
 
 /*
@@ -1049,20 +1020,6 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 	 * the targeted processor.
 	 */
 
-	if (x86_platform.legacy.warm_reset) {
-
-		pr_debug("Setting warm reset code and vector.\n");
-
-		smpboot_setup_warm_reset_vector(start_ip);
-		/*
-		 * Be paranoid about clearing APIC errors.
-		*/
-		if (APIC_INTEGRATED(boot_cpu_apic_version)) {
-			apic_write(APIC_ESR, 0);
-			apic_read(APIC_ESR);
-		}
-	}
-
 	/*
 	 * AP might wait on cpu_callout_mask in cpu_init() with
 	 * cpu_initialized_mask set if previous attempt to online
@@ -1118,13 +1075,6 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 		}
 	}
 
-	if (x86_platform.legacy.warm_reset) {
-		/*
-		 * Cleanup possible dangling ends...
-		 */
-		smpboot_restore_warm_reset_vector();
-	}
-
 	return boot_error;
 }
 
-- 
2.11.0

