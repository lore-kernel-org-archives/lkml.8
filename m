Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2481C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F4DD22C9D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="InuP5ggH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgGTKiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 06:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbgGTKiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 06:38:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3735CC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 03:38:13 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a14so2459713wra.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 03:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N+KShEFnJxGX9yyx1xEF9LSqKvHu0acMJ8Lfm+hfvF0=;
        b=InuP5ggHa1/pALofoPR9I3mpWK6lk35q8MGa+FJ0Cza+bBiYtFfAfJifs5zPiJVAKO
         CSLgdxPzxyqBiXe2uGN/mkOvmK79TKhwicrYic0fPSwbvA1F2oYSeo6BnetKrChAk48K
         RphsMD8e2J70zfqCIDM8f8/BX73vUE0Z2Ia+w26NKh8JaxhJndQox54CkzJLPm91UjXc
         DczOioE6l7MGFL2/aBhgWuSQP6Va27Dm3aIXNq//YPAH0ckPXiXknmAjFN1Bo4N8Oyob
         HjJp9feTK7Mg2/cI61mhCw7+gbtK7C6kpJ+P/DHeZGYRrsZfJ8RoYMxCiT2cGVJ3rtfD
         ISlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N+KShEFnJxGX9yyx1xEF9LSqKvHu0acMJ8Lfm+hfvF0=;
        b=sOd90OvFWglGMqqbnBLASJVZAJBU2qzMNdCKO9g2VDA67UTzNc4zu+O+p44DLL8H+D
         kWFMY4sr2wZTgm+/CKtqH6PGQN/dhAu7lRG08HSuK2r4trfGQGNy+FwGKakbU2iqy93+
         Eq57dwVsUi2cPEEy8b1BXiPpe6yxWnJ/gjUpkXs8Iu/yyXRV+04QkXc17OO53eGzKw8I
         dfWIDKNOxIhI6RpsUtTn94vifZL6/9XQY71RkgX3O6v76B/mLQOwxGPIGjyOffkx8O33
         YbXdt357ZAHuX/L32n3GZcKwEwVIhDaFRngw23LJJQHhE1nfwFjsKEYSiul7MduFO15N
         reVw==
X-Gm-Message-State: AOAM530XSePSuszVUaxRr//1EVj7FRFQdOAtb+sZXYEIxeNTX+RBlTf8
        sbB20qwQ2DMAHVUqxZQ8IL6pbg==
X-Google-Smtp-Source: ABdhPJw1/id93mBovoy22Lfk5BHPwv61GWmvOT4Bygs+7ogCIaqufAY1PEFM0xd4XmzTqhaH/IU8vg==
X-Received: by 2002:a5d:548f:: with SMTP id h15mr5097677wrv.331.1595241491766;
        Mon, 20 Jul 2020 03:38:11 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:3590:b402:869a:11fc? ([2a01:e34:ed2f:f020:3590:b402:869a:11fc])
        by smtp.googlemail.com with ESMTPSA id t141sm33345477wmt.26.2020.07.20.03.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 03:38:11 -0700 (PDT)
Subject: Re: [PATCH v4 08/16] thermal: sun8i: add TEMP_CALIB_MASK for
 calibration data in sun50i_h6_ths_calibrate
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Frank Lee <frank@allwinnertech.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?6buE54OB55Sf?= <huangshuosheng@allwinnertech.com>,
        liyong@allwinnertech.com
References: <cover.1594708863.git.frank@allwinnertech.com>
 <b8761e036b25f20873534e5f8d10b37b5d2ce72c.1594708864.git.frank@allwinnertech.com>
 <4771acd6-ecd3-b8e1-8605-75d78720b1d3@linaro.org>
 <CAEExFWv9_1kec_b+t+nnvT3cziXzmVa8GzJT3pQAZiCf4KA0ig@mail.gmail.com>
 <836e1b23-1c75-57fe-6e45-f7141272071c@linaro.org>
 <CAEExFWsJBizFArd+9Mh6D=o6rvD7GLPZ-1pNFzTvBiE+uKwVhQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c1491845-ebd0-27d2-cf50-a8c5847869ab@linaro.org>
Date:   Mon, 20 Jul 2020 12:38:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEExFWsJBizFArd+9Mh6D=o6rvD7GLPZ-1pNFzTvBiE+uKwVhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2020 11:27, Frank Lee wrote:
> HI,
> On Fri, Jul 17, 2020 at 3:56 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 17/07/2020 09:35, Frank Lee wrote:
>>> On Fri, Jul 17, 2020 at 12:26 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 14/07/2020 09:13, Frank Lee wrote:
>>>>> From: Yangtao Li <frank@allwinnertech.com>
>>>>>
>>>>> For sun50i_h6_ths_calibrate(), the data read from nvmem needs a round of
>>>>> calculation. On the other hand, the newer SOC may store other data in
>>>>> the space other than 12bit sensor data. Add mask operation to read data
>>>>> to avoid conversion error.
>>>>>
>>>>> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
>>>>> Reviewed-by: Yangtao Li <tiny.windzz@gmail.com>
>>>>
>>>> Can you clarify these SoB ?
>>>
>>> Previously I used 'Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>',
>>> maybe this should be removed directly?
>>>
>>>>
>>>> Frank Lee==Yangtao Li==frank@allwinnertech.com==tiny.windzz@gmail.com ?
>>>>
>>>
>>> Yeah.
>>
>> You are not supposed to add reviewed-by yourself. Please remove it.
> 
> Should I resend the entire series or just the thermal patch?
> What about those that have been applied.

I can not speak on behalf of other maintainers.

The simplest would be to ask them directly.

If you want to go forward with the thermal changes, you can send them
separately but Maxim's Ack will be needed anyway.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
