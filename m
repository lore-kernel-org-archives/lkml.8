Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8CBC55191
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C7CB2071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XIK6D6eh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDYKnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 06:43:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48732 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726087AbgDYKnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587811419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zX1gMKclpqnAEoBMDkK5PhMtrskM3KRZZa0iKX4TUNw=;
        b=XIK6D6ehndPRXiFuJisdbweMTv3c5M+y7VQX4Mt4enBFRkBEp334BybcEffF6uaBLRlRev
        kXrZTeZz0s/w9zEXTLvVl2OL892xd9YA7aedjY610iRc22GnTAt7wxtz6te9/NnRzvGJ1t
        ISBmGgV/LXMhhk7/IF8boUBcOunXoVg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-9R2PGDBqOam5g9pmCP4w9A-1; Sat, 25 Apr 2020 06:43:37 -0400
X-MC-Unique: 9R2PGDBqOam5g9pmCP4w9A-1
Received: by mail-wr1-f70.google.com with SMTP id g7so6490388wrw.18
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 03:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zX1gMKclpqnAEoBMDkK5PhMtrskM3KRZZa0iKX4TUNw=;
        b=F5LE+oZGmhtji8kKUn5tFkFEmpxL147pXqubQeqe4LfZjQ9kP7xaZhWDe0v18kHEzg
         /+OhRG1nSqrOFj5qGZxj6A8iVj8V4MAup8dyfwijZVaop0dALDfTW4dgrp7jh5/RZPeo
         RWrCf1c9T5xCFgbqzTkGyMLwtQDBWV2aV1D8zY2Nrq9sxEIKE7nfdktcG5yPdwVxL0Vs
         amsKHf8cuiPzh08aqIUaEzwMEttB3B9fRrxBhiHEXA2nEuHtq5NwCx31FAs5pADgnS80
         CWEPAc/XS8Z3QCwYouI9EdTQ/noRby0IftcmB5caOK2iaAdj1fboAFIwlkl9GZ5slHRI
         j3XA==
X-Gm-Message-State: AGi0PubzbMtSgeHMGYIDi8H/F0umA7HDOkrc7ulxxzlLwkfnIT4nZPNT
        KKPsUKBTimqCmSE78kptOLIdPYkvtJNgnqdXBv1XIyqQfpqatfvx43WpqeUx/o0aCTC3fv7WNiX
        cqNio5OTxIIYKVjl0U19RbcWJ
X-Received: by 2002:adf:ee88:: with SMTP id b8mr15892431wro.93.1587811416288;
        Sat, 25 Apr 2020 03:43:36 -0700 (PDT)
X-Google-Smtp-Source: APiQypKA9B9pJGKX+0LgDRDvi6v5gXYIEKKnz5THJmcU6hGlhBUcL+S8FEF2XD5VredWlxBdzhvHSQ==
X-Received: by 2002:adf:ee88:: with SMTP id b8mr15892412wro.93.1587811415984;
        Sat, 25 Apr 2020 03:43:35 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id k17sm6631766wmi.10.2020.04.25.03.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 03:43:35 -0700 (PDT)
Subject: Re: [PATCH] kvm/eventfd: remove unneeded conversion to bool
To:     Jason Yan <yanaijie@huawei.com>, peterx@redhat.com,
        tglx@linutronix.de, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200420123805.4494-1-yanaijie@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <109d0871-7099-b476-8354-11a628a04b3d@redhat.com>
Date:   Sat, 25 Apr 2020 12:43:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420123805.4494-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/20 14:38, Jason Yan wrote:
> The '==' expression itself is bool, no need to convert it to bool again.
> This fixes the following coccicheck warning:
> 
> virt/kvm/eventfd.c:724:38-43: WARNING: conversion to bool not needed
> here
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  virt/kvm/eventfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index 67b6fc153e9c..0c4ede45e6bd 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -721,7 +721,7 @@ ioeventfd_in_range(struct _ioeventfd *p, gpa_t addr, int len, const void *val)
>  		return false;
>  	}
>  
> -	return _val == p->datamatch ? true : false;
> +	return _val == p->datamatch;
>  }
>  
>  /* MMIO/PIO writes trigger an event if the addr/val match */
> 

Queued, thanks.

Paolo

