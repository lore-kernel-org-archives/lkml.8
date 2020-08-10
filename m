Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81425C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 00:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C1E8206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 00:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBU2Rmmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgHJAVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 20:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgHJAVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 20:21:50 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FD4C061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 17:21:50 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h8so3793032lfp.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 17:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P/ypPDyRPbCocww+YFXAuHCLF+0kpPQwbXzkE6ttE/Y=;
        b=XBU2Rmmg0TsRVZ76/PqiHpNNtcQvigRFiiGwNRKu/VoeJsv9IPVAGHYMz/PEKPv3WB
         ZKJv7C/cWl2LmtC/iFbkZ4w9uKWiAXIexssMhkeabZaptSP0wK8p85osz0vMW8eDMpH3
         EqhbZUep83r0kb4wDLLhKWXr66e1YraeVCwP0FO2+oQxa1VmFKzk+oz/5mEvOnJ5F5/w
         9Kyf39z8bHprOW5cy8Joh21ZhRDmPcbaakJFffBlhEkZOdbb6K+aBnwl9dicday8vZP2
         zY30SbeC94gaZ/wFNuQcHcyrqgkxH2hgvvWgx4y+Eyabgvd3Lmegr4qq2A3A2AiurLZQ
         iLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P/ypPDyRPbCocww+YFXAuHCLF+0kpPQwbXzkE6ttE/Y=;
        b=lHztYgSCltMiOWYVMjDEhXdy3YgbIHBmf30vRJHJPLbNjOPpMkCRE4tHeTbXcnON4Z
         RRsnJ4UtgvGlzySJ+HGRQzZJztohTymv5UIjWXjdw2ivokr1cV3z3U+UPJBf9zmNEhav
         OIzJ6xyRz5HT/Bo68qI+b9cZbeGNIe7Az2GxipLQsCunR4mwXO4jIOOaR9e4O9C/JOJn
         BSLlT6w1KWcMm1krmVBzF0Z1a0XH51vc6L5muUvb0mE4IiGuEAKCIZ7pj92A1VjUtQTF
         zo3FDUMLUG3txr2jVXWn5k4UU71ZY6IAYg2ghLSm0R3a/DB6Msq+jLSj1Q3hYbq1hvi4
         BDew==
X-Gm-Message-State: AOAM532gYrdZLZvPszdPkwV8JbpAJMAO5okzNu0VSbhZgzvZ1SFPJHYh
        daR2ROlYEH+0yDpqnNEObotYi0nf
X-Google-Smtp-Source: ABdhPJxYWB6lpCXNwdIn/2Js4jZyiTW7F3z0SVygCQh/G1+a5mvNQ6MGzIJmGHELLiGyZxDh7sd/VA==
X-Received: by 2002:a19:814c:: with SMTP id c73mr11508672lfd.16.1597018908388;
        Sun, 09 Aug 2020 17:21:48 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id b15sm2422214lji.140.2020.08.09.17.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2020 17:21:47 -0700 (PDT)
Subject: Re: [PATCH] regulator: simplify locking
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <b22fadc413fd7a1f4018c2c9dc261abf837731cb.1597007683.git.mirq-linux@rere.qmqm.pl>
 <40871bc7-2d6c-10d4-53b3-0aded21edf3b@gmail.com>
 <20200809223030.GB5522@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8850c09f-4b24-7ab2-a0f7-e0d752f5a404@gmail.com>
Date:   Mon, 10 Aug 2020 03:21:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200809223030.GB5522@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.08.2020 01:30, Michał Mirosław пишет:
> On Mon, Aug 10, 2020 at 12:40:04AM +0300, Dmitry Osipenko wrote:
>> 10.08.2020 00:16, Michał Mirosław пишет:
>>> Simplify regulator locking by removing locking around locking. rdev->ref
>>> is now accessed only when the lock is taken. The code still smells fishy,
>>> but now its obvious why.
>>>
>>> Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
>>> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
>>> ---
>>>  drivers/regulator/core.c         | 37 ++++++--------------------------
>>>  include/linux/regulator/driver.h |  1 -
>>>  2 files changed, 6 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
>>> index 9e18997777d3..b0662927487c 100644
>>> --- a/drivers/regulator/core.c
>>> +++ b/drivers/regulator/core.c
>>> @@ -45,7 +45,6 @@
>>>  	pr_debug("%s: " fmt, rdev_get_name(rdev), ##__VA_ARGS__)
>>>  
>>>  static DEFINE_WW_CLASS(regulator_ww_class);
>>> -static DEFINE_MUTEX(regulator_nesting_mutex);
>>>  static DEFINE_MUTEX(regulator_list_mutex);
>>>  static LIST_HEAD(regulator_map_list);
>>>  static LIST_HEAD(regulator_ena_gpio_list);
>>> @@ -150,32 +149,13 @@ static bool regulator_ops_is_valid(struct regulator_dev *rdev, int ops)
>>>  static inline int regulator_lock_nested(struct regulator_dev *rdev,
>>>  					struct ww_acquire_ctx *ww_ctx)
>>>  {
>>> -	bool lock = false;
>>>  	int ret = 0;
>>>  
>>> -	mutex_lock(&regulator_nesting_mutex);
>>> +	if (ww_ctx || !mutex_trylock_recursive(&rdev->mutex.base))
>>
>> Have you seen comment to the mutex_trylock_recursive()?
>>
>> https://elixir.bootlin.com/linux/v5.8/source/include/linux/mutex.h#L205
>>
>>  * This function should not be used, _ever_. It is purely for hysterical GEM
>>  * raisins, and once those are gone this will be removed.
>>
>> I knew about this function and I don't think it's okay to use it, hence
>> this is why there is that "nesting_mutex" and "owner" checking.
>>
>> If you disagree, then perhaps you should make another patch to remove
>> the stale comment to trylock_recursive().
> 
> I think that reimplementing the function just to not use it is not the
> right solution. The whole locking protocol is problematic and this patch
> just uncovers one side of it.

It's not clear to me what is uncovered, the ref_cnt was always accessed
under lock. Could you please explain in a more details?

Would be awesome if you could improve the code, but then you should
un-deprecate the trylock_recursive() before making use of it. Maybe
nobody will mind and it all will be good in the end.
