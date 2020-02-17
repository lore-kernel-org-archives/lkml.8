Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB7FC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 11:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68428207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 11:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gE+G+JlB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgBQLXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 06:23:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36583 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728572AbgBQLXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 06:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581938602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MzSShR7Baq3pMc/kBpgCJS277t/Xu5wsk9DwxCBu5Qs=;
        b=gE+G+JlB0xdu6FzNBGbC4AngtKZfMEQaiTvaLR3FC0EljGIF5/r54HrS87Z2IR46QIcgaF
        zOL5oIwNmoCAlDICC5HZtaFpWxI8/iPRELJ6MVsZ7fRglPOo1HLgcI4mQxRzZYrbImGnxp
        RD4gAGse5w9waflZDwbN9cMnSTqaP4E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-SXA9mesqOpafUisj1Yu9aA-1; Mon, 17 Feb 2020 06:23:20 -0500
X-MC-Unique: SXA9mesqOpafUisj1Yu9aA-1
Received: by mail-wr1-f72.google.com with SMTP id j4so8792295wrs.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 03:23:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MzSShR7Baq3pMc/kBpgCJS277t/Xu5wsk9DwxCBu5Qs=;
        b=sbkbCfSlpq+wwpkLmvJq9lc50HDD0zIczMQHJDjakHSwor75NvMGs4MxOP36VXcF86
         I208C5DCgqUgb74YtpLXyoOMvedMnzAwcvmw/Uk5qb/TMZF14mbsqXkLfFNhf5W8qaua
         AlbPGuSK3e2z1WS4l+Se9bExvAU/DYYnZSR5FA9bVR1Lx+2LTDeNWydZsXPO1CZKcTX1
         V/qv7x4nqTikIOaybgb4jDrrnox20TavTxMSADLSVFG3UFINiKZlK7yeFpJ7cGXu4x+0
         lWVn/7S+KRH97H5rNID4IDzR2L+jFSkCOzTGP4znw307EF/cJGVdlThtCCE5djrHVa0b
         PX3A==
X-Gm-Message-State: APjAAAWrDI/rm9T0Dj0oNIRl9mMudjZymi64BVp2bwVgp3zCUR2oIqLl
        PCit1CvQgTPWUoO/OJ+ab932aM79Wg4Gbl+XBf5LUKFNm6FlpyHAs3e23aB7s7BNEqBtI0iglo1
        mtVM374xgejA4W+VAlhugXMja
X-Received: by 2002:a1c:e388:: with SMTP id a130mr21631729wmh.176.1581938598880;
        Mon, 17 Feb 2020 03:23:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqxRwSyzU0Sqecaad9VwaOksR0eo61oSfyaLYDxhxuBCi+8SmZweE1jjTzMmyVXDqR/8yH9N7Q==
X-Received: by 2002:a1c:e388:: with SMTP id a130mr21631707wmh.176.1581938598568;
        Mon, 17 Feb 2020 03:23:18 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4? ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
        by smtp.gmail.com with ESMTPSA id i16sm213867wmb.36.2020.02.17.03.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2020 03:23:18 -0800 (PST)
Subject: Re: [PATCH v3 1/2] KVM: X86: Less kvmclock sync induced vmexits after
 VM boots
To:     Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <CANRm+Cz6Es1TLFdGxz_65i-4osE6=67J=noqWC6n09TeXSJ5SA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8fd7a83a-6fde-652f-0a2e-ec7b90c13616@redhat.com>
Date:   Mon, 17 Feb 2020 12:23:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CANRm+Cz6Es1TLFdGxz_65i-4osE6=67J=noqWC6n09TeXSJ5SA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/20 11:36, Wanpeng Li wrote:
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index fb5d64e..d0ba2d4 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9390,8 +9390,9 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>      if (!kvmclock_periodic_sync)
>          return;
> 
> -    schedule_delayed_work(&kvm->arch.kvmclock_sync_work,
> -                    KVMCLOCK_SYNC_PERIOD);
> +    if (kvm->created_vcpus == 1)
> +        schedule_delayed_work(&kvm->arch.kvmclock_sync_work,
> +                        KVMCLOCK_SYNC_PERIOD);

This is called with kvm->lock not held, so you can have
kvm->created_vcpus == 2 by the time you get here.  You can test instead
"if (vcpu->vcpu_idx == 0)".

Thanks,

Paolo

