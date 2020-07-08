Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2319CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D17382078B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594219350;
	bh=Og37IWk+rzdUhuqc33PQ0XLmps9AmjPXura1NZT+ReM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ZKhaNLmOVtal9G9gTJxv2q07o2RN6h1/m15Wy0Te7bPI4bIe342VW798Ouo8/Qu/K
	 bKW+NsaycEWI4JYZWK58MjNUeW1bVwXrMjMP40tzEfiyi3FAGEPIisrQ91iRWvQYIl
	 jqiJfeQkGuNzSRfN1ROYHtSgjI6l6IQtv5lGCbyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgGHOm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 10:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729676AbgGHOm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 10:42:28 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D12C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 07:42:28 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id c16so47248234ioi.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 07:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=olFZheMiwXV/hWN7JvWbJtXZG77gpY4w4jkiOAkoKwM=;
        b=A8AnotPqLSlZRRqYmspoS+6VXNBxfSG+I6aEVCqsfSgA+78sfaKBHlhDJuQvT5Z9fG
         ATD9tzSA3JJaeER79AscDOhx8gESCzX2TQ1BQqbx7rOvAkErjONQaQ5YxEM79dJipabC
         pCzFSpBDStem7TgumX2cqauSmd0K7vlrUSqHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=olFZheMiwXV/hWN7JvWbJtXZG77gpY4w4jkiOAkoKwM=;
        b=qVCLQzBQNhbDwaesqs88RWDyzQ8Nm1SsNFOCE7TC1fe9yUF5ZKGsydqJ9ApB6KNzC3
         YlZtQ4LsL+DujucvGcW7eP7hfrVN2ikylt1Tzv+69LjIOab8vMBvdnLnesM59AjvD8fe
         AOk2xS13lgy6UKjAMqXJ6z9o85tvAmrbVLV9+S4PcY2qEyb1Bbt0BIc9qA8A9pgzaZLK
         KHD8qrRJTIypPJfMDA1aBzYV7BkIy2M93po6mzUdg6SLGbZiOFJZej5B7mVyTvwpC6mr
         T3cVKVt7AkflNxPQ6aT1JqUChecsgFwzetehK3SwOnjLYaMNtOseLpjIK9NyRq5/TR+f
         ZKew==
X-Gm-Message-State: AOAM5327FtU8kWjQyNLztKcLDBZRuFIu+gJ+uNG6u3WPK35S1M0SUXTD
        k/X9PHqYEpTiJVOSMH6yl4wTTA==
X-Google-Smtp-Source: ABdhPJztx42BQruhpR+Eein2ofg+xHraiz1u5gK80gHGG1Sl2yr4WRL+agEWtq6nE56YmByNEYSJ+Q==
X-Received: by 2002:a6b:1d7:: with SMTP id 206mr37360623iob.138.1594219348015;
        Wed, 08 Jul 2020 07:42:28 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b21sm121894ioc.36.2020.07.08.07.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 07:42:27 -0700 (PDT)
Subject: Re: [PATCH] usbip: Use fallthrough pseudo-keyword
To:     Julia Lawall <julia.lawall@inria.fr>, Joe Perches <joe@perches.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200707195214.GA3932@embeddedor>
 <977e88c2-58cb-9507-c889-854e574a8f31@linuxfoundation.org>
 <8e08240671d65f1e92dbf5e1e066190149e0d074.camel@perches.com>
 <alpine.DEB.2.22.394.2007081209500.2558@hadrien>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <486d9450-21a9-fb35-3473-4e589005d1c7@linuxfoundation.org>
Date:   Wed, 8 Jul 2020 08:42:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2007081209500.2558@hadrien>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/20 4:16 AM, Julia Lawall wrote:
> 
> 
> On Tue, 7 Jul 2020, Joe Perches wrote:
> 
>> On Tue, 2020-07-07 at 14:06 -0600, Shuah Khan wrote:
>>> On 7/7/20 1:52 PM, Gustavo A. R. Silva wrote:
>>>> Replace the existing /* fall through */ comments and its variants with
>>>> the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
>>>> fall-through markings when it is the case.
>>>>
>>>> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
>>>>
>>>
>>> Is fallthrough syntax supported on our min gcc version?
>>
>> No.  Introduced in gcc 7.
>>
>>> Does checkpatch or coccicheck catch these cases?
>>
>> Kinda.  checkpatch isn't very good at it.
>> I _believe_, though I'm not at all sure,
>> that coccinelle can find these.
> 
> I would not guarantee anything about the support of Coccinelle for switch.
> Coccinelle does now have the ability to match on comments.  So since there
> is a distinct comment that it is to be removed, it might be possible to do
> that part automatically.
> 
> Maybe it would have to look something like this:
> 
> @r1@
> comments c : script:python() { code to recognize the comment };
> statement S;
> @@
> 
> S@c
> + fallthrough(); //or whatever is wanted
> 
> @@
> statement r1.S;
> @@
> 
> - S
> - fallthrough();
> + S
> + fallthrough();
> 
> The second rule probably looks pretty strange, but the goal is to remove
> the comments between S and fallthrough();
> 
> There is an example demos/comments.cocci that shows how to access the
> comment information using both ocaml and python.
> 

Thanks Julia. Maybe this is a way to address all of the cases. I am a
bit concerned about min gcc which is 4.8 and the fallthrough syntax
support is in gcc 7

-- Shuah

