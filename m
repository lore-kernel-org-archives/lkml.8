Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A7BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD6D20656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxauVzyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgF2Srj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:47:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28761 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728003AbgF2Srg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593456454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=is53wqYM+DH4GlUOLl6eyQhk3j5Rkm24u9IsygULR3E=;
        b=GxauVzyQtrQIIUd2O6H6OByChCMIQRNojC8fysrQGmM2GRz+lcW5rrRYhDwa0R1i0yLZCL
        r5Oz5NJypK8f2YvSI1CSU72TIMf1mhZaIPwHxLLs9GH4iLpDkXmLMeLYzLv52l+uiCap2Z
        PJkXTEplIeIghUzvhfv8vBFGPhLCiZI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-dFBC5HF2MFm5pRnxUx_OBA-1; Mon, 29 Jun 2020 09:46:46 -0400
X-MC-Unique: dFBC5HF2MFm5pRnxUx_OBA-1
Received: by mail-ed1-f69.google.com with SMTP id x20so14170367edr.20
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 06:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=is53wqYM+DH4GlUOLl6eyQhk3j5Rkm24u9IsygULR3E=;
        b=kwQiAoSMBuLt8977Ryg7kwYfbcEcxxLKEFVVTPfjnvULZTartwXfi0x/3oF+4uid82
         +8alk+07xWX/z0JPwxSNP4pFQn+LTDxPwgb9sIfVXhH01aotuAfT+L4LYY8dmD0Vha8i
         lz1h1j8CcB1LKQwaGAzZu6TVC5Kau97hliKq3xmPot0wZgXx2tmx9e2IAzrDfq1nEt9/
         B5HmVNkkOk5ap0pNYnILnAqX483b+DR4fVxAjjw9r2OxFBh3hAizUDWRWooV8WEcjl5f
         XTMKdXsyPY3PzExG49a5qq3cJX/JW4aoKidG+Om3HejGhmbzHPFLQplKCpBhCH1yXM0/
         4Z0A==
X-Gm-Message-State: AOAM531woLmkLJFZOVvaBsbib4JTh6vc0zf61k9tBDNwl9MlmiNK8Yxw
        wsSFBXOUpN4tFRLS4f7ZFZsfx24msjgrFq4VCz5NZTFVVVTzBReufzXUBOLhe9tleU+yJWkcQDt
        gEiPPtewgQEivYYj3KkPqEd87
X-Received: by 2002:a17:906:8607:: with SMTP id o7mr13831839ejx.142.1593438405550;
        Mon, 29 Jun 2020 06:46:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxewVMMB60DfYI8z+2p9BsuKt4Mh3TKFrImVLPlOVRyz+wPv5CMtmyRSbX5oxgxbsyu8yAeIg==
X-Received: by 2002:a17:906:8607:: with SMTP id o7mr13831812ejx.142.1593438405243;
        Mon, 29 Jun 2020 06:46:45 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id d12sm54628edx.80.2020.06.29.06.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 06:46:44 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: X86: Fix async pf caused null-ptr-deref
In-Reply-To: <1593426391-8231-1-git-send-email-wanpengli@tencent.com>
References: <1593426391-8231-1-git-send-email-wanpengli@tencent.com>
Date:   Mon, 29 Jun 2020 15:46:43 +0200
Message-ID: <877dvqc7cs.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> From: Wanpeng Li <wanpengli@tencent.com>
>
> Syzbot reported that:
>
>   CPU: 1 PID: 6780 Comm: syz-executor153 Not tainted 5.7.0-syzkaller #0
>   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>   RIP: 0010:__apic_accept_irq+0x46/0xb80
>   Call Trace:
>    kvm_arch_async_page_present+0x7de/0x9e0
>    kvm_check_async_pf_completion+0x18d/0x400
>    kvm_arch_vcpu_ioctl_run+0x18bf/0x69f0
>    kvm_vcpu_ioctl+0x46a/0xe20
>    ksys_ioctl+0x11a/0x180
>    __x64_sys_ioctl+0x6f/0xb0
>    do_syscall_64+0xf6/0x7d0
>    entry_SYSCALL_64_after_hwframe+0x49/0xb3
>  
> The testcase enables APF mechanism in MSR_KVM_ASYNC_PF_EN with ASYNC_PF_INT 
> enabled w/o setting MSR_KVM_ASYNC_PF_INT before, what's worse, interrupt 
> based APF 'page ready' event delivery depends on in kernel lapic, however, 
> we didn't bail out when lapic is not in kernel during guest setting 
> MSR_KVM_ASYNC_PF_EN which causes the null-ptr-deref in host later. 
> This patch fixes it.
>
> Reported-by: syzbot+1bf777dfdde86d64b89b@syzkaller.appspotmail.com
> Fixes: 2635b5c4a0 (KVM: x86: interrupt based APF 'page ready' event delivery)

Thanks!

> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/x86.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 00c88c2..1c0b4f5 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2693,6 +2693,9 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
>  	if (data & 0x30)
>  		return 1;
>  
> +	if (!lapic_in_kernel(vcpu))
> +		return 1;
> +

I'm not sure how much we care about !lapic_in_kernel() case but this
change should be accompanied with userspace changes to not expose
KVM_FEATURE_ASYNC_PF_INT or how would the guest know that writing a
legitimate value will result in #GP?

Alternatively, we may just return '0' here: guest will be able to check
what's in the MSR to see if the feature was enabled. Normally, guests
shouldn't care about this but maybe there are cases when they do?

>  	vcpu->arch.apf.msr_en_val = data;
>  
>  	if (!kvm_pv_async_pf_enabled(vcpu)) {

-- 
Vitaly

