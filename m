Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB1DC35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FEA721744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJqTYZwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbgBYOzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:55:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45554 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730659AbgBYOzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582642519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gji83vHKV1k5g/ChPkhalite2KXqbop0gZZfM2DEBYg=;
        b=FJqTYZwHS4zMn92K9Y20eurDNQz4YEczt2exBxf5g3ryiKz1UyI5VlfmCCVF8AQCF0l7bY
        V9rmSH/p2V1lFsOmlToX6XaeeWzWYZuBBvMbFj+MJNivo/tMjzvm+WNSgoold4Z5hGKuWU
        OsUfF0XsGGCwmP/k05coM23r/7oVx74=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-agpjJVPJNlu0YTR4JoXKiA-1; Tue, 25 Feb 2020 09:55:14 -0500
X-MC-Unique: agpjJVPJNlu0YTR4JoXKiA-1
Received: by mail-wr1-f70.google.com with SMTP id m15so7376357wrs.22
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 06:55:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Gji83vHKV1k5g/ChPkhalite2KXqbop0gZZfM2DEBYg=;
        b=ZCK3x40O3CbpP413aE82IiaFrUOhzsB9S/MqY9eBQlaTb807UadkngPreqRO7mHdE4
         s2WFnje0UDthqdgxj6WUHSkNR+JI29PVOptFuFEzQgkN9EEjDUKPgY/U4usqGwGBv2pE
         nxyAYGZFKwmgfRNzSxIexJzm44DCLfOyOJzB/4jnRkEonQnjerxIGOAnrvnZN59bDIjB
         dzfTxENOMBv47IqEyxvXFlMbq+yRYVedRunJq9tXnlr1tHvSBQsWmBzcjO/fIloqTM0F
         ybLygNS5PrHo7xRnyEyDN279Uz/gw9Bhzg57o7VMUaT+QWzU9/iXp2JrQWW/PTHmiSBo
         FE/g==
X-Gm-Message-State: APjAAAV0QTY4ajyzsLu9N/yreiKmWzW5RbQMS+sN4PPlHAvypVCPa3Ov
        ki+FeuxUJCoE32D8ryk7JgbZzImRur0GKwi/1jGBItVvWCKrwbU1hV4H2Oq9RNxCWTJOEXyRb5T
        rMU8yESN0EfWjq4gFct1OE0/K
X-Received: by 2002:adf:fc12:: with SMTP id i18mr14772567wrr.354.1582642513260;
        Tue, 25 Feb 2020 06:55:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwXr3wjuxnRC1UK23RsKWqBFdQZDHdHj223uHMid455IAOjAv00FvziRQO2xBJQYBw4ADY7dw==
X-Received: by 2002:adf:fc12:: with SMTP id i18mr14772547wrr.354.1582642513041;
        Tue, 25 Feb 2020 06:55:13 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t10sm3180316wru.59.2020.02.25.06.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 06:55:12 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 59/61] KVM: x86: Don't propagate MMU lpage support to memslot.disallow_lpage
In-Reply-To: <20200201185218.24473-60-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-60-sean.j.christopherson@intel.com>
Date:   Tue, 25 Feb 2020 15:55:11 +0100
Message-ID: <878skqlnsg.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Stop propagating MMU large page support into a memslot's disallow_lpage
> now that the MMU's max_page_level handles the scenario where VMX's EPT is
> enabled and EPT doesn't support 2M pages.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 3 ---
>  arch/x86/kvm/x86.c     | 6 ++----
>  2 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 3ad24ca692a6..e349689ac0cf 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7633,9 +7633,6 @@ static __init int hardware_setup(void)
>  	if (!cpu_has_vmx_tpr_shadow())
>  		kvm_x86_ops->update_cr8_intercept = NULL;
>  
> -	if (enable_ept && !cpu_has_vmx_ept_2m_page())
> -		kvm_disable_largepages();
> -
>  #if IS_ENABLED(CONFIG_HYPERV)
>  	if (ms_hyperv.nested_features & HV_X64_NESTED_GUEST_MAPPING_FLUSH
>  	    && enable_ept) {
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 144143a57d0b..b40488fd2969 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9884,11 +9884,9 @@ int kvm_arch_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
>  		ugfn = slot->userspace_addr >> PAGE_SHIFT;
>  		/*
>  		 * If the gfn and userspace address are not aligned wrt each
> -		 * other, or if explicitly asked to, disable large page
> -		 * support for this slot
> +		 * other, disable large page support for this slot.
>  		 */
> -		if ((slot->base_gfn ^ ugfn) & (KVM_PAGES_PER_HPAGE(level) - 1) ||
> -		    !kvm_largepages_enabled()) {
> +		if ((slot->base_gfn ^ ugfn) & (KVM_PAGES_PER_HPAGE(level) - 1)) {
>  			unsigned long j;
>  
>  			for (j = 0; j < lpages; ++j)

MMU code always explodes my brain, this left me wondering why wasn't the
original vmx_get_lpage_level() adjusted before...

FWIW,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

