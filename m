Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95709C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 730C8206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6QbDLkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgFBN27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgFBN26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:28:58 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F048BC061A0E;
        Tue,  2 Jun 2020 06:28:57 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id d6so1444838pjs.3;
        Tue, 02 Jun 2020 06:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fP8bDVMSOhUWMBpileSgO8TPsqk2gHN6BkWpLwOq3I0=;
        b=X6QbDLkQFzzfgBl8Z+cYFVwUfWYoeWpLs+gdCIrW8IjydOBV75ORrI6HMHjj2Mpt5m
         fZHDTBggkpC7nWAe90KGiXhkxT3cPp9fMNupiR5vyqU6zBHzJG+7ILq+eJrK+/Mpwjjx
         RnX5qALh+mD/jmK6RApH9SI6vjaUjxfPMNlvWoTPytWbFfjzjxeHZo7fV8CfxBcDd+tM
         3spaLlpFOuJlmmCltL5+rFRTdQAIUwheahxGC/drCs3tzUjq18Y7CSUOAWbFyYcvP/az
         PeXdRA2GMvR8y/3pcij8iBMPq+a2a4QHo0/W1xahEm2LeWvja9BHT/0exmQX7gDVwkiA
         Zicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fP8bDVMSOhUWMBpileSgO8TPsqk2gHN6BkWpLwOq3I0=;
        b=Uf3luvA79vGMpIZgKQqNVbdb+j4yzNRQS7OtFj37O938w8Rhyfbk3qF+5GiRRvcMjo
         GOG5eBxDSbdbYtHjfp/b4S2i7arXVM3cKNh03Ok6Gb4hEIMKvqeJJnTh0HwGvOTY3NoI
         cauK6INHU/EA1pgsQzm7uPtSosTzrj8WipuqAPA8gKNIhjUP283VrFp8TV9PuaBeYguf
         1Ps2EjtqNGLjJu+6Z1H9NGHk0CyCr8bYO4aKjJe6mCl1fBx0e3S2x28BmTI8/7xKpOY6
         fL22c7fxW7MQdtN8RaH+PvU8w6XKiFn79op7z6zrXYKkA+37CMROBJ0Xa6jpJm/w/B5I
         OCZg==
X-Gm-Message-State: AOAM5305IZAMOBZ/Oeh8x7qM1W5uq9MHZZMlGrxnBTea0y8SovJhpV53
        yFGKaiLpj3lpZ/3OO1RQaTo=
X-Google-Smtp-Source: ABdhPJz6b8mrr9XDbRkVoSaeyZm1ughGVCKjctF9bY+4py+mzxGmlbPG3zRJUsuvL8egDFRBUvOGjg==
X-Received: by 2002:a17:90b:1101:: with SMTP id gi1mr5872830pjb.117.1591104537361;
        Tue, 02 Jun 2020 06:28:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n24sm2482118pjt.47.2020.06.02.06.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 06:28:56 -0700 (PDT)
Subject: Re: [v4,1/1] hwmon: (nct7904) Add watchdog function
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        yuechao.zhao@advantech.com.cn
Cc:     345351830@qq.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amy.shih@advantech.com.tw, oakley.ding@advantech.com.tw,
        jia.sui@advantech.com.cn, shengkui.leng@advantech.com.cn
References: <20200331052850.5419-1-yuechao.zhao@advantech.com.cn>
 <CAMuHMdUesEMsWH55Tfe+eru8iVpgWbKPnL-wgRakG9BEpP4Y1g@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <c94d4263-1644-7059-f26d-e81c30a1c766@roeck-us.net>
Date:   Tue, 2 Jun 2020 06:28:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUesEMsWH55Tfe+eru8iVpgWbKPnL-wgRakG9BEpP4Y1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/20 1:01 AM, Geert Uytterhoeven wrote:
> Hi Yuechao,
> 
> On Tue, Mar 31, 2020 at 7:30 AM <yuechao.zhao@advantech.com.cn> wrote:
>> From: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
>>
>> implement watchdong functionality into the "hwmon/nct7904.c"
>>
>> Signed-off-by: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
> 
> Thanks for your patch, which is now commit 77849a552d142ef5 ("hwmon:
> (nct7904) Add watchdog function").
> 
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -1340,10 +1340,12 @@ config SENSORS_NCT7802
>>
>>  config SENSORS_NCT7904
>>         tristate "Nuvoton NCT7904"
>> -       depends on I2C
>> +       depends on I2C && WATCHDOG
>> +       select WATCHDOG_CORE
> 
> This makes the driver unselectable if WATCHDOG is not set.
> 
> Is there a use case for using this driver without watchdog functionality?
> If yes, it might make sense to make the watchdog support optional,
> protected by #ifdef CONFIG_WATCHDOG, and change the above to
> 

We use the same pattern in other hwmon drivers which also implement
watchdog functionality, so I am not particularly concerned about it.

Guenter

>     depends on I2C
>     select WATCHDOG_CORE if WATCHDOG
> 
> If no, please ignore my email.
> 
>>         help
>>           If you say yes here you get support for the Nuvoton NCT7904
>> -         hardware monitoring chip, including manual fan speed control.
>> +         hardware monitoring chip, including manual fan speed control
>> +         and support for the integrated watchdog.
>>
>>           This driver can also be built as a module. If so, the module
>>           will be called nct7904.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 

