Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED552C8300D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA72C2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxVCouHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgD3Ldy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:33:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27310 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726511AbgD3Ldx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588246431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nYHjyQZB66u0Ewnyj3ClGluuIthhdPA1Z2vZ3odLsss=;
        b=RxVCouHGijFCONd0sGEZBSVY/EhgRnrOHjsQjL1Q2sprnC3L2j1fNNLmZ6G4DbVv5fTNrD
        cyhOg17+XXBe3nTLxDvSeeqJ85VgXugBr/HS0jMVjX3i56+dW6bXoJUdpHloYvdsarvUaJ
        IzGxAcCcEilYPjY8DzxOGU5rFpk6dto=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-y2yYGJomOyWXwIHw2eIuzA-1; Thu, 30 Apr 2020 07:33:49 -0400
X-MC-Unique: y2yYGJomOyWXwIHw2eIuzA-1
Received: by mail-wm1-f69.google.com with SMTP id n127so465776wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 04:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=nYHjyQZB66u0Ewnyj3ClGluuIthhdPA1Z2vZ3odLsss=;
        b=aP/cyndZlNSW0EU/e9GhEziNqv3IkxqD9vJI4YJTgzU4eiqf27tPNEXvdxgf4Of1oc
         NPspqsWmmVZW6xUws+rukjBXDyEQ/DKKxmj3CKAA/zxPMBG0BhKRLMtiVyDDd9LpSF8O
         TwQBydP0y9P9HkOqrxKNonxhiTcZtlb/YG9ghlZQwSRiNQjTUpWGgDbpCdTpIJC2rBbO
         MHJz2NansH6KDTOyVrAeAMsKeAqOtUGTS9MveSv8gLdD5GGY6Ff0IkytODoBpwWC8I0M
         X/BEm1bkmz4/zQ25+SrzdrNCko0KAbAQnHbhEH7Ys3BniJhvdKEn8t9adB7djTfdECyL
         E4TA==
X-Gm-Message-State: AGi0PuajyivBjGxzbsBTyE6lY/u2AU4h46J5U2fvLAjZvl5jkRS+zMzf
        6lszQcYVA+lkLuOSIZayyljEJObHvWkeXGKZABzLx3TMlhV8mzatZHKxrd1PZLSmLoDnKqR9fTv
        eHWCUJ7Tyk/ORj9DUfzK8aT+U
X-Received: by 2002:adf:f10c:: with SMTP id r12mr3433689wro.409.1588246428709;
        Thu, 30 Apr 2020 04:33:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypJoZaH2lPDWe0GJpyQePdThFimTFd28mPxMCRnVLbCUn/3Kpq62ADMYononpBhZV+7wN64Dbw==
X-Received: by 2002:adf:f10c:: with SMTP id r12mr3432706wro.409.1588246416469;
        Thu, 30 Apr 2020 04:33:36 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f2sm3762196wro.59.2020.04.30.04.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 04:33:35 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH RFC 4/6] KVM: x86: acknowledgment mechanism for async pf page ready notifications
In-Reply-To: <18b66e2e-9256-0ef0-4783-f89211eeda88@redhat.com>
References: <20200429093634.1514902-1-vkuznets@redhat.com> <20200429093634.1514902-5-vkuznets@redhat.com> <b1297936-cf69-227b-d758-c3f3ca09ae5d@redhat.com> <87sgglfjt9.fsf@vitty.brq.redhat.com> <18b66e2e-9256-0ef0-4783-f89211eeda88@redhat.com>
Date:   Thu, 30 Apr 2020 13:33:34 +0200
Message-ID: <87k11xfbsh.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 30/04/20 10:40, Vitaly Kuznetsov wrote:
>>>  I think in that case
>>> kvm_check_async_pf_completion will refuse to make progress.
>>> You need to make this bit stateful (e.g. 1 = async PF in progress, 0 =
>>> not in progress), and check that for page ready notifications instead of
>>> EFLAGS.IF.  
>>> This probably means that;
>>>
>>> - it might be simpler to move it to the vector MSR
>> I didn't want to merge 'ACK' with the vector MSR as it forces the guest
>> to remember the setting. It doesn't matter at all for Linux as we
>> hardcode the interrupt number but I can imaging an OS assigning IRQ
>> numbers dynamically, it'll need to keep record to avoid doing rdmsr.
>
> I would expect that it needs to keep it in a global variable anyway, but
> yes this is a good point.  You can also keep the ACK MSR and store the
> pending bit in the other MSR, kind of like you have separate ISR and EOI
> registers in the LAPIC.
>

Honestly I was inspired by Hyper-V's HV_X64_MSR_EOM MSR as the protocol
we're trying to come up with here is very similar to HV messaging)

I'm not exactly sure why we need the pending bit after we drop #PF. When
we call kvm_check_async_pf_completion() from MSR_KVM_ASYNC_PF_ACK write
it will (in case there are page ready events in the queue) check if the
slot is empty, put one there and raise IRQ regardless of guest's current
state. It may or may not get injected immediately but we don't care.
The second invocation of kvm_check_async_pf_completion() from vcpu_run()
will just go away.

I'm probably just missing something, will think of it again while
working on v1, it seems nobody is against the idea in general. Thanks!

-- 
Vitaly

