Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7093EC33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 09:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465A82467A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 09:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579082297;
	bh=h6zCE0q6DO1rnPqpR4VKOLirQ6rXBOlucf/Pdr3iGhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RFgn6q1e6pL7qUULWKwdU7CF4Flehq6i2uvBTTvrh3xXo/zQjLAg7x0zSRxufanL2
	 SGFrllnrMl/BbkZI4tQZZVj5fMaopsmv491eZ6T4BdBe6iQHo0XCDpSkhLxekmJ+Tf
	 CKF3DjwmTOC/wAONpKj6/FGvD/XjMTv/CXCtz7JM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgAOJ6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 04:58:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:50174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729532AbgAOJ6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 04:58:16 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49A2E207FF;
        Wed, 15 Jan 2020 09:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579082295;
        bh=h6zCE0q6DO1rnPqpR4VKOLirQ6rXBOlucf/Pdr3iGhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ntVKidoCwc/REx7d3xtVRIRcqEeC/ILpT+VwTyu9Dp+vdEim3PyRmPMGeJExhqrF8
         bqheIe6iQZhB6aqNjJQcx6HAxgSbtukgRpYETrbkUd1F89UVd/Sp1KwLdVYhHnspyU
         4eH3BWkBkVllZhy41HNEXokIiWie35dUrJFa+zVE=
Date:   Wed, 15 Jan 2020 09:58:11 +0000
From:   Will Deacon <will@kernel.org>
To:     Steven Price <steven.price@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, julien@xen.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v2] arm64: cpufeature: Export matrix and other features
 to userspace
Message-ID: <20200115095810.GD21692@willie-the-truck>
References: <20191216113337.13882-1-steven.price@arm.com>
 <20200115094916.GC21692@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115094916.GC21692@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 09:49:17AM +0000, Will Deacon wrote:
> In other words, I'll drop the SPECRES parts from this patch. Sound ok?

Diff below.

Will

--->8

diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
index 5382981533f8..27877d25dd9b 100644
--- a/Documentation/arm64/cpu-feature-registers.rst
+++ b/Documentation/arm64/cpu-feature-registers.rst
@@ -206,8 +206,6 @@ infrastructure:
      +------------------------------+---------+---------+
      | BF16                         | [47-44] |    y    |
      +------------------------------+---------+---------+
-     | SPECRES                      | [43-40] |    y    |
-     +------------------------------+---------+---------+
      | SB                           | [39-36] |    y    |
      +------------------------------+---------+---------+
      | FRINTTS                      | [35-32] |    y    |
diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
index 183ba86ad46e..4fafc57d8e73 100644
--- a/Documentation/arm64/elf_hwcaps.rst
+++ b/Documentation/arm64/elf_hwcaps.rst
@@ -232,10 +232,6 @@ HWCAP2_DGH
 
     Functionality implied by ID_AA64ISAR1_EL1.DGH == 0b0001.
 
-HWCAP2_SPECRES
-
-    Functionality implied by ID_AA64ISAR1_EL1.SPECRES == 0b0001.
-
 4. Unused AT_HWCAP bits
 -----------------------
 
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index ac7180b2c20b..fcb390ea29ea 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -93,7 +93,6 @@
 #define KERNEL_HWCAP_I8MM		__khwcap2_feature(I8MM)
 #define KERNEL_HWCAP_DGH		__khwcap2_feature(DGH)
 #define KERNEL_HWCAP_BF16		__khwcap2_feature(BF16)
-#define KERNEL_HWCAP_SPECRES		__khwcap2_feature(SPECRES)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 8f3f1b66f7b2..e6dad5924703 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -72,6 +72,5 @@
 #define HWCAP2_I8MM		(1 << 13)
 #define HWCAP2_BF16		(1 << 14)
 #define HWCAP2_DGH		(1 << 15)
-#define HWCAP2_SPECRES		(1 << 16)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9164ee5351a4..c88f8fb80e2e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -138,7 +138,7 @@ static const struct arm64_ftr_bits ftr_id_aa64isar1[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_I8MM_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_DGH_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_BF16_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_SPECRES_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_SPECRES_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_SB_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_FRINTTS_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_PTR_AUTH),
@@ -1678,7 +1678,6 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_LRCPC_SHIFT, FTR_UNSIGNED, 2, CAP_HWCAP, KERNEL_HWCAP_ILRCPC),
 	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_FRINTTS_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_FRINT),
 	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_SB_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_SB),
-	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_SPECRES_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_SPECRES),
 	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_BF16_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_BF16),
 	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_DGH_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_DGH),
 	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_I8MM_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_I8MM),
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index c689e26889c7..9013b224591a 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -91,7 +91,6 @@ static const char *const hwcap_str[] = {
 	"i8mm",
 	"bf16",
 	"dgh",
-	"specres",
 	NULL
 };
 
