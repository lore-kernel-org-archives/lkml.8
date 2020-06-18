Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5EDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D2F21852
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iGrcbBhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgFRIHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgFRIFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 04:05:53 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83B6C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 01:05:52 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g10so4238820wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 01:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J2P4KBeBVJFsQpvXTMn3UFoEhQaQEz0OzmITSUrph+k=;
        b=iGrcbBhGhHQ7Yp78sT9XYD5gnQb8zLcNX2E++DMQRtVSdZkuOMhsCY7eHb++j+NZ+M
         43bP8ooOmivRJ0UJeVjOVRE8kqwGUcBw9gW6Ci1SHMNd0e+OqcA9i5iVfiYNZL5SI9ia
         Dao0bP4oX/prcLfy7RvPGRL28+H7pOrPHCWd2inm6dcMpR1Kg9b8kuxkGOmy8xjjTo4d
         zmidEuvhhMtAngCXZvFOVqG3wH0aOYB17UvWmii4XwaAQdjWbBwYHYzsWIbCpDjaPtrv
         C4hO+m1Dd8EYX+SNuVc0PYfRE6CV8fjlWAPZy6UuL6YznVBThIfEDG9GHwbIOyoOXoUM
         h2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=J2P4KBeBVJFsQpvXTMn3UFoEhQaQEz0OzmITSUrph+k=;
        b=eBj1ZEU7u1/arHTsIvuZoFnWNRhjXRMhzwc2b97SM1pvPMS36YhxFsePj7gRLUqOF8
         f3miMckuguKP029BjG0sKgtedSBg0f3Va51RhYj3tIFXZM/ek/9eod0c5Qun9Mtd0L7e
         hgOx+azOXnJp1M0lkvxr1gd8XB6RiWuzIdFfONnnUGF13vP6MGiZDJBcvskdgCImSZ16
         EM6D8f7lZBQDYj8Ht17mRe7NatGXfIg0SiRmegAP/KPSSYqieIU5BZmvLvnVQEGvS4Rq
         PtktjP+/eg3yC53yip9gfDqLPNtVzrPyPcBd+3P3zRyDZM6xEw0Qu6HbECEqRQ3uQvdA
         rmyQ==
X-Gm-Message-State: AOAM530O//kribHriD8TYfPmZmSXGAYbWp8KvF1uAR8DwoO1t8yG/Xzd
        93X0A1JgO8kndiTN5ma2z67br3gJGUGMBw==
X-Google-Smtp-Source: ABdhPJyKF2YVQ2af0HBuvWK8IKhsQTdcg0atn/l8fDapEmRF0oEenQ6aEEYol/gk/64PsK9g5fH8Ew==
X-Received: by 2002:a1c:60d6:: with SMTP id u205mr2847110wmb.163.1592467550784;
        Thu, 18 Jun 2020 01:05:50 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:9902:c1f0:76c7:9dbc? ([2a01:e35:2ec0:82b0:9902:c1f0:76c7:9dbc])
        by smtp.gmail.com with ESMTPSA id c16sm2530606wml.45.2020.06.18.01.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 01:05:50 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] drm/bridge: ti-sn65dsi86: Don't compile GPIO bits
 if not CONFIG_OF_GPIO
To:     Doug Anderson <dianders@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sean Paul <seanpaul@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Sandeep Panda <spanda@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200612123003.v2.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid>
 <CAD=FV=W6d-Asap63+MDga26k2krfNOZ4ftcM1HPp3T0oXWdA0A@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <cc184761-eb91-402f-c2df-c55d25274b66@baylibre.com>
Date:   Thu, 18 Jun 2020 10:05:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=W6d-Asap63+MDga26k2krfNOZ4ftcM1HPp3T0oXWdA0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On 15/06/2020 16:36, Doug Anderson wrote:
> Hi,
> 
> On Fri, Jun 12, 2020 at 12:31 PM Douglas Anderson <dianders@chromium.org> wrote:
>>
>> The kernel test robot noted that if "OF" is defined (which is needed
>> to select DRM_TI_SN65DSI86 at all) but not OF_GPIO that we'd get
>> compile failures because some of the members that we access in "struct
>> gpio_chip" are only defined "#if defined(CONFIG_OF_GPIO)".
>>
>> All the GPIO bits in the driver are all nicely separated out.  We'll
>> guard them with the same "#if defined" that the header has and add a
>> little stub function if OF_GPIO is not defined.
>>
>> Fixes: 27ed2b3f22ed ("drm/bridge: ti-sn65dsi86: Export bridge GPIOs to Linux")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>> ---
>>
>> Changes in v2: None
>>
>>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
> 
> The kernel test robot gave me another yell over the weekend.  I think
> the whole series is ready to land, but if nothing else could at least
> patch #1 land to fix the build error so the robot is happy?

I'm pushing the serie to drm-misc-next

Neil

> 
> -Doug
> 

