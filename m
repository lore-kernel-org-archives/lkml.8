Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8BDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8726520671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ScF/vljj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgEOV6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 17:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbgEOV6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 17:58:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F617C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 14:58:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y7so4250193ybj.15
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 14:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GTVuWwS2hblHClQm8gIFz7ihw1x99scmM3jSEY3TZaU=;
        b=ScF/vljjjOsoUAb5eKQehk5LdUROhB34RIBR84M41ZsXhMv0d/atJP7umjBss/Egu/
         w7fiy1x6T9JcSbJP6FXR64pddeDbHFmDgqqeTJWQ/4N458sqSXARPxOqGl5GTyIHyhW5
         ylHimsKfLfytO/ZIV4TvYSPBSCFCGUJoDLPOdbtRS3CBBNFyvuRhgLB7NFRXfxEIoH/v
         jABZSzkqgWzY1Pb/HpGNMu3g/QXoPYFsNlepvBSj3jjR1MnnY6jZCw3KlY5FMdgGbn3Z
         vohIko2feeuCPsmRq+nsMZk/8r5P+DXa2y9DHdea89nVgbzkxGBaaYCeY8szGRGOOYI9
         /PrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GTVuWwS2hblHClQm8gIFz7ihw1x99scmM3jSEY3TZaU=;
        b=QEqTbJmFzCtzWGeIz0rpq8O4nsb7g8Z/fjcqBWtEMyDhWXJ+XR7h7CLd+7MsWB+po5
         Ik8I9k3CxuKUaPLsDeG+C5X57wp+LYUSUO6X0QXDL6AmJu9gLOUs6cZ4VGG7m+wPFzQE
         kX217bi+QOCIi0+d7GohP5rCi6OkKH5pjxbpduFLoN3fhvjCWigcDDxTrKz1iCbzTejM
         YRNWWFJKyqCO0Wi3VlN3IsWQK0z3wxhK9QFOpBstUwIHYkaoLqMYG0TK+XlNfNsEbCzB
         Kybf/nOPM7UP0YKmfcyr+joiBOePmsUmKmNLUszAC/LbcNdN2eIdG/itFigDGeM2wAhc
         OMKg==
X-Gm-Message-State: AOAM531x01VJN/EQgrh+n6oGKF7WT+EgbM3LPdYCLrqn5748QQW/QmZ8
        p12cb9pghaFDIoCEX38CjJ5guTdAOJIybWUIM1uPw2RPEFil9uXwQgc9GtGp1ldXsnt9QmPoUaS
        VpXELf2mrg+PFmYssSBf1iOpLk9Tm0GS7L01C8UHTXZlFBC9igzgxPZ8DFrkPCsfPF4HMMonK
X-Google-Smtp-Source: ABdhPJwZut710qxlwIxovaUUaQ0Jr79UHVEgwWahC9eiK8PwumVIcyXk0NuUUUDUUfcvcnk8cu0/bg98diIE
X-Received: by 2002:a25:a06:: with SMTP id 6mr8811658ybk.238.1589579886553;
 Fri, 15 May 2020 14:58:06 -0700 (PDT)
Date:   Fri, 15 May 2020 14:57:33 -0700
In-Reply-To: <20200515215733.20647-1-eranian@google.com>
Message-Id: <20200515215733.20647-4-eranian@google.com>
Mime-Version: 1.0
References: <20200515215733.20647-1-eranian@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH 3/3] perf/x86/rapl: add AMD Fam17h RAPL support
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@elte.hu, irogers@google.com,
        kim.phillips@amd.com, jolsa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables AMD Fam17h RAPL support for the Package level metric.
The support is as per AMD Fam17h Model31h (Zen2) and model 00-ffh (Zen1) PPR.

The same output is available via the energy-pkg pseudo event:

$ perf stat -a -I 1000 --per-socket -e power/energy-pkg/

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/probe.c          |  4 ++++
 arch/x86/events/rapl.c           | 17 +++++++++++++++++
 arch/x86/include/asm/msr-index.h |  3 +++
 3 files changed, 24 insertions(+)

diff --git a/arch/x86/events/probe.c b/arch/x86/events/probe.c
index c2ede2f3b2770..b3a9df2e48dfa 100644
--- a/arch/x86/events/probe.c
+++ b/arch/x86/events/probe.c
@@ -26,6 +26,10 @@ perf_msr_probe(struct perf_msr *msr, int cnt, bool zero, void *data)
 
 			grp->is_visible = not_visible;
 
+			/* avoid unpopulated entries */
+			if (!msr[bit].msr)
+				continue;
+
 			if (msr[bit].test && !msr[bit].test(bit, data))
 				continue;
 			/* Virt sucks; you cannot tell if a R/O MSR is present :/ */
diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index e98f627a13fa8..47ff20dfde889 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -526,6 +526,15 @@ static struct perf_msr intel_rapl_msrs[] = {
 	[PERF_RAPL_PSYS] = { MSR_PLATFORM_ENERGY_STATUS, &rapl_events_psys_group,  test_msr },
 };
 
+static struct perf_msr amd_rapl_msrs[] = {
+	[PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, NULL},
+	[PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr },
+	[PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   NULL},
+	[PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   NULL},
+	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL},
+};
+
+
 static int rapl_cpu_offline(unsigned int cpu)
 {
 	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
@@ -729,6 +738,13 @@ static struct rapl_model model_skl = {
 	.rapl_msrs      = intel_rapl_msrs,
 };
 
+static struct rapl_model model_amd_fam17h = {
+	.events		= BIT(PERF_RAPL_PKG),
+	.apply_quirk	= false,
+	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
+	.rapl_msrs      = amd_rapl_msrs,
+};
+
 static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&model_snb),
 	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&model_snbep),
@@ -757,6 +773,7 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&model_skl),
+	X86_MATCH_VENDOR_FAM(AMD, 0x17, &model_amd_fam17h),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 12c9684d59ba6..ef452b817f44f 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -301,6 +301,9 @@
 #define MSR_PP1_ENERGY_STATUS		0x00000641
 #define MSR_PP1_POLICY			0x00000642
 
+#define MSR_AMD_PKG_ENERGY_STATUS	0xc001029b
+#define MSR_AMD_RAPL_POWER_UNIT		0xc0010299
+
 /* Config TDP MSRs */
 #define MSR_CONFIG_TDP_NOMINAL		0x00000648
 #define MSR_CONFIG_TDP_LEVEL_1		0x00000649
-- 
2.26.2.761.g0e0b3e54be-goog

