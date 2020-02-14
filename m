Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C37AC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 09:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F99E2187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 09:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MG+BzmXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgBNJ1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 04:27:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46907 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728775AbgBNJ1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 04:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581672435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W9L6+hlfFcwPgS55DrqQw6gYUivMR5YUGI9xhyo/lzU=;
        b=MG+BzmXVHO0m0YJ0DJT85NDuvQ9Cp6ZrX4+nAP/3c8qVG0IqFPrIqHLksJ51lrl39UQ2dA
        TyWo3TArHByn5TA7/OuSlhAzSk6UxpU9+r23m1bEq3GBN8Cm9hbG4kudUoA/ZoYRTirng/
        ihBORyyyHc+ydi20lm0q12AMmBSd0bQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-Pc_r-3krMMGC1_vK3agPcw-1; Fri, 14 Feb 2020 04:27:14 -0500
X-MC-Unique: Pc_r-3krMMGC1_vK3agPcw-1
Received: by mail-wr1-f72.google.com with SMTP id n23so3705488wra.20
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 01:27:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W9L6+hlfFcwPgS55DrqQw6gYUivMR5YUGI9xhyo/lzU=;
        b=F20lpiD2uStrGpdoqOtQpSSKJI+qwLn8+D3FoOJSBSD7Y+vkWPrGe7C1HdIaf7AZ3v
         v0Zba2/qfC4ol9CBwSH4g+gkaDU4AKkSc3MtKkg7zCqHe+Dy3EzJrn/bqhXfOxef+GnG
         lsrvSUoiLZ5ij7IhKD3hzA8gNpuNrNxxy6oQ/GaaQZW6oEhsUdtTyWYSvORryvV0sOhC
         B4arD12EHa2Zom1Wb8vArOqq77Y6qdrtAL3ew1/8EH98c7xvZcsSKY4Zpjc4ffIb+ms7
         F0i1fKeyN7xWxlgT/d9rk0lzxFtFGtLlzIkt+3nZ5Xl1gRB5ZBsZ3T+0y+iYFKpbkOVX
         vkoA==
X-Gm-Message-State: APjAAAU/bFYsQ8E18tlyAbsSe7RhZu4yW4poSkIIr/ipspdQpsKPhhh9
        COUmWWRsaUlZVviP8GOzgKxFjadYs87vZmxfNYg2a/y5EjfuVJJXUqwVBUPrSbB1bhuGnDSxgxr
        Kz+X2+vWybOsVk1qMif05n9oS
X-Received: by 2002:adf:cd11:: with SMTP id w17mr3181491wrm.66.1581672432698;
        Fri, 14 Feb 2020 01:27:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqyhDe+9WPl/Lr+ImSq5Cn6F33+OBgghSkd5Er/DXRFlffocFuVtQtoh3XDQuBbSH0ZY2PzbZQ==
X-Received: by 2002:adf:cd11:: with SMTP id w17mr3181453wrm.66.1581672432365;
        Fri, 14 Feb 2020 01:27:12 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4? ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
        by smtp.gmail.com with ESMTPSA id c15sm6427554wrt.1.2020.02.14.01.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 01:27:11 -0800 (PST)
Subject: Re: [PATCH v2] KVM: X86: Grab KVM's srcu lock when accessing hv
 assist page
To:     Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <CANRm+CznPq3LQUyiXr8nA7uP5q+d8Ud-Ki-W7vPCo_BjDJtOSw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7171e537-27f9-c1e5-ae32-9305710be2c7@redhat.com>
Date:   Fri, 14 Feb 2020 10:27:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CANRm+CznPq3LQUyiXr8nA7uP5q+d8Ud-Ki-W7vPCo_BjDJtOSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/20 10:16, Wanpeng Li wrote:
> From: wanpeng li <wanpengli@tencent.com>
> 
> For the duration of mapping eVMCS, it derefences ->memslots without holding
> ->srcu or ->slots_lock when accessing hv assist page. This patch fixes it by
> moving nested_sync_vmcs12_to_shadow to prepare_guest_switch, where the SRCU
> is already taken.

Looks good, but I'd like an extra review from Sean or Vitaly.

We also should add a WARN_ON_ONCE that replaces the previous location of
the "if (vmx->nested.need_vmcs12_to_shadow_sync)", but I can do that myself.

Thanks,

Paolo

> It can be reproduced by running kvm's evmcs_test selftest.
> 
>   =============================
>   warning: suspicious rcu usage
>   5.6.0-rc1+ #53 tainted: g        w ioe
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
>   cpu: 6 pid: 8507 comm: evmcs_test tainted: g        w ioe     5.6.0-rc1+ #53
>   hardware name: dell inc. optiplex 7040/0jctf8, bios 1.4.9 09/12/2016
>   call trace:
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
>    entry_syscall_64_after_hwframe+0x49/0xbe
> 
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 9a66648..6bd6ca4 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1214,6 +1214,9 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
> 
>      vmx_set_host_fs_gs(host_state, fs_sel, gs_sel, fs_base, gs_base);
>      vmx->guest_state_loaded = true;
> +
> +    if (vmx->nested.need_vmcs12_to_shadow_sync)
> +        nested_sync_vmcs12_to_shadow(vcpu);
>  }
> 
>  static void vmx_prepare_switch_to_host(struct vcpu_vmx *vmx)
> @@ -6480,9 +6483,6 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
>          vmcs_write32(PLE_WINDOW, vmx->ple_window);
>      }
> 
> -    if (vmx->nested.need_vmcs12_to_shadow_sync)
> -        nested_sync_vmcs12_to_shadow(vcpu);
> -
>      if (kvm_register_is_dirty(vcpu, VCPU_REGS_RSP))
>          vmcs_writel(GUEST_RSP, vcpu->arch.regs[VCPU_REGS_RSP]);
>      if (kvm_register_is_dirty(vcpu, VCPU_REGS_RIP))
> --
> 2.7.4
> 

