Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7818AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5361122D03
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJj2ffV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgHTN3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:29:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42240 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729301AbgHTN1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 09:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597930060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DAGecdZwlkCmWN+ue1t4x/y2+dJaBtvVkYDbnFL2ArE=;
        b=DJj2ffV5GMFskZvUpCs+SXgswY2KApFmfdwxi+7MZey2Dl8LqAVhSVFVTc/CPddQNNupHi
        5lwbBXTVTxJOXJZc6GcZKHTSt1hY0rlY8+FMVRm2+6XbyyCdWFk1IpVRhZYl9ElqJn/J+8
        sXMGLGK4Uf6SrA+SPaEk1mqxy0DokZ0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-yxxGaQzqMcq_kYE18BaPXw-1; Thu, 20 Aug 2020 09:27:39 -0400
X-MC-Unique: yxxGaQzqMcq_kYE18BaPXw-1
Received: by mail-qk1-f198.google.com with SMTP id n128so1250214qke.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 06:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DAGecdZwlkCmWN+ue1t4x/y2+dJaBtvVkYDbnFL2ArE=;
        b=ajNCuiBJubvJsQMvg0qenl1Zij678KKnlNnNaNfVmkHnatHXhfLyJe4iNJjnunjSGl
         A1tywggZWrjfaJAxfu3zPy7ApG9WiCFoTjFfvBvkNeYuyYrmdw9WtkZ7yBl+rtN9WYjy
         DVHdZC7TLlLGi2hRV3LCS5r4knlunnLA2CyGibcAwQdB0323IVUvEbiCDQH3ERy8HGwf
         AZmlWXlvRbDnNrlo+lULODdR/HKcigiDyuNRudRwwMmmqSmcabnWO8jofV8pYvN4rJO8
         UpdE6mu9L1f7JO0xH174Y9jz33cGz9Ogt73G6wgUH0GprlP8DTbjEXtrtpckRfqwuWd3
         qrpQ==
X-Gm-Message-State: AOAM530viX6dskgvpAuIz7rZNbSynCEg/7zqt59Lkx9gWMSYqSUWrF03
        UOaVO4XYYhd0DeGJ3MBqEnGp96OYtAtP82Gt1Dn8HdOF31Tc0L0hyKVQGisTgMtNUk43whGz070
        XiT+g4sS3gzGJ21Nykl9TKf2N
X-Received: by 2002:ac8:564d:: with SMTP id 13mr2688673qtt.101.1597930058349;
        Thu, 20 Aug 2020 06:27:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8usGhxVEOYqYVa3I9N6+A3QyxTwJoJ2mZHFFTPor1LOox137u/l6oZfaIOPqyX556p76xjA==
X-Received: by 2002:ac8:564d:: with SMTP id 13mr2688660qtt.101.1597930058111;
        Thu, 20 Aug 2020 06:27:38 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k31sm2798255qtd.60.2020.08.20.06.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 06:27:37 -0700 (PDT)
Subject: Re: [PATCH] crypto: drbg: check blocklen is non zero
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     davem@davemloft.net, smueller@chronox.de,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200802171247.16558-1-trix@redhat.com>
 <20200820071522.GA21511@gondor.apana.org.au>
From:   Tom Rix <trix@redhat.com>
Message-ID: <97371bc7-ebb6-92f2-bbaa-6b444e27cb8b@redhat.com>
Date:   Thu, 20 Aug 2020 06:27:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200820071522.GA21511@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many divide by 0 reports.  This one got attention because it is in crypto, where i believe problems, even false positives, should be fixed.

Tom

On 8/20/20 12:15 AM, Herbert Xu wrote:
> On Sun, Aug 02, 2020 at 10:12:47AM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Clang static analysis reports this error
>>
>> crypto/drbg.c:441:40: warning: Division by zero
>>         padlen = (inputlen + sizeof(L_N) + 1) % (drbg_blocklen(drbg));
>>                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
>>
>> When drbg_bocklen fails it returns 0.
>>
>> 	if (drbg && drbg->core)
>> 		return drbg->core->blocklen_bytes;
>> 	return 0;
> Yes but it can only fail if the drbg is not instantiated.  If
> you're hitting the generate path with an uninstantiated drbg you've
> got bigger problems than a divide by zero.
>
> So how is this even possible?
>
> Cheers,

