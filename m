Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D87BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 139B420729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="oyw4eWd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbgGVKVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgGVKVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:21:01 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA2CC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:21:01 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id r12so817748ilh.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PkgNjuH0re4Q7qPeSybNSLCmblxEadw0kOBtvVg3X1I=;
        b=oyw4eWd+Fb2mw9IxPseZ32QSlljL3Ww2mivGyJdH0RTmv4IVSRCkQ20tsZY504IGGg
         z0x0Bfn13NyfcR7nEZZaPFFCaqB/1jYE+CUEx1rZGOVh/7Z8c3eqM7Bap4mHvyg3kTLz
         llI7vmSIIR1gJux2u4qZ93GLnndLdBQ3xZIAR0jFR3QxAXBrq8Jd8yc6Uik559N9J216
         jKPJVLXReOynXPnbSSmBnLKZv9y+yFOqdFt7aJux4iIbdQSdIsgBZ2N7eLim/yBedltT
         nJl0WuGf8xAyIWFZBG0atg3q38cF79S5xBf9BBNrapUm38B6NRuCBRZbdBaozQHNIsFM
         lCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PkgNjuH0re4Q7qPeSybNSLCmblxEadw0kOBtvVg3X1I=;
        b=OYOUKpEzhzxY9YxqEvXsBKgoqhHT10s55G1rqnB0Z2bK6PhgkNpu9pN5zlmvUoJG+w
         z+NIcfAT4qr7TMbZggcYmYTXXK32YpiVQtDxB7vKZluE0+NgVDIwZBBixK0kVT6l2cKH
         ikByO6kXJAVL80yag5I9ERqOO5sNhspm1Q+Nx4sDNIEwy/6UMafGiN5mOCzelkMAsZ4D
         mC0lHhirfVqY9S0zrhfPuwFx1LhbiurxtF0eXmlnYOGHMtMZqOeqShgs8nquKC9cM6+8
         BUnPkN6NHRdkNQCOwg9pVaHrX5q5jVzFt6Q7d+LB+fX2q6KD9dhROqehyUSomQQ61WEA
         BBRw==
X-Gm-Message-State: AOAM533xHZ+kwwgs+cp2B2TcFAWDAxXmCxVOMOhJGHPC3u2ig7pbB2bi
        EtwqCXkDjbYnUeVEUxcOmf9B6LnSFPE=
X-Google-Smtp-Source: ABdhPJx3gcQCFnXkbqf9RYJ79qKVem/VXm4+g5TjUOPMGb0VCOTAMwkwmX8poBZgDaKWgUu1s8Yqcw==
X-Received: by 2002:a92:8451:: with SMTP id l78mr32782711ild.234.1595413260592;
        Wed, 22 Jul 2020 03:21:00 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:0:4a0f:cfff:fe35:d61b])
        by smtp.googlemail.com with ESMTPSA id z4sm2685899ilq.25.2020.07.22.03.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 03:21:00 -0700 (PDT)
Subject: Re: af_key: pfkey_dump needs parameter validation
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        netdev@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
References: <20200721132358.966099-1-salyzyn@android.com>
 <20200722093318.GO20687@gauss3.secunet.de>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <2ae16588-2972-a797-9310-4f9d56b7348b@android.com>
Date:   Wed, 22 Jul 2020 03:20:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200722093318.GO20687@gauss3.secunet.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/20 2:33 AM, Steffen Klassert wrote:
> On Tue, Jul 21, 2020 at 06:23:54AM -0700, Mark Salyzyn wrote:
>> In pfkey_dump() dplen and splen can both be specified to access the
>> xfrm_address_t structure out of bounds in__xfrm_state_filter_match()
>> when it calls addr_match() with the indexes.  Return EINVAL if either
>> are out of range.
>>
>> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
>> Cc: netdev@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: kernel-team@android.com
>> ---
>> Should be back ported to the stable queues because this is a out of
>> bounds access.
> Please do a v2 and add a proper 'Fixes' tag if this is a fix that
> needs to be backported.
>
> Thanks!

Confused because this code was never right? From 2008 there was a 
rewrite that instantiated this fragment of code so that it could handle 
continuations for overloaded receive queues, but it was not right before 
the adjustment.

Fixes: 83321d6b9872b94604e481a79dc2c8acbe4ece31 ("[AF_KEY]: Dump SA/SP 
entries non-atomically")

that is reaching back more than 12 years and the blame is poorly aimed 
AFAIK.

Sincerely -- Mark Salyzyn

