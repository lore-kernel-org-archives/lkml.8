Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BBFC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C62252063A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/YfUCBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410010AbgDOP5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:57:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54391 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404288AbgDOP5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586966231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sWwTwNA7+phf5J6ocjP6MH/fyRWY0vqsvDmTIUNVg/c=;
        b=N/YfUCBixnViJpfJf0EmRV51xFGlDjHe1LV6xMoSA1u4nYZC4VniHm3DSoHCUs7qiMgswP
        DOFdUNpCabbXRCEHPWZ1xfwrsogSus2WeYgQxRJUn8rAJhyD38oJujj6M9m8uXpjJh4RR5
        CkZNVT8+7HDZJydwaljGKO7T1xnfn2s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-IMa1fkHbPIyHXrfns8LVwg-1; Wed, 15 Apr 2020 11:57:10 -0400
X-MC-Unique: IMa1fkHbPIyHXrfns8LVwg-1
Received: by mail-wr1-f72.google.com with SMTP id d17so118603wrr.17
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 08:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sWwTwNA7+phf5J6ocjP6MH/fyRWY0vqsvDmTIUNVg/c=;
        b=k8fPjrWqf6niVCH2CX18SZEGTGD51tg9b7u6+7ZR3OBZHU2AhuXs2lmD4WEglCWh0p
         yKq8DI87F15wUrSiP0yh9/CbLqXfZ023zE0B2bw0y83bm8pnFQjip9A0J07aaiw/C/La
         ANSXks68cv6DasCcEnHE7I6eJwGrqCV43WmEkMdNpYC/0ujcpALL2WZJuIlkfa5swZLI
         J56PCEDd97ad/C9dWjl6Da7M8ujLVC5x3BIAUZdTgmJLMmF6CI+vpn5w9d7xCtY7shJd
         nWkYGSwukqPG4/8rqSX+wPr6Fl3eO2VPHpVt5OM4vN5MjvFVH/ptwqZfV30HGpA0XHaB
         5TgA==
X-Gm-Message-State: AGi0PubqF+Fty9FS+HZVV6R6JKZNMtShvcBE5EJ1812EaIsAQCSwL6UU
        rRZzWqNz/P+cksIbIaNZj/9e65sH/xLIjqnzhKkfh1iD0FOCItfVjTfg8YkIAH93DtRSWZN6rHe
        Wo3lhOm/0GmOsACWahpjJDjBe
X-Received: by 2002:a5d:634d:: with SMTP id b13mr19463056wrw.353.1586966228729;
        Wed, 15 Apr 2020 08:57:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypIvk74Vbzc+nC3ZUdsH+JbRlmAAljzx/00bcskMqe7C68PkiOj6WX15mXQMgZZa33OZVhwlXw==
X-Received: by 2002:a5d:634d:: with SMTP id b13mr19463030wrw.353.1586966228418;
        Wed, 15 Apr 2020 08:57:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9066:4f2:9fbd:f90e? ([2001:b07:6468:f312:9066:4f2:9fbd:f90e])
        by smtp.gmail.com with ESMTPSA id v21sm12010wmj.8.2020.04.15.08.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 08:57:07 -0700 (PDT)
Subject: Re: [PATCH -next] kvm/svm: disable KCSAN for svm_vcpu_run()
To:     Qian Cai <cai@lca.pw>, paulmck@kernel.org
Cc:     elver@google.com, sean.j.christopherson@intel.com,
        kasan-dev@googlegroups.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200415153709.1559-1-cai@lca.pw>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f02ca9b9-f0a6-dfb5-1ca0-32a12d4f56fb@redhat.com>
Date:   Wed, 15 Apr 2020 17:57:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415153709.1559-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/20 17:37, Qian Cai wrote:
> For some reasons, running a simple qemu-kvm command with KCSAN will
> reset AMD hosts. It turns out svm_vcpu_run() could not be instrumented.
> Disable it for now.
> 
>  # /usr/libexec/qemu-kvm -name ubuntu-18.04-server-cloudimg -cpu host
> 	-smp 2 -m 2G -hda ubuntu-18.04-server-cloudimg.qcow2
> 
> === console output ===
> Kernel 5.6.0-next-20200408+ on an x86_64
> 
> hp-dl385g10-05 login:
> 
> <...host reset...>
> 
> HPE ProLiant System BIOS A40 v1.20 (03/09/2018)
> (C) Copyright 1982-2018 Hewlett Packard Enterprise Development LP
> Early system initialization, please wait...
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/x86/kvm/svm/svm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 2be5bbae3a40..1fdb300e9337 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3278,7 +3278,7 @@ static void svm_cancel_injection(struct kvm_vcpu *vcpu)
>  
>  bool __svm_vcpu_run(unsigned long vmcb_pa, unsigned long *regs);
>  
> -static void svm_vcpu_run(struct kvm_vcpu *vcpu)
> +static __no_kcsan void svm_vcpu_run(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  
> 

I suppose you tested the patch to move cli/sti into the .S file.  Anyway:

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks,

Paolo

