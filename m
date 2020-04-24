Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FUZZY_XPILL,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F49EC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 11:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 228E220700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 11:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ixfPudMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgDXLoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 07:44:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27826 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726247AbgDXLoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 07:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587728645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TbNQCab5Ra8181T5/MK2gTcwXHvQ29jb9+DIlTHWC1I=;
        b=ixfPudMzIo4bT9eATyTex1EZ6M1h3qcfWjVsqOL4lNEvwVY8Y+3iAy2T6BARQTwwIFTNYK
        4QBtaR2W7G2LX8vKTXXFHJqh0b1NG5ioI+rq+J1qTF9KZteWLFfY6KttraJpm/nBrSrs9J
        YujLX9PYEgQhn7Dd4RrRR+fqz0vz/rg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-RaElWW2LND2M9fd_5j-zcA-1; Fri, 24 Apr 2020 07:44:04 -0400
X-MC-Unique: RaElWW2LND2M9fd_5j-zcA-1
Received: by mail-wr1-f71.google.com with SMTP id j22so4658965wrb.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 04:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=TbNQCab5Ra8181T5/MK2gTcwXHvQ29jb9+DIlTHWC1I=;
        b=q92hvJjWDrwUEoR+78wsaVPDS+M2Xm81Z119Y+vcp3B8T8eKkCw7xs9pXFCpv+pclg
         DFwgSwJeWR7ch1FUHvUbbJlgAae6WEz1YSI2pxlYeHd7/BHy9va0W9z6d3CpEFfypnSg
         hwouycFxwEpvJG/DWCzbzjTWexK5dvRfkhA8qn9znP3RkO5/W2gG6o3cezeobNEcg+1p
         S/SluKsRhFzKTSfIeBtD001v2q3UVy58rzITSOg/ecs31dyzr18iR2geerG925yu4zVH
         cGLmMd2dfA3HNUQ3w5YJ48GqPAyUb08+kb8gBpjjSl0Rm/QA/0cGEZuaDXMNgpvQt4wL
         83OQ==
X-Gm-Message-State: AGi0PuZXEyA+kOLx8Scb+hu9X910c597ddm6yKwR3n1FQ+iJ3xcj/D31
        455EYs6qHj4wb4/T5It0hIwUNMobs+M2gJpV9QFIV9tXx3X/6bb7W43hXZ1QHk91a4+N00Yf0UQ
        pS6ZbCfIexF8CDPPRIfusjqRc
X-Received: by 2002:a7b:c20f:: with SMTP id x15mr9286262wmi.2.1587728643009;
        Fri, 24 Apr 2020 04:44:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypLKFseMgm1aFXaNx8PZ04efUG3ucG4ytcFQhbEAim7FsrEWHqfaBejy54arQOfgTO8Su3O2yA==
X-Received: by 2002:a7b:c20f:: with SMTP id x15mr9286230wmi.2.1587728642771;
        Fri, 24 Apr 2020 04:44:02 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id h1sm2625970wme.42.2020.04.24.04.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 04:44:02 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: nVMX: Store vmcs.EXIT_QUALIFICATION as an unsigned long, not u32
In-Reply-To: <20200423001127.13490-1-sean.j.christopherson@intel.com>
References: <20200423001127.13490-1-sean.j.christopherson@intel.com>
Date:   Fri, 24 Apr 2020 13:44:00 +0200
Message-ID: <87wo65nm67.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Use an unsigned long for 'exit_qual' in nested_vmx_reflect_vmexit(), the
> EXIT_QUALIFICATION field is naturally sized, not a 32-bit field.
>
> The bug is most easily observed by doing VMXON (or any VMX instruction)
> in L2 with a negative displacement, in which case dropping the upper
> bits on nested VM-Exit results in L1 calculating the wrong virtual
> address for the memory operand, e.g. "vmxon -0x8(%rbp)" yields:
>
>   Unhandled cpu exception 14 #PF at ip 0000000000400553
>   rbp=0000000000537000 cr2=0000000100536ff8
>
> Fixes: fbdd50250396d ("KVM: nVMX: Move VM-Fail check out of nested_vmx_exit_reflected()")
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>
> Sadly (for me), I can't blame a mishandled merge on this one.  Even more
> embarassing is that this is actually the second instance where I botched
> the size for exit_qual, you'd think I'd have double-checked everything
> after the first one...
>
>  arch/x86/kvm/vmx/nested.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index f228339cd0a0..3f32f81f5c59 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5814,7 +5814,8 @@ bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>  	u32 exit_reason = vmx->exit_reason;
> -	u32 exit_intr_info, exit_qual;
> +	unsigned long exit_qual;
> +	u32 exit_intr_info;
>  
>  	WARN_ON_ONCE(vmx->nested.nested_run_pending);

Too late but

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

I also did 'git grep -W 'u32.*exit_qual' kvm/queue' and I can see a few
more places where 'exit_qual' is u32:
nested_vmx_check_guest_state()
nested_vmx_enter_non_root_mode()
vmx_set_nested_state()

Being too lazy to check an even if there are no immediate issues with
that, should we just use 'unsigned long' everywhere?

-- 
Vitaly

