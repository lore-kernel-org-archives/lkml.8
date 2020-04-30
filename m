Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F17EC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E3E4217BA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d2VkIY9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgD3OtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728246AbgD3OtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:49:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327B5C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:49:11 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x25so2194501wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wdv9+QboSB0n8mCt4SCrZeIquYs40oZsiEsRDsuUlz0=;
        b=d2VkIY9z2QxMTr9h0uS1PRKv10w2VGgdwRE0sKCV0WjUfaxd1zset/EMhBFQfskuJe
         goCtRuSXhK3kBgyLdjxZkBMTTngcnKPaSof2L7u3yexydH49mW/U9M2iAHHQSRFilRvM
         k5KEZcFespm6qTVeA32TSRCr6jhm8eRQ7Ym71GbZAd8JnCvyrcI6hKtB2OiGX+xOYXeV
         ZJH2zA3r+wbu9/VfJjCHzG1bm+FreLspb3qUpNwgCGbxVqCG0mvKmtssm+3ikb0CfkWM
         4I5A3chetvEn8rgjOt0JZFuLRpLheKnZsDVdY+eVw++ctr0guSEm0z28nbRuzNSgGdil
         gVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wdv9+QboSB0n8mCt4SCrZeIquYs40oZsiEsRDsuUlz0=;
        b=Fr1ZJkxS8oOttuzipq3vZ/CD3hYV2Not6JSf+466GpKOOuSrbF6On+8aALgkw24WVI
         Gt/XIhHdW7mIncVNuCo+NnHTneBErj4m1BjaurXncCfqsEVvcRugsqjkZ3/5ydLCThPh
         3qzA1T2QEJeNdGfmvvP7JAqbPVT9nkIrGfUCA4tc8XwgZZuszrUPmR8i0CLme8HAMkBz
         d0mNa1LGXucgsm7osNDeFVbHwrVN/+LUCJPTDesDUYu1oafnyv3MYQJz0Iu9s6Jjjl9C
         W3ibvRqX3jGW8bnxNeSweRtu4h9C5hRJRBF27swrQesHuk/qAV0w4CXzAhrYlOkrOPTp
         8jnA==
X-Gm-Message-State: AGi0PuZjOObaEynSknU3nn86JM6uHqHuEN+lHF7qlwEeSMx1EsEWMFec
        NzEi0HWl9sHvKpIrM5PFROr7LQ==
X-Google-Smtp-Source: APiQypI5dMJz38mZmwtrxPPLvPMzBmrs/Qs1QaCKD/ikyZpdAJowByuEdCLiCgMzdGxwo2O5sdWohw==
X-Received: by 2002:a1c:7905:: with SMTP id l5mr3549110wme.5.1588258149457;
        Thu, 30 Apr 2020 07:49:09 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d4b6:9828:8bd2:ce6f])
        by smtp.gmail.com with ESMTPSA id a24sm12220432wmb.24.2020.04.30.07.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 07:49:08 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 13/15] arm64: kvm: Add comments around __hyp_text_ symbol aliases
Date:   Thu, 30 Apr 2020 15:48:29 +0100
Message-Id: <20200430144831.59194-14-dbrazdil@google.com>
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

With all source files split between VHE/nVHE, add comments around the list of
symbols where nVHE code still links against kernel proper. Split them into
groups and explain how each group is currently used.

Some of these dependencies will be removed in the future.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kernel/image-vars.h | 49 +++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index e272eedfe19a..04a3ee21e694 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -61,24 +61,37 @@ __efistub__ctype		= _ctype;
  * memory mappings.
  */
 
-__hyp_text___icache_flags = __icache_flags;
-__hyp_text___kvm_handle_stub_hvc = __kvm_handle_stub_hvc;
-__hyp_text_arm64_const_caps_ready = arm64_const_caps_ready;
-__hyp_text_arm64_enable_wa2_handling = arm64_enable_wa2_handling;
-__hyp_text_arm64_ssbd_callback_required = arm64_ssbd_callback_required;
-__hyp_text_cpu_hwcap_keys = cpu_hwcap_keys;
-__hyp_text_cpu_hwcaps = cpu_hwcaps;
-__hyp_text_kimage_voffset = kimage_voffset;
-__hyp_text_kvm_host_data = kvm_host_data;
-__hyp_text_kvm_patch_vector_branch = kvm_patch_vector_branch;
-__hyp_text_kvm_update_va_mask = kvm_update_va_mask;
-__hyp_text_kvm_vgic_global_state = kvm_vgic_global_state;
-__hyp_text_panic = panic;
-__hyp_text_physvirt_offset = physvirt_offset;
-__hyp_text_sve_load_state = sve_load_state;
-__hyp_text_sve_save_state = sve_save_state;
-__hyp_text_vgic_v2_cpuif_trap = vgic_v2_cpuif_trap;
-__hyp_text_vgic_v3_cpuif_trap = vgic_v3_cpuif_trap;
+/* If nVHE code panics, it ERETs into panic() in EL1. */
+__hyp_text_panic			= panic;
+
+/* Stub HVC IDs are routed to a handler in .hyp.idmap.text. Executed in EL2. */
+__hyp_text___kvm_handle_stub_hvc	= __kvm_handle_stub_hvc;
+
+/* Alternative callbacks, referenced in .altinstructions. Executed in EL1. */
+__hyp_text_arm64_enable_wa2_handling	= arm64_enable_wa2_handling;
+__hyp_text_kvm_patch_vector_branch	= kvm_patch_vector_branch;
+__hyp_text_kvm_update_va_mask		= kvm_update_va_mask;
+
+/* Values used to convert between memory mappings, read-only after init. */
+__hyp_text_kimage_voffset		= kimage_voffset;
+__hyp_text_physvirt_offset		= physvirt_offset;
+
+/* Data shared with the kernel. */
+__hyp_text_cpu_hwcaps			= cpu_hwcaps;
+__hyp_text_cpu_hwcap_keys		= cpu_hwcap_keys;
+__hyp_text___icache_flags		= __icache_flags;
+__hyp_text_kvm_vgic_global_state	= kvm_vgic_global_state;
+__hyp_text_arm64_ssbd_callback_required	= arm64_ssbd_callback_required;
+__hyp_text_kvm_host_data		= kvm_host_data;
+
+/* Static keys shared with the kernel. */
+__hyp_text_arm64_const_caps_ready	= arm64_const_caps_ready;
+__hyp_text_vgic_v2_cpuif_trap		= vgic_v2_cpuif_trap;
+__hyp_text_vgic_v3_cpuif_trap		= vgic_v3_cpuif_trap;
+
+/* SVE support, currently unused by nVHE. */
+__hyp_text_sve_save_state		= sve_save_state;
+__hyp_text_sve_load_state		= sve_load_state;
 
 #endif /* CONFIG_KVM */
 
-- 
2.26.1

