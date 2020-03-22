Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB07C4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 13:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54642072E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 13:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tag0G7d6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgCVNIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 09:08:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31893 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725997AbgCVNIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 09:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584882498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wo+FEifuRFslOR4lP0rC0Ti7Taj/A+kMlugh1DShQME=;
        b=Tag0G7d6ysCVSnBR/Mg16CmGmSfgV+RcWeGKn+tmHgqQGjYocGNSRV0iXlx0o17P43Kz1Q
        L5uOElm80PRZxXFY4KlfpcyqCozpwIBQRXf8WP8N3I9L1bHDfe5N1ondA2AByXtsX3J2Ly
        8p63TYncfx4HUDZybwwjH9wrwVinOBY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-VNQwXkbWNdi7xXTGstxbsQ-1; Sun, 22 Mar 2020 09:08:16 -0400
X-MC-Unique: VNQwXkbWNdi7xXTGstxbsQ-1
Received: by mail-wr1-f69.google.com with SMTP id q18so5785722wrw.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 06:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wo+FEifuRFslOR4lP0rC0Ti7Taj/A+kMlugh1DShQME=;
        b=FqXXGe/sFeC5fWTFI7ZF8sAmFbqQRmBpYo/+lgk612yLP7VX77sAK7Nbqn8dAJ4TT4
         EueeAg2rwNeL/5CUdTpYPRdhlindKzGfI0zpJD73nbpUAK7GBQ70LhteYK6olMSWlzpt
         NWg1FrfvM5Z/HzSRTw/skQS/VsSit+YqcwJzgiGRLy4cWCONhUN3GwowLx4ykN5gWCIu
         d8BWvhbhe9rtAKWZzpEeogAEGd3xjhcivQyr64CXFBPTzPhCeY7IxoRRB5YK2NCbJ9f4
         BhxIlORoJItllN+gIxt7bHZIY+6cOxcRzalPkm9wtWFZXkJDwp7P+62bamhQBaFnrmDk
         GARw==
X-Gm-Message-State: ANhLgQ0K/iJFsIf4sd7ycML17+pzdRLpQY8BMdS1EDhWNNZbW+zvdwWs
        2OVhtRZg6+AzQfVyfkTy7NZHbXz8o3yvKOBTue6LJNUsNKZKMdK0R7zZN4hhVv1NTfnHgd1GwDz
        efw+HUj/yHpYSRHv9zgR4f6b8
X-Received: by 2002:adf:dd10:: with SMTP id a16mr15126893wrm.26.1584882495419;
        Sun, 22 Mar 2020 06:08:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vusblq6la+uuydp58U1smaFH+cEB4h83QoWWeBOqy/iybNOzxNYvMhb326r5THN16y+CJaS9A==
X-Received: by 2002:adf:dd10:: with SMTP id a16mr15126869wrm.26.1584882495224;
        Sun, 22 Mar 2020 06:08:15 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id g1sm4072755wro.28.2020.03.22.06.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 06:08:14 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] KVM: VMX: Fold loaded_vmcs_init() into alloc_loaded_vmcs()
In-Reply-To: <20200321193751.24985-3-sean.j.christopherson@intel.com>
References: <20200321193751.24985-1-sean.j.christopherson@intel.com> <20200321193751.24985-3-sean.j.christopherson@intel.com>
Date:   Sun, 22 Mar 2020 14:08:13 +0100
Message-ID: <87fte0bkqq.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Subsume loaded_vmcs_init() into alloc_loaded_vmcs(), its only remaining
> caller, and drop the VMCLEAR on the shadow VMCS, which is guaranteed to
> be NULL.  loaded_vmcs_init() was previously used by loaded_vmcs_clear(),
> but loaded_vmcs_clear() also subsumed loaded_vmcs_init() to properly
> handle smp_wmb() with respect to VMCLEAR.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 14 ++++----------
>  arch/x86/kvm/vmx/vmx.h |  1 -
>  2 files changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index efaca09455bf..07634caa560d 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -653,15 +653,6 @@ static int vmx_set_guest_msr(struct vcpu_vmx *vmx, struct shared_msr_entry *msr,
>  	return ret;
>  }
>  
> -void loaded_vmcs_init(struct loaded_vmcs *loaded_vmcs)
> -{
> -	vmcs_clear(loaded_vmcs->vmcs);
> -	if (loaded_vmcs->shadow_vmcs && loaded_vmcs->launched)
> -		vmcs_clear(loaded_vmcs->shadow_vmcs);
> -	loaded_vmcs->cpu = -1;
> -	loaded_vmcs->launched = 0;
> -}
> -
>  #ifdef CONFIG_KEXEC_CORE
>  static void crash_vmclear_local_loaded_vmcss(void)
>  {
> @@ -2555,9 +2546,12 @@ int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
>  	if (!loaded_vmcs->vmcs)
>  		return -ENOMEM;
>  
> +	vmcs_clear(loaded_vmcs->vmcs);
> +
>  	loaded_vmcs->shadow_vmcs = NULL;
>  	loaded_vmcs->hv_timer_soft_disabled = false;
> -	loaded_vmcs_init(loaded_vmcs);
> +	loaded_vmcs->cpu = -1;
> +	loaded_vmcs->launched = 0;
>  
>  	if (cpu_has_vmx_msr_bitmap()) {
>  		loaded_vmcs->msr_bitmap = (unsigned long *)
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index be93d597306c..79d38f41ef7a 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -492,7 +492,6 @@ struct vmcs *alloc_vmcs_cpu(bool shadow, int cpu, gfp_t flags);
>  void free_vmcs(struct vmcs *vmcs);
>  int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs);
>  void free_loaded_vmcs(struct loaded_vmcs *loaded_vmcs);
> -void loaded_vmcs_init(struct loaded_vmcs *loaded_vmcs);
>  void loaded_vmcs_clear(struct loaded_vmcs *loaded_vmcs);
>  
>  static inline struct vmcs *alloc_vmcs(bool shadow)

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

