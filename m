Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BC8C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95CBC20678
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Au1hdPOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgIBPgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbgIBPEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:04:11 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19C4C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 08:04:10 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u27so3002819lfm.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 08:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HiRuvEqiDybiJUKnUKiZbLHW27tCpis/5RkIzrkHyvo=;
        b=Au1hdPOdNIbnCYpc+FLW9mZRqKSHvtM+vgh+N4KBowy5CcPX/wQUuP+eje+4rBDV97
         KLY8Kl0WTPfeSKKVoG/1cEjdeulfTk5gAubbP8GjeQdR6EUdkrw2/u3vjqVv6HYHYyaG
         WSLEehcUXt3DyHr3q/aW5DXqOEx7vfpub51115femkpKFHwLy9ilrHZqsmX1mCCzGqn8
         VTsd3YgRZHT7z5a7xKFOfIwEN6K7sq97i2EIJ/jKTqQjxEfSXbuTjtIuby3QJlwAIU57
         46larQEoVCARsd8r0SZGoHjbROrK0RTqOutlxzjXqd86ChXEC6q2B7y6y6uQ2vmt5bcb
         /XKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HiRuvEqiDybiJUKnUKiZbLHW27tCpis/5RkIzrkHyvo=;
        b=Lav9ltkTDO+4HZ93Wu1psVNTxRWvHzf29a5ZGCE5wRkgosfLYfz31T5FiRel1rgxiW
         s7UDstvKVbNd2nNWbKcx0FbdYKck1fWGIHqBOoXpnWaUoctNqbAyPygItAS/Jt8OjiVO
         JbfM0dY3wCxEljtySSxvsEBoGzz3lGFO4Llm39B1IlAdf+PqRlfYq2VkSUdErvrrbnUR
         vJaSFQUaiG4cmlnRX9PUgW+S0ASXtWIX40+vXv5CQ158lEoqC4NGpKHRO0uynuOL4nzq
         yZf9rJa4RvWH4s1GZOKRfWgFznJcMJCi2ab24lXBLjjeW5PbAsN2nWaLQH8GvqaIdAH5
         3rpw==
X-Gm-Message-State: AOAM530B+gYNCkaBMPMBqGPfVn+waVxskPnHv51piwqSbaOZz2M2RTdK
        Py/lYEU3rkd780+R2XpqDc73KXagf6M=
X-Google-Smtp-Source: ABdhPJx8ndplM70w/fPRT5dyH8UCnjgErnKyqRBblhHDssYwRQAzG/NJAjHCxq/73tuRAqw/oVgIHQ==
X-Received: by 2002:a19:e57:: with SMTP id 84mr3257500lfo.161.1599059048792;
        Wed, 02 Sep 2020 08:04:08 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id a21sm1027224ljh.114.2020.09.02.08.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 08:04:08 -0700 (PDT)
Subject: Re: [PATCH v1] regmap: Add can_sleep configuration option
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <CGME20200902142057eucas1p245e94459d5adcd9cc4c38617da1abfc8@eucas1p2.samsung.com>
 <20200902141843.6591-1-digetx@gmail.com>
 <8dfcf671-d76a-4833-3fe9-2d0505d1b0d3@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <81c91dbe-312e-5394-da1d-a6965e8fcb56@gmail.com>
Date:   Wed, 2 Sep 2020 18:04:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8dfcf671-d76a-4833-3fe9-2d0505d1b0d3@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

02.09.2020 17:53, Marek Szyprowski пишет:
> Hi Dmitry,
> 
> On 02.09.2020 16:18, Dmitry Osipenko wrote:
>> Regmap can't sleep if spinlock is used for the locking protection.
>> This patch fixes regression caused by a previous commit that switched
>> regmap to use fsleep() and this broke Amlogic S922X platform.
>>
>> This patch adds new configuration option for regmap users, allowing to
>> specify whether regmap operations can sleep and assuming that sleep is
>> allowed if mutex is used for the regmap locking protection.
>>
>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Fixes: 2b32d2f7ce0a ("regmap: Use flexible sleep")
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> This fixes the issue I've reported. Thanks!
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Awesome! Thank you!
