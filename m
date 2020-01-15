Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BF3C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863482187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jM56Ns4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgAOSJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:09:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23791 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729126AbgAOSJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579111746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5tHKVF6hE8k1A4jAnNLU6EWJxP3bsR+fHzY8JCdWULQ=;
        b=jM56Ns4UrmdAEK36Mhv3F0ClsToBRfVefzqHku1yMND4Fxwm8qAxatJhpJvIzzb5ZQRwyQ
        K4vrsb4biHXnafLayDNptS2ZRwemOPtNYQYIK8FPvaKObNk5WG5Df3Z5mV5J8kre1/K5F3
        0z+KXNRn+fHtES9ytsCqPAGmApoW3zc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-MMQdVt1yOWihUOg90o26cQ-1; Wed, 15 Jan 2020 13:09:05 -0500
X-MC-Unique: MMQdVt1yOWihUOg90o26cQ-1
Received: by mail-wr1-f69.google.com with SMTP id b13so8249929wrx.22
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 10:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5tHKVF6hE8k1A4jAnNLU6EWJxP3bsR+fHzY8JCdWULQ=;
        b=mzpSslG43wNXgb8n9Ck/uI1YI+pAnbt+ZrJCvy7w2kjU9oDPTyb75lRwxP47PhJZ2+
         9TntEmXIBElkDi17C7h++1VwoDrOlCFFRMR1X3OfEQ5E0WUuu+iB6I6KqILp3+60obtA
         FG7UHfJ/c+4U6ioVFUBj9QMdsHhq6Saz7LVSG9pfHPY6aRNl8W/zTMSKmKUVlYnk61I7
         9SVp2lcDHxsWu+zdnN17W36ojcp39xENSEnGTIFcfjYInndZbQU3jjnLaOroVZsPwK5/
         UTPmhKMxpNlLJPziSNO0m4ZzUpR3Ylq2ZDnBevolgT3cypMJM7j0XThbXOA6KnT3Mgo9
         sZpQ==
X-Gm-Message-State: APjAAAV1kSG9loFQzDFuoo1mXQHb2oO0XlWKlo0kRVtUHvPvNBgUEjwz
        XICgc7DSNZr8qKyqjVnCUxHO7mCJTbWST3gT09alkTdOG8B1Sjac+439f2wS18rQD0UBWgy7Apx
        UHFH0t2v6/7ATHPu5G1YpxshD
X-Received: by 2002:a1c:cc06:: with SMTP id h6mr1180737wmb.118.1579111743673;
        Wed, 15 Jan 2020 10:09:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqxz3Od9pW50MbM+fl0twh6Cat2WEcOnFG3vbz6aK9duw/Q+74qSPhY+DNPxcgsaL7r4BOVCIw==
X-Received: by 2002:a1c:cc06:: with SMTP id h6mr1180714wmb.118.1579111743481;
        Wed, 15 Jan 2020 10:09:03 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a? ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
        by smtp.gmail.com with ESMTPSA id q3sm719555wmj.38.2020.01.15.10.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 10:09:02 -0800 (PST)
Subject: Re: [PATCH] KVM: VMX: Clean up the spaces redundant.
To:     Haiwei Li <lihaiwei.kernel@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, hpa@zytor.com
References: <5c33f601-0bee-7958-7295-541b87b95138@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <62d3be94-c5de-a50d-fa42-aed59702a64e@redhat.com>
Date:   Wed, 15 Jan 2020 19:09:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <5c33f601-0bee-7958-7295-541b87b95138@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/19 08:36, Haiwei Li wrote:
> From 6b2634f16cfd5d48896a7c0a094b59410ce078c5 Mon Sep 17 00:00:00 2001
> From: Haiwei Li <lihaiwei@tencent.com>
> Date: Wed, 18 Dec 2019 15:21:10 +0800
> Subject: [PATCH] Clean up the spaces redundant.
> 
> Clean up the spaces redundant in vmx.c.
> 
> Signed-off-by: Haiwei Li <lihaiwei@tencent.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 51e3b27..94a7456 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -173,7 +173,7 @@
>  module_param(ple_window_shrink, uint, 0444);
> 
>  /* Default is to compute the maximum so we can never overflow. */
> -static unsigned int ple_window_max        =
> KVM_VMX_DEFAULT_PLE_WINDOW_MAX;
> +static unsigned int ple_window_max = KVM_VMX_DEFAULT_PLE_WINDOW_MAX;
>  module_param(ple_window_max, uint, 0444);
> 
>  /* Default is SYSTEM mode, 1 for host-guest mode */
> -- 
> 1.8.3.1
> 

Queued, thanks.

Paolo

