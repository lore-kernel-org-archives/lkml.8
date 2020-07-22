Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20368C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE19920727
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKEmnc6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733074AbgGVXxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 19:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbgGVXxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 19:53:01 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB82BC0619DC;
        Wed, 22 Jul 2020 16:53:00 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u5so2081917pfn.7;
        Wed, 22 Jul 2020 16:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B5mk9djHDrhZQjRnYy8xg8m6WI9FXyZZZHr/dT2BIYU=;
        b=jKEmnc6qdbr+pSxMexbN5/0ydyb9jmmb/CtnBEhEA6/eA8yB2kplXzQeuADuMg7/87
         Ek6zng6kNQoOoiYeCj5Y1eQQTI8+BCpDgzHZZIVD1sEcEt/YC06S2tGS9cngJLnPoNu9
         xSugmrcuZoAoK06D4TFrGc8dOGA40S6+mWjILrpBVH2qYi+7d5EUq1a4xrc8AktEXwAp
         o4Zu4cDUf/xx9pPZSdtRmbliiw2e+4mo3HMh30a433vZkkoQQwThsF9QVadXKym+qBmc
         OJ66r0NoqGT8zzwUvDMMgtsyEz5NirAh4WIyE6fJ9PTz13Wjy4I9M5sE68SwNJe5WE0W
         qeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=B5mk9djHDrhZQjRnYy8xg8m6WI9FXyZZZHr/dT2BIYU=;
        b=kmDf24++PSJNnXHpqz83F6g83CEVp/d963MiIqCA4IBpFDohNP3U46xqRY18l28b9F
         6HKHbKpTyhwkrF1tklMOucJaI0/nwTWxuG4oW8EWguZCb25sdBsaUR+iaDUEFMV9y3tg
         WIEHYq7OBIfZmyt1BYbDUFdj2SiZw31e0+sf8UIB0YJTOZg/RNTVuQWClvzsrOU4ce8Y
         m7UDH+3j1cg/yjlkvFAJtuckz4MSfUEwN/qosU9FvRenOipWgzsfxYfkiXxuHzUrwkEa
         tdRljoLe/OKccsfypJqhZuU0JCq60FEoHG3nhzmtCLmqophtl+AbtJEFcsmrFzFaIZUz
         ysJg==
X-Gm-Message-State: AOAM532cAEs4Tv/ahKrsjip2iskbAjR8Zxe6FaSbO3wH15leq/ErZ8gc
        bxboWOGiyg2TgKUD6LpGj7VvhWyi
X-Google-Smtp-Source: ABdhPJy0DBSEwvu2CNfFxKmkCKvY0Jp7Icur6ZIHGZjTOF/DjMn54r4Cgx6ficLJcfcPRByIL3WlZw==
X-Received: by 2002:a62:8ccb:: with SMTP id m194mr1870232pfd.36.1595461980003;
        Wed, 22 Jul 2020 16:53:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9sm698919pfd.133.2020.07.22.16.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 16:52:58 -0700 (PDT)
Subject: Re: [PATCH] sh: add missing EXPORT_SYMBOL() for __delay
To:     Rich Felker <dalias@libc.org>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <87wob2clos.wl-kuninori.morimoto.gx@renesas.com>
 <20200722023840.GA55317@roeck-us.net>
 <20200722225239.GX14669@brightrain.aerifal.cx>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <fa0456c9-cef0-45e7-59d7-ad652734b1d5@roeck-us.net>
Date:   Wed, 22 Jul 2020 16:52:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722225239.GX14669@brightrain.aerifal.cx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rich,

On 7/22/20 3:52 PM, Rich Felker wrote:
> On Tue, Jul 21, 2020 at 07:38:40PM -0700, Guenter Roeck wrote:
>> On Thu, Dec 12, 2019 at 11:38:43AM +0900, Kuninori Morimoto wrote:
>>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>>
>>> __delay() is used from kernel module.
>>> We need EXPORT_SYMBOL(), otherwise we will get compile error.
>>>
>>> ERROR: "__delay" [drivers/net/phy/mdio-cavium.ko] undefined!
>>>
>>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>
>> I must admit that this patch completely baffles me. __delay was
>> already exported, only elsewhere in the file. With this patch
>> in place, it is exported twice, and all sh builds in -next fail
>> with
>>
>> In file included from include/linux/linkage.h:7,
>>                  from arch/sh/include/asm/bug.h:5,
>>                  from include/linux/bug.h:5,
>>                  from include/linux/thread_info.h:12,
>>                  from include/asm-generic/current.h:5,
>>                  from ./arch/sh/include/generated/asm/current.h:1,
>>                  from include/linux/sched.h:12,
>>                  from arch/sh/lib/delay.c:8:
>> include/linux/export.h:67:36: error: redefinition of '__ksymtab___delay'
>>
>> Guenter
>>
>>> ---
>>>  arch/sh/lib/delay.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/sh/lib/delay.c b/arch/sh/lib/delay.c
>>> index dad8e6a..540e670 100644
>>> --- a/arch/sh/lib/delay.c
>>> +++ b/arch/sh/lib/delay.c
>>> @@ -29,6 +29,7 @@ void __delay(unsigned long loops)
>>>  		: "0" (loops)
>>>  		: "t");
>>>  }
>>> +EXPORT_SYMBOL(__delay);
>>>  
>>>  inline void __const_udelay(unsigned long xloops)
>>>  {
> 
> I presently have a revert of this commit in queue for next. If it's
> sufficiently breaking (and especially if there are other regressions
> that need to be fixed, see the pmd_free thing) I could try to get it
> in for 5.8 still but that's getting a bit late.
> 

The patch in mainline is ok. It appears that it has been applied
again in -next.

"git log --oneline v5.7.. arch/sh/lib/delay.c" on top of next-20200721
reports:

ee0e4f15dfd4 (origin/akpm) sh: add missing EXPORT_SYMBOL() for __delay
d1f56f318d23 sh: add missing EXPORT_SYMBOL() for __delay

Maybe it just needs to be dropped from the akpm tree in -next ?

Thanks,
Guenter
