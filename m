Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98746C3565B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC3C206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JJd2icL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgBUSXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 13:23:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50654 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgBUSXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:23:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so2757769wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 10:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=el0ksJbOaCzUgbQQlOdxCAczDgGJZ08IsAkqI71psIE=;
        b=JJd2icL1qjAUrXOYho8MTDEJu+K4IobYWsBZeg0w/qRU4Rs1SfWnWRv0Vo09VjqD8X
         UUdtVwRy2eNM7ZZ5gGp5d4+KME3tnAciw2KQZWZ+H1lGcdWYIXyOYQR/ziz5xaGCD19L
         gwVfS8Z2Eij1tCyGwa+maXTsvzgfh9scgHCfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=el0ksJbOaCzUgbQQlOdxCAczDgGJZ08IsAkqI71psIE=;
        b=UEYBoBw8s8KOxdY1q+8A+qsCQzP8vYImPmSv4bJv6g6FF1qGw6QN0Yowj8lwdMIo9Y
         V2mDLmko5ly705ADUkfo3ip5DDYgkbOMueUNltxSCIY4mt4roGXRGmbq2wYg76JNjTtY
         NtLMDgBemBHWRK+kFY1Yt9IcNlrHxTYTyLGVr8Bq9vDdV1Dn4yHZ32Ly4SU81SL5gQAO
         b8gou9o1IrbBMXY7l7Zll4uRc9bYdQdH94yygxLlQ0on9Af8vsnh45YGf7vATqEC+GyW
         QOhZYXYvYF7JuCk8ArIjSbAZzaGeF2FUpUj2WwyrKGF/rCNt0LXVAtHnZeY6+5SPc6P8
         7dBQ==
X-Gm-Message-State: APjAAAV8ys2NUQnQ1ICk6j/n6yZ8jnwfGWe3ljvmiY7RKuT2YEOMii7f
        +zo5VEmZgmrvhM4j5Jmk5E0Vsg==
X-Google-Smtp-Source: APXvYqx4zkQNTAzHsaS1HJ4Q9vOk7i7H0fXR5nL1AHhodIvw7c+ts75n1DYhqiJupD1CUbSs1LvWGQ==
X-Received: by 2002:a1c:f713:: with SMTP id v19mr4959041wmh.113.1582309410725;
        Fri, 21 Feb 2020 10:23:30 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id f8sm4696963wru.12.2020.02.21.10.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 10:23:27 -0800 (PST)
Subject: Re: [PATCH 2/7] firmware: add offset to request_firmware_into_buf
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <20190822192451.5983-1-scott.branden@broadcom.com>
 <20190822192451.5983-3-scott.branden@broadcom.com>
 <s5hef1crybq.wl-tiwai@suse.de>
 <10461fcf-9eca-32b6-0f9d-23c63b3f3442@broadcom.com>
 <s5hr258j6ln.wl-tiwai@suse.de>
 <93b8285a-e5eb-d4a4-545d-426bbbeb8008@broadcom.com>
 <s5ho90byhnv.wl-tiwai@suse.de>
 <b440f372-45be-c06c-94a1-44ae6b1e7eb8@broadcom.com>
 <s5hwoeyj3i5.wl-tiwai@suse.de> <20191011133120.GP16384@42.do-not-panic.com>
 <e65a3ba1-d064-96fe-077e-59bf8ffff377@broadcom.com>
 <CAK8P3a2NJurg_hxVbWYZwJVhYM5-xjWt12Kh0DdyfTGqQPrPAQ@mail.gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <c3bf2985-78d3-ae98-a19d-a596f42a22ce@broadcom.com>
Date:   Fri, 21 Feb 2020 10:23:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2NJurg_hxVbWYZwJVhYM5-xjWt12Kh0DdyfTGqQPrPAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-02-21 12:44 a.m., Arnd Bergmann wrote:
> On Fri, Feb 21, 2020 at 1:11 AM Scott Branden
> <scott.branden@broadcom.com> wrote:
>> On 2019-10-11 6:31 a.m., Luis Chamberlain wrote:
>>> On Tue, Aug 27, 2019 at 12:40:02PM +0200, Takashi Iwai wrote:
>>>> On Mon, 26 Aug 2019 19:24:22 +0200,
>>>> Scott Branden wrote:
>>>>> I will admit I am not familiar with every subtlety of PCI
>>>>> accesses. Any comments to the Valkyrie driver in this patch series are
>>>>> appreciated.
>>>>> But not all drivers need to work on all architectures. I can add a
>>>>> depends on x86 64bit architectures to the driver to limit it to such.
>>>> But it's an individual board on PCIe, and should work no matter which
>>>> architecture is?  Or is this really exclusive to x86?
>>> Poke Scott.
>> Yes, this is exclusive to x86.
>> In particular, 64-bit x86 server class machines with PCIe gen3 support.
>> There is no reason for these PCIe boards to run in other lower end
>> machines or architectures.
> It doesn't really matter that much what you expect your customers to
> do with your product, or what works a particular machine today, drivers
> should generally be written in a portable manner anyway and use
> the documented APIs. memcpy() into an __iomem pointer is not
> portable and while it probably works on any x86 machine today, please
> just don't do it. If you use 'sparse' to check your code, that would normally
> result in an address space warning, unless you add __force and a
> long comment explaining why you cannot just use memcpy_to_io()
> instead. At that point, you are already better off usingn memcpy_to_io() ;-)
We don't want to allocate to intermediate memory and do another memcpy 
just to write to pcie.
I will have to look into the linux request_firmware_info_buf code and 
detect whether the buf being request to is
in kernel or io memory and perform the operation there.  Hopefully such 
is possible.
>
>          Arnd

