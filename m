Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F958C3F36B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E849921D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811559;
	bh=dOo1aVw4V9u11zlErQFApZyURjETEfSHyBTk7erGGMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w1WrB6xTfPBi/tWSLSG3JNWu0PxHF6zkus8DqvpIGrTUtngmDTeFn0pUJBcwKNFMI
	 yjIHTJdmK+IED7gGQ2JnbpHA2UzFP+y8BmoiPkFsXYa5qL3XVOfeYglPKnBeAeb5rt
	 FjByC1/tSYfb6WfevCw8lcCTPjDpaleE2KBo4YIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbgB0Nwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:52:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:52048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731160AbgB0Nwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:52:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6133720578;
        Thu, 27 Feb 2020 13:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811550;
        bh=dOo1aVw4V9u11zlErQFApZyURjETEfSHyBTk7erGGMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C+COqB1J4PpFr99og1NFMMwk3Iewt9N2LwonPeHTGt3nKc+AA/mZR/+jvaL7hoLxj
         c2k2UURC7gHXEJQFtmvnN9YGTbFkhtBPIluQQd3E5Sm7Ru8MceHdh+j8ZZ6+bwHwVX
         8zqYVXdRsrEFyJzyO3UxCkUB+yalCdu0Alx1Kd1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 011/237] arm64: cpufeature: Set the FP/SIMD compat HWCAP bits properly
Date:   Thu, 27 Feb 2020 14:33:45 +0100
Message-Id: <20200227132256.788124184@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

commit 7559950aef1ab8792c50797c6c5c7c5150a02460 upstream

We set the compat_elf_hwcap bits unconditionally on arm64 to
include the VFP and NEON support. However, the FP/SIMD unit
is optional on Arm v8 and thus could be missing. We already
handle this properly in the kernel, but still advertise to
the COMPAT applications that the VFP is available. Fix this
to make sure we only advertise when we really have them.

Cc: stable@vger.kernel.org # v4.14
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 52 +++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index c477fd34a9120..6b3bb67596ae8 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -41,9 +41,7 @@ EXPORT_SYMBOL_GPL(elf_hwcap);
 #define COMPAT_ELF_HWCAP_DEFAULT	\
 				(COMPAT_HWCAP_HALF|COMPAT_HWCAP_THUMB|\
 				 COMPAT_HWCAP_FAST_MULT|COMPAT_HWCAP_EDSP|\
-				 COMPAT_HWCAP_TLS|COMPAT_HWCAP_VFP|\
-				 COMPAT_HWCAP_VFPv3|COMPAT_HWCAP_VFPv4|\
-				 COMPAT_HWCAP_NEON|COMPAT_HWCAP_IDIV|\
+				 COMPAT_HWCAP_TLS|COMPAT_HWCAP_IDIV|\
 				 COMPAT_HWCAP_LPAE)
 unsigned int compat_elf_hwcap __read_mostly = COMPAT_ELF_HWCAP_DEFAULT;
 unsigned int compat_elf_hwcap2 __read_mostly;
@@ -1134,17 +1132,30 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{},
 };
 
-#define HWCAP_CAP(reg, field, s, min_value, cap_type, cap)	\
-	{							\
-		.desc = #cap,					\
-		.type = ARM64_CPUCAP_SYSTEM_FEATURE,		\
+
+#define HWCAP_CPUID_MATCH(reg, field, s, min_value)		\
 		.matches = has_cpuid_feature,			\
 		.sys_reg = reg,					\
 		.field_pos = field,				\
 		.sign = s,					\
 		.min_field_value = min_value,			\
+
+#define __HWCAP_CAP(name, cap_type, cap)			\
+		.desc = name,					\
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,		\
 		.hwcap_type = cap_type,				\
 		.hwcap = cap,					\
+
+#define HWCAP_CAP(reg, field, s, min_value, cap_type, cap)	\
+	{							\
+		__HWCAP_CAP(#cap, cap_type, cap)		\
+		HWCAP_CPUID_MATCH(reg, field, s, min_value)	\
+	}
+
+#define HWCAP_CAP_MATCH(match, cap_type, cap)			\
+	{							\
+		__HWCAP_CAP(#cap, cap_type, cap)		\
+		.matches = match,				\
 	}
 
 static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
@@ -1177,8 +1188,35 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	{},
 };
 
+#ifdef CONFIG_COMPAT
+static bool compat_has_neon(const struct arm64_cpu_capabilities *cap, int scope)
+{
+	/*
+	 * Check that all of MVFR1_EL1.{SIMDSP, SIMDInt, SIMDLS} are available,
+	 * in line with that of arm32 as in vfp_init(). We make sure that the
+	 * check is future proof, by making sure value is non-zero.
+	 */
+	u32 mvfr1;
+
+	WARN_ON(scope == SCOPE_LOCAL_CPU && preemptible());
+	if (scope == SCOPE_SYSTEM)
+		mvfr1 = read_sanitised_ftr_reg(SYS_MVFR1_EL1);
+	else
+		mvfr1 = read_sysreg_s(SYS_MVFR1_EL1);
+
+	return cpuid_feature_extract_unsigned_field(mvfr1, MVFR1_SIMDSP_SHIFT) &&
+		cpuid_feature_extract_unsigned_field(mvfr1, MVFR1_SIMDINT_SHIFT) &&
+		cpuid_feature_extract_unsigned_field(mvfr1, MVFR1_SIMDLS_SHIFT);
+}
+#endif
+
 static const struct arm64_cpu_capabilities compat_elf_hwcaps[] = {
 #ifdef CONFIG_COMPAT
+	HWCAP_CAP_MATCH(compat_has_neon, CAP_COMPAT_HWCAP, COMPAT_HWCAP_NEON),
+	HWCAP_CAP(SYS_MVFR1_EL1, MVFR1_SIMDFMAC_SHIFT, FTR_UNSIGNED, 1, CAP_COMPAT_HWCAP, COMPAT_HWCAP_VFPv4),
+	/* Arm v8 mandates MVFR0.FPDP == {0, 2}. So, piggy back on this for the presence of VFP support */
+	HWCAP_CAP(SYS_MVFR0_EL1, MVFR0_FPDP_SHIFT, FTR_UNSIGNED, 2, CAP_COMPAT_HWCAP, COMPAT_HWCAP_VFP),
+	HWCAP_CAP(SYS_MVFR0_EL1, MVFR0_FPDP_SHIFT, FTR_UNSIGNED, 2, CAP_COMPAT_HWCAP, COMPAT_HWCAP_VFPv3),
 	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_AES_SHIFT, FTR_UNSIGNED, 2, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_PMULL),
 	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_AES_SHIFT, FTR_UNSIGNED, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_AES),
 	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_SHA1_SHIFT, FTR_UNSIGNED, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_SHA1),
-- 
2.20.1



