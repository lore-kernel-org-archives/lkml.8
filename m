Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFA2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C59BE20663
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFUigwMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgFDOxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:53:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41427 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729089AbgFDOxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591282421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bkjkczUAegkCYVD3I4mCfLncEzS/Hv9PCrfpe6zg2Qc=;
        b=dFUigwMNlR4Ca5xnid82ixO/o7O3J2cYZNxC8QnNkNUHOC+A5a1C1LBL64IYapjBovDBSg
        iAx2O982JbOFWRyMQqi8kA50+4yEYEnme/Ad31Kku7H2dceowVFqz9PMKPIspmfMc+HrzJ
        emBdQW6PYHocnCcc7AkNXCiIueCwWPI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-cSAcU14RO6SFvZZihQ6nQw-1; Thu, 04 Jun 2020 10:53:38 -0400
X-MC-Unique: cSAcU14RO6SFvZZihQ6nQw-1
Received: by mail-ej1-f72.google.com with SMTP id gr26so2228115ejb.22
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 07:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bkjkczUAegkCYVD3I4mCfLncEzS/Hv9PCrfpe6zg2Qc=;
        b=kEO2cIsYAnMywn0sj0F1plYwHdiDyfeFkqlckqmJLv04UfUjYKSzmbKKmOXPZxgwAz
         r27VCEUw1ULAu1sAwQkKXLcJVZk2PHBKM+oIRC5u9TvNjHnrEXpihUR3Eww5+xg4Larm
         hy1T5IME4FSEphFE54iSc2/N53MaQfYg3O7cIrYM8NnIvW+rhcDxPlGxa8KlAkOHRQom
         HdbcR5ePRwZwArv7ve0BLQN8xnUFKj7hz9VwuLVUZ/pnmCdyepe9GNQuVtBPbTSmcmaF
         EuZr8TkZiFbRhhH+Gd3YmRMxvhcUe/U02S7/c2D4bo3LQhM76JivoLnJLUBL1T4NbpHu
         Z1vA==
X-Gm-Message-State: AOAM5315j4XImNnj5pVUlGsRWjXXgDG6B0ULpVdDkl563njiM32sgV+j
        zTw2XgAy+A4SbrZGFluAqlvDrZc7qjbvgzu2gsvIALwxWWiIwGLRzH3YuWXWIQ/kHLeRBauFJg8
        1YOycENEBPD7kCss2Qrta1f0z
X-Received: by 2002:a05:6402:1d96:: with SMTP id dk22mr4850221edb.258.1591282416850;
        Thu, 04 Jun 2020 07:53:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdUWD/soPlYgGL8mgklo+O0gr8pBKIXLBPJA28P88u/VAkfY5QZj9Zn762qCiARN2fkqYzVQ==
X-Received: by 2002:a05:6402:1d96:: with SMTP id dk22mr4850191edb.258.1591282416533;
        Thu, 04 Jun 2020 07:53:36 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id ce16sm2313704ejb.76.2020.06.04.07.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 07:53:36 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: nVMX: Inject #GP when nested_vmx_get_vmptr() fails to read guest memory
In-Reply-To: <da7acd6f-204d-70e2-52aa-915a4d9163ef@redhat.com>
References: <20200604143158.484651-1-vkuznets@redhat.com> <da7acd6f-204d-70e2-52aa-915a4d9163ef@redhat.com>
Date:   Thu, 04 Jun 2020 16:53:35 +0200
Message-ID: <87mu5ievbk.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 04/06/20 16:31, Vitaly Kuznetsov wrote:
>> Syzbot reports the following issue:
>> 
>> WARNING: CPU: 0 PID: 6819 at arch/x86/kvm/x86.c:618 kvm_inject_emulated_page_fault+0x210/0x290 arch/x86/kvm/x86.c:618
>> ...
>> Call Trace:
>> ...
>> RIP: 0010:kvm_inject_emulated_page_fault+0x210/0x290 arch/x86/kvm/x86.c:618
>> ...
>>  nested_vmx_get_vmptr+0x1f9/0x2a0 arch/x86/kvm/vmx/nested.c:4638
>>  handle_vmon arch/x86/kvm/vmx/nested.c:4767 [inline]
>>  handle_vmon+0x168/0x3a0 arch/x86/kvm/vmx/nested.c:4728
>>  vmx_handle_exit+0x29c/0x1260 arch/x86/kvm/vmx/vmx.c:6067
>> 
>> 'exception' we're trying to inject with kvm_inject_emulated_page_fault() comes from
>>   nested_vmx_get_vmptr()
>>    kvm_read_guest_virt()
>>      kvm_read_guest_virt_helper()
>>        vcpu->arch.walk_mmu->gva_to_gpa()
>> 
>> but it is only set when GVA to GPA conversion fails. In case it doesn't but
>> we still fail kvm_vcpu_read_guest_page(), X86EMUL_IO_NEEDED is returned and
>> nested_vmx_get_vmptr() calls kvm_inject_emulated_page_fault() with zeroed
>> 'exception'. This happen when e.g. VMXON/VMPTRLD/VMCLEAR argument is MMIO.
>> 
>> KVM could've handled the request correctly by going to userspace and
>> performing I/O but there doesn't seem to be a good need for such requests
>> in the first place. Sane guests should not call VMXON/VMPTRLD/VMCLEAR with
>> anything but normal memory. Just inject #GP to find insane ones.
>> 
>> Reported-by: syzbot+2a7156e11dc199bdbd8a@syzkaller.appspotmail.com
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/vmx/nested.c | 19 +++++++++++++++++--
>>  1 file changed, 17 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
>> index 9c74a732b08d..05d57c3cb1ce 100644
>> --- a/arch/x86/kvm/vmx/nested.c
>> +++ b/arch/x86/kvm/vmx/nested.c
>> @@ -4628,14 +4628,29 @@ static int nested_vmx_get_vmptr(struct kvm_vcpu *vcpu, gpa_t *vmpointer)
>>  {
>>  	gva_t gva;
>>  	struct x86_exception e;
>> +	int r;
>>  
>>  	if (get_vmx_mem_address(vcpu, vmx_get_exit_qual(vcpu),
>>  				vmcs_read32(VMX_INSTRUCTION_INFO), false,
>>  				sizeof(*vmpointer), &gva))
>>  		return 1;
>>  
>> -	if (kvm_read_guest_virt(vcpu, gva, vmpointer, sizeof(*vmpointer), &e)) {
>> -		kvm_inject_emulated_page_fault(vcpu, &e);
>> +	r = kvm_read_guest_virt(vcpu, gva, vmpointer, sizeof(*vmpointer), &e);
>> +	if (r != X86EMUL_CONTINUE) {
>> +		if (r == X86EMUL_PROPAGATE_FAULT) {
>> +			kvm_inject_emulated_page_fault(vcpu, &e);
>> +		} else {
>> +			/*
>> +			 * X86EMUL_IO_NEEDED is returned when kvm_vcpu_read_guest_page()
>> +			 * fails to read guest's memory (e.g. when 'gva' points to MMIO
>> +			 * space). While KVM could've handled the request correctly by
>> +			 * exiting to userspace and performing I/O, there doesn't seem
>> +			 * to be a real use-case behind such requests, just inject #GP
>> +			 * for now.
>> +			 */
>> +			kvm_inject_gp(vcpu, 0);
>> +		}
>> +
>>  		return 1;
>>  	}
>>  
>> 
>
> Hi Vitaly,
>
> looks good but we need to do the same in handle_vmread, handle_vmwrite,
> handle_invept and handle_invvpid.  Which probably means adding something
> like nested_inject_emulation_fault to commonize the inner "if".
>

Oh true, I've only looked at nested_vmx_get_vmptr() users to fix the
immediate issue. Will do v2.

-- 
Vitaly

