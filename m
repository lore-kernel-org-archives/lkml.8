Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F38C4BA18
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE7124670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaZGoS9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgBZQn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:43:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32558 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726214AbgBZQn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582735407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sE1NdjxwrRYWFMPfmNxlgM+W5OTCkbL8wxbNxVCasR8=;
        b=JaZGoS9cQ8pjYWyQO34U4kUUsITvz4ozxaiodR9Nhon0KzBVqNWHdUfZGdKcPISDJOMHGc
        yMrzLubSiGOAn+hXmwR5shdoCKSXrW9t4n+wdfU1L5fdecP73Kt8BD7UMD4YuhqPbK6KCa
        m9hbA7HnH/Q/+vxO+Ue27xqIlOfCE6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-rWs9osVYPC2teGR0nCK1RQ-1; Wed, 26 Feb 2020 11:43:22 -0500
X-MC-Unique: rWs9osVYPC2teGR0nCK1RQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DEC710937BA;
        Wed, 26 Feb 2020 16:43:19 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A93C15C102;
        Wed, 26 Feb 2020 16:43:16 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Patrick Geary <patrickg@supermicro.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Drake <drake@endlessm.com>,
        Michael Zhivich <mzhivich@akamai.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org
Subject: [PATCH] x86/tsc: Add kernel options to disable CPUID and MSR calibrations
Date:   Wed, 26 Feb 2020 11:43:08 -0500
Message-Id: <20200226164308.14468-1-prarit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have had to debug a few unstable x86 systems that required me to block
the CPUID and MSR calibrations and only use the PIT calibration.  After
blocking the calibrations I was able to debug and find bugs in firmware
that were eventually fixed and resulted in stable systems.

Patrick Geary also posted a similar patch (see link below) that would hav=
e
allowed him to boot overclocked CPUs by skipping the CPUID calibration
which resulted in unstable boots due to timing issues.

Add kernel options to disable the CPUID and MSR calibrations.

Also allow for comma-separated TSC options, for example,

	tsc=3Dno_cpuid_calibration,no_msr_calibration,reliable

Link: https://lore.kernel.org/lkml/fdf96605-a4a0-049b-51c9-1e68cc2a9b93@s=
upermicro.com/#r
Co-developed-by: Patrick Geary <patrickg@supermicro.com>
Signed-off-by: Patrick Geary <patrickg@supermicro.com>
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Daniel Drake <drake@endlessm.com>
Cc: Michael Zhivich <mzhivich@akamai.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-doc@vger.kernel.org
---
 .../admin-guide/kernel-parameters.txt         |  8 +++-
 arch/x86/kernel/tsc.c                         | 44 ++++++++++++++-----
 2 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
index dbc22d684627..0316aadfff08 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4942,7 +4942,7 @@
 			See Documentation/admin-guide/mm/transhuge.rst
 			for more details.
=20
-	tsc=3D		Disable clocksource stability checks for TSC.
+	tsc=3Doption[,option...]	Various TSC options.
 			Format: <string>
 			[x86] reliable: mark tsc clocksource as reliable, this
 			disables clocksource verification at runtime, as well
@@ -4960,6 +4960,12 @@
 			in situations with strict latency requirements (where
 			interruptions from clocksource watchdog are not
 			acceptable).
+			[x86] no_cpuid_calibration: Disable the CPUID TSC
+			calibration.  Used in situations where the CPUID
+			TSC khz does not match the actual CPU TSC khz
+			[x86] no_msr_calibration: Disable the MSR TSC
+			calibration.  Used in situations where the MSR
+			TSC khz does not match the actual CPU TSC khz.
=20
 	tsx=3D		[X86] Control Transactional Synchronization
 			Extensions (TSX) feature in Intel processors that
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 7e322e2daaf5..c949cb833d05 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -45,6 +45,11 @@ static int __read_mostly tsc_unstable;
 static DEFINE_STATIC_KEY_FALSE(__use_tsc);
=20
 int tsc_clocksource_reliable;
+/*
+ * TSC calibration sequence disablement
+ */
+int calibrate_cpuid_khz_enabled =3D 1;
+int calibrate_msr_enabled =3D 1;
=20
 static u32 art_to_tsc_numerator;
 static u32 art_to_tsc_denominator;
@@ -287,14 +292,30 @@ static int no_tsc_watchdog;
=20
 static int __init tsc_setup(char *str)
 {
-	if (!strcmp(str, "reliable"))
-		tsc_clocksource_reliable =3D 1;
-	if (!strncmp(str, "noirqtime", 9))
-		no_sched_irq_time =3D 1;
-	if (!strcmp(str, "unstable"))
-		mark_tsc_unstable("boot parameter");
-	if (!strcmp(str, "nowatchdog"))
-		no_tsc_watchdog =3D 1;
+	while (str) {
+		char *k =3D strchr(str, ',');
+
+		if (k)
+			*k++ =3D 0;
+
+		if (!strcmp(str, "reliable"))
+			tsc_clocksource_reliable =3D 1;
+		if (!strcmp(str, "noirqtime"))
+			no_sched_irq_time =3D 1;
+		if (!strcmp(str, "unstable"))
+			mark_tsc_unstable("boot parameter");
+		if (!strcmp(str, "nowatchdog"))
+			no_tsc_watchdog =3D 1;
+		if (!strcmp(str, "no_cpuid_calibration")) {
+			calibrate_cpuid_khz_enabled =3D 0;
+			pr_info("CPUID khz calibration disabled\n");
+		}
+		if (!strcmp(str, "no_msr_calibration")) {
+			calibrate_cpuid_khz_enabled =3D 0;
+			pr_info("msr calibration disabled\n");
+		}
+		str =3D k;
+	}
 	return 1;
 }
=20
@@ -860,9 +881,12 @@ static unsigned long pit_hpet_ptimer_calibrate_cpu(v=
oid)
  */
 unsigned long native_calibrate_cpu_early(void)
 {
-	unsigned long flags, fast_calibrate =3D cpu_khz_from_cpuid();
+	unsigned long flags, fast_calibrate =3D 0;
+
+	if (calibrate_cpuid_khz_enabled)
+		fast_calibrate =3D cpu_khz_from_cpuid();
=20
-	if (!fast_calibrate)
+	if (!fast_calibrate && calibrate_msr_enabled)
 		fast_calibrate =3D cpu_khz_from_msr();
 	if (!fast_calibrate) {
 		local_irq_save(flags);
--=20
2.21.1

