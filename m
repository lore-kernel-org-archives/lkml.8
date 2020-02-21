Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC7EC35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A972073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ht15uYtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgBUN0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:26:51 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22242 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727213AbgBUN0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582291609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pp52uql4euz6sc9/tpF3BoUO1r84mKC2NqpqrjvTgCE=;
        b=ht15uYttCA70vhyz6GJezZ8yIhy6w+7SbNuKFOGJJkK3o7Kj6UYUSaHA05/XThEpt+RPyj
        Piq+LwqTX7vLcMQJeJmHj2KRkBFFnmV/xsL49Gv+2dRulpHyOvtiFMDC8MMq3CXX2RlgMU
        sfVFLwupqFu1t5Mw1me/xPAtiT8d0ws=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-wzAf4nRJMJOpcBnztrrYrQ-1; Fri, 21 Feb 2020 08:26:48 -0500
X-MC-Unique: wzAf4nRJMJOpcBnztrrYrQ-1
Received: by mail-wm1-f71.google.com with SMTP id b205so615548wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 05:26:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=pp52uql4euz6sc9/tpF3BoUO1r84mKC2NqpqrjvTgCE=;
        b=ppAxkJLqrV/HWgPc6ellRegFbVu377NDMUqI2cQQaKU2xyBp8luuPWQQqfrNA2bO2x
         kEvu/Hrnf1oW8qhE/+wdplSeeBsyPanb0ydOs3W5Nm7dbW7lwizcw8KJdMq423P7Y8R3
         JyGbJMTlV2ZzgI3BdqPldZU3YP9x+8+82847aN6wn57EC2KGdTTDUDd9wgshA9fE6tEF
         eNRAuuXIMTAKQxzRtoI+H0nLfhmagdiQWsFqxXAACPktsS9NmVGnevsJ2sIEnptxxhhy
         D6ctYwM0ZNFHpJq0jTCEkL5S8dH/aJVvgw8exy6tsJ4rwsCI7fuEKzB+NDW0CmwFgdRG
         +7BQ==
X-Gm-Message-State: APjAAAW/Tvz1agmEDrAuPxSOhjvYosyRVhJNSsSbwTM4rI51sssFSajY
        aRiOIP+O6aVF1qbiUcAZ2c0/gng9WlAVBAbF9+sSHt1pWIh9iI+iclL4tMT1CuJWDTexe+rEiNf
        txmdMRohOLc1rypvEi8ydI34M
X-Received: by 2002:a1c:b0c3:: with SMTP id z186mr3858302wme.36.1582291606669;
        Fri, 21 Feb 2020 05:26:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqzxbF95OXsrWyungR3AunMn453gY9WbnEXGRp+W3FBe+YdiQTXfHAprgJwrb8V0Wwn3+8m1hA==
X-Received: by 2002:a1c:b0c3:: with SMTP id z186mr3858273wme.36.1582291606366;
        Fri, 21 Feb 2020 05:26:46 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b17sm4095785wrp.49.2020.02.21.05.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 05:26:45 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] KVM: VMX: Handle INVVPID fallback logic in vpid_sync_vcpu_addr()
In-Reply-To: <20200220204356.8837-4-sean.j.christopherson@intel.com>
References: <20200220204356.8837-1-sean.j.christopherson@intel.com> <20200220204356.8837-4-sean.j.christopherson@intel.com>
Date:   Fri, 21 Feb 2020 14:26:45 +0100
Message-ID: <8736b4t6ju.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Directly invoke vpid_sync_context() to do a global INVVPID when the
> individual address variant is not supported instead of deferring such
> behavior to the caller.  This allows for additional consolidation of
> code as the logic is basically identical to the emulation of the
> individual address variant in handle_invvpid().
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/ops.h | 12 +++++-------
>  arch/x86/kvm/vmx/vmx.c |  3 +--
>  2 files changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/ops.h b/arch/x86/kvm/vmx/ops.h
> index a2b0689e65e3..612df1bdb26b 100644
> --- a/arch/x86/kvm/vmx/ops.h
> +++ b/arch/x86/kvm/vmx/ops.h
> @@ -276,17 +276,15 @@ static inline void vpid_sync_context(int vpid)
>  		vpid_sync_vcpu_global();
>  }
>  
> -static inline bool vpid_sync_vcpu_addr(int vpid, gva_t addr)
> +static inline void vpid_sync_vcpu_addr(int vpid, gva_t addr)
>  {
>  	if (vpid == 0)
> -		return true;
> +		return;
>  
> -	if (cpu_has_vmx_invvpid_individual_addr()) {
> +	if (cpu_has_vmx_invvpid_individual_addr())
>  		__invvpid(VMX_VPID_EXTENT_INDIVIDUAL_ADDR, vpid, addr);
> -		return true;
> -	}
> -
> -	return false;
> +	else
> +		vpid_sync_context(vpid);
>  }
>  
>  static inline void ept_sync_global(void)
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 9a6664886f2e..349a6e054e0e 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2826,8 +2826,7 @@ static void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr)
>  {
>  	int vpid = to_vmx(vcpu)->vpid;
>  
> -	if (!vpid_sync_vcpu_addr(vpid, addr))
> -		vpid_sync_context(vpid);
> +	vpid_sync_vcpu_addr(vpid, addr);
>  
>  	/*
>  	 * If VPIDs are not supported or enabled, then the above is a no-op.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

