Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4347DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD8E206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftMqAWN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgGUN7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:59:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45827 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726359AbgGUN7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 09:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595339951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1XSRxOKWh2EaVf4Y8gn83C3uqoFTDUh2rGXBPh4SjUw=;
        b=ftMqAWN9K0hEp8KUDhZXRE3OtwnKucOdUjc6Pl5x3e6fCJNUPksBUph0c8Nnemz67BJH/N
        M0oM7CnbE6ETlFqhKrhLvlG6vY0kk/O5R3uXYBOG+YNDxB4sW+jnTTw97YPUobRxdnTH0l
        mUVIv2Jl2T0E1eiziWyByV9ou1BBW8I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-QoFtDvEwO_2MPI81Uf_aFw-1; Tue, 21 Jul 2020 09:59:09 -0400
X-MC-Unique: QoFtDvEwO_2MPI81Uf_aFw-1
Received: by mail-wr1-f71.google.com with SMTP id s16so13065855wrv.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 06:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=1XSRxOKWh2EaVf4Y8gn83C3uqoFTDUh2rGXBPh4SjUw=;
        b=AIQQk2QrhdB9O1ztGEl98G/luEFW51sT2L5kSFUWiPK7SNUkuhzqRoUDmabU9xlJ1U
         kuSTENCqRhmPDC8DcPBtjhetU8aQyNZZzPGqdap+ki138gXikQrcFtlCESCk9geSv3bM
         FcjbH7MwnAQ78fmJlShU8bsIqt9RiFkLwE5ms9RcQYTL6LDwMdKopOAtDgfoy4I2YLcf
         R6kkFEv3RWSyGbKVFGbFzq52qQt7nLONmnHMTlKc6Nn45AnK7Z4ejwxlKOBAonddD4n8
         InjNDpBmsyH+xFEiXBHZqaGy4rPV9nFmdAZSKZD9Rzw0Ulvm/x6OJ+GBWJjOE+0+mK/t
         kVCA==
X-Gm-Message-State: AOAM530R/HsyKbOnyNqEdfXDgVO57Xn4xrTNE6y5/XdeI/jfXlhKKZ+u
        fHn7RSB9lHVmuylDLpLmdqvFLKA03p2VEX/gHE1riKOtMkRnWCjsIYUjwslckMQKw1yxhqY2TGp
        cyKK3Qir8CCVUCde13hGPicKs
X-Received: by 2002:a7b:c14a:: with SMTP id z10mr4031827wmi.19.1595339948082;
        Tue, 21 Jul 2020 06:59:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyG2A4z6SCsD9epS9EdBWaiWCEjcl6nQH/beMuz+mPDsHK4PgHUf5QKKCHzrdN8fMpih4ZIbA==
X-Received: by 2002:a7b:c14a:: with SMTP id z10mr4031815wmi.19.1595339947844;
        Tue, 21 Jul 2020 06:59:07 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u84sm3634813wmg.7.2020.07.21.06.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 06:59:07 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6/7] KVM: x86: Use common definition for kvm_nested_vmexit tracepoint
In-Reply-To: <20200721002717.GC20375@linux.intel.com>
References: <20200718063854.16017-1-sean.j.christopherson@intel.com> <20200718063854.16017-7-sean.j.christopherson@intel.com> <87365mqgcg.fsf@vitty.brq.redhat.com> <20200721002717.GC20375@linux.intel.com>
Date:   Tue, 21 Jul 2020 15:59:06 +0200
Message-ID: <87imehotp1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Mon, Jul 20, 2020 at 06:52:15PM +0200, Vitaly Kuznetsov wrote:
>> Sean Christopherson <sean.j.christopherson@intel.com> writes:
>> > +TRACE_EVENT_KVM_EXIT(kvm_nested_vmexit);
>> >  
>> >  /*
>> >   * Tracepoint for #VMEXIT reinjected to the guest
>> > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
>> > index fc70644b916ca..f437d99f4db09 100644
>> > --- a/arch/x86/kvm/vmx/nested.c
>> > +++ b/arch/x86/kvm/vmx/nested.c
>> > @@ -5912,10 +5912,7 @@ bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu)
>> >  	exit_intr_info = vmx_get_intr_info(vcpu);
>> >  	exit_qual = vmx_get_exit_qual(vcpu);
>> >  
>> > -	trace_kvm_nested_vmexit(vcpu, exit_reason, exit_qual,
>> > -				vmx->idt_vectoring_info, exit_intr_info,
>> > -				vmcs_read32(VM_EXIT_INTR_ERROR_CODE),
>> > -				KVM_ISA_VMX);
>> > +	trace_kvm_nested_vmexit(exit_reason, vcpu, KVM_ISA_VMX);
>> >  
>> >  	/* If L0 (KVM) wants the exit, it trumps L1's desires. */
>> >  	if (nested_vmx_l0_wants_exit(vcpu, exit_reason))
>> 
>> With so many lines removed I'm almost in love with the patch! However,
>> when testing on SVM (unrelated?) my trace log looks a bit ugly:
>> 
>>            <...>-315119 [010]  3733.092646: kvm_nested_vmexit:    CAN'T FIND FIELD "rip"<CANT FIND FIELD exit_code>vcpu 0 reason npf rip 0x400433 info1 0x0000000200000006 info2 0x0000000000641000 intr_info 0x00000000 error_code 0x00000000
>>            <...>-315119 [010]  3733.092655: kvm_nested_vmexit:    CAN'T FIND FIELD "rip"<CANT FIND FIELD exit_code>vcpu 0 reason npf rip 0x400433 info1 0x0000000100000014 info2 0x0000000000400000 intr_info 0x00000000 error_code 0x00000000
>> 
>> ...
>> 
>> but after staring at this for some time I still don't see where this
>> comes from :-( ... but reverting this commit helps:
>
> The CAN'T FIND FIELD blurb comes from tools/lib/traceevent/event-parse.c.
>
> I assume you are using tooling of some form to generate the trace, i.e. the
> issue doesn't show up in /sys/kernel/debug/tracing/trace.  If that's the
> case, this is more or less ABI breakage :-(
>  

Right you are,

the tool is called 'trace-cmd record -e kvm ...' / 'trace-cmd report'
but I always thought it's not any different from looking at
/sys/kernel/debug/tracing/trace directly. Apparently I was wrong. 'cat
/sys/kernel/debug/tracing/trace' seems to be OK, e.g.:

 qemu-system-x86-20263 [006] .... 75982.292657: kvm_nested_vmexit: vcpu 0 reason hypercall rip 0x40122f info1 0x0000000000000000 info2 0x0000000000000000 intr_info 0x00000000 error_code 0x00000000

-- 
Vitaly

