Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E677C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5A42078A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fxxkenOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgCYKSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:18:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53821 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgCYKSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:18:43 -0400
Received: from [IPv6:2601:646:8600:3281:c898:2a71:8b3c:1618] ([IPv6:2601:646:8600:3281:c898:2a71:8b3c:1618])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 02PAHWME3424848
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 25 Mar 2020 03:17:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 02PAHWME3424848
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020032201; t=1585131457;
        bh=MfCnNAHIm3q3trq9/ponNXXkVrT3z6pQ6mvLieAcQOw=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=fxxkenOd1GNat/czNUL3g5OX7rYv1s5cxhr6lPNbToyJOvqRI7N1LZTXxvZC+gKat
         UehNoYWrNtHSkYDW+JU2xUcI90yvB6nEHccigghFwql1IHqxu/U9j8DKpJRdu04Rjp
         9ktUPsCqm58jlPoQpdwcyVon+x4AU8ZUw/iRa1XIgQx1+nnoHqLyfZqF7hz/z3fExM
         jl57k7M2pvzIbBrt1ZXWC6iXhPzr8AvIOp1T887u/+yuMFtvEn+gE59y0hS+3dG4JS
         A2MgdufY3v2m3DE+ACguCvEw09B7dCNPdj0k8mVioLO1pqpjpR0haiwxweH9oTu9Tl
         4+COMkeZeATdg==
Date:   Wed, 25 Mar 2020 03:17:24 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20200325101431.12341-1-andrew.cooper3@citrix.com>
References: <20200325101431.12341-1-andrew.cooper3@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] x86/smpboot: Remove 486-isms from the modern AP boot path
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
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
        jailhouse-dev@googlegroups.com
From:   hpa@zytor.com
Message-ID: <601E644A-B046-4030-B3BD-280ABF15BF53@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 25, 2020 3:14:31 AM PDT, Andrew Cooper <andrew=2Ecooper3@citrix=2E=
com> wrote:
>Linux has an implementation of the Universal Start-up Algorithm (MP
>spec,
>Appendix B=2E4, Application Processor Startup), which includes
>unconditionally
>writing to the Bios Data Area and CMOS registers=2E
>
>The warm reset vector is only necessary in the non-integrated Local
>APIC case=2E
>UV and Jailhouse already have an opt-out for this behaviour, but
>blindly using
>the BDA and CMOS on a UEFI or other reduced hardware system isn't
>clever=2E
>
>Drop the warm_reset flag from struct x86_legacy_features, and tie the
>warm
>vector modifications to the integrated-ness of the Local APIC=2E  This
>has the
>advantage of compiling the warm reset logic out entirely for 64bit
>builds=2E
>
>CC: Thomas Gleixner <tglx@linutronix=2Ede>
>CC: Ingo Molnar <mingo@redhat=2Ecom>
>CC: Borislav Petkov <bp@alien8=2Ede>
>CC: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>CC: x86@kernel=2Eorg
>CC: Jan Kiszka <jan=2Ekiszka@siemens=2Ecom>
>CC: James Morris <jmorris@namei=2Eorg>
>CC: David Howells <dhowells@redhat=2Ecom>
>CC: Andrew Cooper <andrew=2Ecooper3@citrix=2Ecom>
>CC: Matthew Garrett <mjg59@google=2Ecom>
>CC: Josh Boyer <jwboyer@redhat=2Ecom>
>CC: Zhenzhong Duan <zhenzhong=2Eduan@oracle=2Ecom>
>CC: Steve Wahl <steve=2Ewahl@hpe=2Ecom>
>CC: Mike Travis <mike=2Etravis@hpe=2Ecom>
>CC: Dimitri Sivanich <dimitri=2Esivanich@hpe=2Ecom>
>CC: Arnd Bergmann <arnd@arndb=2Ede>
>CC: "Peter Zijlstra (Intel)" <peterz@infradead=2Eorg>
>CC: Giovanni Gherdovich <ggherdovich@suse=2Ecz>
>CC: "Rafael J=2E Wysocki" <rafael=2Ej=2Ewysocki@intel=2Ecom>
>CC: Len Brown <len=2Ebrown@intel=2Ecom>
>CC: Kees Cook <keescook@chromium=2Eorg>
>CC: Martin Molnar <martin=2Emolnar=2Eprogramming@gmail=2Ecom>
>CC: Pingfan Liu <kernelfans@gmail=2Ecom>
>CC: linux-kernel@vger=2Ekernel=2Eorg
>CC: jailhouse-dev@googlegroups=2Ecom
>Signed-off-by: Andrew Cooper <andrew=2Ecooper3@citrix=2Ecom>
>---
>Thomas: I finally found the reference we were discussing in Portland=2E=
=20
>Sorry
>this patch took so long=2E
>
>I don't have any non-integrated APIC hardware to test with=2E  Can anyone
>help
>me out?
>---
> arch/x86/include/asm/x86_init=2Eh    |  1 -
> arch/x86/kernel/apic/x2apic_uv_x=2Ec |  1 -
> arch/x86/kernel/jailhouse=2Ec        |  1 -
> arch/x86/kernel/platform-quirks=2Ec  |  1 -
> arch/x86/kernel/smpboot=2Ec          | 21 ++++++++++++---------
> 5 files changed, 12 insertions(+), 13 deletions(-)
>
>diff --git a/arch/x86/include/asm/x86_init=2Eh
>b/arch/x86/include/asm/x86_init=2Eh
>index 96d9cd208610=2E=2E006a5d7fd7eb 100644
>--- a/arch/x86/include/asm/x86_init=2Eh
>+++ b/arch/x86/include/asm/x86_init=2Eh
>@@ -229,7 +229,6 @@ enum x86_legacy_i8042_state {
> struct x86_legacy_features {
> 	enum x86_legacy_i8042_state i8042;
> 	int rtc;
>-	int warm_reset;
> 	int no_vga;
> 	int reserve_bios_regions;
> 	struct x86_legacy_devices devices;
>diff --git a/arch/x86/kernel/apic/x2apic_uv_x=2Ec
>b/arch/x86/kernel/apic/x2apic_uv_x=2Ec
>index ad53b2abc859=2E=2E5afcfd193592 100644
>--- a/arch/x86/kernel/apic/x2apic_uv_x=2Ec
>+++ b/arch/x86/kernel/apic/x2apic_uv_x=2Ec
>@@ -343,7 +343,6 @@ static int __init uv_acpi_madt_oem_check(char
>*_oem_id, char *_oem_table_id)
> 	} else if (!strcmp(oem_table_id, "UVH")) {
> 		/* Only UV1 systems: */
> 		uv_system_type =3D UV_NON_UNIQUE_APIC;
>-		x86_platform=2Elegacy=2Ewarm_reset =3D 0;
>		__this_cpu_write(x2apic_extra_bits, pnodeid <<
>uvh_apicid=2Es=2Epnode_shift);
> 		uv_set_apicid_hibit();
> 		uv_apic =3D 1;
>diff --git a/arch/x86/kernel/jailhouse=2Ec b/arch/x86/kernel/jailhouse=2E=
c
>index 6eb8b50ea07e=2E=2Ed628fe92d6af 100644
>--- a/arch/x86/kernel/jailhouse=2Ec
>+++ b/arch/x86/kernel/jailhouse=2Ec
>@@ -210,7 +210,6 @@ static void __init jailhouse_init_platform(void)
> 	x86_platform=2Ecalibrate_tsc	=3D jailhouse_get_tsc;
> 	x86_platform=2Eget_wallclock	=3D jailhouse_get_wallclock;
> 	x86_platform=2Elegacy=2Ertc		=3D 0;
>-	x86_platform=2Elegacy=2Ewarm_reset	=3D 0;
> 	x86_platform=2Elegacy=2Ei8042	=3D X86_LEGACY_I8042_PLATFORM_ABSENT;
>=20
> 	legacy_pic			=3D &null_legacy_pic;
>diff --git a/arch/x86/kernel/platform-quirks=2Ec
>b/arch/x86/kernel/platform-quirks=2Ec
>index b348a672f71d=2E=2Ed922c5e0c678 100644
>--- a/arch/x86/kernel/platform-quirks=2Ec
>+++ b/arch/x86/kernel/platform-quirks=2Ec
>@@ -9,7 +9,6 @@ void __init x86_early_init_platform_quirks(void)
> {
> 	x86_platform=2Elegacy=2Ei8042 =3D X86_LEGACY_I8042_EXPECTED_PRESENT;
> 	x86_platform=2Elegacy=2Ertc =3D 1;
>-	x86_platform=2Elegacy=2Ewarm_reset =3D 1;
> 	x86_platform=2Elegacy=2Ereserve_bios_regions =3D 0;
> 	x86_platform=2Elegacy=2Edevices=2Epnpbios =3D 1;
>=20
>diff --git a/arch/x86/kernel/smpboot=2Ec b/arch/x86/kernel/smpboot=2Ec
>index d85e91a8aa8c=2E=2Ee2ebb0be2ee3 100644
>--- a/arch/x86/kernel/smpboot=2Ec
>+++ b/arch/x86/kernel/smpboot=2Ec
>@@ -1049,18 +1049,21 @@ static int do_boot_cpu(int apicid, int cpu,
>struct task_struct *idle,
> 	 * the targeted processor=2E
> 	 */
>=20
>-	if (x86_platform=2Elegacy=2Ewarm_reset) {
>+	/*
>+	 * APs are typically started in one of two ways:
>+	 *
>+	 * - On 486-era hardware with a non-integrated Local APIC, a single
>+	 *   INIT IPI is sent=2E  When the AP comes out of reset, the BIOS
>+	 *   follows the warm reset vector to start_ip=2E
>+	 * - On everything with an integrated Local APIC, the start_ip is
>+	 *   provided in the Startup IPI message, sent as part of an
>+	 *   INIT-SIPI-SIPI sequence=2E
>+	 */
>+	if (!APIC_INTEGRATED(boot_cpu_apic_version)) {
>=20
> 		pr_debug("Setting warm reset code and vector=2E\n");
>=20
> 		smpboot_setup_warm_reset_vector(start_ip);
>-		/*
>-		 * Be paranoid about clearing APIC errors=2E
>-		*/
>-		if (APIC_INTEGRATED(boot_cpu_apic_version)) {
>-			apic_write(APIC_ESR, 0);
>-			apic_read(APIC_ESR);
>-		}
> 	}
>=20
> 	/*
>@@ -1118,7 +1121,7 @@ static int do_boot_cpu(int apicid, int cpu,
>struct task_struct *idle,
> 		}
> 	}
>=20
>-	if (x86_platform=2Elegacy=2Ewarm_reset) {
>+	if (!APIC_INTEGRATED(boot_cpu_apic_version)) {
> 		/*
> 		 * Cleanup possible dangling ends=2E=2E=2E
> 		 */

We don't support SMP on 486 and haven't for a very long time=2E Is there a=
ny reason to retain that code at all?
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
