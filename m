Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8051EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 567A6206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKjVazW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgFJXy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:54:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56870 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726948AbgFJXy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 19:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591833266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SCtwfxayuox1/yPqLw5A7CnfLtpo4UULn1Kziha2I2Q=;
        b=BKjVazW6AQvJydW8fGRijbH1IGVSOdQ9EmTuC3XViF4mFQkemimrNQxcRTUj7q5SearMn7
        W734Mi7GMdu13QdHY3pJvGaQ6QVM3vM54KJsn/2word0U3hOpy0RqEyJL6Y6i9EsXAQlr5
        GAlEkt3GlR9tOlp2SW8rAPj5qW8fkkw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-_x3vyxqgPLy5nwM8OwRC1A-1; Wed, 10 Jun 2020 19:54:24 -0400
X-MC-Unique: _x3vyxqgPLy5nwM8OwRC1A-1
Received: by mail-wr1-f71.google.com with SMTP id j16so1738077wre.22
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 16:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SCtwfxayuox1/yPqLw5A7CnfLtpo4UULn1Kziha2I2Q=;
        b=WdRYKJKgh8FvSi6Ia+8dRTWg7mbvKLQmEKLitumCrd3rxuMspKdqEt7NXEnnN4IRau
         BpQQ9GESiXRrvG4JQ29nBUwnSsE9z1q5KLlKxxODSeGn9rLdeFjASP8O90rM1Vqlhkw/
         jMxZSeQQeq+/NkkAPPcTY/E9n+y+TWbRSOR6lSpxV50IJT7vFInQ5gbfRQwcUImKjuWA
         WkzXDAihUEWzkfJwOirDlPgxRbu2q1s2OfwQa62GaAx9wx4um1bbFRqVsOFz3A6OU2qL
         py/alk2LSygIEMvo/KvGNwwIeQAfxpJlZfeiS5FuCXYXApMzfyK0sI3umZfuda7REU3t
         IdNg==
X-Gm-Message-State: AOAM531Wn7+Q3wzWNNj14x7cI81Jsnsw48xhW/Tl/bJ0rjtHU6/x07mF
        a7XwCNL64hEaMJA+yXvizcofACk3OMmh+fBjsgi9mzM8PJrc4NBSm8+xDS+3uaQdjFJgL3cxRrk
        UN3TSu91YB1lV39f0/e88U7KP
X-Received: by 2002:adf:f64c:: with SMTP id x12mr5965176wrp.281.1591833263031;
        Wed, 10 Jun 2020 16:54:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysclxi3majveRTpBVh4uGlZRNlhlB/11mmXMMl39Dgc4rltBvvupYmUCE0PccDrtKt6N0wEw==
X-Received: by 2002:adf:f64c:: with SMTP id x12mr5965158wrp.281.1591833262819;
        Wed, 10 Jun 2020 16:54:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29ed:810e:962c:aa0d? ([2001:b07:6468:f312:29ed:810e:962c:aa0d])
        by smtp.gmail.com with ESMTPSA id q1sm1469054wmc.12.2020.06.10.16.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 16:54:22 -0700 (PDT)
Subject: Re: [PATCH] KVM: selftests: fix sync_with_host() in smm_test
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Marcelo Bandeira Condotta <mcondotta@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20200610164116.770811-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c9a42060-a951-aadc-93db-c22b86a9a0de@redhat.com>
Date:   Thu, 11 Jun 2020 01:54:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200610164116.770811-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/20 18:41, Vitaly Kuznetsov wrote:
> It was reported that older GCCs compile smm_test in a way that breaks
> it completely:
> 
>   kvm_exit:             reason EXIT_CPUID rip 0x4014db info 0 0
>   func 7ffffffd idx 830 rax 0 rbx 0 rcx 0 rdx 0, cpuid entry not found
>   ...
>   kvm_exit:             reason EXIT_MSR rip 0x40abd9 info 0 0
>   kvm_msr:              msr_read 487 = 0x0 (#GP)
>   ...
> 
> Note, '7ffffffd' was supposed to be '80000001' as we're checking for
> SVM. Dropping '-O2' from compiler flags help. Turns out, asm block in
> sync_with_host() is wrong. We us 'in 0xe, %%al' instruction to sync
> with the host and in 'AL' register we actually pass the parameter
> (stage) but after sync 'AL' gets written to but GCC thinks the value
> is still there and uses it to compute 'EAX' for 'cpuid'.
> 
> smm_test can't fully use standard ucall() framework as we need to
> write a very simple SMI handler there. Fix the immediate issue by
> making RAX input/output operand. While on it, make sync_with_host()
> static inline.
> 
> Reported-by: Marcelo Bandeira Condotta <mcondotta@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  tools/testing/selftests/kvm/x86_64/smm_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/smm_test.c b/tools/testing/selftests/kvm/x86_64/smm_test.c
> index 36314152943d..ae39a220609f 100644
> --- a/tools/testing/selftests/kvm/x86_64/smm_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/smm_test.c
> @@ -47,10 +47,10 @@ uint8_t smi_handler[] = {
>  	0x0f, 0xaa,           /* rsm */
>  };
>  
> -void sync_with_host(uint64_t phase)
> +static inline void sync_with_host(uint64_t phase)
>  {
>  	asm volatile("in $" XSTR(SYNC_PORT)", %%al \n"
> -		     : : "a" (phase));
> +		     : "+a" (phase));
>  }
>  
>  void self_smi(void)
> 

Queued, thanks.

Paolo

