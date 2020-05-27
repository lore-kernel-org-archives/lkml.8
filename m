Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9898DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 695C92073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qkjZeK1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgE0WrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgE0WrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:47:20 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06080C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:47:20 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id t24so3147623qtj.15
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+W4lF7UtJVbGRkFSPB+ui5gTLdR8hGilHFdC/hRQAXM=;
        b=qkjZeK1KixBHbAdBl1mURobDnN4wJvkEKoPoyzvD5MTIkhRTfHf20l1PjNgMPN7r+E
         s38wLvtUBs6EJXniHVi/HYV6fJKf7z+8yoaKQd0ddtKafxu1vARrJCsikBgbkM9jgpSn
         HGcWYDS1MxVdE//7q4k1uXc5x0WVpDFQzMxhEZDapDpxpN2AfsJBVhXr5Qcc7FuZNuyR
         uuQDppUMWtDWhqwbqwr5WmncfndjhrNxfsc+jwi4/dVVDkxpIXEhGpYYPImbdM4O0Fkx
         nRwFA/bWy4Q+kBmBd5GTzJl18o8ZMqs0sppKDCHEHs3Tn7owfGBSeBDjUpxYUidZ2ncA
         upaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+W4lF7UtJVbGRkFSPB+ui5gTLdR8hGilHFdC/hRQAXM=;
        b=WVB44tMPJPbCH5JzyjhNeNdtzmpGhWKdN/24Cay8uI/5Bnu4dXYCO9ivs/v54m7col
         m6CCuo1OvQNFCyStXyLfWh19/NlSO0FCqcESyFV2ahHaDVhDnFH2yBQwBonqdc6S74Hf
         swlDSKwOSPxopnjd3Ynyx7axArjvG5xEgL+KVBD6Nw5kaBjQwzA/FU8+KLOl3vHgxmsP
         dDO/QmDrfuoS1zqE89WcJhy7+7AURXOLgBWBWJBfbnM9UEFpIyO8O0Vz/ZwKVZ+SIXCY
         llO5GM0AukhyGuEms/tCwJU6erBqt33ksCQN7awclWz8PSK7JNlUyIyKrrKFtiNzhsC6
         y10g==
X-Gm-Message-State: AOAM533DIk00ZkI2duYOsCVsp1R4spVb1k/OExcVIxaTpy/zOgVyeycY
        tJfUmzJlWfk64FBoVxcSDKU8iS7B8nSNsEy8BuiTkXDPEyNLe8hQ1e2TPeyeEsEC6Om1hpq3NdF
        WJFSksIt9PW94Nv0KZKr2S6wqhC9Uj3jFWYUS9SS9z9lBDJRqzsV5J3ZguzLh7P81TkAzhMk9
X-Google-Smtp-Source: ABdhPJzwMdRUDBmp9VZZQ7tjW98z69fblvDb+plo64yHST0pOeNuAIEQgnz4/UNnHraJPMoP5E8t1YBTc+uS
X-Received: by 2002:a05:6214:1447:: with SMTP id b7mr286273qvy.83.1590619639098;
 Wed, 27 May 2020 15:47:19 -0700 (PDT)
Date:   Wed, 27 May 2020 15:46:59 -0700
In-Reply-To: <20200527224659.206129-1-eranian@google.com>
Message-Id: <20200527224659.206129-6-eranian@google.com>
Mime-Version: 1.0
References: <20200527224659.206129-1-eranian@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v2 5/5] perf/x86/rapl: add AMD Fam17h RAPL support
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
 arch/x86/events/rapl.c           | 18 ++++++++++++++++++
 arch/x86/include/asm/msr-index.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index fcb21fbcfe0d0..4ed95d03f2a74 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -537,6 +537,16 @@ static struct perf_msr intel_rapl_msrs[] = {
 	[PERF_RAPL_PSYS] = { MSR_PLATFORM_ENERGY_STATUS, &rapl_events_psys_group,  test_msr },
 };
 
+/*
+ * force to PERF_RAPL_MAX size due to:
+ * - perf_msr_probe(PERF_RAPL_MAX)
+ * - want to use same event codes across both architectures
+ */
+static struct perf_msr amd_rapl_msrs[PERF_RAPL_MAX] = {
+	[PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr },
+};
+
+
 static int rapl_cpu_offline(unsigned int cpu)
 {
 	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
@@ -740,6 +750,13 @@ static struct rapl_model model_skl = {
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
@@ -768,6 +785,7 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
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
2.27.0.rc0.183.gde8f92d652-goog

