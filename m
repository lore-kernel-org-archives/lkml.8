Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53900C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C89B2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2QZyPBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgEFUHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 16:07:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47903 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725966AbgEFUHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 16:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588795641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nr2XB0SiZijHY6nfXs3OR3ar7uF0bSSBLwC2t+otSlI=;
        b=C2QZyPBeZe6DVkNIG61auBbm3WacrbF7mVaXDIaMWZI7gClIeTWLb11BtSpLOFDpS6IggW
        2wlxM/Y6cEvU5hzrxguzYfvbDIvLcWMjSeXFfLud2G5i8uEIDV8fx/qxVRvyIvd0ICXOdg
        pRw7/7FbkCcbwp+CLK2znmW7pby40es=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-ti_MRp_KOo2Mk-c4dpOZVw-1; Wed, 06 May 2020 16:07:19 -0400
X-MC-Unique: ti_MRp_KOo2Mk-c4dpOZVw-1
Received: by mail-wr1-f70.google.com with SMTP id 30so1871015wrp.22
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 13:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nr2XB0SiZijHY6nfXs3OR3ar7uF0bSSBLwC2t+otSlI=;
        b=bd3nzjTO2InuDKLLGWcjetI/Jr9/DwEwHF/zxnciEBb8HXFEfZJTNycLNO6pzBFhGH
         gAMX1VkGAVgmEUtPoZ0uWyRKf1iAG0odiPxUC9E8HHoqazcTQF7HQC05YZ7y+teqJJjA
         rlvTLYdDyid4Nf+6v+Kzp+95ap2xfZ6ZW4Hn9zL9P0gLk4INU+lvTiIjfRvt7A8HeMzA
         zBWYRSGsKyRtNk9ETkwp6K3NcbeHZuyyfoYHljaIx4zwqq+RnVkXyq2Zw3f2Dg+tvjtU
         T+UilZFE0es63X1Qd03UZ2H+O4ehItOIyIDfqkrHuW33ePqqYMerb+iAFsIao2WQ/bKf
         K24g==
X-Gm-Message-State: AGi0PuZ1xZquYdPxHGvSgr8HFXYtTpETKEqbvRlMxFz/W03KKeEiy7FA
        AaDQ6Y3n84VjEUygSZE+QQ0Otlhri+yJqE08MC4jE6J6M6F2mvtFTq5PjYVHxEAKyBInIbgfzvl
        EMsfQ+gCk6e2zhAvguIsp5xTj
X-Received: by 2002:adf:a118:: with SMTP id o24mr10790497wro.330.1588795638258;
        Wed, 06 May 2020 13:07:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypI1QhkL/CkiekHxjEdCPMNrWs8KQjzSl9IDIA1IuPBMTiLzuwT4e/4T4P7nwRcfbaE9f3Cp8g==
X-Received: by 2002:adf:a118:: with SMTP id o24mr10790464wro.330.1588795637918;
        Wed, 06 May 2020 13:07:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:11d7:2f21:f38b:17e? ([2001:b07:6468:f312:11d7:2f21:f38b:17e])
        by smtp.gmail.com with ESMTPSA id w10sm4498960wrg.52.2020.05.06.13.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 13:07:17 -0700 (PDT)
Subject: Re: [PATCH 8/9] KVM: x86, SVM: do not clobber guest DR6 on
 KVM_EXIT_DEBUG
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20200506111034.11756-1-pbonzini@redhat.com>
 <20200506111034.11756-9-pbonzini@redhat.com> <20200506181515.GR6299@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8f7f319c-4093-0ddc-f9f5-002c41d5622c@redhat.com>
Date:   Wed, 6 May 2020 22:07:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200506181515.GR6299@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/20 20:15, Peter Xu wrote:
> On Wed, May 06, 2020 at 07:10:33AM -0400, Paolo Bonzini wrote:
>> On Intel, #DB exceptions transmit the DR6 value via the exit qualification
>> field of the VMCS, and the exit qualification only contains the description
>> of the precise event that caused a vmexit.
>>
>> On AMD, instead the DR6 field of the VMCB is filled in as if the #DB exception
>> was to be injected into the guest.  This has two effects when guest debugging
>> is in use:
>>
>> * the guest DR6 is clobbered
>>
>> * the kvm_run->debug.arch.dr6 field can accumulate more debug events, rather
>> than just the last one that happened.
>>
>> Fortunately, if guest debugging is in use we debug register reads and writes
>> are always intercepted.  Now that the guest DR6 is always synchronized with
>> vcpu->arch.dr6, we can just run the guest with an all-zero DR6 while guest
>> debugging is enabled, and restore the guest value when it is disabled.  This
>> fixes both problems.
>>
>> A testcase for the second issue is added in the next patch.
> 
> Is there supposed to be another test after this one, or the GD test?

It's the GD test.
>> +		/* This restores DR6 to all zeros.  */
>> +		kvm_update_dr6(vcpu);
> 
> I feel like it won't work as expected for KVM_GUESTDBG_SINGLESTEP, because at
> [2] below it'll go to the "else" instead so dr6 seems won't be cleared in that
> case.

You're right, I need to cover both cases that trigger #DB.

> Another concern I have is that, I mostly read kvm_update_dr6() as "apply the
> dr6 memory cache --> VMCB".  I'm worried this might confuse people (at least I
> used quite a few minutes to digest...) here because latest data should already
> be in the VMCB.

No, the latest guest register is always in vcpu->arch.dr6.  It's only
because of KVM_DEBUGREG_WONT_EXIT that kvm_update_dr6() needs to pass
vcpu->arch.dr6 to kvm_x86_ops.set_dr6.  Actually this patch could even
check KVM_DEBUGREG_WONT_EXIT instead of vcpu->guest_debug.  I'll take a
look tomorrow.

> Also, IMHO it would be fine to have invalid dr6 values during
> KVM_SET_GUEST_DEBUG.  I'm not sure whether my understanding is correct, but I
> see KVM_SET_GUEST_DEBUG needs to override the in-guest debug completely.

Sort of, userspace can try to juggle host and guest debugging (this is
why you have KVM_GUESTDBG_INJECT_DB and KVM_GUESTDBG_INJECT_BP).

> If we worry about dr6 being incorrect after KVM_SET_GUEST_DEBUG is disabled,
> IMHO we can reset dr6 in kvm_arch_vcpu_ioctl_set_guest_debug() properly before
> we return the debug registers to the guest.
> 
> PS. I cannot see above lines [1] in my local tree (which seems to be really a
> bugfix...).  I tried to use kvm/queue just in case I missed some patches, but I
> still didn't see them.  So am I reading the wrong tree here?

The patch is based on kvm/master, and indeed that line is from a bugfix
that I've posted yesterday ("KVM: SVM: fill in
kvm_run->debug.arch.dr[67]"). I had pushed that one right away, because
it was quite obviously suitable for 5.7.

Paolo

