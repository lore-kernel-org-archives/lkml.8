Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AEBC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59B55206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tb5qYIWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgDVIiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 04:38:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23011 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726002AbgDVIip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 04:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587544724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sNTOJ4DOMqRb7+wXEID+nQDjGuphmZGJ3HThxBu7IL0=;
        b=Tb5qYIWXL715Ut5stx/b+SgjOVApXYvF1VLK48sZOIryWZ7jxEo1R/2b/nT3CgmXkN3TL8
        Ow7wq6aKRJ8lfTG7EBlI4hDbSCa/SZ3OhLUKEPCyb04YDJ1PlBs7XB32tVGMfh7hqJVct+
        Sv3MH9sTGVnw5AWEhn1PV45D9jLmeAE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-VCiZGM4uPjyuncomMSYw1w-1; Wed, 22 Apr 2020 04:38:42 -0400
X-MC-Unique: VCiZGM4uPjyuncomMSYw1w-1
Received: by mail-wm1-f69.google.com with SMTP id v185so516076wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 01:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sNTOJ4DOMqRb7+wXEID+nQDjGuphmZGJ3HThxBu7IL0=;
        b=Ld4oo7E4/rKpAV72ziaj147a4H2EC6aQciZZZ1pGpWbi+7AmTEOMrVOZ4nVYzRVKzl
         GEk2oOzQHkKv4S7a0Kdnn0xVyom8+6a4VzIRpsIG9gqAMTPYYTS6gbq4bmVGWjn962Lo
         6Fnx+7pjyuR0AstAcHdNiOWTR4SfV1WMPObd3kejHf+gb56WY2sziVw6t0exWD29m6yr
         lrDLEZc0AB6PmcUAfqss32ZfmW9HtMxuagXTQWRFX3FFGA0npzbs34JDXAcLizaC9prS
         MhA9kmWBMy2KluSRDJ/+/MNX9hpyyDO8ebjRgZjC8dtWQZEMpE81RqjBHbKjdr+q3c54
         yt2w==
X-Gm-Message-State: AGi0PuZ/u0JZENIQMr7IFgetJcyvApB+YvEEkT0P3LWTydhPjBWxIaeU
        xO/tiz+Tpx0y23+lXXpbABimQP0G1tTXGFQO5E4NtSBoJpqmXGyHodhkC68EZycm/sSauuOnPNZ
        YTAutFoG4H4rwfVcIOY4za6On
X-Received: by 2002:a7b:cbc6:: with SMTP id n6mr9898910wmi.155.1587544721447;
        Wed, 22 Apr 2020 01:38:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypKIAK7PHX7yxQV9nvW/3uOnuY71DYi++4LYtknbUhl3x9F6y+H9cop2sa4girLIMLzLO6u82A==
X-Received: by 2002:a7b:cbc6:: with SMTP id n6mr9898897wmi.155.1587544721232;
        Wed, 22 Apr 2020 01:38:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f43b:97b2:4c89:7446? ([2001:b07:6468:f312:f43b:97b2:4c89:7446])
        by smtp.gmail.com with ESMTPSA id a24sm6542275wmb.24.2020.04.22.01.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 01:38:40 -0700 (PDT)
Subject: Re: [PATCH 1/2] KVM: X86: TSCDEADLINE MSR emulation fastpath
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Haiwei Li <lihaiwei@tencent.com>
References: <1587468026-15753-1-git-send-email-wanpengli@tencent.com>
 <1587468026-15753-2-git-send-email-wanpengli@tencent.com>
 <ed968729-5d2a-a318-1d8f-db39e6ee72cb@redhat.com>
 <CANRm+CxzROx=eawemmzh==2Mz-DxKSyYFSxHqLxUiGFFnWkAYw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d87e0a4b-608a-451b-e3f0-968d46b6cc26@redhat.com>
Date:   Wed, 22 Apr 2020 10:38:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CANRm+CxzROx=eawemmzh==2Mz-DxKSyYFSxHqLxUiGFFnWkAYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/20 02:48, Wanpeng Li wrote:
> On Tue, 21 Apr 2020 at 19:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 21/04/20 13:20, Wanpeng Li wrote:
>>> +     case MSR_IA32_TSCDEADLINE:
>>> +             if (!kvm_x86_ops.event_needs_reinjection(vcpu)) {
>>> +                     data = kvm_read_edx_eax(vcpu);
>>> +                     if (!handle_fastpath_set_tscdeadline(vcpu, data))
>>> +                             ret = EXIT_FASTPATH_CONT_RUN;
>>> +             }
>>>               break;
>> Can you explain the event_needs_reinjection case?  Also, does this break
> This is used to catch the case vmexit occurred while another event was
> being delivered to guest software, I move the
> vmx_exit_handlers_fastpath() call after vmx_complete_interrupts()
> which will decode such event and make kvm_event_needs_reinjection
> return true.

This doesn't need a callback, kvm_event_needs_reinjection should be enough.

You should also check other conditions such as

	vcpu->mode == EXITING_GUEST_MODE || kvm_request_pending(vcpu)
            || need_resched() || signal_pending(current)

before doing CONT_RUN.

>> AMD which does not implement the callback?
> Now I add the tscdeadline msr emulation and vmx-preemption timer
> fastpath pair for Intel platform.

But this would cause a crash if you run on AMD.

Paolo

