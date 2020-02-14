Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75A6C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A99E222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VM1RXZdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgBNI6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:58:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48296 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727965AbgBNI6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581670722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZxPxH9selPQsPQw4xzzB5zmDFvRGn/ObfsDg5wJhnc=;
        b=VM1RXZdjoVuZ4tciMwBrrHSScyw3iHaTpIViCW7J/fdJWnSeLJcDpSPQhvbYZv9MznHpA3
        HKo7nx7z+WZ1hhy5ElnZEFcXvbuKFvIis9s3sN3+NVAtSdMSKFghSe6i13ONIencqaRrhJ
        aYlCbqyKh2t56GlEJjRkJ8bx4zeQQ7o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-BmiekBUmO_69Vq720PGl3g-1; Fri, 14 Feb 2020 03:58:41 -0500
X-MC-Unique: BmiekBUmO_69Vq720PGl3g-1
Received: by mail-wm1-f70.google.com with SMTP id p2so3527463wma.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 00:58:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VZxPxH9selPQsPQw4xzzB5zmDFvRGn/ObfsDg5wJhnc=;
        b=Vs3lmLd023BVeXCkkks5wiNk24pFqS0g45qgg/j4xkOOix0G+OnwolERTyxObo3arT
         9dCwve2QI7nubg7b6E7bVo3yz9PBpCkbvzc8scB+d827v2ZfxBnk1PFwh0bOv9RzR3Q9
         0P5OiGKcQ5BD7tvCfJvXVJFmWUzwINZf7mVQfhB3goZrNIDCi/rs6MwnM5/SgBzXPy/m
         aGvaEcA4bNz2jGgPBfdT8hwHxhBfTf5LNLjSxj+O9UgsYIk896Mpa1UKC03PWtMlKy66
         DgEmBLrSPMfm/w0yOKSOJSeNl2qCHSUUJF6XfO279ohsJLbwg5tHa1I45D83W2+iTa9v
         LuTw==
X-Gm-Message-State: APjAAAVX0N3KZ58Qc1cVRQioaOEOvY2rXLhS1oV0+LhkKKCEJvt5aFO1
        2YS1iYJ4lyYubiaN93OioDmIaZTpLJp3ZTC7AN65LN8ocdWQV+PsIKG4X7F6+JwwMgIwRjzUa8M
        IuAHtnIJ0bvI39PYSguHGq6Ky
X-Received: by 2002:a1c:1d13:: with SMTP id d19mr3586145wmd.163.1581670719729;
        Fri, 14 Feb 2020 00:58:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqzMQ5zgy765JKWLgB6Jgp08t0X0ZEeA60mDVa8HhL5xAKIpnNOcfDk61imUYkpRDNIURRFpbw==
X-Received: by 2002:a1c:1d13:: with SMTP id d19mr3586100wmd.163.1581670719355;
        Fri, 14 Feb 2020 00:58:39 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4? ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
        by smtp.gmail.com with ESMTPSA id 16sm6300278wmi.0.2020.02.14.00.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 00:58:38 -0800 (PST)
Subject: Re: [PATCH RESEND] KVM: X86: Grab KVM's srcu lock when accessing hv
 assist page
To:     Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <CANRm+CwmVnJqCzN1sWhBOKZBCqpL2ZfRbT-V+tHMGFwPjCZGvw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <353a53a7-5d1e-1797-c870-1eb8b382bedd@redhat.com>
Date:   Fri, 14 Feb 2020 09:58:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CANRm+CwmVnJqCzN1sWhBOKZBCqpL2ZfRbT-V+tHMGFwPjCZGvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/20 09:51, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Acquire kvm->srcu for the duration of mapping eVMCS to fix a bug where accessing
> hv assist page derefences ->memslots without holding ->srcu or ->slots_lock.

Perhaps nested_sync_vmcs12_to_shadow should be moved to
prepare_guest_switch, where the SRCU is already taken.

Paolo

> It can be reproduced by running KVM's evmcs_test selftest.
> 
>   =============================
>   WARNING: suspicious RCU usage
>   5.6.0-rc1+ #53 Tainted: G        W IOE
>   -----------------------------
>   ./include/linux/kvm_host.h:623 suspicious rcu_dereference_check() usage!
> 
>   other info that might help us debug this:
> 
>    rcu_scheduler_active = 2, debug_locks = 1
>   1 lock held by evmcs_test/8507:
>    #0: ffff9ddd156d00d0 (&vcpu->mutex){+.+.}, at:
> kvm_vcpu_ioctl+0x85/0x680 [kvm]
> 
>   stack backtrace:
>   CPU: 6 PID: 8507 Comm: evmcs_test Tainted: G        W IOE     5.6.0-rc1+ #53
>   Hardware name: Dell Inc. OptiPlex 7040/0JCTF8, BIOS 1.4.9 09/12/2016
>   Call Trace:
>    dump_stack+0x68/0x9b
>    kvm_read_guest_cached+0x11d/0x150 [kvm]
>    kvm_hv_get_assist_page+0x33/0x40 [kvm]
>    nested_enlightened_vmentry+0x2c/0x60 [kvm_intel]
>    nested_vmx_handle_enlightened_vmptrld.part.52+0x32/0x1c0 [kvm_intel]
>    nested_sync_vmcs12_to_shadow+0x439/0x680 [kvm_intel]
>    vmx_vcpu_run+0x67a/0xe60 [kvm_intel]
>    vcpu_enter_guest+0x35e/0x1bc0 [kvm]
>    kvm_arch_vcpu_ioctl_run+0x40b/0x670 [kvm]
>    kvm_vcpu_ioctl+0x370/0x680 [kvm]
>    ksys_ioctl+0x235/0x850
>    __x64_sys_ioctl+0x16/0x20
>    do_syscall_64+0x77/0x780
>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 657c2ed..a68a69d 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -1994,14 +1994,18 @@ static int
> nested_vmx_handle_enlightened_vmptrld(struct kvm_vcpu *vcpu,
>  void nested_sync_vmcs12_to_shadow(struct kvm_vcpu *vcpu)
>  {
>      struct vcpu_vmx *vmx = to_vmx(vcpu);
> +    int idx;
> 
>      /*
>       * hv_evmcs may end up being not mapped after migration (when
>       * L2 was running), map it here to make sure vmcs12 changes are
>       * properly reflected.
>       */
> -    if (vmx->nested.enlightened_vmcs_enabled && !vmx->nested.hv_evmcs)
> +    if (vmx->nested.enlightened_vmcs_enabled && !vmx->nested.hv_evmcs) {
> +        idx = srcu_read_lock(&vcpu->kvm->srcu);
>          nested_vmx_handle_enlightened_vmptrld(vcpu, false);
> +        srcu_read_unlock(&vcpu->kvm->srcu, idx);
> +    }
> 
>      if (vmx->nested.hv_evmcs) {
>          copy_vmcs12_to_enlightened(vmx);
> --
> 2.7.4
> 

