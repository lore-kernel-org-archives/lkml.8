Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C803EC2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A32222076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6gwro6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409951AbgDOOyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:54:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46215 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407940AbgDOOx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586962436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=36E4N7q+94RvweaZXTmr5UhjWWpdGRQf/CnIVV4HQ7Q=;
        b=U6gwro6xiU9eCgTCwQJRAK62K7jqZAL1m+2IQ0sSeLzDk6LQZSaViUIYykVrU+i8s1qKsS
        ALuoGPdoillUDzf07rZjmvrGkwxs2JJntzBD1YGRq5PEszDKhpujsNQ7mbkcKUmA9LBwM3
        zglDD0Y/uFz2jTRh157oJh3XBZFJsFI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364--J2YLDMYOearMlPirHaDnA-1; Wed, 15 Apr 2020 10:53:54 -0400
X-MC-Unique: -J2YLDMYOearMlPirHaDnA-1
Received: by mail-wm1-f72.google.com with SMTP id u11so2787881wmc.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 07:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=36E4N7q+94RvweaZXTmr5UhjWWpdGRQf/CnIVV4HQ7Q=;
        b=L0asS7BOJP8K6/pjUJ9QJSjfMVPE+DvYoj61htvJRQZhIJ84e/fO1aXUArwL8cYchq
         oCYLE3cFjNfdAvme0PdkjsoJCvCR9h+LDQCKb6oVmzWhTMujVzNPkDF6MkdYgVZuiIUG
         GYxOUx9iTnG2+XeoEkyUzh5dh6vkajBbl5C2juIAZy9vYEAwbw5eI2JRplqe1JJWmuEG
         yvLAN9LrZ/gLeGpKa1LuOu4Vm8reLXJOuRtr/cCLxkCXsmEctwqGUcFNKLH9ooBh+rtr
         KL84R8grDJujO5csUb7AfCZ2b0TQE3Pqts8oVmCw6S0PQom6LDzrnAnyk/1LmaSPOORv
         /D+A==
X-Gm-Message-State: AGi0PuZtG7RxdLM5M0r/1PCIKOZSXkrNgBYHXh8RuwR/Ba1cFDu8k93W
        M7eegp2R7cvNdXJ7zTE5Oc18eeB+t/arNuqEIEQjTAR+s9CIeJfRyr6072dlf1t8cnKzCnfe22T
        0CFA10z6Y02af2YBpHU4teyCH
X-Received: by 2002:adf:904a:: with SMTP id h68mr27495438wrh.291.1586962433427;
        Wed, 15 Apr 2020 07:53:53 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ/cAvGQw1YkBGC6okX7zE61HyLuQq2hlX8Pbvb6qNBrcmDX5EvBomqGUFPNgHPYY5OVR7fYQ==
X-Received: by 2002:adf:904a:: with SMTP id h68mr27495417wrh.291.1586962433189;
        Wed, 15 Apr 2020 07:53:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9066:4f2:9fbd:f90e? ([2001:b07:6468:f312:9066:4f2:9fbd:f90e])
        by smtp.gmail.com with ESMTPSA id t2sm16563569wmt.15.2020.04.15.07.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 07:53:52 -0700 (PDT)
Subject: Re: [PATCH] KVM: SVM: Fix build error due to missing release_pages()
 include
To:     Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>
Cc:     KVM <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20200411160927.27954-1-bp@alien8.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <26c86223-6e5b-169b-7967-a406a3b1678b@redhat.com>
Date:   Wed, 15 Apr 2020 16:53:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200411160927.27954-1-bp@alien8.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/20 18:09, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Fix:
> 
>   arch/x86/kvm/svm/sev.c: In function ‘sev_pin_memory’:
>   arch/x86/kvm/svm/sev.c:360:3: error: implicit declaration of function ‘release_pages’;\
> 	  did you mean ‘reclaim_pages’? [-Werror=implicit-function-declaration]
>     360 |   release_pages(pages, npinned);
>         |   ^~~~~~~~~~~~~
>         |   reclaim_pages
> 
> because svm.c includes pagemap.h but the carved out sev.c needs it too.
> Triggered by a randconfig build.
> 
> Fixes: eaf78265a4ab ("KVM: SVM: Move SEV code to separate file")
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/kvm/svm/sev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 0e3fc311d7da..0208ab2179d5 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -12,6 +12,7 @@
>  #include <linux/kernel.h>
>  #include <linux/highmem.h>
>  #include <linux/psp-sev.h>
> +#include <linux/pagemap.h>
>  #include <linux/swap.h>
>  
>  #include "x86.h"
> 

Queued, thanks.

Paolo

