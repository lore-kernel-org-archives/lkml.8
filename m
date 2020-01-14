Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA00C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9B72465A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="LpgACcfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgANOYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:24:08 -0500
Received: from mail-40135.protonmail.ch ([185.70.40.135]:11461 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbgANOYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:24:07 -0500
Date:   Tue, 14 Jan 2020 14:23:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1579011844;
        bh=lpMOa+iJAF3MtHqUdxDVUs+npedWnm91Kj5dgmwc2PU=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=LpgACcfJBOF6PL+bDsMcoJJZdQvw9qO/eb+oldm8VU5m3y2y6eWPKyLaMc5e1v7Y0
         AIosKcpKusScaGatpoudpOicuiXXECuT2SVMLh5+WpUt1/36LuBQdxIhvqZOqlfnZ1
         A6Zm6mLGoduMzBzKiI/2CieLiJ/JSMbXV1CLd1KQ=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Krzysztof Piecuch <piecuch@protonmail.com>
Cc:     "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "malat@debian.org" <malat@debian.org>,
        "piecuch@protonmail.com" <piecuch@protonmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "mzhivich@akamai.com" <mzhivich@akamai.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "drake@endlessm.com" <drake@endlessm.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Reply-To: Krzysztof Piecuch <piecuch@protonmail.com>
Subject: [PATCH] x86/tsc: Add tsc_guess flag disabling CPUID.16h use for tsc calibration
Message-ID: <03j72W25Dne_HDSwI8Y7xiXPzvEBX5Ezw_xw8ed8DC83bpdMxoPcjhbinNcDD0yeoX9GGN691f3kqqtGLztTnW8Pay3FrbO5sTlj3vjnh-Y=@protonmail.com>
Feedback-ID: krphKiiPlx_XKIryTSpdJ_XtBwogkHXWA-Us-PsTeaBSrzOTAKWxwbFkseT4Z85b_7PMRvSnq3Ah7f9INXrOMw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing base clock frequency directly impacts tsc hz but not CPUID.16h
values. An overclocked CPU supporting CPUID.16h and partial CPUID.15h
support will set tsc hz according to "best guess" given by CPUID.16h
relying on tsc_refine_calibration_work to give better numbers later.
tsc_refine_calibration_work will refuse to do its work when the outcome is
off the early tsc hz value by more than 1% which is certain to happen on an
overclocked system.

Signed-off-by: Krzysztof Piecuch <piecuch@protonmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 arch/x86/kernel/tsc.c                           | 12 ++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
index ade4e6ec23e0..54ae9e153a19 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4905,6 +4905,12 @@
 =09=09=09interruptions from clocksource watchdog are not
 =09=09=09acceptable).

+=09tsc_guess=3D=09[X86,INTEL] Don't use data provided by CPUID.16h during
+=09=09=09early tsc calibration. Disabling this may be useful for
+=09=09=09CPUs with altered base clocks.
+=09=09=09Format: <bool> (1/Y/y=3Denable, 0/N/n=3Ddisable)
+=09=09=09default: enabled
+
 =09tsx=3D=09=09[X86] Control Transactional Synchronization
 =09=09=09Extensions (TSX) feature in Intel processors that
 =09=09=09support TSX control.
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 7e322e2daaf5..a807c33a3d41 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -59,6 +59,13 @@ struct cyc2ns {

 static DEFINE_PER_CPU_ALIGNED(struct cyc2ns, cyc2ns);

+static bool _read_mostly tsc_guess =3D 1;
+static int __init tsc_guess_setup(char *buf)
+{
+=09return strtobool(buf, &tsc_guess);
+}
+early_param("tsc_guess", tsc_guess_setup);
+
 __always_inline void cyc2ns_read_begin(struct cyc2ns_data *data)
 {
 =09int seq, idx;
@@ -654,7 +661,8 @@ unsigned long native_calibrate_tsc(void)
 =09 * clock, but we can easily calculate it to a high degree of accuracy
 =09 * by considering the crystal ratio and the CPU speed.
 =09 */
-=09if (crystal_khz =3D=3D 0 && boot_cpu_data.cpuid_level >=3D 0x16) {
+=09if (crystal_khz =3D=3D 0 && tsc_guess &&
+=09=09boot_cpu_data.cpuid_level >=3D 0x16) {
 =09=09unsigned int eax_base_mhz, ebx, ecx, edx;

 =09=09cpuid(0x16, &eax_base_mhz, &ebx, &ecx, &edx);
@@ -692,7 +700,7 @@ static unsigned long cpu_khz_from_cpuid(void)
 =09if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_INTEL)
 =09=09return 0;

-=09if (boot_cpu_data.cpuid_level < 0x16)
+=09if (boot_cpu_data.cpuid_level < 0x16 || !tsc_guess)
 =09=09return 0;

 =09eax_base_mhz =3D ebx_max_mhz =3D ecx_bus_mhz =3D edx =3D 0;
--
2.20.1

