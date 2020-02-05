Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4066C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E93218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VCTk3RZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgBEOzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:55:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40272 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726320AbgBEOzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:55:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580914542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Apr6jPFMPadZ6VcFfTXO/neiYKpBhQFen1bycOWrv0=;
        b=VCTk3RZNlyy52RYTcziRVgZYs2kPNAQ66FdoAuoMeTHrkQ8hoirhYjKxYFdLxfC0iVnGCf
        TUmz+jVqoA91gXPcZAZkV/Fm1LRTzaaAUvC3dWDwznc3O/F0rsMOqaL0pNk4VHbXaUU8HN
        xOhNTy5BDX7C3jw2A+GsyKer160MRNE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-g4FzdGDOPzaxMulyv8ORXg-1; Wed, 05 Feb 2020 09:55:37 -0500
X-MC-Unique: g4FzdGDOPzaxMulyv8ORXg-1
Received: by mail-wr1-f70.google.com with SMTP id p8so1311288wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 06:55:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Apr6jPFMPadZ6VcFfTXO/neiYKpBhQFen1bycOWrv0=;
        b=JwcIsqsbyVGncQ2wV0cviZtprS8K/ZHm0c6bGSCRQYqMarlxeH0ZDW7D76W2OybZ0N
         DpDCb0BGkZDzQSJRcosZd+AH1b6xnn6HGEhCT+mWhV3cm8WAdWn+fscoMANMM17ArsER
         zJXVnox4RdXBe1McZFWr1yjpFJC2wNJJtO0fpkgTVi3wiaC7Wqpjn/QB9Twk+u2zcoZs
         5mvF2ZPvtcF8qQhd8djSCOBevP9zpdKEnI6r+rj1wozuQOq6MYBNkS+N4lvW3Mw5hbnA
         EjZcPMLK8OEGmsWe9znuOX2FGKHsztW5Ev65YY6fuT/+96n7wUMNEd/ujfTiTT2YCmrP
         3oKw==
X-Gm-Message-State: APjAAAUxWDyoOZYJEkPdP1ZQYk99LFMdn3Ixbk8bES5LxRklwtvQG3JR
        A4AZLUOQuA7FAByipqAj9vuxxjx8k7+mfrZswt72sNo1Ryf+edYIajtWP1iamtsrrZKm6YLLck/
        kIi/PM5jreZ+vDI7U0xqN+zTM
X-Received: by 2002:a1c:5f06:: with SMTP id t6mr6232297wmb.32.1580914536328;
        Wed, 05 Feb 2020 06:55:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqxMDOPjQO1WGEO27EZ111Mu4rckUktMk9kud1PhMkGSCCGuov+QjkW9lVN5tJszG3vDKZQ1tg==
X-Received: by 2002:a1c:5f06:: with SMTP id t6mr6232275wmb.32.1580914536051;
        Wed, 05 Feb 2020 06:55:36 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56? ([2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56])
        by smtp.gmail.com with ESMTPSA id s65sm8834946wmf.48.2020.02.05.06.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 06:55:35 -0800 (PST)
Subject: Re: [PATCH 0/3] x86/kvm/hyper-v: fix enlightened VMCS & QEMU4.2
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Liran Alon <liran.alon@oracle.com>,
        Roman Kagan <rkagan@virtuozzo.com>
References: <20200205123034.630229-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <adbf1ea0-9c59-f683-ce03-a8fd92bfe488@redhat.com>
Date:   Wed, 5 Feb 2020 15:55:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200205123034.630229-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/20 13:30, Vitaly Kuznetsov wrote:
> With fine grained VMX feature enablement QEMU>=4.2 tries to do KVM_SET_MSRS
> with default (matching CPU model) values and in case eVMCS is also enabled,
> fails. While the regression is in QEMU, it may still be preferable to
> fix this in KVM.
> 
> It would be great if we could just omit the VMX feature filtering in KVM
> and make this guest's responsibility: if it switches to using enlightened
> vmcs it should be aware that not all hardware features are going to be
> supported. Genuine Hyper-V, however, fails the test. It, for example,
> enables SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES and without
> 'apic_access_addr' field in eVMCS there's not much we can do in KVM.
> Microsoft confirms the bug but it is unclear if it will ever get fixed
> in the existing Hyper-V versions as genuine Hyper-V never exposes
> these unsupported controls to L1.
> 
> Changes since 'RFC':
> - Go with the bare minimum [Paolo]
> 
> KVM RFC:
> https://lore.kernel.org/kvm/20200115171014.56405-1-vkuznets@redhat.com/
> 
> QEMU RFC@:
> https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg00123.html
> 
> Vitaly Kuznetsov (3):
>   x86/kvm/hyper-v: remove stale evmcs_already_enabled check from
>     nested_enable_evmcs()
>   x86/kvm/hyper-v: move VMX controls sanitization out of
>     nested_enable_evmcs()
>   x86/kvm/hyper-v: don't allow to turn on unsupported VMX controls for
>     nested guests
> 
>  arch/x86/kvm/vmx/evmcs.c  | 90 ++++++++++++++++++++++++++++++++++-----
>  arch/x86/kvm/vmx/evmcs.h  |  3 ++
>  arch/x86/kvm/vmx/nested.c |  3 ++
>  arch/x86/kvm/vmx/vmx.c    | 16 ++++++-
>  4 files changed, 99 insertions(+), 13 deletions(-)
> 

Queued, thanks.

Paolo

