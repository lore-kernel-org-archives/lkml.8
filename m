Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CD3C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 18:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F9520674
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 18:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jj8V+g5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgGYSsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 14:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgGYSsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 14:48:09 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07BAC08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 11:48:08 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b13so6907339edz.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 11:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=J+Mg8FrXjOOpUXGKNdsJwjOwj3SmjqQEXToX5OfPGgg=;
        b=Jj8V+g5CBjwKufxhqOSZQdk2PR87G5SB1sP1DxTgqrtzTDOs8t/xRSGVc+9lryMSOJ
         y4joCsPIsVUq/BwYFV66ROD1qHkeAkKgjdH+jfI+ggX0b2/rnlVIEvBxe37AdYJM22P3
         93Toaxn/Ubt21KRJyEjgg4y7MItquN/o/8v4Uph7novYd2edC3zum9nhW2cGg24VUtIy
         k6ZXZsZJkho8Hi8WasP+nD0R/DZNHS1odz0qs9BKi2btJ1oq6rnE0cdM23UK0T99lTZM
         zd1i3sr7/xb0npgogbHiP3CtKnembKl8P3E/DGbD1iKgc9UnoSkRLxWgxR+3qy5dwz6a
         DaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=J+Mg8FrXjOOpUXGKNdsJwjOwj3SmjqQEXToX5OfPGgg=;
        b=Zq7MNbjhdFtpeCz10efjEsGtieMlo/7+t3y4/+PXUMNX/3Leu5XzSxNyAPdMI7gWaN
         t6SrSDx2hxmaFWwFx+Vxz2b2pwzld2+8wpMHcj+ha4Fw4z271y/M1ipYv0RyMafq1hHT
         vI/aiYpWS9be6p/SpuTrvphxsBu4JWdtLw3rruKkekCUxufANb4+SHUANKff1Tpv5o3x
         5DGTmstyd3CsEzSpfsJewkuXyGNcUGZmplOlJ7Js6ujPu5XAKgs38xGala9WOgLNKLIu
         sL5Yxsl85gdVRHEXGoYRVRH5jFY9hOGQP/QBnGbXoqLz4bDCTnSbqeJY25cd2NJnvUb5
         qgpA==
X-Gm-Message-State: AOAM533ewAOwv/2uUWGtE/FcvlSIQ7DaStuWCotGsIZE5hPR7X6d0Ijh
        fNFd7O5YCT9igya3y+T+8yhpiuWN8w==
X-Google-Smtp-Source: ABdhPJy2GWv6Wb+FYd0PBNz124ebLOiMzSnYouKGt+VDudPTH3Gt0GRTzt2LTf9Q2y8OnTLrsPEzQQ==
X-Received: by 2002:a50:bf07:: with SMTP id f7mr6053745edk.356.1595702885977;
        Sat, 25 Jul 2020 11:48:05 -0700 (PDT)
Received: from [192.168.200.34] (ip5b436a54.dynamic.kabel-deutschland.de. [91.67.106.84])
        by smtp.gmail.com with ESMTPSA id i2sm3612187edk.30.2020.07.25.11.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2020 11:48:05 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] drm: rockchip: various ports for older VOPs
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200722181332.26995-1-knaerzche@gmail.com>
 <CAKMK7uGKyYea_9MamAQw2=ebjW=raYCDeFCf_5jyyJPHL9AZWA@mail.gmail.com>
 <47599ce1-2a3b-87eb-c46e-8f7f79ca945e@gmail.com>
 <CAKMK7uEn0552JuTuwpL-XdYSVk7OA=fEsphpivS8ouE-10--Zg@mail.gmail.com>
From:   Alex Bee <knaerzche@gmail.com>
Message-ID: <0e5f6e41-5fa4-2989-f4b8-89a9471db931@gmail.com>
Date:   Sat, 25 Jul 2020 20:48:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uEn0552JuTuwpL-XdYSVk7OA=fEsphpivS8ouE-10--Zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 25.07.20 um 17:54 schrieb Daniel Vetter:
> On Sat, Jul 25, 2020 at 3:52 PM Alex Bee <knaerzche@gmail.com> wrote:
>>
>> Am 22.07.20 um 23:43 schrieb Daniel Vetter:
>>> On Wed, Jul 22, 2020 at 8:13 PM Alex Bee <knaerzche@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> this series mainly ports existining functionality to older SoCs - most
>>>> importantly enables alpha blending for RK3036, RK3066, RK3126 and
>>>> RK3188.
>>>> Besides that, it also changes the window type from DRM_PLANE_TYPE_CURSOR
>>>> to DRM_PLANE_TYPE_OVERLAY for VOPs that have only one (1) overlay window.
>>> This doesn't make much sense, the cursor overlay is really just a hint
>>> for legacy ioctls that this is the overlay that should be used for
>>> cursors. Compositors should try to use such planes as full overlays
>>> (if they don't want to use them as a cursor). So sounds like a case of
>>> "fix your compositor".
>> I agree here - but: If HWC windows would have been implemented in this
>> particular driver, their max size would be 128x128 on some SoCs - so
>> they woudn't be really suitable to create an OSD overlay at 4K, for
>> example. I don't know, but I guess other vendors implement their HWC
>> windows on this reduced HW resources as well. I guess that is one of the
>> reasons, why userspace, which aims to be cross-plattfrom, avoids
>> DRM_PLANE_TYPE_CURSOR when its looking for an usable overlay plane. (a
>> heuristic, indeed)
> Which userspace does that?
kodi-gbm: 
https://github.com/xbmc/xbmc/blob/master/xbmc/windowing/gbm/DRMUtils.cpp#L406 

> We should fix that, not try to work around
> that in all the drivers in upstream, that wont work.
You're right I'll drop this part.
> -Daniel
>
>>> For atomic there's 0 difference between a overlay or a cursor (primary
>>> plane is still treated somewhat special in the RMFB ioctl, but again
>>> that's for backwards compat reasons with existing uapi, not because
>>> the primary plane is different).
>>>
>>> What does happen though is that this breaks cursor for legacy
>>> userspace, which is probably not really what you want.
>> Indeed not.
>>
>> Beforhand I was submiiting this, I looked arround and couldn't find
>> anything which relies or even depends of a cursor window to be
>> available. Even if: as per spec only one DRM_PLANE_TYPE_PRIMARY is
>> mandatory, everything else is optional.
>>
>>> -Daniel
>>>
>>>
>>>> Regards,
>>>> Alex
>>>>
>>>> Changes in v2:
>>>> - drop not yet upstreamed dsp_data_swap from RK3188 regs
>>>> - rephrase most commit messages
>>>>
>>>> Alex Bee (5):
>>>>     drm: rockchip: add scaling for RK3036 win1
>>>>     drm: rockchip: add missing registers for RK3188
>>>>     drm: rockchip: add alpha support for RK3036, RK3066, RK3126 and RK3188
>>>>     drm: rockchip: set alpha_en to 0 if it is not used
>>>>     drm: rockchip: use overlay windows as such
>>>>
>>>>    drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  1 +
>>>>    drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 42 ++++++++++++++++++---
>>>>    drivers/gpu/drm/rockchip/rockchip_vop_reg.h |  1 +
>>>>    3 files changed, 38 insertions(+), 6 deletions(-)
>>>>
>>>> --
>>>> 2.17.1
>>>>
>>> --
>>> Daniel Vetter
>>> Software Engineer, Intel Corporation
>>> http://blog.ffwll.ch
>> Best Regards
>>
>
Best regards
