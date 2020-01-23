Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1C9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA0020684
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="uyJEjCNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgAWQJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 11:09:37 -0500
Received: from mail4.protonmail.ch ([185.70.40.27]:41943 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgAWQJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 11:09:37 -0500
Date:   Thu, 23 Jan 2020 16:09:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1579795774;
        bh=yw9raUxPkYxy9cz74srub2AmOejNGYMeNJxZF6QTNv8=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=uyJEjCNr3JFjU3SiCCZO0YzAYGOeP8WhvV1zLb+jAtxAlNM7G7hOS/x5cQzlNO0ao
         rMX+tdwGoKFQRGcEDHNhZPNEWxgX4jD3lIAktLtaqOkQe7KvR64H24nHPYFUmeRWZP
         BAoiFrULx8MZlg76l43Nk46hnS0jnBh7Tom0Eln0=
To:     "linux-kernel\\@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Krzysztof Piecuch <piecuch@protonmail.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo\\@redhat.com" <mingo@redhat.com>,
        "bp\\@alien8.de" <bp@alien8.de>, "hpa\\@zytor.com" <hpa@zytor.com>,
        "x86\\@kernel.org" <x86@kernel.org>,
        "rafael.j.wysocki\\@intel.com" <rafael.j.wysocki@intel.com>,
        "drake\\@endlessm.com" <drake@endlessm.com>,
        "viresh.kumar\\@linaro.org" <viresh.kumar@linaro.org>,
        "juri.lelli\\@redhat.com" <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "mzhivich\\@akamai.com" <mzhivich@akamai.com>,
        "malat\\@debian.org" <malat@debian.org>,
        "piecuch@protonmail.com" <piecuch@protonmail.com>
Reply-To: Krzysztof Piecuch <piecuch@protonmail.com>
Subject: [PATCH] x86/tsc: Add tsc_early_khz command line parameter overriding early TSC calibration
Message-ID: <O2CpIOrqLZHgNRkfjRpz_LGqnc1ix_seNIiOCvHY4RHoulOVRo6kMXKuLOfBVTi0SMMevg6Go1uZ_cL9fLYtYdTRNH78ChaFaZyG3VAyYz8=@protonmail.com>
Feedback-ID: krphKiiPlx_XKIryTSpdJ_XtBwogkHXWA-Us-PsTeaBSrzOTAKWxwbFkseT4Z85b_7PMRvSnq3Ah7f9INXrOMw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing base clock frequency directly impacts TSC Hz but not CPUID.16h
value. An overclocked CPU supporting CPUID.16h and with partial CPUID.15h
support will set TSC Hz according to "best guess" given by CPUID.16h
relying on tsc_refine_calibration_work to give better numbers later.
tsc_refine_calibration_work will refuse to do its work when the outcome is
off the early TSC Hz value by more than 1% which is certain to happen
on an overclocked system.

Fix this by adding a tsc_early_khz command line parameter that makes the
kernel skip early TSC calibration and use the given value instead.
This allows the user to provide the expected TSC frequency that is closer
to reality than the one reported by the hardware, enabling
tsc_refine_calibration_work to do meaningful error checking.

Signed-off-by: Krzysztof Piecuch <piecuch@protonmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 arch/x86/kernel/tsc.c                           | 16 +++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
index ade4e6ec23e0..28646ea99549 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4905,6 +4905,12 @@
 =09=09=09interruptions from clocksource watchdog are not
 =09=09=09acceptable).

+=09tsc_early_khz=3D  [X86] Skip early TSC calibration and use the given
+=09=09=09value instead. Useful when the early TSC frequency discovery
+=09=09=09procedure is not reliable, such as on overclocked systems
+=09=09=09with CPUID.16h support and partial CPUID.15h support.
+=09=09=09Format: <unsigned int>
+
 =09tsx=3D=09=09[X86] Control Transactional Synchronization
 =09=09=09Extensions (TSX) feature in Intel processors that
 =09=09=09support TSX control.
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 7e322e2daaf5..9566a50f9fdb 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -41,6 +41,7 @@ EXPORT_SYMBOL(tsc_khz);
  * TSC can be unstable due to cpufreq or due to unsynced TSCs
  */
 static int __read_mostly tsc_unstable;
+static unsigned int __read_mostly tsc_early_khz;

 static DEFINE_STATIC_KEY_FALSE(__use_tsc);

@@ -59,6 +60,16 @@ struct cyc2ns {

 static DEFINE_PER_CPU_ALIGNED(struct cyc2ns, cyc2ns);

+static int __init tsc_early_khz_setup(char *buf)
+{
+=09int err =3D kstrtouint(buf, 0, &tsc_early_khz);
+
+=09if (err)
+=09=09tsc_early_khz =3D 0;
+=09return err;
+}
+early_param("tsc_early_khz", tsc_early_khz_setup);
+
 __always_inline void cyc2ns_read_begin(struct cyc2ns_data *data)
 {
 =09int seq, idx;
@@ -1404,7 +1415,10 @@ static bool __init determine_cpu_tsc_frequencies(boo=
l early)

 =09if (early) {
 =09=09cpu_khz =3D x86_platform.calibrate_cpu();
-=09=09tsc_khz =3D x86_platform.calibrate_tsc();
+=09=09if (tsc_early_khz)
+=09=09=09tsc_khz =3D tsc_early_khz;
+=09=09else
+=09=09=09tsc_khz =3D x86_platform.calibrate_tsc();
 =09} else {
 =09=09/* We should not be here with non-native cpu calibration */
 =09=09WARN_ON(x86_platform.calibrate_cpu !=3D native_calibrate_cpu);
--
2.17.1

