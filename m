Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7501AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51ABB2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MYaMiRiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgEOK7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgEOK7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:59:17 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4DFC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:59:17 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l17so3033050wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wKY3Sv04y9T25D28x0+yoca4JqoOKU6viRzuCp/o2d8=;
        b=MYaMiRiz1CtiS090xzgno9gIDJcuB2yEV9pYsHZtfn9MDBV+1Lb61O84bGSxxbGm/3
         elvcYsu2EMhv9Gis8QZnBIOfyFjmlnBWT0yDiIl16ZEZyh3Qm2DUSWuuWJSyOUeY583g
         VlLJUs441j/vco+A7dJ+tQTgMJFr8y3hnQBIXgJ8aKdEObgPU12qX43fP37XyYzPrG1l
         SBK8QAmP9SNb143vdUN+gyCeM1j9SpSGBwNh2pu1WvbRYKCLTVIlN5u/kP3JR6OXkrIu
         rx5ygMcBqj5CmvNXSxpp7oj3wxNgnG8OattGZ5qDmnj7RZ8ahWDTu8FsKX32glfhzpzs
         QbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wKY3Sv04y9T25D28x0+yoca4JqoOKU6viRzuCp/o2d8=;
        b=Z007Nu8YSWV24RQJJd4ncTZzKsa7xbfu4y00G4plxNbced7ZuNldH+A081zNVaxpjU
         9hk449RNgU1j1CFCrD2WPfxsXlkY0FzjF/zbLBp95q+SwJtVD44XRAz2QSg41Wrsw8ka
         Bc5mhp0/Itzoaw0Y1hF/nmQcP2X9E1tObyRu4OmuEJLkRvjWXV79j6hhfNNyVtEY7ut1
         EP8r5BXfLPxfu/blTeaEGDa5SuLEq/J+EuZ19uYsK9T61RimPiLlFo5rIjZgAwWRxxqI
         SjWEfkeuYcqagRyvWdOm3QHOgNPTW9yITftBLzopQ9cExYjlvYbxDjX8BFClFiGmpBF5
         Sl6A==
X-Gm-Message-State: AOAM532zqONi+vF2xSh88p7c5qN+EUsUmqPQmYhZuAcGhkicufULBmwP
        Wn9iacGab1aj+ur6u4UiY44IgQ==
X-Google-Smtp-Source: ABdhPJxDpM4n30e5iBr2RTiZvdPUETO1aVERF22wXT/LtFQlS2FUwWdRvrja8ivqmLjEU8Yx1VWMvA==
X-Received: by 2002:a5d:62c7:: with SMTP id o7mr3622526wrv.212.1589540355340;
        Fri, 15 May 2020 03:59:15 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d11b:f847:8002:7411])
        by smtp.gmail.com with ESMTPSA id l19sm3242185wmj.14.2020.05.15.03.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 03:59:14 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 11/14] arm64: kvm: Compile remaining hyp/ files for both VHE/nVHE
Date:   Fri, 15 May 2020 11:58:38 +0100
Message-Id: <20200515105841.73532-12-dbrazdil@google.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515105841.73532-1-dbrazdil@google.com>
References: <20200515105841.73532-1-dbrazdil@google.com>
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
index c16cf4e2cd8b..217e5e5a101d 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -61,26 +61,8 @@ __efistub__ctype		= _ctype;
  * memory mappings.
  */
 
-__kvm_nvhe___fpsimd_restore_state = __fpsimd_restore_state;
-__kvm_nvhe___fpsimd_save_state = __fpsimd_save_state;
-__kvm_nvhe___guest_enter = __guest_enter;
-__kvm_nvhe___guest_exit = __guest_exit;
 __kvm_nvhe___icache_flags = __icache_flags;
 __kvm_nvhe___kvm_handle_stub_hvc = __kvm_handle_stub_hvc;
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
@@ -89,7 +71,6 @@ __kvm_nvhe_cpu_hwcaps = cpu_hwcaps;
 __kvm_nvhe_kimage_voffset = kimage_voffset;
 __kvm_nvhe_kvm_host_data = kvm_host_data;
 __kvm_nvhe_kvm_patch_vector_branch = kvm_patch_vector_branch;
-__kvm_nvhe_kvm_skip_instr32 = kvm_skip_instr32;
 __kvm_nvhe_kvm_update_va_mask = kvm_update_va_mask;
 __kvm_nvhe_kvm_vgic_global_state = kvm_vgic_global_state;
 __kvm_nvhe_panic = panic;
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index a67958f29fd7..819d5271c49a 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -7,8 +7,9 @@ asflags-y := -D__KVM_NVHE_HYPERVISOR__
 ccflags-y := -D__KVM_NVHE_HYPERVISOR__ -fno-stack-protector \
 	     -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK_PLUGIN)
 
-obj-y := ../timer-sr.o timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o \
-	 ../hyp-entry.o
+obj-y := ../vgic-v3-sr.o ../timer-sr.o timer-sr.o ../aarch32.o \
+	 ../vgic-v2-cpuif-proxy.o sysreg-sr.o debug-sr.o ../entry.o switch.o \
+	 ../fpsimd.o tlb.o ../hyp-entry.o
 
 obj-y := $(patsubst %.o,%.hyp.o,$(obj-y))
 extra-y := $(patsubst %.hyp.o,%.hyp.tmp.o,$(obj-y))
-- 
2.26.2

