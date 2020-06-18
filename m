Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17A0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97EA02075E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GEbrZUYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbgFRM2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgFRM0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:26:41 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB36CC06179B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:26:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b6so5830848wrs.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E1RONziHkaXcIbp8EZDtcBXhqYuNXkWrxwk7rGyJjWU=;
        b=GEbrZUYqxyO+kyfPLW1XsrO90u8JIgVJkPp7Ozi4c+c3BAL1hjqsyehMHSraKA9IaF
         iFVKkO6pAzNc1X4cQYOdnMRyAve1mAXOGX3kykmGwsSwV+kD4Hn9EFHcUWruCoVxe/0A
         ErGcs1QOOt7cihX/KUvc0I8ouOORh83beB6KQULWl9r+55Bx85RVg7KTcC6iQVbWmDLP
         EfRtkUPnPFfKS4Y4Llfn2K9nMlRZz2NLNE/KAtkfHAxw9DyALzAC5UGBgYPZezEMj04A
         rHOw1Hu4XAuXLvJTUjAXN5H15zJP+Fo8dwD3GYdAzLaJktcA2MMwG13bVp1Vh6Baku0o
         JxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E1RONziHkaXcIbp8EZDtcBXhqYuNXkWrxwk7rGyJjWU=;
        b=ttTcoeFPCqfz+F4xVzisIcVbOTjUAGTPBN6mH4mfZ5Xd89I9FpfsMX/63hiUZDR3Zr
         OvW89WZXaSfX4q3x9lKl0v2V2ePru9ohc8jVuuH866H2z+qJ38uYtv8UPHBbOC4XXjDT
         FKCObRv9huRP1Gm+ivdPeL2QdKrFhT+3s6V0fH+yvef/IQdc0/sVWJSj6vaurlyfOaTw
         HucUaVUmmGam477Y+nK9gT8FaubO8NL2IgOYdt7D/4Ah3oVKg2T/O9wFUv35ZAqhUfHS
         Wb8u1LhHrss7VKQGB+zET+3d+PNDJT8Bzalsh0Ta805cdemxiEQO8SYUPjl8JQhKEGgP
         HdzQ==
X-Gm-Message-State: AOAM532duBNLsPO4vcvTyi3iDmGRSMVIDsg+Wi4zWTmDuucZ/lOT8p7D
        sWU3Mdjfh0iZK2V/LfkFZBtkAQ==
X-Google-Smtp-Source: ABdhPJxtj4KuEKVAUVM/ayFvRfAHHTsgx+xpEM7sEoPG8ylQ3t5pkgRZ9BQ6Ls0lNwmXJ9BWTKycUA==
X-Received: by 2002:a5d:6a4b:: with SMTP id t11mr4289837wrw.404.1592483170221;
        Thu, 18 Jun 2020 05:26:10 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:c1af:c724:158a:e200])
        by smtp.gmail.com with ESMTPSA id j5sm3377432wrm.57.2020.06.18.05.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 05:26:09 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v3 12/15] arm64: kvm: Compile remaining hyp/ files for both VHE/nVHE
Date:   Thu, 18 Jun 2020 13:25:34 +0100
Message-Id: <20200618122537.9625-13-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618122537.9625-1-dbrazdil@google.com>
References: <20200618122537.9625-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is part of a series which builds KVM's non-VHE hyp code separately
from VHE and the rest of the kernel.

The following files in hyp/ contain only code shared by VHE/nVHE:
  vgic-v3-sr.c, aarch32.c, vgic-v2-cpuif-proxy.c, entry.S, fpsimd.S
Compile them under both configurations. Deletions in image-vars.h reflect
eliminated dependencies of nVHE code on the rest of the kernel.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kernel/image-vars.h   | 19 -------------------
 arch/arm64/kvm/hyp/nvhe/Makefile |  5 +++--
 2 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 94bfc61b3f51..2cc3e7673dc2 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -61,27 +61,9 @@ __efistub__ctype		= _ctype;
  * memory mappings.
  */
 
-__kvm_nvhe___fpsimd_restore_state = __fpsimd_restore_state;
-__kvm_nvhe___fpsimd_save_state = __fpsimd_save_state;
-__kvm_nvhe___guest_enter = __guest_enter;
-__kvm_nvhe___guest_exit = __guest_exit;
 __kvm_nvhe___hyp_panic_string = __hyp_panic_string;
 __kvm_nvhe___hyp_stub_vectors = __hyp_stub_vectors;
 __kvm_nvhe___icache_flags = __icache_flags;
-__kvm_nvhe___vgic_v2_perform_cpuif_access = __vgic_v2_perform_cpuif_access;
-__kvm_nvhe___vgic_v3_activate_traps = __vgic_v3_activate_traps;
-__kvm_nvhe___vgic_v3_deactivate_traps = __vgic_v3_deactivate_traps;
-__kvm_nvhe___vgic_v3_get_ich_vtr_el2 = __vgic_v3_get_ich_vtr_el2;
-__kvm_nvhe___vgic_v3_init_lrs = __vgic_v3_init_lrs;
-__kvm_nvhe___vgic_v3_perform_cpuif_access = __vgic_v3_perform_cpuif_access;
-__kvm_nvhe___vgic_v3_read_vmcr = __vgic_v3_read_vmcr;
-__kvm_nvhe___vgic_v3_restore_aprs = __vgic_v3_restore_aprs;
-__kvm_nvhe___vgic_v3_restore_state = __vgic_v3_restore_state;
-__kvm_nvhe___vgic_v3_save_aprs = __vgic_v3_save_aprs;
-__kvm_nvhe___vgic_v3_save_state = __vgic_v3_save_state;
-__kvm_nvhe___vgic_v3_write_vmcr = __vgic_v3_write_vmcr;
-__kvm_nvhe_abort_guest_exit_end = abort_guest_exit_end;
-__kvm_nvhe_abort_guest_exit_start = abort_guest_exit_start;
 __kvm_nvhe_arm64_const_caps_ready = arm64_const_caps_ready;
 __kvm_nvhe_arm64_enable_wa2_handling = arm64_enable_wa2_handling;
 __kvm_nvhe_arm64_ssbd_callback_required = arm64_ssbd_callback_required;
@@ -94,7 +76,6 @@ __kvm_nvhe_idmap_t0sz = idmap_t0sz;
 __kvm_nvhe_kimage_voffset = kimage_voffset;
 __kvm_nvhe_kvm_host_data = kvm_host_data;
 __kvm_nvhe_kvm_patch_vector_branch = kvm_patch_vector_branch;
-__kvm_nvhe_kvm_skip_instr32 = kvm_skip_instr32;
 __kvm_nvhe_kvm_update_va_mask = kvm_update_va_mask;
 __kvm_nvhe_kvm_vgic_global_state = kvm_vgic_global_state;
 __kvm_nvhe_panic = panic;
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 4ec34abce0a9..d51ae163430d 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -7,8 +7,9 @@ asflags-y := -D__KVM_NVHE_HYPERVISOR__
 ccflags-y := -D__KVM_NVHE_HYPERVISOR__ -fno-stack-protector \
 	     -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK_PLUGIN)
 
-obj-y := ../timer-sr.o timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o \
-	 hyp-init.o ../hyp-entry.o
+obj-y := ../vgic-v3-sr.o ../timer-sr.o timer-sr.o ../aarch32.o \
+	 ../vgic-v2-cpuif-proxy.o sysreg-sr.o debug-sr.o ../entry.o switch.o \
+	 ../fpsimd.o tlb.o hyp-init.o ../hyp-entry.o
 
 obj-y := $(patsubst %.o,%.hyp.o,$(obj-y))
 extra-y := $(patsubst %.hyp.o,%.hyp.tmp.o,$(obj-y))
-- 
2.27.0

