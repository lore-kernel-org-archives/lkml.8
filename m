Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BEBC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 130C0206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpbfD+Tj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgDPPGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:06:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25991 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2392448AbgDPNwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587045132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JtZT59l+g5q4URhJXPd/sWhIspEh7jpqcBTOItYfg28=;
        b=UpbfD+TjxgVDFCkYpiX4MvbZlZ/3FysYkwB0fTH9tdCPq6BVHM5dQCfhYNPNxApPRdKI8r
        3FsrpcFlVWicKspJ6nDK0JJ5WUR7wbKDP1njDE/w32L2EkY/lVItDEr8Bn1dPQRMHk/LXg
        QDbFEDP3oaFVWwGLjfx6r3YF2NQT0YY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-khDCBiQVNYuy8S_CwG-7UQ-1; Thu, 16 Apr 2020 09:52:11 -0400
X-MC-Unique: khDCBiQVNYuy8S_CwG-7UQ-1
Received: by mail-wm1-f69.google.com with SMTP id f8so1444311wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 06:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JtZT59l+g5q4URhJXPd/sWhIspEh7jpqcBTOItYfg28=;
        b=OefavNLAroRu89bLBGe46kPiKqGbjheM711G+mNHGQrjtzHobQAU4r29Kav7xa+zWB
         pQlngzKDXCWX+/OCGGaYWfXHaw/xv9lFpteW681AhI43NCrHRC2jqEG7ZHsG6DGolYEx
         E7AHh15yNWoRVt/kiEVI4a9wLh+HcqTJwaXp9GoQkvo/QfKD1tMHBw6+b8apWncBoB/C
         PN5PK0br3UhDNgmorqEnGUC8UtjhdsxI8Sq5Z9pq3plcbqB0UKcOUPHFV38IyQ9Ok0mO
         p9jwse2Q3QeTmpYJHUSTECgCuDnLxb4rx7oRYF8Xh54B2KArYthHEXEVxwIWUxZtEL+4
         RsrQ==
X-Gm-Message-State: AGi0PuYfzn7RNcS1U7K8X33TZHnUd4Gp/vNHWXIIpMxMG7+TbYEF+lR+
        u9rj7hKDeVO5V2gEEcSD5sbE6FsqSjKpNh880DHYH0O7QbJpB559oEH/lLK6Q8chwHU2yAX5Mop
        j7NsIxtMFqJfwkFDgL6gwi2L0
X-Received: by 2002:a5d:6950:: with SMTP id r16mr11568143wrw.388.1587045129598;
        Thu, 16 Apr 2020 06:52:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypK63/aYHcwyhd8tocTraFkjK2hYA4p1i+B3r5iNYJk8yI1wvmbWMNaX6XdqWAZjmgzyg1U15w==
X-Received: by 2002:a5d:6950:: with SMTP id r16mr11568119wrw.388.1587045129315;
        Thu, 16 Apr 2020 06:52:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:399d:3ef7:647c:b12d? ([2001:b07:6468:f312:399d:3ef7:647c:b12d])
        by smtp.gmail.com with ESMTPSA id p7sm28032996wrf.31.2020.04.16.06.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 06:52:08 -0700 (PDT)
Subject: Re: [PATCH 0/2] KVM: x86/mmu: Minor cleanup in try_async_pf()
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20200415214414.10194-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <29248fbf-f0fd-74e6-3edb-ee5ad1e0b33d@redhat.com>
Date:   Thu, 16 Apr 2020 15:52:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415214414.10194-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/20 23:44, Sean Christopherson wrote:
> 
> I'm not 100% on whether or not open coding the private memslot check in
> patch 2 is a good idea.  Avoiding the extra memslot lookup is nice, but
> that could be done by providing e.g. kvm_is_memslot_visible(). 

Yeah, that's better.  The patch is so small that it's even pointless to
split it in two:

From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] KVM: x86/mmu: Avoid an extra memslot lookup in try_async_pf() for L2

Create a new function kvm_is_visible_memslot() and use it from
kvm_is_visible_gfn(); use the new function in try_async_pf() too,
to avoid an extra memslot lookup.

Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6d6cb9416179..fe04ce843a57 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4082,19 +4082,18 @@ static bool try_async_pf(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
 			 gpa_t cr2_or_gpa, kvm_pfn_t *pfn, bool write,
 			 bool *writable)
 {
-	struct kvm_memory_slot *slot;
+	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 	bool async;
 
 	/*
 	 * Don't expose private memslots to L2.
 	 */
-	if (is_guest_mode(vcpu) && !kvm_is_visible_gfn(vcpu->kvm, gfn)) {
+	if (is_guest_mode(vcpu) && !kvm_is_visible_memslot(slot)) {
 		*pfn = KVM_PFN_NOSLOT;
 		*writable = false;
 		return false;
 	}
 
-	slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 	async = false;
 	*pfn = __gfn_to_pfn_memslot(slot, gfn, false, &async, write, writable);
 	if (!async)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 658215f6102c..7d4f1eb70274 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1357,6 +1357,12 @@ static inline void kvm_vcpu_set_dy_eligible(struct kvm_vcpu *vcpu, bool val)
 }
 #endif /* CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT */
 
+static inline bool kvm_is_visible_memslot(struct kvm_memory_slot *memslot)
+{
+	return (memslot && memslot->id < KVM_USER_MEM_SLOTS &&
+		!(memslot->flags & KVM_MEMSLOT_INVALID));
+}
+
 struct kvm_vcpu *kvm_get_running_vcpu(void);
 struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void);
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index da8fd45e0e3e..8aa577db131e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1607,11 +1607,7 @@ bool kvm_is_visible_gfn(struct kvm *kvm, gfn_t gfn)
 {
 	struct kvm_memory_slot *memslot = gfn_to_memslot(kvm, gfn);
 
-	if (!memslot || memslot->id >= KVM_USER_MEM_SLOTS ||
-	      memslot->flags & KVM_MEMSLOT_INVALID)
-		return false;
-
-	return true;
+	return kvm_is_visible_memslot(memslot);
 }
 EXPORT_SYMBOL_GPL(kvm_is_visible_gfn);
 

