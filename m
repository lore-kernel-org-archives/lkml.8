Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A89C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3341120663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9ki7V9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbgF2TB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:01:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56641 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727018AbgF2TBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593457305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rE8sePDsqa4643aK/Xq/VoL9+mfjUnQLSGGnMx89Flk=;
        b=R9ki7V9/RnRr86Dlmgk8FELDy8nWOxN4KYPjz0WXf0d2ID56d+nsw+m0N452NSAYot6mve
        mV6EmfvFUy8uIidrEwJjb68eIiCMTrrUCN+gfVMJffhBNuCpN/OUhwsOkrO6mVCtnULGUc
        /ElGP50P7f15XvuWiISOjqfAX+Q/ypA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-Z7Hk_V3DPFe4DDRLgJCccg-1; Mon, 29 Jun 2020 09:59:28 -0400
X-MC-Unique: Z7Hk_V3DPFe4DDRLgJCccg-1
Received: by mail-wr1-f70.google.com with SMTP id p9so16576130wrx.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 06:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rE8sePDsqa4643aK/Xq/VoL9+mfjUnQLSGGnMx89Flk=;
        b=EoFblXlhAgvxBtNtf6LKdOeFl1L1jkINCLxuOyobzaXmw6FiFDXlbbAiftOOKPigbw
         Fc1tYIBhtGwL4X6Nt7HmeYiBWeHmYEtC9FSWBKeFkRFyiUZz8Qyp6tEr6E77/lcDj/1S
         DvbEBQ1xNLiMZVVYoy/woYMUgcD0Jom9JAlg1lGgibe512ERQLaXcyIBCY1gkJnhtU+P
         pYseRectbOk5QJgjRHi1n5QrPMhw1NOYdKeraX287WXKrCqCe4ksmiPyGXRyqpDdqNRq
         X4UejaIkzr60/EjocEjb4YcY8jiJtmmw2NNgfKaGmsjav38sXw/qUlG9AsVmiNG4vCf9
         ccRg==
X-Gm-Message-State: AOAM531qqqE2Ea3zRw+LwCiKKFyZrFd6PIlokSJkpFSiam/1o67y5Qa8
        UgwxyGfLrZV0WMjLVtRnKYGwFieX5y8KB1hmNQsARPZgWk7Jcn9e+E9Vad4mKSGarSczTM4xhlG
        THPhuFO0TnYPq1i2mZnRaVnxS
X-Received: by 2002:a1c:ce:: with SMTP id 197mr16802247wma.177.1593439167025;
        Mon, 29 Jun 2020 06:59:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsxz9zZlXFnZ7BIFPMcVeMeUzlm7a/lsLSfHAU3MGsXPZfgWzKa7c4KMMzMv09dmjzWh/Gkg==
X-Received: by 2002:a1c:ce:: with SMTP id 197mr16802236wma.177.1593439166855;
        Mon, 29 Jun 2020 06:59:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b0e5:c632:a580:8b9a? ([2001:b07:6468:f312:b0e5:c632:a580:8b9a])
        by smtp.gmail.com with ESMTPSA id o1sm52465447wrw.20.2020.06.29.06.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 06:59:26 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: Fix async pf caused null-ptr-deref
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1593426391-8231-1-git-send-email-wanpengli@tencent.com>
 <877dvqc7cs.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f9b06428-51c3-09af-48cc-d378182916fd@redhat.com>
Date:   Mon, 29 Jun 2020 15:59:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <877dvqc7cs.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/20 15:46, Vitaly Kuznetsov wrote:
>> +	if (!lapic_in_kernel(vcpu))
>> +		return 1;
>> +
> I'm not sure how much we care about !lapic_in_kernel() case but this
> change should be accompanied with userspace changes to not expose
> KVM_FEATURE_ASYNC_PF_INT or how would the guest know that writing a
> legitimate value will result in #GP?

Almost any pv feature is broken with QEMU if kernel_irqchip=off.  I
wouldn't bother and I am seriously thinking of dropping all support for
that, including:

- just injecting #UD for MOV from/to CR8 unless lapic_in_kernel()

- make KVM_INTERRUPT fail unless irqchip_in_kernel(), so that
KVM_INTERRUPT is only used to inject EXTINT with kernel_irqchip=split

Paolo

> Alternatively, we may just return '0' here: guest will be able to check
> what's in the MSR to see if the feature was enabled. Normally, guests
> shouldn't care about this but maybe there are cases when they do?
> 

