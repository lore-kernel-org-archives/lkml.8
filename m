Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFBEC35242
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 00:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E382A206CC
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 00:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VZ6ckbfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgBLAVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 19:21:50 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40449 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgBLAVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 19:21:49 -0500
Received: by mail-io1-f66.google.com with SMTP id x1so178146iop.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 16:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=znb551cSk4SwLxhNrEmBfKq1pXuZl4kKW4lbTxGwGf0=;
        b=VZ6ckbfRbXGkd5NeS4Ei/5MZP/bHqLs4i414YLfooFZWB/vpkXt3IRgOWOHViumSmw
         d1dqbNOZEIA0wrY2USJ21lXm6Bf+vZ5MNqF4XFQaUy82r4ioVWSOAy2wxI6esOe4xUd5
         Pj0gKdW0s+lwOTFimBjaR2PgezxkqAafgvdOo4KIJjksO/DAYzzGhkJdfeLdtu7dc3D8
         lA5FUgjcvQ0OpSn5Jx+Qa0wDtDfIonHBAaPjMwsxTyl/oY3XrGZZxXwixUN/WWNMwSfd
         T3eYxWdvx/AdiShb5/amBwznu9N2xDiNXoBrwaPpwqx55F19thSdPSVjxxHnBWKL1QPK
         BPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=znb551cSk4SwLxhNrEmBfKq1pXuZl4kKW4lbTxGwGf0=;
        b=ONFevrqXyze0xYK02sByP8HZHyFP6BHTUbWxzT1XuaFvfNl9ndAyxm4hqi8brHBM2C
         Tc75Hv2EhSk7zirBlNQGGYpIyk6HgdSBE6Oi367wulFwFDaBRW0yo4XM58kvD7sDOEdE
         BXhgBr0f70q5G08lMmkLhojyf4hyp4MVLiroa8r9mb+zc8Yydn0VDNfT/1ooc7FcNJtI
         dOXn/DCQuWO0hKsPsUkC2CWHH7gGR6phlpMxBZ+txeAUAPXvpodkzuW4fFsvZcC+yiSt
         xlgoUHeBGGQ/40mYPAPoxEFpbETtYTJ+Jtu3nsZoqSV1it6qyo+18lxM8W7i97DfR/Lt
         8OBQ==
X-Gm-Message-State: APjAAAUSLb35e/ixTs00Dj81zz/bqAxX4tekG7ogOBVp/NZDQjB5KvAg
        +octeHNPn6jQSuX04/Tyachqg1/LcspAig==
X-Google-Smtp-Source: APXvYqxnRq6BGvwAHW2U261ceZ/bNuGg0tou3R07qwEpFfCKWQdGO9ZqNUDWl6Avc9BLocaETXZ3DQ==
X-Received: by 2002:a5e:9b01:: with SMTP id j1mr15005204iok.27.1581466907709;
        Tue, 11 Feb 2020 16:21:47 -0800 (PST)
Received: from [172.22.22.10] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id q90sm1797509ili.27.2020.02.11.16.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 16:21:46 -0800 (PST)
Subject: Re: [greybus-dev] [PATCH] staging: greybus: Replace zero-length array
 with flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
References: <20200211211219.GA673@embeddedor>
 <e465ca6e-ed9f-4340-9f4c-104f9b6acb74@linaro.org>
 <ebd179c5-29d6-4c86-e047-76815572fcf6@embeddedor.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <7ac2012c-6d22-dcc2-7c96-b9d6d578706a@linaro.org>
Date:   Tue, 11 Feb 2020 18:21:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ebd179c5-29d6-4c86-e047-76815572fcf6@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/20 4:47 PM, Gustavo A. R. Silva wrote:
> 
> 
> On 2/11/20 16:15, Alex Elder wrote:
>> On 2/11/20 3:12 PM, Gustavo A. R. Silva wrote:
>>> The current codebase makes use of the zero-length array language
>>> extension to the C90 standard, but the preferred mechanism to declare
>>> variable-length types such as these ones is a flexible array member[1][2],
>>> introduced in C99:
>>>
>>> struct foo {
>>>         int stuff;
>>>         struct boo array[];
>>> };
>>>
>>> By making use of the mechanism above, we will get a compiler warning
>>> in case the flexible array does not occur last in the structure, which
>>> will help us prevent some kind of undefined behavior bugs from being
>>> inadvertenly introduced[3] to the codebase from now on.
>>>
>>> This issue was found with the help of Coccinelle.
>>>
>>> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
>>> [2] https://github.com/KSPP/linux/issues/21
>>> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>>>
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> ---
>>>  drivers/staging/greybus/raw.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/staging/greybus/raw.c b/drivers/staging/greybus/raw.c
>>> index 838acbe84ca0..2b301b2aa107 100644
>>> --- a/drivers/staging/greybus/raw.c
>>> +++ b/drivers/staging/greybus/raw.c
>>> @@ -30,7 +30,7 @@ struct gb_raw {
>>>  struct raw_data {
>>>  	struct list_head entry;
>>>  	u32 len;
>>> -	u8 data[0];
>>> +	u8 data[];
>>>  };
>>>  
>>>  static struct class *raw_class;
>>>
>>
>> Does the kamlloc() call in receive_data() have any problems
>> with the sizeof(*raw_data) passed as its argument?
>>
> 
> Not in this case. It'd be different with a one-element array (u8 data[1]),
> though.
> 
>> I'm not entirely sure what sizeof(struct-with-flexible-array-member)
>> produces.
>>
> 
> The same as sizeof(struct-with-zero-length-array):
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html

I saw that, but I wondered what the standard says (and
whether Clang produces the same result).

I found this in a draft standard, and I guess we can
assume it applies here:

    "...the  size of the structure is as if the flexible
    array  member were omitted except that it may have
    more trailing padding than the omission would imply."

Looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> --
> Gustavo
> 

