Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0905C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB452071A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxHPoLdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbgE0RAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:00:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26763 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726978AbgE0RAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590598818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=19uN5uVqFPxYVimAYdibOEMC+SZq9IjB04cBBr/Z/FE=;
        b=cxHPoLdTFMe3NpkJn57fS+25dIDbQyx28cc3oD281IAzxq9+hQ82FuywR9CIJoIYk+awHY
        IWdhQZr+YmWL0nmjtDYNjxaDBZj0ZSETx8MAcKOpe04tvR+nso+r4QcefEgBGOlABgO5/S
        6V1uBcb6ToSas1MuEybonPqLXWp2lhk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-mhF3x3onNjStjY1L9b5eXQ-1; Wed, 27 May 2020 13:00:16 -0400
X-MC-Unique: mhF3x3onNjStjY1L9b5eXQ-1
Received: by mail-wm1-f69.google.com with SMTP id x11so10679wmc.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=19uN5uVqFPxYVimAYdibOEMC+SZq9IjB04cBBr/Z/FE=;
        b=hLpgeEwv4DMPH5AeQxrr/+wpv3bF3I1jy4LzcjRHb4P0mN2bB/KM3o2L2n3hl5PRDf
         KerkYnBOjhXxI3hPwvBxVyxYP9Os84uTgPFn4jK+aWS14MaLVc/zlLf0cR4PrpvqkwTg
         mK7aLCypD7pAv2fu4C63rX8dq6iqHGjI5LVWMa9NnBvuTTOw4SVn80Z3U8u9YHVO1kx2
         WlGwnMvGVSzoT67yMdTWj8xPNa5NneY4PBV3Z8EBtTibfOaXbpk2iaVPHlWg5TUBN+w6
         oUvEGqdT2PImFx5C5941DVYFwpJP1Qp4Bf93ZFvOA46rdpf6Ztxbr+VMfuHAor7rMFy4
         JrGA==
X-Gm-Message-State: AOAM533WUXkJlaJIB+/sK2otIgYW8Yrel8BgU87idFHP8U1bkuQy8J+G
        FUaBn8JgQ9UKZDfUTfix6uOS4Ij2I9C9nHiET/pNTHeMf014ZGTIIz95BjglyXtloGMLn7P7lPY
        BHeSmEj0lyvFcPJIXdX1niFjx
X-Received: by 2002:adf:feca:: with SMTP id q10mr18966774wrs.380.1590598815696;
        Wed, 27 May 2020 10:00:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZsMcWkS3QYq92JA1gLacyexyY9OQ9Klpg3SI6agBShM60ySQO59nAhfrwJJyiTsfoOy/rdw==
X-Received: by 2002:adf:feca:: with SMTP id q10mr18966738wrs.380.1590598815463;
        Wed, 27 May 2020 10:00:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id h15sm3219876wrt.73.2020.05.27.10.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 10:00:14 -0700 (PDT)
Subject: Re: [PATCH 0/2] Fix issue with not starting nesting guests on my
 system
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Tao Xu <tao3.xu@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jingqi Liu <jingqi.liu@intel.com>
References: <20200523161455.3940-1-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c12376a8-fc98-5785-e4b6-5c682afd3cd6@redhat.com>
Date:   Wed, 27 May 2020 19:00:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200523161455.3940-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/20 18:14, Maxim Levitsky wrote:
> On my AMD machine I noticed that I can't start any nested guests,
> because nested KVM (everything from master git branches) complains
> that it can't find msr MSR_IA32_UMWAIT_CONTROL which my system doesn't support
> at all anyway.
> 
> I traced it to the recently added UMWAIT support to qemu and kvm.
> The kvm portion exposed the new MSR in KVM_GET_MSR_INDEX_LIST without
> checking that it the underlying feature is supported in CPUID.
> It happened to work when non nested because as a precation kvm,
> tries to read each MSR on host before adding it to that list,
> and when read gets a #GP it ignores it.
> 
> When running nested, the L1 hypervisor can be set to ignore unknown
> msr read/writes (I need this for some other guests), thus this safety
> check doesn't work anymore.
> 
> V2: * added a patch to setup correctly the X86_FEATURE_WAITPKG kvm capability
>     * dropped the cosmetic fix patch as it is now fixed in kvm/queue
> 
> Best regards,
> 	Maxim Levitsky
> 
> Maxim Levitsky (2):
>   kvm/x86/vmx: enable X86_FEATURE_WAITPKG in KVM capabilities
>   kvm/x86: don't expose MSR_IA32_UMWAIT_CONTROL unconditionally
> 
>  arch/x86/kvm/vmx/vmx.c | 3 +++
>  arch/x86/kvm/x86.c     | 4 ++++
>  2 files changed, 7 insertions(+)
> 

Queued for 5.7, thanks (with cosmetic touches to the commit message, and
moving the "case" earlier to avoid conflicts).

Paolo

