Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46623C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2519D2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hem7MA7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgEOK7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgEOK7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:59:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64AEC05BD0A
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:59:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e1so3028390wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qIsoQzx8QXc1ir+dRugWu1fsq9J9q4alaZWOk635tTE=;
        b=hem7MA7Smzp8TqztYBuB5W3IWuLc4iqDhkp4S4YrnIqEmIZYd5pPdRcokkZiSQCBXL
         58opF2y7yXszqJ3evDxLwos9xZqkclw8sRQh7P0+fHtLZlqrEbIdYFuY2QzUT/3oNp3+
         56D/84m33gXnqSp+cu9AJxgtA7yK1RJAbAO0VQpW+NCdV214WKsw960f4Toq0JR2zORt
         KAesZDc+Dr2ZIqP8yY5XwJ6nLSGu7pB7APkga9EQl8I78PToaK+HwDB54eqVuf/tRtOS
         pzcnoFrrzdZU3MnypcCryPp2ei+6BLBHpvUaf/5Qk4Uvog7s+owQl8nsBFbR/RUPagH9
         HC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qIsoQzx8QXc1ir+dRugWu1fsq9J9q4alaZWOk635tTE=;
        b=g6ioICWB3hcgRjIY7IBrrN0ggdvtWCkVkfoXmlAqnFzBtFeIBb50URmFmMTnQmbl2i
         +6gcBy8ug1xmhJhiwxqA58Qvi9jqSWOKYU3bLTNN1lNdfB99PA9OYZhCUQCCv+ITGNbB
         C/J58sGwEzh03aORK+2pXyG4QetN71rdCV35fnJK+EqyG47NrJLseYw/Xx2y3MgfbIH5
         diI7giCE7c5ixeIYSejZn3eq3UUvnrh3684UoQkl/F2X2gkKED6ZTX2iV3OGOkSgJgSB
         q3HDUj/RDaV+Rc7V+Z+FUi2TPYLVC53FRn2Zrw9M1evveSPoTaNDuEJibAlEwSycc5+j
         wkQQ==
X-Gm-Message-State: AOAM5318/hTogNtHTE+d28A7xP6p3MjSWovGv0CGEj+9beXupFFV/e1C
        S3vnycDABH6SYB/bgVSsZzU5jg==
X-Google-Smtp-Source: ABdhPJyxwMkIRcpBncYa6eIwpuEAvcR55Rq93vJeaU2e4BAy6oJpiroVdqRq+R0wPBTMFUMxTSk9rw==
X-Received: by 2002:adf:fa44:: with SMTP id y4mr3731198wrr.135.1589540357099;
        Fri, 15 May 2020 03:59:17 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d11b:f847:8002:7411])
        by smtp.gmail.com with ESMTPSA id 128sm3156597wme.39.2020.05.15.03.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 03:59:16 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 12/14] arm64: kvm: Add comments around __kvm_nvhe_ symbol aliases
Date:   Fri, 15 May 2020 11:58:39 +0100
Message-Id: <20200515105841.73532-13-dbrazdil@google.com>
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

With all source files split between VHE/nVHE, add comments around the list of
symbols where nVHE code still links against kernel proper. Split them into
groups and explain how each group is currently used.

Some of these dependencies will be removed in the future.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kernel/image-vars.h | 47 ++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 217e5e5a101d..0b3a3fe07a64 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -61,23 +61,36 @@ __efistub__ctype		= _ctype;
  * memory mappings.
  */
 
-__kvm_nvhe___icache_flags = __icache_flags;
-__kvm_nvhe___kvm_handle_stub_hvc = __kvm_handle_stub_hvc;
-__kvm_nvhe_arm64_const_caps_ready = arm64_const_caps_ready;
-__kvm_nvhe_arm64_enable_wa2_handling = arm64_enable_wa2_handling;
-__kvm_nvhe_arm64_ssbd_callback_required = arm64_ssbd_callback_required;
-__kvm_nvhe_cpu_hwcap_keys = cpu_hwcap_keys;
-__kvm_nvhe_cpu_hwcaps = cpu_hwcaps;
-__kvm_nvhe_kimage_voffset = kimage_voffset;
-__kvm_nvhe_kvm_host_data = kvm_host_data;
-__kvm_nvhe_kvm_patch_vector_branch = kvm_patch_vector_branch;
-__kvm_nvhe_kvm_update_va_mask = kvm_update_va_mask;
-__kvm_nvhe_kvm_vgic_global_state = kvm_vgic_global_state;
-__kvm_nvhe_panic = panic;
-__kvm_nvhe_sve_load_state = sve_load_state;
-__kvm_nvhe_sve_save_state = sve_save_state;
-__kvm_nvhe_vgic_v2_cpuif_trap = vgic_v2_cpuif_trap;
-__kvm_nvhe_vgic_v3_cpuif_trap = vgic_v3_cpuif_trap;
+/* If nVHE code panics, it ERETs into panic() in EL1. */
+__kvm_nvhe_panic			= panic;
+
+/* Stub HVC IDs are routed to a handler in .hyp.idmap.text. Executed in EL2. */
+__kvm_nvhe___kvm_handle_stub_hvc	= __kvm_handle_stub_hvc;
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
+__kvm_nvhe_vgic_v2_cpuif_trap		= vgic_v2_cpuif_trap;
+__kvm_nvhe_vgic_v3_cpuif_trap		= vgic_v3_cpuif_trap;
+
+/* SVE support, currently unused by nVHE. */
+__kvm_nvhe_sve_save_state		= sve_save_state;
+__kvm_nvhe_sve_load_state		= sve_load_state;
 
 #endif /* CONFIG_KVM */
 
-- 
2.26.2

