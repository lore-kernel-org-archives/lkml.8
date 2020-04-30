Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB47C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E9A92074A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="efC8vkYg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgD3OtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726640AbgD3OtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:49:09 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5005BC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:49:09 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id d17so7241796wrg.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=umkbm5KRG1N3np5zJ4HE1sftpuuUyazttPbykboHAm8=;
        b=efC8vkYgvNM1vKeVr2o1KyvheFweWQLdJEpfuO35sBECfVZWnRqYWwF651X3tv7WUl
         y7foAr0R0XqqiZFBrmI42yS1Ovwh7dWqJWSGU7t2oFv+doT6ZnA2r5ymHwPFZD2OBVPT
         pMw0DH9qc39RJ/JvzQIbUxJASJN7ZxUpMhrKoubW3zdb3umhK9O7VKPc1aDoQUlJyVMx
         O+Ei/SA4/M9+HqIx1BrLA84FsSF9Zm4hUlUT/C6/Qx4J7F1lhqzW5VbWxfHgrTX0eWjE
         Nzs6eMyZqIpzGWPgODgpMKn5JoW7WpNAATr3jAtV9DoXK0zChwiEWhVhc5aN3uSgaXwW
         91Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=umkbm5KRG1N3np5zJ4HE1sftpuuUyazttPbykboHAm8=;
        b=tLJORck0KxWZneQTR87zuigqG3OZiL5sVWIobzcdfpU8OXGHzs/5ayOc4SNbRqgqSf
         mXDL/v9cDXyC3xO8ilBEVqG2vWNFuhoZdI6UIdjAKLPsThT6fouciYo+iYAZAEADVwoQ
         eSbE9NYQhdWJyTBLwW0/+GcD0E8wVWcg5DcRi5CVOgosjX109uQiYvkDrasOfWHQgp7z
         5pIFQosU4YnCGChBqxpXog6rwxAy21LHegzZ5hskS3MoqFcAU0ZaliD0TKkhuaUj4sI1
         08aKaQC8p+VRL4N55iRm9G6TiSlBsrQZosszHQQ84aWTQmJPdq3GjIM54WpyrfuZk3r2
         h3vQ==
X-Gm-Message-State: AGi0PuYWh+O2jSPS+MPkUYdxK74hKF5sJfIBEQj5hrTk6ggnnEN/ohWv
        SYNFw5wtxt2+ZmMI4kFTdHXkJw==
X-Google-Smtp-Source: APiQypIpmxrWfSEem32pw/VDQBnv+MYBdsOIVLgK9Hym1JocNQpMrPcTj2RTIrgFipnFVqbek+O/ww==
X-Received: by 2002:a5d:6841:: with SMTP id o1mr4321497wrw.412.1588258147736;
        Thu, 30 Apr 2020 07:49:07 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d4b6:9828:8bd2:ce6f])
        by smtp.gmail.com with ESMTPSA id s14sm12054954wmh.18.2020.04.30.07.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 07:49:07 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 12/15] arm64: kvm: Compile remaining hyp/ files for both VHE/nVHE
Date:   Thu, 30 Apr 2020 15:48:28 +0100
Message-Id: <20200430144831.59194-13-dbrazdil@google.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200430144831.59194-1-dbrazdil@google.com>
References: <20200430144831.59194-1-dbrazdil@google.com>
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
index b3de24d7ecd1..e272eedfe19a 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -61,26 +61,8 @@ __efistub__ctype		= _ctype;
  * memory mappings.
  */
 
-__hyp_text___fpsimd_restore_state = __fpsimd_restore_state;
-__hyp_text___fpsimd_save_state = __fpsimd_save_state;
-__hyp_text___guest_enter = __guest_enter;
-__hyp_text___guest_exit = __guest_exit;
 __hyp_text___icache_flags = __icache_flags;
 __hyp_text___kvm_handle_stub_hvc = __kvm_handle_stub_hvc;
-__hyp_text___vgic_v2_perform_cpuif_access = __vgic_v2_perform_cpuif_access;
-__hyp_text___vgic_v3_activate_traps = __vgic_v3_activate_traps;
-__hyp_text___vgic_v3_deactivate_traps = __vgic_v3_deactivate_traps;
-__hyp_text___vgic_v3_get_ich_vtr_el2 = __vgic_v3_get_ich_vtr_el2;
-__hyp_text___vgic_v3_init_lrs = __vgic_v3_init_lrs;
-__hyp_text___vgic_v3_perform_cpuif_access = __vgic_v3_perform_cpuif_access;
-__hyp_text___vgic_v3_read_vmcr = __vgic_v3_read_vmcr;
-__hyp_text___vgic_v3_restore_aprs = __vgic_v3_restore_aprs;
-__hyp_text___vgic_v3_restore_state = __vgic_v3_restore_state;
-__hyp_text___vgic_v3_save_aprs = __vgic_v3_save_aprs;
-__hyp_text___vgic_v3_save_state = __vgic_v3_save_state;
-__hyp_text___vgic_v3_write_vmcr = __vgic_v3_write_vmcr;
-__hyp_text_abort_guest_exit_end = abort_guest_exit_end;
-__hyp_text_abort_guest_exit_start = abort_guest_exit_start;
 __hyp_text_arm64_const_caps_ready = arm64_const_caps_ready;
 __hyp_text_arm64_enable_wa2_handling = arm64_enable_wa2_handling;
 __hyp_text_arm64_ssbd_callback_required = arm64_ssbd_callback_required;
@@ -89,7 +71,6 @@ __hyp_text_cpu_hwcaps = cpu_hwcaps;
 __hyp_text_kimage_voffset = kimage_voffset;
 __hyp_text_kvm_host_data = kvm_host_data;
 __hyp_text_kvm_patch_vector_branch = kvm_patch_vector_branch;
-__hyp_text_kvm_skip_instr32 = kvm_skip_instr32;
 __hyp_text_kvm_update_va_mask = kvm_update_va_mask;
 __hyp_text_kvm_vgic_global_state = kvm_vgic_global_state;
 __hyp_text_panic = panic;
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 2b8286ee8138..41018d25118c 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -7,8 +7,9 @@ asflags-y := -D__HYPERVISOR__
 ccflags-y := -D__HYPERVISOR__ -fno-stack-protector -DDISABLE_BRANCH_PROFILING \
 	     $(DISABLE_STACKLEAK_PLUGIN)
 
-obj-y := ../timer-sr.o timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o \
-	 host_hypercall.o ../hyp-entry.o
+obj-y := ../vgic-v3-sr.o ../timer-sr.o timer-sr.o ../aarch32.o \
+	 ../vgic-v2-cpuif-proxy.o sysreg-sr.o debug-sr.o ../entry.o switch.o \
+	 ../fpsimd.o tlb.o host_hypercall.o ../hyp-entry.o
 
 obj-y := $(patsubst %.o,%.hyp.o,$(obj-y))
 extra-y := $(patsubst %.hyp.o,%.hyp.tmp.o,$(obj-y))
-- 
2.26.1

