Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE16FC33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17E22072E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="tRdm+bh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgAQPN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:13:57 -0500
Received: from mail-40130.protonmail.ch ([185.70.40.130]:33299 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbgAQPN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:13:56 -0500
Date:   Fri, 17 Jan 2020 15:13:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1579274033;
        bh=bQrJQ2tPkY3J9bw/IJpTnUr830uKKD9zDmVamxGtpI4=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=tRdm+bh+MbfqJn6k9IA0Wm15CYQWqMAm9cYjPn1ENlcdA08Gr6bP3qkzmvwFbiUzL
         IKXK5BNF2B36gHomKuSTQLFIC8Usb+Cw3gT1UaQx944Z+rV+V7HNFpm4YVCp+4Qv0Y
         yEAE9udsvVVaW0Of4wOdhulvIfqKkh0BA2Bd6uZU=
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "drake@endlessm.com" <drake@endlessm.com>,
        "malat@debian.org" <malat@debian.org>,
        "mzhivich@akamai.com" <mzhivich@akamai.com>,
        "piecuch@protonmail.com" <piecuch@protonmail.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Krzysztof Piecuch <piecuch@protonmail.com>
Reply-To: Krzysztof Piecuch <piecuch@protonmail.com>
Subject: [PATCH] x86/tsc: Add tsc_tuned_baseclk flag disabling CPUID.16h use for tsc calibration
Message-ID: <9rN6HvBfpUYE7XjHYSTKXKkKOUHQd_skSYGqjXlI0jTIk4nqLoLUloev1jgSayOdvzmkXgRNP8j_mgcikMJy6L_JN_vJhUJn9vD9xm_ueSo=@protonmail.com>
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

Fix this by adding tsc_tuned_baseclk command line parameter that makes
the kernel ignore CPUID.16h data during TSC calibration.

Signed-off-by: Krzysztof Piecuch <piecuch@protonmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
 arch/x86/kernel/tsc.c                           | 16 ++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
index ade4e6ec23e0..b251169692a8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4905,6 +4905,17 @@
 =09=09=09interruptions from clocksource watchdog are not
 =09=09=09acceptable).

+=09tsc_tuned_baseclk=3D
+=09=09=09[X86,INTEL] Ignore data provided by CPUID.16h during
+=09=09=09early tsc calibration. Useful when changing base clock
+=09=09=09frequency (overclocking).
+=09=09=09Warning: in case your system does not provide
+=09=09=09alternatives to determine cpu speed (HPET, PIT, complete
+=09=09=09CPUID.15h support, MSR) the kernel will fail to
+=09=09=09calibrate the clocksource and local APIC.
+=09=09=09Format: <bool> (1/Y/y=3Denabled, 0/N/n=3Ddisabled)
+=09=09=09default: disabled
+
 =09tsx=3D=09=09[X86] Control Transactional Synchronization
 =09=09=09Extensions (TSX) feature in Intel processors that
 =09=09=09support TSX control.
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 7e322e2daaf5..c9b638dd8f4d 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -59,6 +59,17 @@ struct cyc2ns {

 static DEFINE_PER_CPU_ALIGNED(struct cyc2ns, cyc2ns);

+static bool __read_mostly tsc_tuned_baseclk;
+static int __init tsc_tuned_baseclk_setup(char *buf)
+{
+=09int ret =3D strtobool(buf, &tsc_tuned_baseclk);
+
+=09if (tsc_tuned_baseclk)
+=09=09pr_warn("tsc_tuned_baseclk: This will allow your CPU to use TSC with=
 an overclocked base clock but your system will require some means of TSC c=
alibration other than CPUID 16h.");
+=09return ret;
+}
+early_param("tsc_tuned_baseclk", tsc_tuned_baseclk_setup);
+
 __always_inline void cyc2ns_read_begin(struct cyc2ns_data *data)
 {
 =09int seq, idx;
@@ -654,7 +665,8 @@ unsigned long native_calibrate_tsc(void)
 =09 * clock, but we can easily calculate it to a high degree of accuracy
 =09 * by considering the crystal ratio and the CPU speed.
 =09 */
-=09if (crystal_khz =3D=3D 0 && boot_cpu_data.cpuid_level >=3D 0x16) {
+=09if (crystal_khz =3D=3D 0 && !tsc_tuned_baseclk &&
+=09=09boot_cpu_data.cpuid_level >=3D 0x16) {
 =09=09unsigned int eax_base_mhz, ebx, ecx, edx;

 =09=09cpuid(0x16, &eax_base_mhz, &ebx, &ecx, &edx);
@@ -692,7 +704,7 @@ static unsigned long cpu_khz_from_cpuid(void)
 =09if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_INTEL)
 =09=09return 0;

-=09if (boot_cpu_data.cpuid_level < 0x16)
+=09if (boot_cpu_data.cpuid_level < 0x16 || tsc_tuned_baseclk)
 =09=09return 0;

 =09eax_base_mhz =3D ebx_max_mhz =3D ecx_bus_mhz =3D edx =3D 0;
--
2.20.1

