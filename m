Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50149C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F1B2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbM12CpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgFDOk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:40:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37829 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728682AbgFDOk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591281656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T1KzIQ4ZIm1Bb01N7lRD8u70UzbaIWnRS/sElZztpMM=;
        b=HbM12CpUDYB+eaizVmTEDR8FDZOMS0ndFU5VPK32cfeoNcvqpSbbtFq6HkTNs+QA2b9yv9
        XHcVYEulBcy0iTomHM8ZzAK1HxZ8tJG+MvYaeM9bDXFidGyIMECbqD2CCfkJyE4hojNXSL
        ccAeaqPLh3I7MXYZ48SSFpFNYwz6lY0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-ftwfZGpvNniY_jRkebqKBA-1; Thu, 04 Jun 2020 10:40:55 -0400
X-MC-Unique: ftwfZGpvNniY_jRkebqKBA-1
Received: by mail-wr1-f69.google.com with SMTP id s17so2501496wrt.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 07:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T1KzIQ4ZIm1Bb01N7lRD8u70UzbaIWnRS/sElZztpMM=;
        b=MNFXTg09kbu4hyCSYrANr1V92eMgKETghuSQOFUY2EIclwPjHBT+Yi+zjGu60Bi9sE
         6NU0HOVIBpUPqBrnzG4O+tDVnpLlZswhTQe9Et7Bh6VvkG7XDW5BQ7XfX5EQnKuH4WYT
         dsrhfxl8HN1Wo+Z38rcI+ZPTparsKooXIiMgH8mOTfcM2k8WtWfbStgQ8n382e0pRQE9
         WkbcFGNuFqaQpAi2B5LW/INPYAegyhsqUlbhxH/vXAsqy0HVI78Am+e8aNjty7dODfkM
         sJubGzFJia3sJz5RV/k+FRa/t/QsAva+HJIM1mwVSXfI/oavoedU2Ng7o1yK+ISALljk
         l+vA==
X-Gm-Message-State: AOAM530Zc6duP7GBF5XU6snI564AqXQV0Qgu5bW6TGnH39wRisHTQWoG
        HmwJ/ojLUNcEIDrUDL05FUSkQLFfSgRFfHofuP9CisjmkBePjjByxhQmf5l6R+RscfcOFOrWPkP
        o+VbE3mECemE6YOrze0s4JPBq
X-Received: by 2002:a5d:4f09:: with SMTP id c9mr4622976wru.3.1591281654238;
        Thu, 04 Jun 2020 07:40:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0T3+36Rp24qdkIttu0E+JI6/N5toSssvU3HegZCFxjFGCHGF+T9y5wmhzxGSCEXHDXbg8JA==
X-Received: by 2002:a5d:4f09:: with SMTP id c9mr4622958wru.3.1591281653985;
        Thu, 04 Jun 2020 07:40:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb? ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
        by smtp.gmail.com with ESMTPSA id 23sm7275756wmg.10.2020.06.04.07.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 07:40:53 -0700 (PDT)
Subject: Re: [PATCH] KVM: nVMX: Inject #GP when nested_vmx_get_vmptr() fails
 to read guest memory
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
References: <20200604143158.484651-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <da7acd6f-204d-70e2-52aa-915a4d9163ef@redhat.com>
Date:   Thu, 4 Jun 2020 16:40:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200604143158.484651-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/20 16:31, Vitaly Kuznetsov wrote:
> Syzbot reports the following issue:
> 
> WARNING: CPU: 0 PID: 6819 at arch/x86/kvm/x86.c:618 kvm_inject_emulated_page_fault+0x210/0x290 arch/x86/kvm/x86.c:618
> ...
> Call Trace:
> ...
> RIP: 0010:kvm_inject_emulated_page_fault+0x210/0x290 arch/x86/kvm/x86.c:618
> ...
>  nested_vmx_get_vmptr+0x1f9/0x2a0 arch/x86/kvm/vmx/nested.c:4638
>  handle_vmon arch/x86/kvm/vmx/nested.c:4767 [inline]
>  handle_vmon+0x168/0x3a0 arch/x86/kvm/vmx/nested.c:4728
>  vmx_handle_exit+0x29c/0x1260 arch/x86/kvm/vmx/vmx.c:6067
> 
> 'exception' we're trying to inject with kvm_inject_emulated_page_fault() comes from
>   nested_vmx_get_vmptr()
>    kvm_read_guest_virt()
>      kvm_read_guest_virt_helper()
>        vcpu->arch.walk_mmu->gva_to_gpa()
> 
> but it is only set when GVA to GPA conversion fails. In case it doesn't but
> we still fail kvm_vcpu_read_guest_page(), X86EMUL_IO_NEEDED is returned and
> nested_vmx_get_vmptr() calls kvm_inject_emulated_page_fault() with zeroed
> 'exception'. This happen when e.g. VMXON/VMPTRLD/VMCLEAR argument is MMIO.
> 
> KVM could've handled the request correctly by going to userspace and
> performing I/O but there doesn't seem to be a good need for such requests
> in the first place. Sane guests should not call VMXON/VMPTRLD/VMCLEAR with
> anything but normal memory. Just inject #GP to find insane ones.
> 
> Reported-by: syzbot+2a7156e11dc199bdbd8a@syzkaller.appspotmail.com
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 9c74a732b08d..05d57c3cb1ce 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -4628,14 +4628,29 @@ static int nested_vmx_get_vmptr(struct kvm_vcpu *vcpu, gpa_t *vmpointer)
>  {
>  	gva_t gva;
>  	struct x86_exception e;
> +	int r;
>  
>  	if (get_vmx_mem_address(vcpu, vmx_get_exit_qual(vcpu),
>  				vmcs_read32(VMX_INSTRUCTION_INFO), false,
>  				sizeof(*vmpointer), &gva))
>  		return 1;
>  
> -	if (kvm_read_guest_virt(vcpu, gva, vmpointer, sizeof(*vmpointer), &e)) {
> -		kvm_inject_emulated_page_fault(vcpu, &e);
> +	r = kvm_read_guest_virt(vcpu, gva, vmpointer, sizeof(*vmpointer), &e);
> +	if (r != X86EMUL_CONTINUE) {
> +		if (r == X86EMUL_PROPAGATE_FAULT) {
> +			kvm_inject_emulated_page_fault(vcpu, &e);
> +		} else {
> +			/*
> +			 * X86EMUL_IO_NEEDED is returned when kvm_vcpu_read_guest_page()
> +			 * fails to read guest's memory (e.g. when 'gva' points to MMIO
> +			 * space). While KVM could've handled the request correctly by
> +			 * exiting to userspace and performing I/O, there doesn't seem
> +			 * to be a real use-case behind such requests, just inject #GP
> +			 * for now.
> +			 */
> +			kvm_inject_gp(vcpu, 0);
> +		}
> +
>  		return 1;
>  	}
>  
> 

Hi Vitaly,

looks good but we need to do the same in handle_vmread, handle_vmwrite,
handle_invept and handle_invvpid.  Which probably means adding something
like nested_inject_emulation_fault to commonize the inner "if".

Thanks,

Paolo

