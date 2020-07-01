Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC45C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 942CD20722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yChXw7M9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgGAHgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgGAHf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:35:59 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1AEC061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 00:35:59 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z15so11454480wrl.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 00:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uuJwNZbCJukOAxG04+bEWS+MLz2Rq8gWyM8D40COw3k=;
        b=yChXw7M9FFpaCgHzXPeEjg6Agoi5DJvvzkuLdDhKWaklgV/V8w1S0eCFEhS83ayX2B
         WF/5Smqdh5i19A58NL7uY9XiFmLFS/Db/gWZTcZ7WxiWMJsddOsI7WcGbKGUcTq40/D6
         NpzHFxlMMsObCd3jLFUQLS+mlhgjj2zKGH2KiLT9gnPRGnpTJMLa2pFe9/U3BG6Vyeh4
         MuVz/Ce4CQIvRMPa1YUww25zkQBlrXLqTpArkFBgITn9+di5Q8ploQM173ZrrWOfcTUq
         d8r66mBFTe8JtsclNqY9Ufq/72yEE/lBv5Dqz0+Jp/zJIDwT8Ww6OCBcouV9n/i+B7i0
         A2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uuJwNZbCJukOAxG04+bEWS+MLz2Rq8gWyM8D40COw3k=;
        b=MVP7OYzcPeDDro/L6U94lgM8qigZJdMJUynsWYQpZg5srwIkIGP8IjQQJ80FUXWwf+
         M2ZpsveCOYm26DDT+WcMestlyNQnr/Sx+njh91FSMUPirgiMix3ojIJeaQ9lhElvc+6U
         tmsq6CD6L0lnfLRqICizEVrvUTRR5jok8McTST+hz4pe6RbmLZugOgXJAlFv/e1uM3v2
         xY4UkTwsJILXE/JWK9lfgHpiuAIhU61ThXjAPk9DMakPA6aHoEM239vCN1xQk0wG6Afs
         RcqrtVxwCGC12p/xps0o3c5s0CFsqz/qlj18avdzZwQozBKu+CgHqq9ebhWMfcDfJtiv
         lpww==
X-Gm-Message-State: AOAM530z5uoloGQJGkmUB0Q1lA2MgFwUVCasM4zLoMr+ZQ0okwhm0KwW
        Y0blbDAW/6mtHcBclMffCo6A90H48vQ=
X-Google-Smtp-Source: ABdhPJzWgyKNmS0DgHxcetOgx5rfvGFYh3l3N2IHSclS5+IEdzswBdTlieFbYsUWpwFCRfc++1hTbg==
X-Received: by 2002:adf:f34f:: with SMTP id e15mr25731085wrp.415.1593588957853;
        Wed, 01 Jul 2020 00:35:57 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07? ([2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07])
        by smtp.googlemail.com with ESMTPSA id e5sm6588989wrs.33.2020.07.01.00.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 00:35:57 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] thermal: core: Add helpers to browse the cdev, tz
 and governor list
To:     Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
 <CAP245DVy+Z9D+6=-cX4TaGFoK-e2N+mWwOvNYOe_E9Fh=7vnaA@mail.gmail.com>
 <bed1d41f81f369e7123a2eab7fde3e81a3b063aa.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <143d954f-2ecf-c4d3-cb7d-f2ea75da8276@linaro.org>
Date:   Wed, 1 Jul 2020 09:35:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <bed1d41f81f369e7123a2eab7fde3e81a3b063aa.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2020 17:09, Zhang Rui wrote:
> Hi, Daniel,
> 
> seems that you forgot to cc linux-pm mailing list.
> 
> On Tue, 2020-06-30 at 17:16 +0530, Amit Kucheria wrote:
>> On Thu, Jun 25, 2020 at 8:15 PM Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>>>
>>> The cdev, tz and governor list, as well as their respective locks
>>> are
>>> statically defined in the thermal_core.c file.
>>>
>>> In order to give a sane access to these list, like browsing all the
>>> thermal zones or all the cooling devices, let's define a set of
>>> helpers where we pass a callback as a parameter to be called for
>>> each
>>> thermal entity.
>>>
>>> We keep the self-encapsulation and ensure the locks are correctly
>>> taken when looking at the list.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
>>>  drivers/thermal/thermal_core.c | 51
>>> ++++++++++++++++++++++++++++++++++
>>
>> Is the idea to not use thermal_helpers.c from now on? It fits
>> perfectly with a patch I have to merge all its contents to
>> thermal_core.c :-)
> 
> I agree these changes should be in thermal_helper.c

Oh, actually I remind put those functions in the thermal_core.c file
because they need the locks which are statically defined in there.

If the functions are moved to thermal_helper.c that will imply to export
the locks outside of the file, thus breaking the self-encapsulation.

Do you want to move them out?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
