Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E6EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9BF020738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnjMgpis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbgFDQn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:43:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33811 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729859AbgFDQn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591289005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b43y7oBLYY4aNesbrL9YUempKco+Tvij6pj28X/0Ggg=;
        b=TnjMgpisVQA4FaxjiX5s/YiGin5n4Sr2PI5IZza38bT8r4pErS2n//M+UPpaGjaTx+3aa8
        kmB2ch7HzJ70N99/C88ngZvF0CWOnPM2/ufqHuyW4zI1yWp5HHgg4ls/Ax2TWJhrA1u/9i
        DU5valMLduA706Tj9HenZz9DztlftvE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-F7AGwcOaMnq7V_MSmYm1uw-1; Thu, 04 Jun 2020 12:43:24 -0400
X-MC-Unique: F7AGwcOaMnq7V_MSmYm1uw-1
Received: by mail-ed1-f71.google.com with SMTP id y4so2888435edo.16
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 09:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=b43y7oBLYY4aNesbrL9YUempKco+Tvij6pj28X/0Ggg=;
        b=NtVTy4o59rrVM0n2sUsgpDQLrXxW2Oq7u15FB9IwYhs+l0q9tta9LGgWkgVAqQF7SY
         CFqD4n8PNqimxbbqIYNznTPShLoAr9x+Lz/uuSNrd84H1eGx4xKtfuL1sRZmwsvailHV
         GI9CUAN3m512Tdj4nxUbyjWOXZzKqBJhOPSHpvFjB/3wNrneWwuDj5C3hNFPi9GHA10j
         tsnTmuvzaTuOpCRclfUjI3V7+4iYVANpLNV4jMmx7g19MXnChO+h6cqXmz86g4ytyD68
         ghzEajWZF/CxMQxp7Ea9s5okS8hXA+03d8yFnH1i7HnW+eeTOGCLUTZ4pIp8qMcRC+rT
         1Rcw==
X-Gm-Message-State: AOAM531+wmQ4v0fsSVxdzraPvTnVPshJXUXnAlj6UxlsGjDgLNd6UlDq
        7QxO11D4nUIyW0VqDNs/6A6BxJs3IN4sDXDoExwlAn0xrJuW6LkXABY+O8QRDl9qJFwIUTBEPFf
        rx8zhIadKM3TmlDQGfzgeW9zg
X-Received: by 2002:a17:906:2f8d:: with SMTP id w13mr4892305eji.102.1591289002658;
        Thu, 04 Jun 2020 09:43:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPnkn9qZ3C4tEYb3JPcW9SIz73nKr8uZwFQF/sN4ea+5RpiF1LAJWzu/jMThhlIZyslufZDw==
X-Received: by 2002:a17:906:2f8d:: with SMTP id w13mr4892290eji.102.1591289002373;
        Thu, 04 Jun 2020 09:43:22 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id v24sm2550044ejf.20.2020.06.04.09.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 09:43:21 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: nVMX: Inject #GP when nested_vmx_get_vmptr() fails to read guest memory
In-Reply-To: <20200604160253.GF30223@linux.intel.com>
References: <20200604143158.484651-1-vkuznets@redhat.com> <da7acd6f-204d-70e2-52aa-915a4d9163ef@redhat.com> <20200604145357.GA30223@linux.intel.com> <87k10meth6.fsf@vitty.brq.redhat.com> <20200604160253.GF30223@linux.intel.com>
Date:   Thu, 04 Jun 2020 18:43:19 +0200
Message-ID: <87h7vqeq8o.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Thu, Jun 04, 2020 at 05:33:25PM +0200, Vitaly Kuznetsov wrote:
>> Sean Christopherson <sean.j.christopherson@intel.com> writes:
>> 
>> > On Thu, Jun 04, 2020 at 04:40:52PM +0200, Paolo Bonzini wrote:
>> >> On 04/06/20 16:31, Vitaly Kuznetsov wrote:
>> >
>> > ...
>> >
>> >> > KVM could've handled the request correctly by going to userspace and
>> >> > performing I/O but there doesn't seem to be a good need for such requests
>> >> > in the first place. Sane guests should not call VMXON/VMPTRLD/VMCLEAR with
>> >> > anything but normal memory. Just inject #GP to find insane ones.
>> >> > 
>> 
>> ...
>> 
>> >> 
>> >> looks good but we need to do the same in handle_vmread, handle_vmwrite,
>> >> handle_invept and handle_invvpid.  Which probably means adding something
>> >> like nested_inject_emulation_fault to commonize the inner "if".
>> >
>> > Can we just kill the guest already instead of throwing more hacks at this
>> > and hoping something sticks?  We already have one in
>> > kvm_write_guest_virt_system...
>> >
>> >   commit 541ab2aeb28251bf7135c7961f3a6080eebcc705
>> >   Author: Fuqian Huang <huangfq.daxian@gmail.com>
>> >   Date:   Thu Sep 12 12:18:17 2019 +0800
>> >
>> >     KVM: x86: work around leak of uninitialized stack contents
>> >
>> 
>> Oh I see...
>> 
>> [...]
>> 
>> Let's get back to 'vm_bugged' idea then? 
>> 
>> https://lore.kernel.org/kvm/87muadnn1t.fsf@vitty.brq.redhat.com/
>
> Hmm, I don't think we need to go that far.  The 'vm_bugged' idea was more
> to handle cases where KVM itself (or hardware) screwed something up and
> detects an issue deep in a call stack with no recourse for reporting the
> error up the stack.
>
> That isn't the case here.  Unless I'm mistaken, the end result is simliar
> to this patch, except that KVM would exit to userspace with
> KVM_INTERNAL_ERROR_EMULATION instead of injecting a #GP.  E.g.

I just wanted to resurrect that 'vm_bugged' idea but was waiting for a
good opportunity :-)

The advantage of KVM_EXIT_INTERNAL_ERROR is that we're not trying to
invent some behavior which is not in SDM and making it a bit more likely
that we get a bug report from an angry user.

>
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 9c74a732b08d..e13d2c0014e2 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -4624,6 +4624,20 @@ void nested_vmx_pmu_entry_exit_ctls_update(struct kvm_vcpu *vcpu)
>         }
>  }
>
> +static int nested_vmx_handle_memory_failure(struct kvm_vcpu *vcpu, int ret,
> +                                           struct x86_exception *e)
> +{
> +       if (r == X86EMUL_PROPAGATE_FAULT) {
> +               kvm_inject_emulated_page_fault(vcpu, &e);
> +               return 1;
> +       }
> +
> +       vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
> +       vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
> +       vcpu->run->internal.ndata = 0;
> +       return 0;
> +}
> +
>  static int nested_vmx_get_vmptr(struct kvm_vcpu *vcpu, gpa_t *vmpointer)
>  {
>         gva_t gva;
> @@ -4634,11 +4648,9 @@ static int nested_vmx_get_vmptr(struct kvm_vcpu *vcpu, gpa_t *vmpointer)
>                                 sizeof(*vmpointer), &gva))
>                 return 1;
>
> -       if (kvm_read_guest_virt(vcpu, gva, vmpointer, sizeof(*vmpointer), &e)) {
> -               kvm_inject_emulated_page_fault(vcpu, &e);
> -               return 1;
> -       }
> -
> +       r kvm_read_guest_virt(vcpu, gva, vmpointer, sizeof(*vmpointer), &e);
> +       if (r)
> +               return nested_vmx_handle_memory_failure(r, &e);
>         return 0;
>  }
>

... and the same for handle_vmread, handle_vmwrite, handle_invept and
handle_invvpid as suggested by Paolo. I'll be sending this as v2 with
your Suggested-by: shortly.

>
>
> Side topic, I have some preliminary patches for the 'vm_bugged' idea.  I'll
> try to whip them into something that can be posted upstream in the next few
> weeks.
>

Sounds great!

-- 
Vitaly

