Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C35C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103B82078B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TzqRs97V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371201AbgDOO5G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:57:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52888 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S371177AbgDOO4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586962611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4LhKDhow9t4woo07RzJCC9BA6orwImyFYcMaIKVNQYo=;
        b=TzqRs97VvVnPF1S/AUh13ioMLeQ+2iWNapgWA/qMtVTQogIHTWlYRMayXL1P/Azjqrc+z9
        bkLB6JVbNaFo7UEdw7jpC9/n071MGzLyBd6/4FwsOhf186JuOlQ9AAUv34oDfvvehTTE0k
        b/UvUI3cmZWVbpRHPbDoRA+RwaawNZI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-zu35gdtLNf-onHsC-VLV_A-1; Wed, 15 Apr 2020 10:56:49 -0400
X-MC-Unique: zu35gdtLNf-onHsC-VLV_A-1
Received: by mail-wm1-f69.google.com with SMTP id f17so5054067wmm.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 07:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4LhKDhow9t4woo07RzJCC9BA6orwImyFYcMaIKVNQYo=;
        b=qGvdfQi07nBoZD2zU6w0ymQU1PAC1LRtTRX6EX6xe0hyyiXJysOv5n+o14cBYYXXNM
         s0fOSzrI7pvQkFZnivV0o5pZ9299KFrTKnz/zcZIV3af0Hx20Kz1YC4W2ETrUT4Z/sS9
         W5n+I76nxew3s58FEEL1MtNpZmFS9khyuXlJGs/9a7YYTwcjWSjRY0GnIY/rGSCpkXDd
         12Vqun1yv1vX/Mg2yMNmxnoGyvivcQdnBzFIurx31WRgO9If+FNsMi92erhvI0PdXcdq
         irz7ZS/Gw/cnYERJov8YLsgpyGHMuBUtzXyHCnSNSEFCbvUIdWDQkyAUmNIirYj+UJwd
         fqlg==
X-Gm-Message-State: AGi0PuZU4VaZelgG0aAYH4GYu/wPMmB53kp/A2YKqf6lJHB7+72+6gu2
        6iF0eaZHBt3SAXaP7T/sQdit4JaVfvoq83uTt+Xz0kgj5l/vPpYuCTKqVrhUnU9waFTJvT/sSCD
        ZAsmrLdE75dMoxNEIXWa6IEw1
X-Received: by 2002:a1c:3281:: with SMTP id y123mr5590629wmy.30.1586962608040;
        Wed, 15 Apr 2020 07:56:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypJjilpHVeNKifN5eFrDuYwLsxn/vAfdpiQUm+CsSSmPNw/ELDy1FSOfPgEWE/zxFxJRvEgZQg==
X-Received: by 2002:a1c:3281:: with SMTP id y123mr5590604wmy.30.1586962607784;
        Wed, 15 Apr 2020 07:56:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9066:4f2:9fbd:f90e? ([2001:b07:6468:f312:9066:4f2:9fbd:f90e])
        by smtp.gmail.com with ESMTPSA id n124sm23657617wma.11.2020.04.15.07.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 07:56:47 -0700 (PDT)
Subject: Re: [PATCH] KVM: remove redundant assignment to variable r
To:     Colin King <colin.king@canonical.com>, kvm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200410113526.13822-1-colin.king@canonical.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6d66cb24-b517-1bc3-15c3-9b302215febf@redhat.com>
Date:   Wed, 15 Apr 2020 16:56:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200410113526.13822-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/20 13:35, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable r is being assigned  with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  virt/kvm/kvm_main.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 74bdb7bf3295..03571f6acaa8 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3160,7 +3160,6 @@ static long kvm_vcpu_ioctl(struct file *filp,
>  	case KVM_SET_REGS: {
>  		struct kvm_regs *kvm_regs;
>  
> -		r = -ENOMEM;
>  		kvm_regs = memdup_user(argp, sizeof(*kvm_regs));
>  		if (IS_ERR(kvm_regs)) {
>  			r = PTR_ERR(kvm_regs);
> 

Queued, thanks.

Paolo

