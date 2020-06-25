Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC99C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE59020781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MhOzW3yI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404528AbgFYLyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404521AbgFYLx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:53:59 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ED6C061573
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 04:53:58 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k6so5548412wrn.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 04:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CW6BYTLV8RVUMjaLp+LWWUGTwyDc3MgC2HjUHbF/G2s=;
        b=MhOzW3yI+siMjHTtYaiCz2XLI6/mry8izaTQaA34GiRDbsBr88f4b3j8djs9+W84H4
         F+tDSo9EVncOoAMEqTx3X5wJsmZn3M3Phy8Ait0ENNBBAuKcEFkQkOgU4YaEj/fMgFkN
         4qGDx8jnpdvv4MTKVr6SE2n7URh3I3WOvT8qwnrx26Z/a5zvG5xtwrGZRoj73cNfJnLC
         nYLmhjOcqQBfKnKjbGTp7DPyAIOn8vR019zIH0M4SzNBjAc4PS/zfjgw6TZ8z6PU0qxV
         RdkFK9ebW2V1iQfgLGgGt0MmWs1sUY+I1jWGbdLNOAYbZ3AJCooZimhraUf0vFkOVwsS
         UJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CW6BYTLV8RVUMjaLp+LWWUGTwyDc3MgC2HjUHbF/G2s=;
        b=fRU0UOhU5pwU6FATxUi7Fe7/d5Focmpn2Co7WtJ8aSQdAgkZvbcuwTJRGUmuEc8Ds1
         8EIOqra8UBiC2E4jiXKIASn8yrw87SBpJSuucEwKKIAzdDKO2icJI1xHnM5NyE2pxgtw
         RvklEW779VJyaCVK+1ffqnd17/sZDh2ybasQ08TVaVYniVxRUUBK9/8TGZ6KFwlQdJW4
         MFcAb0nLDVyrNIjuYt5b4KMMy5NOdYSj/zXzhS5YXgXkaUZ41GXcQg09Ko5Bcr1XLaqp
         e+YrCeD3WZOnAyQOO48GCIdnINPQJtqTzeBH6JXr0KaMUaugzqRJPLQcG8S01TaboT0Q
         Z7JA==
X-Gm-Message-State: AOAM530kTWkgp9A8dU+PTV0+qBPxlCfX0MJkna8vEDq0maCTuW2nDDm4
        DZYd/MJgwDK1S5S+QEj8bnLrWg==
X-Google-Smtp-Source: ABdhPJy559uKp/8Pf7fBmRXt3yEfg0Q4Vzy6+P4IVjpOo/VV24C39KBymKP81gddL3dRbcznwrSMKA==
X-Received: by 2002:adf:e749:: with SMTP id c9mr39236061wrn.25.1593086036592;
        Thu, 25 Jun 2020 04:53:56 -0700 (PDT)
Received: from google.com ([2a01:4b00:8523:2d03:c126:6748:7a9d:2d])
        by smtp.gmail.com with ESMTPSA id h203sm12165406wme.37.2020.06.25.04.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 04:53:55 -0700 (PDT)
Date:   Thu, 25 Jun 2020 12:53:55 +0100
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com,
        kernel-team@android.com
Subject: Re: [PATCH v3 05/15] arm64: kvm: Build hyp-entry.S separately for
 VHE/nVHE
Message-ID: <20200625115355.iqt3np4m6gjmpbap@google.com>
References: <20200618122537.9625-1-dbrazdil@google.com>
 <20200618122537.9625-6-dbrazdil@google.com>
 <5029f8fb4a7816e11de7469c09347c79@kernel.org>
 <20200622102041.myve2otyoj5q7j5s@google.com>
 <491f3c8877897a4ac69d69fb7354c1cb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <491f3c8877897a4ac69d69fb7354c1cb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Marc,

> I'd be happy with the (maybe temporary) magic approach. It helps reasoning
> about things, and makes the transition smoother. Yes, bugs could crop up
> there, but given the static nature of obtaining a symbol's address, I'm
> fairly confident we'll get it right. The same cannot be said about pointers
> though.

Ok, so this is what it would look like:

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 6a682d66a640..0d1b3b1946f0 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -59,13 +59,14 @@
 #define DECLARE_KVM_HYP_SYM(sym)               \
        DECLARE_KVM_VHE_SYM(sym);               \
        DECLARE_KVM_NVHE_SYM(sym)
+#define CHOOSE_HYP_SYM(sym) (has_vhe() ? sym : kvm_nvhe_sym(sym))

 /* Translate a kernel address of @sym into its equivalent linear mapping */
-#define kvm_ksym_ref(sym)                                              \
+#define kvm_ksym_ref(ptr)                                              \
        ({                                                              \
-               void *val = &sym;                                       \
+               void *val = (ptr);                                      \
                if (!is_kernel_in_hyp_mode())                           \
-                       val = lm_alias(&sym);                           \
+                       val = lm_alias((ptr));                          \
                val;                                                    \
         })
 #define kvm_ksym_ref_nvhe(sym) kvm_ksym_ref(kvm_nvhe_sym(sym))
@@ -76,7 +77,14 @@ struct kvm_vcpu;
 extern char __kvm_hyp_init[];
 extern char __kvm_hyp_init_end[];

-extern char __kvm_hyp_vector[];
+DECLARE_KVM_HYP_SYM(__kvm_hyp_vector);
+#define __kvm_hyp_vector CHOOSE_HYP_SYM(__kvm_hyp_vector)
+
+#ifdef CONFIG_KVM_INDIRECT_VECTORS
+DECLARE_KVM_HYP_SYM(__bp_harden_hyp_vecs);
+#define __bp_harden_hyp_vecs CHOOSE_HYP_SYM(__bp_harden_hyp_vecs)
+extern atomic_t arm64_el2_vector_last_slot;
+#endif

 extern void __kvm_flush_vm_context(void);
 extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);

Everything compiles and boots. Only existing code I had to change was:

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 90cb90561446..34b551385153 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1285,7 +1285,7 @@ static void cpu_init_hyp_mode(void)
         * so that we can use adr_l to access per-cpu variables in EL2.
         */
        tpidr_el2 = ((unsigned long)this_cpu_ptr(&kvm_host_data) -
-                    (unsigned long)kvm_ksym_ref(kvm_host_data));
+                    (unsigned long)kvm_ksym_ref(&kvm_host_data));

        pgd_ptr = kvm_mmu_get_httbr();
        hyp_stack_ptr = __this_cpu_read(kvm_arm_hyp_stack_page) + PAGE_SIZE;

WDYT?

Thanks,
-David

