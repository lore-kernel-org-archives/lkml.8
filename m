Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2197C35250
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 16:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DC421775
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 16:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFIyJ6ot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgBGQQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 11:16:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20678 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726951AbgBGQQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 11:16:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581092171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8UGF+us/QjNLtxAbCjqUfORhSYgR+W+cBk4g3xSP3Ts=;
        b=MFIyJ6otuWWy1gvtj17nsbhOrZmacYjrjm11N4hK4rn7CMm4kkdHgGbRvjC18r1ySx+rmj
        SIEwmh1bnc3U0r1HwoMcIDZCDfqxxoXTGZ3pn/kZGKwM+v2xrXBsNDXssIPQQFW7vHhD9V
        kAwA8M4wvQc40hJPQfTWz6nUmXzntl0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-zTsB_fptNf6nKI3a_CTUGg-1; Fri, 07 Feb 2020 11:15:52 -0500
X-MC-Unique: zTsB_fptNf6nKI3a_CTUGg-1
Received: by mail-wr1-f70.google.com with SMTP id o6so1497004wrp.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 08:15:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=8UGF+us/QjNLtxAbCjqUfORhSYgR+W+cBk4g3xSP3Ts=;
        b=peLXUO9PbIPxv31pRJ9maqZ/LDJgcovAKcyKJIjdhCqK54+RCbUQZbZCIdlqK8gQBF
         ffhunzs+bFW8HVd8K7sYL/BZf71SMqV4NlvAGJFgty7fVkljWzzNABWGLTHh6BeiCPlg
         Wim4oaVmHkDP9Sh9eX6HanVPu+/pYIdJunKOYTBufGonrmpWycFkJVKk/yaWwsZxwkG6
         WljaDVREVnINpHENuRujDKqbEHCItBsW7XD+/5CGMTf8qBYAEP1C4HFAdBoIrpYlDDRC
         pGpQtiYbmlySapVQWMIPFZMSq5P3saxgWD//CVCYUNB0Xd1L3XXDFE5cMsm1A2F6Qj8m
         rhRA==
X-Gm-Message-State: APjAAAVHa1DaRBORYnv52qMRqbJXBYnrLUufAyrx5IAOaUljLqa3xPWQ
        qATXA5ibeGKyy1qG/jNMF7/Si7dKBg8nm0hNv8JsiM7gTT7/7+9fkwR7chY6I09s0100oypvCec
        s6m5rxD4ZaSHL20qEKesO9gvK
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr5747589wru.220.1581092150864;
        Fri, 07 Feb 2020 08:15:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqzuMrUSlAHFFtOdliasJ2FbsSMODN3UyfYDYi/Y+DGrbA18SO09VGYXIKn9XxznvVzUjfgG7A==
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr5747573wru.220.1581092150650;
        Fri, 07 Feb 2020 08:15:50 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i4sm3820758wmd.23.2020.02.07.08.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 08:15:50 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: x86/mmu: Avoid retpoline on ->page_fault() with TDP
In-Reply-To: <20200207155539.GC2401@linux.intel.com>
References: <20200206221434.23790-1-sean.j.christopherson@intel.com> <878sleg2z7.fsf@vitty.brq.redhat.com> <20200207155539.GC2401@linux.intel.com>
Date:   Fri, 07 Feb 2020 17:15:49 +0100
Message-ID: <8736bmqsp6.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Fri, Feb 07, 2020 at 10:29:16AM +0100, Vitaly Kuznetsov wrote:
>> Sean Christopherson <sean.j.christopherson@intel.com> writes:
>> 
>> > Wrap calls to ->page_fault() with a small shim to directly invoke the
>> > TDP fault handler when the kernel is using retpolines and TDP is being
>> > used.  Denote the TDP fault handler by nullifying mmu->page_fault, and
>> > annotate the TDP path as likely to coerce the compiler into preferring
>> > the TDP path.
>> >
>> > Rename tdp_page_fault() to kvm_tdp_page_fault() as it's exposed outside
>> > of mmu.c to allow inlining the shim.
>> >
>> > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> > ---
>> 
>> Out of pure curiosity, if we do something like
>> 
>> if (vcpu->arch.mmu->page_fault == tdp_page_fault)
>>     tdp_page_fault(...)
>> else if (vcpu->arch.mmu->page_fault == nonpaging_page_fault)
>>    nonpaging_page_fault(...)
>> ...
>> 
>> we also defeat the retpoline, right?
>
> Yep.
>
>> Should we use this technique ... everywhere? :-)
>
> It becomes a matter of weighing the maintenance cost and robustness against
> the performance benefits.  For the TDP case, amost no one (that cares about
> performance) uses shadow paging, the change is very explicit, tiny and
> isolated, and TDP page fault are a hot path, e.g. when booting the VM.
> I.e. low maintenance overhead, still robust, and IMO worth the shenanigans.
>
> The changes to VMX's VM-Exit handlers follow similar thinking: snipe off
> the exit handlers that are performance critical, but use a low maintenance
> implementation for the majority of handlers.
>
> There have been multiple attempts to add infrastructure to solve the
> maintenance and robustness problems[*], but AFAIK none of them have made
> their way upstream.
>
> [*] https://lwn.net/Articles/774743/
>

Oh I see, missed some of these discussion.

And I actualy forgot to say:

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

as the patch itself looks good to me, I was just wondering about the
approach in general.

-- 
Vitaly

