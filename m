Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AACFC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C6820719
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RqDt+Msw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733040AbgG0OkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:40:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37987 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730521AbgG0OkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595860818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=izsbK+ZOKnq7dNSVt0IlxJ0IbYW71pzFLmCjbU4plCU=;
        b=RqDt+MsweS6EvRG9tfmqUpufgUqnG+n5cqkctIwXoQ7L+bxHWqTPXEDiEZSxtRxNcQIz5p
        T0hyaF2Ptc2tAVy3WWUa1As20J+YA/gJfznyAwdS1UyrRR1/dU86Ttnq3Kp8taB0GYXECA
        tSiD2pcnn2jXXTzw3lQGvQXU2cOspVo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-91nFSw4yMEiDHkMpP4VNRA-1; Mon, 27 Jul 2020 10:40:15 -0400
X-MC-Unique: 91nFSw4yMEiDHkMpP4VNRA-1
Received: by mail-wm1-f71.google.com with SMTP id s2so4799878wmj.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 07:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=izsbK+ZOKnq7dNSVt0IlxJ0IbYW71pzFLmCjbU4plCU=;
        b=C/W0vc8bKCYAXHl5eUyQVMOWs35Yy26PWGi+NO0/ikN0XBPJBIybPYQaFV+qTCI7J0
         Fb9X6vV0BvtmyTvjzBoQkr5pG+gYIsVzubOXLafaATmNqsvUcCIq/rGFppP8oX5XRAph
         n6GbpPK6IjEZAhBmEwfb2o7oJCsqijjTraD9APTHSGXOlZxQ2EK+i+jdIvV92rfht2tU
         1p8nSnOrWbWZru9ZY1Py+S8bP6yHSH9fdp/5KWhSSl0tx2Q9EvA8tnWkEJz86sxgVY0w
         sIhxLBGME2e3mH1WlkZsonbnF3Z450KntKhzFNhII+0dn1qksOT+rKPLpE0fb8djWXr4
         Mnuw==
X-Gm-Message-State: AOAM531fydHqOcHw+ypxUcAvJSLEkYCf4fISwgGlYFfBSHZrhVXjmJQA
        aJWxTlse/L9JG1K7LHrGpvIjclQYF+UtT511J3r1eda7wyeIbv7F07NCWPZGjPuaFvcE0C450ff
        /so+4+iMxht69C/ANkOmUC9GB
X-Received: by 2002:a1c:5982:: with SMTP id n124mr20918659wmb.77.1595860814723;
        Mon, 27 Jul 2020 07:40:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgZuIogu5hzxAcWaxVai3d/DsyPRSUKU7GcLo+4TZTFJ/k5uN+y5FA8hkMBW9RTUIKGPi0nA==
X-Received: by 2002:a1c:5982:: with SMTP id n124mr20918640wmb.77.1595860814402;
        Mon, 27 Jul 2020 07:40:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4502:3ee3:2bae:c612? ([2001:b07:6468:f312:4502:3ee3:2bae:c612])
        by smtp.gmail.com with ESMTPSA id z127sm4591641wme.44.2020.07.27.07.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 07:40:13 -0700 (PDT)
Subject: Re: [PATCH] KVM: Using macros instead of magic values
To:     Haiwei Li <lihaiwei.kernel@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>, mingo@redhat.com,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>
References: <4c072161-80dd-b7ed-7adb-02acccaa0701@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <92cd8fd2-d838-a1e3-dc39-7e6e5c4e68ca@redhat.com>
Date:   Mon, 27 Jul 2020 16:40:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <4c072161-80dd-b7ed-7adb-02acccaa0701@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/20 10:23, Haiwei Li wrote:
> From: Haiwei Li <lihaiwei@tencent.com>
> 
> Instead of using magic values, use macros.
> 
> Signed-off-by: Haiwei Li <lihaiwei@tencent.com>
> ---
>  arch/x86/kvm/lapic.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 47801a4..d5fb2ea 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2083,7 +2083,8 @@ int kvm_lapic_reg_write(struct kvm_lapic *apic,
> u32 reg, u32 val)
> 
>      case APIC_SELF_IPI:
>          if (apic_x2apic_mode(apic)) {
> -            kvm_lapic_reg_write(apic, APIC_ICR, 0x40000 | (val & 0xff));
> +            kvm_lapic_reg_write(apic, APIC_ICR,
> +                        APIC_DEST_SELF | (val & APIC_VECTOR_MASK));
>          } else
>              ret = 1;
>          break;
> -- 
> 1.8.3.1
> 

Queued, thanks.

Paolo

