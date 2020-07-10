Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67761C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4104F2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b="jSuGNfD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGJDMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 23:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgGJDMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 23:12:33 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB42C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 20:12:31 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id w17so3663925oie.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 20:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DnmHgWcom46+tP3PEnGuwAzr3b6gjMlwO5pxp3gapqY=;
        b=jSuGNfD45Izh3sRrOP0RiWYQ8FBRprrDa+5SeAyoMFHrIih0JrEYrIao53SPdJr1PQ
         3GJa5ghDh4Un0ZKpxmYVcpXrUhCd5S5Y+LGbTNJctLtOSD2HltDVx6fPF7AS987Gd6RQ
         7cVeLIO+rsqy7eipSmU+dT03/wVdJMCOuXgJl/4nwwnp17bNmM/XbtwipbD6iUPfvdY+
         g6muq6gAcDM4YTEJ22dAqJu4yWccecvcxZ2zk3DWjsq0aJ2RrkrePo1/ZozS9IviBZ2j
         /94+3ONa1eYD16bqCz5+ASzu/pzGSuq3Z6nii/bXBO1t97JjlMztquEzxvM+q3ONhlmG
         eqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DnmHgWcom46+tP3PEnGuwAzr3b6gjMlwO5pxp3gapqY=;
        b=SiMKstXcuNgBW8T7tty9kdT0BC9Ag9QD3SMMVxFzKEHQbv9ysE/qgnmrB2k7qDsu1p
         vdg1gl/8W+JKoxd+MOp6HoLQ+iOdzsbsFpvpn2ZDJrD7mGcRgBSd3V2xqlvPmy/rq8bF
         HQzyFB3lcMEeuLbm8b3KkOq5+ixZCmegGolvHA8ifgx+Q0dh1mp+9L2eVgi+ywERJ9k2
         K9BzvDJHCAgz9NDk4OI7SSxcHgPGixQcppgAQzw6sOC3KknF3Brc6HPxXXc0inmHboi2
         BUEoxUzME5PLJvnt6u9CFXOKQNJCbkKzxif+jRd6/8tx6Yio5XlBw8JvcD2j8thJZ2Ls
         QIsQ==
X-Gm-Message-State: AOAM532wvRtzgThLtuktZCAMKQCVHPa3pg+QPNJXeJfi/u3vT4XHHLhO
        NJIJDSgsb+S9Vmec7ZgIg1me/Q==
X-Google-Smtp-Source: ABdhPJx2h1UeNaDOf3+qpVJW4onLPxgHKnYXVtTrb928wLj3IWfsG8Vr0loQvc2MTwx+pNOmAX9GqA==
X-Received: by 2002:aca:57c5:: with SMTP id l188mr2721479oib.154.1594350751200;
        Thu, 09 Jul 2020 20:12:31 -0700 (PDT)
Received: from [192.168.11.9] (cpe-173-175-113-3.satx.res.rr.com. [173.175.113.3])
        by smtp.gmail.com with ESMTPSA id s4sm946821oom.15.2020.07.09.20.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 20:12:30 -0700 (PDT)
Subject: Re: [PATCH v3 6/9] drm/bridge: ti-sn65dsi86: Use 18-bit DP if we can
To:     Doug Anderson <dianders@chromium.org>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Steev Klimaszewski <steev@gentoo.org>
References: <20191218143416.v3.6.Iaf8d698f4e5253d658ae283d2fd07268076a7c27@changeid>
 <20200710011935.GA7056@gentoo.org>
 <CAD=FV=X3oazamoKR1jHoXm-yCAp9208ahNd8y+NDPt1pU=5xRg@mail.gmail.com>
 <CAD=FV=UWQsGit6XMCzHn5cBRAC9nAaGReDyMzMM2Su02bfiPyQ@mail.gmail.com>
From:   Steev Klimaszewski <steev@kali.org>
Message-ID: <dc786abb-4bc2-2416-7ee5-de408aceb8f1@kali.org>
Date:   Thu, 9 Jul 2020 22:12:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=UWQsGit6XMCzHn5cBRAC9nAaGReDyMzMM2Su02bfiPyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/9/20 9:14 PM, Doug Anderson wrote:
> Hi,
>
> On Thu, Jul 9, 2020 at 6:38 PM Doug Anderson <dianders@chromium.org> wrote:
>> Hi,
>>
>> On Thu, Jul 9, 2020 at 6:19 PM Steev Klimaszewski <steev@gentoo.org> wrote:
>>> Hi Doug,
>>>
>>> I've been testing 5.8 and linux-next on the Lenovo Yoga C630, and with this patch applied, there is really bad banding on the display.
>>>
>>> I'm really bad at explaining it, but you can see the differences in the following:
>>>
>>> 24bit (pre-5.8) - https://dev.gentoo.org/~steev/files/image0.jpg
>>>
>>> 18bit (5.8/linux-next) - https://dev.gentoo.org/~steev/files/image1.jpg
>> Presumably this means that your panel is defined improperly?  If the
>> panel reports that it's a 6 bits per pixel panel but it's actually an
>> 8 bits per pixel panel then you'll run into this problem.
>>
>> I would have to assume you have a bunch of out of tree patches to
>> support your hardware since I don't see any device trees in linuxnext
>> (other than cheza) that use this bridge chip.  Otherwise I could try
>> to check and confirm that was the problem.
> Ah, interesting.  Maybe you have the panel:
>
> boe,nv133fhm-n61
>
> As far as I can tell from the datasheet (I have the similar
> boe,nv133fhm-n62) this is a 6bpp panel.  ...but if you feed it 8bpp
> the banding goes away!  Maybe the panel itself knows how to dither???
> ...or maybe the datasheet / edid are wrong and this is actually an
> 8bpp panel.  Seems unlikely...
>
> In any case, one fix is to pick
> <https://lore.kernel.org/dri-devel/1593087419-903-1-git-send-email-kalyan_t@codeaurora.org/>,
> though right now that patch is only enabled for sc7180.  Maybe you
> could figure out how to apply it to your hardware?
>
> ...another fix would be to pretend that your panel is 8bpp even though
> it's actually 6bpp.  Ironically if anyone ever tried to configure BPP
> from the EDID they'd go back to 6bpp.  You can read the EDID of your
> panel with this:
>
> bus=$(i2cdetect -l | grep sn65 | sed 's/i2c-\([0-9]*\).*$/\1/')
> i2cdump ${bus} 0x50 i
>
> When I do that and then decode it on the "boe,nv133fhm-n62" panel, I find:
>
> 6 bits per primary color channel
>
> -Doug


Hi Doug,

Decoding it does show be to boe,nv133fhm-n61 - and yeah it does say it's 
6-bit according to panelook's specs for it.


I'll take a look at the patch and see what I can come up with... at the 
moment, I'm forcing it to be 8bit and that does "work fine" but I'd like 
it to be fixed properly instead of my hack.

Thanks for your time and work!

-- Steev

