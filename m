Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C78C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E5E4207DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599594911;
	bh=I0G8YPmAGfHI9oVnXnhT6zK+vohuKECpT4ROo69X7KM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=V43bDmAXABFO90FA9y7RnT9RNGAxNcAfCQmYKpX1FL5EjxNtnLmG8DwExC2uAgTpa
	 Or6RLw6gx65oRI3l2qLqYc5+hMpyKFHG4oGUwmKILMz4wDWYB96m2MX/QGjEssoA4v
	 5YqZpA8POLW48PXuuqGNBd192khp8u003gJ685sw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbgIHTzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730627AbgIHPhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:37:36 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284ECC0612FB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 08:24:58 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id m25so4030983oou.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 08:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G6ViLODgIVrthYfKcZQ7FI0bgtyUL4tDP++rqJGkVeI=;
        b=iarUR/yb8+vhpB9MCNX6sNi5tVLKL2hEF2c1YCH4ZGlP4A40m00LY0Zan7YWLCbFRG
         iWHZSUVOrXv0/h/LB4Su9Vv8y7LSofbP/248L+GszV9UVPREAJfzDqoWiASfyTqkZGBL
         KtfIvLB+ozrc3BjhRT6aaqpOKhEpTc5jQbkB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G6ViLODgIVrthYfKcZQ7FI0bgtyUL4tDP++rqJGkVeI=;
        b=JTQrm6Tsnrnt4EWKPJg3HtKYjlYAAImM+zujF0Dz7Fce9+7Rw897etCMcqdEeScJy3
         e44u/ne3hdoK9e9BWJb/spMbF6lfJFdLwpJ8HCGg9DM93T/5CBWdtOea2NI1xdvVjnQY
         kwCiuE2ZujksombqvsDVL91QGCNs2mnGx/sH4ZSLagznT+WNlivY6MRmXqJnUfAxTK5+
         Vk8D9Lu4hGlKu15Euh80ogjtDNBHJ4VqNn5P+tZAi4UUWhrf2CvTKAHgPhyzPmitSMq1
         iQDHLIisMfIVvHy7shgSgTIA7d32Mo4d17AU0BAzMVCjINfwk656Nb2G/n48tNgWZpTu
         CpAA==
X-Gm-Message-State: AOAM532XVg0YkSnzK/gJAb+AwOirbi+E4u/LWfvGDpzvGA/iNUkc47F7
        +Wdt6lVqXNxrJSJWGlvoxmnVxw==
X-Google-Smtp-Source: ABdhPJz0UryFsak7mYC/o6Xu1t/X6pyxx8YadpYswTqzZPW/lHGfpm0d5irxqSu6eKaOpBwWpU7mpg==
X-Received: by 2002:a4a:81:: with SMTP id 123mr18910109ooh.80.1599578697111;
        Tue, 08 Sep 2020 08:24:57 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q14sm162188ota.41.2020.09.08.08.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 08:24:56 -0700 (PDT)
Subject: Re: [PATCH v6 00/20] gpio: cdev: add uAPI v2
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200831032006.1019978-1-warthog618@gmail.com>
 <CAMpxmJUETJgmxzWzHumOVr+vWFQ27P71MtcdSdf_=jvtrSfRPg@mail.gmail.com>
 <20200903083750.GA17445@sol> <20200904125250.GA323947@sol>
 <CAMpxmJWVZ8Bf1gPibvbk=E5XNvQ_i76E430MMhUWwE1ACoPTQg@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9db62b42-9a1e-0264-e88c-e636004cb629@linuxfoundation.org>
Date:   Tue, 8 Sep 2020 09:24:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMpxmJWVZ8Bf1gPibvbk=E5XNvQ_i76E430MMhUWwE1ACoPTQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/20 7:02 AM, Bartosz Golaszewski wrote:
> On Fri, Sep 4, 2020 at 2:52 PM Kent Gibson <warthog618@gmail.com> wrote:
>>
>> On Thu, Sep 03, 2020 at 04:37:50PM +0800, Kent Gibson wrote:
>>> On Thu, Sep 03, 2020 at 10:02:04AM +0200, Bartosz Golaszewski wrote:
>>>> On Mon, Aug 31, 2020 at 5:21 AM Kent Gibson <warthog618@gmail.com> wrote:
>>>>>
>> [snip]
>>>>
>>>> To me it looks good, just a couple nits here and there and some questions.
>>>>
>>>> I think it's worth deciding whether we want to keep the selftests in
>>>> tools/testing/selftests/gpio/ and then maybe consider porting
>>>> gpio-mockup-chardev.c to V2 or simply outsource it entirely to
>>>> libgpiod.
>>>>
>>>
>>> Ooops - I wasn't even aware they existed - though it had crossed my mind
>>> that the kernel should have some selftests somewhere - I use the libgpiod
>>> tests, from my libgpiod port, and my own Go based test suite for my testing,
>>> as well as some smoke tests with the tools/gpio.
>>>
>>> The libgpiod tests only cover v1 equivalent functionality, while my Go
>>> tests cover the complete uAPI, and both v1 and v2.
>>>
>>> It would be good for the kernel to at least have some smoke tests to
>>> confirm basic functionality, even thorough testing is left to a
>>> userspace library.  So the existing tests should be ported to v2, though
>>> should also retain the v1 tests if v1 is still compiled in.
>>>
>>
>> I've got a v7 ready to submit that includes a couple of patches for the
>> gpio-mockup selftests (their primary purpose appears to be testing the
>> mockup module, rather than the GPIO ABI), but I now notice that the
>> selftests/gpio section of the tree has a different maintainer:
>>
>> scripts/get_maintainer.pl 0021-selftests-gpio-port-to-GPIO-uAPI-v2.patch
>> Bamvor Jian Zhang <bamv2005@gmail.com> (maintainer:GPIO MOCKUP DRIVER)
>> Shuah Khan <shuah@kernel.org> (maintainer:KERNEL SELFTEST FRAMEWORK)
>> linux-gpio@vger.kernel.org (open list:GPIO MOCKUP DRIVER)
>> linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
>> linux-kernel@vger.kernel.org (open list)
> 
> Bamvor, Shuah: do you still have interest in maintaining these, or can
> we update MAINTAINERS?
> 

I maintain kselftests and gpio selftest falls under that. Please send
selftest patches to me so I can review them.

As for the gpio mock driver and test itself, you will have to wait for
Bamvor to respond.

>>
>> The v7 patch up to that point restores the functions that the selftests
>> are using so that they build and run again.

This test has been problematic because of its dependency on tools/gpio.

>> So I should hold off on the selftest patches and submit them separately
>> after the GPIO changes are in?
>>

Please send me the selftest patches. Also see the comments in
selftests/Makefile about excluding the gpio test from default run.

thanks,
-- Shuah


