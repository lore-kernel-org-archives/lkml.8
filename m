Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7500EC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47545207E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaHFLoGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbgAUMZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:25:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30027 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728682AbgAUMZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:25:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579609552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yIalB9cBALXRgp/uNH08VZa3aNqDipb3jjDmU3WLB8Q=;
        b=LaHFLoGy4Fwjac3NRE6NRp0nCF96HCHOlMXUa3X69ne4R45M5DxzcaxSHRkGPY+TGoQNzS
        CWeTW8QEFSc42epQCjlB/wYReqbUmdfBpFsOlA12tqPskadBz5913a++s+Q7rQrqJapzOF
        pnL/KLtbhFgNkEZaGGCvleptTR71pIg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-LJHXDn2ANPGLMZV-84Yj-w-1; Tue, 21 Jan 2020 07:25:50 -0500
X-MC-Unique: LJHXDn2ANPGLMZV-84Yj-w-1
Received: by mail-wr1-f72.google.com with SMTP id j4so1240837wrs.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 04:25:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yIalB9cBALXRgp/uNH08VZa3aNqDipb3jjDmU3WLB8Q=;
        b=CIhZMKZW6UhSHf1oME6OAsIjhW8R0XN+FksS09gJepiT3yi3HeDSQPw3urK4nfRVMK
         z4zwPYOMeR9YXyDLgEr5km0dI+dl8/fehPqpF0HqaK4kXsV/ySB7wVjykdBCAfgOuOHj
         HVGkWlnikmiYEV37s7OG2baWrV0GICJqS++Kez8aB/3lNRxtYdblSgTRGp+eiYN/CJpQ
         GJrWODhm91QKlrgqsPETm+aUGqJQ0GrODCp3D8bFQlYChw9BDUL6F8NhNgX1RMO6JRNv
         nTWmedjWuS9ZqD80gpF3z3R05ExR2AqvB7Iq6PzrMexIxDzurUt/45oalIm7ijQNu7hn
         0vNA==
X-Gm-Message-State: APjAAAU42r9tL7W71CLDWJqhCPqFheVRBMSSe/qHpHWJax42PHizXAWV
        WUb4dIdA9eegFCnSIdT08Pgo7pH+tCZFC+TVhLEjMf6TNNrehQiAdAmyA3yCIrxAKmzEXTUkT5O
        TawNlEvBlyz5sU9aCVfZPslsA
X-Received: by 2002:a5d:4e90:: with SMTP id e16mr4900214wru.318.1579609549463;
        Tue, 21 Jan 2020 04:25:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqxDJBpeRnDpwBUTmvjf0/2nvS8A5DXXrLixRiDHN9QnRC30oFmfVLhbmYyQlNVKrDuaKY0sSA==
X-Received: by 2002:a5d:4e90:: with SMTP id e16mr4900192wru.318.1579609549154;
        Tue, 21 Jan 2020 04:25:49 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a? ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
        by smtp.gmail.com with ESMTPSA id j12sm53225490wrt.55.2020.01.21.04.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 04:25:48 -0800 (PST)
Subject: Re: [PATCH] kvm/x86: export kvm_vector_hashing_enabled() is
 unnecessary
To:     Peng Hao <richard.peng@oppo.com>, rkrcmar@redhat.com
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1574814625-29295-1-git-send-email-richard.peng@oppo.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fa69afdb-f140-8891-c73f-ccbe4abbd108@redhat.com>
Date:   Tue, 21 Jan 2020 13:25:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1574814625-29295-1-git-send-email-richard.peng@oppo.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/19 01:30, Peng Hao wrote:
> kvm_vector_hashing_enabled() is just called in kvm.ko module.
> 
> Signed-off-by: Peng Hao <richard.peng@oppo.com>
> ---
>  arch/x86/kvm/x86.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 5d53052..169cea6 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10236,7 +10236,6 @@ bool kvm_vector_hashing_enabled(void)
>  {
>  	return vector_hashing;
>  }
> -EXPORT_SYMBOL_GPL(kvm_vector_hashing_enabled);
>  
>  bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
>  {
> 

Queued, thanks.

Paolo

