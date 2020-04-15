Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D849EC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B09212076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/VB/KtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370858AbgDOOne (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:43:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30215 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733249AbgDOOmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586961751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jcswj4fMIzy1VSkpe0j3kCHXPaYoyRFwnxHUU0e019I=;
        b=X/VB/KtIlPs8RqKvLkqQYahNrzV16JhtmeJ1N037/IwNDMekMuzIvmYShQlgwGbBj1Yx+d
        j5AprWri9WbEf9UdvBoVRRtGrMwkqSf8RkadhSi/MqjeX7Nz0VBu9xU2DxGLOHJTXuyaPT
        YON+/iJQe1STB9nSPqNq6CXVbChqNho=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-Y1KEESK7MoaD85yEUkY4iQ-1; Wed, 15 Apr 2020 10:42:30 -0400
X-MC-Unique: Y1KEESK7MoaD85yEUkY4iQ-1
Received: by mail-wr1-f69.google.com with SMTP id d17so1832wrr.17
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 07:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jcswj4fMIzy1VSkpe0j3kCHXPaYoyRFwnxHUU0e019I=;
        b=DOD6N+df8FtQivuPmrR7AJrc1a9v9JEOHOePb9m1iF5VSRn9nP9vjKp6fvN+hPXJ7A
         oWL4bnt7rp1lQPCKd4NALEX5nG01lidf3yw30xnpScpEn7yd4O2+wSCSbM4RQrlH1Gll
         R/VIDOPh3dDZrL/TN0iAz7baUDgnvkkBZ8YGKRNnMMCAwNXEZbwqX5Wokya5MBChZ9/t
         s8dudcyPBCVvXTO/NovPVsQ1Qa52LNhokrhyyqYYdmARA9GKwQLPHFDh5MVU36wwsW26
         cHjQo76M0ppBHe7cdeiCLvryYgY5SkW/qm8o52UOHoIDiRZkyEMeo5zQxIKjjoJsiFIj
         iIjA==
X-Gm-Message-State: AGi0PuYnkNxfzn8nqsa8mRSRzaa+KBLcPbLoJk1gWpkB0FUDAezwfilu
        OctdrFqyvPlrH9hb1IrrXUObZgFK9LnX8VEJ/dciY1/7P2WggDs3nwE8/2dj3UB0a9MXRJh3NPJ
        X4QD9h7+dGmnLT4msiMhucUDZ
X-Received: by 2002:a5d:51c6:: with SMTP id n6mr23228102wrv.314.1586961748851;
        Wed, 15 Apr 2020 07:42:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypLhnFTufVnEV7mvMNC3KmCyW/b8aBHad2cdYj8UeBTDu5XbSSHNUq+WhQ9qWV0NLZkASnsJHg==
X-Received: by 2002:a5d:51c6:: with SMTP id n6mr23228081wrv.314.1586961748565;
        Wed, 15 Apr 2020 07:42:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9066:4f2:9fbd:f90e? ([2001:b07:6468:f312:9066:4f2:9fbd:f90e])
        by smtp.gmail.com with ESMTPSA id j11sm2090904wrr.62.2020.04.15.07.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 07:42:27 -0700 (PDT)
Subject: Re: [PATCH] x86/kvm: make steal_time static
To:     Jason Yan <yanaijie@huawei.com>, sean.j.christopherson@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Hulk Robot <hulkci@huawei.com>
References: <20200415084939.6367-1-yanaijie@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d1700173-29c1-2e7c-46bd-471876d96762@redhat.com>
Date:   Wed, 15 Apr 2020 16:42:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415084939.6367-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/20 10:49, Jason Yan wrote:
> Fix the following sparse warning:
> 
> arch/x86/kernel/kvm.c:58:1: warning: symbol '__pcpu_scope_steal_time'
> was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  arch/x86/kernel/kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 6efe0410fb72..f75010cde5d5 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -55,7 +55,7 @@ static int __init parse_no_stealacc(char *arg)
>  early_param("no-steal-acc", parse_no_stealacc);
>  
>  static DEFINE_PER_CPU_DECRYPTED(struct kvm_vcpu_pv_apf_data, apf_reason) __aligned(64);
> -DEFINE_PER_CPU_DECRYPTED(struct kvm_steal_time, steal_time) __aligned(64) __visible;
> +static DEFINE_PER_CPU_DECRYPTED(struct kvm_steal_time, steal_time) __aligned(64) __visible;
>  static int has_steal_clock = 0;
>  
>  /*
> 

Queued, thanks.

Paolo

