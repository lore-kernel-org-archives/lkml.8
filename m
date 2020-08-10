Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F9BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 05:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8842620734
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 05:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAPpfcwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgHJFOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 01:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgHJFOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 01:14:24 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A12C061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 22:14:23 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v4so8167230ljd.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 22:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sk7lsktJKJkZp7BIFhMAFoO+G3Ai31Ravpu0dNEI2/Y=;
        b=BAPpfcwF0obJu/FSy2u74Qya0T+g+dsJX+xbjJ0HCrfmPb79av3SKNd2dqJdgKh3B7
         h2y0l9KhADKMmu/cf5c6Py4nkBie5uc8oI3Yk1rm6cNTeHIJBXxPDARKXpbWJERSDvce
         mqGVA/AoSbMpgoOjAmkYrmPYpbNO5pXPvg212v87Tv5ckvl0sgW7JY6ISOydxrYkro2q
         Yigm6w/y2IEg5z2AWZcKfcVpeCKf0f6UuAGn2Hmc9MjYoZZI5T97sLs4zew4+Fq5n+NC
         +7zNwNA/DtfBdkTTyDQBrg41boxyZjVvEqI02DTy4Gf3l1+t+EUXJ4zDXXZS/00PEZfU
         u4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sk7lsktJKJkZp7BIFhMAFoO+G3Ai31Ravpu0dNEI2/Y=;
        b=j0mRHHARPomXDmYbTUzpP4FsYM5DqbUZLl2kI9aRHD1IpjF1lO2WRcR1cVyiNj/rzq
         swXTq6q8ZUdjgHDoAO3i0OlCitMsEK7yxhsMNE6QLi7e+DjLnCcFICUNHkr4guRfxurO
         nTVcoMyFQ3gOLGp//IlYnN3B87fmndMaaTuiBGUYiqS0Rz9rFqFHlF1GN3H9Nwn2Ks+J
         LrMpAmOSo66/mL6sFAOMdy3w+RJJ9i7t5A4rra1NCZTnQmj9KqSS1mN9s4y9qW4/bJl0
         TdFR45zf4LBH2dRM7bdLAuXowcxJw6C6oOUGO4MR//eZip9sO/qM5vVTVDy1d+RumBFM
         62Hw==
X-Gm-Message-State: AOAM5302ZOJ9EgeOJOiEgHekqxWPWyRFDIq/e0CutnC2f05KgN0ikjc9
        ie/T5k6b6K12mekIoeVh8I5uG4wI
X-Google-Smtp-Source: ABdhPJw6fzjWkx3sGRiBryZSOtRRaIZAolbn/+XA+5ONAliNd4Th7m7rXm2zRIKAY//4HYtCJLFzXA==
X-Received: by 2002:a2e:968c:: with SMTP id q12mr10920885lji.51.1597036462022;
        Sun, 09 Aug 2020 22:14:22 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id n29sm11028324lfi.9.2020.08.09.22.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2020 22:14:21 -0700 (PDT)
Subject: Re: [PATCH] regulator: simplify locking
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <b22fadc413fd7a1f4018c2c9dc261abf837731cb.1597007683.git.mirq-linux@rere.qmqm.pl>
 <40871bc7-2d6c-10d4-53b3-0aded21edf3b@gmail.com>
 <20200809223030.GB5522@qmqm.qmqm.pl>
 <8850c09f-4b24-7ab2-a0f7-e0d752f5a404@gmail.com>
 <20200810005927.GA13107@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <dc398754-f31e-9703-01b1-fec2d3a381cf@gmail.com>
Date:   Mon, 10 Aug 2020 08:14:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810005927.GA13107@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.08.2020 03:59, Michał Mirosław пишет:
> On Mon, Aug 10, 2020 at 03:21:47AM +0300, Dmitry Osipenko wrote:
>> 10.08.2020 01:30, Michał Mirosław пишет:
>>> On Mon, Aug 10, 2020 at 12:40:04AM +0300, Dmitry Osipenko wrote:
>>>> 10.08.2020 00:16, Michał Mirosław пишет:
>>>>> Simplify regulator locking by removing locking around locking. rdev->ref
>>>>> is now accessed only when the lock is taken. The code still smells fishy,
>>>>> but now its obvious why.
>>>>>
>>>>> Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
>>>>> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
>>>>> ---
>>>>>  drivers/regulator/core.c         | 37 ++++++--------------------------
>>>>>  include/linux/regulator/driver.h |  1 -
>>>>>  2 files changed, 6 insertions(+), 32 deletions(-)
>>>>>
>>>>> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
>>>>> index 9e18997777d3..b0662927487c 100644
>>>>> --- a/drivers/regulator/core.c
>>>>> +++ b/drivers/regulator/core.c
>>>>> @@ -45,7 +45,6 @@
>>>>>  	pr_debug("%s: " fmt, rdev_get_name(rdev), ##__VA_ARGS__)
>>>>>  
>>>>>  static DEFINE_WW_CLASS(regulator_ww_class);
>>>>> -static DEFINE_MUTEX(regulator_nesting_mutex);
>>>>>  static DEFINE_MUTEX(regulator_list_mutex);
>>>>>  static LIST_HEAD(regulator_map_list);
>>>>>  static LIST_HEAD(regulator_ena_gpio_list);
>>>>> @@ -150,32 +149,13 @@ static bool regulator_ops_is_valid(struct regulator_dev *rdev, int ops)
>>>>>  static inline int regulator_lock_nested(struct regulator_dev *rdev,
>>>>>  					struct ww_acquire_ctx *ww_ctx)
>>>>>  {
>>>>> -	bool lock = false;
>>>>>  	int ret = 0;
>>>>>  
>>>>> -	mutex_lock(&regulator_nesting_mutex);
>>>>> +	if (ww_ctx || !mutex_trylock_recursive(&rdev->mutex.base))
>>>>
>>>> Have you seen comment to the mutex_trylock_recursive()?
>>>>
>>>> https://elixir.bootlin.com/linux/v5.8/source/include/linux/mutex.h#L205
>>>>
>>>>  * This function should not be used, _ever_. It is purely for hysterical GEM
>>>>  * raisins, and once those are gone this will be removed.
>>>>
>>>> I knew about this function and I don't think it's okay to use it, hence
>>>> this is why there is that "nesting_mutex" and "owner" checking.
>>>>
>>>> If you disagree, then perhaps you should make another patch to remove
>>>> the stale comment to trylock_recursive().
>>>
>>> I think that reimplementing the function just to not use it is not the
>>> right solution. The whole locking protocol is problematic and this patch
>>> just uncovers one side of it.
>>
>> It's not clear to me what is uncovered, the ref_cnt was always accessed
>> under lock. Could you please explain in a more details?
>>
>> Would be awesome if you could improve the code, but then you should
>> un-deprecate the trylock_recursive() before making use of it. Maybe
>> nobody will mind and it all will be good in the end.
> 
> I'm not sure why the framework wants recursive locking? If only for the
> coupling case, then ww_mutex seems the right direction to replace it:
> while walking the graph it will detect entering the same node
> a second time. But this works only during the locking transaction (with
> ww_context != NULL). Allowing recursive regulator_lock() outside of it
> seems inviting trouble.

Yes, it's for the coupling case. Coupled regulators may have common
ancestors and then the whole sub-tree needs to be locked while operating
with a coupled regulator.

The nested locking usage is discouraged in general because it is a
source of bugs. I guess it should be possible to get rid of all nested
lockings in the regulator core and use a pure ww_mutex, but somebody
should dedicate time to work on it.
