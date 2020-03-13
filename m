Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B7BC5ACBF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD29020746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idFOZvTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgCMJfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 05:35:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38089 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726377AbgCMJeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 05:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584092076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b9csfzgQL1arrRthML64Bn1Sn3mvBEViBOBi0LSzDTM=;
        b=idFOZvTAFYSa7xXBacqBKcd2EmWVgzGRNy/wFMI98Y2I+WcKqpog77vPsJzQINsSkvFR3x
        g4ODRy2F3509jtR3BYMyTpckkWYXMRVEzttj7XBIndaZH7kCiRGDRcRYwd75LrgX/PDEJB
        k1tZXFFRkdiu2FHSdumgjNgWmJi+yC8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-ly4YoN3tOeSNdzbq2Of6iw-1; Fri, 13 Mar 2020 05:34:35 -0400
X-MC-Unique: ly4YoN3tOeSNdzbq2Of6iw-1
Received: by mail-wm1-f70.google.com with SMTP id n25so2689568wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 02:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=b9csfzgQL1arrRthML64Bn1Sn3mvBEViBOBi0LSzDTM=;
        b=mgLfKi2bHit6DRGaIoNsMW7en/Fp8BpSXQwO0Anwl7RTAOR8y2INmjVXB0uotJbdBD
         tKpc5+xn91T7RiJgp/wjoYc8ggaGkKzqSE64g9K5TADhsYMykl2sCtB9CGg/v6laijDm
         2VLuKnSwn1FABpvqtU5aoF5ULyemCjsVSzyaXQFoK7KYnZ7nXlctz07OrXw3/eswPzXD
         cHFA4vgZAA7S/PkYSL/h4ZCwo2+6o6ZsrG6HSEHOj+ZS522l74ST9TdgP+93V4HcR2PX
         fELlsRQWMWOl9PZjVSqo7AAw3gxVTU50QWB3mDt7wubZV/rQVNfGuEw4Tm4zxBuzwOVS
         ta3A==
X-Gm-Message-State: ANhLgQ1NvMknJ0e+uLMoasr0rRAL4MuuH/V9eO2hMyvqy45/J6xf6LWu
        n9DbgJ5rUhqkbpGP5JRAeu+9DwJYLve8ak6iT+jRT3c1uiBuqn6xK2ZdugaQCWi4M7vBcx1nE20
        G+IOK1nsJsR3u+NT1MLfU1+F9
X-Received: by 2002:a7b:cb42:: with SMTP id v2mr10206255wmj.170.1584092074147;
        Fri, 13 Mar 2020 02:34:34 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuUwXziaHoyA1EEaDQKmhBGTd8I4EwnbQQvJ7qV9xq0EdNJGxLx7LH6TG0wt2i7eEVNjyjK+w==
X-Received: by 2002:a7b:cb42:: with SMTP id v2mr10206222wmj.170.1584092073863;
        Fri, 13 Mar 2020 02:34:33 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id l83sm16592995wmf.43.2020.03.13.02.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 02:34:33 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Toni Spets <toni.spets@iki.fi>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: VMX: Condition ENCLS-exiting enabling on CPU support for SGX1
In-Reply-To: <20200312180416.6679-1-sean.j.christopherson@intel.com>
References: <20200312180416.6679-1-sean.j.christopherson@intel.com>
Date:   Fri, 13 Mar 2020 10:34:32 +0100
Message-ID: <87y2s4pphz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Enable ENCLS-exiting (and thus set vmcs.ENCLS_EXITING_BITMAP) only if
> the CPU supports SGX1.  Per Intel's SDM, all ENCLS leafs #UD if SGX1
> is not supported[*], i.e. intercepting ENCLS to inject a #UD is
> unnecessary.
>
> Avoiding ENCLS-exiting even when it is reported as supported by the CPU
> works around a reported issue where SGX is "hard" disabled after an S3
> suspend/resume cycle, i.e. CPUID.0x7.SGX=0 and the VMCS field/control
> are enumerated as unsupported.  While the root cause of the S3 issue is
> unknown, it's definitely _not_ a KVM (or kernel) bug, i.e. this is a
> workaround for what is most likely a hardware or firmware issue.  As a
> bonus side effect, KVM saves a VMWRITE when first preparing vmcs01 and
> vmcs02.
>
> Query CPUID directly instead of going through cpu_data() or cpu_has() to
> ensure KVM is trapping ENCLS when it's supported in hardware, e.g. even
> if X86_FEATURE_SGX1 (which doesn't yet exist in upstream) were disabled
> by the kernel/user.

I would prefer this paragraph to become a comment right above
cpu_has_sgx() or I bet we'll be getting a lot of 'avoid open-coding
boot_cpu_has() ...' patches in the future.

>
> Note, SGX must be disabled in BIOS to take advantage of this workaround
>
> [*] The additional ENCLS CPUID check on SGX1 exists so that SGX can be
>     globally "soft" disabled post-reset, e.g. if #MC bits in MCi_CTL are
>     cleared.  Soft disabled meaning disabling SGX without clearing the
>     primary CPUID bit (in leaf 0x7) and without poking into non-SGX
>     CPU paths, e.g. for the VMCS controls.
>
> Fixes: 0b665d304028 ("KVM: vmx: Inject #UD for SGX ENCLS instruction in guest")
> Reported-by: Toni Spets <toni.spets@iki.fi>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>
> This seems somewhat premature given that we don't yet know if the observed
> behavior is a logic bug, a one off manufacturing defect, firmware specific,
> etc...  On the other hand, the change is arguably an optimization
> irrespective of using it as a workaround.
>
>  arch/x86/kvm/vmx/vmx.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 40b1e6138cd5..50cab98382e7 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2338,6 +2338,11 @@ static void hardware_disable(void)
>  	kvm_cpu_vmxoff();
>  }
>  
> +static bool cpu_has_sgx(void)
> +{
> +	return cpuid_eax(0) >= 0x12 && (cpuid_eax(0x12) & BIT(0));
> +}
> +
>  static __init int adjust_vmx_controls(u32 ctl_min, u32 ctl_opt,
>  				      u32 msr, u32 *result)
>  {
> @@ -2418,8 +2423,9 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>  			SECONDARY_EXEC_ENABLE_USR_WAIT_PAUSE |
>  			SECONDARY_EXEC_PT_USE_GPA |
>  			SECONDARY_EXEC_PT_CONCEAL_VMX |
> -			SECONDARY_EXEC_ENABLE_VMFUNC |
> -			SECONDARY_EXEC_ENCLS_EXITING;
> +			SECONDARY_EXEC_ENABLE_VMFUNC;
> +		if (cpu_has_sgx())
> +			opt2 |= SECONDARY_EXEC_ENCLS_EXITING;
>  		if (adjust_vmx_controls(min2, opt2,
>  					MSR_IA32_VMX_PROCBASED_CTLS2,
>  					&_cpu_based_2nd_exec_control) < 0)

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

