Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D8AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9756D23E56
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdlRvIKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgFTQSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 12:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFTQSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 12:18:15 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B066DC06174E;
        Sat, 20 Jun 2020 09:18:14 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id k15so267065lfc.4;
        Sat, 20 Jun 2020 09:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y/B8+Wt8t65HyAHFIvqCHVw/CPSbL5JP5E6zK3iaABQ=;
        b=sdlRvIKhkaKKZTjU3Hr85BxtzEcUie+Z3KoUUKlgApYqjtNyyX/51yd9pc/UOLjIcK
         hej1uV1emdGGYFG5l21iPSkSiVOPTRGWnOCsMsjWYYVuDacDmqkzr35Bb4Lfuird1PCp
         USG1+oG64s8bR6UOHuxYwiJaJQBvUODlSJi+cmIkfpAygnHxhYeEfsBb2COzHCVH/O3h
         /aEu0wTZKiFFlBIqOWZS98UF4baUwPhWI38g6BtUUh1+uH/5GUkR6CL+c1McgBNtZj9E
         Z5FhHfP8Gs+bFwBFNlzziN1F78+Is/EHr8bS35gWFn46NzSyFXfp+c7p83RD45r/FJnf
         oGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y/B8+Wt8t65HyAHFIvqCHVw/CPSbL5JP5E6zK3iaABQ=;
        b=fghDiE3usgPEG1N9M/PIxJiqnpxsED8VbyPcDS05K4VFHkCmdo9h8IFv0a42iHdP9Q
         IBi7WBzx1JITh9Q05ymLXTYsJsys3RNdZgJROZ6nt3mUKUYViXi6AS1RIjrYZqq7O6d9
         ejjvL6d4n9u7sbn5wrXjKcYT92FOta/lCRzl76BGPkutg+XdQxsWVo8wwSCON12sUA6p
         0PQS21Fp2zgmokfK7DKepDiaAECZZNWLjciFv1FtHgNi7wmY5Sm/iw62c58+M2EhIxXO
         guph0UiFpWC1CH8H9GsUI6IDK/DPjaBgbN+kimt+GHsvn/z+unA3Y0uaz/SrRQlJdNJl
         YJKg==
X-Gm-Message-State: AOAM5303VQe6QzwKCfPgs8hTry5IINyrD5zzNucOCYp7CuWi4rj5VMeD
        bynU+yYzpKNbmUYkasQ9rA4=
X-Google-Smtp-Source: ABdhPJxC4Ue/7La+Ph2+EqjG4x2knGuQ7LL1+gFoJ+jfuTZGL3POZpxRQSk77anQqyHqi4QWMaYbmw==
X-Received: by 2002:a19:e93:: with SMTP id 141mr4959112lfo.107.1592669892976;
        Sat, 20 Jun 2020 09:18:12 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id u8sm2158588lff.38.2020.06.20.09.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 09:18:11 -0700 (PDT)
Subject: Re: [PATCH v8 7/7] drm/panel-simple: Add missing connector type for
 some panels
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20200617222703.17080-1-digetx@gmail.com>
 <20200617222703.17080-8-digetx@gmail.com>
 <20200620112132.GB16901@ravnborg.org>
 <20200620114934.GB5829@pendragon.ideasonboard.com>
 <ea421084-a91c-bc03-5997-1723075b7cae@gmail.com>
 <20200620143114.GA22329@ravnborg.org>
 <e77a34c1-3e0b-7f30-25d0-a955ec8d8c86@gmail.com>
 <20200620153012.GA22743@ravnborg.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ce053d7d-7458-20a0-4e9e-77f7f99d364b@gmail.com>
Date:   Sat, 20 Jun 2020 19:18:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200620153012.GA22743@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.06.2020 18:30, Sam Ravnborg пишет:
> Hi Dmitry
> On Sat, Jun 20, 2020 at 06:05:37PM +0300, Dmitry Osipenko wrote:
>> 20.06.2020 17:31, Sam Ravnborg пишет:
>>> Hi Dmitry
>>>
>>>>
>>>> Oops! Good catch!
>>> Yep, thanks Laurent. Should have taken a better look before applying.
>>>
>>>> Indeed, I blindly set the LVDS type to all these
>>>> panels. Please revert this patch, I'll double check each panel and
>>>> prepare an updated version of this patch. Thank you very much for the
>>>> review!
>>>
>>> If you can prepare a fix within a few days then lets wait for that.
>>> I will do a better review next time.
>>
>> Hello Sam,
>>
>> I should be able to make it later today or tomorrow. Could you please
>> clarify what do you mean by the fix, do you what it to be as an
>> additional patch on top of the applied one or a new version of the patch?
> An additional patch on top of the one applied.
> It shall carry a proper fixes: tag like this:
> 
> Fixes: 94f07917ebe8 ("drm/panel-simple: Add missing connector type for some panels")
> Cc: Dmitry Osipenko <digetx@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: dri-devel@lists.freedesktop.org

Okay!
