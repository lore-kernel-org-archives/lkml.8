Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AAAC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6096021569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B/RnOoig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgBLXEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:04:47 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:36468 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgBLXEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:04:46 -0500
Received: by mail-vk1-f194.google.com with SMTP id i4so1045942vkc.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 15:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rZc6YtKm0NgqfqELl0Ged7y550Im2QjkLBOstVaWr/E=;
        b=B/RnOoigo7Do72Ok+CIzPjCgyPH4qvuU85m2AGDbWVIlI2aVD4kshxqVkcOHxItPAP
         lhsMokayGGzLw6FPwokLCGD22QDsalq8UCou/e6YKFTLfhT74HnB6cCK3tKn8UojpvHb
         7jh2/BPTkwQWMPDnpUknof63iws9HXf5zTXJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rZc6YtKm0NgqfqELl0Ged7y550Im2QjkLBOstVaWr/E=;
        b=ZyaGYbB2FOoxqV3rxMSd8pwDTiFffNYJABXiPe7i1Pk10RrxiY7ygK1g1AVINAU5D7
         6/E8DSKrrhzdJJ7czYxgrDxvaOkDE0NvzH9d7gP4ktZtOlBSXHN6AMDh7MvF0LoNvW0r
         qomY4XJLw2JRn0YNxZUekTPBg2pYP962K2DGTrP5dmnDF3E0nmiLZ4fMa2kTZrLeUy+3
         iEDgPVwjkzxOwCH8YEg7l1DtHf3h9+KGufWR29qC1D3bXmZRJAt2gMp74apj6IdQfS16
         qN7Qd7h9QaXBic+NMJuaDNQi41LEqpco9Ndw/E5QtGZz3inl6DLFv8sxOJBYvErK89DT
         PRTg==
X-Gm-Message-State: APjAAAWelw9e3OqqWD5ZZIJpZM2ESuDMZIQyO1/9OFxh4/l/Dt9R214t
        71exVZ/1e3BGATWlcSJbgaWFSvtKdAw=
X-Google-Smtp-Source: APXvYqyCry66Pbua08pxkFj4xwCRq989creUidKTY2maSuSwMaz8OfE8DP9wGnuH4lf1A2BIrSEA7w==
X-Received: by 2002:a1f:6344:: with SMTP id x65mr573144vkb.26.1581548684058;
        Wed, 12 Feb 2020 15:04:44 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id 42sm230931uac.16.2020.02.12.15.04.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 15:04:43 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id o187so1046611vka.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 15:04:42 -0800 (PST)
X-Received: by 2002:a1f:a9d0:: with SMTP id s199mr582450vke.40.1581548682205;
 Wed, 12 Feb 2020 15:04:42 -0800 (PST)
MIME-Version: 1.0
References: <20191218223530.253106-1-dianders@chromium.org>
 <20191218143416.v3.6.Iaf8d698f4e5253d658ae283d2fd07268076a7c27@changeid>
 <20200203233711.GF311651@builder> <CAD=FV=VTKfv93BiNRYBxWg8o8YKrQy3Z85MzR8XFr=GCS5xhdg@mail.gmail.com>
In-Reply-To: <CAD=FV=VTKfv93BiNRYBxWg8o8YKrQy3Z85MzR8XFr=GCS5xhdg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 12 Feb 2020 15:04:30 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XPscj+bDBjxqBSudj77WeAjCvmOYcOu27jk4gqiCcWcA@mail.gmail.com>
Message-ID: <CAD=FV=XPscj+bDBjxqBSudj77WeAjCvmOYcOu27jk4gqiCcWcA@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] drm/bridge: ti-sn65dsi86: Use 18-bit DP if we can
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Rob Clark <robdclark@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrzej / Neil,

On Mon, Feb 3, 2020 at 4:21 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Andrzej / Neil,
>
> On Mon, Feb 3, 2020 at 3:37 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Wed 18 Dec 14:35 PST 2019, Douglas Anderson wrote:
> >
> > > The current bridge driver always forced us to use 24 bits per pixel
> > > over the DP link.  This is a waste if you are hooked up to a panel
> > > that only supports 6 bits per color or fewer, since in that case you
> > > ran run at 18 bits per pixel and thus end up at a lower DP clock rate.
> >
> > s/ran/can/
>
> I'm going to make the assumption that you can fix this typo when
> applying the patch and I'm not planning to send a v4.  If that's not a
> good assumption then please yell.

With -rc1 released, it seems like it might be a nice time to land this
series.  Do you happen to know if there is anything outstanding?  Is
one of you two the right person to land this series, or should I be
asking someone else?  I can see if I can find someone to take them
through drm-misc if there's nobody else?

It's not massively crazy urgent or anything, but the patches have been
floating for quite some time now and it'd be nice to know what the
plan was.  I also have another patch I'd like to post up but was
hoping to get this series resolved first.

Thanks much!

-Doug
