Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9DBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 14:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CDDD207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 14:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgHNOgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 10:36:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40165 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgHNOgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 10:36:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id m15so4924225lfp.7;
        Fri, 14 Aug 2020 07:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NO9eozMTpwGqng8nuxmq3yXenUdC5M4ZNaIM3MPApoc=;
        b=t85Q/X6sQIH7iPEeoNPjxbmhF8lviLw1h/whYTjA25Py2pQxP1XX+uNpUx+6mBcZSd
         IqDfWZ2cQxnrkjTzk+Rr5Pwn+8/vbEi2DwwJaPgLx6Li13afPPmbOs5BCvDd05r9jdfg
         4fXRp/f7irbcPsP2Z27+b0Cn+Gme0KYYylizRIbQ35P5g+7mQdRtz3NPELlj879XbsZm
         xZr8gN1w+3rb7bXnPHNs2Y19DEJplts+QZRvphu4TCjylaN3BuadyZv4L58Orzg//j9e
         UGzQzgRX2oRGp1m61rsN5GhucoL0jOIJqTkQoXMyfWq6NNYjlDHBC1OV+mTP9cB7EeXC
         hOOA==
X-Gm-Message-State: AOAM533kuzzGW+2RnESjfgkPz4rOLAIw/rSfHpK6s2OPYJVncHjBPbC9
        ZmhtXks43EqN9+Kz3VwCr2TabpMgxI4=
X-Google-Smtp-Source: ABdhPJwya6daZDg1709UAO+ZeAogK+wDgC0rCR3897JFviZd21xzcqM7b1cyMqFPpBPssXwfYKGtSQ==
X-Received: by 2002:a19:6b0e:: with SMTP id d14mr1370001lfa.103.1597415796370;
        Fri, 14 Aug 2020 07:36:36 -0700 (PDT)
Received: from [10.68.32.147] (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.gmail.com with ESMTPSA id t12sm1242709lfe.43.2020.08.14.07.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 07:36:35 -0700 (PDT)
Reply-To: efremov@linux.com
To:     Markus Elfring <Markus.Elfring@web.de>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     Julia Lawall <julia.lawall@inria.fr>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <ed9a8046-4c21-e849-f68b-9e08991b701d@web.de>
 <8e76e81f-970b-b1f7-840d-10506dc3311a@linux.com>
 <48ffa436-6e73-88b2-07bc-89942f3c6d8e@web.de>
From:   Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Subject: Re: [PATCH] coccinelle: api: add sprintf() support to
 device_attr_show
Message-ID: <0a9015b6-9037-59c5-31f2-cd2b32c86b50@linux.com>
Date:   Fri, 14 Aug 2020 17:36:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <48ffa436-6e73-88b2-07bc-89942f3c6d8e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/14/20 3:30 PM, Markus Elfring wrote:
>>> You propose to use a nested SmPL disjunction for desired adjustments.
>>> I suggest to start a corresponding case distinction behind
>>> the key word “return” instead of repeating it three times.
>>
>> It doesn't work.
> 
> How do you think about to apply a SmPL rule variant like the following?
> 
> @rp depends on patch@
> identifier show, dev, attr, buf;
> constant str;
> @@
> 
> ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
> {
> 	<...
> 	return
> (
> -		snprintf
> +		sprintf
> 			(
> 			buf,
> -			\(PAGE_SIZE\|PAGE_SIZE - 1\),
> (			str
> |
> (			"%i"\|"%i\n"\|"%li"\|"%li\n"\|"%lli"\|"%lli\n"\|
> 			"%d"\|"%d\n"\|"%ld"\|"%ld\n"\|"%lld"\|"%lld\n"\|
> 			"%u"\|"%u\n"\|"%lu"\|"%lu\n"\|"%llu"\|"%llu\n"\|
> 			"%x"\|"%x\n"\|"%lx"\|"%lx\n"\|"%llx"\|"%llx\n"\|
> 			"%X"\|"%X\n"\|"%lX"\|"%lX\n"\|"%llX"\|"%llX\n"\|
> 			"0x%x"\|"0x%x\n"\|"0x%lx"\|"0x%lx\n"\|"0x%llx"\|"0x%llx\n"\|
> 			"0x%X"\|"0x%X\n"\|"0x%lX"\|"0x%lX\n"\|"0x%llX"\|"0x%llX\n"\|
> 			"%02x\n"\|"%03x\n"\|"%04x\n"\|"%08x\n"\|
> 			"%02X\n"\|"%03X\n"\|"%04X\n"\|"%08X\n"\|
> 			"0x%02x\n"\|"0x%03x\n"\|"0x%04x\n"\|"0x%08x\n"\|
> 			"0x%02X\n"\|"0x%03X\n"\|"0x%04X\n"\|"0x%08X\n"\|
> 			"%zd"\|"%zd\n"\|"%zu"\|"%zu\n"\|"%zx"\|"%zx\n"\|
> 			"%c"\|"%c\n"\|"%p"\|"%p\n"\|"%pU\n"\|"%pUl\n"\|"%hu\n"
> )			,
> 			...
> )
> 			)
> |
> -		snprintf
> +		scnprintf
> 			(...)
> );
> 	...>
> }
> 

3 levels of nested disjunctions makes this pattern completely unreadable
and gives no comparable benefits. I don't think we should care much about
number of characters in the kernel sources, gzip will do a better job
anyway.


Thanks,
Denis
