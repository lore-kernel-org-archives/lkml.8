Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959B0C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71DEE2068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erYyRWGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgDUQIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:08:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47254 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725990AbgDUQIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587485298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zX1gMKclpqnAEoBMDkK5PhMtrskM3KRZZa0iKX4TUNw=;
        b=erYyRWGV/0ocYHOU6uK5EhYmyY7NmrnJovFmRBsggadTyCJVIsrKfDqOpOoxwrvUAHkVFy
        uj1/OpH38NWS0bp8grYdAxNpCby6/AR5W3G0a1WU49/NHt7oEyKQcyOPmtOAqDK6vi24gs
        tdwT3RUF59UnF3WQVGU7t6JREtkUe3Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-s0ziHU3lOwm_Xx0qu341Yg-1; Tue, 21 Apr 2020 12:08:17 -0400
X-MC-Unique: s0ziHU3lOwm_Xx0qu341Yg-1
Received: by mail-wr1-f72.google.com with SMTP id d17so7719339wrr.17
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zX1gMKclpqnAEoBMDkK5PhMtrskM3KRZZa0iKX4TUNw=;
        b=kryY6OQ0NTlxw62uzvc/7GjjTq/wVDUGQhWFaKK+6idszSoo8XpeV0Ckynt5Z0eQrq
         Zg1x78dT+iA00AxDaHUZrjOvAp7GDhiEM5eK1XvyIuB0CQKKU4JrxlkT3Io0v/amyu/6
         g4GODZ5Z8y8e94hqzLZQffPKenQGsLULkFxPd5rOF3So5s0NAHcxkihblaL4JMuj1GuX
         fYaahG9yHb2uXd6D3ghI5B0Np8Uq4WHZKkbUA+D/Ppi9DorCG+Z2Mck67r0JQlNJONid
         YUKXvR1Gd5KC8MQkku53olrV/ukhvRAT5yuUlf8jo++W+xW4YZl4SicEr1w7Nvgs4tqV
         QdTQ==
X-Gm-Message-State: AGi0PuY5Zuth4OZdzlawszXXt8JRPp9KnXTpbrlS3PxLYP/BDNhNMrTW
        oPprN1D1mbgOaxToc5DAfC1ri6UcyY4/3kXOhD4+gPXPg4Qc2UVmH3dwbQ3BGMnYpCl6t5pgYVj
        1CKB5HB0zmHo4MSFDwiu0pQM0
X-Received: by 2002:a5d:4cc2:: with SMTP id c2mr7833689wrt.130.1587485295142;
        Tue, 21 Apr 2020 09:08:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypLvIubcHMY+bL+zO//2Pbr43uhrB1dGEYg7deIwhIyQZYcUlf8RLmjST2V4p2KxDgWpDL0OHQ==
X-Received: by 2002:a5d:4cc2:: with SMTP id c2mr7833673wrt.130.1587485294887;
        Tue, 21 Apr 2020 09:08:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f43b:97b2:4c89:7446? ([2001:b07:6468:f312:f43b:97b2:4c89:7446])
        by smtp.gmail.com with ESMTPSA id x18sm4235851wrs.11.2020.04.21.09.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 09:08:14 -0700 (PDT)
Subject: Re: [PATCH] kvm/eventfd: remove unneeded conversion to bool
To:     Jason Yan <yanaijie@huawei.com>, peterx@redhat.com,
        tglx@linutronix.de, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200420123805.4494-1-yanaijie@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7a0d78d8-e5db-30fb-a2a2-62113a791e49@redhat.com>
Date:   Tue, 21 Apr 2020 18:08:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420123805.4494-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8
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

