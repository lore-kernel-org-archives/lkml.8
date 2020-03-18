Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC715C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7727E20768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBwATdF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbgCRKqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:46:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:34307 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbgCRKqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584528363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uWV0E8WuUvVzJXKHJaGqWfWFWL+nt8HkJYbvJBWmVJc=;
        b=PBwATdF4MK59cN+1G1SN9m6HPLO+0ZEZui7aTquC/TZO/WlFwSuWA1mDJytd0xAPjpPD9U
        v1aL5znN/wto8c6i1+tcmN2R8ck75oaoiXqp3a3Hi7ViBR4W+cepdrGc/hcrZzVtSVN1FP
        6yMfLaTRxCfr/iVd9Jhve40K8qLpya4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-S8mUhoQ-MISEzmu4GsUoIA-1; Wed, 18 Mar 2020 06:46:01 -0400
X-MC-Unique: S8mUhoQ-MISEzmu4GsUoIA-1
Received: by mail-wm1-f72.google.com with SMTP id n188so883011wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 03:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uWV0E8WuUvVzJXKHJaGqWfWFWL+nt8HkJYbvJBWmVJc=;
        b=sChlRT5yHeCbj4pO/8zX8Sib1RHdriTkyKFPW1xTQYVey6EFjHmWNS3WpeDF6akEWb
         nsphRmt05Gk8sTub+iuym01rzrE6R8qehfMDcjcPCgjCD71Tlx6YdaW6h75lDsJEFWtU
         DYN7lHxuCxmfumI+TQ2yaF1JgwtU87dz0mkGFT+OnXp/oh08cvP7G8ILesfG9OEyesUq
         F7rAokedhlOiQXyY3IsI/mcHmyInuhsXp2aY1WwU+uRsOk1bBqkN9VoEOQ3IU9UL8r1p
         RrjRFJNkMCcZpj3IuC7YZSRH86mjLkd2mYJ9O5i8x7Dlz/sHBCmigmMqb7VHFdSj6oNo
         +VQA==
X-Gm-Message-State: ANhLgQ2WVq3pgbZ/2A2VR5JuNTYZfCU3ovJgcHzGF6kbyBdi8xiZz3aD
        UNFo1HRBxJQuITbeGAkGhuvuFRmyIgFjCtoE/tt4cgRGnDf2+55snKvycwfrA0rPX85D9fJrsF7
        oaxLZZZtQhD9ARYgmO379GxhR
X-Received: by 2002:adf:f6c7:: with SMTP id y7mr5031696wrp.269.1584528360540;
        Wed, 18 Mar 2020 03:46:00 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtByzzSqhvGfuZQYMNsjB+hb5k3ChPobewTa8Fv1dmM79oMuF+sykpezUdGDurYfurj5qMzVA==
X-Received: by 2002:adf:f6c7:: with SMTP id y7mr5031667wrp.269.1584528360226;
        Wed, 18 Mar 2020 03:46:00 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
        by smtp.gmail.com with ESMTPSA id 7sm3376839wmf.20.2020.03.18.03.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 03:45:59 -0700 (PDT)
Subject: Re: [PATCH v2 23/32] KVM: nVMX: Add helper to handle TLB flushes on
 nested VM-Enter/VM-Exit
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20200317045238.30434-1-sean.j.christopherson@intel.com>
 <20200317045238.30434-24-sean.j.christopherson@intel.com>
 <0975d43f-42b6-74db-f916-b0995115d726@redhat.com>
 <20200317181832.GC12959@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f4850521-29fe-51ff-05e7-76cef1fa0fd9@redhat.com>
Date:   Wed, 18 Mar 2020 11:45:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317181832.GC12959@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/20 19:18, Sean Christopherson wrote:
> On Tue, Mar 17, 2020 at 06:17:59PM +0100, Paolo Bonzini wrote:
>> On 17/03/20 05:52, Sean Christopherson wrote:
>>> +	nested_vmx_transition_tlb_flush(vcpu, vmcs12);
>>> +
>>> +	/*
>>> +	 * There is no direct mapping between vpid02 and vpid12, vpid02 is
>>> +	 * per-vCPU and reused for all nested vCPUs.  If vpid12 is changing
>>> +	 * then the new "virtual" VPID will reuse the same "real" VPID,
>>> +	 * vpid02, and so needs to be sync'd.  Skip the sync if a TLB flush
>>> +	 * has already been requested, but always update the last used VPID.
>>> +	 */
>>> +	if (nested_cpu_has_vpid(vmcs12) && nested_has_guest_tlb_tag(vcpu) &&
>>> +	    vmcs12->virtual_processor_id != vmx->nested.last_vpid) {
>>> +		vmx->nested.last_vpid = vmcs12->virtual_processor_id;
>>> +		if (!kvm_test_request(KVM_REQ_TLB_FLUSH, vcpu))
>>> +			vpid_sync_context(nested_get_vpid02(vcpu));
>>>  	}
>>
>> Would it make sense to move nested_vmx_transition_tlb_flush into an
>> "else" branch?
> 
> Maybe?  I tried that at one point, but didn't like making the call to
> nested_vmx_transition_tlb_flush() conditional.  My intent is to have
> the ...tlb_flush() call be standalone, i.e. logic that is common to all
> nested transitions, so that someone can look at the code can easily
> (relatively speaking) understand the basic rules for TLB flushing on
> nested transitions.

I think it's clear from the above code that we're handling a TLB flush
in a way that doesn't require nested_vmx_transition_tlb_flush.  But
perhaps I didn't understand what you mean by "logic that is common to
all nested transitions" and why you named it
nested_vmx_transition_tlb_flush.

Perhaps nested_vmx_transition_tlb_flush could grow a vmentry/vmexit bool
argument instead?

> I also tried the oppositie, i.e. putting the above code in an else-branch,
> with nested_vmx_transition_tlb_flush() returning true if it requested a
> flush.  But that required updating vmx->nested.last_vpid in a separate
> flow, which was quite awkward.

No, that's awkward indeed.

Paolo

>> And should this also test that KVM_REQ_TLB_FLUSH_CURRENT is not set?
> 
> Doh, yes.
> 

