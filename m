Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F4DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D61520663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SAidnYTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389621AbgF2Ul5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731666AbgF2TOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:06 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5792EC008756
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:41:51 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q15so14548643wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kELMG7Ol5vjIMHU3qC+BQXaaTJ8E8QYQvAWRNYeed9M=;
        b=SAidnYTvCAvw4nM9pKaVGyUWYh4lBZdMjgSCjmPpa9D3LQBrQUc3RCKehpb6PKqggZ
         TeaOqMvp6dCVKftm/uw0GaG8yXAySh/iP6DzwlDk2xCIwxhqxWoWKTW+iJ1pcCaOZfbB
         DpZKB/oMAPAc3h6cmL+d2DN+Xo5dvzwAOBpglwMqaLhgudXwT45k2EN4EBQ3wKzjeCEj
         q8iYSAM/hObjr4f78K4bmXmnCpKibZwbyiHAfSkWy3P+T72ouT3J3oje0riSVe13LDQX
         WTI0E2PYLcV57jEmExGhOdtznJuDkUL5Gy6hx/fV9er78GznjRIovETaeom4xFrtDaFP
         JG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kELMG7Ol5vjIMHU3qC+BQXaaTJ8E8QYQvAWRNYeed9M=;
        b=RpZgy5UGKv2mzsKVd/nwsaNhrm0DVKClg2y6XJvulc8zcxHm3u4wIi9maMbP8V1H9u
         ksnIoo/XetLfuFfYx5yTZxy4Snn4Ppo7KN/3yxFQHRprM8zBQqyhHQOoywp8wHDZjs1A
         WfgfWOctbT7hLVr4Qj28l9YgwzvmU8GEkk29aWoG+dSbO+R+lXadv+bicLg9rTBv0Cw/
         +1kT6XKc0moAv0aQZYdSZ/F4DZEBariq/hPc1gTd0hGQSbeJIjpZu2L53TbxHh5bBsdX
         dH8WFywaCygFS19JEEIpvtYDBJLnGlSdCW3oWTUeLoDYqfNuMvu6WJ+sA1/6G3VcTZX2
         kjng==
X-Gm-Message-State: AOAM533FiLCxtTqOWRiZWh5eQDQScvuCAr2ZxSKtedCssevZMv7nTcF+
        utUstQQRChmgHxpphhU7kU0rsqjRREJeQQ==
X-Google-Smtp-Source: ABdhPJyIgWKnLVqOjW/TXd55cHSZefw2qzWi6tfdjxbEZPy9CjFBYVBt8aaWScCDu9aOFYS3XT3bmQ==
X-Received: by 2002:a1c:b6c3:: with SMTP id g186mr16279573wmf.135.1593420109557;
        Mon, 29 Jun 2020 01:41:49 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:9902:c1f0:76c7:9dbc? ([2a01:e35:2ec0:82b0:9902:c1f0:76c7:9dbc])
        by smtp.gmail.com with ESMTPSA id r1sm14414094wrw.24.2020.06.29.01.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 01:41:48 -0700 (PDT)
Subject: Re: [PATCH 4/4] drm/bridge: ti-sn65dsi86: Check the regmap return
 value when setting a GPIO
To:     Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sandeep Panda <spanda@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200608104832.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid>
 <20200608104832.4.Ia4376fd88cdc6e8f8b43c65548458305f82f1d61@changeid>
 <159186950406.242598.11120838219466948342@swboyd.mtv.corp.google.com>
 <CAD=FV=Xt8AdnemnKLgxwkC-W=LWC06OU9x20RszXPLfAvUm9Og@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <e454746a-8137-a26f-d6ba-ca30adec036c@baylibre.com>
Date:   Mon, 29 Jun 2020 10:41:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Xt8AdnemnKLgxwkC-W=LWC06OU9x20RszXPLfAvUm9Og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2020 16:34, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jun 11, 2020 at 2:58 AM Stephen Boyd <swboyd@chromium.org> wrote:
>>
>> Quoting Douglas Anderson (2020-06-08 10:48:35)
>>> The ti_sn_bridge_gpio_set() got the return value of
>>> regmap_update_bits() but didn't check it.  The function can't return
>>> an error value, but we should at least print a warning if it didn't
>>> work.
>>>
>>> This fixes a compiler warning about setting "ret" but not using it.
>>>
>>> Fixes: 27ed2b3f22ed ("drm/bridge: ti-sn65dsi86: Export bridge GPIOs to Linux")
>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>> ---
>>>
>>>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
>>> index 1080e4f9df96..526add27dc03 100644
>>> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
>>> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
>>> @@ -999,6 +999,9 @@ static void ti_sn_bridge_gpio_set(struct gpio_chip *chip, unsigned int offset,
>>>         ret = regmap_update_bits(pdata->regmap, SN_GPIO_IO_REG,
>>>                                  BIT(SN_GPIO_OUTPUT_SHIFT + offset),
>>>                                  val << (SN_GPIO_OUTPUT_SHIFT + offset));
>>> +       if (ret)
>>> +               dev_warn(pdata->dev,
>>> +                        "Failed to set bridge GPIO %d: %d\n", offset, ret);
>>
>> GPIO %u because it's unsigned?
> 
> Sure.  I'll plan to spin tomorrow in case anyone else has any
> feedback.  If any maintainer would prefer me not to spin and would
> rather fix this when applying, please shout and I won't send out a v2.
> 
> -Doug
> 

Yes please respin, ping me on IRC if I forget to apply..

Neil
