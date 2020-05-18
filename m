Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD494C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD184207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+oHmq9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgERKz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 06:55:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33899 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726388AbgERKz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589799356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4qCPvl+Kzxwr6u2SnFhTAgqF+P+2b9DjFZ38t/g4QD4=;
        b=P+oHmq9eLc3xlGGsiFlu6Lbbx2vl85GCJKXz4D7+IY9aPf1SXLf203a+hHFMu9bqWETF51
        gC7xf3iGFdo26xdGRN4mcNgpDBNyKCjvN1MN6qVxVhDmQaxx+ig6erYsstFqKoijdOJklF
        5yZ1vZcUlWOkKRSQ5Oc3tBHHAiUJiaQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-uX0bK0YwNFCwlvQUhBV1sw-1; Mon, 18 May 2020 06:55:55 -0400
X-MC-Unique: uX0bK0YwNFCwlvQUhBV1sw-1
Received: by mail-wr1-f71.google.com with SMTP id z16so5483463wrq.21
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 03:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4qCPvl+Kzxwr6u2SnFhTAgqF+P+2b9DjFZ38t/g4QD4=;
        b=Oo8PR2YXgkJLbsqz1fTEvGs+/r4EWWEhP2sIvA/z6qWmyUb0InfC1itZHVIM+2i/53
         BgpY3rguJodbEIYMqlaWJbjbjnBqGkoymz8TJWo73NPBwFplUBjrm4MNeampLNL3YRVN
         nu2iGkgm1fnaMqdIe6L16LudfDjGpGXnmHoKuewmoD+3qzHHYqkJmBa977oNVVtAHat1
         FPCb85ZHXw8jXIuVMjSLxWsZPv7t+SuraNrTJtfygqnMpSJdsgP4NSojtIHHqLEyzrEi
         s3B2vn6kACem6A600I9HVe/mMFJrZ2EaSqOx41qSiLBDMoOug44nEJVtIN+3b5nOeACm
         6tTg==
X-Gm-Message-State: AOAM531fQYEaFMf7Xe6mbzwn8W58UbZQ+D9klwZbJdYnX+gPdjcSJwzq
        vj/6nU5K6t/WP8ALPTiFLhI1pisIvAwAEW70f2sGOOoSADHuNAhZvnga+QwS8nNL0dCPdw6t/x+
        7ixZZ7OD9Wrhak3EwgAih6oVm
X-Received: by 2002:a1c:f312:: with SMTP id q18mr18869332wmq.175.1589799353627;
        Mon, 18 May 2020 03:55:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsnCM+6ovpWCbwXHDYfwN2IAiPYSCAAfCLhQaa+AbmlDlCkZMMg/BjMjagVdget3fEYHegKA==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr18869311wmq.175.1589799353431;
        Mon, 18 May 2020 03:55:53 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.90.67])
        by smtp.gmail.com with ESMTPSA id r3sm15448334wmh.48.2020.05.18.03.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 03:55:52 -0700 (PDT)
Subject: Re: [PATCH] KVM: Fix the indentation to match coding style
To:     Haiwei Li <lihaiwei.kernel@gmail.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>, wanpengli@tencent.com,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, hpa@zytor.com
Cc:     "x86@kernel.org" <x86@kernel.org>, kvm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <2f78457e-f3a7-3bc9-e237-3132ee87f71e@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b4443a42-bd06-4b67-64e6-6c636507713b@redhat.com>
Date:   Mon, 18 May 2020 12:55:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2f78457e-f3a7-3bc9-e237-3132ee87f71e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/20 03:31, Haiwei Li wrote:
> From: Haiwei Li <lihaiwei@tencent.com>
> 
> There is a bad indentation in next&queue branch. The patch looks like
> fixes nothing though it fixes the indentation.
> 
> Before fixing:
> 
>                 if (!handle_fastpath_set_x2apic_icr_irqoff(vcpu, data)) {
>                         kvm_skip_emulated_instruction(vcpu);
>                         ret = EXIT_FASTPATH_EXIT_HANDLED;
>                }
>                 break;
>         case MSR_IA32_TSCDEADLINE:
> 
> After fixing:
> 
>                 if (!handle_fastpath_set_x2apic_icr_irqoff(vcpu, data)) {
>                         kvm_skip_emulated_instruction(vcpu);
>                         ret = EXIT_FASTPATH_EXIT_HANDLED;
>                 }
>                 break;
>         case MSR_IA32_TSCDEADLINE:
> 
> 
> Signed-off-by: Haiwei Li <lihaiwei@tencent.com>
> ---
>  arch/x86/kvm/x86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 471fccf..446f747 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1631,7 +1631,7 @@ fastpath_t handle_fastpath_set_msr_irqoff(struct
> kvm_vcpu *vcpu)
>                 if (!handle_fastpath_set_x2apic_icr_irqoff(vcpu, data)) {
>                         kvm_skip_emulated_instruction(vcpu);
>                         ret = EXIT_FASTPATH_EXIT_HANDLED;
> -               }
> +               }
>                 break;
>         case MSR_IA32_TSCDEADLINE:
>                 data = kvm_read_edx_eax(vcpu);
> -- 
> 1.8.3.1
> 

Queued, thanks.

Paolo

