Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A170C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A6B2073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGO3BzmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgBLLzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:55:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21423 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725781AbgBLLzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581508508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+nCekSvtnF5ICGx5lYNRGTF4VRbsHea62qKJdV2fz/U=;
        b=PGO3BzmTF6VttXh+nOAlYMGzTw5oOR9347zB7qt4X3ukNDaANVZab5hJBZ04jcbMjGBKOx
        mHFAT28DoMoqA+PlLt5YbB8HeD/IRNjthrpYNxualVfRRt6V+9FDmbF+fwDILWlRoRL1n1
        scRBtwyD+aGlRSSxuBfby1NbtFjByi0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-UARxIu99Mk-tiggExnlUtA-1; Wed, 12 Feb 2020 06:55:06 -0500
X-MC-Unique: UARxIu99Mk-tiggExnlUtA-1
Received: by mail-wm1-f71.google.com with SMTP id g26so621968wmk.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 03:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+nCekSvtnF5ICGx5lYNRGTF4VRbsHea62qKJdV2fz/U=;
        b=UYsw8kTm2uW6VGECKpj+A6H3xFBc3pNCve0FdFkq7KxjPRzLIHF+4pN/vnKJ5JpPAJ
         xiitVPAxLi4/UaVwgJ/Y8DVbVGoFshgAR57cUgXc1MJrv9vWQJidTAFWYRCa8R+17D9E
         FLdlK3VcqMWRq+FhniUtVP7jvxTiHaTAIyeiPAk4JgdgrPuE5CdTYyswhj/8PI/EcMT7
         qbG6gi0wSzhsr+3SuEYDnh+HVfK/ieK3f6mYDEXjMOR91N7y5q198bYS+2HtQLBNx73X
         XX22MM0BqYIrxL86pQS1OAwT93MCKYhsk0thADKBp+Erm5xzeGDDyHW7RXQIrtDYqz2B
         FeWQ==
X-Gm-Message-State: APjAAAWOThZu0TfKe5RxL/8PENZO1IIg/ozH3KYJMyPAxlZdkdRFnPuf
        WmiaBi8NMXY6L5WO4GlRw+lxtIYZhvEDIbTMptdAu8w18kq8VdsFLRx2MAwTCwf6xJV3Yduxzby
        Tgsi9f9A4tHeRVb6OkYK9pz4u
X-Received: by 2002:a05:6000:10c:: with SMTP id o12mr15163427wrx.106.1581508505085;
        Wed, 12 Feb 2020 03:55:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqzhqQox9crYXM4E5K0/jOBGNlzJTU+ZSosFlntFfc8I8yK1mEtYnXRBjEkAkS76pfnNva2ofA==
X-Received: by 2002:a05:6000:10c:: with SMTP id o12mr15163402wrx.106.1581508504809;
        Wed, 12 Feb 2020 03:55:04 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:652c:29a6:517b:66d9? ([2001:b07:6468:f312:652c:29a6:517b:66d9])
        by smtp.gmail.com with ESMTPSA id b13sm377412wrq.48.2020.02.12.03.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 03:55:03 -0800 (PST)
Subject: Re: [PATCH] KVM: x86/mmu: Avoid retpoline on ->page_fault() with TDP
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200206221434.23790-1-sean.j.christopherson@intel.com>
 <878sleg2z7.fsf@vitty.brq.redhat.com> <20200207155539.GC2401@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <408bfd4c-7407-48cd-95fb-db44a7c1c2bf@redhat.com>
Date:   Wed, 12 Feb 2020 12:55:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200207155539.GC2401@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/20 16:55, Sean Christopherson wrote:
> It becomes a matter of weighing the maintenance cost and robustness against
> the performance benefits.  For the TDP case, amost no one (that cares about
> performance) uses shadow paging, the change is very explicit, tiny and
> isolated, and TDP page fault are a hot path, e.g. when booting the VM.
> I.e. low maintenance overhead, still robust, and IMO worth the shenanigans.

The "NULL" trick does not seem needed though.  Any objections to this?

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 9277ee8a54a5..a647601c9e1c 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -109,7 +109,7 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 					u32 err, bool prefault)
 {
 #ifdef CONFIG_RETPOLINE
-	if (likely(!vcpu->arch.mmu->page_fault))
+	if (likely(vcpu->arch.mmu->page_fault == kvm_tdp_page_fault))
 		return kvm_tdp_page_fault(vcpu, cr2_or_gpa, err, prefault);
 #endif
 	return vcpu->arch.mmu->page_fault(vcpu, cr2_or_gpa, err, prefault);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 5267f1440677..87e9ba27ada1 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4925,12 +4925,7 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
 		return;
 
 	context->mmu_role.as_u64 = new_role.as_u64;
-#ifdef CONFIG_RETPOLINE
-	/* Nullify ->page_fault() to use direct kvm_tdp_page_fault() call. */
-	context->page_fault = NULL;
-#else
 	context->page_fault = kvm_tdp_page_fault;
-#endif
 	context->sync_page = nonpaging_sync_page;
 	context->invlpg = nonpaging_invlpg;
 	context->update_pte = nonpaging_update_pte;

Paolo

