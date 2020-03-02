Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEF5C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0633724673
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bN5i+rDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgCBSWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:22:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23858 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726997AbgCBSWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583173332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ih5//RAv6LhCAV7ANNWMSlbgMbwpFxJEPQWnbvDX1pk=;
        b=bN5i+rDRRehkh6Ub9LLvs7GniUBaTvaMvyCIXVrfio8rZEHSNUGYEuyw34Hru5jmEOiejA
        y3RMBqcGnzNLf+vpX94ooMCflne/uh9idDqPW/RkKMMLRcaY9YzQrV0FhhXwJBa9vjl6Q8
        R70pDOHF6wgCm89qig/2WYtpRGgM/50=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-9mIcrl5qM7eNV5P_7daE8g-1; Mon, 02 Mar 2020 13:22:11 -0500
X-MC-Unique: 9mIcrl5qM7eNV5P_7daE8g-1
Received: by mail-wr1-f71.google.com with SMTP id j32so63848wre.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 10:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ih5//RAv6LhCAV7ANNWMSlbgMbwpFxJEPQWnbvDX1pk=;
        b=ZA9JWItULQ3z3epG5xZJk2/BxYUiShr1gGrCQZqMqgZCao8sfNEPRLXlU0S6KETXoQ
         f5icA+QkJOkH3naH3e8OPuU/A/trRaWlrlWJmvxzvxlnNgs2vgQQdLiKR+RIySKBBiIX
         0yKlmpmN4FnMDXDut7FOqbrxCTWkCPoEU1Jn1v77LuRSEi3tP3kKKaAl8NFq7UbDLZt0
         qaoldo6K/+YTvIeKMNTJimDKVMg3eZUTGrSOa46dGDx1sUCrLUnkvAG+FL1dMoCuGiqG
         FnR05VFy24TvNJn56+IKA4kXtyQeq8zMvOrZ65AIJz8PlEkuSMYLBO1mO7ABotXP1mFw
         WjgA==
X-Gm-Message-State: ANhLgQ05m8DpiFO7uLF/lkM7ZVfuAm2HrOVk0MzJWDlhE1NFx2oJT/5T
        lfZFrgzfAmEwI5MeLnu7/CZa0/RjWjHi2s0c9AjZflCYU+u/afAil1rgf4DRNxg52q+fk5xFd1B
        Tb2u/o+beo9ttsn9Gfq9++Ty3
X-Received: by 2002:a1c:cc06:: with SMTP id h6mr40736wmb.118.1583173330032;
        Mon, 02 Mar 2020 10:22:10 -0800 (PST)
X-Google-Smtp-Source: ADFU+vs9ZQ2SoIISj8TdDsBbhc3slcREpZ8XKsZ1xcKoa/2yEi4GDeN1FpR2ke/iKZ7ArhjCgTZ7JA==
X-Received: by 2002:a1c:cc06:: with SMTP id h6mr40717wmb.118.1583173329766;
        Mon, 02 Mar 2020 10:22:09 -0800 (PST)
Received: from [192.168.178.40] ([151.30.85.6])
        by smtp.gmail.com with ESMTPSA id a184sm346359wmf.29.2020.03.02.10.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 10:22:09 -0800 (PST)
Subject: Re: [PATCH v3] KVM: X86: Just one leader to trigger kvmclock sync
 request
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1582859921-11932-1-git-send-email-wanpengli@tencent.com>
 <87lfoihpwt.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f0fe943d-bdd0-1150-6d22-e7e48416da6d@redhat.com>
Date:   Mon, 2 Mar 2020 19:22:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87lfoihpwt.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/20 14:01, Vitaly Kuznetsov wrote:
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9389,11 +9389,9 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>  
>         mutex_unlock(&vcpu->mutex);
>  
> -       if (!kvmclock_periodic_sync)
> -               return;
> -
> -       schedule_delayed_work(&kvm->arch.kvmclock_sync_work,
> -                                       KVMCLOCK_SYNC_PERIOD);
> +       if (vcpu->vcpu_idx == 0 && kvmclock_periodic_sync)
> +               schedule_delayed_work(&kvm->arch.kvmclock_sync_work,
> +                                     KVMCLOCK_SYNC_PERIOD);
>  }

> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Good idea, I squashed the change.

Paolo

