Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4BDC11D0A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07080206EF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTY9u1hH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgBTNoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 08:44:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58475 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727298AbgBTNoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 08:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582206245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9GnCMDDr9bENW9WQppVm9UUnxyqhxQmFQhfd/rFn4fo=;
        b=LTY9u1hH1HPAuKqAfxibwn5+nxaXOt9zdo6mnRy5wiVp1SmjhDkAB9aD6nfQpfc8WDe5Kx
        Ibg7ITcu/ZPulK794ZbYU22uHGrn94o4IuQstdQHr8L1BXhFuQOSQLntHV4nAMJhkwIYV2
        aGRYMsP2DIwd/i8yFY64ub5wi2ckIgw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-A_910umtPBaUjXRX0W3jow-1; Thu, 20 Feb 2020 08:44:03 -0500
X-MC-Unique: A_910umtPBaUjXRX0W3jow-1
Received: by mail-wm1-f69.google.com with SMTP id u11so846692wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 05:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9GnCMDDr9bENW9WQppVm9UUnxyqhxQmFQhfd/rFn4fo=;
        b=Xvvv7Q/kZtvbStyhfANslRaZKjGYy0VQL86pVkksMqIcadX5zg51W9aQE8w5EtoP28
         oZHGOyAGbckxDQjiPgK67wLaEbfe99SbUZujIzqJP9+4Ww1JU/Vpksu1mNiM8Ak3H9rf
         vuzxFXnetqNuygBI7bjiiWpZm+rCwJRculwtlffrgUTjZcEbOFwF7nUzGumLNwBEwUie
         uSK0/oKOmbCvJnxu6/TMAAl0+sMvgw+2Keyjdk38+H8KQEN/PoiG3m5rnPUE13ZcXEsF
         RLELetmdPwiwesOlj21z9tYt8QFzOjEzLPI3/ELZyqsh/U2MvpvF8DjKgCCw6b6//Sa9
         FgYQ==
X-Gm-Message-State: APjAAAVsgcgpXnJ4iAryzKGy/Z5DX5dW/3HG1zXrk0z0vQsFYcj1Io4k
        ePtvQksbQXVTSxQ+9GymvByYE2TtnCfQiyW3qlOTXtQtoXrxOWxOqdiuhq1pLhWwEfjSEubDE6O
        eMhw2cOx+A8TAZFiTODKF8RRd
X-Received: by 2002:a05:600c:4105:: with SMTP id j5mr4820232wmi.28.1582206242467;
        Thu, 20 Feb 2020 05:44:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqyUpHy0hlSQ8YseVyGjJV91s1b+icW0ezutQz33mhkVlVtICBPEbWyT+7sWDM88+qD5srIPjg==
X-Received: by 2002:a05:600c:4105:: with SMTP id j5mr4820213wmi.28.1582206242154;
        Thu, 20 Feb 2020 05:44:02 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a9sm4992690wrn.3.2020.02.20.05.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 05:44:01 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: enable -Werror
In-Reply-To: <1581535233-42127-1-git-send-email-pbonzini@redhat.com>
References: <1581535233-42127-1-git-send-email-pbonzini@redhat.com>
Date:   Thu, 20 Feb 2020 14:44:00 +0100
Message-ID: <875zg174rj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> Avoid more embarrassing mistakes.  

"avoid more" != "make less" :-)

> At least those that the compiler can catch.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
> index b19ef421084d..4654e97a05cc 100644
> --- a/arch/x86/kvm/Makefile
> +++ b/arch/x86/kvm/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  ccflags-y += -Iarch/x86/kvm
> +ccflags-y += -Werror
>  
>  KVM := ../../../virt/kvm

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

