Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86811C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39FFA20674
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b="N1V7lGaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgGJRLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgGJRLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:11:01 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C51C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:11:01 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id y9so1128633oot.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=myKrcYnB9ONGWrZiACvGtAE7VPtZF9mIixa8UnGi6lk=;
        b=N1V7lGaZGWwxiYdD9wOB2b2qeBTGFS7LeCUeOyQDGr77E2QdU1l+pzpFOJsZd7MdbH
         5BZLjBKlMuIpW5aXi2HxkFOY0DXugOgAVEeeRcYv2yL5xtXDHZiZ8suu7RS5pHoNAmYq
         X0EnB73RKYgutPIphvQ258SDBj6jxQPjVupknICdnY9TA0ycqtw92/IFT/tPp9CH3HaJ
         9vIgkz7Vfr8kMd09mIW3tqmlktPNU9aI36bFTh9AyHRb/1MRx6H1xRU9XQ4ZQ7/mBdfR
         KE2rWibNWlq6TEir7pyE6lDz0H8nhkgSuuBm6gtk7gxaBX7D8hd5mrfbBSECypCdxk2V
         4NOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=myKrcYnB9ONGWrZiACvGtAE7VPtZF9mIixa8UnGi6lk=;
        b=sjmLNl0qThku43n2Ke/vTAVQNAdHrF6ZsMHWyQLhpKXnRtpObPbqg15b99bxBjLW6Z
         g9Li8d1duJPwEOktj0vsyPLUYJmQCBdTgXWtZks/pP0DQp88UDcvcwnbwey9QVhT0m7U
         X+O0BcxshFuABqH2sI8i1sqob1grTK/uU/GDU+ygujY4Eir48Po9nWgMGNmB0l5lrmmw
         T+aeZWuofg699tLkx1nCUIvmo32YKxd9Ftij7CBpcTJJlFFFJMjMr5+fRrqEfU11uAzC
         9Lg9rEcZvUbs4N+PB3zpnIjsjZVWj0gklG48wh4j77gtmLKe5SD826hsR+YuzIOcOEyB
         ZXwg==
X-Gm-Message-State: AOAM531pnzbR3FlUEbQNnrJ5x1G5T5caVxaq5yICEJCbWHbalst2ANPV
        UewZ54uZ5Xvq+FQSs0B5Sk39Kg==
X-Google-Smtp-Source: ABdhPJyjAlrVf6Bdz3VCvEYqB3qfK0eEiCjavF7ooSGh3jbEZrY6tG1/lygDevSV4tm2BlzLIZYJMQ==
X-Received: by 2002:a4a:e381:: with SMTP id l1mr57870309oov.55.1594401060152;
        Fri, 10 Jul 2020 10:11:00 -0700 (PDT)
Received: from Steevs-MBP.hackershack.net (cpe-173-175-113-3.satx.res.rr.com. [173.175.113.3])
        by smtp.gmail.com with ESMTPSA id j97sm1184834otj.31.2020.07.10.10.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 10:10:59 -0700 (PDT)
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
 <dc786abb-4bc2-2416-7ee5-de408aceb8f1@kali.org>
 <e0702671-3bed-9e3d-c7f4-d050c617eb65@kali.org>
 <bc795659-7dd6-c667-1c93-4331510ecfbc@kali.org>
 <CAD=FV=VC+RP8WfS-yuc65WRN2KokNbAs-F3UdQtQoZjcMMSNFA@mail.gmail.com>
 <f81f0d22-85d6-66eb-c8d9-345757f53959@kali.org>
 <CAD=FV=WB_4xLe9UZX3eVemybQ1neXJVZgzrDCW-xUxbAM6hCTA@mail.gmail.com>
From:   Steev Klimaszewski <steev@kali.org>
Message-ID: <8e306b6d-246d-aa7f-cb24-923e13afcd04@kali.org>
Date:   Fri, 10 Jul 2020 12:10:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=WB_4xLe9UZX3eVemybQ1neXJVZgzrDCW-xUxbAM6hCTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/10/20 9:47 AM, Doug Anderson wrote:
> Hi,
>
>
> But should I continue on this path,
> It's probably worth getting dithering working on your sdm845 anyway in
> case anyone actually does put a 6bpp panel on this SoC.
>
>
>> or should we be finding others who
>> have an N61 and see what their EDID reports?
> I have an email out to BOE, but it might take a little while to get a
> response.  I'll see what they say.  If they say that the panel
> actually supports 8bpp then it's a no-brainer and we should just
> switch to 8bpp and be done.
>
> ...but if they say it's a 6bpp panel that has its own dither logic
> then it gets more complicated.  Initially one would think there should
> be very little downside in defining the panel as an 8bpp panel and
> calling it done.  ...except that it conflicts with some other work
> that I have in progress.  :-P  Specifically if you treat the panel as
> 6bpp and then reduce the blanking a tiny bit you can actually save 75
> mW of total system power on my board (probably similar on your board
> since you have the same bridge chip).  You can see a patch to do that
> here:
>
> https://crrev.com/c/2276384
>
> ...so I'm hoping to get some clarity from BOE both on the true bits
> per pixel and whether my proposed timings are valid before moving
> forward.  Is that OK?
>
>
> -Doug


It's fine by me - testing Rob's suggestion of changing
MAX_HDISPLAY_SPLIT 1080->1920 along with the change to adding IS_SDM845
does give me a full screen that looks nicer, I'm fine with using the
hack locally until a proper solution is found.  And I'm always a fan of
using less power on a laptop.


I'll give the patch a spin here if you want as well.


Hopefully BOE gets back to you soon, and there's no rush, I'm just an
end user who is extremely appreciative of all the work everyone on the
list and the kernel in general put in to make my machines usable.

