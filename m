Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274FAC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E7A206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0wQf7g9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCMMrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:47:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46911 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726426AbgCMMrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584103625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cVGvYp8s4tIYmQbZbCv3pyCVPMIadQ3rGV3wCFwPiPQ=;
        b=P0wQf7g95cE1OYv4e0N0SL9yEmMHyf9bB0s8rMxvri45V8Q7+h3O5AMtKNBx43F1A6XaO5
        az2PpdTasrhJiPjI9ec6XvCaO+SQy8F+DJk4Um3SAam1v8CScTlsontBFOSJcOQM6iKp8Z
        EGcbWHxSEGmH/hEegYC5cYTtkBzvOys=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-ZqvBH-IDP8Op0KM2XeutcA-1; Fri, 13 Mar 2020 08:47:04 -0400
X-MC-Unique: ZqvBH-IDP8Op0KM2XeutcA-1
Received: by mail-wr1-f71.google.com with SMTP id l16so3493134wrr.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 05:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=cVGvYp8s4tIYmQbZbCv3pyCVPMIadQ3rGV3wCFwPiPQ=;
        b=Rj5xTk7/tQ/0h6F3Z7T0bbGAhv2MaHsH8a31WmHccMQK5O3YXRYo2VujMKbYNUSRSq
         8dNm9uT+Dkyc2qwbUXkbcX0/7qs+fEldsIS5cMoEju+1+vgkdHJ7uJFLbjEc6eS8aISc
         t/Y1beQND/WzBTgqtNo05T6OFjmaeUt8I49hnyjYV3yYJXd8rayQ03h4vAghb6+S4d81
         lscDVDfCV52io+pIihFuj9HxdePXLEonQxwxpcorUW00H28QUVhhW7R5tgI6ZTs+rRbm
         /ygo/0BBc2euwi9GIO/FYVr7ZotPZ14zguLLDdHCIRgwF0jjdzibeMysK1Lr5pfKfyMz
         CyNw==
X-Gm-Message-State: ANhLgQ0YMWL3MwXEl3Et0dSixw4mqKr6EMfvuxj8mwGLVp9neq7ZxP+w
        GUDnTBqI7sQXT5TOAzRXEGChsD4SGCo/qZn3TYrGXzhNxztgmqurKNmxy/8ejNl8BWnVbITEyEX
        yxCBg8HXsS0xfWPVLXSoZuibI
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr10738915wmc.39.1584103623133;
        Fri, 13 Mar 2020 05:47:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuB2U9pYEH4d9F0BJmVdxxrIWk5xI3GpDU0d8J7LIDQTOvO+P2YVyz1UPOYDpy7EcUGXaBvAQ==
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr10738899wmc.39.1584103622905;
        Fri, 13 Mar 2020 05:47:02 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id l18sm9773424wrr.17.2020.03.13.05.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 05:47:01 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH 04/10] KVM: VMX: Convert local exit_reason to u16 in nested_vmx_exit_reflected()
In-Reply-To: <20200312184521.24579-5-sean.j.christopherson@intel.com>
References: <20200312184521.24579-1-sean.j.christopherson@intel.com> <20200312184521.24579-5-sean.j.christopherson@intel.com>
Date:   Fri, 13 Mar 2020 13:47:01 +0100
Message-ID: <87a74kpgl6.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Store only the basic exit reason in the local "exit_reason" variable in
> nested_vmx_exit_reflected().  Except for tracing, all references to
> exit_reason are expecting to encounter only the basic exit reason.
>
> Opportunistically align the params to nested_vmx_exit_handled_msr().
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index cb05bcbbfc4e..1848ca0116c0 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5374,7 +5374,7 @@ static bool nested_vmx_exit_handled_io(struct kvm_vcpu *vcpu,
>   * MSR bitmap. This may be the case even when L0 doesn't use MSR bitmaps.
>   */
>  static bool nested_vmx_exit_handled_msr(struct kvm_vcpu *vcpu,
> -	struct vmcs12 *vmcs12, u32 exit_reason)
> +					struct vmcs12 *vmcs12, u16 exit_reason)
>  {
>  	u32 msr_index = kvm_rcx_read(vcpu);
>  	gpa_t bitmap;
> @@ -5523,7 +5523,7 @@ bool nested_vmx_exit_reflected(struct kvm_vcpu *vcpu)
>  	u32 intr_info = vmcs_read32(VM_EXIT_INTR_INFO);
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>  	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
> -	u32 exit_reason = vmx->exit_reason;
> +	u16 exit_reason;
>  
>  	if (vmx->nested.nested_run_pending)
>  		return false;
> @@ -5548,13 +5548,15 @@ bool nested_vmx_exit_reflected(struct kvm_vcpu *vcpu)
>  	 */
>  	nested_mark_vmcs12_pages_dirty(vcpu);
>  
> -	trace_kvm_nested_vmexit(kvm_rip_read(vcpu), exit_reason,
> +	trace_kvm_nested_vmexit(kvm_rip_read(vcpu), vmx->exit_reason,
>  				vmcs_readl(EXIT_QUALIFICATION),
>  				vmx->idt_vectoring_info,
>  				intr_info,
>  				vmcs_read32(VM_EXIT_INTR_ERROR_CODE),
>  				KVM_ISA_VMX);
>  
> +	exit_reason = vmx->exit_reason;
> +
>  	switch (exit_reason) {
>  	case EXIT_REASON_EXCEPTION_NMI:
>  		if (is_nmi(intr_info))

If the patch is looked at by itself (and not as part of the series) one
may ask to add a comment explaining that we do the trunctation
deliberately but with all patches of the series it is superfluous.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

