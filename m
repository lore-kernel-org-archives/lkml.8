Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F3CC433FC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C96F82080D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MVr23i9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbgGVQpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 12:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbgGVQpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 12:45:06 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C24EC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 09:45:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o11so2556675wrv.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 09:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UzkCazi9IF2R2fovvI4XRbgeSUfI2aZOTLYWCOQmH7Y=;
        b=MVr23i9EY3adsavlnzqKlwywAbRQmWnYu/O0PqHFO5h2mZINEVU5vdwtCNcmVIzmqc
         HuDpvw4REHKGW2v9gawHMWOspu7nYKIcm7m1oe8P0DG0AG/jVj8RQJM+fncEU8eAoeFW
         Q4grx48wtHAnOBBbFmFB/F65EWt+ytE4kp9aCo51/gz5p+jKu5T4002eOYPYmq7uEzE1
         NJ+zdUhBvFRvtHM/RZLaDZ3LPvYeZlJRJrm4vb3JYln4uQgm1YmjZZ9WkIcvE4+s0QMo
         wpBITPMxNDcLOEuTS6TvgjT2x1TCzG34+CS/lKZmQkI5ELNGsHGz5y5Vo26RHLtMkgdF
         k+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UzkCazi9IF2R2fovvI4XRbgeSUfI2aZOTLYWCOQmH7Y=;
        b=Hy5vB/Ft2357FpowEqC6wEd0mLh0yG+Mlb+Ndwh2AiFwC5oLxoAtuyim8pt50V6vEH
         6pWsvLxxSLZCBgK6kVarLpzJI0GQpDm8mIKAjPWtynX4pl+OVK3SDjet1L3tPIQwT38J
         BAlSuhvNvR/JIwVjRM0E3mhHlDhKMGOKpg/04LxAehN2z67xDstgZLk/dY0SuIPnYsQV
         m0+pJzzS3e4ZcdTcuDW+V/9jnvD5roqr2/iAEv3hLwVxSJTxw7drvZcUWNFAklyPkEeX
         y3nMdzqgZbMe6658V9kVl1f/dAFIWC9dWOjmauJ2GuG4VRHEt7k2pV2XTb0+AJ8crFni
         WFLg==
X-Gm-Message-State: AOAM531VXPBMujVa8bBGA7IdJ+lfgCgw7bv3eM84vSz5vOUw6wwhVyXG
        eH1hzqgOfKl3LatnmwLC+bN0Sg==
X-Google-Smtp-Source: ABdhPJx/qEkJrXuwujIJYy6c8DcTNrb907z4XGsmWjlpmktsrboRRdsmuZeU2BTNkn5zyZPYZ1dJqQ==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr417138wrs.228.1595436304534;
        Wed, 22 Jul 2020 09:45:04 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:b0ee:900a:e004:b9d0])
        by smtp.gmail.com with ESMTPSA id 2sm250421wmo.44.2020.07.22.09.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 09:45:03 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@google.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 3/9] kvm: arm64: Remove hyp_adr/ldr_this_cpu
Date:   Wed, 22 Jul 2020 17:44:18 +0100
Message-Id: <20200722164424.42225-4-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722164424.42225-1-dbrazdil@google.com>
References: <20200722164424.42225-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hyp_adr/ldr_this_cpu helpers were introduced for use in hyp code because
they always needed to use TPIDR_EL2 for base, while adr/ldr_this_cpu from
kernel proper would select between TPIDR_EL2 and _EL1 based on VHE/nVHE.

Simplify this now that the nVHE hyp mode case can be handled using the
__KVM_NVHE_HYPERVISOR__ macro. VHE hyp code selects _EL2 with alternatives.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/assembler.h | 27 +++++++++++++++++----------
 arch/arm64/include/asm/kvm_asm.h   | 14 +-------------
 arch/arm64/kvm/hyp/hyp-entry.S     |  2 +-
 3 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 54d181177656..b392a977efb6 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -218,6 +218,21 @@ lr	.req	x30		// link register
 	str	\src, [\tmp, :lo12:\sym]
 	.endm
 
+	/*
+	 * @dst: destination register (32 or 64 bit wide)
+	 */
+	.macro	this_cpu_offset, dst
+#ifdef __KVM_NVHE_HYPERVISOR__
+	mrs	\dst, tpidr_el2
+#else
+alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
+	mrs	\dst, tpidr_el1
+alternative_else
+	mrs	\dst, tpidr_el2
+alternative_endif
+#endif
+	.endm
+
 	/*
 	 * @dst: Result of per_cpu(sym, smp_processor_id()) (can be SP)
 	 * @sym: The name of the per-cpu variable
@@ -226,11 +241,7 @@ lr	.req	x30		// link register
 	.macro adr_this_cpu, dst, sym, tmp
 	adrp	\tmp, \sym
 	add	\dst, \tmp, #:lo12:\sym
-alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
-	mrs	\tmp, tpidr_el1
-alternative_else
-	mrs	\tmp, tpidr_el2
-alternative_endif
+	this_cpu_offset \tmp
 	add	\dst, \dst, \tmp
 	.endm
 
@@ -241,11 +252,7 @@ alternative_endif
 	 */
 	.macro ldr_this_cpu dst, sym, tmp
 	adr_l	\dst, \sym
-alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
-	mrs	\tmp, tpidr_el1
-alternative_else
-	mrs	\tmp, tpidr_el2
-alternative_endif
+	this_cpu_offset \tmp
 	ldr	\dst, [\dst, \tmp]
 	.endm
 
diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index da4a0826cacd..bbd14e205aba 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -151,20 +151,8 @@ extern char __smccc_workaround_1_smc[__SMCCC_WORKAROUND_1_SMC_SZ];
 
 #else /* __ASSEMBLY__ */
 
-.macro hyp_adr_this_cpu reg, sym, tmp
-	adr_l	\reg, \sym
-	mrs	\tmp, tpidr_el2
-	add	\reg, \reg, \tmp
-.endm
-
-.macro hyp_ldr_this_cpu reg, sym, tmp
-	adr_l	\reg, \sym
-	mrs	\tmp, tpidr_el2
-	ldr	\reg,  [\reg, \tmp]
-.endm
-
 .macro get_host_ctxt reg, tmp
-	hyp_adr_this_cpu \reg, kvm_host_data, \tmp
+	adr_this_cpu \reg, kvm_host_data, \tmp
 	add	\reg, \reg, #HOST_DATA_CONTEXT
 .endm
 
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 689fccbc9de7..0a0cb1d3acd3 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -108,7 +108,7 @@ alternative_cb_end
 	str	x0, [x2, #VCPU_WORKAROUND_FLAGS]
 
 	/* Check that we actually need to perform the call */
-	hyp_ldr_this_cpu x0, arm64_ssbd_callback_required, x2
+	ldr_this_cpu x0, arm64_ssbd_callback_required, x2
 	cbz	x0, wa2_end
 
 	mov	w0, #ARM_SMCCC_ARCH_WORKAROUND_2
-- 
2.27.0

