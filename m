Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F85EC52D59
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB09021D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813636;
	bh=JI9fVbysw8MJNXzuudnRo9dSCuDCC2WnuoMEA9dZJoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xtfRrnZjXLDw+oZNWxMmpln/ZEyJO4hVx4TeC19wEb2kVuQoqKu8nI9eklTXX2Sbb
	 r5nLKrrJfWUx8iOtFh1diJrH2ETZNyXSr+zlsytFdW7cJgrGexSLuNQQufJStwZ9Qn
	 pUhmWwX7MD5HS2FrAh3OCZHPovJuTEt8ltUTXxkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388343AbgB0OJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:09:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388311AbgB0OI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:08:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE4432468D;
        Thu, 27 Feb 2020 14:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812536;
        bh=JI9fVbysw8MJNXzuudnRo9dSCuDCC2WnuoMEA9dZJoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iMMSOsF4FFDzPca2+fHqKiBGuMbR9VErCpG+J+PW6HolocTF/EfE4yqyUicKaFiF9
         OjDeS2yDB2L353F8bgDnxojSBTusV0l7coAa9oEi6Jbv6OnLk1CR6GkzAc85iF6FbO
         OUS4ADrR63MB5Z0BAPCaYSto0NkdrjGzAocUaOvo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kim Phillips <kim.phillips@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5.4 054/135] x86/cpu/amd: Enable the fixed Instructions Retired counter IRPERF
Date:   Thu, 27 Feb 2020 14:36:34 +0100
Message-Id: <20200227132237.238373577@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132228.710492098@linuxfoundation.org>
References: <20200227132228.710492098@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

commit 21b5ee59ef18e27d85810584caf1f7ddc705ea83 upstream.

Commit

  aaf248848db50 ("perf/x86/msr: Add AMD IRPERF (Instructions Retired)
		  performance counter")

added support for access to the free-running counter via 'perf -e
msr/irperf/', but when exercised, it always returns a 0 count:

BEFORE:

  $ perf stat -e instructions,msr/irperf/ true

   Performance counter stats for 'true':

             624,833      instructions
                   0      msr/irperf/

Simply set its enable bit - HWCR bit 30 - to make it start counting.

Enablement is restricted to all machines advertising IRPERF capability,
except those susceptible to an erratum that makes the IRPERF return
bad values.

That erratum occurs in Family 17h models 00-1fh [1], but not in F17h
models 20h and above [2].

AFTER (on a family 17h model 31h machine):

  $ perf stat -e instructions,msr/irperf/ true

   Performance counter stats for 'true':

             621,690      instructions
             622,490      msr/irperf/

[1] Revision Guide for AMD Family 17h Models 00h-0Fh Processors
[2] Revision Guide for AMD Family 17h Models 30h-3Fh Processors

The revision guides are available from the bugzilla Link below.

 [ bp: Massage commit message. ]

Fixes: aaf248848db50 ("perf/x86/msr: Add AMD IRPERF (Instructions Retired) performance counter")
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Link: http://lkml.kernel.org/r/20200214201805.13830-1-kim.phillips@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/msr-index.h |    2 ++
 arch/x86/kernel/cpu/amd.c        |   14 ++++++++++++++
 2 files changed, 16 insertions(+)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -510,6 +510,8 @@
 #define MSR_K7_HWCR			0xc0010015
 #define MSR_K7_HWCR_SMMLOCK_BIT		0
 #define MSR_K7_HWCR_SMMLOCK		BIT_ULL(MSR_K7_HWCR_SMMLOCK_BIT)
+#define MSR_K7_HWCR_IRPERF_EN_BIT	30
+#define MSR_K7_HWCR_IRPERF_EN		BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
 #define MSR_K7_FID_VID_CTL		0xc0010041
 #define MSR_K7_FID_VID_STATUS		0xc0010042
 
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -28,6 +28,7 @@
 
 static const int amd_erratum_383[];
 static const int amd_erratum_400[];
+static const int amd_erratum_1054[];
 static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum);
 
 /*
@@ -978,6 +979,15 @@ static void init_amd(struct cpuinfo_x86
 	/* AMD CPUs don't reset SS attributes on SYSRET, Xen does. */
 	if (!cpu_has(c, X86_FEATURE_XENPV))
 		set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
+
+	/*
+	 * Turn on the Instructions Retired free counter on machines not
+	 * susceptible to erratum #1054 "Instructions Retired Performance
+	 * Counter May Be Inaccurate".
+	 */
+	if (cpu_has(c, X86_FEATURE_IRPERF) &&
+	    !cpu_has_amd_erratum(c, amd_erratum_1054))
+		msr_set_bit(MSR_K7_HWCR, MSR_K7_HWCR_IRPERF_EN_BIT);
 }
 
 #ifdef CONFIG_X86_32
@@ -1105,6 +1115,10 @@ static const int amd_erratum_400[] =
 static const int amd_erratum_383[] =
 	AMD_OSVW_ERRATUM(3, AMD_MODEL_RANGE(0x10, 0, 0, 0xff, 0xf));
 
+/* #1054: Instructions Retired Performance Counter May Be Inaccurate */
+static const int amd_erratum_1054[] =
+	AMD_OSVW_ERRATUM(0, AMD_MODEL_RANGE(0x17, 0, 0, 0x2f, 0xf));
+
 
 static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum)
 {


