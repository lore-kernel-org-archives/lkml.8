Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D0BC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F7A20714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ZUJ7PJnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCYKOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:14:43 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:6495 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgCYKOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1585131283;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=HGOJS2fOv/uszg9zMTZ0Pk+5SqksTTlrIT7p7p7GpNk=;
  b=ZUJ7PJnhLSDbfiigFXxaQlPdztAaVhQk/czVFL5OykcIBq/miYH92fF0
   YBtIGcJaymoDARBZHRxhr5Z/J7znuM/hfX+QuXzOvSHBejRpYCdKRoegB
   KFwV3IS1wjvyVss9U+E9xauxYUl8XOHY0QsTKgGu3lNNJE81xqi4fPO8l
   Y=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=andrew.cooper3@citrix.com; spf=Pass smtp.mailfrom=Andrew.Cooper3@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  andrew.cooper3@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="andrew.cooper3@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
  Andrew.Cooper3@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="Andrew.Cooper3@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: r/duezuPH95hneB0/6WiVnY7dVNcDiDLinZUb8n5MUnf4OrVPpdVF0jTSag0GTB1xkfm3Ubrjl
 2Br2IgAz9LjqMDwhGObwCn1Lfzw1mDFw0IjvtGT2TCIqUUVEbMm5Zf+I5oK/+vkmb+vOkrWJXc
 h5kwlYMlRzDU7VOb9XZMt1Nxgor5pBpwSsNp7ucLyVvjiR57qDj84b/Bw7N0GSjIpc2CEjH0wj
 64ZZ4MkvLSazeACNFca1jBl3m5g9jDggi6n+sH9Z+rpIaPVlrc9u/rATgDrmBsoIunkNXXOv1C
 lM8=
X-SBRS: 2.7
X-MesageID: 14580578
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,304,1580792400"; 
   d="scan'208";a="14580578"
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
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        <jailhouse-dev@googlegroups.com>
Subject: [PATCH] x86/smpboot: Remove 486-isms from the modern AP boot path
Date:   Wed, 25 Mar 2020 10:14:31 +0000
Message-ID: <20200325101431.12341-1-andrew.cooper3@citrix.com>
X-Mailer: git-send-email 2.11.0
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

Drop the warm_reset flag from struct x86_legacy_features, and tie the warm
vector modifications to the integrated-ness of the Local APIC.  This has the
advantage of compiling the warm reset logic out entirely for 64bit builds.

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
CC: Zhenzhong Duan <zhenzhong.duan@oracle.com>
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
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
Thomas: I finally found the reference we were discussing in Portland.  Sorry
this patch took so long.

I don't have any non-integrated APIC hardware to test with.  Can anyone help
me out?
---
 arch/x86/include/asm/x86_init.h    |  1 -
 arch/x86/kernel/apic/x2apic_uv_x.c |  1 -
 arch/x86/kernel/jailhouse.c        |  1 -
 arch/x86/kernel/platform-quirks.c  |  1 -
 arch/x86/kernel/smpboot.c          | 21 ++++++++++++---------
 5 files changed, 12 insertions(+), 13 deletions(-)

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
index d85e91a8aa8c..e2ebb0be2ee3 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1049,18 +1049,21 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 	 * the targeted processor.
 	 */
 
-	if (x86_platform.legacy.warm_reset) {
+	/*
+	 * APs are typically started in one of two ways:
+	 *
+	 * - On 486-era hardware with a non-integrated Local APIC, a single
+	 *   INIT IPI is sent.  When the AP comes out of reset, the BIOS
+	 *   follows the warm reset vector to start_ip.
+	 * - On everything with an integrated Local APIC, the start_ip is
+	 *   provided in the Startup IPI message, sent as part of an
+	 *   INIT-SIPI-SIPI sequence.
+	 */
+	if (!APIC_INTEGRATED(boot_cpu_apic_version)) {
 
 		pr_debug("Setting warm reset code and vector.\n");
 
 		smpboot_setup_warm_reset_vector(start_ip);
-		/*
-		 * Be paranoid about clearing APIC errors.
-		*/
-		if (APIC_INTEGRATED(boot_cpu_apic_version)) {
-			apic_write(APIC_ESR, 0);
-			apic_read(APIC_ESR);
-		}
 	}
 
 	/*
@@ -1118,7 +1121,7 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 		}
 	}
 
-	if (x86_platform.legacy.warm_reset) {
+	if (!APIC_INTEGRATED(boot_cpu_apic_version)) {
 		/*
 		 * Cleanup possible dangling ends...
 		 */
-- 
2.11.0

