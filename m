Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A477EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 01:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81DA0206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 01:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kxMyTpnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgGJBis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 21:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgGJBis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 21:38:48 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A409EC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 18:38:47 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id x205so2136554vsc.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 18:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rwZ3DYshMM6TxgS7HlmiJMG3O0eqLFDjVA0qiqONL9c=;
        b=kxMyTpnOoVqLAx06Eq/BG8dsTt2HetQM+osslhZwLZLc6qwsmlW+bGHiIJ4xrH96dS
         b8Z4AmXJ6eAlGURzDiRvOaW6caIuXF3dnOU9Me9Ji2G9SrPTWdoTpsd8DSYGzmMWDoCP
         9QKK+ffBMstJ7DjkzVsc4yRl/QNqfbFX9q+ZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwZ3DYshMM6TxgS7HlmiJMG3O0eqLFDjVA0qiqONL9c=;
        b=hAgtGDC1MI+iyZYJ3BUBviJPMHWj1JHpCtJJZTOHa7KLI+5V9cRATuLksKWY1BFFI+
         7NQw65J7SFk4aqjv+6JlWX23XoEPG6UOHN904yE2WvnXC7vEvWxN1GXvxqtOlKjbSCqw
         wUbM1WN46UXcjlC7RvqpWTocUHFCAZQDneXG/VwjZ2z5kpXKJG3BTR2UlO9KaKRyY6C2
         iEgOw+36gpb38TSgRPkSRNAtmATAU0a9iablVtf7PmsJxOJb6qycHN4tv5DcaZmpYHdX
         U0cRp0Y9QbZjhsth4RCZ2MSRxVbvKjr5sg+3KYCu+AKiAVW5nA4L9/sV3Ub8essL62dM
         s/1w==
X-Gm-Message-State: AOAM530+olIjt6p7E+gpGQ87wLdkIUIouQSxHFhRuK5iLWtMj0PGPXG2
        2g4ngJ+GQEvLl5vlxN6D0KYznLd+9GA=
X-Google-Smtp-Source: ABdhPJzqYJy4hEqyZ94R9HFmrrt1Qc0JlflY8S9xPwAkNsJhBVJNEM15BmnEstgHpJjC+xINf4hsag==
X-Received: by 2002:a67:1105:: with SMTP id 5mr36484452vsr.174.1594345126195;
        Thu, 09 Jul 2020 18:38:46 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id t2sm667811vka.28.2020.07.09.18.38.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 18:38:44 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id b77so2145496vsd.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 18:38:43 -0700 (PDT)
X-Received: by 2002:a67:e046:: with SMTP id n6mr20302730vsl.6.1594345122863;
 Thu, 09 Jul 2020 18:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191218143416.v3.6.Iaf8d698f4e5253d658ae283d2fd07268076a7c27@changeid>
 <20200710011935.GA7056@gentoo.org>
In-Reply-To: <20200710011935.GA7056@gentoo.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 9 Jul 2020 18:38:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X3oazamoKR1jHoXm-yCAp9208ahNd8y+NDPt1pU=5xRg@mail.gmail.com>
Message-ID: <CAD=FV=X3oazamoKR1jHoXm-yCAp9208ahNd8y+NDPt1pU=5xRg@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] drm/bridge: ti-sn65dsi86: Use 18-bit DP if we can
To:     steev@kali.org
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 9, 2020 at 6:19 PM Steev Klimaszewski <steev@gentoo.org> wrote:
>
> Hi Doug,
>
> I've been testing 5.8 and linux-next on the Lenovo Yoga C630, and with this patch applied, there is really bad banding on the display.
>
> I'm really bad at explaining it, but you can see the differences in the following:
>
> 24bit (pre-5.8) - https://dev.gentoo.org/~steev/files/image0.jpg
>
> 18bit (5.8/linux-next) - https://dev.gentoo.org/~steev/files/image1.jpg

Presumably this means that your panel is defined improperly?  If the
panel reports that it's a 6 bits per pixel panel but it's actually an
8 bits per pixel panel then you'll run into this problem.

I would have to assume you have a bunch of out of tree patches to
support your hardware since I don't see any device trees in linuxnext
(other than cheza) that use this bridge chip.  Otherwise I could try
to check and confirm that was the problem.

-Doug
