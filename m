Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDD4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75557206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIY+T7f1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgA2SJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:09:08 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35337 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgA2SJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 13:09:08 -0500
Received: by mail-pg1-f195.google.com with SMTP id l24so195226pgk.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 10:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Qfgy4sCCCO9qTQgchyD2bDgwppQqFA1HOWEoZpdCsZk=;
        b=oIY+T7f1/3KDhWmi+9XoCo3BKr+sq4W/mKeDPKem3BbD+RYGZFt1E4Jp4cyhzNTMxX
         Vl4hyPH9kJOowMKuBPT14LZs8R7i6iRzAvLg4vy1iaGYIi3E5lYXku6DVG8xl258MhEl
         E11Q+enPS9OJ02bTdGX9v8A4hEx02Brb38Kxi3nQOfl6km6CZ0My6MEozc6OUudKSHD2
         kWixGUmfrVcQczIGzuiq4qKlMsZoHHEDPx8WHoXnoe6jMj96x4/AAWrNkteBp0x15qMV
         yQPmd/JcBLUbLvLO4WCP/uNjORquLpGHF8O1GKCVNz0drUGPUSfR27pKbWBGJVtNZL31
         wh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Qfgy4sCCCO9qTQgchyD2bDgwppQqFA1HOWEoZpdCsZk=;
        b=OMabP//BMbH5xk5rQ1/muWsw3pePJkJfAxEGBb2NiEa2AaNW3AjXb9trmRAg1rRdiO
         EefnqexA/OUC0rc+hyElTwZJs4xB6hcnyxBXuRNqibtaN/m3atn0tsuNnPcVNCVljYQY
         BF4d+4jD2pmZ4/x+JdrNOAWX3VvqCs+np+b7a3oc8TWr97siPj5ljBR/OR+zEazmHq63
         5mYYZ5bWdkEfUSIAdH15svAEbm2IjpgLfxqcRBYW/jVIdAzc/i6ZuKpUha306BLa/TgO
         q6wukgmhDHABxLi9kjNlExQ6QBkBvEwNnpIsX6xORlZSOWc+0J7MFzy3Zz8V3U5nbnPf
         X8Rw==
X-Gm-Message-State: APjAAAXzSiJBQoxEzsyd/hc8jYZptMjWRveW2Pu+UE/9D4s9satXaIB2
        sZSKzc9QEsFNro9+MXIxKHI=
X-Google-Smtp-Source: APXvYqwichPv1+UwFlqgSYCn8ypS1/PKPTuj/ovLT9rCDcB1J+64NLcb3U0HJ6idY1dU0SMjh5rnng==
X-Received: by 2002:a63:1106:: with SMTP id g6mr282135pgl.13.1580321347528;
        Wed, 29 Jan 2020 10:09:07 -0800 (PST)
Received: from [192.168.0.16] (97-115-104-237.ptld.qwest.net. [97.115.104.237])
        by smtp.gmail.com with ESMTPSA id n15sm204952pfq.168.2020.01.29.10.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 10:09:06 -0800 (PST)
Subject: Re: [PATCH] kbuild: Include external modules compile flags
From:   Gregory Rose <gvrose8192@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dev@openvswitch.org, dsahern@gmail.com
References: <1580161806-8037-1-git-send-email-gvrose8192@gmail.com>
 <CAK7LNAQyh9CFgKd1DtAPFW8DuHNp1gn8YABuP8-LsF=hHK2DFw@mail.gmail.com>
 <f6ffa0d0-8214-8fc0-4fe9-4b70a1581d3e@gmail.com>
Message-ID: <677aff5a-a52e-08ae-f341-547af08f7566@gmail.com>
Date:   Wed, 29 Jan 2020 10:09:05 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <f6ffa0d0-8214-8fc0-4fe9-4b70a1581d3e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/28/2020 7:37 AM, Gregory Rose wrote:
> On 1/27/2020 7:35 PM, Masahiro Yamada wrote:
>> On Tue, Jan 28, 2020 at 6:50 AM Greg Rose <gvrose8192@gmail.com> wrote:
>>> Since this commit:
>>> 'commit 9b9a3f20cbe0 ("kbuild: split final module linking out into 
>>> Makefile.modfinal")'
>>> at least one out-of-tree external kernel module build fails
>>> during the modfinal make phase because Makefile.modfinal does
>>> not include the ccflags-y variable from the exernal module's Kbuild.
>> ccflags-y is passed only for compiling C files in that directory.
>>
>> It is not used for compiling *.mod.c
>> This is true for both in-kernel and external modules.
>>
>> So, ccflags-y is not a good choice
>> for passing such flags that should be globally effective.
>>
>>
>> Maybe, KCFLAGS should work.
>>
>>
>> module:
>>         $(MAKE) KCFLAGS=...  M=$(PWD) -C /lib/modules/$(uname 
>> -r)/build modules
>>

Hi Masahiro,

I'm unable to get that to work.  KCFLAGS does not seem to be used in 
Makefile.modfinal.

[snip]
>>> --- a/scripts/Makefile.modfinal
>>> +++ b/scripts/Makefile.modfinal
>>> @@ -21,6 +21,10 @@ __modfinal: $(modules)
>>>   modname = $(notdir $(@:.mod.o=))
>>>   part-of-module = y
>>>
>>> +# Include the module's Makefile to find KBUILD_EXTRA_SYMBOLS
>>> +include $(if $(wildcard $(KBUILD_EXTMOD)/Kbuild), \
>>> +             $(KBUILD_EXTMOD)/Kbuild)
>>> +

I continue to wonder why this it is so bad to include the external 
module's Kbuild.
It used to be included in Makefile.modpost and did no harm, and in fact 
was what
made our external build work at all in the past.  Without the ability to 
define our
local kernel module build environment during the modfinal make I see no 
way forward.

That said, I'm no expert on the Linux kernel Makefile 
interdependencies.  If you
have some other idea we could try I'm game.

Thanks,

- Greg

