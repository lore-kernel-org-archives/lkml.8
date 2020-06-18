Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135F9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E21CC2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XImm0NWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbgFRM25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbgFRM0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:26:40 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CDFC0617B9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:26:13 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q2so3415349wrv.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ceSCnqPU+qhFBApWd37Hj9Iarz1DhO8p+J0NPEP0HY=;
        b=XImm0NWhTRSHFfFBJjAzpQWgVma/Daqep8ONE/WtU0eu796P/BJ1Ml/kY6divma1BZ
         divyMCuPOWy2+Na9sCUHeEQHXDGfXSrgILV1ChiotyZiFrKWVTKqgspfJUGxjfiEFgAL
         bs5UNOB+ODc6oS4w10pOJ3JbNBTelTewFdDqnIa1dm5DMNHubszjkQpu58Yxu8UYt6kH
         0U8YLbm977SDUYSQKiIzCGXda5Ch3oM5q6dqt+qPLbB2dq6mnOVBJyXBQWnz3EztZbB2
         sQWwr4W/YZTBEUbTz1tEwW8ducrc7HBqZu1rOprt/H5743BsmmMTZQKJee9lmFylU00/
         TXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ceSCnqPU+qhFBApWd37Hj9Iarz1DhO8p+J0NPEP0HY=;
        b=YGi+RjO5/sUmSGbnD3jpfv8ItyE8Kiq54Pi9Sn2gPpQcy3XlifpyUa9eu5OK8HeaBO
         Wy6kK47yWXbtQhnvBCqS0fTu069hssF8JkECq1gol60LUOBkKNOYmk2DudxOer4Smsgz
         YWihao8bf4ob3tA7KkbWR4RdQN4vzRKePRdp/MJWBLSoTKdP1VKE+p8HAFZNRjiCSTm7
         SVBjvY4zQtcTw+mJIfgrjrxvCuAFojcaPNjTTViy14IY4Cb3XAUzfdvcjLqsMnHBgBa5
         KcfN5DqOo2OE4F/qjeKMQt8nS/+lF4MJZsvPRlcGpv5t3gvHoOa5LmN5aLr0mmQjjbiy
         ZdOg==
X-Gm-Message-State: AOAM531FCUPxFON1oSKCTZBRghqSJE6xrcRaW80/BShs+LaLap/XDYKg
        7I5G32nieDu6ee9MbHdWAilUpQ==
X-Google-Smtp-Source: ABdhPJwR+2X7OijhjCKVfnY0bd5pmPZUZ3Q1eOHRC2W/NjdYmx/NZTyrTPK2hq0x8R87nRQuJSwogQ==
X-Received: by 2002:a5d:654c:: with SMTP id z12mr4248011wrv.315.1592483171911;
        Thu, 18 Jun 2020 05:26:11 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:c1af:c724:158a:e200])
        by smtp.gmail.com with ESMTPSA id 125sm3467359wmc.23.2020.06.18.05.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 05:26:11 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v3 13/15] arm64: kvm: Add comments around __kvm_nvhe_ symbol aliases
Date:   Thu, 18 Jun 2020 13:25:35 +0100
Message-Id: <20200618122537.9625-14-dbrazdil@google.com>
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

With all source files split between VHE/nVHE, add comments around the list of
symbols where nVHE code still links against kernel proper. Split them into
groups and explain how each group is currently used.

Some of these dependencies will be removed in the future.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kernel/image-vars.h | 53 +++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 2cc3e7673dc2..da8f39fae5e8 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -61,30 +61,43 @@ __efistub__ctype		= _ctype;
  * memory mappings.
  */
 
-__kvm_nvhe___hyp_panic_string = __hyp_panic_string;
-__kvm_nvhe___hyp_stub_vectors = __hyp_stub_vectors;
-__kvm_nvhe___icache_flags = __icache_flags;
-__kvm_nvhe_arm64_const_caps_ready = arm64_const_caps_ready;
-__kvm_nvhe_arm64_enable_wa2_handling = arm64_enable_wa2_handling;
-__kvm_nvhe_arm64_ssbd_callback_required = arm64_ssbd_callback_required;
-__kvm_nvhe_cpu_hwcap_keys = cpu_hwcap_keys;
-__kvm_nvhe_cpu_hwcaps = cpu_hwcaps;
+/* If nVHE code panics, it ERETs into panic() in EL1. */
+__kvm_nvhe___hyp_panic_string		= __hyp_panic_string;
+__kvm_nvhe_panic			= panic;
+
+/* Values used by the hyp-init vector. */
+__kvm_nvhe___hyp_stub_vectors		= __hyp_stub_vectors;
+__kvm_nvhe_idmap_t0sz			= idmap_t0sz;
+
+/* Alternative callbacks, referenced in .altinstructions. Executed in EL1. */
+__kvm_nvhe_arm64_enable_wa2_handling	= arm64_enable_wa2_handling;
+__kvm_nvhe_kvm_patch_vector_branch	= kvm_patch_vector_branch;
+__kvm_nvhe_kvm_update_va_mask		= kvm_update_va_mask;
+
+/* Values used to convert between memory mappings, read-only after init. */
+__kvm_nvhe_kimage_voffset		= kimage_voffset;
+
+/* Data shared with the kernel. */
+__kvm_nvhe_cpu_hwcaps			= cpu_hwcaps;
+__kvm_nvhe_cpu_hwcap_keys		= cpu_hwcap_keys;
+__kvm_nvhe___icache_flags		= __icache_flags;
+__kvm_nvhe_kvm_vgic_global_state	= kvm_vgic_global_state;
+__kvm_nvhe_arm64_ssbd_callback_required	= arm64_ssbd_callback_required;
+__kvm_nvhe_kvm_host_data		= kvm_host_data;
+
+/* Static keys shared with the kernel. */
+__kvm_nvhe_arm64_const_caps_ready	= arm64_const_caps_ready;
 #ifdef CONFIG_ARM64_PSEUDO_NMI
-__kvm_nvhe_gic_pmr_sync = gic_pmr_sync;
+__kvm_nvhe_gic_pmr_sync			= gic_pmr_sync;
 #endif
-__kvm_nvhe_idmap_t0sz = idmap_t0sz;
-__kvm_nvhe_kimage_voffset = kimage_voffset;
-__kvm_nvhe_kvm_host_data = kvm_host_data;
-__kvm_nvhe_kvm_patch_vector_branch = kvm_patch_vector_branch;
-__kvm_nvhe_kvm_update_va_mask = kvm_update_va_mask;
-__kvm_nvhe_kvm_vgic_global_state = kvm_vgic_global_state;
-__kvm_nvhe_panic = panic;
+__kvm_nvhe_vgic_v2_cpuif_trap		= vgic_v2_cpuif_trap;
+__kvm_nvhe_vgic_v3_cpuif_trap		= vgic_v3_cpuif_trap;
+
+/* SVE support, currently unused by nVHE. */
 #ifdef CONFIG_ARM64_SVE
-__kvm_nvhe_sve_load_state = sve_load_state;
-__kvm_nvhe_sve_save_state = sve_save_state;
+__kvm_nvhe_sve_save_state		= sve_save_state;
+__kvm_nvhe_sve_load_state		= sve_load_state;
 #endif
-__kvm_nvhe_vgic_v2_cpuif_trap = vgic_v2_cpuif_trap;
-__kvm_nvhe_vgic_v3_cpuif_trap = vgic_v3_cpuif_trap;
 
 #endif /* CONFIG_KVM */
 
-- 
2.27.0

