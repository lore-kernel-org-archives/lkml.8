Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D7DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6222D206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="w7+V51LF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbgEVMwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 08:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbgEVMw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 08:52:28 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E5FC035463
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 05:52:26 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z18so12439595lji.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 05:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hp9LVrV/jryYEOmKqMZilHNSbd08lh9WQOd5VsCx30A=;
        b=w7+V51LF61oIWXbD/uIzaRfC1I5yP8CeMVMcem9dRCqApl+zLMn39ALMj56hHtJ9Qf
         Gyb+f7KQfxfRYMPPlqUwSJltzR+TxpbCxAwW2trP0D5VP1QRHIqZblwOCnhLP5TSw2ox
         tSDHd0F/H4fqN+mgyYgPjTGtZZCBTHLGg8/fSKOx0jH5hz8hgx3KHFfdloZtRSES0pIf
         2aOwZG4Q3FRMLhqztET2rmONddbkJeBUOmSg+4wYmi51JmHJDjcjjy3TIZNuwPhxGj2y
         UD5n8gyfyOquHbuAKSgJrf3yvDpZ2xnmbdfHr9HKoYZrbgZBrLkqru1euBjF0BiEeAhZ
         lS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hp9LVrV/jryYEOmKqMZilHNSbd08lh9WQOd5VsCx30A=;
        b=m+qOJ+FchsD3IJkqyza4R5RerZO2wVU9TsxDDLCThh/yLyhvBvOUOATSHDdqPOsBcQ
         kT+DR5IPkTVSvI56QZNkjX3/BLXR/hZ3R0XRkgeKhWbLGdiXxV85MYx3H/tEfHDu0T9C
         hMOLe3N+epduHM9MKi24Sl3ilLlFLzLxgwkNqNo8970ZB0wXW6X3CYBVdb9RQSGqVSrn
         sQG9h6PMLa+yynNq/uPBtCHxxm4H6wZWF2RJXABe/juXTpjEIGqLdjcXHyrq/YhzlRr8
         GbBFJoKCX2lLkcWTha/4T4GYnbBBMrrb3kGgmCTJq7QJ25s9uXiLL6/gIsxdUWV696Vu
         1XhQ==
X-Gm-Message-State: AOAM532iXRKXaLCkZqp396didKNB3kGgWrXkF8xDckY56bNLTgDTttns
        6ERRQnDo7zyumlXzvX/FxneUxw==
X-Google-Smtp-Source: ABdhPJxjv+o2Z6h/SDQekvHRlmANly8ZZinNLfWWZwgF4Ua2uGZvW18C8lVOUb91lDab94je8Nxavg==
X-Received: by 2002:a05:651c:547:: with SMTP id q7mr5071399ljp.437.1590151944946;
        Fri, 22 May 2020 05:52:24 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w15sm1266864ljj.57.2020.05.22.05.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 05:52:22 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id E7E01102058; Fri, 22 May 2020 15:52:19 +0300 (+03)
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC 10/16] KVM: x86: Enabled protected memory extension
Date:   Fri, 22 May 2020 15:52:08 +0300
Message-Id: <20200522125214.31348-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522125214.31348-1-kirill.shutemov@linux.intel.com>
References: <20200522125214.31348-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up hypercalls for the feature and define VM_KVM_PROTECTED.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig     | 1 +
 arch/x86/kvm/cpuid.c | 3 +++
 arch/x86/kvm/x86.c   | 9 +++++++++
 include/linux/mm.h   | 4 ++++
 4 files changed, 17 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58dd44a1b92f..420e3947f0c6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -801,6 +801,7 @@ config KVM_GUEST
 	select ARCH_CPUIDLE_HALTPOLL
 	select X86_MEM_ENCRYPT_COMMON
 	select SWIOTLB
+	select ARCH_USES_HIGH_VMA_FLAGS
 	default y
 	---help---
 	  This option enables various optimizations for running under the KVM
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 901cd1fdecd9..94cc5e45467e 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -714,6 +714,9 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 			     (1 << KVM_FEATURE_POLL_CONTROL) |
 			     (1 << KVM_FEATURE_PV_SCHED_YIELD);
 
+		if (VM_KVM_PROTECTED)
+			entry->eax |=(1 << KVM_FEATURE_MEM_PROTECTED);
+
 		if (sched_info_on())
 			entry->eax |= (1 << KVM_FEATURE_STEAL_TIME);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c17e6eb9ad43..acba0ac07f61 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7598,6 +7598,15 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 		kvm_sched_yield(vcpu->kvm, a0);
 		ret = 0;
 		break;
+	case KVM_HC_ENABLE_MEM_PROTECTED:
+		ret = kvm_protect_all_memory(vcpu->kvm);
+		break;
+	case KVM_HC_MEM_SHARE:
+		ret = kvm_protect_memory(vcpu->kvm, a0, a1, false);
+		break;
+	case KVM_HC_MEM_UNSHARE:
+		ret = kvm_protect_memory(vcpu->kvm, a0, a1, true);
+		break;
 	default:
 		ret = -KVM_ENOSYS;
 		break;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4f7195365cc0..6eb771c14968 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -329,7 +329,11 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_MAPPED_COPY	VM_ARCH_1	/* T if mapped copy of data (nommu mmap) */
 #endif
 
+#if defined(CONFIG_X86_64) && defined(CONFIG_KVM)
+#define VM_KVM_PROTECTED VM_HIGH_ARCH_4
+#else
 #define VM_KVM_PROTECTED 0
+#endif
 
 #ifndef VM_GROWSUP
 # define VM_GROWSUP	VM_NONE
-- 
2.26.2

