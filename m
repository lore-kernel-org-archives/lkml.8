Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D44C54E49
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 22:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1C31208DB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 22:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tkqv2f5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgEIWuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 18:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgEIWuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 18:50:00 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F967C05BD09
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 15:49:59 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id j127so1394227vke.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 15:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TXUBBXmljQ5wXNIAowkwYkd4kb/4nsVYm0GYUwUuYac=;
        b=Tkqv2f5gzC+XAAIPgdH4R2bngWQK+egYnu5AfQSyhmjrOFiaTRmfAv7lxgLnmQRtYh
         NBnfLaEJwQKjW3zaO8N1Ey2h0IUcGByzxK0QPSE9/2kqI0YP0aHCLIuvqeL3qlQkJmgq
         GdgmD/Eytja1TI6YPeB/tQ7b4pxyojrn+yLps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TXUBBXmljQ5wXNIAowkwYkd4kb/4nsVYm0GYUwUuYac=;
        b=b5Mm9R+ogLVJps1BD8RCHiKpzSOXS/oc3u5TdmAcgv+EHDyhHSKlOLJhZuYLa1zf0Y
         70KcmwdGpsfw/ZdhsO0KzX+ki+9KRTbb7ickNCMJPGNvQJus0PiNkXC0843PLqN+qrW7
         u1qq+F8aViv2diDTDTTncmJgAIUrFYuBZ6iS4svQzuz8NUps46IxtzWATy6q+R5vLHkS
         sNvPMiy3Ov84nG2CrYbLVJVPb8ZpuYX80j64Ano7yrqoAa3/pzglCVoqYQ+QbNFM/mHG
         8QNqo3oJxoWcP01r4E/O5k73WAA9ehSHLM6+38rnjElIL0vPUieQnH78uaBM7C3Uztv9
         1KQg==
X-Gm-Message-State: AOAM533jO1WoIA4aWg2LrhdNqkr8dmxpzq750nSfMaEjgVbkeCJ3l/wR
        ZE4VFwA/Hz73jocvrCZ3/4nrAGCQy5A=
X-Google-Smtp-Source: ABdhPJxFp42baQ8hCVlJIp0XUXRsAlE0ZjKt7TsNJ6oMh62wTWXxfW4yThhb8v8ERjPt2O9Zykpqqw==
X-Received: by 2002:a1f:2655:: with SMTP id m82mr2832983vkm.52.1589064598408;
        Sat, 09 May 2020 15:49:58 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id g78sm5295540vkf.53.2020.05.09.15.49.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 15:49:57 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id g15so688094uah.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 15:49:57 -0700 (PDT)
X-Received: by 2002:ab0:45c7:: with SMTP id u65mr7022602uau.8.1589064596879;
 Sat, 09 May 2020 15:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200508155859.1.I4d29651c0837b4095fb4951253f44036a371732f@changeid>
 <20200509200021.GA30802@ravnborg.org>
In-Reply-To: <20200509200021.GA30802@ravnborg.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sat, 9 May 2020 15:49:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W+sAfu-A0ScE+hzNOd=jxnf+YZgwygPoR-gFqm0b++5A@mail.gmail.com>
Message-ID: <CAD=FV=W+sAfu-A0ScE+hzNOd=jxnf+YZgwygPoR-gFqm0b++5A@mail.gmail.com>
Subject: Re: [PATCH 1/3] panel: simple: Fix size and bpp of BOE NV133FHM-N61
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, May 9, 2020 at 1:00 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Douglas
>
> On Fri, May 08, 2020 at 03:59:00PM -0700, Douglas Anderson wrote:
> > The BOE NV133FHM-N61 is documented in the original commit to be a
> > 13.3" panel, but the size listed in our struct doesn't match.
> > Specifically:
> >
> >   math.sqrt(30.0 * 30.0 + 18.7 * 18.7) / 2.54 ==> 13.92
> >
> > Searching around on the Internet shows that the size that was in the
> > structure was the "Outline Size", not the "Display Area".  Let's fix
> > it.
> >
> > Also the Internet says that this panel supports 262K colors.  That's
> > 6bpp, not 8bpp.
> >
> > Fixes: b0c664cc80e8 ("panel: simple: Add BOE NV133FHM-N61")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Added to drm-misc-next as I did not think this had to be updated in
> mainline right now. Let me know if you expect it to land in mainline
> soonish.

drm-misc-next is perfect, thanks!

-Doug
