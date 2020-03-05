Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F038C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F962166E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0VYjSjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgCEKIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:08:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31287 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726048AbgCEKIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583402926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a++OnOLHx7X8yF6qTfZsk/CBiAFakXwwpWB/hlFxqQk=;
        b=b0VYjSjS8cYmXf37DQDgYEnEctWn1+KamHSN5i4zPaYzLMWfk04ubqegbh8AKo/bBxzWWr
        AhlqZio4+9CnNCDB+sDtApjjaO2hvweK8UqVJzeEMrinQBRH+AvnLtN8BSODXokRKnfRr9
        jxTnnEVS+myOwxKB0Jmy8GFJPuxHSmE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-J_PgCmR1P86beQUa6xyehA-1; Thu, 05 Mar 2020 05:08:43 -0500
X-MC-Unique: J_PgCmR1P86beQUa6xyehA-1
Received: by mail-wr1-f69.google.com with SMTP id m18so2070591wro.22
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 02:08:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=a++OnOLHx7X8yF6qTfZsk/CBiAFakXwwpWB/hlFxqQk=;
        b=osK3H/uamH6e6YVF4djZSnx2AfKTl8fbud3rbCjxLnHMIVCDfHHAo6HhjOMxF37eD7
         xry4Q1V4iS6SCjXIirSA5BUJZfH2XGppP5Y4iaHlwZlAvn6o+wTUfjRncooY3UlH4EPy
         f5BNvF6ukA3GP6IxuZM0/1q0fD8OGb7zdusbhITJ4YfvUp1q5Pyuk5NpaXgItEF42z1R
         mn5aWhyL8F3ZcPPpNRk5abcRnTcyxgSvVlqahJSFo+WbM764K45Dbbr0lvYL4ddzhLf+
         HIJ4M1HgF+mSE7vYHnylkJRTNj9wFzStJr8WXyGpSwIOb/Nj7RECIag0Lcxg8+ORu8za
         rWYw==
X-Gm-Message-State: ANhLgQ1oc+0xgLv1Krm7vHbh1MMmD1Cgkv10jQ3opkgMAThGp4C6FKoS
        AdssmL+SPltxuvEa1DzlDa0vee0oiMyWi0sLq4cNzKFp30ha04NbkSUIurdQV+Xn+5cUf6a4w20
        xUeZEUFdaxWnJDofXw3ZcSvOM
X-Received: by 2002:a1c:f008:: with SMTP id a8mr8497021wmb.81.1583402921632;
        Thu, 05 Mar 2020 02:08:41 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsbhjFKaAeSfPW48bnxoeEB0ks/A9uEmzLV2bTa/Ugj9be5kTg7qhyLsAMwgyzYk+RO9VUxug==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr8497006wmb.81.1583402921444;
        Thu, 05 Mar 2020 02:08:41 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i6sm10535928wra.42.2020.03.05.02.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 02:08:40 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH] KVM: VMX: Use wrapper macro ~RMODE_GUEST_OWNED_EFLAGS_BITS directly
In-Reply-To: <1583375731-18219-1-git-send-email-linmiaohe@huawei.com>
References: <1583375731-18219-1-git-send-email-linmiaohe@huawei.com>
Date:   Thu, 05 Mar 2020 11:08:39 +0100
Message-ID: <87tv33cdw8.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linmiaohe <linmiaohe@huawei.com> writes:

> From: Miaohe Lin <linmiaohe@huawei.com>
>
> (X86_EFLAGS_IOPL | X86_EFLAGS_VM) indicates the eflag bits that can not be
> owned by realmode guest, i.e. ~RMODE_GUEST_OWNED_EFLAGS_BITS. Use wrapper
> macro directly to make it clear and also improve readability.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 743b81642ce2..9571f8dea016 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1466,7 +1466,7 @@ void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
>  	vmx->rflags = rflags;
>  	if (vmx->rmode.vm86_active) {
>  		vmx->rmode.save_rflags = rflags;
> -		rflags |= X86_EFLAGS_IOPL | X86_EFLAGS_VM;
> +		rflags |= ~RMODE_GUEST_OWNED_EFLAGS_BITS;
>  	}
>  	vmcs_writel(GUEST_RFLAGS, rflags);
>  
> @@ -2797,7 +2797,7 @@ static void enter_rmode(struct kvm_vcpu *vcpu)
>  	flags = vmcs_readl(GUEST_RFLAGS);
>  	vmx->rmode.save_rflags = flags;
>  
> -	flags |= X86_EFLAGS_IOPL | X86_EFLAGS_VM;
> +	flags |= ~RMODE_GUEST_OWNED_EFLAGS_BITS;
>  
>  	vmcs_writel(GUEST_RFLAGS, flags);
>  	vmcs_writel(GUEST_CR4, vmcs_readl(GUEST_CR4) | X86_CR4_VME);

Double negations are evil, let's define a macro for 'X86_EFLAGS_IOPL |
X86_EFLAGS_VM' instead (completely untested):

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4ee19fb35cde..d838f93bd6d2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -139,7 +139,8 @@ module_param_named(preemption_timer, enable_preemption_timer, bool, S_IRUGO);
 #define KVM_PMODE_VM_CR4_ALWAYS_ON (X86_CR4_PAE | X86_CR4_VMXE)
 #define KVM_RMODE_VM_CR4_ALWAYS_ON (X86_CR4_VME | X86_CR4_PAE | X86_CR4_VMXE)
 
-#define RMODE_GUEST_OWNED_EFLAGS_BITS (~(X86_EFLAGS_IOPL | X86_EFLAGS_VM))
+#define RMODE_HOST_OWNED_EFLAGS_BITS (X86_EFLAGS_IOPL | X86_EFLAGS_VM)
+#define RMODE_GUEST_OWNED_EFLAGS_BITS (~RMODE_HOST_OWNED_EFLAGS_BITS)
 
 #define MSR_IA32_RTIT_STATUS_MASK (~(RTIT_STATUS_FILTEREN | \
        RTIT_STATUS_CONTEXTEN | RTIT_STATUS_TRIGGEREN | \
@@ -1468,7 +1469,7 @@ void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
        vmx->rflags = rflags;
        if (vmx->rmode.vm86_active) {
                vmx->rmode.save_rflags = rflags;
-               rflags |= X86_EFLAGS_IOPL | X86_EFLAGS_VM;
+               rflags |= RMODE_HOST_OWNED_EFLAGS_BITS;
        }
        vmcs_writel(GUEST_RFLAGS, rflags);
 
@@ -2794,7 +2795,7 @@ static void enter_rmode(struct kvm_vcpu *vcpu)
        flags = vmcs_readl(GUEST_RFLAGS);
        vmx->rmode.save_rflags = flags;
 
-       flags |= X86_EFLAGS_IOPL | X86_EFLAGS_VM;
+       flags |= RMODE_HOST_OWNED_EFLAGS_BITS;
 
        vmcs_writel(GUEST_RFLAGS, flags);
        vmcs_writel(GUEST_CR4, vmcs_readl(GUEST_CR4) | X86_CR4_VME);

-- 
Vitaly

