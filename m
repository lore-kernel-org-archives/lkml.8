Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3064C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6AA206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXtPj5wg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgCLKg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:36:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60087 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726299AbgCLKgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584009384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GH7fU1TWEWw40X0bZzMnWywwid5YSvqvgDDmRobv45Y=;
        b=iXtPj5wgcCMHSPMzUsWRxwATQWYS/jAqATCs65UX95fNsBSU8NojmKBiZ0siIQNqoCgXSm
        bjdMrPSTDAzVtdUbL1L/5EPCPAaPVkeYNMJnR/m0riWF5afhlS0BRIlPbI/di/7mI0sHVq
        wkrvCNSM/fhh2LY7SCxCQzZUM0LJJE4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-aaaiaHC8OHeu5ht11UZDLw-1; Thu, 12 Mar 2020 06:36:21 -0400
X-MC-Unique: aaaiaHC8OHeu5ht11UZDLw-1
Received: by mail-wr1-f69.google.com with SMTP id j17so2394132wru.19
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 03:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=GH7fU1TWEWw40X0bZzMnWywwid5YSvqvgDDmRobv45Y=;
        b=EY4eiJ+yyQ8NhVjylE1Vjh9cSLFMMJH+tMGjYI+aUZhsatHc0EggpsiYI6MvyRnfBz
         9nouFksM/Bn8FU7nPyPkUNIjrXfJ3cxcQVYwAZRZGellhF4lss6tBvw7zMSI9Q778VKE
         AnIu+nKcYJ+u4LB2ih9Hr6Hbi1EYrp20ex2puzkmnipfZa3LwKWFPSZDGv9ac9QqsvIw
         cUVKttE3pd4BlUL9vyDfEgcCrC8UktFZZMtg9CwBzDUtCbQvcN9RqHe7++gGT78cX5vR
         nhDY+D5AYruL9TOTmtmuUPzdCYVm6wJxQ8LsWZFOQZR0is424RUMFiBOysxtLW0xBB9K
         zIFQ==
X-Gm-Message-State: ANhLgQ2JiQ6YsulPYHkr3gTqaJoAC3YCBw+fhmYW5JC8+/os9JB7w1yF
        /e6HOKNXGUnyWBN/dU2UtZYnwX3dbLrnXsH5UAuo5CJXl4HQuAg9Pj6jedHyfGhqivWYYjc5WSp
        SzONpXD9OpDSI7kYYL7rupuFF
X-Received: by 2002:a1c:2e4d:: with SMTP id u74mr4107935wmu.96.1584009380311;
        Thu, 12 Mar 2020 03:36:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs7zWG7tWo2aK3FgLZH9xdm8Y5FGguMSvAZpJaTh4TPxo4IM8BRiVjLFQaYc3w9c3HX8ctjrA==
X-Received: by 2002:a1c:2e4d:: with SMTP id u74mr4107908wmu.96.1584009380046;
        Thu, 12 Mar 2020 03:36:20 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id l7sm2679012wrw.33.2020.03.12.03.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 03:36:19 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] KVM: VMX: Micro-optimize vmexit time when not exposing PMU
In-Reply-To: <1584007547-4802-1-git-send-email-wanpengli@tencent.com>
References: <1584007547-4802-1-git-send-email-wanpengli@tencent.com>
Date:   Thu, 12 Mar 2020 11:36:19 +0100
Message-ID: <87r1xxrhb0.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> From: Wanpeng Li <wanpengli@tencent.com>
>
> PMU is not exposed to guest by most of cloud providers since the bad performance 
> of PMU emulation and security concern. However, it calls perf_guest_switch_get_msrs()
> and clear_atomic_switch_msr() unconditionally even if PMU is not exposed to the 
> guest before each vmentry. 
>
> ~1.28% vmexit time reduced can be observed by kvm-unit-tests/vmexit.flat on my 
> SKX server.
>
> Before patch:
> vmcall 1559
>
> After patch:
> vmcall 1539
>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 40b1e61..fd526c8 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6441,6 +6441,9 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
>  	int i, nr_msrs;
>  	struct perf_guest_switch_msr *msrs;
>  
> +	if (!vcpu_to_pmu(&vmx->vcpu)->version)
> +		return;
> +
>  	msrs = perf_guest_get_msrs(&nr_msrs);
>  
>  	if (!msrs)

Personally, I'd prefer this to be expressed as

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 40b1e6138cd5..ace92076c90f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6567,7 +6567,9 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
 
        pt_guest_enter(vmx);
 
-       atomic_switch_perf_msrs(vmx);
+       if (vcpu_to_pmu(&vmx->vcpu)->version)
+               atomic_switch_perf_msrs(vmx);
+
        atomic_switch_umwait_control_msr(vmx);
 
        if (enable_preemption_timer)

(which will likely produce the same code as atomic_switch_perf_msrs() is
likely inlined).

Also, (not knowing much about PMU), is
"vcpu_to_pmu(&vmx->vcpu)->version" check correct?

E.g. in intel_is_valid_msr() correct for Intel PMU or is it stated
somewhere that it is generic rule?

Also, speaking about cloud providers and the 'micro' nature of this
optimization, would it rather make sense to introduce a static branch
(the policy to disable vPMU is likely to be host wide, right)?

-- 
Vitaly

