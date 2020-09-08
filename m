Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C204FC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DBD821D1A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="O0Fz0vqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgIHHTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729330AbgIHHST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:18:19 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABA9C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 00:18:17 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id q9so16213144wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 00:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BnZLlR/MqannyWzL/NE/WCFqx90iIATvWssNkndAyuw=;
        b=O0Fz0vqVen5yD+ixiiv6Iil1A9arYyZHXu45/ldMkIihqHbX6OTNifTm1rtv3DDvOW
         WyAFYIb5x77WHNfLxod0m48U/xo74yrRuiwojICLINLDChoNBl0jPeScM/mx4yEFUTrU
         bg/veOxJBJKVRO/i15Ev9WzsjplgPRjNY7yMQxJJT/gufQ5WKbo7qdYGwc8dtIme62VQ
         3pPQDEtexpP1n1MZXPOQgBFDjTkxlPHHwpbhpAokREfd8TqVd2tpY+HkQPxD4Kn58KW2
         TEhIWKbyAiUmfpbCT+kaCuunbLRett5rXNZ19Sk1dyaJCHwQInhoRQiXsFu2zNATHtDR
         Y8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BnZLlR/MqannyWzL/NE/WCFqx90iIATvWssNkndAyuw=;
        b=umJ4GKYeJTDkzpzAW3nN9HXMl+rFccX+wGcfHO8EoWPAGOLroqdpk6tXWopdNjwSOE
         vaM4Qyh5UkGplYecNOr0jIyIuwnwZGfW05pcXPvthhdPScaEDQOHc8GI3yXA7VodJp7f
         uyxYYidPYCsSjwJdWQ6XIyuk9VtAZkWihJAgwd4WPCivnzNGlgOlDNG8oqstIT4ee9QN
         U8IJhvLN9POar+OpQ1Rsnmlhhm3QPF7mYEKXKCwzrYCAVtSQ3sM2YWM6ePeQWRJEbEXY
         83f1+9DrwseqJLj5ycI3oKC3JsWPO8MBSjcdHRsaDotzqn8Ks7ASU8HRCzS+0I+rF4AH
         IZsA==
X-Gm-Message-State: AOAM532JYYMxPzjk6nmO+cPDh9kWZKucXm4mWkMvqFoP/iBpKJfEiz5y
        k8+f4i7pndkWCo9Lzmc5O6ulTQ==
X-Google-Smtp-Source: ABdhPJzj1ecX+gU9LYQBG52HZN4YgLlObJ5QS6k25m00eZqK7euxQxVeZuSFQQDbipQ15acvDmqz+A==
X-Received: by 2002:a1c:1fcc:: with SMTP id f195mr2744223wmf.127.1599549492849;
        Tue, 08 Sep 2020 00:18:12 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac? ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id k8sm32317392wma.16.2020.09.08.00.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 00:18:12 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIIHYyIDYvNl0gZHJtL3BhbmVsOiBBZGQg?=
 =?UTF-8?Q?Ilitek_ILI9341_DBI_panel_driver?=
To:     Paul Cercueil <paul@crapouillou.net>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        =?UTF-8?B?5L2V5bCP6b6Z?= <Leon.He@unisoc.com>, od@zcrc.me,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20200822163250.63664-1-paul@crapouillou.net>
 <20200822163250.63664-7-paul@crapouillou.net>
 <edf38d68214247f486db3cc1f81ec404@shmbx04.spreadtrum.com>
 <COYVFQ.2IA7KFB6BF4C3@crapouillou.net>
 <20200830191133.GB6043@pendragon.ideasonboard.com>
 <20200830202822.GA950472@ravnborg.org> <5BHAGQ.KGFJ0K3OLEAO3@crapouillou.net>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <cf46c61b-1517-3009-cb92-a86e970dccc0@baylibre.com>
Date:   Tue, 8 Sep 2020 09:18:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5BHAGQ.KGFJ0K3OLEAO3@crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2020 14:57, Paul Cercueil wrote:
> 
> 
> Le dim. 30 août 2020 à 22:28, Sam Ravnborg <sam@ravnborg.org> a écrit :
>> Hi Laurent.
>>
>>>  >
>>>  > Please read the cover letter, it explains why it's done this way. The
>>>  > whole point of this patchset is to merge DSI and DBI frameworks in a
>>>  > way that can be maintained.
>>>
>>>  I think this proves the point that the proposed naming is confusing. At
>>>  least a rename would be required.
>>
>> Do you have any inputs on the amount of rename we are looking into.
>> Is this a simple s/struct mipi_dsi_device/struct mipi_dxi_device/
>> or something more?
>>
>> We should script the rename as it will tocuh a lot of files,
>> and without a script we would chase this. But once it is scripted
>> it would be trivial to perform.
>>
>> I did not look at this enough, but I had an idea that we
>> would have do to a s/dsi/dxi/ in a lot of places.
>>
>> (dxi is my best proposal at the moment for something covering both dsi
>> and dbi).
> 
> dcs?
> 
> Since DBI and DSI panels generally all use DCS commands.

mipi_disp / mipi_display ? since it's all about mipi display interfaces
with different transport protocols.

Neil

> 
> -Paul
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

