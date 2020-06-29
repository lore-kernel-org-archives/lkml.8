Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD470C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EBA6206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fce1K0Oh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbgF2TGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:06:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55375 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730037AbgF2TGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593457572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wiA60jnjSVk1PN6FvCwFOWuyAKPOYAY44lt2HUcQNf4=;
        b=Fce1K0OhI4n8GXXkr71jHl24wl4Cn5c1UK2uzi7eDRUgQozU7BMbOCFVNgH2BfebMgmcT7
        5THjliWzZixzSxbfbn+ppcPeVR/XnnYlYz1ufDx2dB/ZlhzK6mmI29VdKFzsKcMxri9Vil
        VVLr+Ku+YqyLsuJJzxTplIZdsJiPEP8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-WF7REQIJOxiSNRrVrGysAw-1; Mon, 29 Jun 2020 11:03:44 -0400
X-MC-Unique: WF7REQIJOxiSNRrVrGysAw-1
Received: by mail-wr1-f69.google.com with SMTP id y13so16666132wrp.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wiA60jnjSVk1PN6FvCwFOWuyAKPOYAY44lt2HUcQNf4=;
        b=bv84YorrWpAmSkVEounLH8RrzzWA/LiW3gfz7BAym/QWhiv33wMZge7kj38VH31F94
         SXI8gP9vaO6Uw0eR9SGoXokXqT0Ugu2gvF3q+zsKeWYeMgJ3ynvluJcCxx9/OC54Hqa0
         QlZpEQwkM5/EtLrR0yqf6f5a+/aucArPWDUY3zI24gXaMwKu0lBqFrxpvNBnq6ebC8oC
         7d/dnMGbVXZJ/M/BNqiHyr3hmNSxWH6LykTHN5zi94VioAvB+kRJWm/IOs2D0dVS9Q+Y
         q3fx/IeS21MMp4sGpjhnFyGESP0lVARPfDJxQY/c+ZMQx8hunohV7oNpcAgDfgZ6Mgty
         qvJw==
X-Gm-Message-State: AOAM531kygnbmiZ4TKJmm3ClPPKq4GxHPCoMfITPWAgGmvnvDTLD+Npc
        c6R0e6KUb1nAwltoqQTutAmXtE+dMWYgTxii4ziIIqlGCXhUqWFvHb97q30AdPl/Ngmo2GErkiX
        bI7LvsMa0Eh8JYOi+9QaV6iBr
X-Received: by 2002:a7b:c185:: with SMTP id y5mr17739374wmi.85.1593443023634;
        Mon, 29 Jun 2020 08:03:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfWzhvzup1XHO1uAaeVJMlYTx2UJCwm1ZI0mJJ7N8UF2kln9C5WXC5FIAYwAJfdIO20eLgbA==
X-Received: by 2002:a7b:c185:: with SMTP id y5mr17739339wmi.85.1593443023215;
        Mon, 29 Jun 2020 08:03:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b0e5:c632:a580:8b9a? ([2001:b07:6468:f312:b0e5:c632:a580:8b9a])
        by smtp.gmail.com with ESMTPSA id a126sm63300wme.28.2020.06.29.08.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 08:03:42 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: Fix async pf caused null-ptr-deref
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1593426391-8231-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <60b8326d-3979-6218-4a41-79c86ffab3bd@redhat.com>
Date:   Mon, 29 Jun 2020 17:03:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1593426391-8231-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/20 12:26, Wanpeng Li wrote:
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
>  	vcpu->arch.apf.msr_en_val = data;
>  
>  	if (!kvm_pv_async_pf_enabled(vcpu)) {
> 

Queued, thanks.

Paolo

